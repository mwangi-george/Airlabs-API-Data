pacman::p_load(
  bs4Dash, tidyverse, janitor, shiny, waiter, shinycssloaders, shinyWidgets, gt, httr, jsonlite
)

# Modules
modules <- str_c("modules/", list.files("modules/"), sep = "")
map(modules, ~ source(.x))


# App files
appFiles <- str_c("appStructure/", list.files("appStructure/"), sep = "")
map(appFiles, ~ source(.x))

ui <- bs4DashPage(
  header, sidebar, body, controlbar, footer,
  skin = "light"
)

server <- function(input, output, session) {
  observeEvent(input$getNearbyLocationsDataButton, {
    nearbyAirportsAndCitiesServer(
      "nearbyAirportsTable",
      userLatitude = input$nearbyLatitude,
      userLongitude = input$nearbyLongitude,
      userDistance = input$nearbyDistance,
      triggerId = input$getNearbyLocationsDataButton,
      requiredOutput = "airports"
    )

    nearbyAirportsAndCitiesServer(
      "nearbyCitiesTable",
      userLatitude = input$nearbyLatitude,
      userLongitude = input$nearbyLongitude,
      userDistance = input$nearbyDistance,
      triggerId = input$getNearbyLocationsDataButton,
      requiredOutput = "cities"
    )
  })
}

shinyApp(ui, server)
