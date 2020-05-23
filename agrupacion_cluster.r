# Preparación de la data --------------------------------------------------
data("quakes")

quakes <- quakes %>%
  dplyr::mutate(mag.level = cut(mag,c(3,4,5,6),
                                labels = c('>3 & <=4', 
                                           '>4 & <=5', 
                                           '>5 & <=6')))

# Dividir el data frame ---------------------------------------------------
quakes.df <- split(quakes, quakes$mag.level)

l <- leaflet() %>% addTiles()

l

# Agrupación y cluster por función ----------------------------------------
names(quakes.df) %>% 
  purrr::walk( function(df) {
    l <<- l %>%
      addMarkers(data=quakes.df[[df]],
                 lng=~long, lat=~lat,
                 label=~as.character(mag),
                 popup=~as.character(mag),
                 group = df,
                 clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                 labelOptions = labelOptions(noHide = F,
                                             direction = 'auto',))
  })


# Agregando control de layers ---------------------------------------------
l %>%
  addLayersControl(
    overlayGroups = names(quakes.df),
    options = layersControlOptions(collapsed = FALSE)
  )
