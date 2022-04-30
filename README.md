kmdata
====

This R<sup>[[1]](#1)</sup> package contains a database of 304 reconstructed,
patient-level clinical trial datasets on multiple survival endpoints,
including overall and progression-free survival.

The data have been extracted from Kaplan-Meier (KM) curves reported in 153
oncology Phase III clinical trial publications.

Studies have been identified through a [PubMed](https://pubmed.ncbi.nlm.nih.gov/)
search of clinical trials in breast, lung cancer, prostate, and colorectal
cancer published between 2014 and 2016.

For each trial that met the our search criteria, we extracted and curated
study-level information.

All reported KM survival curves were digitized with the software
[DigitizeIt](https://www.digitizeit.de).

The digitized KM survival curves were used to estimate (possibly censored)
patient-level event times using the Guyot-algorithm<sup>[[2]](#2)</sup>.

### References
<a id="1">[1]</a>
R-Core-Team.
A Language and Environment for Statistical Computing.
R Found Stat Comput.
2018;2: https://www.r-project.org.

<a id="2">[2]</a>
Guyot P, Ades AE, Ouwens MJNM, Welton NJ.
Enhanced secondary analysis of survival data: Reconstructing the data from
published Kaplan-Meier survival curves.
_BMC Med Res Methodol_.
2012;12. doi:10.1186/1471-2288-12-9

---

### Installation

```r
# install.packages('devtools')
devtools::install_github('raredd/kmdata', build_vignettes = TRUE)
```

### Getting started

View a list of the data available in the `kmdata` package:

```r
library('kmdata')
data(package = 'kmdata')
```

Or generate individual patient data (IPD) from digitized survival curve data
using the method described by Guyot:

```r
library('survival')
sf <- survfit(Surv(time, status) ~ 1, cancer)
aa <- summary(sf, times = 0:8 * 100)

pt <- ipd(sf$time, sf$surv, aa$time, aa$n.risk)
pf <- survfit(Surv(time, event) ~ 1, pt)
```

Compare:

```r
sf
````

```
# Call: survfit(formula = Surv(time, status) ~ 1, data = cancer)
# 
#       n  events  median 0.95LCL 0.95UCL 
#     228     165     310     285     363 
```

```r
pf
```

```
# Call: survfit(formula = Surv(time, event) ~ 1, data = pt)
# 
#       n  events  median 0.95LCL 0.95UCL 
#     228     163     310     285     363 
```

```r
summary(sf, times = 0:5 * 100)
````

```
# Call: survfit(formula = Surv(time, status) ~ 1, data = cancer)
# 
# time n.risk n.event survival std.err lower 95% CI upper 95% CI
#    0    228       0   1.0000  0.0000       1.0000        1.000
#  100    196      31   0.8640  0.0227       0.8206        0.910
#  200    144      41   0.6803  0.0311       0.6219        0.744
#  300     92      29   0.5306  0.0346       0.4669        0.603
#  400     57      25   0.3768  0.0358       0.3128        0.454
#  500     41      12   0.2933  0.0351       0.2320        0.371
```

```r
summary(pf, times = 0:5 * 100)
````

```
# Call: survfit(formula = Surv(time, event) ~ 1, data = pt)
# 
# time n.risk n.event survival std.err lower 95% CI upper 95% CI
#    0    228       0    1.000  0.0000       1.0000        1.000
#  100    196      31    0.864  0.0228       0.8201        0.909
#  200    144      40    0.681  0.0314       0.6221        0.745
#  300     92      29    0.531  0.0348       0.4672        0.604
#  400     57      25    0.379  0.0358       0.3145        0.456
#  500     41      13    0.290  0.0349       0.2295        0.367
```

### Additional resources

See the `kmdata` [intro vignette](vignettes/kmdata-intro.Rmd) or more
information about [generating IPD](vignettes/kmdata-ipd.Rmd) from digitized
survival curves.
