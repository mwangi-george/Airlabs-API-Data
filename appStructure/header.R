header <- dashboardHeader(
  status = "#007FFF",
  # skin = "light",
  fixed = TRUE,
  div(
    h3(
      a("Explore the NearBy AirLabs API", href = "https://airlabs.co/docs/nearby", target = "_blank")
    )
  ),
  title = dashboardBrand(
    title = h4(strong("Airlabs API Data"), style = "font-size: 16px;"),
    color = "primary",
    href = "https://github.com/mwangi-george",
    image = "img/flight_1.jpg",
    opacity = 1
  )
)
