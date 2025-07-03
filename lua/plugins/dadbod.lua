--- Sets the keymap for each of the keys in the specified buffer
--- @param keys string[]
--- @param buf integer
--- @param func function
local function set_multi_keymap(keys, buf, func)
	for _, key in ipairs(keys) do
		vim.keymap.set("n", key, func, { buffer = buf })
	end
end

return {
	"tpope/vim-dadbod",
	dependencies = { "kristijanhusak/vim-dadbod-ui" },
	keys = {
		{
			"<leader>db",
			function()
				vim.cmd("DBUI")
				set_multi_keymap({ "<ESC>", "<C-c>", "q", "<leader>db" }, 0, vim.cmd.close)
			end,
		},
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_win_position = "right"
		vim.g.db_ui_winwidth = 50
	end,
}
