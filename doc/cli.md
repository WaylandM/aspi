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

####plot.Histogram

####plot.Volcano

##How to use the CLI

