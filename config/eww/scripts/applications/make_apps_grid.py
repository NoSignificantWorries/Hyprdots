#!/bin/env python

import os
from pathlib import Path
import configparser

import applications as my_apps

base_grid = "(box :class \"main-apps\" :orientation \"h\")"

def main() -> None:
    for icon_file, command in my_apps.APPLICATIONS:
        icon_file = Path(icon_file).expanduser()
        if not icon_file.exists():
            continue

        print(f"(app-button :icon-path \"{icon_file}\" :command \"{command}\")")


if __name__ == "__main__":
    print(my_apps.APPLICATIONS)
    main()

