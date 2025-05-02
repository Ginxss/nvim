-- TODO: Does not work yet, try again later
return {
	"cordx56/rustowl",
	enabled = false,
	cond = not vim.g.profile_light,
	version = "*",
	build = "cargo install --path . --locked",
	lazy = false, -- This plugin is already lazy
	-- ft = "rust",
	opts = {
		client = {
			on_attach = function(_, buffer)
				vim.keymap.set("n", "<leader>o", function()
					require("rustowl").toggle(buffer)
				end, { buffer = buffer, desc = "Toggle RustOwl" })
			end,
		},
	},
}
