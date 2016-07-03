#ASPI Graphical User Interface (GUI)

This is a guide to using the web application. Data analysis is explained in more detail on the following page: [Interpretation of statistical tests](https://github.com/WaylandM/aspi/blob/master/doc/statistical_tests_interpretation.md).

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

##3. Results Summary

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/summary_tab.PNG" width="550" alt="Summary tab">


##4. Individual hosts

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/individual_hosts_tab.PNG" width="550" alt="Start screen">


##5. Histogram

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/histogram_tab.PNG" width="550" alt="Start screen">


##6. Volcano Plot

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/volcano_plot_tab.PNG" width="550" alt="Start screen">


