return {
    {
	    'williamboman/mason.nvim',
	    config = function()
		    require('mason').setup()
	    end
    },
    {
	    'williamboman/mason-lspconfig.nvim',
	    dependencies = { 'williamboman/mason.nvim' },
	    config = function()
		    require('mason-lspconfig').setup {
			    ensure_installed = { 'rust_analyzer' },
			    automatic_installation = true,
		    }
	    end
    },
    {
	    'neovim/nvim-lspconfig',
	    dependencies = { 'williamboman/mason-lspconfig.nvim' },
	    config = function()
		    require('lspconfig').rust_analyzer.setup {}
	    end
    },
}
