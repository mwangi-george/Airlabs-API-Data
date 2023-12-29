nearbyAirportsAndCitiesUi <- function(id) {
  ns <- NS(id)
  tagList(
    gt_output(ns("nearbyCitiesOrAirportsTable")) %>% withSpinner(type = 4, size = .5)
  )
}




nearbyAirportsAndCitiesServer <- function(id, userLatitude, userLongitude, userDistance, triggerId, requiredOutput) {
  moduleServer(id, function(input, output, session) {
    df <- eventReactive(triggerId, {
      apiBase <- "https://airlabs.co/api/v9/nearby"
      apiKey <- "8112ce34-bcbf-4246-9dac-8fa34dd14f3a"

      nearbyAPI <- str_c(
        apiBase, "?lat=", userLatitude, "&lng=", userLongitude, "&distance=", userDistance, "&api_key=", apiKey
      )

      apiResultsList <- GET(nearbyAPI) %>%
        content(as = "text", encoding = "UTF-8") %>%
        fromJSON()

      if (requiredOutput == "cities") {
        citiesDf <- apiResultsList$response$cities %>% 
          relocate(country_code) %>%
          arrange(desc(popularity)) %>%
          rename(
            `Airport Name` = name,
            `Country Code` = country_code,
            Latitude = lat,
            Longitude = lng,
            Popularity = popularity,
            Distance = distance
          )
        
        return(citiesDf)
      } else {
        airportsDf <- apiResultsList$response$airports %>% 
          relocate(country_code) %>%
          arrange(desc(popularity)) %>%
          rename(
            `Airport Name` = name,
            `IATA Code` = iata_code,
            `ICAO Code` = icao_code,
            `Country Code` = country_code,
            Latitude = lat,
            Longitude = lng,
            Popularity = popularity,
            Distance = distance
          )
        
        return(airportsDf)
      }
    })
    
    if (requiredOutput == "cities") {
      output$nearbyCitiesOrAirportsTable <- render_gt({
        output$downloadNearbyCitiesData <- downloadHandler(
          filename = function() {
            paste("Cities-Data-", Sys.time(), ".csv", sep = "")
          },
          content = function(file) {
            write.csv(df(), file)
          }
        )
        
        df() %>%
          gt() %>%
          tab_header(
            title = "",
            subtitle = str_c("Showing Cities within a", userDistance, "km range from your Geo location ordered by City's Popularity", sep = " ")
          ) %>%
          opt_stylize(style = 6, color = "pink") %>%
          tab_options(
            table.width = pct(100),
            heading.background.color = "white",
            container.overflow.y = TRUE,
            container.overflow.x = TRUE
          ) %>%
          fmt_flag(columns = `Country Code`) %>%
          cols_label(`Country Code` = "")
      })
    } else {
      output$nearbyCitiesOrAirportsTable <- render_gt({
        output$downloadNearbyAirportsData <- downloadHandler(
          filename = function() {
            paste("Airports-Data-", Sys.time(), ".csv", sep = "")
          },
          content = function(file) {
            write.csv(df(), file)
          }
        )
        
        df() %>%
          gt() %>%
          tab_header(
            title = "",
            subtitle = str_c("Showing Airports within a", userDistance, "km range from your Geo location ordered by Airport's Popularity", sep = " ")
          ) %>%
          opt_stylize(style = 6, color = "pink") %>%
          tab_options(
            table.width = pct(100),
            heading.background.color = "white",
            container.overflow.y = TRUE,
            container.overflow.x = TRUE
          ) %>%
          fmt_flag(columns = `Country Code`) %>%
          cols_label(`Country Code` = "")
      })
    }
  })
}
