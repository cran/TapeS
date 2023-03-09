#' Data: Taper Curve models fit using R-Package TapeR
#'
#' Taper curve models based on a large data base of sectional measurements and
#' fit by \code{\link[TapeR]{TapeR_FIT_LME.f}}.
#'
#' @details These taper curve models were developed for this package based on a
#' collection of sectional measurements from several german forest research
#' stations (FVA-BW, LFE, NW-FVA, TUM) and french ONF. Details for model fitting
#' can be found in the corresponding report.
#'
#' Data used to fit the models consists of
#' \itemize{
#'  \item{Norway spruce: }{n=15181, n_D=156501}
#'  \item{European silver fir: }{n=7263, n_D=58988}
#'  \item{Douglas fir: }{n=12019, n_D=116349}
#'  \item{Scotch pine: }{n=11844, n_D=130379}
#'  \item{larch: }{n=2816, n_D=25490}
#'  \item{beech: }{n=16105, n_D=142691}
#'  \item{oak (robur/petraea): }{n=12341, n_D=97754}
#'  \item{Red oak: }{n=5411, n_D=43575}
#' }
#' where n=number of trees and n_D=number of diameter measurements included.
#'
#' @format A list with eight elements, each a TapeR taper curve model, fit
#' using \code{\link[TapeR]{TapeR_FIT_LME.f}}. Additionally, these objects
#' carry two attributes: \code{spp} and \code{name}, the first refering to the
#' species code (cf. \code{\link{tprSpeciesCode}}) and the second
#' to the abbreviated german species name. These eight models refer to
#' the different tree species: Norway Spruce, Silver fir, Douglas fir, Scots
#' pine, European larch, European Beech, Oak and Northern red oak.
#' The spp-attributed is evaluated e.g. by the bark functions
#' @source data collection of sectionally measured trees compiled by
#' FVA-BW \url{https://www.fva-bw.de}
#' @references Vonderach und Kändler (2021): Neuentwicklung von
#' Schaftkurvenmodellen für die Bundeswaldinventur auf Basis des TapeR-Pakets.
#' Abschlussbericht zum Projekt BWI-TapeR im Auftrag des Thüneninstituts für
#' Waldökosysteme.
#' @examples
#' data(SKPar)
#' @keywords datasets
"SKPar"

#' Data: Percentage of unusable wood in Beech and Oak in Germany
#'
#' This data gives percentage of unusable wood according to species (beech or
#' oak) and 2cm-diameter classes and cutting diameter. Data was taken from
#' BDAT-Fortran-library.
#'
#' @format A three-dimensional array.
#' @source BDAT-Fortran-library
#' @references none, yet.
#' @examples
#' data(unvd)
#' dim(unvd)
#' dbh <- 40 # diameter in breast height
#' cd <- 10 # cutting diameter
#' unvd[1, floor(dbh/2), cd]
#' @keywords datasets
"unvd"

#' Data: Function Parameters to estimate cutting diameter
#'
#' Parameters for linear regression model of form
#' Az=exp(p1+p2*log(dbh)+p3*(log(dbh)^2)+p4*dbh).
#' Function returns expected cutting diameter according to species and diameter
#' in breast height (dbh). Parameters taken from source code of BDAT.
#'
#' The implemented species are (column=species name):
#' 1=Norway spruce (S-Dt)
#' 2=Norway spruce (N-Dt)
#' 3=Silver fir
#' 4=Scots pine
#' 5=European larch
#' 6=European beech
#' 7=Quercus petraea and robur, possibly rubra
#'
#' @format A two-dimensional array. rows refer to species, columns to parameter
#' of linear model.
#' @source BDAT-Fortran-library
#' @references Kublin and Scharnagl, 1988.
#' @examples
#' data(azp)
#' dim(azp)
#' azp[1,] # 1=Norway spruce (S-Dt)
#' dbh <- 30
#' exp(azp[1,1]+azp[1,2]*log(dbh)+azp[1,3]*(log(dbh)^2)+azp[1,4]*dbh) # as implemented
#'
#' @keywords datasets
"azp"

#' Data: Function Parameters to estimate double bark thickness
#'
#' Parameters for linear regression models to estimate double bark thickness
#' according to species, diameter over bark and stem part.
#'
#' @format A three-dimensional array, first dimension refer to species code,
#' second dimension to required function (stem part) and third dimension to the
#' required parameter.
#' @source BDAT-Fortran-library
#' @references Kublin and Scharnagl, 1988.
#' @examples
#' data(dbtp)
#' dbtp[1,,]
#' dbtp[1,1,]
#'
#' @keywords datasets
"dbtp"

#' Data: Volume (cbm over bark) according to FAO definition for trees with
#' dbh less than 7cm
#'
#' This data keeps the volume according to FAO definition in cubic meter
#' including bark for trees with dbh < 7cm. Data discriminates according to
#' species and diameter class (class mid at 25mm, 55mm and 65mm).
#'
#' @format A two-dimensional array.
#' @source Riedel et al. 2017, table 5.6, p. 35
#' @references Riedel et al 2017: Die Dritte Bundeswaldinventur BWI 2012,
#' Inventur und Auswertemethoden, Eberswalde November 2017.
#' @examples
#' data(volfaodlt7)
#' dim(volfaodlt7)
#' dbhclass <- 3 # classified diameter in breast height, i.e. 3=50-60mm
#' sp <- 10 # species code
#' volfaodlt7[BaMap(sp, 8), 3]
#' @keywords datasets
"volfaodlt7"

#' Data: Crown wood expansion models to include branch coarse wood
#'
#' This data gives percentage of branch coarse wood (as difference between TapeS
#' and BDAT taper curves) with respect to BDAT crown coarse wood. With these
#' models one can expand the TapeS main axis crown coarse wood into total
#' crown coarse wood. Yet, a clear volume reference of very large trees - the
#' case, where expansion seems to be necessary - does not exists.
#'
#' @format a list with two elemens, each a (GAM) model
#' @source based on comparison between BDAT and TapeS
#' @references none, yet.
#' @examples
#' data(crownExpansion)
#' str(crownExpansion, max.level=1)
#' @keywords datasets
"crownExpansion"
