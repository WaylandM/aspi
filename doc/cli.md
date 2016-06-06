#ASPI Command Line Interface (CLI)

##Functions Available
The script [aspi.R](https://github.com/WaylandM/aspi/blob/master/cli/aspi.R) provides five functions: **removeUninfected**, **g.test**, **eb.test**, **plot.Histogram** and **plot.Volcano**.


####removeUninfected
**removeUninfected** takes as its argument a matrix or data.frame containing exactly two columns: 

left: counts of parasites on the left side of the host

right: counts of parasites on the right side of the host

It returns the matrix or data.frame after removing uninfected hosts (i.e. those with zero counts for both left and right sides).

####g.test
This function implements Sokal & Rohlf's (1995) replicated G-tests of goodness-of-fit for the specific case of an expected 1:1 ratio.

Reference R.R. Sokal & F.J. Rohlf (1995) Biometry. 3rd Edition. New York: W.H. Freeman and Company. 887 pp.

The function takes as its argument a matrix or data frame with two numeric columns; first column is for left-side and 2nd column for right-side. Identifiers for hosts can be provided as row names.

It returns a list containing two data.frames:

**summary** - results of total, heterogeneity and pooled G-tests

**hosts** - results (G-statistic, raw p-value, FDR corrected p-value, FWER corrected p-value) of individual G-tests on distribution of parasites in each host.

####eb.test
This function performs a binomial exact test with the null hypothesis of a 1:1 ratio. It takes as its argument a matrix or data frame with two numeric columns; first column is for left-side and 2nd column for right-side. Identifiers for hosts can be provided as row names.

It returns a list containing two elements:

**pooled** - p-value for pooled binomial exact test (null hypothesis: the ratio of the total number of parasites from each side doesn't differ from 1:1).

**hosts** - data.frame of results of binomial exact tests performed on the distribution of parasites in each host

####plot.Histogram
**plot.Histogram** creates a histogram showing distribution of fold differences in abundance of parasites between left and right sides. For each host the number of parasites on the right side is divided by the number of parasites on the left side, and the result binary log transformed. The log2 ratio will be negative if there are more parasites on the left than right and positive if there are more parasites on the right than left. A log2 ratio of one corresponds to a one-fold difference, i.e. double the number of parasites. Perfect symmetry is a log2 ratio of zero.

This function takes the following arguments:
* **x** - a matrix or data frame with two numeric columns; first column is for left-side and 2nd column for right-side. Identifiers for hosts can be provided as row names.
* **nBreaks** - a single number giving the number of cells for the histogram.
* **...** - optionally, additional arguments can be passed, such as graphical parameters.

####plot.Volcano
**plot.Volcano** creates a volcano plot, *i.e.* a scatterplot of statistical significance (-log10(p-value)) *vs* fold difference (log2 ratio - as calculated for the histogram above) in parasite abundance between left and right. Each point in the scatterplot represents the parasite distribution in an individual host. A dashed horizontal line represents the user-defined p-value threshold for significance. If a parasite distribution deviates significantly from symmetry it is shown as a red square, otherwise as a blue circle.

**plot.Volcano** takes the following arguments:
* **x** - a matrix or data frame with two numeric columns; first column is for left-side and 2nd column for right-side. Identifiers for hosts can be provided as row names.
* **test** - if set to "G" (default) a G-test is performed; otherwise an exact binomial test is performed.
* **pAdj** - method for correcting p-values for multiple comparisons. If set to "BH" (default), Benjamini & Hochberg's procedure is used to control the false discovery rate (FDR); otherwise Holm's methos is used to control the familywise error rate (FWER).
* **sigThresh** - significance threshold (defaults to 0.05); p-values below this value will be called significant.
* *...* - optionally, additional arguments can be passed, such as graphical parameters.

##How to use the CLI
###1. Read source code
To read files over https we need to install the RCurl package:
```r
install.packages("RCurl", dependencies = TRUE)
```
The latest version of the meristogram code can be sourced directly from the meristogram repository on github:
```r
library(RCurl)
eval(expr = parse(text = getURL("https://raw.githubusercontent.com/WaylandM/aspi/master/cli/aspi.R", ssl.verifypeer=FALSE) ))
```
Alternatively, if you have a local copy of meristogram.R you can read it using **source**, *e.g.*:
```r
source("~/aspi.R")
```

###2. Read parasite infection data
The input file format for ASPI is comma separated value (CSV) with three columns:
* **host id** - unique id for host
* **left** - number of parasites in/on organ/structure on left
* **right** - number of parasites in/on organ/structure on right

Example data files can be found in: https://github.com/WaylandM/aspi/tree/master/data/parasites

To read in an example data file from the aspi repository on github, use:
```r
diplostomum <- read.csv(text=getURL("https://raw.githubusercontent.com/WaylandM/aspi/master/data/parasites/Diplostomum_eyes_excluding_lenses.csv"), row.names=1)
```
Alternatively, a locally stored hook measurement file can be read using:
```r
diplostomum <- read.csv("Diplostomum_eyes_excluding_lenses.csv", row.names=1)
```

If you want to know how many hosts are represented in the data.frame, use:
```r
length(diplostomum[,1])
```

If you think there may be records for uninfected hosts in your data.frame it is important to run the following command before performing statistical tests or creating graphs:
```r
diplostomum <- removeUninfected(diplostomum)
```

###3. Detect asymmetry
To perform replicated G-tests of goodness-of-fit to detect asymmetry in parasite distributions, run the following command:
```r
gTestResults <- g.test(diplostomum)
```

To inspect the results of the total, heterogeneity and pooled G-tests, run:
```r
gTestResults$summary
```

The results for the G-tests on individual hosts is found in:
```r
gTestResults$hosts
```

###4. Create Histogram
Create a histogram showing fold differences in abundance between left and right:
```r
plotHistogram(diplostomum,nBreaks=20,main="Diplostomum metacercariae in eyes of ruffe")
```

###5. Create Volcano Plot
Create a volcano plot using FDR corrected p-values from exact binomial tests and a significance threshold of 0.1:
```r
plotVolcano(diplostomum, test="G", pAdj="EB", sigThresh=0.1, main="Diplostomum metacercariae in eyes of ruffe")
```

