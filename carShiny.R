# This file contains a Flow Chart Shiny App for Car Fuel Efficiency 
# Author: Harrison Bailye
# Date: 126/11/2021

pacman::p_load(DiagrammeR, shiny, shinydashboard, tidyverse)
car <- read.csv("Driving.csv")

# Header for UI
header <- dashboardHeader(title = "My Car Fuel Efficiency")

# Sidebar for UI
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("sitemap")),
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Interactive Plots", tabName = "plots", icon = icon("chart-line"))
  ))
  
# Body for UI
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "overview",
            h2("Overview of the Shiny App"),
            h3("Introduction"),
            box(width = 14,
                "Since purchasing my own car in October 2021, I have been intrigued at the fuel efficiency. 
                  So I decided to measure it and do some exploritory data analysis on the collected data. The
                  aim of the project was to lower the average fuel consumputon of the car by understanding the 
                  optimal way to drive it. Additionally, I wanted to investigate if the claimed average fuel
                  efficiency was accurate or not."),
            h3("Car Details"), 
            fluidRow(infoBox("Model", "2008 Subaru Impreza RX", icon = icon("car"))),
            fluidRow(infoBox("Engine", "2.0 Litres", icon = icon("car-battery"))),
            fluidRow(infoBox("Odometer", "178,300 km", icon = icon("tachometer-alt"))),
            fluidRow(infoBox("Claimed Average Fuel Efficiency", "9.8 L/100km", icon = icon("gas-pump")))),
    tabItem(tabName = "dashboard"),
    tabItem(tabName = "plots",
            fluidRow(
              box(plotOutput("plot1", height = 250)),
              box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
              )
   ))))

## UI
ui <- dashboardPage(header, sidebar, body)

## Server
server <- function(input, output, session) { }

# Call the App
shinyApp(ui, server)








