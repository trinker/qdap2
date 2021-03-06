\name{replace_abbreviation}
\alias{replace_abbreviation}
\title{Replace Abbreviations}
\usage{
  replace_abbreviation(text.var,
    abbreviation = qdap::abbreviations, replace = NULL,
    ignore.case = TRUE)
}
\arguments{
  \item{text.var}{The text variable.}

  \item{abbreviation}{A two column key of abbreviations
  (column 1) and long form replacements (column 2) or a
  vector of abbreviations.  Default is to use qdap's
  abbreviations data set.}

  \item{replace}{A vector of long form replacements if a
  data frame is not supplied to the abbreviation argument.}

  \item{ignore.case}{logical.  If TRUE replaces without
  regard to capitalization.}
}
\value{
  Returns a vector with abbreviations replaced.
}
\description{
  This function replaces abbreviations with long form.
}
\examples{
x <- c("Mr. Jones is here at 7:30 p.m.",
    "Check it out at www.github.com/trinker/qdap",
    "i.e. He's a sr. dr.; the best in 2012 A.D.",
    "the robot at t.s. is 10ft. 3in.")

replace_abbreviation(x)

#create abbreviation and replacement vectors
abv <- c("in.", "ft.", "t.s.")
repl <- c("inch", "feet", "talkstats")

replace_abbreviation(x, abv, repl)

(KEY <- rbind(abbreviations, data.frame(abv = abv, rep = repl)))
replace_abbreviation(x, KEY)
}
\seealso{
  \code{\link[qdap]{bracketX}}, \code{\link[qdap]{qprep}},
  \code{\link[qdap]{replace_contraction}},
  \code{\link[qdap]{replace_number}},
  \code{\link[qdap]{replace_symbol}}
}
\keyword{abbreviation}

