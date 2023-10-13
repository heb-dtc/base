local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
		},
	},
})

vim.keymap.set("n", "<C-p>", function()
	if vim.fn.isdirectory(".git") ~= 0 then
		builtin.git_files()
		return
	else
		builtin.find_files()
		return
	end
end)

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ps', function ()
    builtin.grep_string({ search = vim.fn.input("Grep > ")});
end)

-- vim.keymap.set("n", "<leader>f", function()
--	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
