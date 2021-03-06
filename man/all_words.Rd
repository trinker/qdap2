\name{all_words}
\alias{all_words}
\title{Searches Text Column for Words}
\usage{
  all_words(text.var, begins.with = NULL, contains = NULL,
    alphabetical = TRUE)
}
\arguments{
  \item{text.var}{The text variable.}

  \item{begins.with}{This argument takes a word chunk.
  Default is NULL. Use this if searching for a word
  beginning with the word chunk.}

  \item{contains}{This argument takes a word chunk.
  Default is NULL. Use this if searching for a word
  containing the word chunk.}

  \item{alphabetical}{logical.  If True orders rows
  alphabetically, if false orders the rows by frequency.}
}
\value{
  Returns a dataframe with frequency counts of words that
  begin with or contain the provided word chunk.
}
\description{
  A convenience function to find words that begin with or
  contain a letter chunk and returns the frequency counts
  of the number of occurrences of each word.
}
\note{
  Cannot provide both \code{begins.with} and
  \code{contains} arguments at once.  If both begins.with
  and contains are NULL all.words returns a frequency count
  for all words.
}
\examples{
x1 <- all_words(raj$dialogue, begins.with="re")
head(x1, 10)
x2 <- all_words(raj$dialogue, "q")
head(x2, 10)
all_words(raj$dialogue, contains="conc")
x3 <- all_words(raj$dialogue)
head(x3, 10)
}
\seealso{
  \code{\link[qdap]{term.match}}
}

