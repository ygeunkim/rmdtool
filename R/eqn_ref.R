#' Equation reference in html documents
#'
#' @description
#' By writing this script at the beginning of the rmd file, equation referencing becomes more flexible in html documents.
#' @examples
#' eqn_numbering()
#' @return Copy and paste to the document
#' @export
eqn_numbering <- function() {
  jax <- paste0(eqn_mathjax(), collapse = "\n")
  writeLines(jax)
}

eqn_mathjax <- function() {
  c(
    "<script type=\"text/x-mathjax-config\">",
    "MathJax.Hub.Config({",
    "  TeX: { equationNumbers: { autoNumber: \"AMS\" } }",
    "});",
    "</script>"
  )
}
