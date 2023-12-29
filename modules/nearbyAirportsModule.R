# nearbyAirportsUi <- function(id){
#   ns <- NS(id)
#   
#   tagList(
#     gt_output(ns("nearbyAirportsTable")) %>% withSpinner(type = 4, size = .5)
#   )
# }
# 
# 
# nearbyAirportsAndCitiesServer <- function(id, userLatitude, userLongitude, userDistance, triggerId){
#   moduleServer(id, function(input, output, session){
#     
#     citiesDf <- reactiveVal()
#     
#     nearbyAirportsDf <- eventReactive(triggerId, {
#       
#       apiBase <- 'https://airlabs.co/api/v9/nearby'
#       apiKey <- Sys.getenv("airLabsApiKey")
#       
#       nearbyAPI <- str_c(
#         apiBase, "?lat=", userLatitude, "&lng=", userLongitude, "&distance=", userDistance, "&api_key=", apiKey
#       )
#       
#       apiResultsList <- GET(nearbyAPI) %>% 
#         content(as = "text", encoding = "UTF-8") %>% 
#         fromJSON()
#       
#       cities <- as_tibble(apiResultsList$response$cities)
#       citiesDf(cities)
#       
#       airports <- apiResultsList$response$airports
#       return(airports)
#     })
#     
#     
#     output$nearbyAirportsTable <- render_gt({
#       nearbyAirportsDf() %>% 
#         relocate(country_code) %>% 
#         arrange(desc(popularity)) %>% 
#         rename(
#           `Airport Name` = name,
#           `IATA Code` = iata_code,
#           `ICAO Code` = icao_code,
#           `Country Code` = country_code,
#           Latitude = lat, 
#           Longitude = lng,
#           Popularity = popularity,
#           Distance = distance
#         ) %>% 
#         gt() %>% 
#         tab_header(
#           title = "Airports near you",
#           subtitle = str_c("Showing Airports within a", userDistance, "km range from your location", sep = " ")
#         ) %>%
#         opt_stylize(style = 6) %>% 
#         tab_options(
#           table.width = pct(100),
#           heading.background.color = "#00436B",
#           container.overflow.y = TRUE,
#           container.overflow.x = TRUE
#         ) %>% 
#         fmt_flag(columns = `Country Code`) %>% 
#         cols_label(`Country Code` = "")
#     })
#     
#     output$nearbyCitiesTable <- render_gt({
#       citiesDf() %>% 
#         relocate(country_code) %>% 
#         arrange(desc(popularity)) %>% 
#         rename(
#           `Airport Name` = name,
#           `Country Code` = country_code,
#           Latitude = lat, 
#           Longitude = lng,
#           Popularity = popularity,
#           Distance = distance
#         ) %>% 
#         gt() %>% 
#         tab_header(
#           title = "Cities near you",
#           subtitle = str_c("Showing Cities within a", userDistance, "km range from your location", sep = " ")
#         ) %>%
#         opt_stylize(style = 6) %>% 
#         tab_options(
#           table.width = pct(100),
#           heading.background.color = "#00436B",
#           container.overflow.y = TRUE,
#           container.overflow.x = TRUE
#         ) %>% 
#         fmt_flag(columns = `Country Code`) %>% 
#         cols_label(`Country Code` = "")
#     })
#     
#   })
# }
