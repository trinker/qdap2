\name{Trim}
\alias{Trim}
\title{Remove Leading/Trailing White Space}
\usage{
  Trim(x)
}
\arguments{
  \item{x}{The text variable.}
}
\value{
  Returns a vector with the leading/trailing white spaces
  removed.
}
\description{
  Remove leading/trailing white space.
}
\examples{
(x <- c("  talkstats.com ", "   really? ", " yeah"))
Trim(x)
}

