% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{FALCON_2}
\alias{FALCON_2}
\title{FALCON, figure 2}
\format{
A data frame of 462 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab PFS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (anastrazole, fulvestrant) \cr
}
}
\source{
Robertson JFR, Bondarenko IM, Trishkina E, et al. Fulvestrant 500 mg
versus anastrozole 1 mg for hormone receptor-positive advanced breast
cancer (FALCON): an international, randomised, double-blind, phase 3
trial. Lancet 2016; 388: 2997–3005.
}
\usage{
FALCON_2
}
\description{
Kaplan-Meier digitized data from FALCON, figure 2 (PMID 27908454). A reported sample size of 462 for a primary endpoint of PFS in breast cancer.
}
\examples{
summary(FALCON_2)

kmplot(FALCON_2)
}
\keyword{datasets}
