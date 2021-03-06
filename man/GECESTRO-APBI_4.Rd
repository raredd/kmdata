% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{GECESTRO-APBI_4}
\alias{GECESTRO-APBI_4}
\title{GECESTRO-APBI, figure 4}
\format{
A data frame of 1,184 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in years) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (apbi, wbi) \cr
}
}
\source{
Strnad V, Ott OJ, Hildebrandt G, et al. 5-year results of accelerated
partial breast irradiation using sole interstitial multicatheter
brachytherapy versus whole-breast irradiation with boost after
breast-conserving surgery for low-risk invasive and in-situ carcinoma
of the female breast: a randomised, phase 3, non-inferiority trial.
Lancet 2016; 387: 229–38.
}
\usage{
`GECESTRO-APBI_4`
}
\description{
Kaplan-Meier digitized data from GECESTRO-APBI, figure 4 (PMID 26494415). A reported sample size of 551 for a primary endpoint of LR in breast cancer.
}
\examples{
summary(`GECESTRO-APBI_4`)

kmplot(`GECESTRO-APBI_4`)
}
\keyword{datasets}
