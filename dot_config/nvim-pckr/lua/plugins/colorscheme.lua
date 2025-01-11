require("material").setup({
	-- Adding custom_highlights as border color was not visible for transparent background in deep ocean.
	custom_highlights = {
		-- Added an empty string for FloatBorder to use defualt values instead
		-- black borders which are the default by doesn't fit with transparent background
		-- and dark ocean theme.
		FloatBorder = {},
	},
	plugins = {
		"gitsigns",
		"indent-blankline",
		"illuminate",
	},
	disable = {
		background = true,
	},
	contrast = {
		-- If the background is set to transparent,
		terminal = false, -- Enable contrast for the built-in terminal
		sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = false, -- Enable contrast for floating windows
		--lsp_virtual_text = true, -- Enable contrasted background for lsp virtual text
		non_current_windows = true, -- Enable contrasted background for non-current windows
	},
	lualine_style = "stealth",
})

--Initialising plugins
vim.g.material_style = "deep ocean" --Setting desired style
vim.cmd("colorscheme material") --enabling the theme.

--I do not know that wheather the above setup is working or not, will have to change few values from default and
--see If that takes effect.
