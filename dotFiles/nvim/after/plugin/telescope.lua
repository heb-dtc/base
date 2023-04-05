local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function ()
    if vim.fn.isdirectory('.git') ~= 0 then
        builtin.git_files()
        return
    else
        builtin.find_files()
        return
    end
end)
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
