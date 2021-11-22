# This file contains a Flow Chart Shiny App for Document Understanding 

# Load packages 
pacman::p_load(DiagrammeR, shiny)

# Define flow chart
diagram <-"digraph {
  graph [overlap = true, rankdir = LR]
  
  node [shape = rectangle, width = 2, height = 1, fontname = futura, fontsize = 16, fontcolor = white, style = filled]  
    rec1 [label = 'Data \n Acquisition', tooltip = 'Click for Data Acquisition Tab', color = steelblue1]
    rec2 [label = 'Text \n Extraction', tooltip = 'Click for Text Extraction Tab', color = steelblue2]
    rec3 [label = 'Document \n Filtering', tooltip = 'Click for Document Filtering Tab', color = steelblue3]
    rec4 [label = 'Text \n Understanding', tooltip = 'Click for Text Understanding Tab', color = steelblue]
    rec5 [label = 'Claim \n Match', tooltip = 'Click for Claim Match Tab', color = steelblue4]
  
  edge [arrowhead = vee];
  rec1 -> rec2 -> rec3 -> rec4 -> rec5
  }"

# Define the user interface
ui <- fluidPage(
  titlePanel("Flow Chart for Document Understanding"), 
  grVizOutput('diagram', width = "100%", height = "760px"), 
  )

# Define the server
server <- function(input, output, session) {
  output$diagram <- renderGrViz({grViz({diagram})})
  }

# Call the shiny app
shinyApp(ui, server)


# find out how to link to a tab