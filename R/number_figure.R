#' Cross reference a figure caption
#'
#' list, cross reference a `fig.cap` in r markdown with label and link of pdf
#' @param refer of `$cap` refer the figure caption, same as the chunk name
#' @param title of `$cap` caption of the plot
#' @param refer of `$ref` cross refer the corresponding figure by number
#' @examples
#' ```{r example-plot, fig.cap = fig$cap("example-plot", "Example plot")}
#' set.seed(1)
#' mydf <- data_frame(x = rnorm(100))
#' mydf <- mutate(y = x * 2)
#' mydf %>%
#'   ggplot(aes(x, y)) +
#'   geom_point()
#' fig$ref("example-plot")
#' ```
#'
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
