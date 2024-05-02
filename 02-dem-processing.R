library(sf)
library(terra)
library(whitebox)
whitebox::wbt_init()

#Clip the DEM.. it was too big in its natural form
#Is there a way to save to a temporary location? for intermediate steps

#Processing DEM for hydrologic analysis using WhiteBox tools.

#Input
# * DEM
# * Watershed boundaries

#Output
# * Watershed 3 DEM -raw
# * Filled 



# hb_dem <- rast("~/projects/DSS/HBEF/data/GIS/grids/dem1m.tif")
# plot(hb_dem)
# 
# ws3 <- vect("vectors/ws3.shp")
# ws3_100 <- buffer(ws3, 100)

ws3_dem <- crop(hb_dem, ws3_100)
writeRaster(ws3_dem, filename = 'rasters/dem1m_ws3.tif', overwrite = TRUE)

#hb_dem <- rast("~/projects/DSS/HBEF/data/GIS/grids/dem/hydem1mlpns.tif")


# difference <- ws3_dem - hyws3_dem
# 
# library(tmap)
# 
# difference[difference == 0] <- NA
# 
# wbt_hillshade(dem = "rasters/dem1m_ws3.tif",
#               output = "rasters/hillsh1m_ws3.tif",
#               azimuth = 115)
# 
# hillshade <- rast("rasters/hillsh1m_ws3.tif")
# 
# plot(hillshade)
# 
# tm_shape(hillshade)+
#   tm_raster(style = "cont",palette = "-Greys", legend.show = FALSE)+
#   tm_scale_bar()+
#   tm_shape(difference)+
#   tm_raster(style = "cont",legend.show = TRUE)+
#   tm_scale_bar()

# breach and fill depressions

wbt_breach_depressions_least_cost(
  dem = "rasters/dem1m_ws3.tif",
  output = "rasters/ws3_breached.tif",
  dist = 3,
  fill = TRUE)


wbt_fill_depressions_wang_and_liu(
  dem = "rasters/ws3_breached.tif",
  output = "rasters/ws3_breachfilled.tif"
)


# feature preserving smoothing
wbt_feature_preserving_smoothing("rasters/ws3_breachfilled.tif", 
                                 "rasters/ws3_breachfillsmooth.tif", 
                                 filter = 1, norm_diff = 15, num_iter = 10, verbose_mode = TRUE)



# breach larger landscape depressions



#Compare difference between the one olivia made and the one I make. How does it affect other things?



# Create flow accumulation rasters via d8-flow accumulation and multiple direction flow accumulation.
# 
# Create a flow network using multiple (where a stream would likely be).
# 
# Delineate subwatersheds
# 
# Calculate topographic indices and topogrpahic metrics.

Then we will extract metrics from subwatersheds and export as a csv file.