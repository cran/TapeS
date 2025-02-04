% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tprBiomass.r
\name{tprBiomass}
\alias{tprBiomass}
\alias{tprBiomass,tprTrees-method}
\title{total aboveground and component biomass}
\usage{
tprBiomass(
  obj,
  component = NULL,
  useNFI = TRUE,
  interval = "none",
  mono = TRUE,
  Rfn = NULL
)

\S4method{tprBiomass}{tprTrees}(
  obj,
  component = NULL,
  useNFI = TRUE,
  interval = "none",
  mono = TRUE,
  Rfn = NULL
)
}
\arguments{
\item{obj}{object of class 'tprTrees'}

\item{component}{component for which biomass should be returned. If NULL,
total aboveground biomass is returned, if 'all', all components are returned.
See details.}

\item{useNFI}{if \code{TRUE}, agb is estimated by the NFI-functions and
component estimates are scaled so that their sum (i.e. agb) equals the
estimate of the NFI functions. If \code{FALSE}, the NSUR functions are used
for agb and component estimates.}

\item{interval}{character to indicate whether and which type of interval is
required; one of \code{none}, \code{confidence} or \code{prediction}.}

\item{mono}{logical, defaults to true. If calibrated taper curve is
non-monotonic at stem base, a support diameter is added.}

\item{Rfn}{Rfn setting for residuals error matrix, defaults to
\code{list(fn="sig2")}, see \code{\link[TapeR]{resVar}}.}
}
\value{
a vector in case agb or only one component is requested, otherwise
a matrix with one row per tree
}
\description{
calculate total above ground and optionally component biomass
for given trees
}
\details{
The available components are agb (= total aboveground biomass),
stw (=stump wood), stb (=stump bark), sw (=solid wood with diameter above
 7cm over bark), sb (=bark of component sw), fwb (=fine wood incl. bark)
 and ndl (=needles), if applicable. The needles-component is set to zero for
 deciduous tree species, no mass for leaves is available. One can request
 'all' components to receive all components.
}
\section{Methods (by class)}{
\itemize{
\item \code{tprBiomass(tprTrees)}: method for class 'tprTrees'

}}
\examples{
obj <- tprTrees(spp=c(1, 15),
                Dm=list(c(30, 28), c(30, 28)),
                Hm=list(c(1, 3), c(1, 3)),
                Ht = rep(30, 2))
(tmp <- tprBiomass(obj, component="all"))

tprBiomass(obj, component=NULL) # aboveground biomass
component <- c("agb", "sw", "sb", "ndl")
tprBiomass(obj, component=component)
component <- c("sw", "sb", "ndl")
tprBiomass(obj, component="all")
# use NSUR-functions from Vonderach et al. 2018
# obs: currently sth=1\% of tree height
# and kl=70\% of tree height
tprBiomass(obj, component="all",  useNFI = FALSE)

## getting confidence and prediction intervals
useNFI <- FALSE
interval <- "confidence"
component <- c("sw", "agb")
tprBiomass(obj, component, useNFI, interval)
tprBiomass(obj, component, useNFI, interval="none")
tprBiomass(obj, component, useNFI=TRUE, interval)
tprBiomass(obj, component, useNFI=TRUE, interval="none")

obj <- tprTrees(spp=15, Dm=30, Hm=1.3, Ht=27)
tprBiomass(obj, component="all", interval="confidence")
tprBiomass(obj, component="ndl", interval="confidence")

obj <- tprTrees(spp=c(1, 15), Dm=c(30, 30), Hm=c(1.3, 1.3), Ht=c(27, 27))
tprBiomass(obj, component="all", interval="confidence")

obj <- tprTrees(spp=c(1, 15), Dm=c(30, 30), Hm=c(1.3, 1.3), Ht=c(27, 27))
tprBiomass(obj, component=c("sw", "ndl"), interval="confidence")

obj <- tprTrees(spp=c(1, 15), Dm=c(30, 30), Hm=c(1.3, 1.3), Ht=c(27, 27))
tprBiomass(obj, component=c("ndl", "agb"), interval="confidence")

obj <- tprTrees(spp=c(1, 15), Dm=c(30, 30), Hm=c(1.3, 1.3), Ht=c(27, 27))
tprBiomass(obj, component=c("ndl"), interval="confidence")
}
\references{
Kändler, G. and B. Bösch (2012). Methodenentwicklung für die
3. Bundeswaldinventur: Modul 3 Überprüfung und Neukonzeption einer
Biomassefunktion - Abschlussbericht. Im Auftrag des Bundesministeriums für
Ernährung, Landwirtschaft und Verbraucherschutz in Zusammenarbeit mit dem
Institut für Waldökologie und Waldinventur des Johann Heinrich von
Thünen-Instituts, FVA-BW: 71.

Kaendler (2021): Biometrische Modelle für die Ermittlung des Holzvorrats,
seiner Sortimentsstruktur und der oberirdischen Biomasse im Rahmen der
Bundeswaldinventur. Allg. Forst- u. J.-Ztg., 191. Jg., 5/6 83

Vonderach, C., G. Kändler and C. Dormann (2018): Consistent set of additive
biomass equations for eight tree species in Germany fitted by nonlinear
seemingly unrelated regression. Annals of Forest Science (2018) 75:49
doi: 10.1007/s13595-018-0728-4
}
