% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{TRIBE(2)_2A}
\alias{TRIBE(2)_2A}
\title{TRIBE(2), figure 2A}
\format{
A data frame of 508 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab PFS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (folfiri_bevacizumab, folfoxiri_bevacizumab) \cr
}
}
\source{
Mayer RJ, Van Cutsem E, Falcone A, et al. Randomized trial of TAS-102
for refractory metastatic colorectal cancer. N Engl J Med 2015; 372:
1909–19.
}
\usage{
`TRIBE(2)_2A`
}
\description{
Kaplan-Meier digitized data from TRIBE(2), figure 2A (PMID 25970050). A reported sample size of 508 for a primary endpoint of PFS in colorectal cancer.
}
\examples{
summary(`TRIBE(2)_2A`)

kmplot(`TRIBE(2)_2A`)
}
\keyword{datasets}
