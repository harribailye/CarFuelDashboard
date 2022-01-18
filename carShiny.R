# This file contains a Flow Chart Shiny App for Car Fuel Efficiency 
# Author: Harrison Bailye
# Date: 26/11/2021

## Load in the packages and the data 
pacman::p_load(DiagrammeR, shiny, shinydashboard, tidyverse)
car <- readRDS("2022-01-18-driving.rds")


## Create a flow chart 
diagram <-"digraph {
  graph [overlap = true, rankdir = LR]
  
  node [shape = rectangle, width = 2, height = 1, fontname = futura, fontsize = 16, fontcolor = white, style = filled]  
    rec1 [label = 'Connected \n Data Collector', color = steelblue1]
    rec2 [label = 'Exported \n Data', color = steelblue2]
    rec3 [label = 'Imported \n Data into R', color = steelblue3]
    rec4 [label = 'Cleaned \n the Data',color = steelblue]
    rec5 [label = 'Produced \n Summary Statistics', color = steelblue4]
  
  edge [arrowhead = vee];
  rec1 -> rec2 -> rec3 -> rec4 -> rec5
  }"


# Header for UI
header <- dashboardHeader(title = "My Car Fuel Efficiency")

# Sidebar for UI
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("sitemap")),
    menuItem("Findings", tabName = "findings", icon = icon("chart-line"))
  ))
  
# Body for UI
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "overview",
            
            h2("Overview of the Shiny App"),
          
            box(width = 14, title = "Introduction",
                status = "primary", solidHeader = TRUE,
                "Since purchasing my own car in October 2021, I have been intrigued at the fuel efficiency. 
                  So I decided to measure it and do some exploritory data analysis on the collected data. The
                  aim of the project was to lower the average fuel consumputon of the car by understanding the 
                  optimal way to drive it. Additionally, I wanted to investigate if the claimed average fuel
                  efficiency was accurate or not."),
            
            box(width = 14, title = "Car Details",
                status = "primary", solidHeader = TRUE,
            fluidRow(infoBox("Model", "2008 Subaru Impreza RX Hatchback", icon = icon("car")), 
                     infoBox("Engine", "4 Cylinders, 2.0 Litres", icon = icon("car-battery")),
                     infoBox("Drive Type", "4-Speed Automatic, AWD", icon = icon("car-side"))),
            fluidRow(infoBox("Odometer", "178,300 km", icon = icon("tachometer-alt")), 
                     infoBox("Claimed Average Fuel Efficiency", "8.8 L/100km", icon = icon("gas-pump")),
                     infoBox("Safety Rating", "5 Star", icon = icon("star")))),
      
            box(width = 14, title = "Data Process",
                status = "primary", solidHeader = TRUE,
                "The data was collected using a bluetooth OBD reader device that was connected to the car.
                After a few months of data collection, the data was exported and imported into R. From there,
                basic summary statistics were formulated and plots were constructed. Once this EDA was done,
                more complex predictive models were built for the data.",
            grVizOutput('diagram', width = "100%", height = "200px"))),
    
    tabItem(tabName = "findings",
            
            h2("Data Results"),
            
            
            fluidRow(
              valueBox(value = paste0(round(mean(car$`Fuel effciency`), 2), " L/100km"), subtitle = "Average Fuel Efficiency", width = 3, icon = icon("gas-pump")),
              valueBox(value =  paste0(round(mean(car$`Avr. Speed`), 2), " km/hr"), subtitle = "Average Speed", width = 3, icon = icon("stopwatch")),
              valueBox(value = paste0(round(mean(car$`Distance`), 2), " km"), subtitle = "Average Distance Travelled", width = 3, icon = icon("road")),
              valueBox(value = paste0(round(mean(car$`Avr. RPM`), 2), " rpm"), subtitle = "Average RPM", width = 3, icon = icon("tachometer-alt"))),
            fluidRow(
              box(title = "A Plot of Fuel Efficiency", plotOutput("hist", height = 300)),
              box(title = "Interactive Controls", sliderInput("range", "Driving Time", min = 0, max = 100, value = 50))
            ))))



## UI
ui <- dashboardPage(header, sidebar, body)

## Server
server <- function(input, output, session) { 
  output$diagram <- renderGrViz({ grViz({diagram}) })
  
  output$hist <- renderPlot( { car %>%
      ggplot(aes(`Fuel effciency`, `Avr. RPM`)) +
      geom_point() + xlab("Fuel") + ylab("Fuel")
  })
}

# Call the App
shinyApp(ui, server)








