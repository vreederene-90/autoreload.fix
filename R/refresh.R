#' autoreload for shiny app that contains multiple files (outside of app.R)
#' @usage refresh()
#' @description
#' An addin is added to Rstudio which can be binded to a keyboard shortcut.
#' Alternatively, a Shiny app can be launched which monitors file changes and updates the modified date & time of "app.R".
#' This results in an automatic refresh of your app.
#' @param app.R The location of your app.R file. It is assumed to be at the root of your project.
#' @importFrom here here
#' @seealso autorefresh
#' @export
refresh <- function() {

  if ("dev/app.R" %in% list.files(here::here(), recursive = T)) {
    Sys.setFileTime("dev/app.R", Sys.time())
  } else {
    stop("Couldn't locate 'app.R' in /dev (if you are working in a golem, rename run_dev.R)")
  }
}
