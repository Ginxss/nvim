-- the colorscheme should be available when starting Neovim 
return {
	{
		'folke/tokyonight.nvim',
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		-- config = function()
		-- 	require('tokyonight').setup({
		-- 		styles = {
		-- 			keywords = { italic = false },
		-- 		},
		-- 	})
		--
		-- 	vim.cmd([[colorscheme tokyonight]])
		-- end
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				styles = {
					conditionals = {}, -- removed italic
				},
				-- To treat builtin functions like regular functions:
				-- custom_highlights = function(colors)
				-- 	return {
				-- 		["@function.builtin"] = { link = "Function" }
				-- 	}
				-- end,
			})

			vim.cmd.colorscheme 'catppuccin-mocha'
		end,
	}
}
