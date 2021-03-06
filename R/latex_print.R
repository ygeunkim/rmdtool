#' Inline latex method for matrix
#'
#' @description
#' Write R matrix object in Latex block.
#' This function might be useful as an alternative to implementing the whole package.
#' By this one function, same things can be done as \code{\link{knit_print.matrix}}, althogh you should specify the function.
#' @param x R matrix object
#' @examples
#' A <- matrix(1:9, nrow = 3)
#' bmatrix(A)
#' ## You can write the matrix A in the inline $`r bmatrix(A)`$ or
#' ## $$`r bmatrix(A)`$$
#' @return This function is designed to use in the latex block. Output in the chunk might useless. For chunk usage, `paste()` of last line should be replaced by `writeLines()`.
#' @seealso \code{\link{knit_print.matrix}}
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
#' @param ... Additional arguments passed to the S3 method.
#' @examples
#' A <- matrix(1:9, nrow = 3)
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
#' `knitr_print()` will print an object with math form in the r markdown chunk or inline. It can be an tex or a matrix. In the chunk, `results = 'asis'` option should be assigned to that chunk.
#' Printing matrix becomes more compact than before. It will be printed math form in the inline, i.e. `r matrix`. Here, the function does not have to be written.
#' If in-chunk option is choosed, normal matrix form in R console will be printed.
#' @param x `tex` or `matrix` to be printed
#' @param inline Choose between inline versus in-chunk. The default is set to be `inline = FALSE`, in-chunk.
#' @param ... Additional arguments passed to the S3 method.
#' @examples
#' A <- matrix(1:9, nrow = 3)
#' library(knitr) # to use knit_print() function directly, knitr package needed
#' knit_print(as_tex(A))
#' knit_print(as_tex(A), inline = TRUE)
#' knit_print(A)
#' knit_print(A, inline = TRUE)
#' ## In case of matrix, $`r A`$ or $$`r A`$$ works.
#' ## vignette will provide the details.
#' @seealso \code{\link{bmatrix}} Printing matrix latex form by using the function
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
