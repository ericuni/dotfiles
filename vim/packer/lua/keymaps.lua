-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<c-e>', builtin.buffers, {})

-- youdao translator
vim.keymap.set('n', '<c-t>', ':<C-u>Ydc<CR>', {silent = true})
vim.keymap.set('v', '<c-t>', ':<C-u>Ydv<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>yd', ':<C-u>Yde<CR>', {})

