-- Maybe try out blink.cmp?
return {
	{
		"folke/lazydev.nvim",
		cond = not vim.g.profile_light,
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-u>"] = cmp.mapping.scroll_docs(-8),
					["<C-d>"] = cmp.mapping.scroll_docs(8),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
					["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "lazydev" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- cmp for search
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- cmp for ':'
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
			-- Set configuration for specific filetype.
			--[[ cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
				})
			})
			require('cmp_git').setup() ]]
			--
		end,
	},
}
