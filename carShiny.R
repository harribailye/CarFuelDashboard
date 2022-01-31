# This file contains a Flow Chart Shiny App for Car Fuel Efficiency 
# Author: Harrison Bailye
# Date: 26/11/2021

## Load in the packages and the data 
pacman::p_load(DiagrammeR, shiny, shinydashboard, tidyverse)
car <- read_csv("https://github.com/harribailye/ShinyApp/blob/main/car_data.csv")
head(car)