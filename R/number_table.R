#' Cross reference a table caption
#'
#' @description
#' list, cross reference a table in r markdown with label and link of pdf
#' @examples
#' knitr::kable(ggplot2::mpg, caption = tab$cap("tab-chunk-name", "Caption name"))
#' tab$ref("tab-chunk-name")
#' ## For detailed usage, see the vignette
#' @return Everything is same but Figure versus Table.
#' \item{refer}{of `$cap` refer the table caption, same as the chunk name}
#' \item{title}{of `$cap` caption of the table}
#' \item{refer}{of `$ref` cross refer the corresponding table by number}
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
