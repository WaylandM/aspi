# Examples

Here are examples of the results ASPI returns under different scenarios. Simulated data sets have been generated for parasitic infections showing: 

1. [symmetry](#symmetry) 
2. [left bias with the left:right ratio varying between hosts](#left-bias-heterogeneous)
3. [left bias with left:right ratio similar in all hosts](#left-bias-homogeneous)
4. [asymmetry with inconsistent bias left bias in some hosts and right in others](#asymmetry-with-inconsistent-bias)

## Symmetry
### Data
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

Similar numbers of parasites on each side.

### Results

|Test 	|df 	|G 	|p |
|-------|-----|---|---|
|Pooled 	|1 	|0.146330920915123 	|0.70206661375943|
|Heterogeneity 	|9 	|8.79163155133531 	|0.456726682229064|
|Total 	|10 	|8.93796247225043 	|0.538001144071982|

Pooled, heterogeneity and total G-test statistics are not significant at an alpha of 0.05.

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

Individual G-tests show that parasite distributions do not differ from symmetry in any of the 10 hosts.

## Left bias with left:right ratio varying between hosts<a id="left-bias-heterogeneous"></a>
### Data
Simulated data file: [simulated_left_bias_heterogeneous_proportions.csv](https://github.com/WaylandM/aspi/blob/master/data/parasites/simulated_left_bias_heterogeneous_proportions.csv)

|Host Accession Number 	|left 	|right|
|-----------------------|-------|-----|
|1 	|165 	|53|
|2 	|235 	|126|
|3 	|203 	|128|
|4 	|219 	|101|
|5 	|246 	|144|
|6 	|233 	|110|
|7 	|189 	|52|
|8 	|193 	|84|
|9 	|170 	|97|
|10 	|199 	|91|

In this example there are more parasites on the left than the right in every host. Furthermore, the proportion of parasites on the left and right sides varies betweeen hosts. For example, in host **1** there are three times as many parasites on the left than on the right, whereas in host **3** the ratio is approximately 1.6:1.

### Results

|Test	 |df	 |G	 |p  |
|------|-----|---|---|
|Pooled	 |1	 |382.12807212135	 |4.28203156354104e-85|
|Heterogeneity	 |9	 |33.7113460367219	 |0.000100347129240852|
|Total	 |10	 |415.839418158072	 |3.99378016012777e-83|

Pooled, heterogeneity and total G-test statistics are all highly significant (p<0.001). 

* A significant total G-test indicates that overall the parasite distributions deviate from symmetry in some way. 
* A significant pooled G-test shows that the sum of the counts of the parasites from the left side of hosts differs from the sum of the counts of the parasites from the right side of hosts.
* A significant heterogeneity G-test reveals that the proportion of parasites found on the left and right sides, varies from host to host.


|Host	|Left	|Right	|G	|p	|BH	|Holm|
|-----|-----|-------|---|---|---|----|
|1	|165	|53	|60.3852725718099	|7.79943410730731e-15	|3.89971705365366e-14	|7.01949069657658e-14|
|2	|235	|126	|33.4306106474677	|7.38523824283611e-9	|1.05503403469087e-8	|2.95409529713445e-8|
|3	|203	|128	|17.1424440854558	|0.0000346786174084717	|0.0000346786174084717	|0.0000346786174084717|
|4	|219	|101	|44.5565203119125	|2.47119132902404e-11	|6.1779783225601e-11	|1.72983393031683e-10|
|5	|246	|144	|26.9896902768882	|2.04543541946344e-7	|2.55679427432929e-7	|6.13630625839031e-7|
|6	|233	|110	|45.1054789442357	|1.86702318495702e-11	|6.1779783225601e-11	|1.49361854796561e-10|
|7	|189	|52	|82.7345375124112	|9.38470729017537e-20	|9.38470729017537e-19	|9.38470729017537e-19|
|8	|193	|84	|44.0734747253867	|3.16277964157487e-11	|6.32555928314974e-11	|1.89766778494492e-10|
|9	|170	|97	|20.2152092600228	|0.00000692005577265575	|0.00000768895085850639	|0.0000138401115453115|
|10	|199	|91	|41.2061798224816	|1.36988747717129e-10	|2.28314579528549e-10	|6.84943738585646e-10|

Individual G-tests demonstrate a highly significant (FDR corrected p-value < 0.00001) difference between the numbers of parasites found on the left and right sides in all 10 hosts.

## Left bias with left:right ratio similar in all hosts<a id="left-bias-homogeneous"></a>
### Data
Simulated data file: [simulated_left_bias_homogeneous_proportions.csv](https://github.com/WaylandM/aspi/blob/master/data/parasites/simulated_left_bias_homogeneous_proportions.csv)

|Host Accession Number 	|left 	|right|
|-----------------------|-------|-----|
|1 	|183 	|84|
|2 	|175 	|86|
|3 	|133 	|68|
|4 	|83 	|36|
|5 	|100 	|42|
|6 	|69 	|34|
|7 	|111 	|49|
|8 	|163 	|77|
|9 	|138 	|81|
|10 	|157 	|85|

Similar to the previous data-set, this example also shows a left-bias. However, in this example the ratio of the number of parasites on the left side to the number on the right is aproximately 2:1 in all hosts.

### Results

|Test 	|df 	|G 	|p|
|-------|-----|---|---|
|Pooled 	|1 	|234.461657733301 	|6.34408659631689e-53|
|Heterogeneity 	|9 	|4.05015602190781 	|0.908080444644809|
|Total 	|10 	|238.511813755209 	|1.40674151103899e-45| 

The pooled and total G-test statistics are highly significant. However, the heterogeneity G-test statistic is not significant at the 5% threshold.
* A significant total G-test indicates that overall the parasite distributions deviate from symmetry in some way. 
* A significant pooled G-test shows that the sum of the counts of the parasites from the left side of hosts differs from the sum of the counts of the parasites from the right side of hosts.
* A non-significant heterogeneity G-test suggests that the proportion of parasites found on the left and right sides does not vary between hosts.


|Host	|Left	|Right	|G	|p	|BH	|Holm|
|-----|-----|-------|---|---|---|----|
|1	|183	|84	|37.5989649789143	|8.68905748068773e-10	|8.68905748068773e-9	|8.68905748068773e-9|
|2	|175	|86	|30.9660014586787	|2.62588180813738e-8	|8.75293936045794e-8	|2.1007054465099e-7|
|3	|133	|68	|21.4025095562866	|0.00000372283586908068	|0.00000531833695582955	|0.0000155353840139914|
|4	|83	|36	|19.0785420757981	|0.0000125447451722269	|0.0000156809314652836	|0.0000376342355166806|
|5	|100	|42	|24.3972000536876	|7.83825320923353e-7	|0.00000156765064184671	|0.00000477340936567812|
|6	|69	|34	|12.1333609283645	|0.000495277795428561	|0.000495277795428561	|0.000495277795428561|
|7	|111	|49	|24.6655708105375	|6.81915623668302e-7	|0.00000156765064184671	|0.00000477340936567812|
|8	|163	|77	|31.5125638930898	|1.98153981743315e-8	|8.75293936045794e-8	|1.78338583568983e-7|
|9	|138	|81	|15.0078275859522	|0.000107066158844774	|0.000118962398716416	|0.000214132317689548|
|10	|157	|85	|21.7492724138998	|0.00000310707680279828	|0.00000517846133799713	|0.0000155353840139914|

All individual G-tests are significant (FDR corrected p-value < 0.001), demonstrating that the left bias occurs in all 10 hosts.

## Asymmetry with inconsistent bias<a id="asymmetry-with-inconsistent-bias"></a>
Simulated data file: [simulated_asymmetry_inconsistent_bias.csv](https://github.com/WaylandM/aspi/blob/master/data/parasites/simulated_asymmetry_inconsistent_bias.csv)

|Host Accession Number 	|left 	|right|
|-----------------------|-------|-----|
|1 	|105 	|117|
|2 	|200 	|142|
|3 	|74 	|195|
|4 	|172 	|182|
|5 	|88 	|84|
|6 	|194 	|140|
|7 	|199 	|166|
|8 	|75 	|106|
|9 	|157 	|187|
|10 	|178 	|108|

In this example some hosts have many more parasites on the left than right, whereas others have more on the right than left.

### Results

|Test 	|df 	|G 	|p|
|-------|-----|---|---|
|Pooled 	|1 	|0.0784248954615663 	|0.779443400466083|
|Heterogeneity 	|9 	|104.280018014651 	|2.13746167861965e-18|
|Total 	|10 	|104.358442910113 	|7.28706563795127e-18|

The hetereogeneity and total G-test statistics are both highly significant, but the pooled G-test is not significant at an alpha of 0.05. 
* A significant total G-test statistic indicates that overall the parasite distributions deviate from symmetry in some way.
* A non-significant pooled G-test shows there is no evidence of bias towards one side.
* A significant heterogeneity G-test reveals that the proportion of parasites on the left and right sides varies from host to host.

|Host	|Left	|Right	|G	|p	|BH	|Holm|
|-----|-----|-------|---|---|---|----|
|1	|105	|117	|0.648964893078459	|0.420483000518133	|0.525603750647667	|1|
|2	|200	|142	|9.88395833015335	|0.00166725888363099	|0.00555752961210331	|0.0133380710690479|
|3	|74	|195	|56.4299225495395	|5.82373475090054e-14	|5.82373475090054e-13	|5.82373475090054e-13|
|4	|172	|182	|0.282523457510361	|0.595052003312743	|0.661168892569715	1|
|5	|88	|84	|0.093031642634366	|0.760357858740811	|0.760357858740811	1|
|6	|194	|140	|8.7689773527841	|0.00306397191135336	|0.00765992977838339	|0.0214478033794735|
|7	|199	|166	|2.9876396682616	|0.0839023820404203	|0.139837303400701	|0.419511910202102|
|8	|75	|106	|5.33565902667606	|0.0208934391588535	|0.041786878317707	|0.125360634953121|
|9	|157	|187	|2.6196055353284	|0.10555067699548	|0.150786681422114	|0.422202707981918|
|10	|178	|108	|17.3081604541468	|0.0000317819069131459	|0.00015890953456573	|0.000286037162218313|

If we choose an FDR (Benjamini and Hochberg) corrected p-value of 0.05 as our significance threshold, we find five of ten hosts have asymmetric distributions of parasites. Of these five, three show a left bias and two a right bias. This is an example of inconsistent bias.
