import os
import shutil


HOME = "/home/dmitry"
REPO_DIR = f"{HOME}/Hyprdots"
CONFIG_DIR = f"{HOME}/.config/"

DIRS = [
    (f"{CONFIG_DIR}/hypr/", "config/hypr/"),
    (f"{CONFIG_DIR}/atuin/", "config/atuin"),
    (f"{CONFIG_DIR}/neofetch/", "config/neofetch"),
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

