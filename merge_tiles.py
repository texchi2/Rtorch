#!/usr/bin/env python3
# using hash bang to execute $ python3 merge_tiles.py

# merge by pyvips =>
#*** pip3 install pyvips
#*** sudo apt install libvips

#merge_tiles.py
# goal:
# TH2113193-Region 001.tif, TH2113193-Region 002.tif => TH2113193_HE.tif

# a list in python: https://www.askpython.com/python/list/iterate-through-list-in-python
import pyvips

        # tiles = [pyvips.Image.new_from_file(f"{x}_{y}.jpeg", access="sequential")
#                 for y in range(height) for x in range(width)] 

TH_id = "TH2123220"  #"TH2113193"
regions = ["008", "009", "010", "012"] #, "005", "006"]


tiles = [pyvips.Image.new_from_file(f"{TH_id}-Region {y}.tif", access="sequential") for y in regions] 
print([f"{TH_id}-Region {y}.tif" for y in regions])  

image = pyvips.Image.arrayjoin(tiles, across= len(regions), background=255) # white
image.write_to_file(f"../{TH_id}_HE.tif", compression="deflate", tile=True)
#"jpeg", tile=True)
# lzw or deflate by Adobe

#TIFF (Tagged Image File Format) is a file format for storing images. TIFF files support multiple "pages" or images as well as a variety of storage formats and compression methods. One of these storage formats is called the Tiled TIFF storage format.

#A Tiled TIFF image is composed of many square tiles of the same size (typically 256×256 pixels). The advantage of the tiled format is that extremely large images can be loaded and displayed efficiently by loading only those tiles that are absolutely necessary (rather than loading a single, large (huge), monolithic image).
#An SVS file is a Tiled TIFF image that has a few additional pages (images) that include the slide label, overview image, and a few smaller, scaled copies of the scanned slide.
#We use the term Whole Scan Image to indicate any image format that contains a Region of Interest (ROI) scanned from a microscope slide. 


# Use compression to set the tiff compression. Currently jpeg, packbits, fax4, lzw, none, deflate, webp and zstd are supported. The default is no compression. JPEG compression is a good lossy compressor for photographs, packbits is good for 1-bit images, and deflate is the best lossless compression TIFF can do.

