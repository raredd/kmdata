% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{PETACC8_3A}
\alias{PETACC8_3A}
\title{PETACC8, figure 3A}
\format{
A data frame of 1,602 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in years) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (folfox4, folfox4_cetuximab) \cr
}
}
\source{
Taieb J, Tabernero J, Mini E, et al. Oxaliplatin, fluorouracil, and
leucovorin with or without cetuximab in patients with resected stage
III colon cancer (PETACC-8): an open-label, randomised phase 3 trial.
Lancet Oncol 2014; 15: 862–73.
}
\usage{
PETACC8_3A
}
\description{
Kaplan-Meier digitized data from PETACC8, figure 3A (PMID 24928083). A reported sample size of 2,559 for a primary endpoint of DFS in colorectal cancer.
}
\examples{
summary(PETACC8_3A)

kmplot(PETACC8_3A)
}
\keyword{datasets}
