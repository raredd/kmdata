% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{JFMC33-0502_2B}
\alias{JFMC33-0502_2B}
\title{JFMC33-0502, figure 2B}
\format{
A data frame of 1,060 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in years) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (control, study) \cr
}
}
\source{
Sadahiro S, Tsuchiya T, Sasaki K, et al. Randomized phase III trial
of treatment duration for oral uracil and tegafur plus leucovorin as
adjuvant chemotherapy for patients with stage IIB/III colon cancer:
final results of JFMC33-0502. Ann Oncol 2015; 26: 2274–80.
}
\usage{
`JFMC33-0502_2B`
}
\description{
Kaplan-Meier digitized data from JFMC33-0502, figure 2B (PMID 26347106). A reported sample size of 1,071 for a primary endpoint of DFS in colorectal cancer.
}
\examples{
summary(`JFMC33-0502_2B`)

kmplot(`JFMC33-0502_2B`)
}
\keyword{datasets}
