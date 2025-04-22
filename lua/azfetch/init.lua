local M = {}

-- Plugin version
M.version = "0.0.3"

-- Default options
M.options = {
	decrypt = false, -- Optional decryption
	keymap = "<leader>az", -- Default keymap
}

-- Function to fetch and optionally decrypt Azure Function App settings
function M.fetch_and_decrypt_settings()
	local app_name = vim.fn.input("Enter Function App Name: ", "")
	if app_name == "" then
		print("No Function App Name provided. Aborting.")
		return
	end

	-- Run the fetch command
	local fetch_command = "func azure functionapp fetch-app-settings " .. app_name
	local fetch_result = vim.fn.system(fetch_command)
	if vim.v.shell_error ~= 0 then
		print("Error fetching settings: " .. fetch_result)
		return
	end
	print("Settings fetched successfully.")

	-- Optionally decrypt the settings
	if M.options.decrypt then
		local decrypt_command = "func settings decrypt"
		local decrypt_result = vim.fn.system(decrypt_command)
		if vim.v.shell_error ~= 0 then
			print("Error decrypting settings: " .. decrypt_result)
			return
		end

		vim.api.nvim_command("new") -- Open a new buffer
		vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(decrypt_result, "\n"))
		print("Settings decrypted successfully.")
	else
		print("Decryption skipped. Fetched settings are available in the command output.")
	end
end

-- Setup function to configure the plugin
function M.setup(options)
	-- Merge user options with defaults
	M.options = vim.tbl_deep_extend("force", M.options, options or {})

	-- Set up the keymap
	if M.options.keymap and M.options.keymap ~= "" then
		vim.api.nvim_set_keymap(
			"n",
			M.options.keymap,
			":lua require('azfetch').fetch_and_decrypt_settings()<CR>",
			{ noremap = true, silent = true }
		)
	end
end

-- Function to get the plugin version
function M.get_version()
	print("azfetch.nvim version: " .. M.version)
end

return M
