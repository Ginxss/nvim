return {
	'rafamadriz/friendly-snippets',
	{
		'L3MON4D3/LuaSnip',
		version = 'v2.*',
		build = 'make install_jsregexp',
		dependencies = { 'rafamadriz/friendly-snippets' },
		config = function()
			local ls = require('luasnip')

			-- vim.keymap.set({'i'}, '<C-K>', function() ls.expand() end, {silent = true})
			vim.keymap.set({'i'}, '<Tab>', function()
				if ls.expandable() then
					ls.expand()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
				end
			end, {silent = true})

			vim.keymap.set({'i', 's'}, '<Tab>', function()
				if ls.locally_jumpable(1) then
					ls.jump(1)
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
				end
			end, {silent = true})

			vim.keymap.set({'i', 's'}, '<S-Tab>', function()
				if ls.locally_jumpable(-1) then
					ls.jump(-1)
				else 
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true), 'n', false)
				end
			end, {silent = true})

			vim.keymap.set({'i', 's'}, '<C-E>', function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, {silent = true})

			require('luasnip.loaders.from_vscode').lazy_load()
		end
	},
}
