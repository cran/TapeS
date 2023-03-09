#' @title total aboveground and component biomass
#' @description calculate total above ground and optionally component biomass
#' for given trees
#' @param obj object of class 'tprTrees'
#' @param component component for which biomass should be returned. If NULL,
#' total aboveground biomass is returned, if 'all', all components are returned.
#' See details.
#' @param mono logical, defaults to true. If calibrated taper curve is
#' non-monotonic at stem base, a support diameter is added.
#' @param Rfn Rfn setting for residuals error matrix, defaults to
#' \code{list(fn="sig2")}, see \code{\link[TapeR]{resVar}}.
#' @details The available components are agb (= total aboveground biomass),
#' stw (=stump wood), stb (=stump bark), sw (=solid wood with diameter above
#'  7cm over bark), sb (=bark of component sw), fwb (=fine wood incl. bark)
#'  and ndl (=needles), if applicable. The needles-component is set to zero for
#'  deciduous tree species, no mass for leaves is available. One can request
#'  'all' components to receive all components.
#' @return  a vector in case agb or only one component is requested, otherwise
#' a matrix with one row per tree
#' @references Kändler, G. and B. Bösch (2012). Methodenentwicklung für die
#' 3. Bundeswaldinventur: Modul 3 Überprüfung und Neukonzeption einer
#' Biomassefunktion - Abschlussbericht. Im Auftrag des Bundesministeriums für
#' Ernährung, Landwirtschaft und Verbraucherschutz in Zusammenarbeit mit dem
#' Institut für Waldökologie und Waldinventur des Johann Heinrich von
#' Thünen-Instituts, FVA-BW: 71.
#'
#' Kaendler (2021): AFJZ article, in press.
#' @export
#' @examples
#' obj <- tprTrees(spp=c(1, 15),
#'                 Dm=list(c(30, 28), c(30, 28)),
#'                 Hm=list(c(1, 3), c(1, 3)),
#'                 Ht = rep(30, 2))
#' ## OBS: component 'ndl' NOT included to aboveground biomass 'agb'
#' (tmp <- tprBiomass(obj, component="all"))
#' rowSums(tmp[, -which(colnames(tmp) %in% c("agb", "ndl"))])
#' ## equal to
#' tmp$agb
#' tprBiomass(obj, component=NULL) # aboveground biomass
#' component <- c("agb", "sw", "sb", "ndl")
#' tprBiomass(obj, component=component)
#' component <- c("sw", "sb", "ndl")
#' tprBiomass(obj, component=component)


setGeneric("tprBiomass",
           function(obj, component=NULL, mono=TRUE, Rfn=NULL) standardGeneric("tprBiomass"))

#' @describeIn tprBiomass method for class 'tprTrees'
setMethod("tprBiomass", signature = "tprTrees",
          function(obj, component=NULL, mono=TRUE, Rfn=NULL){

            if(!is.null(Rfn)){
              old <- options()$TapeS_Rfn
              options(TapeS_Rfn = Rfn)
              on.exit(options(TapeS_Rfn = old))
            }
            if(!identical(mono, oldmono <- options()$TapeS_mono)){
              options("TapeS_mono" = mono)
              on.exit(options("TapeS_mono" <- oldmono))
            }

            if(is.null(component)){
              comp <- "agb"
            } else if(identical(component, "all")){
              comp <- c("stw", "stb", "sw", "sb", "fwb", "ndl", "agb")
            } else if(!all(component %in% c("stw", "stb", "sw", "sb",
                                            "fwb", "ndl", "agb"))){
              stop("'component' wrong! use 'stw', 'stb', 'sw', 'sb', ",
                       "'fwb', 'ndl' and/or 'agb'")
            } else {
              comp <- component
            }
            d13 <- D13(obj)
            d03 <- D03(obj)
            ## getting the agb biomass from Kaendler and Boesch 2013
            bwiBm <- biomass(BaMap(obj@spp, 6), d13, d03, obj@Ht)
            ## if components are required, use shares from BmComp-Function
            if(!all(comp %in% "agb")){ ## further comps beside 'agb'
              ## get the component shares from separate functions
              ## (c.f. Vonderach et al. 2018, but re-fitted using D03 and KL)
              sppBmC <- BaMap(obj@spp, 7) # ba code mapping to comp-functions
              nsurBm <- as.data.frame( nsur(sppBmC, dbh = d13, ht = obj@Ht,
                                            sth = 0.01*obj@Ht, d03 = d03,
                                            kl = 0.7 * obj@Ht) )

              nsurBm$agb <- rowSums(nsurBm[, -which(colnames(nsurBm)=="id")])
              # nsurBm$agb <- rowSums(nsurBm[, -which(colnames(nsurBm)%in%c("id", "ndl"))])
              # if("ndl" %in% comp){
              #   ndl <- nsurBm$ndl
              #   ndlshare <- ndl / nsurBm$agb
              #   comp <- comp[!grepl("ndl", comp)]
              # } else {
              #   ndlshare <- NULL
              # }
              # nsurBm$ndl <- NULL # 'ndl' not in BWI-Biomass included
              bmshare <- nsurBm[, comp, drop=FALSE] / nsurBm$agb
              res <- apply(bmshare[, comp, drop=FALSE],
                           MARGIN = 2,
                           function(m){ bwiBm * m }, simplify = FALSE)
              res <- as.data.frame(res)
              # if(!is.null(ndlshare)){
              #   res$ndl <- bwiBm * ndlshare
              # }
            } else {
              res <- bwiBm
            }

            return(res)
          })
