### summary data (arm-level, demographics)
# kmdata_key, kmdata_demo
###


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
#' \code{\link{kmdata_demo}}; \code{\link{select_kmdata}};
#' \code{\link{summary.kmdata}}
"kmdata_key"


#' \code{kmdata} demographics data
#' 
#' Demographics of data sets in \code{kmdata} package by treatment arm. Missing
#' values are shown when either the publication did not report or the number
#' could not be inferred from available information.
#' 
#' @format
#' A data frame of 331 observations and 12 variables:
#' 
#' \tabular{lll}{
#' 
#' \tab \code{Publication} \tab publication identifier \cr
#' \tab \code{Therapy} \tab therapy received \cr
#' \tab \code{Description} \tab additional information about \code{Therapy}
#'   where appropriate \cr
#' \tab \code{Median Age} \tab the median age by publication/therapy \cr
#' \tab \code{Age Range} \tab the age range by publication/therapy \cr
#' \tab \code{Sex:Males} \tab the number of males by publication/therapy \cr
#' \tab \code{Sex:Females} \tab the number of females by publication/therapy \cr
#' \tab \code{Race:White} \tab the number of White/Caucasian by
#'   publication/therapy \cr
#' \tab \code{Race:Other} \tab the number of non-White/Caucasian by
#'   publication/therapy \cr
#' \tab \code{ECOG:0/1} \tab the number of patients with an ECOG performance
#'   score of 0 or 1 by publication/therapy \cr
#' \tab \code{ECOG:2+} \tab the number of patients with an ECOG performance
#'   score of 2+ by publication/therapy \cr
#' \tab \code{ECOG:UNK} \tab the number of patients with an ECOG performance
#'   score of unknown by publication/therapy \cr
#' 
#' }
#' 
#' @seealso
#' \code{\link{kmdata_key}}; \code{\link{select_kmdata}};
#' \code{\link{summary.kmdata}}
"kmdata_demo"
