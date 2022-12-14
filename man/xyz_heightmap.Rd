% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xyz_heightmap.R
\name{xyz_heightmap}
\alias{xyz_heightmap}
\title{Calculate x,y,z coordinates from a height matrix}
\usage{
xyz_heightmap(
  mat,
  col = NULL,
  scale = 1,
  min = NULL,
  flipx = FALSE,
  flipy = TRUE,
  ground = "xy",
  solid = TRUE,
  verbose = FALSE
)
}
\arguments{
\item{mat}{integer matrix. The matrix will be interpreted as cubes (or cuboids) flat on the
page, with the value in the matrix interpreted as the height above the page.}

\item{col}{matrix, vector, or (palette) function of colours.
If a matrix it must be the same dimensions as the \code{mat} argument;
each cube/cuboid corresponding to that x,y value will have that color.
If a vector then if the max of \code{z} values is less than equal to the number
of colors we will use the \code{z} integers
as indices else we will use \code{\link[base:cut]{base::cut()}} to assign z values to colors.
If a function we will call it with the argument \code{max(z)} to create a
a vector of colors and then use the z values as indices.
If \code{col} is not NULL then a \code{fill} column will be included in the final returned coordinates.}

\item{scale}{scale factor for values in matrix. Default = 1}

\item{min}{Minimum target \code{z} value.  If \code{NULL} ignore else we "translate"
the z-values so the minimum z-value is equal to this value.}

\item{flipx, flipy}{Should the matrix be flipped in the horizontal/vertical directions (respectively)?
Note: \code{flipy} defaults to \code{TRUE} as matrices are indexed
from the top-down, but the coordinate space is increasing
from the bottom up.   Flipping the matrix vertically is usually
what you want.}

\item{ground}{Orientation of the ground plane. Default: "xy".  Possible
values "xy", "xz", "zy"}

\item{solid}{Should the heightmap be made 'solid' i.e. without holes?
This can be an expensive operation in terms of
both memory and CPU, but should be OK for simple examples.
Set to FALSE if things take too long or you will be rendering cuboids.
This operation works by extruding cubes down from the top of the height map to the floor to
ensure gaps do not appear when the slope is too great.}

\item{verbose}{Be verbose? default: FALSE}
}
\value{
A data frame of \code{x}, \code{y}, \code{z}, \code{raw}, and possibly \code{fill} columns.
The "raw" column is the (original) "z" column before any \code{scale}, \code{min}, and \code{ground}
transformations have been performed (it may be repeated "down" if \code{solid = TRUE}).
The "raw" column can be useful as the \code{fill} value in \code{ggplot2} plots especially
when adding a legend.
}
\description{
Calculate x,y,z coordinates from a height matrix
}
\examples{
if (require("grDevices") && require("grid")) {
  mat <- datasets::volcano
  mat <- 0.3 * (mat - min(mat)) + 1.0

  grid.newpage()
  grid.rect(gp=gpar(col=NA, fill="grey5"))
  width <- convertWidth(unit(0.007, "snpc"), "cm")

  # Top view
  pushViewport(viewport(width = 0.7, height = 0.7, x = 0.65, y = 0.65))
  coords <- xyz_heightmap(mat, col = terrain.colors, solid = FALSE)
  grid.oblicubes(coords, scale = 0, width = width, gp = gpar(col=NA))
  popViewport()

  # South view
  pushViewport(viewport(width = 0.7, height = 0.3, x = 0.65, y = 0.15))
  coords <- xyz_heightmap(mat, col = terrain.colors, ground = "xz")
  grid.oblicubes(coords, scale = 0, width = width, gp = gpar(col=NA))
  popViewport()

  # West view
  pushViewport(viewport(width = 0.3, height = 0.7, x = 0.15, y = 0.65))
  coords <- xyz_heightmap(mat, col = terrain.colors, ground = "zy")
  grid.oblicubes(coords, scale = 0, width = width, gp = gpar(col=NA))
  popViewport()
}
if (require("grDevices") && require("ggplot2")) {
  data("volcano", package = "datasets")
  df <- xyz_heightmap(volcano, scale = 0.3, min = 1, solid = FALSE)
  g <- ggplot(df, aes(x, y, z = z, fill = raw)) +
         geom_oblicuboids(light = FALSE) +
         coord_fixed() +
         scale_fill_gradientn(name = "Height (m)", colours=terrain.colors(256)) +
         labs(x = "East (10m)", y = "North (10m)", title = "Maungawhau (`datasets::volcano`)")
  plot(g)
}
}
