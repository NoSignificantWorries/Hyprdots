#!/usr/bin/python3

import json
import re
import pathlib


TEMPLATE_CONFIG_NAME = "template-configs"
TEMPLATE_JSON_NAME = "template-jsons"
TEMPLATE_JSON_MODULES = "template-jsons-modules"
TEMPLATE_MAIN_JSON = "template-main-json"

INCLUDE = "$include"
VARS = "VARS"


def expend_path(path):
    path = pathlib.Path(path)
    return pathlib.Path(path.expanduser())


def open_json(file):
    with open(file, "r") as json_file:
        return json.load(json_file)


def parse_jsons(data, vars_global, current_dir):
    if isinstance(data, dict):
        if VARS in data.keys():
            vars_global.update(data[VARS])
            del data[VARS]
            _, vars_global = parse_jsons(vars_global, vars_global, current_dir)
        if INCLUDE in data.keys():
            include_path = data[INCLUDE]
            include_file = current_dir.joinpath(*include_path)
            include_dir = current_dir.joinpath(*include_path[:-1])
            
            include_data = open_json(include_file)
            parsed_vars, parsed_data = parse_jsons(include_data, vars_global, include_dir)
            data.update(parsed_data)
            vars_global.update(parsed_vars)
            del data[INCLUDE]

        for key in data.keys():
            if isinstance(data[key], dict):
               parsed_vars, parsed_data = parse_jsons(data[key], vars_global, current_dir)
               data[key] = parsed_data
               vars_global.update(parsed_vars)
    
    return vars_global, data
    

class TemplateWorker:
    def __init__(self, pathes) -> None:
        self.pathes = pathes
        self.global_json = None
    
    def open_jsons(self):
        current_dir = self.pathes[TEMPLATE_JSON_NAME]
        
        base_json = open_json(self.pathes[TEMPLATE_MAIN_JSON])
        parsed_vars, parsed_data = parse_jsons(base_json, {}, current_dir)
        parsed_data["VARS"] = parsed_vars

        self.global_json = parsed_data

        with open("json_test.jsonc", "w") as file_to_write:
            json.dump(self.global_json, file_to_write, ensure_ascii=False, indent=4)

        
    def run(self):
        self.open_jsons()
        

def compile(pathes):
    worker = TemplateWorker(pathes=pathes)
    
    worker.run()


if __name__ == "__main__":
    TEMPLATES = expend_path("~/Hyprdots/templates")

    pathes = {
        TEMPLATE_CONFIG_NAME: TEMPLATES / "config",
        TEMPLATE_JSON_NAME: TEMPLATES / "json",
        TEMPLATE_JSON_MODULES: TEMPLATES / "json" / "modules",
        TEMPLATE_MAIN_JSON: TEMPLATES / "json" / "system.jsonc"
    }
    compile(pathes)
