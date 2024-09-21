return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		opts = {
			open_mapping = '<leader>t',
			insert_mappings = false,
			terminal_mappings = false,
			persist_mode = false,
			direction = 'float',
			float_opts = {
				border = 'double',
				width = function()
					return math.floor(vim.o.columns * 0.7)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
			}
		}
	}
}
