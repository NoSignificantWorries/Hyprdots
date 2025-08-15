import os

import catppuccin

config.load_autoconfig()

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"

catppuccin.setup(c, "mocha", True)

c.auto_save.session = False
c.session.default_name = "default"

c.editor.command = ["nvim", "-f", "{file}"]

