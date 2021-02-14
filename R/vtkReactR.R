#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @examples
#' libray("vtkReactR")
#' #Transfer function at the moment broken
#' volume = array(runif(1000), dim=rep(10, 3))
#' vtkReactR::vtkView(
#'   vtkReactR::vtkVolumeDataRepresentation(volume=volume)
#' )
#'
#' @export
vtkView <- function(..., width = NULL, height = NULL, elementId = NULL, id=0)
{
  # describe a React component to send to the browser for rendering.
  content <- reactR::component(
    "View",
    list(id=as.character(id),
         ...)
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'vtkReactR',
    reactR::reactMarkup(content),
    width = width,
    height = height,
    package = 'vtkReactR',
    elementId = elementId
  )
}

#' @export
vtkVolumeDataRepresentation <- function(
                                     ...,
                                     volume,
                                     spacing=c(1,1,1),
                                     origin=c(0,0,0),
                                     rescaleColorMap=FALSE
                                    )
{
  reactR::component("VolumeDataRepresentation",
                      list(
                         spacing = spacing,
                         dimensions = dim(volume),
                         origin = origin,
                         scalars = as.vector(volume),
                         rescaleColorMap = rescaleColorMap,
                         ...
                       )
                    )
}

#' @export
vtkVolumeController <- function( ... ){
  reactR::component("VolumeController", ... )
}

#' @export
vtkVolumeRepresentation <- function( ... ){
  reactR::component("VolumeRepresentation", ... )
}

#' @export
vtkImageData <- function( ... ){
  reactR::component("ImageData", ... )
}



#' Shiny bindings for vtkReactR
#'
#' Output and render functions for using vtkReactR within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a vtkReactR
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name vtkReactR-shiny
#'
#' @export
vtkViewOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'vtkReactR', width, height, package = 'vtkReactR')
}

#' @rdname vtkReactR-shiny
#' @export
renderVtkView <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, vtkViewOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @rdname vtkReactR-shiny
vtkReactR_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}
