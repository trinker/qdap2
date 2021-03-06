\name{duplicates}
\alias{duplicates}
\title{Find Duplicated Words in a Text String}
\usage{
  duplicates(string, threshold = 1)
}
\arguments{
  \item{string}{A character string.}

  \item{threshold}{An integer of the minimal number of
  repeats.}
}
\value{
  Returns a vector of all duplicated words/chunks.
}
\description{
  Find duplicated word/word chunks in a string.  Intended
  for internal use.
}
\examples{
duplicates(DATA$state)
duplicates(DATA$state[1])
}

