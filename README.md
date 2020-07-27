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
