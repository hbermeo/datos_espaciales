addLegendCustom <-  function(map, colors, labels, sizes, opacity = 0.5){
  colorAdditions <- paste0(colors, "; border-radius: 50%; width:", sizes, "px; height:", sizes, "px")
  labelAdditions <- paste0("<div style='display: inline-block;height: ", 
                           sizes, "px;margin-top: 4px;line-height: ", sizes, "px;'>", 
                           labels, "</div>")
  return(addLegend(map, colors = colorAdditions, 
                   labels = labelAdditions, opacity = opacity,
                   position = "bottomleft"))
}
