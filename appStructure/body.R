nearbyAirportsTab <- tabItem(
  tabName = "nearbyAirports",
  fluidRow(
    box(
      width = 12,
      title = "API Usage",
      status = "primary",
      solidHeader = TRUE,
      userPost(
        id = 1,
        image = "img/dp.jpg",
        author = "George Mwangi N.",
        description = "Shared publicly - 29th December, 2023",
        "You can use this Interface to know the nearest departure airport or all available airports within a given radius at a click of a button"
      )
    ),
    box(
      width = 12,
      height = 500,
      title = "Airports",
      maximizable = TRUE,
      solidHeader = TRUE,
      status = "primary",
      sidebar = boxSidebar(
        startOpen = FALSE,
        id = "nearbyAirportsSidebar",
        width = 25,
        background = "#00436B"
      ),
      dropdownMenu = boxDropdown(
        fluidRow(downloadButton("downloadNearbyAirportsData", "Download", style = "background-color: #007FFF; width: 80%; padding: 0px; border-radius: 5px; margin: auto;"))
      ),
      nearbyAirportsAndCitiesUi("nearbyAirportsTable")
    )
  )
)

nearbyCitiesTab <- tabItem(
  tabName = "nearbyCities",
  fluidRow(
    box(
      title = "Cities",
      width = 12,
      height = 500,
      maximizable = TRUE,
      solidHeader = TRUE,
      status = "primary",
      sidebar = boxSidebar(
        startOpen = FALSE,
        id = "nearbyCitiesSidebar",
        width = 25,
        background = "#00436B"
      ),
      dropdownMenu = boxDropdown(
        fluidRow(downloadButton("downloadNearbyCitiesData", "Download", style = "background-color: #007FFF; width: 80%; padding: 0px; border-radius: 5px; margin: auto;"))
      ),
      nearbyAirportsAndCitiesUi("nearbyCitiesTable")
    )
  )
)


body <- bs4DashBody(
  tabItems(
    nearbyAirportsTab, nearbyCitiesTab
  )
)
