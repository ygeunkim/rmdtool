#' Inline latex method for matrix
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

#' Tex class for matrix
#'
#' Tex class to write math form easily
as_tex <- function(x, ...) {
  UseMethod("as_tex", x)
}

as_tex.character <- function(x, ...) {
  structure(x, class = c("tex", "character"))
}

as_tex.matrix <- function(x, ...) {
  begin <- "\\begin{bmatrix}"
  end <- "\\end{bmatrix}"
  X <-
    apply(x, 1, function(x) {
      paste(
        paste(x, collapse = "&"),
        "\\\\"
      )
    })
  as_tex(paste(c(begin, X, end), collapse = " "))
}

#' Print method for tex class
#'
#' Print method of `tex` class for `knitr_print`
knitr_print.tex <- function(x, inline = FALSE, ...) {
  if (inline) {
    print(x)
  } else {
    asis_output(
      paste0("$$", x, "$$")
    )
  }
}

#' Print method for matrix class
#'
#' Print method of `matrix` for `knitr_print`
knitr_print.matrix <- function(x, inline = FALSE, ...) {
  if (inline) {
    as_tex(x)
  } else {
    print(x)
  }
}
