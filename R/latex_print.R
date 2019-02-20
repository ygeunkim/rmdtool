#' Inline latex method for matrix
#'
#' @description
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

#' Coerce characters and matrices to tex
#'
#' @description
#' `as_tex()` can be applied to a `character` or a `matrix` object, so that the input is changed into the new object `tex`. This might make up the defect of `knitr_print` method for matrix.
#' @param x `character` or `matrix` object to be `tex`
#' @examples
#' A <- matrix(1:10, nrow = 2)
#' as_tex(A)
#' @export
as_tex <- function(x, ...) {
  UseMethod("as_tex", x)
}

#' @export
#' @rdname as_tex
as_tex.character <- function(x, ...) {
  structure(x, class = c("tex", "character"))
}

#' @export
#' @rdname as_tex
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

#' Print tex or matrix class as latex
#'
#' @description
#' `knitr_print()` will print matrix with math form in the r markdown chunk or inline. In the chunk, `results = 'asis'` option should be assigned to that chunk.
#' Printing matrix becomes more compact. It will be printed math form in the inline, i.e. `r matrix`. Here, the function does not have to be specified. If in-chunk option is choosed, normal matrix form in R console will be printed.
#' @param x `tex` or `matrix` to be printed
#' @param inline Choose between inline versus in-chunk. The default is set to be `inline = FALSE`, in-chunk.
#' @examples
#' ```{r, results = 'asis'}
#' A <- matrix(1:10, nrow = 2)
#' knitr_print(as_tex(A))
#' ```
#' @importFrom knitr knit_print
#' @importFrom knitr asis_output

#' @export
#' @rdname knit_print
knit_print.tex <- function(x, inline = FALSE, ...) {
  if (inline) {
    x
  } else {
    asis_output(
      paste0("$$", x, "$$")
    )
  }
}

#' @export
#' @rdname knit_print
knit_print.matrix <- function(x, inline = FALSE, ...) {
  if (inline) {
    as_tex(x)
  } else {
    print(x)
  }
}
