# vtkReactR HTMLWidget

R htmlwidget wrapper for react-vtk-js.

Work in progress ...

## Install

In R:

```
require("devtools")
devtools::install_github("samuelgerber/vtkReactR")
```


### Example

```
libray("vtkReactR")
require(shiny)

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
```



## Building for Development

Because this package includes Javascript source code that requires a compilation step,
package installation is in two phases: Javascript tools build the Javascript, and R tools
build and install the package. The R package includes the built Javascript files in the `inst/` directory.

### Javascript Build Requirements

Building Javascript should work on macOS, Linux, and Windows. The following tools are necessary regardless of your platform:

- [Node.js](https://nodejs.org/en/)
- [Yarn](https://yarnpkg.com/en/)

### R Build Requirements

You should install the `reactR` package if you haven't, as this widget depends on it.


### Development Workflow

After you've installed Node.js and Yarn, run the following command to resolve and download dependencies:

```
yarn install
```

Now, run `yarn` to build `inst/htmlwidgets/vtkReactR.js`:

```
yarn run webpack --mode=development
```

> To run `yarn webpack` automatically whenever sources change, use the command `yarn run webpack --mode=development --watch`

Now that the Javascript is built, you can install the R package:

```
require(devtools)
devtools::document()
devtools::install()
```


