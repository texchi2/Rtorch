#!/usr/bin/env python3
# using hash bang to execute $ python3 merge_tiles.py
# run python under R reticulate package
# merge by pyvips =>
#*** pip3 install pyvips
#*** sudo apt install libvips

#merge_tiles.py
# goal:
# TH2113193-Region 001.tif, TH2113193-Region 002.tif => TH2113193_HE.tif

# a list in python: https://www.askpython.com/python/list/iterate-through-list-in-python
import pyvips
import os
files = os.listdir('/mnt/c/Users/User/Documents/TissueFAXS_OVH2022/TMUH2017/OVH_TMUH_2017_WSI_CK13_Box1246/') #insert folder path

structured_files = {}
for file in files:
#    name, date, sample, environment = file.split('_')
    re.split("- ", file)
    structured_files.append({'TH_id':name, 'Region':region, 'Number':number})
    
        # tiles = [pyvips.Image.new_from_file(f"{x}_{y}.jpeg", access="sequential")
#                 for y in range(height) for x in range(width)] 
# string process https://stackoverflow.com/questions/71214436/how-to-extract-data-from-a-filename-in-python-convert-file-name-to-string

TH_id = "TH2123220"  #"TH2113193"
regions = ["008", "009", "010", "012"] #, "005", "006"]


tiles = [pyvips.Image.new_from_file(f"{TH_id}-Region {y}.tif", access="sequential") for y in regions] 
print([f"{TH_id}-Region {y}.tif" for y in regions])  

# HE, CK13
image = pyvips.Image.arrayjoin(tiles, across= len(regions), background=255) # white
image.write_to_file(f"../{TH_id}_CK13.tif", compression="deflate", tile=True)
#"jpeg", tile=True)
# lzw or deflate by Adobe

#TIFF (Tagged Image File Format) is a file format for storing images. TIFF files support multiple "pages" or images as well as a variety of storage formats and compression methods. One of these storage formats is called the Tiled TIFF storage format.

#A Tiled TIFF image is composed of many square tiles of the same size (typically 256×256 pixels). The advantage of the tiled format is that extremely large images can be loaded and displayed efficiently by loading only those tiles that are absolutely necessary (rather than loading a single, large (huge), monolithic image).
#An SVS file is a Tiled TIFF image that has a few additional pages (images) that include the slide label, overview image, and a few smaller, scaled copies of the scanned slide.
#We use the term Whole Scan Image to indicate any image format that contains a Region of Interest (ROI) scanned from a microscope slide. 


# Use compression to set the tiff compression. Currently jpeg, packbits, fax4, lzw, none, deflate, webp and zstd are supported. The default is no compression. JPEG compression is a good lossy compressor for photographs, packbits is good for 1-bit images, and deflate is the best lossless compression TIFF can do.

