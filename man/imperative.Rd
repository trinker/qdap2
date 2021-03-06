\name{imperative}
\alias{imperative}
\title{Intuitively Remark Sentences as Imperative}
\usage{
  imperative(dataframe, person.var, text.var,
    lock.incomplete = FALSE, additional.names = NULL,
    parallel = FALSE, warning = FALSE)
}
\arguments{
  \item{dataframe}{A data.frame object.}

  \item{person.var}{The person variable.}

  \item{text.var}{The text variable.}

  \item{lock.incomplete}{logical.  If TRUE locks incomplete
  sentences (sentences ending with "|") from being marked
  as imperative.}

  \item{additional.names}{Additional names that may be used
  in a command (people in the context that do not speak).}

  \item{parallel}{logical.  If TRUE attempts to run the
  function on multiple cores.  Note that this may not mean
  a speed boost if you have one core or if the data set is
  smaller as the cluster takes time to create.  With the
  \code{mraja1spl} data set, with an 8 core machine,
  \code{\link[qdap]{imperative}} had 1/3 the running time.}

  \item{warning}{logical.  If TRUE provides comma warnings
  (sentences that contain numerous commas that may be
  handled incorrectly by the algorithm).}
}
\value{
  Returns a dataframe with a text variable indicating
  imperative sentences.  Imperative sentences are marked
  with * followed by the original end mark.
}
\description{
  Automatic imperative remarking.
}
\section{Warning}{
  The algorithm used by \code{\link[qdap]{imperative}} is
  sensitive to English language dialects and types.  Commas
  can indicate a choppy sentence and may indicate a false
  positive.
}
\examples{
dat <- data.frame(name=c("sue", rep(c("greg", "tyler", "phil",
    "sue"), 2)), statement=c("go get it|", "I hate to read.",
    "Stop running!", "I like it!", "You are terrible!", "Don't!",
    "Greg, go to the red, brick office.", "Tyler go to the gym.",
    "Alex don't run."), stringsAsFactors = FALSE)

imperative(dat, "name", "statement", , c("Alex"))
imperative(dat, "name", "statement", lock.incomplete = TRUE, c("Alex"))
imperative(dat, "name", "statement", , c("Alex"), warning=TRUE)
imperative(dat, "name", "statement", , c("Alex"), warning=TRUE,
    parallel = TRUE)
}

