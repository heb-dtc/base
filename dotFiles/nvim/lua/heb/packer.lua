vim.cmd([[packadd packer.nvim]])

local packer = require("packer")

packer.init({
	log = { level = "error" },
})

return packer.startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.4",
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		use({
			"EdenEast/nightfox.nvim",
			as = "nightfox",
			config = function()
				vim.cmd("colorscheme duskfox")
			end,
		})

		use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
				-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			},
		})

		use("tpope/vim-fugitive")

		use("scrooloose/nerdtree")

		use({
			"VonHeikemen/lsp-zero.nvim",
			branch = "v3.x",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" }, -- Required
				{ "williamboman/mason.nvim" }, -- Optional
				{ "williamboman/mason-lspconfig.nvim" }, -- Optional

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" }, -- Required
				{ "hrsh7th/cmp-nvim-lsp" }, -- Required
				{ "hrsh7th/cmp-buffer" }, -- Optional
				{ "hrsh7th/cmp-path" }, -- Optional
				{ "saadparwaiz1/cmp_luasnip" }, -- Optional
				{ "hrsh7th/cmp-nvim-lua" }, -- Optional

				-- Snippets
				{ "L3MON4D3/LuaSnip" }, -- Required
				{ "rafamadriz/friendly-snippets" }, -- Optional
			},
		})

        use {'nvim-telescope/telescope-ui-select.nvim' }

		use({
			"https://github.com/davisdude/vim-love-docs",
			branch = "build",
		})

		use("nvimtools/none-ls.nvim")

		use({
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			config = function()
				require("toggleterm").setup()
			end,
		})

		use("mbbill/undotree")

		use("udalov/kotlin-vim")

		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons", opt = true },
		})

        use("github/copilot.vim")
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
