return {
    {
	    'williamboman/mason.nvim',
	    config = true,
    },
    {
	    'williamboman/mason-lspconfig.nvim',
	    dependencies = { 'williamboman/mason.nvim' },
		opts = {
			ensure_installed = { 'lua_ls', 'rust_analyzer' },
			automatic_installation = true,
		},
    },
    {
	    'neovim/nvim-lspconfig',
	    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    },
}
