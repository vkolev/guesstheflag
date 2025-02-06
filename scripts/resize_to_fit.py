import os
import sys

from PIL import Image

def get_folders(base_folder):
    return [os.path.join(base_folder, path) for path in os.listdir(base_folder) if "imageset" in path]

def get_images(folder):
    return [file for file in os.listdir(folder) if "png" in file]

def resize_image_in_place(folder, image):
    size = (600, 300)
    if "2x" in image:
        size = (400, 200)
    original_image = Image.open(os.path.join(folder, image))
    fitted_image = original_image.resize(size, Image.LANCZOS)
    fitted_image.save(os.path.join(folder, image))

def main():
    base_folder = sys.argv[1]
    if not os.path.isdir(base_folder):
        raise FileNotFoundError(base_folder)

    all_folders = get_folders(base_folder)
    for folder in all_folders:
        images = get_images(folder)
        for image in images:
            resize_image_in_place(folder, image)

if __name__ == "__main__":
    main()