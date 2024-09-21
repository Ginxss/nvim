return {
	'nvim-tree/nvim-web-devicons',
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('nvim-tree').setup({
				view = {
					width = 50,
				},
				actions = {
					open_file = {
						quit_on_open = true,
					}
				}
			})

			vim.keymap.set('n', '<leader>e', '<CMD>NvimTreeFindFileToggle<CR>')
		end
	},
}
