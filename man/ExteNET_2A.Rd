% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{ExteNET_2A}
\alias{ExteNET_2A}
\title{ExteNET, figure 2A}
\format{
A data frame of 2,840 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab DFS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (neratinib, placebo) \cr
}
}
\source{
Chan A, Delaloge S, Holmes FA, et al. Neratinib after
trastuzumab-based adjuvant therapy in patients with HER2-positive
breast cancer (ExteNET): a multicentre, randomised, double-blind,
placebo-controlled, phase 3 trial. Lancet Oncol 2016; 17: 367–77.
}
\usage{
ExteNET_2A
}
\description{
Kaplan-Meier digitized data from ExteNET, figure 2A (PMID 26874901). A reported sample size of 2,840 for a primary endpoint of iDFS in breast cancer.
}
\examples{
summary(ExteNET_2A)

kmplot(ExteNET_2A)
}
\keyword{datasets}
