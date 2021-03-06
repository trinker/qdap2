\name{gantt_wrap}
\alias{gantt_wrap}
\title{Gantt Plot}
\usage{
  gantt_wrap(dataframe, plot.var, facet.vars = NULL,
    fill.var = NULL, title = NULL,
    ylab = as.character(plot.var),
    xlab = "duration.default", rev.factor = TRUE,
    transform = FALSE, ncol = NULL, minor.line.freq = NULL,
    major.line.freq = NULL, sig.dig.line.freq = 1,
    hms.scale = NULL, scale = NULL, space = NULL, size = 3,
    rm.horiz.lines = FALSE, x.ticks = TRUE, y.ticks = TRUE,
    legend.position = NULL, bar.color = NULL,
    border.color = NULL, border.size = 2,
    border.width = 0.1, constrain = TRUE)
}
\arguments{
  \item{dataframe}{A data frame with plotting variable(s)
  and a column of start and end times.}

  \item{plot.var}{A factor plotting variable (y axis).}

  \item{facet.vars}{An optional single vector or list of 1
  or 2 to facet by.}

  \item{fill.var}{An optional variable to fill the code
  strips by.}

  \item{title}{An optional title for the plot.}

  \item{ylab}{An optional y label.}

  \item{xlab}{An optional x label.}

  \item{rev.factor}{logical.  If TRUE reverse the current
  plotting order so the first element in the plotting
  variable's levels is plotted on top.}

  \item{ncol}{if an integer value is passed to this
  \code{\link[qdap]{gantt_wrap}} uses
  \code{\link[ggplot2]{facet_wrap}} rather than
  \code{\link[ggplot2]{facet_grid}}.}

  \item{transform}{logical.  If TRUE the repeated facets
  will be transformed from stacked to side by side.}

  \item{minor.line.freq}{A numeric value for frequency of
  minor grid lines.}

  \item{major.line.freq}{A numeric value for frequency of
  major grid lines.}

  \item{sig.dig.line.freq}{An internal rounding factor for
  minor and major line freq.  Generally, default value of 1
  suffices for larger range of x scale may need to be set
  to -2..}

  \item{hms.scale}{logical.  If TRUE converts scale to
  h:m:s format.  Default NULL attempts to detect if object
  is a cm_time2long object}

  \item{scale}{Should scales be fixed (\code{"fixed"}, the
  default), free (\code{"free"}), or free in one dimension
  (\code{"free_x"}, \code{"free_y"})}

  \item{space}{If \code{"fixed"}, the default, all panels
  have the same size. If \code{"free_y"} their height will
  be proportional to the length of the y scale; if
  \code{"free_x"} their width will be proportional to the
  length of the x scale; or if \code{"free"} both height
  and width will vary. This setting has no effect unless
  the appropriate scales also vary.}

  \item{size}{The width of the plot bars.}

  \item{rm.horiz.lines}{logical.  If TRUE the horizontal
  lines will be removed.}

  \item{x.ticks}{logical.  If TRUE the x ticks will be
  displayed.}

  \item{y.ticks}{logical.  If TRUE the y ticks will be
  displayed.}

  \item{legend.position}{The position of legends.
  (\code{"left"}, \code{"right"}, \code{"bottom"},
  \code{"top"}, or two-element numeric vector).}

  \item{bar.color}{Optional color to constrain all bars.}

  \item{border.color}{The color to plot border around Gantt
  bars (default is NULL).}

  \item{border.size}{An integer value for the size to plot
  borders around Gantt bars. Controls length (width also
  controlled if not specified).}

  \item{border.width}{Controls border width around Gantt
  bars.  Use a numeric value in addition to border size if
  plot borders appear disproportional.}

  \item{constrain}{logical.  If TRUE the Gantt bars touch
  the edge of the graph.}
}
\value{
  Returns a Gantt style visualization. Invisibly returns
  the ggplot2 list object.
}
\description{
  A \href{http://docs.ggplot2.org/current/}{ggplot2}
  wrapper that produces a Gantt plot.
}
\note{
  For non repeated measures data/plotting use
  \code{\link[qdap]{gantt}}; for repeated measures data
  output use \code{\link[qdap]{gantt_rep}}; and for a
  convenient wrapper that takes text and generates plots
  use \code{\link[qdap]{gantt_plot}}.
}
\examples{
dat <- gantt(mraja1$dialogue, list(mraja1$fam.aff, mraja1$sex),
    units = "sentences", plot.colors = 'black', sums = TRUE,
    col.sep = "_")$gantt.df
htruncdf(dat)
gantt_wrap(dat, fam.aff_sex, title = "Gantt Plot")
dat$codes <- sample(LETTERS[1:3], nrow(dat), TRUE)
gantt_wrap(dat, fam.aff_sex, fill.var = "codes",
    legend.position = "bottom")

dat2 <- with(rajSPLIT, gantt_rep(act, dialogue,
    list(fam.aff, sex), units = "words", col.sep = "_"))
htruncdf(dat2)
x <- gantt_wrap(dat2, fam.aff_sex, facet.vars = "act",
    title = "Repeated Measures Gantt Plot")

library(ggplot2); library(scales); library(RColorBrewer)
x + scale_color_manual(values=rep("black",
    length(levels(dat2$fam.aff_sex))))
}
\author{
  Andrie de Vries and Tyler Rinker
  <tyler.rinker@gmail.com>.
}
\references{
  Clark, W. & Gantt, H. (1922) The Gantt chart, a working
  tool of management. New York, Ronald Press.
}
\seealso{
  \code{\link[qdap]{gantt}},
  \code{\link[qdap]{gantt_plot}},
  \code{\link[qdap]{gantt_rep}},
  \code{\link[ggplot2]{facet_grid}},
  \code{\link[ggplot2]{facet_wrap}}
}
\keyword{Gantt}

