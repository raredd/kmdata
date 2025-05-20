### km metrics
# kmm, kmm_legend
###


#' Kaplan-Meier metrics
#' 
#' Compute metrics between two \code{\link[survival]{survfit}} objects; see
#' examples in \code{\link{kmm_legend}}.
#' 
#' @param x,y \code{survfit} objects
#' @param times times to evaluate survival
#' 
#' @export

kmm <- function(x, y, times = NULL) {
  ## use mean of abs/sq when:
  # - comparing different studies, independent time points (or time frame) 
  # - to emphasize "average time point error"
  ## use sum of abs/sq when:
  # - comparing only models with the same number of time points (or time frame)
  # - to emphasize total error across all time points
  
  ## all unique times
  if (is.null(times)) {
    # times <- unique(x$time)
    times <- unique(sort(c(x$time, y$time)))
  }
  single <- function(x) {
    stopifnot(inherits(x, 'survfit'))
    is.null(x$strata) || length(x$n) == 1L
  }
  stopifnot(
    single(x), single(y),
    length(times) > 5L
  )
  
  ## survival at each point
  xs <- summary(x, times = times, extend = TRUE)$surv
  ys <- summary(y, times = times, extend = TRUE)$surv
  
  er <- xs - ys
  ae <- abs(er)
  se <- er ^ 2
  ## https://bmcmedresmethodol.biomedcentral.com/articles/10.1186/s12874-024-02273-8
  rmse <- sqrt(mean(se))
  
  data.frame(mae = mean(ae), sae = sum(ae), mse = mean(se), sse = sum(se), rmse)
}

#' Add legend for \code{kmm}
#' 
#' Compute metrics for two or more \code{\link[survival]{survfit}} objects,
#' and plot results as a \code{\link[graphics]{legend}}.
#' 
#' @param list a list of two or more \code{survfit} objects
#' @param times a vector of times to compare curves
#' @param metric the metric to show; default is the square root of the mean
#'   squared errors \code{"rmse"}
#' @param plot logical; if \code{TRUE} (default), a legend is draw on the
#'   existing device; otherwise, the text is returned
#' @param ... additional arguments passed to \code{\link[graphics]{legend}}
#'   or to override defaults
#' 
#' @examples
#' library('survival')
#' set.seed(1)
#' lung2 <- within(lung, {
#'   time <- time / 100
#'   ## generate different curves with human error
#'   time2 <- time + runif(nrow(lung))
#'   time3 <- time + runif(nrow(lung), 0, 0.25)
#'   cohort <- factor(1, 1:2)
#' })
#' 
#' truth  <- survfit(Surv(time, status) ~ 1, lung2)
#' recap1 <- survfit(Surv(time2, status) ~ 1, lung2)
#' recap2 <- survfit(Surv(time3, status) ~ 1, lung2)
#' recap3 <- survfit(Surv(time3, status) ~ cohort, lung2)
#' 
#' plot(truth, conf.int = FALSE)
#' lines(recap1, col = 2, conf.int = FALSE)
#' lines(recap2, col = 3, conf.int = FALSE)
#' l <- list(truth = truth, recap1 = recap1, recap2 = recap2)
#' ## error using all unique times
#' kmm_legend(l)
#' ## error using interpolated times 0-10 (ie, asymptotic error)
#' kmm_legend(l, times = seq(0, 10, length.out = 1e4), inset = c(0, 0.25))
#' ## error of interpolated time interval 0-2
#' kmm_legend(l, times = seq(0, 2, length.out = 1e4), inset = c(0, 0.5))
#' ## error of interpolated time interval 6-10
#' kmm_legend(l, times = seq(6, 10, length.out = 1e4), inset = c(0, 0.75))
#' 
#' ## mean squared error
#' kmm_legend(l, metric = 'mse', x = 'top')
#' kmm_legend(l, times = seq(0, 10, length.out = 1e4),
#'          metric = 'mse', x = 'top', inset = c(0, 0.25))
#' kmm_legend(l, times = seq(0, 2, length.out = 1e4),
#'          metric = 'mse', x = 'top', inset = c(0, 0.5))
#' kmm_legend(l, times = seq(6, 10, length.out = 1e4),
#'          metric = 'mse', x = 'top', inset = c(0, 0.75))
#' 
#' @export

kmm_legend <- function(list, times = NULL,
                       metric = c('rmse', 'mse', 'sse', 'mae', 'sae'),
                       plot = TRUE, ...) {
  metric <- match.arg(metric)
  labels <- c(
    mse = 'Mean sq. error', sse = 'Sum sq. error',
    mae = 'Mean abs. error', sae = 'Sum abs. error',
    rmse = 'Root mean sq. error'
  )
  names(metric) <- labels[metric]
  if (is.null(names(list)))
    names(list) <- seq_along(list)
  
  leg <- sapply(list[-1L], function(x) {
    kmm(list[[1L]], x, times)[, metric]
  })
  txt <- sprintf('%s vs %s: %.4f', names(list)[1L], names(list)[-1L], leg)
  leg <- list(x = 'topright', title = names(metric), bty = 'n', legend = txt)
  
  if (plot)
    do.call('legend', modifyList(leg, list(...))) else txt
}
