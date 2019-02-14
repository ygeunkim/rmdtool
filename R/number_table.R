tab <- local({
  j <- 0
  tab_ref <- list()
  list(
    cap = function(refer, title) {
      j <<- j + 1
      tab_ref[[refer]] <<- paste("Table ", "\\ref{", refer, "}", sep = "")
      paste(title, "\\label{", refer, "}", sep = "")
    },
    ref = function(refer) {
      tab_ref[[refer]]
    }
  )
})
