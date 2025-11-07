import sys
import tomllib
from pathlib import Path


VERBOSE = True
DRY_RUN = False

ignore_patterns = []

dotconf_name = "dotc.toml"
dotignore_name = ".dotignore"


class Ignored:
    def __init__(self, patterns_global=[], patterns_local=[], files=False, dirs=False) -> None:
        self.ignored_patterns_global = ["dotc.toml", ".dotignore"] + patterns_global
        self.ignored_patterns_local = patterns_local + self.ignored_patterns_global
        self.ignore_files = files
        self.ignore_dirs = dirs


def create_path_and_symlink(target_path: Path, link_path: Path, overwrite: bool = False) -> bool:
    try:
        # Создаем директорию для целевого файла, если не существует
        target_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Создаем сам файл, если не существует
        if not target_path.exists():
            target_path.touch()
            print(f"Создан файл: {target_path}")
        
        # Проверяем существование симлинка
        if link_path.exists() or link_path.is_symlink():
            if overwrite:
                # Удаляем существующий симлинк/файл
                if link_path.is_symlink() or link_path.is_file():
                    link_path.unlink()
                    print(f"Удален существующий симлинк: {link_path}")
                else:
                    print(f"Ошибка: {link_path} существует и не является файлом/симлинком")
                    return False
            else:
                print(f"Симлинк уже существует: {link_path}")
                return False
        
        # Создаем симлинк
        link_path.symlink_to(target_path)
        print(f"Создан симлинк: {link_path} -> {target_path}")
        return True
        
    except Exception as e:
        print(f"Ошибка: {e}")
        return False


def check_dots(path):
    is_dotconf = False
    is_dotignore = False

    if (path / dotconf_name).is_file():
        is_dotconf = True
    if (path / dotignore_name).is_file():
        is_dotignore = True

    return is_dotconf, is_dotignore


def load_toml_file(filepath):
    with open(filepath, "rb") as f:
        config = tomllib.load(f)
    
    return config


def load_ignore_file(filepath):
    ignored = {}
    group = None

    with open(filepath, "r") as f:
        ignore_lines = f.readlines()

        for i, line in enumerate(ignore_lines):
            line = line.strip()
            if line.startswith("#"):
                continue
            elif line.startswith("-"):
                if group is None:
                    if VERBOSE:
                        print(f"[WARN]: Unrecognized ignore elemnt position in file \"{filepath}\" line {i + 1}")
                    continue
                ignored[group].append(line[1:].strip())
            elif bool(line):
                group = line[:-1].strip()
                if group not in ignored.keys():
                    ignored[group] = []
            else:
                group = None
    
    return ignored


def parse_ignore_data(data):
    globals = []
    local = []
    files = False
    dirs = False
    if "global" in data.keys():
        globals = data["global"]
    if "local" in data.keys():
        local = data["local"]
    if "flags" in data.keys():
        for flag in data["flags"]:
            match flag:
                case "files":
                    files = True
                case "dirs":
                    dirs = True
    
    return Ignored(globals, local, files, dirs)


def process_folder(folderpath, target_path, global_ignores=[]):
    is_conf, is_ignore = check_dots(folderpath)
    
    ignored = Ignored(patterns_global=global_ignores)
    link_rules = {}

    if is_ignore:
        ignored_local_fmts = load_ignore_file(folderpath / dotignore_name)
        ignored = parse_ignore_data(ignored_local_fmts)
    if is_conf:
        local_conf = load_toml_file(folderpath / dotconf_name)
        if "linkrules" in local_conf.keys():
            for key in local_conf["linkrules"]:
                link_rules[local_conf["linkrules"][key]["source"]] = target_path / local_conf["linkrules"][key]["target"]

    childrens = list(folderpath.iterdir())
    
    for children in childrens:
        if children.is_file() and ignored.ignore_files:
            continue
        if children.is_dir() and ignored.ignore_dirs:
            continue
        if children.name.startswith("."):
            continue
        
        ignore_flag = False
        for file_fmt in ignored.ignored_patterns_local:
            if children.match(folderpath / file_fmt):
                ignore_flag = True
                break
        if ignore_flag:
            continue
        
        if children.name in link_rules.keys():
            target = link_rules[children.name]
        else:
            target = target_path / children.name

        if children.is_dir():
            process_folder(children, target, ignored.ignored_patterns_global)
        else:
            if DRY_RUN:
                print("Symlink:", children, target)
            else:
                create_path_and_symlink(target, children, True)
                if VERBOSE:
                    print("[INFO]: Created symlink:", children, target)


def main(confpath):
    config = load_toml_file(confpath)
    
    root = Path(config["settings"]["dotdir"]).expanduser()
    target = Path.home()
    
    if not root.is_dir():
        print(f"[ERROR]: Dot directory \"{root}\" does not exist.")
        sys.exit(1)
    
    process_folder(root, target)


if __name__ == "__main__":
    main("dotc.toml")
