\name{convert}
\alias{convert}
\title{Convert Seconds to h:m:s}
\usage{
  convert(x)
}
\arguments{
  \item{x}{A vector of times in seconds.}
}
\value{
  Returns a vector of times in h:m:s format.  Generally,
  this function is for internal use.
}
\description{
  Converts a vector of seconds to h:m:s
}
\examples{
convert(c(256, 3456, 56565))
}
\seealso{
  \code{\link[chron]{times}}
}
\keyword{conversion}
\keyword{time,}

