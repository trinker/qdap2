\name{word.count}
\alias{char.table}
\alias{character.count}
\alias{character.table}
\alias{wc}
\alias{word.count}
\title{Word Counts}
\usage{
  word.count(text.var, byrow = TRUE, missing = NA,
    digit.remove = TRUE, names = FALSE)

  wc(text.var, byrow = TRUE, missing = NA,
    digit.remove = TRUE, names = FALSE)

  character.count(text.var, byrow = TRUE, missing = NA,
    apostrophe.remove = TRUE, digit.remove = TRUE,
    count.space = FALSE)

  character.table(text.var, grouping.var, percent = TRUE,
    prop.by.row = TRUE, zero.replace = 0, digits = 2, ...)

  char.table(text.var, grouping.var, percent = TRUE,
    prop.by.row = TRUE, zero.replace = 0, digits = 2, ...)
}
\arguments{
  \item{text.var}{The text variable}

  \item{grouping.var}{The grouping variables.  Default NULL
  generates one output for all text.  Also takes a single
  grouping variable or a list of 1 or more grouping
  variables.}

  \item{byrow}{logical.  If TRUE counts by row, if FALSE
  counts all words.}

  \item{missing}{Value to insert for missing values (empty
  cells).}

  \item{digit.remove}{logical.  If TRUE removes digits
  before counting words.}

  \item{names}{logical.  If TRUE the sentences are given as
  the names of the counts.}

  \item{apostrophe.remove}{logical.  If TRUE apostrophes
  will be counted in the character count.}

  \item{count.space}{logical.  If TRUE spaces are counted
  as characters.}

  \item{prop.by.row}{logical.  If TRUE applies proportional
  to the row.  If FALSE applies by column.}

  \item{\ldots}{Other arguments passed to
  \code{\link[qdap]{prop}}.}

  \item{percent}{logical.  If TRUE output given as percent.
  If FALSE the output is proportion.}

  \item{zero.replace}{Value to replace 0 values with.}

  \item{digits}{Integer; number of decimal places to round
  when printing.}
}
\value{
  \code{word.count} - returns a word count by row or total.

  \code{character.count} - returns a character count by row
  or total.

  \code{character.table} - returns a list: dataframe of
  character counts by grouping variable.
  \item{raw}{Dataframe of the frequency of characters by
  grouping variable.} \item{prop}{Dataframe of the
  proportion of characters by grouping variable.}
  \item{rnp}{Dataframe of the frequency and proportions of
  characters by grouping variable.} \item{percent}{The
  value of percent used for plotting purposes.}
  \item{zero.replace}{The value of zero.replace used for
  plotting purposes.}
}
\description{
  \code{word.count} - Transcript apply word counts.

  \code{character.count} - Transcript apply character
  counts.

  \code{character.table} - Computes a table of character
  counts by grouping . variable(s).
}
\note{
  wc is a convenient short hand for word.count.
}
\examples{
# WORD COUNT
word.count(DATA$state)
wc(DATA$state)
word.count(DATA$state, names = TRUE)
word.count(DATA$state, byrow=FALSE, names = TRUE)
sum(word.count(DATA$state))

# CHARACTER COUNTS
character.count(DATA$state)
character.count(DATA$state, byrow=FALSE)
sum(character.count(DATA$state))

# CHARACTER TABLE
x <- character.table(DATA$state, DATA$person)
plot(x)
plot(x, label = TRUE)
plot(x, label = TRUE, text.color = "red")
plot(x, label = TRUE, lab.digits = 1, zero.replace = "PP7")
x$raw[, 1:20]
x$prop[, 1:8]
x$rnp[, 1:8]

## char.table(DATA$state, DATA$person)
## char.table(DATA$state, DATA$person, percent = TRUE)
## character.table(DATA$state, list(DATA$sex, DATA$adult))

library(ggplot2);library(reshape2)
dat <- character.table(DATA$state, list(DATA$sex, DATA$adult))
dat2 <- colsplit2df(melt(dat$raw), keep.orig = TRUE)
head(dat2, 15)
dat3 <- dat2[rep(seq_len(dim(dat2)[1]), dat2[, 5]), -5]


ggplot(data = dat2, aes(y = variable, x = value, colour=sex)) +
    facet_grid(adult~.) +
    geom_line(size=1, aes(group =variable), colour = "black") +
    geom_point()

ggplot(data = dat3, aes(x = variable, fill = variable)) +
    geom_bar() +
    facet_grid(sex ~ adult, margins = TRUE) +
    theme(legend.position="none")
}
\seealso{
  \code{\link[qdap]{syllable.count}}

  \code{\link[qdap]{prop}}
}
\keyword{character-count}
\keyword{word-count,}

