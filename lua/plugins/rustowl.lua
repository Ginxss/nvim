-- TODO
return {
	"cordx56/rustowl",
	cond = not vim.g.profile_light,
	enabled = false,
	ft = "rust",
	dependencies = { "neovim/nvim-lspconfig" },
}
