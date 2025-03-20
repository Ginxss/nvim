local M = {}

M.setup = function()
	-- nothing
end

local function found(err, result)
	return not err and result and not vim.tbl_isempty(result)
end

local function request_lsp(callback)
	local params = vim.lsp.util.make_position_params()

	vim.lsp.buf_request(0, "textDocument/implementation", params, function(impl_err, impl_result)
		if found(impl_err, impl_result) then
			callback(impl_result)
		else
			vim.lsp.buf_request(0, "textDocument/definition", params, function(def_err, def_result)
				if found(def_err, def_result) then
					callback(def_result)
				end
			end)
		end
	end)
end

local function get_buffer(filename)
	local bufs = vim.api.nvim_list_bufs()

	for _, buf in ipairs(bufs) do
		if vim.api.nvim_buf_get_name(buf) == filename then
			return buf
		end
	end

	return nil
end

--- Gets the implementation code from the lsp result
--- @return string[]?, string?: the lines and the filetype of the source buffer/file
local function get_code_with_filetype(lsp_result)
	local uri = lsp_result[1].targetUri
	local filename = vim.uri_to_fname(uri)

	local range = lsp_result[1].targetRange
	local start_line = range.start.line
	local end_line = range["end"].line + 1

	local buf = get_buffer(filename)

	if buf then
		local lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line, false)
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
		return lines, filetype
	else
		print("No buffer found, should fall back to disk!")
		return
	end
end

--- @param lines string[]
--- @return integer
local function max_line_length(lines)
	local max_length = 0

	for _, line in ipairs(lines) do
		if #line > max_length then
			max_length = #line
		end
	end

	return max_length
end

--- @param lines string[]
--- @param filetype string?
local function open_floating_win(lines, filetype)
	local max_length = max_line_length(lines)
	local width = math.min(max_length, 100)
	local height = math.min(#lines, 40)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

	if filetype then
		vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
	end

	local win_opts = {
		width = width,
		height = height,
		row = 1,
		col = 0,
		relative = "cursor",
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_opts)
	vim.api.nvim_set_option_value("wrap", false, { win = win })

	vim.keymap.set("n", "<ESC>", "<CMD>bd<CR>", { buffer = buf })
	vim.keymap.set("n", "q", "<CMD>bd<CR>", { buffer = buf })
end

local function display_function_code(lsp_result)
	local lines, filetype = get_code_with_filetype(lsp_result)
	if lines then
		open_floating_win(lines, filetype)
	end
end

M.peek_implementation = function()
	request_lsp(display_function_code)
end

return M
