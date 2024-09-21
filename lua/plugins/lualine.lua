return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local function telescope_statusline()
			return 'Telescope'
		end

		local telescope = {
			sections = { lualine_a = { telescope_statusline } },
			filetypes = { 'TelescopePrompt' }
		}

		require('lualine').setup {
			options = {
				globalstatus = true,
			},
			inactive_sections = {},
			extensions = { 'lazy', 'nvim-tree', 'toggleterm', 'mason', telescope }
		}
	end,
}
