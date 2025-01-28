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

require("pckr").add({
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
			vim.api.nvim_set_keymap("n", "<C-p>", "", {
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
	{
		"zaldih/themery.nvim",
		config = "plugins.themery",
	},
})
