\name{trans.cloud}
\alias{trans.cloud}
\title{Word Clouds by Grouping Variable}
\usage{
  trans.cloud(text.var = NULL, grouping.var = NULL,
    word.list = NULL, stem = FALSE, target.words = NULL,
    expand.target = TRUE, target.exclude = NULL,
    stopwords = NULL, min.freq = 1, caps = TRUE,
    caps.list = NULL, random.order = FALSE, rot.per = 0,
    cloud.colors = NULL, title = TRUE, cloud.font = NULL,
    title.font = NULL, title.color = "black",
    title.padj = -4.5, title.location = 3,
    title.cex = NULL, title.names = NULL,
    proportional = FALSE, max.word.size = NULL,
    min.word.size = 0.5, legend = NULL, legend.cex = 0.8,
    legend.location = c(-0.03, 1.03), char.keep = "~~",
    char2space = NULL)
}
\arguments{
  \item{text.var}{The text variable.}

  \item{grouping.var}{The grouping variables.  Default NULL
  generates one output for all text.  Also takes a single
  grouping variable or a list of 1 or more grouping
  variables.}

  \item{word.list}{A frequency word list passed from
  \code{\link[qdap]{word_list}}.}

  \item{stem}{logical.  If TRUE the \code{text.var} will be
  stemmed.}

  \item{target.words}{A named list of vectors of words
  whose length corresponds to \code{cloud.colors} (+1
  length in cloud colors for non matched terms).}

  \item{expand.target}{logical.  If TRUE agrep will be used
  to expand the \code{target.words}.}

  \item{target.exclude}{A vector of words to exclude from
  the \code{target.words}.}

  \item{stopwords}{Words to exclude from the cloud.}

  \item{min.freq}{An integer value indicating the minimum
  frequency a word must appear to be included.}

  \item{caps}{logical.  If TRUE selected words will be
  capitalized.}

  \item{caps.list}{A vector of words to capitalize
  (\code{caps} must be TRUE).}

  \item{random.order}{Plot words in random order. If false,
  they will be plotted in decreasing frequency.}

  \item{rot.per}{Proportion words with 90 degree rotation.}

  \item{cloud.colors}{A vector of colors equal to the
  length of target words +1.}

  \item{title}{logical.  IF TRUE adds a title corresponding
  to the \code{grouping.var}.}

  \item{cloud.font}{The font family of the cloud text.}

  \item{title.font}{The font family of the cloud title.}

  \item{title.color}{A character vector of length one
  corresponding to the color of the title.}

  \item{title.padj}{Adjustment for the title. For strings
  parallel to the axes, padj = 0 means right or top
  alignment, and padj = 1 means left or bottom alignment.}

  \item{title.location}{On which side of the plot
  (1=bottom, 2=left, 3=top, 4=right).}

  \item{title.cex}{Character expansion factor for the
  title. NULL and NA are equivalent to 1.0.}

  \item{title.names}{Optional vector of title names equal
  in length to the grouping.var that will override the
  default use of the grouping.var names.}

  \item{proportional}{logical.  If TRUE scales the word
  clouds across grouping.var to allow cloud to cloud
  comparisons.}

  \item{max.word.size}{A size argument to control the
  minimum size of the words.}

  \item{min.word.size}{A size argument to control the
  maximum size of the words.}

  \item{legend}{A character vector of names corresponding
  to the number of vectors in target.words.}

  \item{legend.cex}{Character expansion factor for the
  legend. NULL and NA are equivalent to 1.0.}

  \item{legend.location}{The x and y co-ordinates to be
  used to position the legend.}

  \item{char.keep}{A character vector of symbol character
  (i.e. punctuation) that strip should keep.  The default
  is to strip everything except apostrophes. This enables
  the use of special characters to be turned into spaces or
  for characters to be retained.}

  \item{char2space}{A vector of characters to be turned
  into spaces.  If \code{char.keep} is NULL,
  \code{char2space} will activate this argument.}
}
\value{
  Returns a series of word cloud plots with target words
  (themes) colored.
}
\description{
  Produces word clouds with optional theme coloring by
  grouping variable.
}
\examples{
terms <- list(
    I=c("i", "i'm"),
    mal=qcv(stinks, dumb, distrust),
    articles=qcv(the, a, an),
    pronoun=qcv(we, you)
)

with(DATA, trans.cloud(state, person, target.words=terms,
    cloud.colors=qcv(red, green, blue, black, gray65),
    expand.target=FALSE, proportional=TRUE))

with(DATA, trans.cloud(state, person, target.words=terms,
    stopwords=exclude(with(DATA, unique(bag.o.words(state))),
        unique(unlist(terms))),
    cloud.colors=qcv(red, green, blue, black, gray65),
    expand.target=FALSE, proportional=TRUE))
}
\seealso{
  \code{\link[wordcloud]{wordcloud}}
}
\keyword{wordcloud}

