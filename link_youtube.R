library(sf)
library(leaflet)
library(dplyr)
library(leafem)
library(htmltools)

### Cargar datos
cantones = st_read("C:\\Curso Leaflete Rstudio\\Proyecto\\datos_espaciales\\cantones.geojson")
cantones = st_transform(cantones, 4326)

b_cantones = st_bbox(cantones)
centro = st_centroid((st_geometry(cantones)))

### Cargar imagen
img = "https://github.com/hbermeo/datos_espaciales/raw/master/Presentacion_Curso.jpg"
#img2 = "https://github.com/hbermeo/datos_espaciales/raw/master/Sig.jpg"


### Lista de Videos
videos = list(
  "https://www.youtube.com/embed/oYDbletjb7o?autoplay=1",
  "https://www.youtube.com/embed/ngCxSsOmsXQ?autoplay=1",
  "https://www.youtube.com/embed/WPG8KGtXbss?autoplay=1",
  "https://www.youtube.com/embed/urMuG16-jNQ?autoplay=1"
)

### Lista de videos para leaflet
videos_y = list(
  '<iframe width="350" height="250" src="https://www.youtube.com/embed/zEwRZ27AcOY?autoplay=1" allow="autoplay; encrypted-media" allowfullscreen></iframe>',
  '<iframe width="350" height="250" src="https://www.youtube.com/embed/ngCxSsOmsXQ?autoplay=1" allow="autoplay; encrypted-media" allowfullscreen></iframe>',
  '<iframe width="350" height="250" src="https://www.youtube.com/embed/WPG8KGtXbss?autoplay=1" allow="autoplay; encrypted-media" allowfullscreen></iframe>',
  '<iframe width="350" height="250" src="https://www.youtube.com/embed/urMuG16-jNQ?autoplay=1" allow="autoplay; encrypted-media" allowfullscreen></iframe>'
)

#popup_v = lapply(videos, leafpop:::popupIframe, )

### Mapa con videos en leaflet
leaflet() %>% addProviderTiles(provider = providers$Stamen.TonerLite)%>%
  addPolygons(data = cantones,
              popup = videos_y,
              popupOptions = popupOptions(maxWidth = 350)) %>%
  addHomeButton(ext = b_cantones, "Cantones") %>% 
  addLogo(img, src = "remote", width = 200, height = 100) %>% 
  addMouseCoordinates() %>%
  addCircleMarkers(data = centro, fillColor = "red", radius = 15) %>%
  addControl(html = HTML("<h2><a href='https://www.udemy.com/course/creacion-de-mapas-web-con-leaflet-y-rstudio/?couponCode=CBABD8AF5E04B1F38BD6'> Curso desde Cero leaflet en R</a></h2>"),
             position = "topright" )

