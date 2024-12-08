-- default: noremap = true -> no recursive mapping: you can include lhs in rhs

-- quick movement with ctrl
vim.keymap.set({ "n", "o", "v" }, "<C-h>", "^")
vim.keymap.set({ "n", "o", "v" }, "<C-l>", "$")
vim.keymap.set({ "n", "o", "v" }, "<C-j>", "}")
vim.keymap.set({ "n", "o", "v" }, "<C-k>", "{")

-- move in insert mode with ctrl
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- f match forward (default backward is , and default forward is ;)
vim.keymap.set({ "n", "o", "v" }, ".", ";")
-- jump to corresponding bracket
vim.keymap.set({ "n", "o", "v" }, "ö", "%")
-- jump context
vim.keymap.set({ "n", "o", "v" }, "ü", "[")
vim.keymap.set({ "n", "o", "v" }, "ä", "]")

-- center on jumps
vim.keymap.set({ "n", "o", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "o", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "o", "v" }, "n", "nzz")
vim.keymap.set({ "n", "o", "v" }, "N", "Nzz")

-- move line/selection up and down
vim.keymap.set("n", "<A-j>", "<CMD>m +1<CR>==")
vim.keymap.set("n", "<A-k>", "<CMD>m -2<CR>==")
vim.keymap.set("i", "<A-j>", "<ESC><CMD>m +1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<ESC><CMD>m -2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- <cmd> runs directly in the same execution context, : uses the cmdline context -> can only find the selection marks with :
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- clear search highlights with esc
vim.g.default_esc_mapping = "<CMD>nohlsearch<CR>"
vim.keymap.set("n", "<ESC>", vim.g.default_esc_mapping)

-- exit terminal mode with esc
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- ctrl+s save (and exit insert mode)
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>")
vim.keymap.set("i", "<C-s>", "<ESC><CMD>w<CR>")

-- switch back to previous file
vim.keymap.set("n", "<leader>b", "<C-^>")

-- system clipboard
vim.keymap.set({ "n", "o", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- paste without losing content
vim.keymap.set("v", "<leader>p", "pgvy")

-- code actions
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

-- go to definition/declaration
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)

-- go to diagnostics
vim.keymap.set("n", "gp", vim.diagnostic.goto_next)
vim.keymap.set("n", "gP", vim.diagnostic.goto_prev)

-- toggle diagnostics
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

-- toggle inlay hints
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- for testing lazy loading
vim.keymap.set("n", "<leader>z", "<CMD>Lazy<CR>")
