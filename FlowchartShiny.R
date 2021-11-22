# This file contains a Flow Chart Shiny App for Document Understanding 

# Load packages 
pacman::p_load(DiagrammeR, shiny)

# Define flow chart
flowchart <-"digraph {
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

jsCode <- paste0("Shiny.onInputChange('clickedElemNr',", 1:5,")")

ui <- shinyUI(
  navbarPage("My Application",
             tabsetPanel(id = "home", 
               tabPanel(
                  "Flow Chart",
                  titlePanel("Flow Chart for Document Understanding"), 
                  grVizOutput('flowchart', width = "100%", height = "760px"),
                  actionButton("link_to_tabpanel_Data_Acquisition", "Link to panel Data Acquisition"),
                  actionButton("link_to_tabpanel_Text_Extraction", "Link to panel Text Extraction")),
             tabPanel("Data-Acquisition",
                      titlePanel("Page for Data Acquisition Process")),
             tabPanel("Text-Extraction",
                      titlePanel("Page for Text Extraction Process"))
  ))
)


# Define the server
server <- function(input, output, session) {
  output$flowchart <- renderGrViz({grViz({flowchart})})
  
  observeEvent(input$link_to_tabpanel_Data_Acquisition, {
    updateTabsetPanel(session, "home", "Data-Acquisition")
  })
  
  observeEvent(input$link_to_tabpanel_Text_Extraction, {
    updateTabsetPanel(session, "home", "Text-Extraction")
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
