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
|-------|-----|---|---|
|Pooled 	|1 	|0.146330920915123 	|0.70206661375943|
|Heterogeneity 	|9 	|8.79163155133531 	|0.456726682229064|
|Total 	|10 	|8.93796247225043 	|0.538001144071982|

|Host	|Left	|Right	|G	|p	|BH	|Holm|
|-----|-----|-------|---|---|---|----|
|1	|86	|89	|0.0514310906751607	|0.820591520535193	|0.911768356150215	|1|
|2	|96	|112	|1.23198588911471	|0.26702117728936	|0.569938254627077	|1|
|3	|92	|88	|0.0888962062923122	|0.765585118481767	|0.911768356150215	|1|
|4	|112	|104	|0.296364073843761	|0.586170849829145	|0.83738692832735	|1|
|5	|90	|109	|1.81683660791132	|0.17769028583282	|0.569938254627077	|1|
|6	|117	|96	|2.07378983082111	|0.149848752143328	|0.569938254627077	|1|
|7	|98	|97	|0.00512822760578169	|0.94291097302238	|0.94291097302238	|1|
|8	|106	|91	|1.1432381556759	|0.284969127313539	|0.569938254627077	|1|
|9	|98	|108	|0.485627727653613	|0.485884184917137	|0.809806974861896	|1|
|10	|84	|102	|1.74466466265676	|0.186548866887074	|0.569938254627077	|1|

