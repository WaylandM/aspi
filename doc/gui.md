#ASPI Web Application

This is a guide to using the web application. 

##1. Read data

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/start.PNG" width="550" alt="Start screen">

Click on **Browse** button to select input file.

The input file format for ASPI is comma separated value (CSV) with three columns:
* **host id** - unique id for host
* **left** - number of parasites in/on organ/structure on left
* **right** - number of parasites in/on organ/structure on right

Example data files can be found in: https://github.com/WaylandM/aspi/tree/master/data/parasites


##2. Select statistical procedures

###2.1 Detection of deviation from symmetry

####2.1.1 Replicated G-tests of goodness-of-fit
Replicated G-tests of goodness-of-fit (Sokal and Rohlf, 1995) are the default method for detecting bilateral asymmetry. This procedure computes four different G-statistics:
* **Total G** - tests null hypothesis that overall the parasite distributions in all individual hosts do not depart from symmetry.
* **Pooled G** - evaluates the null hypothesis that the ratio of the total number of parasites from each side does not differ from symmetry.
* **Heterogeneity G** - examines the null hypothesis that the left:right ratios are the same in all individual hosts. 
* **Individual G** - used to identify which individual hosts have asymmetrical parasite distributions.

Further guidance on the interpretation of the results of replicated G-tests of goodness-of-fit is provided by these [examples](https://github.com/WaylandM/aspi/blob/master/doc/examples.md).

Reference: 
R.R. Sokal & F.J. Rohlf (1995) Biometry. 3rd Edition. New York: W.H. Freeman and Company. 887 pp.

####2.1.2 Binomial exact test
G-tests involve logarithmic transformation and so cannot be applied to counts of zero. Moreover, G-tests are not recommended when counts are below 10. For this situation, binomial exact tests are provided as an alternative, but are limited to testing two null hypotheses:
* the ratio of the total number of parasites on each side doesn't differ from 1:1 (equivalent to the pooled G-test);
* the distribution of parasites in an individual host is symmetrical.

###2.2 Correction for multiple comparisons
When applying hypothesis tests to individual hosts we have to control for multiple comparisons using one of the following two procedures:

####2.2.1 False discovery rate (FDR)
The FDR is the proportion of false positives among all significant test results. Benjamini and Hochberg's method is used to control the FDR.

Reference: 
Benjamini, Y., Hochberg, Y. (1995) Controlling the false discovery rate: a practical and powerful approach to multiple testing. Journal of the Royal Statistical Society B 57: 289-300.

####2.2.2 Familywise error rate (FWER)
The FWER is the probability of a single false positive among a collection (family) of hypothesis tests. Holm's procedure is used to control the FWER.

Reference:
Holm, S. (1979) A simple sequentially rejective multiple test procedure. Scandinavian Journal of Statistics 6, 65–70

##3. Results Summary

After uploading a data file, results are displayed in four tabs, the first of which is the summary:

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/summary_tab.PNG" width="550" alt="Summary tab">

The number of infections reported to be asymmetric will depend on the statistical test used (G-test *vs* binomial exact test), the procedure used to correct for multiple comparisons (control of FDR *vs* FWER) and the chosen significance threshold. 

##4. Individual hosts

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/individual_hosts_tab.PNG" width="550" alt="Start screen">

This tab shows the results of indvidual hypothesis tests applied to each host. In the case of the G-test, seven columns are displayed:
* **Host** - unique host identifier
* **Left** - number of parasites on left
* **Right** - number of parasites on right
* **G** - test statistic
* **p** - p-value for G-test
* **BH** - FDR corrected p-value (Benjamini & Hochberg's procedure)
* **Holm** - FWER corrected p-value (Holm's procedure)

If the exact binomial test is used, the test statistic column is not displayed. Columns can be sorted using the arrows in the column headers. Results can be downloaded as a text file (comma-separated-value).



##5. Histogram

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/histogram_tab.PNG" width="550" alt="Start screen">

The histogram shows the distribution of fold differences in abundance between left and right sides. For each host the number of parasites on the right is divided by the number on the left, and the result is binary log transformed. The binary log ratio will be negative if there are more parasites on the left than right, and positive if there are more parasites on the right than left. A binary log ratio of one corresponds to a one-fold difference, i.e. double the number of parasites. Perfect symmetry is a binary log ratio of zero. An image of the histogram can be downloaded in either PNG or PDF format.

##6. Volcano Plot

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/volcano_plot_tab.PNG" width="550" alt="Start screen">

This plot shows statistical significance (-log10(p-value)) of G-tests for asymmetry of parasite distributions in individual hosts *vs* fold difference (binary log ratio) in parasite abundance between right and left. Each point in the scatterplot represents the parasite distribution in an individual host. The dashed horizontal line represents the chosen p-value threshold. Parasite distributions deviating significantly from symmetry are shown as red squares, whereas those not differing signicantly from a 1:1 ratio are represented by blue circles. Changing the **Multiple Test Correction** and or **Significance level** in the control panel will update the plot.


