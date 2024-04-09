library(sf)
library(terra)
library(soilDB)

#Input
# * Latest HPU map: https://doi.org/10.6073/pasta/48cf92d3fb4875ad399ff86f7d8d17d4 (Accessed 2024-04-04).
# * Watershed boundaries

#Output
# * Watershed 3 HPU map
# * Watershed 3 outline
# * Watershed 3 outline with 100m buffer


#Soil maps
#DEM processing (for hydrologic analysis)
#Precipitation
#Water levels & wells
#Soil descriptions and chemistry
#Chemistry (water)


ws <- vect("vectors/hbef_wsheds.shp")

plot(ws)

## crop to watershed of interest, add 100m buffer
ws3 <- ws[ws$WS == "WS3", ]
ws3_100 <- buffer(ws3, 100)


#1- Bh
#2- Bhs
#3- Bimodal
#4- E podzol
#5- Histosol
#6- Inceptisol
#7- O
#8- Typical

soils <- rast("rasters/hpu_hbef-2024.tif")

plot(soils)

## verses mask
ws3_hpu <- crop(soils, ws3_100)
plot(ws3_hpu)
plot(ws3, add = TRUE)


## save 
writeRaster(ws3_hpu, filename = 'rasters/hpu_ws3.tif', overwrite = TRUE)
writeVector(ws3, filename = 'vectors/ws3.shp', overwrite = TRUE)
writeVector(ws3_100, filename = 'vectors/ws3_100m-buffer.shp', overwrite = TRUE)

## SSURGO via SDA
s <- SDA_spatialQuery(ws3_100, what = 'mupolygon', geomIntersection = TRUE)

## transform
s <- project(s, crs(ws3_100))

## SDA errors
if(inherits(s, 'try-error')) {
  stop('SDA returned an error', call. = FALSE)
}


plot(s)





geom(ws3)

