-- default: noremap = true -> no recursive mapping: you can include lhs in rhs

-- Useful default mappings:
-- C-xl -> complete line

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
vim.keymap.set({ "n", "o", "v" }, "üü", "[m{j_f(") -- TODO

-- center on jumps
vim.keymap.set({ "n", "o", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "o", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "o", "v" }, "<C-f>", "<C-f>zz")
vim.keymap.set({ "n", "o", "v" }, "<C-b>", "<C-b>zz")
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

-- insert semicolon at end of line and exit insert mode
vim.keymap.set("i", "<C-f>", "<End>;<ESC>")

-- system clipboard
vim.keymap.set("n", "<leader>yy", '"+yy')
vim.keymap.set({ "n", "o", "v" }, "<leader>y", '"+y')

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')

-- paste without losing content
vim.keymap.set("v", "<leader><leader>p", "pgvy")

-- switch back to previous file
vim.keymap.set("n", "<leader>b", "<C-^>")

-- Format log file
vim.keymap.set(
	"n",
	"<leader><leader>l",
	'<CMD>%s/\\\\n/\\r/g<CR><CMD>%s/\\\\t/\\t/g<CR><CMD>g/ERROR/exec "normal O"<CR>'
)

-- move through tabs
vim.keymap.set("n", "<C-w>t", "gt")
vim.keymap.set("n", "<C-w><C-t>", "gt")

-- close files
vim.keymap.set({ "n", "o", "v" }, "<leader>x", "<CMD>q<CR>")
vim.keymap.set({ "n", "o", "v" }, "<leader><leader>x", "<CMD>qa<CR>")

-- move through quickfix list
vim.keymap.set("n", "<leader>qn", "<CMD>cnext<CR>")
vim.keymap.set("n", "<leader>qp", "<CMD>cprevious<CR>")

-- code actions
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename)

-- go to definition/declaration
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "ga", vim.lsp.buf.implementation)

-- go to diagnostics
vim.keymap.set("n", "gp", vim.diagnostic.goto_next)
vim.keymap.set("n", "gP", vim.diagnostic.goto_prev)

-- toggle diagnostics
vim.keymap.set("n", "<leader><leader>d", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

-- toggle inlay hints
vim.keymap.set("n", "<leader><leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- lazy.nvim
vim.keymap.set("n", "<leader><leader>z", "<CMD>Lazy<CR>")
