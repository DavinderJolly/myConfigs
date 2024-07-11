return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        prismals = {},
        svelte = {},
        cssls = {},
      })
    end,
  },
}
