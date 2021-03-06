% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{LEA_2C}
\alias{LEA_2C}
\title{LEA, figure 2C}
\format{
A data frame of 374 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (et, et_b) \cr
}
}
\source{
Martín M, Loibl S, von Minckwitz G, et al. Phase III trial evaluating
the addition of bevacizumab to endocrine therapy as first-line
treatment for advanced breast cancer: the letrozole/fulvestrant and
avastin (LEA) study. J Clin Oncol 2015; 33: 1045–52.
}
\usage{
LEA_2C
}
\description{
Kaplan-Meier digitized data from LEA, figure 2C (PMID 25691671). A reported sample size of 374 for a primary endpoint of PFS in breast cancer.
}
\examples{
summary(LEA_2C)

kmplot(LEA_2C)
}
\keyword{datasets}
