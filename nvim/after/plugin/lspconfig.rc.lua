require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"clojure_lsp",
		"html",
		"vimls",
		"eslint",
		"tsserver",
		"pyright",
		"emmet_ls",
		"jdtls",
		"cssls",
		"tailwindcss",
		"clangd",
		"yamlls",
		"gopls",
		"bashls",
		"intelephense",
	},
})

local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.clojure_lsp.setup({
	capabilities = capabilities,
	filetypes = { "clojure", "edn" },
})

nvim_lsp.eslint.setup({
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
})

nvim_lsp.tsserver.setup({
	capabilities = capabilities,
	filetypes = {
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"javascript",
		"javascriptreact",
		"javascript.jsx",
	},
})

nvim_lsp.pyright.setup({
	capabilities = capabilities,
	filetypes = { "python" },
})

nvim_lsp.jdtls.setup({
	capabilities = capabilities,
	filetypes = { "java" },
})

nvim_lsp.html.setup({
	capabilities = capabilities,
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
})

nvim_lsp.emmet_ls.setup({
	capabilities = capabilities,
	filetypes = { "html", "css", "scss", "php" },
})

nvim_lsp.cssls.setup({
	capabilities = capabilities,
	filetypes = { "css", "scss", "less" },
})

nvim_lsp.tailwindcss.setup({
	capabilities = capabilities,
})

nvim_lsp.clangd.setup({
	capabilities = capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

nvim_lsp.rust_analyzer.setup({
	capabilities = capabilities,
	filetypes = { "rust" },
	root_dir = util.root_pattern("Cargo.toml"),
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

nvim_lsp.vimls.setup({
	capabilities = capabilities,
	filetypes = { "vim", "nvim" },
})

nvim_lsp.gopls.setup({
	capabilities = capabilities,
	filetypes = { "go", "gomod" },
})

nvim_lsp.dockerls.setup({
	capabilities = capabilities,
	filetypes = { "dockerfile" },
})

nvim_lsp.yamlls.setup({
	capabilities = capabilities,
	filetypes = { "yaml", "yaml.docker-compose" },
})

nvim_lsp.powershell_es.setup({
	capabilities = capabilities,
	filetypes = { "ps1" },
})

nvim_lsp.intelephense.setup({
	capabilities = capabilities,
	filetypes = { "php" },
})

nvim_lsp.lua_ls.setup({
	on_init = function(client)
		-- patch to fix client.workspace_folders being nul crashing function
		local path
		if client.workspace_folders then
			path = client.workspace_folders[1].name
		else
			path = ""
		end

		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					hint = { enable = true },
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				},
			})
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
	capabilities = capabilities,
	filetypes = { "lua" },
})

if vim.fn.has("unix") == 1 then
	nvim_lsp.bashls.setup({
		capabilities = capabilities,
		filetypes = { "sh", "zsh" },
	})
end
