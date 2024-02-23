local lsp = require("lsp-zero").preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = true,
})

lsp.ensure_installed({
	"tsserver",
	"eslint",
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

local cmp = require("cmp")
--local cmp_format = lsp.cmp_format()
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	["<C-space>"] = cmp.complete(),
-- })

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},

	-- mapping = cmp.mapping.preset.insert({
	-- 	["<C-space>"] = cmp.complete(),
	-- }),

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>ws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>rr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
