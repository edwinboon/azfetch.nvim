local M = {}

-- Import the fetch module
local fetch = require("azure.fetch")

-- Setup function for the plugin
function M.setup(opts)
	opts = opts or {}
	local decrypt = opts.decrypt or false
	local keymaps = opts.keymaps or {}

	-- Default keybinding for fetching app settings
	keymaps.fetch_app_settings = keymaps.fetch_app_settings or "<leader>af"

	-- Set up the keybinding for fetching app settings
	if keymaps.fetch_app_settings then
		vim.api.nvim_set_keymap(
			"n",
			keymaps.fetch_app_settings,
			":lua require('azure.fetch').fetch_app_settings(" .. tostring(decrypt) .. ")<CR>",
			{ noremap = true, silent = true }
		)
	end

	-- Register the command for fetching app settings
	vim.api.nvim_create_user_command("AzFetchAppSettings", function()
		fetch.fetch_app_settings(decrypt)
	end, {})
end

return M
