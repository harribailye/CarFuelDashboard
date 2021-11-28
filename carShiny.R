# This file contains a Flow Chart Shiny App for Car Fuel Efficiency 
# Author: Harrison Bailye
# Date: 126/11/2021

pacman::p_load(DiagrammeR, shiny, shinydashboard, tidyverse)
car <- read.csv("Driving.csv")


## UI
ui <- dashboardPage(
  dashboardHeader(title = "My Car Fuel Efficiency"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("sitemap")),
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Plots", tabName = "plots", icon = icon("chart-line"))
    )
  ),
  dashboardBody()
)






## Server
server <- function(input, output, session) { 
  output$diagram <- renderGrViz({grViz({diagram})})
  }





# Call the App
shinyApp(ui, server)








