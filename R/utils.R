### utilities
# select_kmdata, summary.kmdata
### 


#' Select data sets
#' 
#' Select publication data sets based on study characteristics including
#' outcome, sample size, treatment arms, journal, disease, etc.
#' 
#' @param ... an expression to be evaluated within \code{\link{kmdata_key}}
#'   such as \code{ReportedSampleSize < 100}; see examples
#' @param return type of object to return; one of \code{"name"} (default) for
#'   the study names that match the criteria, \code{"key"} for the matching
#'   rows of \code{kmdata_key}, or \code{"data"} for a list of data frames for
#'   each match
#' 
#' @examples
#' names(kmdata_key)
#' select_kmdata(ReportedSampleSize < 100)
#' select_kmdata(grepl('folfiri', Arms) & Outcome == 'OS')
#' select_kmdata(ReportedSampleSize < 100 |
#'   Cancer %in% c('Lung/Colorectal', 'Prostate'))
#' 
#' ## get a list of the data sets
#' l <- select_kmdata(ReportedSampleSize < 100, return = 'data')
#' par(mfrow = n2mfrow(length(l)))
#' sapply(l, kmplot)
#' 
#' @export

select_kmdata <- function(..., return = c('name', 'key', 'data')) {
  kmdata_key <- kmdata::kmdata_key
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
