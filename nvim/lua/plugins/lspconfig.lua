return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        lua_ls = {},
        rust_analyzer = {
          root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
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
        },
        clojure_lsp = {},
        html = {
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
          },
        },
        vimls = {},
        eslint = {},
        tsserver = {},
        emmet_ls = {},
        jdtls = {},
        cssls = {},
        tailwindcss = {},
        clangd = {},
        yamlls = {},
        gopls = {},
        bashls = {},
        intelephense = {},
      },
    },
  },
}
