\name{multiscale}
\alias{multiscale}
\title{Nested Standardization}
\usage{
  multiscale(numeric.var, grouping.var,
    original_order = TRUE, digits = 2)
}
\arguments{
  \item{numeric.var}{A numeric variable.}

  \item{grouping.var}{The grouping variables.  Default NULL
  generates one output for all text.  Also takes a single
  grouping variable or a list of 1 or more grouping
  variables.}

  \item{original_order}{logical.  IF TRUE orders by the
  original order.  If FALSE orders by group.}

  \item{digits}{Integer; number of decimal places to
  round.}
}
\value{
  Returns a list of two: \item{SCALED_OBSERVATIONS}{A
  dataframe of scaled observations at level one and two of
  the nesting with possible outliers.}
  \item{DESCRIPTIVES_BY_GROUP}{A data frame of descriptives
  by group.}
}
\description{
  Standardize within a subgroup and then within a group.
}
\examples{
dat <- with(mraja1spl, word_stats(dialogue, list(person, sex, fam.aff)))
htruncdf(colsplit2df(dat$ts), ,4)
out1 <- with(colsplit2df(dat$ts), multiscale(word.count, person))
ltruncdf(out1, 10)
out2 <- with(colsplit2df(dat$ts), multiscale(word.count,
    list(fam.aff, sex)))
ltruncdf(out2, 10)
out3 <- with(colsplit2df(dat$ts), multiscale(word.count,
    list(fam.aff, sex), original_order = FALSE))
ltruncdf(out3, 10)
}
\seealso{
  \code{\link[base]{scale}}
}
\keyword{scale}

