#' Cross reference a figure caption
#'
#' list, cross reference a `fig.cap` in r markdown with label and link of pdf
#' @param refer of `$cap` refer the figure caption, same as the chunk name
#' @param title of `$cap` caption of the plot
#' @param refer of `$ref` cross refer the corresponding figure by number
#' @examples
#' ```{r example-plot, fig.cap = fig$cap("example-plot", "Example plot")}
#' set.seed(1)
#' mydf <- tibble(x = rnorm(100))
#' mydf <- mydf %>% mutate(y = x * 2)
#' mydf %>%
#'   ggplot(aes(x, y)) +
#'   geom_point()
#' ```
#' You might cross reference with latex block $`r fig$ref("example-plot")`$
#' @return The number of the figure increases in order. fig$ref("chunk") returns the figure number followed by the string Figure. You don't have to worry changed order of plots while documentation.
#' Also, they provide hyperlink in pdf document so that you can easily approach the plots.
#' @export
fig <- local({
  i <- 0
  fig_ref <- list()
  list(
    cap = function(refer, title) {
      i <<- i + 1
      # fig_ref[[refer]] <<- paste("Figure", i)
      fig_ref[[refer]] <<- paste("Figure ", "\\ref{", refer, "}", sep = "") # \ref{refer} = linked i
      paste(title, "\\label{", refer, "}", sep = "")
    },
    ref = function(refer) {
      fig_ref[[refer]]
    }
  )
})
