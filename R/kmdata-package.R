#' kmdata
#'
#' Re-constructed Kaplan-Meier data from publications gathered on
#' \href{https://pubmed.ncbi.nlm.nih.gov/}{PubMed}.
#' 
#' Data sets were gathered from PubMed and limited to phase 3, randomized
#' trials completed between January 1st 2014 and December 31st 2016 and
#' published by JAMA Oncology, New England Journal of Medicine, Lancet,
#' Lancet Oncology, Journal of Clinical Oncology, Annals of Oncology, Journal
#' of the American Medical Association, or Journal of the National Cancer
#' Institute.
#' 
#' The final list includs 263 figures from 152 publications. The data spans
#' four cancers: colorectal, lung, prostate, and breast. All data sets feature
#' time and event indicators as well as treatment arm (two arms per data set).
#' 
#' Additional information for each study is included in attributes of the data
#' objects or in the key data, \code{kmdata_key}. The key includes publication
#' identifiers, journal, title, outcome, sample size, etc.
#' 
#' This package also includes utilities to generate individual patient data
#' (IPD) from digitized survival curve data using the method described by
#' Guyot (2012); see \code{\link{ipd}}.
#' 
#' @seealso
#' \code{\link{kmdata_key}} for a list of the data sets available with some
#' additional information about each including data source, outcomes, disease
#' type, results, and quality of each re-capitulated data set.
#' 
#' \code{\link[=summary.kmdata]{summary}} for a method to summarize data sets
#' 
#' \code{\link{kmplot}} to plot Kaplan-Meier curves for each data set
#' 
#' \code{\link{select_kmdata}} to select studies based on characteristics
#' listed in the \code{\link{kmdata_key}}
#' 
#' @examples
#' ## all data sets included
#' data(package = 'kmdata')
#' 
#' 
#' ## basic usage
#' summary(ATTENTION_2A)
#' kmplot(ATTENTION_2B)
#' 
#' 
#' ## list of data sets estimating PFS
#' select_kmdata(Outcome %in% 'PFS')
#' 
#' 
#' ## list of studies in breast cancer with fewer than 200 patients
#' l <- select_kmdata(Cancer %in% 'Breast' & ReportedSampleSize < 200, return = 'data')
#' par(mfrow = n2mfrow(length(l)))
#' sapply(l, kmplot)
#'
#' @name kmdata-package
#' @aliases kmdata
#' 
#' @import survival
#' 
#' @importFrom fdrtool monoreg
#' @importFrom graphics axis box grconvertX hist mtext par text
#' @importFrom stats as.formula pchisq terms
"_PACKAGE"
