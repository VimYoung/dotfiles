local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

	if not (vim.uv or vim.loop).fs_stat(pckr_path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/lewis6991/pckr.nvim",
			pckr_path,
		})
	end
	vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

-- Important setup imports
require("config.options")
require("config.keymaps")
-- require("config.lsp.config")
-- require("config.lsp.cmp")

local colorscheme_list = require("plugins.colorschemes.list")
local plugins = {
	{ "marko-cerovac/material.nvim", config = "plugins.colorschemes.material" },
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = "plugins.lualine",
	},
	{ "RRethy/vim-illuminate", config = "plugins.illuminate" },
	"sitiom/nvim-numbertoggle",
	"lewis6991/gitsigns.nvim",
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup(require("plugins.scrollbar"))
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	{
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = "plugins.telescope",
	},
	{
		"jiaoshijie/undotree",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("undotree").setup()
			vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
		end,
	},
	{
		"kelly-lin/ranger.nvim",
		config = function()
			require("ranger-nvim").setup({ replace_netrw = true })
			vim.api.nvim_set_keymap("n", "<leader>p", "", {
				noremap = true,
				callback = function()
					require("ranger-nvim").open(true)
				end,
			})
		end,
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = function()
			require("colorful-winsep").setup()
		end,
	},
	{ "zaldih/themery.nvim", config = "plugins.themery" },
	"nyoom-engineering/oxocarbon.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = "plugins.neotree",
	},
	-- Have to set it up.
	{
		"startup-nvim/startup.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = "plugins.startup",
	},
	-- Have to set it up.
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = "config",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
				},
				snippet = {
					expand = function(args)
						-- You need Neovim v0.10 to use vim.snippet
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({}),
			})
		end,
	},
}


require("pckr").add(table.move(colorscheme_list, 1, #colorscheme_list, #plugins + 1, plugins))
vim.cmd("colorscheme material") --enabling the theme.
