require("config.options")
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

require("pckr").setup({
	display = {
		open_fn = function()
			return require("pckr.util").float({ border = "single" })
		end,
		prompt_border = "double",
	},
})
require("pckr").add({
	{
		"marko-cerovac/material.nvim",
		config = function()
			require("plugins.colorscheme")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("plugins.illuminate")
		end,
	},
	{ "sitiom/nvim-numbertoggle" },
	"lewis6991/gitsigns.nvim",
})
