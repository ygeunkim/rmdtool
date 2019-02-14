#` @param refer of cap character same as chunk name
#` @param title of cap character title of the latex figure
#` @examples
#` ```{r mpgplot, fig.cap = fig$cap("mpgplot", "Engine displacement according to hwy")}
# mpg %>%
#   ggplot() +
#   aes(displ, hwy) +
#   geom_point()
#` ```
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
