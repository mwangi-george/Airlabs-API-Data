sidebar <- dashboardSidebar(
  fixed = TRUE,
  skin = "light",
  status = "primary",
  id = "sidebar",
  customArea = fluidRow(
    actionButton(
      inputId = "myAppButton",
      label = NULL,
      icon = icon("users"),
      width = NULL,
      status = "primary",
      style = "margin: auto",
      dashboardBadge(textOutput("btnVal"), color = "danger")
    )
  ),
  sidebarMenu(
    id = "sidabar",
    flat = FALSE,
    compact = FALSE,
    childIndent = TRUE,
    menuItem("Nearby Airports", tabName = "nearbyAirports", icon = icon("plane-departure")),
    menuItem("Nearby Cities", tabName = "nearbyCities", icon = icon("city")),
    hr(),
    p("API Inputs", align = "center"),
    numericInputIcon(
      "nearbyLatitude",
      label = "Enter the Latitude of your location (e.g., 40.7128)", max = 90, min = -90, value = -1.2841,
      icon = icon("map-pin"),
      help_text = "Latitude ranges from –90° at the south pole to 90° at the north pole, with 0° at the Equator."
    ),
    numericInputIcon(
      "nearbyLongitude",
      label = "Enter the Longitude of your location (e.g., -74.0060)", max = 180, min = -180, value = 36.8155,
      icon = icon("map-pin"),
      help_text = "Longitude ranges from 0° at the Prime Meridian to +180° eastward and −180° westward."
    ),
    numericInputIcon(
      "nearbyDistance",
      label = "Enter Distance from your Geo location in km", max = 12742, min = 0, value = 150,
      icon = icon("route"),
      help_text = "Distance cannot be negative or greater than the diameter of the earth"
    ),
    actionBttn(
      "getNearbyLocationsDataButton",
      label = "Get Data",
      icon = icon("circle-down")
    )
  )
)
