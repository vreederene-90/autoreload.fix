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
refresh <- function(app.R = "app.R") {

  if ("app.R" %in% list.files(here::here())) {
    Sys.setFileTime(app.R, Sys.time())
  } else {
    stop("Couldn't locate app.R, is it present at the root of your project?")
  }
}
