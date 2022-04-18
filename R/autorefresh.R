#' autorefresh
#' @importFrom shiny shinyApp
#' @importFrom shiny reactiveValues
#' @importFrom shiny reactivePoll
#' @importFrom shiny fluidPage
#' @importFrom here here
#' @usage autorefresh()
#' @description Starts a Shiny app that tracks changes in the {projectroot}/R folder and updates the interface of the app accordingly.
#' The function needs to be a run from a rstudio Job or terminal session for it to be able to do its work.
#' @export
#' @seealso refresh
#' @md
autorefresh <- function() {
  ui <- fluidPage()

  server <- function(input,output,session) {

    options(shiny.autoreload = TRUE)

    newest_file <- function() {
      max(as.integer(file.mtime(
        list.files(path = "R", pattern = "*.R", full.names = T)
      )))
    }

    rv <- reactiveValues(init = newest_file())

    poll <-
      reactivePoll(
        500,
        session,
        checkFunc = function() {
          rv$init == newest_file()
        },
        valueFunc = function() {
          newest_file()
        }
      )

    observe(
      poll()
    )

    observe(
      if ("dev/app.R" %in% list.files(here::here(), recursive = T)) {
        if(poll() != rv$init) {
          Sys.setFileTime("dev/app.R",Sys.time())
          rv$init <- poll()
          print(paste0(Sys.time(),": Update executed"))

        }
      } else {
        stop("Couldn't locate 'app.R' in /dev (if you are working in a golem, rename run_dev.R)")
      }
    )

  }
  shinyApp(
    ui,
    server, options = list(launch.browser = T)
  )

}
