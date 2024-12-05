return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		-- TODO: Config aufteilen
		local dap, dapui = require("dap"), require("dapui")

		-- Set up C/C++/Rust debug adapter
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/home/timo/.local/share/nvim/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.rust = {
			{
				-- has to match adapter above
				type = "codelldb",
				name = "Debug",
				request = "launch",
				program = function()
					local handle =
						io.popen("cargo metadata --format-version 1 --no-deps -q --frozen --no-default-features")
					if not handle then
						error("Failed to fetch cargo metadata")
					end
					local result = handle:read("*a")
					handle:close()

					local metadata = vim.fn.json_decode(result)
					local cwd = vim.fn.getcwd()
					local target_dir = metadata.target_directory -- or (cwd .. "/target")
					-- TODO: What if there are multiple packages? -> durchiterieren und das package mit dem gleichen namen wie cwd finden.
					local name = metadata.packages[1].name

					-- TODO: Nur input wenn target_dir nicht gefunden, oder multiple packages + name nicht gefunden.

					return vim.fn.input("Path to executable: ", target_dir .. "/debug/" .. name, "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- Set up keymaps
		vim.keymap.set("n", "<F4>", dap.toggle_breakpoint)

		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<leader><F5>", dap.restart)

		vim.keymap.set("n", "<F6>", dap.step_over)
		vim.keymap.set("n", "<F7>", dap.step_into)
		vim.keymap.set("n", "<F8>", dap.step_out)

		-- Set up UI
		dapui.setup()

		local function open_ui()
			dapui.open()
			vim.keymap.set("n", "<leader>e", function()
				dapui.eval(nil, { enter = true })
			end)
		end

		local function close_ui()
			dapui.close()
			-- TODO: use global
			vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeFindFileToggle<CR>")
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

		-- Set up virtual text
		require("nvim-dap-virtual-text").setup()
	end,
}
