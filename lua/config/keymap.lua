-- start of line
vim.keymap.set({ "n", "o", "v" }, "<C-h>", "^", { noremap = true, silent = false })
-- end of line
vim.keymap.set({ "n", "o", "v" }, "<C-l>", "$")
-- down paragraph
vim.keymap.set({ "n", "o", "v" }, "+", "}")
vim.keymap.set({ "n", "o", "v" }, "<C-j>", "}")
-- up paragraph
vim.keymap.set({ "n", "o", "v" }, "-", "{")
vim.keymap.set({ "n", "o", "v" }, "<C-k>", "{")

-- f match forward (default backward is , and default forward is ;)
vim.keymap.set({ "n", "o", "v" }, ".", ";")
-- jump to corresponding bracket
vim.keymap.set({ "n", "o", "v" }, "ö", "%")
-- jump context
vim.keymap.set({ "n", "o", "v" }, "ü", "[")
vim.keymap.set({ "n", "o", "v" }, "ä", "]")

-- down half page with center (zz centers the view)
vim.keymap.set({ "n", "o", "v" }, "<C-d>", "<C-d>zz")
-- up half page with center
vim.keymap.set({ "n", "o", "v" }, "<C-u>", "<C-u>zz")
-- next search match with center
vim.keymap.set({ "n", "o", "v" }, "n", "nzz")
-- previous search match with center
vim.keymap.set({ "n", "o", "v" }, "N", "Nzz")

-- move in insert mode with ctrl
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- move line/selection up and down
vim.keymap.set("n", "<A-j>", "<CMD>m +1<CR>==")
vim.keymap.set("n", "<A-k>", "<CMD>m -2<CR>==")
vim.keymap.set("i", "<A-j>", "<ESC><CMD>m +1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<ESC><CMD>m -2<CR>==gi")
-- <cmd> runs directly in the same execution context, : uses the cmdline context -> can only find the selection marks with :
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- switch back to previous file
vim.keymap.set("n", "<leader>b", "<C-^>")

-- ctrl+s save
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>")
vim.keymap.set("i", "<C-s>", "<ESC><CMD>w<CR>")

-- clear search highlights with esc
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")

-- exit terminal mode with esc
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- system clipboard
vim.keymap.set({ "n", "o", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- code actions
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

-- toggle inlay hints
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- go to definition/declaration
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)

-- jump to diagnostics
vim.keymap.set("n", "gp", vim.diagnostic.goto_next)
vim.keymap.set("n", "gP", vim.diagnostic.goto_prev)

-- toggle diagnostics
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

vim.keymap.set("n", "<leader>z", "<CMD>Lazy<CR>")
