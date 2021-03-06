% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{AIO0207(a)_3C}
\alias{AIO0207(a)_3C}
\title{AIO0207(a), figure 3C}
\format{
A data frame of 314 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (5fu_bev, no_tx) \cr
}
}
\source{
Hegewisch-Becker S, Graeven U, Lerchenmüller CA, et al. Maintenance
strategies after first-line oxaliplatin plus fluoropyrimidine plus
bevacizumab for patients with metastatic colorectal cancer (AIO
0207): a randomised, non-inferiority, open-label, phase 3 trial.
Lancet Oncol 2015; 16: 1355–69.
}
\usage{
`AIO0207(a)_3C`
}
\description{
Kaplan-Meier digitized data from AIO0207(a), figure 3C (PMID 26361971). A reported sample size of 472 for a primary endpoint of time_tx_failure in colorectal cancer.
}
\examples{
summary(`AIO0207(a)_3C`)

kmplot(`AIO0207(a)_3C`)
}
\keyword{datasets}
