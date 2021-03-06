% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{CEREBEL_2B}
\alias{CEREBEL_2B}
\title{CEREBEL, figure 2B}
\format{
A data frame of 540 observations and 3 variables:
\tabular{lll}{
\tab \code{time} \tab event time (in months) \cr
\tab \code{event} \tab OS event indicator (\code{0}: no event, \code{1}: event) \cr
\tab \code{arm} \tab treatment arms (lapatinib_cape, trastuzumab_cape) \cr
}
}
\source{
Pivot X, Manikhas A, Żurawski B, et al. CEREBEL (EGF111438): A Phase
III, Randomized, Open-Label Study of Lapatinib Plus Capecitabine
Versus Trastuzumab Plus Capecitabine in Patients With Human Epidermal
Growth Factor Receptor 2-Positive Metastatic Breast Cancer. J Clin
Oncol 2015; 33: 1564–73.
}
\usage{
CEREBEL_2B
}
\description{
Kaplan-Meier digitized data from CEREBEL, figure 2B (PMID 25605838). A reported sample size of 540 for a primary endpoint of Incidence_CNSmets in breast cancer.
}
\examples{
summary(CEREBEL_2B)

kmplot(CEREBEL_2B)
}
\keyword{datasets}
