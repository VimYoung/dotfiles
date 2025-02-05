require("themery").setup({
	themes = {
		{
			name = "Material Deep Ocean",
			colorscheme = "material",
			before = [[
        vim.g.material_style = "deep ocean"
      ]],
		},
		{
			name = "Carbon (Min)",
			colorscheme = "oxocarbon",
		},
		{
			name = "Ashen",
			colorscheme = "ashen",
		},
		{
			name = "World",
			colorscheme = "oldworld",
		},
		{
			name = "Modus (Hypr Min)",
			colorscheme = "modus",
		},
		{
			name = "Poim (Min)",
			colorscheme = "poimandres",
		},
		{
			name = "Wave Kanag (Min)",
			colorscheme = "kanagawa-wave",
		},
		{
			name = "Dragon Kanag",
			colorscheme = "kanagawa-dragon",
		},
		{
			name = "Night Owl (Min)",
			colorscheme = "night-owl",
		},
		{
			name = "Material Oceanic",
			colorscheme = "material",
			before = [[
        vim.g.material_style = "oceanic"
      ]],
		},
		{
			name = "Material Lighter",
			colorscheme = "material",
			before = [[
        require("material").setup({
          custom_highlights = {
            FloatBorder = {},
          },
          plugins = {
            "gitsigns",
            "indent-blankline",
            "illuminate",
          },
          contrast = {
            terminal = false, -- Enable contrast for the built-in terminal
            sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
            floating_windows = false, -- Enable contrast for floating windows
            non_current_windows = true, -- Enable contrasted background for non-current windows
          },
          lualine_style = "stealth",
        })

        vim.g.material_style = "lighter"
      ]],
		},
	},
	globalBefore = [[
	   require("material").setup({
	     custom_highlights = {
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
	       terminal = false, -- Enable contrast for the built-in terminal
	       sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
	       floating_windows = false, -- Enable contrast for floating windows
	       non_current_windows = true, -- Enable contrasted background for non-current windows
	     },
	     lualine_style = "stealth",
	   })

	 ]],
	livePreview = true, -- Apply theme while picking. Default to true.
})
