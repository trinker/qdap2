\name{common}
\alias{common}
\title{Find Common Words Between Groups}
\usage{
  common(word.list, overlap = "all", equal.or = "more",
    ...)
}
\arguments{
  \item{word.list}{A list of names character vectors.}

  \item{overlap}{Minimum/exact amount of overlap.}

  \item{equal.or}{A character vector of c(\code{"equal"},
  \code{"greater"}, \code{"more"}, \code{"less"}).}

  \item{\dots}{In lieu of word.list the user may input n
  number of character vectors.}
}
\value{
  Returns a dataframe of all words that match the criteria
  set by \code{overlap} and \code{equal.or}.
}
\description{
  Find common words between grouping variables (e.g.
  people).
}
\examples{
a <- c("a", "cat", "dog", "the", "the")
b <- c("corn", "a", "chicken", "the")
d <- c("house", "feed", "a", "the", "chicken")
common(a, b, d, overlap=2)
common(a, b, d, overlap=3)

r <- list(a, b, d)
common(r)
common(r, overlap=2)

common(word_list(DATA$state, DATA$person)$cwl, overlap = 2)
}

