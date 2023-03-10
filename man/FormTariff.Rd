% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FormTarif.r
\name{FormTariff}
\alias{FormTariff}
\title{Tariff for taper form}
\usage{
FormTariff(spp, Dbh, Ht, inv)
}
\arguments{
\item{spp}{species code of \code{tprSpeciesCode}}

\item{Dbh}{diameter of considered tree at 1.3m above ground [cm]}

\item{Ht}{tree height of considered tree [m]}

\item{inv}{indicator for inventory (0=TapeS taper curve models,
1=NFI1, 2=NsoG, 3=IS08, 4=NFI3, 5=BDAT)}
}
\value{
quotient of d03 / d005 [unitless]
}
\description{
evaluates tariff functions to estimate taper form, i.e. quotient
of d03 by d005
}
\examples{
## dont't run
spp <- 15
Dbh <- 30
Ht <- 27
FormTariff(spp, Dbh, Ht, 0)
FormTariff(spp=c(1:2), Dbh=c(30, 30), Ht=c(27, 24), inv=0)
if(require("rBDAT")){
  FormTariff(spp, Dbh, Ht, 0)
  rBDAT::getForm(list(spp=spp, D1=Dbh, H1=1.3, H=Ht), inv=0) # different taper curves!
  FormTariff(spp, Dbh, Ht, 1)
  rBDAT::getForm(list(spp=spp, D1=Dbh, H1=1.3, H=Ht), inv=1) # identical
  FormTariff(spp, Dbh, Ht, 2)
  rBDAT::getForm(list(spp=spp, D1=Dbh, H1=1.3, H=Ht), inv=2) # identical
  FormTariff(spp, Dbh, Ht, 3)
  rBDAT::getForm(list(spp=spp, D1=Dbh, H1=1.3, H=Ht), inv=3) # identical
  FormTariff(spp, Dbh, Ht, 4)
  rBDAT::getForm(list(spp=spp, D1=Dbh, H1=1.3, H=Ht), inv=4) # identical
}

}
\references{
c.f. rBDAT::getForm respectively BDAT source code FormTarif.f
}
