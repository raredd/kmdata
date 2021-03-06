% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{ESPATUE_3}
\alias{ESPATUE_3}
\title{ESPATUE, figure 3}
\format{
A data frame of 161 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab PFS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (arma, armb) \cr
}
}
\source{
Eberhardt WEE, Pöttgen C, Gauler TC, et al. Phase III Study of
Surgery Versus Definitive Concurrent Chemoradiotherapy Boost in
Patients With Resectable Stage IIIA(N2) and Selected IIIB
Non-Small-Cell Lung Cancer After Induction Chemotherapy and
Concurrent Chemoradiotherapy (ESPATUE). J Clin Oncol 2015; 33:
4194–201.
}
\usage{
ESPATUE_3
}
\description{
Kaplan-Meier digitized data from ESPATUE, figure 3 (PMID 26527789). A reported sample size of 246 for a primary endpoint of OS in lung cancer.
}
\examples{
summary(ESPATUE_3)

kmplot(ESPATUE_3)
}
\keyword{datasets}
