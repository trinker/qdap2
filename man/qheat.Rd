\name{qheat}
\alias{qheat}
\title{Quick Heatmap}
\usage{
  qheat(mat, low = "white", high = "darkblue",
    values = FALSE, digits = 1, text.size = 3,
    text.color = "grey40", xaxis.col = "black",
    yaxis.col = "black", order.by = NULL, grid = "white",
    by.column = TRUE, auto.size = FALSE, mat2 = NULL)
}
\arguments{
  \item{mat}{A matrix or dataframe produced by many qdap
  functions in which the first column is the grouping
  variable and the rest of the matrix is numeric.  Also
  accepts objects directly from
  \code{\link[qdap]{word_stats}} and
  \code{\link[qdap]{question_type}}.}

  \item{low}{The color to be used for lower values.}

  \item{high}{The color to be used for higher values.}

  \item{values}{logical.  If TRUE the cell values will be
  included on the heatmap.}

  \item{digits}{The number of digits displayed if
  \code{values} is TRUE.}

  \item{text.size}{A integer size to plot the text if
  \code{values} is TRUE.}

  \item{text.color}{A character vector to plot the text if
  \code{values} is TRUE.}

  \item{xaxis.col}{A single character vector color choice
  for the high values.}

  \item{yaxis.col}{A single character vector color choice
  for the low values.}

  \item{order.by}{An optional character vector of a
  variable name to order the columns by.  To reverse use a
  negative (\code{-}) before the column name.}

  \item{grid}{The color of the grid (Use NULL to remove the
  grid).}

  \item{by.column}{logical.  If TRUE applies scaling to the
  column.  If FALSE applies scaling by row (use NULL to
  turn off scaling).}

  \item{auto.size}{logical.  IF TRUE the visual will be
  resized to create square cells.}

  \item{mat2}{A second matrix equal in dimensions to
  \code{mat} that will be used for cell labels if
  \code{values} is TRUE.}
}
\description{
  A quick heatmap function for visualizing typical qdap
  dataframe/matrix outputs.
}
\details{
  \code{qheat} is useful for finding patterns and anomalies
  in large qdap generated dataframes and matrices.
}
\note{
  \code{\link[qdap]{qheat}} is a fast way of working with
  data formats produced by qdap.  The function isn't
  designed to be extended beyond exploratory qdap usage.
}
\examples{
dat <- sentSplit(DATA, "state")
ws.ob <- with(dat, word_stats(state, list(sex, adult), tot=tot))
qheat(ws.ob)
qheat(ws.ob, order.by = "sptot",
    xaxis.col = c("red", "black", "green", "blue"))
qheat(ws.ob, order.by = "sptot")
qheat(ws.ob, order.by = "-sptot")
qheat(ws.ob, values = TRUE)
qheat(ws.ob, values = TRUE, text.color = "red")
qheat(ws.ob, "yellow", "red", grid = FALSE)

dat1 <- data.frame(G=LETTERS[1:5], matrix(rnorm(20), ncol = 4))
dat2 <- data.frame(matrix(LETTERS[1:25], ncol=5))
qheat(dat1, values=TRUE)
qheat(dat1, values=TRUE, mat2=dat2)
}
\keyword{heatmap}

