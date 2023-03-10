% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ParSort.r
\name{parSort}
\alias{parSort}
\title{constructor for class parSort}
\usage{
parSort(
  n = 1,
  stH = 0,
  Lxh = 0,
  Hkz = 0L,
  Skz = 0L,
  Hsh = 0,
  Zsh = 0,
  Lsh = 0,
  Zab = 14,
  Lab = 0,
  Az = 0,
  LIh = 0,
  trL = 0,
  fixN = 0L,
  fixL = 0,
  fixZ = 0,
  fixA = 0,
  fixR = 0,
  ...
)
}
\arguments{
\item{n}{the number of parameter sets to generate, defaults to 1}

\item{stH}{stump height}

\item{Lxh}{length of unusable wood at stem foot, see details}

\item{Hkz}{height indicator, see details}

\item{Skz}{stem indicator, see details}

\item{Hsh}{height of stem wood, see details}

\item{Zsh}{cutting diameter of stem wood, see details}

\item{Lsh}{length of stem wood, see details}

\item{Zab}{cutting diameter of upper trunk, see details}

\item{Lab}{length of upper trunk, see details}

\item{Az}{minimal cutting diameter, defaults to 7cm, see details}

\item{LIh}{length of industrial wood, see details}

\item{trL}{maximum transport length}

\item{fixN}{number of fixed length assortments, see details}

\item{fixL}{length of fixed length assortments, see details}

\item{fixZ}{cutting diameter of fixed length assortments, see details}

\item{fixA}{absolute add-on for good measure of fixed length assortments,
given in cm; see details}

\item{fixR}{relative add-on for good measure of fixed length assortments,
given in percentage, i.e. 1\% = 1; see details}

\item{...}{currently unused}
}
\value{
an object of class \code{parSort}, i.e. a list, each element of
length \code{n} or maximum of length of defined parameters
}
\description{
function to call \code{new()} on class \code{parSort}
}
\details{
if n is not given (or one) and any of the other parameter is given
with length greater than one, n is reset to the maximum length of all
parameters; care should be taken when using n and individual parameter
setting for several trees.
}
