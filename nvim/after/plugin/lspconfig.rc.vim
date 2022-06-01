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

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", }
  }

nvim_lsp.pyright.setup {
  on_attach = on_attach,
  filetypes = { "python" },
  }

nvim_lsp.jdtls.setup {
  on_attach = on_attach,
  filetypes = { "java" },
  }

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  filetypes = { "css" },
  }

nvim_lsp.clangd.setup {
  on_attach = on_attach,
  filetypes = { "c", "cpp", "c++", "cc" }
  }

nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  filetypes = { "rust", "rs" }
  }


nvim_lsp.vimls.setup {
  on_attach = on_attach,
  filetypes = { "vim", "nvim" }
  }


nvim_lsp.gopls.setup {
  on_attach = on_attach,
  filetypes = { "go", "gomod" }
  }

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  filetypes = { "lua" }
  }

EOF
