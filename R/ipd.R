### generate ipd data
# ipd
# 
# unexported:
# mono, lims, ipd_
###


#' IPD
#' 
#' Generate individual patient data (IPD) from digitized survival curve data
#' using the method described by Guyot (2012).
#' 
#' @param time,prob vectors of survival time and probabilities
#' @param t.atrisk,n.atrisk vectors of at-risk times and number at-risk
#' @param total (optional) total number of events
#' @param arm (optional) arm label
#' @param tau maximum follow-up time
#' 
#' @import fdrtool
#' 
#' @references
#' Guyot, Patricia, et al. Enhanced secondary analysis of survival data:
#' reconstructing the data from published Kaplan-Meier survival curves.
#' \emph{BMC Medical Research Methodology} 2012, \strong{12}:9.
#' 
#' @examples
#' \dontrun{
#' xy <- system.file('etc', 'init', 'Checkmate 067_S3A_Nivolumab.csv',
#'                   package = 'kmdata')
#' ar <- system.file('etc', 'init', 'At Risk.csv', package = 'kmdata')
#' 
#' dd <- read.csv(xy)
#' aa <- read.csv(ar)
#' aa <- aa[aa$nrisk > 0, ]
#' 
#' ## use full at-risk table data
#' ipd1 <- ipd(dd$T, dd$S, aa$trisk, aa$nrisk, arm = 'Nivo')
#' kmplot(ipd1, xaxis.at = 0:4 * 10, xlim = c(0, 45))
#' 
#' 
#' ## only using 1/2 of at-risk table
#' idx <- replace(seq_along(aa$trisk) %% 2 == 1, nrow(aa), TRUE)
#' ipd2 <- ipd(dd$T, dd$S, aa$trisk[idx], aa$nrisk[idx], arm = 'Nivo')
#' kmplot(ipd2, xaxis.at = 0:4 * 10, xlim = c(0, 45))
#' 
#' 
#' ## only using 1/4 of at-risk table
#' idx <- replace(seq_along(aa$trisk) %% 4 == 1, nrow(aa), TRUE)
#' ipd3 <- ipd(dd$T, dd$S, aa$trisk[idx], aa$nrisk[idx], arm = 'Nivo')
#' kmplot(ipd3, xaxis.at = 0:4 * 10, xlim = c(0, 45))
#' 
#' 
#' ## only using 1/8 of at-risk table
#' idx <- replace(seq_along(aa$trisk) %% 8 == 1, nrow(aa), TRUE)
#' ipd4 <- ipd(dd$T, dd$S, aa$trisk[idx], aa$nrisk[idx], arm = 'Nivo')
#' kmplot(ipd4, xaxis.at = 0:4 * 10, xlim = c(0, 45))
#' }
#' 
#' @export

ipd <- function(time, prob, t.atrisk, n.atrisk, total = NA, arm = 'arm',
                tau = max(t.atrisk)) {
  stopifnot(
    length(time) == length(prob),
    length(t.atrisk) == length(n.atrisk),
    all(n.atrisk > 0),
    length(total) == 1L,
    length(arm) == 1L
  )
  
  if (any(ii <- t.atrisk > max(time))) {
    prob <- c(prob, rep_len(prob[which.max(time)], sum(ii)))
    time <- c(time, t.atrisk[ii])
  }
  prob <- prob[time <= tau]
  time <- time[time <= tau]
  n.atrisk <- n.atrisk[t.atrisk <= tau]
  t.atrisk <- t.atrisk[t.atrisk <= tau]
  
  mo <- mono(time, prob)
  li <- lims(t.atrisk, mo)
  
  res <- ipd_(mo, li, n.atrisk, total)
  res$arm <- as.character(arm)
  
  structure(res, class = c('kmdata', 'data.frame'))
}

mono <- function(time, prob) {
  data <- data.frame(time, prob)
  data <- data[order(data$time, -data$prob), ]
  
  ## if survival distribution is in [0,100] rescale to [0,1]
  if (any(data$prob > 10)) {
    data$prob[data$prob > 100] <- 100
    data$prob[data$prob < 0] <- 0
    data$prob <- rescaler(data$prob, from = c(0, 100))
  } else {
    data$prob[data$prob > 1] <- 1
    data$prob[data$prob < 0] <- 0
  }

  data <- unique(rbind(0:1, data))
  
  ## perform antitonic monotone regression
  mr <- suppressWarnings({
    fdrtool::monoreg(data$time, data$prob, type = 'antitonic')
  })
  
  data.frame(k = seq_along(mr$x), time = mr$x, prob = mr$yf)
}

lims <- function(t.atrisk, mono) {
  # @param t.atrisk a vector of at-risk time
  # @param mono an object returned from \code{mono}
  
  lo <- rep_len(0L, length(t.atrisk))
  ln <- length(lo)
  
  for (ii in seq.int(ln)) {
    x <- mono$time - t.atrisk[ii]
    lo[ii] <- mono$k[x >= 0][1L]
  }
  
  lo[is.na(lo)] <- max(mono$k)
  up <- c(lo[seq(2L, ln)] - 1L, lo[ln])
  
  list(upper = up, lower = lo)
}

ipd_ <- function(mono, atrisk, n.atrisk, total_events = NA) {
  # @param mono an object returned from \code{mono}
  # @param atrisk an object returned from \code{lims}
  # @param n.atrisk a vector of number at risk at each at-risk time
  # @param total_events total no. of events reported; if not, use \code{NA}
  
  his <- function(x, b) {
    hist(x, breaks = b, plot = FALSE)$counts
  }
  
  ## time and survival probability
  t.S <- mono$time
  S   <- mono$prob
  
  ## lower/upper bounds and no. at-risk in interval i
  lower  <- atrisk$lower
  upper  <- atrisk$upper
  n.risk <- n.atrisk
  
  ## the number of remaining intervals after each iteration of the code
  n.int <- length(n.risk)
  ## the final interval i, in the time series
  n.t <- upper[n.int]
  
  ## initialize vectors
  ## the number of censored patients in interval i
  n.censor <- rep_len(0L, (n.int - 1L))
  ## the number of at risk patients in interval i
  n.hat <- rep_len(n.risk[1L] + 1L, n.t)
  ## indicator for when a patient gets censored
  cen <- rep_len(0L, n.t)
  ## indicator for when a patient experiences an event
  d <- rep_len(0L, n.t)
  ## survival distribution over intervals i
  KM.hat <- rep_len(1L, n.t)
  ## survival distribution over remaining intervals
  last.i <- rep_len(1L, n.int)
  sumdL <- 0L
  
  if (n.int > 1L) {
    ## time intervals 1, ..., (n.int - 1)
    for (i in 1:(n.int - 1L)) {
      ## first approximation of no. censored on interval i
      n.censor[i] <- round(n.risk[i] * S[lower[i + 1]] / S[lower[i]] - n.risk[i + 1L])
      
      ## adjust total no. censored until n.hat = n.risk at start of interval (i + 1)
      while ((n.hat[lower[i + 1]] > n.risk[i + 1L]) ||
             ((n.hat[lower[i + 1]] < n.risk[i + 1]) && (n.censor[i] > 0))) {
        if (n.censor[i] <= 0) {
          cen[lower[i]:upper[i]] <- 0
          n.censor[i] <- 0
        }
        
        if (n.censor[i]> 0 ) {
          cen.t <- rep_len(0L, n.censor[i])
          for (j in 1:n.censor[i]) {
            cen.t[j] <- t.S[lower[i]] + j *
              (t.S[lower[(i + 1)]] - t.S[lower[i]]) / (n.censor[i] + 1L)
          }
          
          ## distribute censored observations evenly over time
          ## find no. censored on each time interval
          cen[lower[i]:upper[i]] <- his(cen.t, t.S[lower[i]:lower[(i+1)]])
        }
        ## find no. events and no. at risk on each interval to agree with
        ## K-M estimates read from curves
        n.hat[lower[i]] <- n.risk[i]
        last <- last.i[i]
        
        for (k in lower[i]:upper[i]) {
          if (i == 1L & k == lower[i]) {
            d[k] <- 0
            KM.hat[k] <- 1
          } else {
            ## if any n.atrisk == 0
            # d[k] <- if (n.hat[k] == 0)
            #   0 else round(n.hat[k] * (1 - (S[k] / KM.hat[last])))
            d[k] <- round(n.hat[k] * (1 - (S[k] / KM.hat[last])))
            KM.hat[k] <- KM.hat[last] * (1 - (d[k] / n.hat[k]))
            
            ## fix data here
            # KM.hat[k] <- pmax(1, KM.hat[k])
            # n.hat <- pmax(1L, n.hat)
            # d[k] <- findInterval(d[k], c(-Inf, 1, Inf)) - 1L
          }
          n.hat[k + 1L] <- n.hat[k] - d[k] - cen[k]
          if (d[k] != 0)
            last <- k
        }
        n.censor[i] <- n.censor[i] + (n.hat[lower[i + 1L]] - n.risk[i + 1L])
      }
      if (n.hat[lower[i + 1L]] < n.risk[i + 1L])
        n.risk[i + 1L] <- n.hat[lower[i + 1L]]
      last.i[(i + 1L)] <- last
    }
  }
  
  ## time interval n.int
  if (n.int > 1L) {
    ## assume same censor rate as average over previous time intervals
    tmp <- sum(n.censor[1:(n.int - 1L)]) *
      (t.S[upper[n.int]] - t.S[lower[n.int]]) /
      (t.S[upper[(n.int - 1L)]] - t.S[lower[1L]])
    n.censor[n.int] <- min(round(tmp), n.risk[n.int])
  }
  if (n.int == 1L)
    n.censor[n.int] <- 0L
  
  if (n.censor[n.int] <= 0L) {
    cen[lower[n.int]:(upper[n.int] - 1L)] <- 0L
    n.censor[n.int] <- 0L
  }
  
  if (n.censor[n.int] > 0L) {
    cen.t <- rep_len(0L, n.censor[n.int])
    for (j in 1:n.censor[n.int]) {
      cen.t[j] <- t.S[lower[n.int]] + j *
        (t.S[upper[n.int]] - t.S[lower[n.int]]) / (n.censor[n.int] + 1L)
    }
    cen[lower[n.int]:(upper[n.int] - 1L)] <- his(cen.t, t.S[lower[n.int]:upper[n.int]])
  }
  
  ## find no. events and no. at risk on each interval to agree with
  ## K-M estimates read from curves
  n.hat[lower[n.int]] <- n.risk[n.int]
  last <- last.i[n.int]
  
  for (k in lower[n.int]:upper[n.int]) {
    d[k] <- if (KM.hat[last] != 0)
      round(n.hat[k] * (1 - (S[k] / KM.hat[last]))) else 0
    
    KM.hat[k] <- KM.hat[last] * (1 - (d[k] / n.hat[k]))
    n.hat[k + 1] <- n.hat[k] - d[k] - cen[k]
    ## no. at risk cannot be negative
    if (n.hat[k + 1L] < 0L) {
      n.hat[k + 1L] <- 0L
      cen[k] <- n.hat[k] - d[k]
    }
    if (d[k] != 0)
      last <- k
  }
  
  ## if total no. of events reported, adjust no. censored so that
  ## total no. of events agrees
  if (!is.na(total_events)) {
    if (n.int > 1L) {
      sumdL <- sum(d[1:upper[(n.int - 1L)]])
      ## if total no. of events is already too big, set events and
      ## censoring = 0 on all further time intervals
      if (sumdL >= total_events) {
        # d[cumsum(d) > total_events] <- 0
        d[lower[n.int]:upper[n.int]] <- 0L
        if (upper[n.int] > lower[n.int])
          cen[lower[n.int]:(upper[n.int] - 1L)] <- 0L
        n.hat[(lower[n.int] + 1L):(upper[n.int] + 1L)] <- n.risk[n.int]
      }
    }
    ## otherwise adjust no. censored to give correct total no. events
    if ((sumdL < total_events) || (n.int == 1L)) {
      sumd <- sum(d[1:upper[n.int]])
      
      while ((sumd > total_events) ||
             ((sumd < total_events) && (n.censor[n.int] > 0L))) {
        n.censor[n.int] <- n.censor[n.int] + (sumd - total_events)
        if (n.censor[n.int] <= 0L) {
          cen[lower[n.int]:(upper[n.int] - 1L)] <- 0L
          n.censor[n.int] <- 0L
        }
        if (n.censor[n.int] > 0L) {
          cen.t <- rep_len(0L, n.censor[n.int])
          for (j in 1:n.censor[n.int]) {
            cen.t[j] <- t.S[lower[n.int]] + j *
              (t.S[upper[n.int]] - t.S[lower[n.int]]) / (n.censor[n.int] + 1L)
          }
          cen[lower[n.int]:(upper[n.int] - 1L)] <-
            his(cen.t, t.S[lower[n.int]:upper[n.int]])
        }
        
        n.hat[lower[n.int]] <- n.risk[n.int]
        last <- last.i[n.int]
        
        for (k in lower[n.int]:upper[n.int]) {
          d[k] <- round(n.hat[k] * (1 - (S[k] / KM.hat[last])))
          KM.hat[k] <- KM.hat[last] * (1 - (d[k] / n.hat[k]))
          if (k != upper[n.int]) {
            n.hat[k + 1] <- n.hat[k] - d[k] - cen[k]
            ## no. at risk cannot be negative
            if (n.hat[k + 1] < 0L) {
              n.hat[k + 1] <- 0L
              cen[k] <- n.hat[k] - d[k]
            }
          }
          if (d[k] != 0)
            last <- k
        }
        sumd <- sum(d[1:upper[n.int]])
      }
    }
  }
  
  ## form IPD from time/event data
  t.IPD <- rep_len(t.S[n.t], n.risk[1L])
  e.IPD <- rep_len(0L, n.risk[1L])
  
  ## write event time and event indicator (=1) for each event
  ## as separate row in t.IPD and e.IPD
  k <- 1
  for (j in 1:n.t) {
    if (d[j] != 0L) {
      t.IPD[k:(k + d[j] - 1L)] <- t.S[j]
      e.IPD[k:(k + d[j] - 1L)] <- 1L
      k <- k + d[j]
    }
  }
  ## write censor time and event indicator (=0) for each censor
  ## as separate row in t.IPD and e.IPD
  for (j in 1:(n.t - 1L)) {
    if (cen[j] != 0L) {
      t.IPD[k:(k + cen[j] - 1L)] <- mean(t.S[j:(j + 1L)])
      e.IPD[k:(k + cen[j] - 1L)] <- 0L
      k <- k + cen[j]
    }
  }
  
  res <- data.frame(time = t.IPD, event = e.IPD)[order(t.IPD), ]
  rownames(res) <- NULL
  
  res
}
