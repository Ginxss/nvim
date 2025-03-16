return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local telescope = {
			sections = {
				lualine_a = {
					function()
						return "Telescope"
					end,
				},
			},
			filetypes = { "TelescopePrompt" },
		}

		local undotree = {
			sections = {
				lualine_a = {
					function()
						return "Undotree"
					end,
				},
			},
			filetypes = { "undotree" },
		}

		require("lualine").setup({
			options = {
				globalstatus = true,
			},
			sections = {
				lualine_c = { { "filename", path = 1 } },
			},
			inactive_sections = {},
			extensions = { "lazy", "nvim-tree", "toggleterm", "mason", telescope, undotree },
		})
	end,
}
