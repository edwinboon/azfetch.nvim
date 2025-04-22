# azfetch.nvim

A Neovim plugin to fetch and optionally decrypt Azure Function App settings.

## Features

- Fetch settings from an Azure Function App.
- Optionally decrypt the settings after fetching.
- Configurable keybindings.

## Prerequisites

Before using this plugin, make sure you have the following tools installed and configured:

1. **[Azure Functions Core Tools](https://docs.microsoft.com/nl-nl/azure/azure-functions/functions-run-local?tabs=v4%2Cmacos%2Ccsharp%2Cportal%2Cbash)**:

   - This is required to fetch and decrypt Azure Function App settings.

2. **[Azure CLI](https://docs.microsoft.com/nl-nl/cli/azure/)**:

   - You need to be logged in to Azure using `az login` before using this plugin.

   ```bash
   az login
   ```

---

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
require("lazy").setup({
    {
        "yourusername/azfetch.nvim", -- Replace with your GitHub repository URL
        config = function()
            require("azfetch").setup({
                decrypt = true, -- Set to `false` if you don't want to decrypt
                keymap = "<leader>af", -- Custom keymap
            })
        end,
    },
})
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
    "yourusername/azfetch.nvim", -- Replace with your GitHub repository URL
    config = function()
        require("azfetch").setup({
            decrypt = true, -- Set to `false` if you don't want to decrypt
            keymap = "<leader>af", -- Custom keymap
        })
    end,
}
```

---

## Usage

1. Press the configured keybinding (default: `<leader>az`) in normal mode.
2. Enter the name of the Azure Function App when prompted.
3. The settings will be fetched, and optionally decrypted if `decrypt` is enabled.

---

## Configuration Options

| Option    | Type    | Default      | Description                                 |
| --------- | ------- | ------------ | ------------------------------------------- |
| `decrypt` | boolean | `false`      | Whether to decrypt settings after fetching. |
| `keymap`  | string  | `<leader>az` | Keybinding to trigger the fetch action.     |

---

## Example Configuration

```lua
require("azfetch").setup({
    decrypt = true, -- Enable decryption after fetching
    keymap = "<leader>af", -- Set a custom keybinding
})
```

---

## License

This plugin is licensed under the MIT License.
