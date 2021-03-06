% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{NeoALTTO(b)_2D}
\alias{NeoALTTO(b)_2D}
\title{NeoALTTO(b), figure 2D}
\format{
A data frame of 301 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in years) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (lapatinib_trastuzumab, t) \cr
}
}
\source{
de Azambuja E, Holmes AP, Piccart-Gebhart M, et al. Lapatinib with
trastuzumab for HER2-positive early breast cancer (NeoALTTO):
survival outcomes of a randomised, open-label, multicentre, phase 3
trial and their association with pathological complete response.
Lancet Oncol 2014; 15: 1137–46.
}
\usage{
`NeoALTTO(b)_2D`
}
\description{
Kaplan-Meier digitized data from NeoALTTO(b), figure 2D (PMID 25130998). A reported sample size of 455 for a primary endpoint of pCR in breast cancer.
}
\examples{
summary(`NeoALTTO(b)_2D`)

kmplot(`NeoALTTO(b)_2D`)
}
\keyword{datasets}
