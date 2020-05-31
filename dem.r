###### Creación de MDT MDE
library(raster)
library(sp)
library(sf)
library(gstat)
library(rasterVis)

### Leer datos
setwd("su carpeta de trabajo")

altimetria = st_read("altimetria_corte.shp")
area_estudio = st_read("study_area.shp")

## Plotear datos
plot(altimetria, reset = FALSE, col = "black")

## Crear raster en blanco
dem_b = raster(ext = extent(altimetria),
               crs = projection(as(altimetria, "Spatial")),
               resolution = 5)

dem_b

## Convertir altimetria en puntos
dem_puntos = as(as(altimetria, "Spatial"), "SpatialPointsDataFrame")

## Interpolar 
dem_interp = gstat(formula = ALT ~ 1,
                   locations = dem_puntos,
                   set = list(idp = 2),
                   nmax = 5)

## obteniendo valores de la interpolación
DEM = interpolate(dem_b, dem_interp)

### plot
plot(DEM, col = terrain.colors(20), reset= F)

## lineas contorno 20 m 
cont_20 = altimetria[(altimetria$ALT) %in% 
                        seq(min(altimetria$ALT), 
                            max(altimetria$ALT), 
                            20), ]

plot(cont_20, add = T, col = "black")

## ploteo 3D
plot3D(DEM)
