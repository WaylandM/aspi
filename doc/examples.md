#Examples

Here are examples of the results ASPI returns under different scenarios. Simulated data sets have been generated for parasitic infections showing: 

1. [symmetry](#symmetry) 
2. [left bias with the left:right ratio varying between hosts](#left-bias-heterogeneous)
3. [left bias with left:right ratio similar in all hosts](#left-bias-homogeneous)
4. [asymmetry with inconsistent bias left bias in some hosts and right in others](#asymmetry-with-inconsistent-bias)

##Symmetry
###Data
Simulated data file: [simulated_symmetrical_infection.csv](https://github.com/WaylandM/aspi/blob/master/data/parasites/simulated_symmetrical_infection.csv)

|Host Accession Number 	|left 	|right|
|-----------------------|-------|-----|
|1 	|86 	|89|
|2 	|96 	|112|
|3 	|92 	|88|
|4 	|112 	|104|
|5 	|90 	|109|
|6 	|117 	|96|
|7 	|98 	|97|
|8 	|106 	|91|
|9 	|98 	|108|
|10 	|84 	|102|

###Results

|Test 	|df 	|G 	|p |
|-------|-----|---|--|
|Pooled 	|1 	|0.146330920915123 	|0.70206661375943|
|Heterogeneity 	|9 	|8.79163155133531 	|0.456726682229064|
|Total 	|10 	|8.93796247225043 	|0.538001144071982|

