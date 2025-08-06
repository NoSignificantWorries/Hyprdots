-- Init lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


-- Import plugins and settings
require("vim-options")
require("keybindings")

require("lazy").setup("plugins")

if vim.g.vscode then
    local vscode = {
        action = function(method, params)
            vim.fn.VSCodeNotify(method, params.args)
        end
    }

    -- local vscode = require("vscode")

    local function notify_vscode_mode()
        local mode = vim.api.nvim_get_mode().mode
        local mode_name = ""
        -- Convert Neovim mode to readable name
        if mode == "n" then
            mode_name = "normal"
        elseif mode == "i" then
            mode_name = "insert"
        elseif mode == "v" then
            mode_name = "visual"
        elseif mode == "V" then
            mode_name = "visual"
        elseif mode == "\22" then
            mode_name = "visual"
        elseif mode == "c" then
            mode_name = "cmdline"
        elseif mode == "R" then
            mode_name = "replace"
        else
            mode_name = mode
        end
        --  Call VSCode extension to update UI asynchronously
        vscode.action("nvim-ui-plus.setMode", {
            args = { mode = mode_name }
        })
    end

    -- Mode change notification autocmd
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*",
        callback = notify_vscode_mode,
    })
end

