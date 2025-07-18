import os
import shutil


HOME = "/home/dmitry"
REPO_DIR = f"{HOME}/Hyprdots"
CONFIG_DIR = f"{HOME}/.config/"

DIRS = [
    (f"{CONFIG_DIR}/hypr/", "config/hypr/"),
    (f"{CONFIG_DIR}/rofi/", "config/rofi"),
    (f"{CONFIG_DIR}/waybar/", "config/waybar"),
    (f"{CONFIG_DIR}/atuin/", "config/atuin"),
    (f"{CONFIG_DIR}/neofetch/", "config/neofetch"),
    (f"{CONFIG_DIR}/kitty/", "config/kitty"),
    (f"{CONFIG_DIR}/bottom/", "config/bottom"),
    (f"{CONFIG_DIR}/btop/", "config/btop"),
    (f"{CONFIG_DIR}/dunst/", "config/dunst"),
]


def main() -> None:
    for src, dest in DIRS:
        dest = os.path.join(REPO_DIR, dest)
        if os.path.isdir(src):
            shutil.copytree(src, dest, dirs_exist_ok=True)
        else:
            shutil.copy2(src, dest)


if __name__ == "__main__":
    main()

