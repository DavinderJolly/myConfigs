if !exists('g:lspconfig')
  finish
endif

lua << EOF

require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')


local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>di', '<cmd>lua vim.lsp.buf.<CR>', opts)

end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.clojure_lsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "clojure", "edn" }
  }


nvim_lsp.eslint.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
    }
  }

nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
    }
  }

nvim_lsp.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "python" },
  }


nvim_lsp.omnisharp.setup {
    cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },
    capabilities = capabilities,
    on_attach = on_attach,

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
}

nvim_lsp.sourcery.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "python" },
  init_options = {
    token = "<token>",
    }
  }

nvim_lsp.jdtls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "java" },
  }


nvim_lsp.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
      },
    provideFormatter = true
    },
  }

nvim_lsp.emmet_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "css", "scss" },
  }

nvim_lsp.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "css", "scss", "less" }
  }

nvim_lsp.tailwindcss.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  }

nvim_lsp.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
  }

nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "rust" }
  }

nvim_lsp.vimls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "vim", "nvim" }
  }

nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "go", "gomod" }
  }

nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "lua" }
  }

nvim_lsp.dockerls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "dockerfile" }
  }

nvim_lsp.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "yaml", "yaml.docker-compose" }
  }

if vim.fn.has('unix') == 1 then
  nvim_lsp.bashls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "sh", "zsh" }
    }
end

EOF
