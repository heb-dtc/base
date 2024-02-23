local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	b.formatting.stylua,
	b.diagnostics.luacheck.with({
		extra_args = { "--globals", "vim", "describe" },
	}),
	b.formatting.prettier,
	b.diagnostics.eslint_d,
	-- b.formatting.eslint_d,
	b.code_actions.eslint_d,
	b.completion.spell,
	b.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci" } }),
	b.diagnostics.shellcheck,
	b.diagnostics.vint,
	b.diagnostics.yamllint,
	b.formatting.gofumpt,
	b.formatting.clang_format,
	b.diagnostics.cppcheck,
}

null_ls.setup({
	on_attach = function(_, bufnr)
		print("null-ls attached", bufnr)
	end,
	sources = sources,
	diagnostics_format = "[#{c}] #{m} (#{s})",
	debug = true,
})
