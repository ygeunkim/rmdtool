
# rmdtool

Private tools for writing R markdown documents

Motivated by [StackOverflow](https://stackoverflow.com), including my
own
answers

<a href="https://stackoverflow.com/users/10358660/blended"><img src="https://stackoverflow.com/users/flair/10358660.png" width="208" height="58" alt="profile for Blended at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for Blended at Stack Overflow, Q&amp;A for professional and enthusiast programmers"></a>

  - numbering figures: [figure captions, references using knitr and
    markdown to
    html](https://stackoverflow.com/questions/13848137/figure-captions-references-using-knitr-and-markdown-to-html)
  - display matrices: [For R Markdown, How do I display a matrix from R
    variable](https://stackoverflow.com/questions/45591286/for-r-markdown-how-do-i-display-a-matrix-from-r-variable)
  - enables equation reference: [Rendering problem cross-reference
    equation in r markdown
    HTML](https://stackoverflow.com/questions/55162080/rendering-problem-cross-reference-equation-in-r-markdown-html)

-----

## Install

Denote that this package is made for private usage, so it might not be
comfortable to use.

``` r
devtools::install_github("ygeunkim/rmdtool")
```

## Print matrix

``` r
(a <- 1:3)
#> [1] 1 2 3
(A <- matrix(1:9, nrow = 3))
#>      [,1] [,2] [,3]
#> [1,]    1    4    7
#> [2,]    2    5    8
#> [3,]    3    6    9
```

In case of vector, we can use the `R` object in the latex block. In
fact, we can express this as vector form.

    $(`r a`)^T$

Then we can get
![(1, 2, 3)^T](https://latex.codecogs.com/png.latex?%281%2C%202%2C%203%29%5ET
"(1, 2, 3)^T"). Writing matrix, however, is quite annoying. If we do the
same for the matrix, we will get
![1, 2, 3, 4, 5, 6, 7, 8, 9](https://latex.codecogs.com/png.latex?1%2C%202%2C%203%2C%204%2C%205%2C%206%2C%207%2C%208%2C%209
"1, 2, 3, 4, 5, 6, 7, 8, 9"). So we need to add new method for
`knitr::knit_print()`.

``` r
library(rmdtool)
```

Now consider

    $`r A`$

This inline print method ![\\begin{bmatrix} 1&4&7 \\\\ 2&5&8 \\\\ 3&6&9
\\\\
\\end{bmatrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bbmatrix%7D%201%264%267%20%5C%5C%202%265%268%20%5C%5C%203%266%269%20%5C%5C%20%5Cend%7Bbmatrix%7D
"\\begin{bmatrix} 1&4&7 \\\\ 2&5&8 \\\\ 3&6&9 \\\\ \\end{bmatrix}")
gives `bmatrix` form of the matrix. Also,

    $$`r A`$$

  
![\\begin{bmatrix} 1&4&7 \\\\ 2&5&8 \\\\ 3&6&9 \\\\
\\end{bmatrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bbmatrix%7D%201%264%267%20%5C%5C%202%265%268%20%5C%5C%203%266%269%20%5C%5C%20%5Cend%7Bbmatrix%7D
"\\begin{bmatrix} 1&4&7 \\\\ 2&5&8 \\\\ 3&6&9 \\\\ \\end{bmatrix}")
