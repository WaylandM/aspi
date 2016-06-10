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

####2.1.2 Binomial exact test

###2.2 Correction for multiple comparisons
When applying hypothesis tests to individual hosts we have to control for multiple comparisons using one of the following two procedures:

####2.2.1 False discovery rate (FDR)

####2.2.2 Familywise error rate (FWER)

##3. Results Summary

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/summary_tab.PNG" width="550" alt="Summary tab">


##4. Individual hosts

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/individual_hosts_tab.PNG" width="550" alt="Start screen">


##5. Histogram

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/histogram_tab.PNG" width="550" alt="Start screen">


##6. Volcano Plot

<img src="https://raw.githubusercontent.com/WaylandM/aspi/master/images/volcano_plot_tab.PNG" width="550" alt="Start screen">


