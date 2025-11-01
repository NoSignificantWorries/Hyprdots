from pathlib import Path


HOME = Path.home()

HYPR = "Hyprdots"
HYPR_DESKTOP_DIR = HOME / HYPR / "desktop"
HYPR_CONFIG_DIR = HOME / HYPR / "config"
HYPR_ICONS_DIR = HOME / HYPR / "icons"

CONFIG_DIR = HOME / ".config"
ICONS_DIR = HOME / ".icons"
LOCAL_SHARE_DIR = HOME / ".local/share"

print(HYPR_CONFIG_DIR)
print(HYPR_ICONS_DIR)
print(CONFIG_DIR)


link_parts= [
    {
        "src": HYPR_CONFIG_DIR,
        "dst": HOME,
        "ones": [
            "zsh-functions",
            "zsh-bindings"
        ],
        "pairs": [
            ("zshrc", ".zshrc"),
        ]
    },
    {
        "src": HYPR_CONFIG_DIR,
        "dst": CONFIG_DIR,
        "ones": [
            "hypr",
            "dunst",
            "wlogout",
            "waybar",
            "eww",
            "bottom",
            "btop",
            "yazi",
            "rofi",
            "Kvantum",
            "kitty",
            "lsd",
            "atuin",
            "neofetch",
            "zathura",
            "qutebrowser/config.py",
            "mpv",
            "mimeapps.list"
        ],
        "pairs": []
    },
    {
        "src": HYPR_ICONS_DIR,
        "dst": ICONS_DIR,
        "ones": [
            "desktop",
            "notify"
        ],
        "pairs": []
    },
    {
        "src": HYPR,
        "dst": LOCAL_SHARE_DIR,
        "ones": [
        ],
        "pairs": [
            ("config/qutebrowser/sessions", "qutebrowser/sessions"),
            ("desktop", "applications")
        ]
    }
]
