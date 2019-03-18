#' Cross reference a figure caption
#'
#' @description
#' list, cross reference a table in r markdown with label and link of pdf
#' @param refer of `$cap` refer the table caption, same as the table name
#' @param title of `$cap` caption of the table
#' @param refer of `$ref` cross refer the corresponding table by number
#' @return Everything is same but Figure versus Table.
#' @seealso \code{\link{fig}} Figure numbering
#' @export
tab <- local({
  j <- 0
  tab_ref <- list()
  list(
    cap = function(refer, title, inline = TRUE, ...) {
      j <<- j + 1
      tab_ref[[refer]] <<- paste0("\\text{Table }", "\\ref{table:", refer, "}")
      if (inline) {
        as_tex(paste0(title, "\\label{table:", refer, "}"))
      } else {
        paste0(title, "\\label{table:", refer, "}")
      }
    },
    ref = function(refer, inline = TRUE, ...) {
      if (inline) {
        as_tex(tab_ref[[refer]])
      } else {
        print(tab_ref[[refer]])
      }
    }
  )
})
