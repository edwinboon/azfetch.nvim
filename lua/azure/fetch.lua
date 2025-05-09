local M = {}

-- Function to fetch and optionally decrypt app settings
function M.fetch_app_settings(decrypt)
	-- Prompt the user for the Azure Function App name
	local app_name = vim.fn.input("Enter Azure Function App name: ")
	if app_name == "" then
		print("App name cannot be empty!")
		return
	end

	-- Prompt the user for the Azure Function App resource group
	local resource_group = vim.fn.input("Enter Azure Function App resource group: ")
	if resource_group == "" then
		print("Resource group cannot be empty!")
		return
	end

	-- Construct the Azure CLI command to fetch app settings
	local cmd = "az functionapp config appsettings list --name "
		.. app_name
		.. " --resource-group "
		.. resource_group
		.. " --query '[].{name:name, value:value}' -o json"

	-- Execute the command and capture the output
	local result = vim.fn.system(cmd)

	-- Check for errors
	if vim.v.shell_error ~= 0 then
		print("Error fetching app settings: " .. result)
		return
	end

	-- Parse the JSON result
	local settings = vim.fn.json_decode(result)
	if not settings then
		print("Failed to parse app settings.")
		return
	end

	-- Handle decryption if enabled
	if decrypt then
		for _, setting in ipairs(settings) do
			if setting.value:match("^ENC%(") then
				-- Decrypt the value using Azure CLI or custom logic
				local decrypt_cmd = "az keyvault secret show --name "
					.. setting.name
					.. " --vault-name <YourKeyVaultName> --query value -o tsv"
				local decrypted_value = vim.fn.system(decrypt_cmd)

				-- Replace the encrypted value with the decrypted value
				if vim.v.shell_error == 0 then
					setting.value = decrypted_value
				else
					print("Error decrypting value for " .. setting.name .. ": " .. decrypted_value)
				end
			end
		end
	end

	-- Convert to local.settings.json format
	local local_settings = {
		IsEncrypted = false,
		Values = {},
	}

	-- Add each setting to the Values object
	for _, setting in ipairs(settings) do
		local_settings.Values[setting.name] = setting.value
	end

	-- Get the current working directory
	local cwd = vim.fn.getcwd()
	local output_file = cwd .. "/local.settings.json"

	-- Convert back to JSON with pretty formatting
	local json_str = vim.fn.json_encode(local_settings)

	-- Pretty print JSON (optional)
	-- This creates better formatted JSON with indentation
	if vim.fn.has("nvim-0.7") == 1 then
		-- For Neovim 0.7+ use the built-in JSON formatting
		json_str = vim.json.encode(local_settings, { indent = 2 })
	end

	-- Write to file
	local file = io.open(output_file, "w")
	if file then
		file:write(json_str)
		file:close()
		print("Settings saved to " .. output_file)

		-- Optionally open the file in a new buffer
		vim.cmd("edit " .. output_file)
	else
		print("Failed to write settings to file")
	end
end

return M
