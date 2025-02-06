import json
import os
import pycountry
import cairosvg
from pathlib import Path

from typing import Dict


contents_json = {"images": [], "info": {"author": "xcode", "version": 1}}


def get_all_images(path: Path):
    icons = os.listdir(path=path)
    return [create_icon_meta(icon) for icon in icons if len(icon) < 7]


def create_icon_meta(icon: str) -> Dict[str, str]:
    lang = icon.split(".")[0]
    country = pycountry.countries.get(alpha_2=lang.upper())
    if hasattr(country, "name"):
        return {"name": country.name, "lang": lang}
    return None


def main():
    list_icons = get_all_images("./flags")
    for icon in list_icons:
        if not os.path.exists("./pngs"):
            os.mkdir("./pngs")
        if icon is not None:
            create_assets_directory(icon)


def create_assets_directory(icon: Dict[str, str]):
    directory = f"./pngs/{icon['name']}.imageset"
    if not os.path.exists(directory):
        os.mkdir(directory)

    if not os.path.exists(directory + "/Contents.json"):
        create_contents_json(directory, icon['name'])

    if not os.path.exists(directory + f"/{icon['name']}2x.png"):
        create_png_file(directory, icon, 400, 400)
    if not os.path.exists(directory + f"/{icon['name']}3x.png"):
        create_png_file(directory, icon, 600, 600)
        
def create_contents_json(directory: str, country: str):
    with open(directory + "/Contents.json", "w") as file:
        content_json = {"images": [], "info": {"author": "xcode", "version": 1}}
        for i in [1,2,3]:
            if i == 1:
                content_json["images"].append({
                    "idiom": "universal",
                    "scale": "1x"
                })
            else:
                content_json["images"].append({
                    "filename": f"{country}{i}x.png",
                    "idiom": "universal",
                    "scale": f"{i}x"
                })
        file.write(json.dumps(content_json))

def create_png_file(directory: str, icon: Dict[str, str], width: int, height: int):
    input_url = f"./svg/{icon['lang']}.svg"
    output_url = f"{directory}/{icon['name']}{int(width/200)}x.png"
    input_file = open(input_url, "rb")
    output_file = open(output_url, "w+b")
    cairosvg.svg2png(url=input_url, write_to=output_url, output_width=width, output_height=height)
    output_file.close()
    input_file.close()

if __name__ == "__main__":
    main()
        
