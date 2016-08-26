#Examples

Here are examples of the results ASPI returns under different scenarios. Simulated data sets have been generated for parasitic infections showing: 

1. symmetry 
2. left bias with the left:right ratio varying between hosts
3. left bias with left:right ratio similar in all hosts
4. asymmetry with inconsistent bias (left bias in some hosts and right in others)

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
|9 	|81 	|118|
|10 	|84 	|102|

###Results

|Test	 |df	 |G	 |p   |
|------|-----|---|----|
|Pooled	 |1	 |0.983821810435273	 |0.321257080666917|
|Heterogeneity	 |9	 |14.3881049875038	 |0.109173866154248|
|Total	 |10	 |15.371926797939	 |0.119078939601796|



|Host	|Left	|Right	|G	|p	|BH	|Holm|
|-----|-----|-------|---|---|---|----|
|1	|86	|89	|0.0514310906751607	|0.820591520535193	|0.911768356150215	|1|
|2	|96	|112	|1.23198588911471	|0.26702117728936	|0.474948545522566	|1|
|3	|92	|88	|0.0888962062923122	|0.765585118481768	|0.911768356150215	|1|
|4	|112	|104	|0.296364073843759	|0.586170849829146	|0.837386928327351	|1|
|5	|90	|109	|1.81683660791132	|0.17769028583282	|0.466372167217686	|1|
|6	|117	|96	|2.07378983082111	|0.149848752143328	|0.466372167217686	|1|
|7	|98	|97	|0.00512822760578169	|0.94291097302238	|0.94291097302238	|1|
|8	|106	|91	|1.1432381556759	|0.284969127313539	|0.474948545522566	|1|
|9	|81	|118	|6.91959205334223	|0.00852564230250276	|0.0852564230250276	|0.0852564230250276|
|10	|84	|102	|1.74466466265676	|0.186548866887074	|0.466372167217686	|1|



##Left bias with left:right ratio varying between hosts
###Data
Simulated data file: [simulated_left_bias_heterogeneous_proportions.csv](https://github.com/WaylandM/aspi/blob/master/data/parasites/simulated_left_bias_heterogeneous_proportions.csv)

|Host Accession Number 	|left 	|right|
|-----------------------|-------|-----|
|1 	|165 	53|
|2 	|235 	126|
|3 	|203 	128|
|4 	|219 	101|
|5 	|246 	144|
|6 	|233 	110|
|7 	|189 	52|
|8 	|193 	84|
|9 	|170 	97|
|10 	|199 	91|

###Results


##Left bias with left:right ratio similar in all hosts
Simulated data file: [simulated_left_bias_homogeneous_proportions.csv](https://github.com/WaylandM/aspi/blob/master/data/parasites/simulated_left_bias_homogeneous_proportions.csv)

##Asymmetry with inconsistent bias
Simulated data file: [simulated_asymmetry_inconsistent_bias.csv](https://github.com/WaylandM/aspi/blob/master/data/parasites/simulated_asymmetry_inconsistent_bias.csv)

