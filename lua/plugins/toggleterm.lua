return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = { "<leader>t" },
	config = function()
		local function wider()
			return vim.o.columns > (vim.o.lines * 2)
		end

		require("toggleterm").setup({
			open_mapping = "<leader>t",
			insert_mappings = false,
			terminal_mappings = false,
			persist_mode = false,
			-- shell = "fish", -- set by global shell option
			direction = "float",
			float_opts = {
				border = "curved",
				width = function()
					if wider() then
						return math.floor(vim.o.columns * 0.5)
					else
						return vim.o.columns
					end
				end,
				height = function()
					if wider() then
						return vim.o.lines - 4 -- leave space for lualine at the bottom
					else
						return math.floor(vim.o.lines * 0.5) - 4
					end
				end,
				row = function() -- avoid overlapping lualine -> can't just set to max like col
					if wider() then
						return 0
					else
						return math.ceil(vim.o.lines * 0.5)
					end
				end,
				col = vim.o.columns, -- always as right as possible - floating window can't get outside of bounds
			},
			highlights = {
				FloatBorder = {
					link = "FloatBorder",
				},
			},
			on_open = function()
				vim.keymap.set("n", "<ESC>", "<CMD>ToggleTerm<CR>") -- override esc for close mapping (open_mapping is a toggle, close_mapping doesn't exist)
			end,
			on_close = function()
				vim.keymap.set("n", "<ESC>", vim.g.default_esc_mapping) -- restore original mapping
			end,
		})
	end,
}
