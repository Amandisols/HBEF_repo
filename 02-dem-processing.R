library(sf)
library(terra)
library(whitebox)
whitebox::wbt_init()


#Processing DEM for hydrologic analysis using WhiteBox tools.

#Input
# * DEM
# * Watershed boundaries

#Output
# * Watershed 3 DEM -raw
# * Filled 




# fill single cell pits




# feature preserving smoothing

# breach larger landscape depressions







# Create flow accumulation rasters via d8-flow accumulation and multiple direction flow accumulation.
# 
# Create a flow network using multiple (where a stream would likely be).
# 
# Delineate subwatersheds
# 
# Calculate topographic indices and topogrpahic metrics.

Then we will extract metrics from subwatersheds and export as a csv file.