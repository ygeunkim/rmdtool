#' Cross reference a figure caption
#'
#' list, cross reference a table in r markdown with label and link of pdf
#' @param refer of `$cap` refer the table caption, same as the table name
#' @param title of `$cap` caption of the table
#' @param refer of `$ref` cross refer the corresponding table by number
#' @return Everything is same but Figure versus Table.
#' @export
tab <- local({
  j <- 0
  tab_ref <- list()
  list(
    cap = function(refer, title) {
      j <<- j + 1
      tab_ref[[refer]] <<- paste("Table ", "\\ref{", refer, "}", sep = "")
      paste(title, "\\label{", refer, "}", sep = "")
    },
    ref = function(refer) {
      tab_ref[[refer]]
    }
  )
})
