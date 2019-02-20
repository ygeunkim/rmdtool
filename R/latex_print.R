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

#' Coerce characters and matrices to tex
#'
#' @description
#' `as_tex()` can be applied to a `character` or a `matrix` object, so that the input is changed into the new object `tex`. This might make up the defect of `knitr_print` method for matrix.
#' `as_tex()` is an S3 generic, with methods for:
#' * [`character`][base::character()]
#' * [`matrix`][methods::matrix-class]: bmatrix form of latex
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

#' Print tex class as latex
#'
#' `knitr_print()` will print math form in the r markdown chunk. `results = 'asis'` option should be assigned to that chunk.
#' @param x `tex` to be printed
#' @param inline Choose between inline versus in-chunk. The default is set to be `inline = FALSE`, in-chunk.
#' @examples
#' ```{r, results = 'asis'}
#' A <- matrix(1:10, nrow = 2)
#' knitr_print(as_tex(A))
#' ```
#' @export
knitr_print.tex <- function(x, inline = FALSE, ...) {
  if (inline) {
    print(x)
  } else {
    asis_output(
      paste0("$$", x, "$$")
    )
  }
}

#' Print matrix as latex
#'
#' `knitr_print()` will now print math form in the inline, i.e. `r matrix`. Here, the function does not have to be specified. If in-chunk option is choosed, normal matrix form in R console will be printed.
#' @param x `matrix` to be printed
#' @param inline Choose between inline versus in-chunk. The default is set to be `inline = FALSE`, in-chunk.
#' @export
knitr_print.matrix <- function(x, inline = FALSE, ...) {
  if (inline) {
    as_tex(x)
  } else {
    print(x)
  }
}