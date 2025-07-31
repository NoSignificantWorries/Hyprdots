require("git"):setup()

require("full-border"):setup {
	type = ui.Border.ROUNDED,
}

require("gvfs"):setup({
  save_path = os.getenv("HOME") .. "/.config/yazi/gvfs.private",
  save_password_autoconfirm = true,
})

