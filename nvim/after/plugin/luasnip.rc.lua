require("luasnip.loaders.from_vscode").load({
  paths = { vim.fn.stdpath("config") .. "/customSnippets/" },
})
