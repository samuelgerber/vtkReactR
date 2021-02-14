library(shiny)
library(vtkReactR)

ui <- fluidPage(
  titlePanel("vtkReactR Volume Rendering"),
  vtkViewOutput("widgetOutput"),
  actionButton("random", "Update Volume")
)

server <- function(input, output, session) {
  output$widgetOutput <- renderVtkView({
    input$random
    volume = array(runif(1000), dim=rep(10, 3))
    vtkReactR::vtkView(
      vtkReactR::vtkVolumeDataRepresentation(volume=volume)
    )
  })
}

shinyApp(ui, server)
