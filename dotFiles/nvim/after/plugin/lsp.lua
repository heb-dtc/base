local lsp = require("lsp-zero")

lsp.set_sign_icons({
	error = "✘",
	warn = "▲",
	hint = "⚑",
	info = "»",
})

-- enable logging
-- vim.lsp.set_log_level("trace")

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "eslint" },
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			local lua_opts = lsp.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
		clangd = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.offsetEncoding = { "utf-16" }
			require("lspconfig").clangd.setup({
				capabilities = capabilities,
			})
		end,
	},
})

-- (Optional) Configure lua language server for neovim
-- lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_action = lsp.cmp_action()

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = lsp.cmp_format(),
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, opts)

	vim.keymap.set("n", "go", function()
		vim.lsp.buf.implementation()
	end, opts)

	vim.keymap.set("n", "gs", function()
		vim.lsp.buf.signature_help()
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

	vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
	--vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	vim.keymap.set("n", "<leader>T", "<cmd>Telescope lsp_type_definitions<CR>", opts)

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

	vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
