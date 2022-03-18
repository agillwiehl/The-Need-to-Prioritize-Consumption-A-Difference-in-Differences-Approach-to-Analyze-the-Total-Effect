* Propensity Score Results (4/5)

*** from the Set-Up Code, we only extract the recoded variables that we want for the propensity score matching

*** your file will be differently named ***

use  homedeliver dummykglpg dummylargecylinder dummysmallcylinder smallcylinder largecylinder kglpg treat_new aft interaction_new age agesq bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass totalnumhh dayexpend femalemaker m1_q11_village_code finalhhid m1_q3_hhid treat_new hhidfe interaction_new  using "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"


flexpaneldid_preprocessing, id(hhidfe) treatment(treat_new) time(aft) matchvars(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker age totalnumhh dayexpend) matchtimerel(0)prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta) replace

clear


* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"



***** All Observations 
flexpaneldid dummykglpg, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldiddummkglpg102621.doc, replace

clear


* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"

flexpaneldid dummylargecylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldiddummylarge102621.doc, replace

clear

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"

flexpaneldid dummysmallcylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel test prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldiddummysmall102621.doc, replace

clear

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"

drop if kglpg==0

flexpaneldid kglpg, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidkglpg102621.doc, replace

clear

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"

drop if kglpg==0

flexpaneldid largecylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidlarge102821.doc, replace

clear
* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"

drop if kglpg==0

flexpaneldid smallcylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidsmall102821.doc, replace

clear

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"

drop if kglpg==0

flexpaneldid homedeliver, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidhomedeliver102621.doc, replace



*** Tier analysis 
use "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (5).dta"
merge m:m m1_q3_hhid using "/Users/annelisewiehl/ACCESS-INDIA/DeltaTier.dta"
 
 ** generate moveuptier variable
gen moveuptier=deltatier 
recode moveuptier 0=0 *=1

** remove double observations (the DeltaTier originally has all observations)
bys hhidfe: gen nyear=_N
tabulate nyear aft
drop if nyear==1

duplicates report 
duplicates drop hhidfe aft, force


flexpaneldid moveuptier, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidtier102621.doc, replace




