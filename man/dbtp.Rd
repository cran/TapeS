% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.r
\docType{data}
\name{dbtp}
\alias{dbtp}
\title{Data: Function Parameters to estimate double bark thickness}
\format{
A three-dimensional array, first dimension refer to species code,
second dimension to required function (stem part) and third dimension to the
required parameter.
}
\source{
BDAT-Fortran-library
}
\usage{
dbtp
}
\description{
Parameters for linear regression models to estimate double bark thickness
according to species, diameter over bark and stem part.
}
\examples{
data(dbtp)
dbtp[1,,]
dbtp[1,1,]

}
\references{
Kublin and Scharnagl, 1988.
}
\keyword{datasets}
