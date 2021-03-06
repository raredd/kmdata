% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{CA184-095_2A}
\alias{CA184-095_2A}
\title{CA184-095, figure 2A}
\format{
A data frame of 602 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (ipilimumab, placebo) \cr
}
}
\source{
Beer TM, Kwon ED, Drake CG, et al. Randomized, Double-Blind, Phase
III Trial of Ipilimumab Versus Placebo in Asymptomatic or Minimally
Symptomatic Patients With Metastatic Chemotherapy-Naive
Castration-Resistant Prostate Cancer. J Clin Oncol 2017; 35: 40–7.
}
\usage{
`CA184-095_2A`
}
\description{
Kaplan-Meier digitized data from CA184-095, figure 2A (PMID 28034081). A reported sample size of 602 for a primary endpoint of OS in prostate cancer.
}
\examples{
summary(`CA184-095_2A`)

kmplot(`CA184-095_2A`)
}
\keyword{datasets}
