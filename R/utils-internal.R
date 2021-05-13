### internal utilities
# %||%, pvalr, rescaler, hr_pval, hr_text
###


`%||%` <- function(x, y) {
  if (is.null(x) || length(x) == 0L)
    y else x
}

pvalr <- function(pv, sig.limit = 0.001, digits = 2L, show.p = TRUE) {
  pv <- if (pv < sig.limit)
    sig.limit else format.pval(pv, digits = digits)
  
  pv <- if (pv == '1')
    'p > 0.99' else paste(ifelse(pv < sig.limit, 'p <', 'p ='), pv)
  
  if (show.p)
    pv else gsub('.* ', '', pv)
}

rescaler <- function(x, to = c(0, 1), from = range(x, na.rm = TRUE)) {
  (x - from[1L]) / diff(from) * diff(to) + to[1L]
}

hr_pval <- function(object, details = FALSE, data = NULL, ...) {
  ## rawr:::hr_pval
  object <- if (inherits(object, c('survdiff', 'survfit'))) {
    if (length(form <- object$call$formula) == 1L)
      object$call$formula <- eval(object$call$formula, parent.frame(1L))
    coxph(as.formula(object$call$formula),
          eval(data %||% object$.data %||% object$call$data))
  } else if (inherits(object, c('formula', 'call')))
    coxph(object, data, ...)
  else object
  
  stopifnot(
    inherits(object, 'coxph')
  )
  
  obj <- summary(object)
  obj <- cbind(obj$conf.int[, -2L, drop = FALSE],
               p.value = obj$coefficients[, 'Pr(>|z|)'])
  
  if (details)
    obj
  else obj[, 'p.value']
}

hr_text <- function(formula, data, ..., details = TRUE, pFUN = NULL) {
  ## rawr:::hr_text
  pFUN <- if (is.null(pFUN) || isTRUE(pFUN))
    function(x) pvalr(x, show.p = TRUE)
  else if (identical(pFUN, FALSE))
    identity else match.fun(pFUN)
  
  object <- if (inherits(formula, 'coxph'))
    formula
  else if (inherits(formula, 'survfit'))
    coxph(as.formula(formula$call$formula),
          if (!missing(data)) data else eval(formula$call$data), ...)
  else formula
  
  suppressWarnings({
    cph <- tryCatch(
      if (inherits(object, 'coxph'))
        object else coxph(formula, data, ...),
      # warning = function(w) '',
      error   = function(e) e
    )
  })
  
  if (isTRUE(cph))
    return(FALSE)
  if (identical(cph, ''))
    return(cph)
  if (!inherits(cph, 'coxph'))
    stop(cph)
  
  obj <- hr_pval(cph, details = TRUE)
  
  txt <- apply(obj, 1L, function(x)
    sprintf('HR %.2f (%.2f, %.2f), %s', x[1L], x[2L], x[3L],
            {pv <- pFUN(x[4L]); if (is.na(pv)) 'p > 0.99' else pv}))
  lbl <- attr(terms(cph), 'term.labels')
  txt <- paste(cph$xlevels[[lbl[!grepl('strata\\(', lbl)]]],
               c('Reference', txt), sep = ': ')
  
  if (is.null(cph$xlevels))
    c(NA, gsub('^.*: ', '', txt)[-1L])
  else txt
}
