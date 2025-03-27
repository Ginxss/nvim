return {
	{
		"theHamsta/nvim-dap-virtual-text",
		cond = not vim.g.profile_light,
		lazy = true,
		opts = {
			highlight_changed_variables = false,
		},
	},
	{
		"mfussenegger/nvim-dap",
		cond = not vim.g.profile_light,
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
		keys = {
			{
				"<F4>",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
			{
				"<leader>rb",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- debug adapter
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			-- configuration
			local get_rust_debug_executable = function()
				local cwd = vim.fn.getcwd()
				local default_target_dir = cwd .. "/target/debug/"
				local default_name = string.match(cwd, "([^/]+)$")

				local handle = io.popen("cargo metadata --format-version 1 --no-deps -q --frozen --no-default-features")
				if not handle then
					return vim.fn.input(
						"Could not read cargo metadata, guessing: ",
						default_target_dir .. default_name,
						"file"
					)
				end

				local content = handle:read("*a")
				handle:close()

				local metadata = vim.fn.json_decode(content)
				if not metadata.target_directory then
					return vim.fn.input(
						"Could not read target_directory from metadata, guessing: ",
						default_target_dir .. default_name,
						"file"
					)
				end

				local target_dir = metadata.target_directory .. "/debug/"
				if #metadata.packages ~= 1 then
					for i = 1, #metadata.packages do
						if metadata.packages[i].name == default_name then
							return target_dir .. default_name
						end
					end

					return vim.fn.input(
						"Could not find package name in metadata, guessing: ",
						target_dir .. default_name,
						"file"
					)
				end

				return target_dir .. metadata.packages[1].name
			end

			dap.configurations.rust = {
				{
					type = "codelldb", -- has to match adapter name
					name = "Debug",
					request = "launch",
					program = get_rust_debug_executable,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- additional keymaps
			vim.keymap.set("n", "<leader><leader>rb", dap.clear_breakpoints)
			vim.keymap.set("n", "<leader>rd", dap.continue)
			vim.keymap.set("n", "<leader><leader>rd", dap.restart)
			vim.keymap.set("n", "<leader>rn", dap.step_over)
			vim.keymap.set("n", "<leader>ri", dap.step_into)
			vim.keymap.set("n", "<leader>ro", dap.step_out)

			vim.keymap.set("n", "<leader><F4>", dap.clear_breakpoints)
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<leader><F5>", dap.restart)
			vim.keymap.set("n", "<F6>", dap.step_over)
			vim.keymap.set("n", "<F7>", dap.step_into)
			vim.keymap.set("n", "<F8>", dap.step_out)

			-- UI
			dapui.setup()

			local function open_ui()
				dapui.open()
				vim.keymap.set("n", "<leader>e", function()
					dapui.eval(nil, { enter = true })
				end)
			end

			local function close_ui()
				dapui.close()
				vim.keymap.set("n", "<leader>e", vim.g.default_leader_e_mapping)
			end

			dap.listeners.before.attach.dapui_config = function()
				open_ui()
			end
			dap.listeners.before.launch.dapui_config = function()
				open_ui()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				close_ui()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				close_ui()
			end

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", numhl = "DapStopped" })
		end,
	},
}
