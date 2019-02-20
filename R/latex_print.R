#' Latex method for matrix
#'
#' Write R matrix object in Latex block
#' @param x R matrix object
#' @examples
#' ```{r}
#' A <- matrix(1:10, nrow = 3)
#' ```
#' You can write the matrix A in the inline $`r bmatrix(A)`$ or
#' $$`r bmatrix(A)`$$
#' @return This function is designed to use in the latex block. Output in the chunk might useless. For chunk usage, `paste()` of last line should be replaced by `writeLines()`.
#' @export
bmatrix <- function(x) {
  begin <- "\\begin{bmatrix}"
  end <- "\\end{bmatrix}"
  X <-
    apply(x, 1, function(x) {
      paste(
        paste(x, collapse = "&"),
        "\\\\"
      )
    })
  paste(c(begin, X, end), collapse = "")
}
