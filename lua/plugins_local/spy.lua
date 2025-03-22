local M = {}

--- @class spy.Options
--- @field focus_on_open boolean
--- @field focus_keymap string
--- @field close_keymaps string[]
--- @field wrap boolean
--- @field max_width number
--- @field max_height number
--- @field win_border string

--- @type spy.Options
local options = {
	focus_on_open = false,
	focus_keymap = "<leader>l",
	close_keymaps = { "q", "<ESC>", "<C-c>" },
	wrap = true,
	max_width = 100,
	max_height = 40,
	win_border = "rounded",
}

--- @class spy.OptionsNullable
--- @field focus_on_open boolean?: Whether the floating window should take focus
--- @field focus_keymap string?: Keymap to enter the floating window if not focused on open
--- @field close_keymaps string[]?: Keymaps to close the focused floating window
--- @field wrap boolean?: Wrap for the floating window
--- @field max_width integer?: Maxmimum width for the floating window
--- @field max_height integer?: Maxmimum height for the floating window
--- @field win_border string?: Border style for the floating window

--- @param opts spy.OptionsNullable
M.setup = function(opts)
	options = vim.tbl_deep_extend("force", options, opts or {})
end

--- @return boolean
local function success(err, result)
	return not err and result and not vim.tbl_isempty(result)
end

--- Requests implementations first and definitions second from the lsp for the cursor position
--- @param callback function: The function to call with the lsp result. If no result is found, the function is not called.
local function request_lsp(callback)
	local params = vim.lsp.util.make_position_params()

	vim.lsp.buf_request(0, "textDocument/implementation", params, function(impl_err, impl_result)
		if success(impl_err, impl_result) then
			callback(impl_result)
		else
			vim.lsp.buf_request(0, "textDocument/definition", params, function(def_err, def_result)
				if success(def_err, def_result) then
					callback(def_result)
				end
			end)
		end
	end)
end

--- @return string, integer, integer: filename, start line index (0-based), end line index (exclusive)
local function parse_info(lsp_result)
	local uri = lsp_result[1].targetUri
	local filename = vim.uri_to_fname(uri)

	local range = lsp_result[1].targetRange
	local start_line = range.start.line
	local end_line = range["end"].line + 1

	return filename, start_line, end_line
end

--- @param filename string
--- @return integer?: the buffer handle or nil
local function find_buffer(filename)
	local bufs = vim.api.nvim_list_bufs()

	for _, buf in ipairs(bufs) do
		if vim.api.nvim_buf_get_name(buf) == filename then
			return buf
		end
	end

	return nil
end

--- @return string[]?, string?: function code, filetype of the src buffer/file
local function get_code_with_filetype(lsp_result)
	local filename, start_line, end_line = parse_info(lsp_result)
	local buf = find_buffer(filename)

	local lines, filetype

	if buf then
		lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line, false)
		filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
	else
		local all_lines = vim.fn.readfile(filename)
		lines = vim.list_slice(all_lines, start_line + 1, end_line)
		filetype = vim.filetype.match({ filename = filename })
	end

	return lines, filetype
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

--- Sets the keymap for each of the keys in the specified buffer
--- @param keys string[]
--- @param buf integer
--- @param func function
local function set_multi_keymap(keys, buf, func)
	for _, key in ipairs(keys) do
		vim.keymap.set("n", key, func, { buffer = buf })
	end
end

--- Sets up the keymaps for the new floating window
--- @param win integer: the id of the floating window
--- @param buf integer: the buffer id of the floating window
--- @param base_buf integer: the buffer id of the base window
local function setup_keymaps(win, buf, base_buf)
	vim.keymap.set("n", options.focus_keymap, function()
		vim.api.nvim_set_current_win(win)
	end, { buffer = base_buf })

	local augroup = vim.api.nvim_create_augroup("SpyAutoClose", {})

	local close_win = function()
		vim.api.nvim_win_close(win, true)
		vim.api.nvim_buf_delete(buf, { force = true })

		vim.api.nvim_del_augroup_by_id(augroup)
		vim.keymap.del("n", options.focus_keymap, { buffer = base_buf })
	end

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = augroup,
		buffer = base_buf,
		callback = close_win,
	})

	set_multi_keymap(options.close_keymaps, buf, close_win)
end

--- @param lines string[]
--- @param filetype string?
local function open_floating_win(lines, filetype)
	local base_buf = vim.api.nvim_get_current_buf()

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

	if filetype then
		vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
	end

	local width = math.min(max_line_length(lines), options.max_width)
	local height = math.min(#lines, options.max_height)

	local win_opts = {
		width = width,
		height = height,
		row = 1,
		col = 0,
		relative = "cursor",
		style = "minimal",
		border = options.win_border,
	}

	local win = vim.api.nvim_open_win(buf, options.focus_on_open, win_opts)
	vim.api.nvim_set_option_value("wrap", options.wrap, { win = win })

	setup_keymaps(win, buf, base_buf)
end

--- Parses the lsp result and displays the code in a new floating window
local function display_code(lsp_result)
	local lines, filetype = get_code_with_filetype(lsp_result)
	if lines then
		open_floating_win(lines, filetype)
	end
end

--- Opens the implementation of the function under the cursor in a floating window
M.peek_implementation = function()
	request_lsp(display_code)
end

return M
