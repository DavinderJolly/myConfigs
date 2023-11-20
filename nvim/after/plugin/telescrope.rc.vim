nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope tags<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>ftr <cmd>Telescope treesitter<cr>
nnoremap <leader>fp <cmd>Telescope registers<cr>
nnoremap <leader>fs <cmd>Telescope luasnip<cr>

lua <<EOF

local telescope = require('telescope')
telescope.load_extension('luasnip')

EOF
