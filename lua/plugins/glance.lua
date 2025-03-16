return {
	"dnlhc/glance.nvim",
	config = function()
		local glance = require("glance")
		glance.setup({
			preserve_win_context = false,
			preview_win_opts = { wrap = false },
			border = { enable = true },
		})

		-- TODO: zt in glance window
		local actions = glance.actions

		local function found(err, result)
			return not err and result and not vim.tbl_isempty(result)
		end

		local function peek_implementation()
			local params = vim.lsp.util.make_position_params()

			vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result)
				if found(err, result) then
					actions.open("implementations")
				else
					vim.lsp.buf_request(0, "textDocument/definition", params, function(def_err, def_result)
						if found(def_err, def_result) then
							actions.open("definitions")
						else
							print("No implementation or definition found.")
						end
					end)
				end
			end)
		end

		vim.keymap.set("n", "<leader>i", peek_implementation)
	end,
}
