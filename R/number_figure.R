#' Cross reference a figure caption
#'
#' @description
#' list, cross reference a `fig.cap` in r markdown with label and link of pdf
#' @param refer of `$cap` refer the figure caption, same as the chunk name
#' @param title of `$cap` caption of the plot
#' @param refer of `$ref` cross refer the corresponding figure by number
#' @examples
#' # ```{r example-plot, fig.cap = fig$cap("example-plot", "Example plot")}
#' # draw any plot
#' # ```
#' # You might cross reference with latex block $`r fig$ref("example-plot")`$
#' @return The number of the figure increases in order. fig$ref("chunk") returns the figure number followed by the string Figure. You don't have to worry changed order of plots while documentation.
#' Also, they provide hyperlink in pdf document so that you can easily approach the plots.
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
