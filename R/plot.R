### plots
# kmplot, plot.kmdata
###


#' kmplot
#' 
#' Make a Kaplan-Meier plot of a data set.
#' 
#' @param x a data set of class \code{"kmdata"}, i.e., one of the data sets
#'   in the \pkg{kmdata} package; alternatively, a data frame with columns
#'   "time", "event", and "arm"
#' @param ... additional arguments passed to \code{\link[survival]{plot.survfit}}
#'   or further to \code{\link{plot.default}} or \code{\link{par}}
#' @param relevel logical; if \code{TRUE}, group order is reversed; by default,
#'   the arms are in alphabetical order which may not be desired for some
#'   placebo or control arms
#' @param col a vector of colors for the survival curves (recycled for at-risk
#'   table, medians, and legend)
#' @param plot logical; if \code{TRUE}, a KM figure is drawn
#' @param xlim,ylim x- and y-axis limits
#' @param xaxis.at x-axis positions of ticks and at-risk table
#' @param xlab,ylab the x- and y-axis labels
#' @param lr_test logical; if \code{TRUE}, log-rank test is shown in upper
#'   right corner of figure
#' @param test_details logical; if \code{TRUE}, test statistic and degrees
#'   of freedom are added with p-value for log-rank test
#' @param median logical; if \code{TRUE}, the medians for each curve is added
#' @param atrisk logical; if \code{TRUE}, an at-risk table is drawn below plot
#' @param mark.time passed to \code{\link[survival]{plot.survfit}}
#' @param title optional title for plot; default is \code{attr(data, 'title')}
#' @param legend logical; if \code{TRUE}, a legend for the arms, total events,
#'   and hazard ratios is added
#' 
#' @examples
#' kmplot(ATTENTION_2A)
#' 
#' kmplot(
#'   ATTENTION_2A,
#'   relevel = TRUE, median = FALSE,
#'   col = 3:4, xaxis.at = 0:4 * 6
#' )
#' 
#' ## or equivalently
#' s <- survfit(Surv(time, event) ~ arm, ATTENTION_2A)
#' plot(s, col = 1:2, mark.time = TRUE)
#' 
#' 
#' ## kmplot can be used generically given the proper data structure
#' dat <- data.frame(time = aml$time, event = aml$status, arm = aml$x)
#' kmplot(dat)
#' 
#' @export

kmplot <- function(x, ..., relevel = FALSE, col = NULL, plot = TRUE,
                   xlim = NULL, ylim = NULL, xaxis.at = NULL,
                   xlab = NULL, ylab = NULL,
                   lr_test = TRUE, test_details = TRUE, median = TRUE,
                   atrisk = TRUE, mark.time = TRUE,
                   title = NULL, legend = TRUE) {
  data <- x
  stopifnot(
    inherits(data, 'kmdata') |
      all(c('time', 'event', 'arm') %in% names(data))
  )
  
  xlim <- if (is.null(xlim))
    c(0, max(data$time)) else xlim
  xaxis.at <- xaxis.at %||% attr(data, 'xaxis.at') %||% pretty(xlim)
  
  data <- within(data, {
    arm <- as.factor(arm)
    if (relevel)
      arm <- relevel(arm, levels(arm)[2L])
  })
  ng <- nlevels(data$arm)
  
  sf <- survfit(Surv(time, event) ~ arm, data)
  sd <- cx <- NULL
  if (ng > 1L) {
    sd <- survdiff(Surv(time, event) ~ arm, data)
    cx <- coxph(Surv(time, event) ~ arm, data)
  }
  res <- list(survfit = sf, survdiff = sd, coxph = cx)
  
  if (!plot)
    return(invisible(res))
  
  
  op <- par(las = 1L, mar = par('mar') + c(atrisk * ng + 1, atrisk * 2, 0, 0))
  on.exit(par(op))
  
  col <- col %||% seq_along(sf$strata) %||% 1L
  
  plot(
    sf, col = col, mark.time = mark.time, ...,
    xlim = xlim, ylim = c(0, 1.025), axes = FALSE,
    xaxs = 'i', yaxs = 'i',
    xlab = xlab %||% sprintf('Time in %s', attr(data, 'units')),
    ylab = ylab %||% sprintf('%s probability', attr(data, 'event')),
  )
  
  ## axes, frame
  xaxis.at <- xaxis.at[xaxis.at <= par('usr')[2L]]
  axis(1L, xaxis.at)
  axis(2L, las = 1L)
  box(bty = 'l')
  
  ## annotations
  mtext(title %||% attr(data, 'title'), side = 3L, at = par('usr')[1L], adj = 0)
  nevents <- tapply(data$event, data$arm, sum)
  
  lbl <- sprintf('%s (%s obs, %s events)', names(nevents), if (ng == 1L)
    nrow(data) else table(data$arm), nevents)
  if (ng > 1L)
    lbl <- sprintf('%s; %s', lbl, gsub('^\\S+ ', '', hr_text(cx)))
  if (legend)
    legend(
      'bottomleft', title = '', title.adj = 0.1, lty = 1L, bty = 'n',
      col = col, legend = lbl
    )
  
  ## at-risk table
  if (atrisk) {
    ss <- summary(sf, times = xaxis.at)
    if (is.null(ss$strata))
      ss$strata <- data$arm[1L]
    ar <- data.frame(n.risk = ss$n.risk, time = ss$time, strata = ss$strata)
    ar <- split(ar, ar$strata)
    
    at <- c(2.5, 3, 3) + 0:2 + 1
    for (ii in seq_along(ar))
      mtext(ar[[ii]]$n.risk, side = 1L, line = at[ii + 1L],
            at = ar[[ii]]$time, col = col[ii])
    lbl <- c('No. at-risk', levels(data$arm))
    lbl <- paste0(lbl, strrep(' ', max(nchar(ss$n.risk)) + 3L))
    mtext(lbl, side = 1L, line = at[seq_along(lbl)], at = par('usr')[1L],
          adj = 1, col = c(1L, col))
  }
  
  ## log-rank test in upper right corner
  if (ng > 1L & lr_test) {
    df <- length(sd$n) - 1L
    pv <- pchisq(sd$chisq, df, lower.tail = FALSE)
    
    txt <- sprintf('%s (%s df), %s', sprintf('%0.1f', sd$chisq), df, pvalr(pv))
    txt <- if (test_details)
      bquote(paste(chi^2, ' = ', .(txt))) else pvalr(pv, show.p = TRUE)
    
    mtext(txt, side = 3L, at = par('usr')[2L], adj = 1)
  }
  
  if (median) {
    f <- function(x) {
      x <- if (is.na(x[1L]))
        'Not reached' else sprintf('%.1f (%.1f, %.1f)', x[1L], x[2L], x[3L])
      gsub('NA', '-', x)
    }
    
    md <- summary(sf)$table
    md <- if (!is.null(dim(md)))
      apply(md[, -(1:6)], 1L, f) else f(md[-(1:6)])
    
    xx <- grconvertX(0.85, 'npc')
    yy <- c(0.975, 0.9, 0.85)
    ny <- seq(2L, 2L + ng - 1L)
    text(xx, yy[1L], 'Median (95% CI)', adj = -0.05, xpd = NA)
    text(xx, yy[ny], gsub('arm=', '', names(nevents)), adj = 1, col = col)
    text(xx, yy[ny], md, adj = -0.05, col = col, xpd = NA)
  }
  
  invisible(res)
}

#' @rdname kmplot
#' @export
plot.kmdata <- kmplot
