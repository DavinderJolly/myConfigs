nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ftr <cmd>Telescope treesitter<cr>
nnoremap <leader>fp <cmd>Telescope registers<cr>
nnoremap <leader>fs <cmd>Telescope luasnip<cr>

lua <<EOF

require('telescope').load_extension('luasnip')

EOF
