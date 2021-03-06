% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{COUAA202_2}
\alias{COUAA202_2}
\title{COUAA202, figure 2}
\format{
A data frame of 1,088 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (abiraterone, placebo) \cr
}
}
\source{
Ryan CJ, Smith MR, Fizazi K, et al. Abiraterone acetate plus
prednisone versus placebo plus prednisone in chemotherapy-naive men
with metastatic castration-resistant prostate cancer (COU-AA-302):
final overall survival analysis of a randomised, double-blind,
placebo-controlled phase 3 study. Lancet Oncol 2015; 16: 152–60.
}
\usage{
COUAA202_2
}
\description{
Kaplan-Meier digitized data from COUAA202, figure 2 (PMID 25601341). A reported sample size of 1,088 for a primary endpoint of rPFS/OS in prostate cancer.
}
\examples{
summary(COUAA202_2)

kmplot(COUAA202_2)
}
\keyword{datasets}
