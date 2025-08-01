#!/bin/python

import os
import argparse
from pathlib import Path


def parse_mappings(mapping_file):
    with open(mapping_file, 'r') as f:
        lines = f.readlines()
    
    files_to_link = []
    
    for line in lines:
        line = line.strip()
        line = line.replace("\"", "")
        if not line or line.startswith('#'):
            continue
        
        try:
            src_path, dst_path = line.split(' ')
            src_path = src_path.strip()
            dst_path = dst_path.strip()

            src_path = os.path.expandvars(os.path.join("$HOME", src_path))
            dst_path = os.path.expandvars(os.path.join("$HOME", dst_path))

            if src_path[-1] == '*' and dst_path[-1] == "*":
                src_path = src_path[:-1]
                dst_path = dst_path[:-1]
                
                ignoring = ["linkignore"]
                if "linkignore" in os.listdir(src_path):
                    with open(os.path.join(src_path, "linkignore"), 'r') as ignore:
                        ignoring += ignore.read().split("\n")[:-1]
                
                for file in os.listdir(src_path):
                    if file in ignoring:
                        continue
                    src_file, dst_file = os.path.join(src_path, file), os.path.join(dst_path, file)
                    files_to_link.append((src_file, dst_file))
            elif src_path[-1] == '*' or dst_path[-1] == "*":
                raise ValueError
            else:
                files_to_link.append((src_path, dst_path))
            
        except ValueError:
            print(f"Ошибка в строке: {line} - неверный формат. Ожидается: \"исходный_файл\" \"путь_назначения\" или \"исходная_папка/*\" \"путь_назначения/*\"")
        except Exception as e:
            print(f"Ошибка при обработке {line}: {str(e)}")
    
    return files_to_link


def create_symlinks(mapping_file, dry_run=False):
    """
    Создает симлинки на основе файла с соответствиями исходных файлов и путей назначения.
    
    :param mapping_file: Путь к файлу с соответствиями (формат: исходный_файл|путь_назначения)
    :param dry_run: Если True, только выводит что будет сделано, не создавая симлинки
    """

    lines = parse_mappings(mapping_file)
    
    for src_path, dst_path in lines:
        try:
            if dry_run:
                print(f"DRY RUN: создал бы симлинк: {src_path} -> {dst_path}")
                continue
            
            # Создаем директорию назначения если нужно
            os.makedirs(os.path.dirname(dst_path), exist_ok=True)
            
            # Удаляем существующий файл/симлинк если есть
            if os.path.exists(dst_path) or os.path.islink(dst_path):
                os.remove(dst_path)
            
            # Создаем симлинк
            os.symlink(src_path, dst_path)
            print(f"Создан симлинк: {src_path} -> {dst_path}")
            
        except Exception as e:
            print(f"ERROR: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Создает символические ссылки из файла с соответствиями.')
    parser.add_argument('mapping_file', help='Файл с соответствиями (формат: исходный_файл|путь_назначения)')
    parser.add_argument('--dry-run', action='store_true', help='Только показать что будет сделано, не создавая симлинки')
    
    args = parser.parse_args()
    create_symlinks(args.mapping_file, args.dry_run)

