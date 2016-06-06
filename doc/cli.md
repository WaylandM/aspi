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
* **...** - optionally, additional arguments can be passed to methods, such as graphical parameters.

####plot.Volcano
**plot.Volcano** creates a volcano plot, *i.e.* 

##How to use the CLI

