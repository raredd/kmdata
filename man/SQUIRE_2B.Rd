% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{SQUIRE_2B}
\alias{SQUIRE_2B}
\title{SQUIRE, figure 2B}
\format{
A data frame of 1,093 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab PFS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (gem_cis, necitumumab_gem_cis) \cr
}
}
\source{
Thatcher N, Hirsch FR, Luft AV, et al. Necitumumab plus gemcitabine
and cisplatin versus gemcitabine and cisplatin alone as first-line
therapy in patients with stage IV squamous non-small-cell lung cancer
(SQUIRE): an open-label, randomised, controlled phase 3 trial. Lancet
Oncol 2015; 16: 763–74.
}
\usage{
SQUIRE_2B
}
\description{
Kaplan-Meier digitized data from SQUIRE, figure 2B (PMID 26045340). A reported sample size of 1,093 for a primary endpoint of OS in lung cancer.
}
\examples{
summary(SQUIRE_2B)

kmplot(SQUIRE_2B)
}
\keyword{datasets}
