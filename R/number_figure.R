#' Cross reference a figure caption
#'
#' @description
#' list, cross reference a `fig.cap` in r markdown with label and link of pdf
#' @examples
#' library(ggplot2)
#' ggplot(data = mpg, aes(x = displ, y = hwy)) +
#'   geom_point() +
#'   labs(caption = fig$cap("fig-chunk-name", "Caption name"))
#' fig$ref("fig-chunk-name")
#' ## For detailed usage, see the vignette
#' @return The number of the figure increases in order. fig$ref("chunk") returns the figure number followed by the string Figure. You don't have to worry changed order of plots while documentation.
#' Also, they provide hyperlink in pdf document so that you can easily approach the plots.
#' \item{refer}{of `$cap` refer the figure caption, same as the chunk name}
#' \item{title}{of `$cap` caption of the plot}
#' \item{refer}{of `$ref` cross refer the corresponding figure by number}
#' @seealso \code{\link{tab}} Table numbering
#' @export
fig <- local({
  i <- 0
  fig_ref <- list()
  list(
    cap = function(refer, title, inline = TRUE, ...) {
      i <<- i + 1
      fig_ref[[refer]] <<- paste0("\\text{Figure }", "\\ref{fig:", refer, "}")
      if (inline) {
        as_tex(paste0(title, "\\label{fig:", refer, "}"))
      } else {
        paste0(title, "\\label{fig:", refer, "}")
      }
    },
    ref = function(refer, inline = TRUE, ...) {
      if (inline) {
        as_tex(fig_ref[[refer]])
      } else {
        print(fig_ref[[refer]])
      }
    }
  )
})
