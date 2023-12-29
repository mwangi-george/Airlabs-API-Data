
header <- dashboardHeader(
  status = "#007FFF",
  #skin = "light",
  fixed = TRUE,
  uiOutput("title"),
  title = dashboardBrand(
    title = h4(strong("Airlabs API Data"), style= "font-size: 16px;"),
    color = "primary",
    href = "https://github.com/mwangi-george",
    image = "img/flight_1.jpg",
    opacity = 1
  )
)
