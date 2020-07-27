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
#' @docType package
#' @import survival
#' @importFrom graphics axis box grconvertX hist mtext par text
#' @importFrom stats as.formula pchisq terms
NULL

#' \code{kmdata} key
#' 
#' Description of data sets available in \code{kmdata} package.
#' 
#' @format
#' A data frame of 304 observations and 29 variables:
#' 
#' \tabular{lll}{
#' 
#' \tab \code{name} \tab a unique data set identifier; use this to access data
#'   sets for analysis \cr
#' \tab \code{Journal} \tab the publishing journal \cr
#' \tab \code{PubMedID} \tab the publication PubMed identifier \cr
#' \tab \code{TrialRegistration} \tab trial registration identifier, if
#'   applicable; for example, the ClinicalTrials.gov identifier (NCT number)
#'   or other \cr
#' \tab \code{Title} \tab publication title \cr
#' \tab \code{Year} \tab publication year \cr
#' \tab \code{ClinicalTrial} \tab unique clinical trial identifier; note that
#'   \code{ClinicalTrial} and \code{Figure} are joined to create the unique
#'   trial-figure identifier, \code{name} \cr
#' \tab \code{Figure} \tab figure identifier; note that \code{ClinicalTrial}
#'   and \code{Figure} are joined to create the unique trial-figure
#'   identifier, \code{name} \cr
#' \tab \code{Cancer} \tab study cancer type \cr
#' \tab \code{Subgroups} \tab subgroups studied, if any \cr
#' \tab \code{ReportedSampleSize} \tab overall study sample size \cr
#' \tab \code{RandomizationRatio} \tab the ratio of patients randomized to
#'   each study arm \cr
#' \tab \code{RandomizationType} \tab treatment characteristic by which
#'   patients were randomized, e.g., patients randomized to receive different
#'   dose levels, durations or timing of therapy, or therapy agent \cr
#' \tab \code{TrialDesign} \tab trial design, i.e., superiority,
#'   inferiority, or both \cr
#' \tab \code{Metastatic} \tab indicator of metastatic or non-metastatic
#'   cancer \cr
#' \tab \code{InterventionClass} \tab the class of drug/treatment used in
#'   the intervention/treatment arm \cr
#' \tab \code{Outcome} \tab the outcome or event for each data set, e.g., OS,
#'   PFS, DFS, etc. \cr
#' \tab \code{PrimaryStudyResults} \tab the primary outcome results, either
#'   positive, negative, or mixed (i.e., co-primary endpoints with both
#'   positive and negative outcomes) \cr
#' \tab \code{Units} \tab the time units for \code{Outcome}, e.g., days,
#'   weeks, months, years \cr
#' \tab \code{HazardRatio} \tab the reported/published hazard ratio for
#' \code{Outcome} \cr
#' \tab \code{Arms} \tab the two treatment arms for each data set \cr
#' \tab \code{NumberofArms} \tab the number of treatment arms for the entire
#'   study (note that data sets in this package have two arms each) \cr
#' \tab \code{qsAtRisk} \tab quality score for at-risk tables (0-3) \cr
#' \tab \code{qsTotalEvents} \tab quality score total events (0-3) \cr
#' \tab \code{qsHazardRatio} \tab quality score for hazard ratio (0-3) \cr
#' \tab \code{qsMedian} \tab quality score for median time-to-event (0-3) \cr
#' \tab \code{QualityScore} \tab aggregate quality score for each figure
#'   over the four metrics (hazard ratio, total events, median time-to-event,
#'   number at-risk) comparing published to re-capitulated data \cr
#' \tab \code{QualityMax} \tab maximum quality score possible for each figure;
#'   each quality metric can be score from 0 (worst) to 3 (best); the maximum
#'   score possible for each figure depends on the number of metrics reported
#'   by the publication \cr
#' \tab \code{QualityPercent} \tab a quality score percentage for each figure,
#'   from 0 (worst) to 100 (best): \code{QualityScore / QualityMax * 100} \cr
#' 
#' }
#' 
#' @seealso
#' \code{\link{select_kmdata}}
#' 
"kmdata_key"

#' Select data sets
#' 
#' Select publication data sets based on study characteristics including
#' outcome, sample size, treatment arms, journal, disease, etc.
#' 
#' @param ... an expression to be evaluated within \code{\link{kmdata_key}}
#'   such as \code{SampleSize < 100}; see examples
#' @param return type of object to return; one of \code{"name"} (default) for
#'   the study names that match the criteria, \code{"key"} for the matching
#'   rows of \code{kmdata_key}, or \code{"data"} for a list of data frames for
#'   each match
#' 
#' @examples
#' names(kmdata_key)
#' select_kmdata(SampleSize < 100)
#' select_kmdata(grepl('folfiri', Arms) & Outcome == 'OS')
#' select_kmdata(SampleSize < 100 | Cancer %in% c('Lung/Colorectal', 'Prostate'))
#' 
#' ## get a list of the data sets
#' l <- select_kmdata(SampleSize < 100, return = 'data')
#' par(mfrow = n2mfrow(length(l)))
#' sapply(l, kmplot)
#' 
#' @export

select_kmdata <- function(..., return = c('name', 'key', 'data')) {
  m <- match.call(expand.dots = FALSE)
  l <- which(eval(m$`...`[[1L]], kmdata::kmdata_key))
  
  switch(
    match.arg(return),
    name = kmdata_key$name[l],
    key = kmdata_key[l, ],
    data = mget(kmdata_key$name[l], as.environment('package:kmdata'))
  )
}

#' Summarize \code{kmdata}
#' 
#' Print a summary of a \code{kmdata} object.
#' 
#' @param object an object of class \code{"kmdata"}
#' @param message logical; if \code{TRUE} (default), a description of the
#'   study will be printed with the summary
#' @param ... ignored
#' 
#' @examples
#' summary(ATTENTION_2A)
#' 
#' @export

summary.kmdata <- function(object, message = TRUE, ...) {
  att <- attributes(object)
  tbl <- table(object$arm)
  
  txt <- c(
    att$title,
    sprintf(
      'Time-to-event data of %s observations (%s %s events, %.0f%%) and
      %s arms (%s)\n\nSource:',
      nrow(object), sum(object$event), attr(object, 'event'),
      mean(object$event) * 100, length(tbl),
      toString(sprintf('%s: n=%s', names(tbl), tbl))
    ),
    att$source
  )
  txt <- strwrap(
    txt, getOption('width') * 0.75,
    prefix = '\n', initial = '', exdent = 2L
  )
  if (message)
    message(txt)
  
  object <- within(as.data.frame(object), {
    arm <- factor(arm)
    event <- factor(event)
  })
  
  summary(object)
}
