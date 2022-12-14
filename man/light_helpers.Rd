% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/light_helpers.R
\name{cheap_darken}
\alias{cheap_darken}
\alias{darken_face}
\title{'light' effect helper functions}
\usage{
cheap_darken(col, amount)

darken_face(
  face,
  col,
  top = 0,
  west = 0.2,
  east = 0.2,
  south = 0.4,
  north = 0.4,
  darken_fn = cheap_darken
)
}
\arguments{
\item{col}{Vector of colors to darken}

\item{amount}{Fraction to darken by}

\item{face}{Cube/cuboid face to color.  One of "top", "west", "east", "south", or "north".}

\item{top}{Amount to darken the "top" face.}

\item{west}{Amount to darken the "west" face.}

\item{east}{Amount to darken the "east" face.}

\item{south}{Amount to darken the "south" face.}

\item{north}{Amount to darken the "north" face.}

\item{darken_fn}{Function to darken with.  Should take two arguments:
the first should be the colour and the second should be numeric amount to darken by.
Default will be to use \code{\link[=cheap_darken]{cheap_darken()}}.
\code{colorspace::darken()} is a slower, \dQuote{better} alternative.}
}
\value{
Vector of darkened colors.
}
\description{
Helper functions to generate a \dQuote{light} effect
for \code{\link[=oblicubesGrob]{oblicubesGrob()}}, \code{\link[=grid.oblicubes]{grid.oblicubes()}}, \code{\link[=oblicuboidsGrob]{oblicuboidsGrob()}}, and \code{\link[=grid.oblicuboids]{grid.oblicuboids()}}.
\code{darken_face()} is the default \code{light} argument for \code{\link[=oblicubesGrob]{oblicubesGrob()}}, \code{\link[=grid.oblicubes]{grid.oblicubes()}},
\code{\link[=oblicuboidsGrob]{oblicuboidsGrob()}}, and \code{\link[=grid.oblicuboids]{grid.oblicuboids()}}.
\code{cheap_darken()} is the default darkening function used by \code{darken_face()}.
}
\details{
The \code{light} argument of \code{\link[=oblicubesGrob]{oblicubesGrob()}}, \code{\link[=grid.oblicubes]{grid.oblicubes()}}, \code{\link[=geom_oblicubes]{geom_oblicubes()}},
\code{\link[=oblicuboidsGrob]{oblicuboidsGrob()}}, \code{\link[=grid.oblicuboids]{grid.oblicuboids()}}, and \code{\link[=geom_oblicuboids]{geom_oblicuboids()}}
needs a function that that takes two arguments: the first is \code{face} one of its five faces:
"top", "west", "east", "south", or "north" and the second is \code{col} the cube/cuboid's fill color
}
\examples{
demo_light <- function(light = darken_face, ...) {
  df <- data.frame(x=1, y=1, z=1)
  grid::grid.newpage()
  grid.oblicubes(df, ..., light=light, angle=45, lwd=4,
                 vp = grid::viewport(0.25, 0.25, 0.5, 0.5))
  grid.oblicubes(df, ..., light=light, angle=135, lwd=4,
                 vp = grid::viewport(0.75, 0.25, 0.5, 0.5))
  grid.oblicubes(df, ..., light=light, angle=-45, lwd=4,
                 vp = grid::viewport(0.25, 0.75, 0.5, 0.5))
  grid.oblicubes(df, ..., light=light, angle=-135, lwd=4,
                 vp = grid::viewport(0.75, 0.75, 0.5, 0.5))
}
demo_light()
demo_light(fill = "gold")
demo_light(light = function(face, col)
             darken_face(face, col, top = 0.3,
                         west = 0.6, east = 0.6,
                         south = 0.0, north = 0.0)
)
demo_light(light = function(face, col) {
             n <- length(col)
             switch(face,
               top = rep_len("grey90", n),
               west = rep_len("red", n),
               east = rep_len("green", n),
               south = rep_len("blue", n),
               north = rep_len("yellow", n))
           })
}
