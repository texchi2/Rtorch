
##### %%%%%% Forensic Medicine
#one of libraries that could be used to find master degree of forensic medicine in the world. However, you can use websites like FindAMasters.com ¹ to search for master's degree programs in forensic medicine.
#  FindAMasters Degree Worldwide. https://www.findamasters.com/masters-degrees/course/msc-forensic-medical-sciences/?i194d4804c14215
#As for generating a map using R code, you can use the `mapview` package which provides functions to very quickly and conveniently create interactive visualizations of spatial data ⁵⁶. Here is an example of how you can use the `mapview` package to generate a map:


#```r
# Load necessary libraries
library(sf)
library(mapview)

# Create a data frame with the coordinates of the universities
universities <- data.frame(
  name = c("Queen Mary University of London", "Monash University"),
  lat = c(51.5246, -37.9105),
  lon = c(-0.0393, 145.1340)
)

# Convert data frame to an sf object
universities_sf <- st_as_sf(universities, coords = c("lon", "lat"), crs = 4326)

# Plot the map using mapview
mapview(universities_sf, zcol = "name")
#```

#This code creates a data frame with the coordinates of two universities that offer master's degree programs in forensic medicine: Queen Mary University of London ¹ and Monash University ². The data frame is then converted to an `sf` object and plotted using the `mapview` function.

#Source: Conversation with Bing, 02/05/2023
#(1) MSc Forensic Medical Sciences - FindAMasters Degree Worldwide. https://www.findamasters.com/masters-degrees/course/msc-forensic-medical-sciences/?i194d4804c14215 Accessed 02/05/2023.
#(2) 4 mapview | Making Maps with R - Bookdown. https://bookdown.org/nicohahn/making_maps_with_r5/docs/mapview.html Accessed 02/05/2023.
#(3) mapview package - RDocumentation. https://www.rdocumentation.org/packages/mapview/versions/2.11.0 Accessed 02/05/2023.
#(4)*** Master of Forensic Medicine - Study at Monash University. https://www.monash.edu/study/courses/find-a-course/forensic-medicine-m6009 Accessed 02/05/2023.
#(5) Forensic Medical Sciences MSc - Queen Mary University of London. https://www.qmul.ac.uk/postgraduate/taught/coursefinder/courses/forensic-medical-sciences-msc/ Accessed 02/05/2023.
#(6) Forensic Medicine (MS) - University of Maryland Graduate School. https://graduate.umaryland.edu/forensicmedicine/ Accessed 02/05/2023.
#(7) Interactive Viewing of Spatial Data in R • mapview. https://r-spatial.github.io/mapview/ Accessed 02/05/2023.
