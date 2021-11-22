# This file contains a Flow Chart Shiny App for Document Understanding 

# Load packages 
pacman::p_load(DiagrammeR, shiny)

# Define flow chart
diagram <-"digraph {
  graph [overlap = true, rankdir = LR]
  
  node [shape = rectangle, width = 2, height = 1, fontname = futura, fontsize = 16, fontcolor = white, style = filled ]  
    rec1 [label = 'Data \n Acquisition', tooltip = 'Click for Data Acquisition Tab', color = steelblue1]
    rec2 [label = 'Text \n Extraction', tooltip = 'Click for Text Extraction Tab', color = steelblue2]
    rec3 [label = 'Document \n Filtering', tooltip = 'Click for Document Filtering Tab', color = steelblue3]
    rec4 [label = 'Text \n Understanding', tooltip = 'Click for Text Understanding Tab', color = steelblue]
    rec5 [label = 'Claim \n Match', tooltip = 'Click for Claim Match Tab', color = steelblue4]
  
  rec1 -> rec2 -> rec3 -> rec4 -> rec5
  }"

# Initialize text for each node
texts <- c("Information about data acquisition", 
           "Information about text extraction",
           "Information about document filtering",
           "Information about text understanding",
           "Information about claim match")

jsCode <- paste0("Shiny.onInputChange('clickedElemNr',", 1:5,")")


# Define the user interface
ui <- fluidPage(
  titlePanel("Flow Chart for Document Understanding"), 
  useShinyjs(),
  sidebarLayout(
    sidebarPanel(htmlOutput('info'), uiOutput("tooltip")),
    mainPanel(grVizOutput('diagram', width = "100%", height = "760px")), 
  )
)

# Define the server
server <- function(input, output, session) {
  output$diagram <- renderGrViz({grViz({diagram})})
  
  observeEvent(eventExpr = input$clickedElemNr,{
    output$tooltip <- renderUI({textInput(inputId = "x", label = "Information about Step", value = texts[input$clickedElemNr])})
  })
  
  observe({
    for(nodeNr in 1:length(jsCode)){
      local({
        jsToAdd <- jsCode[nodeNr]
        shinyjs::onclick(paste0("node", nodeNr), runjs(jsToAdd)) 
      })
      
    }
  })
  
 
  }

# Call the shiny app
shinyApp(ui, server)