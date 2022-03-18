** Set Up Code File--- 1 out of 5 code sets
* Open the CEEW ACCESS Appended data set from Harvard Dataverse at https://doi.org/10.7910/DVN/AHFINM. 
* Recode co-variates, independent, and dependent variables
* Age

gen male=m1_q20_gender 


gen age=m1_q19_age


gen state2=m1_q8_state
encode state2, generate(state)
* States
gen bihar=state
recode bihar 1=1 *=0


gen jharkhand=state
recode jharkhand 2=1 *=0



gen madhyapradesh=state
recode madhyapradesh 3=1 *=0


gen odisha=state
recode odisha 4=1 *=0


gen uttarpradesh=state
recode uttarpradesh 5=1 *=0


gen westbengal=state
recode westbengal 6=1 *=0



* Year

generate AFT2=year
encode AFT2, generate(AFT) 

recode AFT 1=0 2=1

gen aft=AFT


* Education 
gen noedu=m1_q23_edu 

recode noedu 1=1  *=0

gen upto5edu=m1_q23_edu

recode upto5edu 2=1 *=0

gen upto10edu=m1_q23_edu

recode upto10edu 3=1 *=0 

gen upto12edu=m1_q23_edu

recode upto12edu 4=1 *=0 

gen gradedu=m1_q23_edu

recode gradedu 5=1 *=0 

* Religion 
gen hindu=m1_q24_religion

recode hindu 1=1 *=0 

gen muslim=m1_q24_religion

recode muslim 2=1 *=0 

gen otherreligion=m1_q24_religion

recode otherreligion 3=1 *=0

* Caste 

gen schedcaste=m1_q25_caste

recode schedcaste 1=1 *=0 

gen schedtribe=m1_q25_caste

recode schedtribe 2=1 *=0

gen backwardclass=m1_q25_caste

recode backwardclass 3=1 *=0

gen general=m1_q25_caste

recode general 4=1 *=0

* Household Size 

gen numchild=m1_q29_no_children

gen numadult=m1_q27_no_adult

gen totalnumhh=numchild+numadult

* Daily Expend 

gen monthexpend=m1_q32_month_expenditure 
destring monthexpend, replace force
gen dayexpend=monthexpend/30

* Female Decision Maker 
gen femalemaker=m1_q38_decision_maker
destring femalemaker, replace force
recode femalemaker 1=0 2=1 3=1 4=0

* Policy Beneficiary

gen pmuybenefit=m4_3n1_ujjwala_beneficiary
recode pmuybenefit  1=1 0=0
replace pmuybenefit=0 if missing(pmuybenefit)

* Use LPG

gen useLPG=m4_q103_lpg
replace useLPG=0 if missing(useLPG)

* Age of Connection 

gen connectionage=m4_q103_1_lpg_year

* Home Delivery

gen homedeliver=m4_q103_14_lpg_cyl_deliver 

* LPG Refills 

gen smallcylinder=m4_q103_7_lpg_scyl



replace smallcylinder=0 if missing(smallcylinder)



gen largecylinder=m4_q103_4_lpg_lcyl

replace largecylinder=0 if missing(largecylinder)



gen kgLPG= smallcylinder*5+largecylinder*14.2
gen kglpg=kgLPG

* Below Poverty Line 

gen TRT=m1_q26_ration
 
recode TRT 0=0 1=0 2=1 3=1
gen trt=TRT


* Age Squared 

gen agesq=age*age

* Interation Term for Age of Connection and PMUY benefit 

 gen pmuybenefit_connectionage= pmuybenefit*connectionage

* create dummyvariables for LPGkg, large cylinder, and small cylinders

gen dummykglpg=kgLPG
gen dummylargecylinder=largecylinder
gen dummysmallcylinder=smallcylinder

recode dummykglpg 0=0 *=1
recode dummysmallcylinder 0=0 *=1
recode dummylargecylinder 0=0 *=1


encode finalhhid, gen(hhidfe)

xtset hhidfe (aft)
xtsum


* Generate a new treatment variable for only the households who maintained bpl status throughout the two years and drop those who switched status
by hhidfe: egen trt_sum=total(trt)
drop if trt_sum==1
gen treat_new=trt_sum 
recode treat_new 2=1 *=0
xtsum treat_new 

gen interaction_new=treat_new*aft

** drop all observations that only offer a single year (i.e. the additions from 2018) as this produces bias
bys hhidfe: gen nyear=_N
tabulate nyear aft
drop if nyear==1

* All good (2-17-2021)

* Check Variables for Recoding Errors and values to create Table 1 

summarize age if AFT==0
summarize age if AFT==1

summarize bihar if AFT==0
summarize bihar if AFT==1

summarize madhyapradesh if AFT==0
summarize madhyapradesh if AFT==1

summarize jharkhand if AFT==0
summarize jharkhand if AFT==1

summarize odisha if AFT==0
summarize odisha if AFT==1

summarize uttarpradesh if AFT==0
summarize uttarpradesh if AFT==1

summarize westbengal if AFT==0
summarize westbengal if AFT==1

summarize noedu if AFT==0
summarize noedu if AFT==1

summarize upto5edu if AFT==0
summarize upto5edu if AFT==1

summarize upto10edu if AFT==0
summarize upto10edu if AFT==1

summarize upto12edu if AFT==0
summarize upto12edu if AFT==1

summarize gradedu if AFT==0
summarize gradedu if AFT==1

summarize schedcaste if AFT==0
summarize schedcaste if AFT==1

summarize schedtribe if AFT==0
summarize schedtribe if AFT==1

summarize general if AFT==0
summarize general if AFT==1

summarize backwardclass if AFT==0
summarize backwardclass if AFT==1

summarize hindu if AFT==0
summarize hindu if AFT==1

summarize muslim if AFT==0
summarize muslim if AFT==1

summarize otherreligion if AFT==0
summarize otherreligion if AFT==1

summarize AFT

summarize totalnumhh if AFT==0
summarize totalnumhh if AFT==1

summarize dayexpend if AFT==0
summarize dayexpend if AFT==1

summarize femalemaker if AFT==0
summarize femalemaker if AFT==1

summarize pmuybenefit if AFT==0
summarize pmuybenefit if AFT==1

summarize useLPG if AFT==0
summarize useLPG if AFT==1

summarize connectionage if AFT==0
summarize connectionage if AFT==1

summarize smallcylinder if AFT==0
summarize smallcylinder if AFT==1

summarize largecylinder if AFT==0
summarize largecylinder if AFT==1

summarize kgLPG if AFT==0
summarize kgLPG if AFT==1

summarize trt if AFT==0
summarize trt if AFT==1

tabulate treat_new aft 


* Turn dayexpend, femalemaker, and homedeliver into numerics 

destring dayexpend, replace force

destring femalemaker, replace force

destring homedeliver, replace force



* Now copy this data frame and keep observations if dayexpend<300Rs to reflect the 300Rs/day income cuttoff.
frame rename default Allobservations

by hhidfe: egen dayexpend_sum=total(dayexpend)

frame copy Allobservations TreatControl3
frame copy Allobservations TreatControl500
 
frame change TreatControl3

keep if dayexpend_sum<=600

frame change TreatControl500

keep if dayexpend_sum<=1000

** Create Table of Descriptive Stats for Treat & Comparison 
 
frame change TreatControl3

summarize male if AFT==0 & treat_new==1
summarize male if AFT==0 & treat_new==0

summarize age if AFT==0 & treat_new==1
summarize age if AFT==0 & treat_new==0

summarize bihar if AFT==0 & treat_new==1
summarize bihar if AFT==0 & treat_new==0

summarize madhyapradesh if AFT==0 & treat_new==1
summarize madhyapradesh if AFT==0 & treat_new==0

summarize jharkhand if AFT==0 & treat_new==1
summarize jharkhand if AFT==0 & treat_new==0

summarize odisha if AFT==0 & treat_new==1
summarize odisha if AFT==0 & treat_new==0

summarize uttarpradesh if AFT==0 & treat_new==1
summarize uttarpradesh if AFT==0 & treat_new==0

summarize westbengal if AFT==0 & treat_new==1
summarize westbengal if AFT==0 & treat_new==0

summarize noedu if AFT==0 & treat_new==1
summarize noedu if AFT==0 & treat_new==0

summarize upto5edu if AFT==0 & treat_new==1
summarize upto5edu if AFT==0 & treat_new==0

summarize upto10edu if AFT==0 & treat_new==1
summarize upto10edu if AFT==0 & treat_new==0

summarize upto12edu if AFT==0 & treat_new==1
summarize upto12edu if AFT==0 & treat_new==0

summarize gradedu if AFT==0 & treat_new==1
summarize gradedu if AFT==0 & treat_new==0

summarize schedcaste if AFT==0 & treat_new==1
summarize schedcaste if AFT==0 & treat_new==0

summarize schedtribe if AFT==0 & treat_new==1
summarize schedtribe if AFT==0 & treat_new==0

summarize general if AFT==0 & treat_new==1
summarize general if AFT==0 & treat_new==0

summarize backwardclass if AFT==0 & treat_new==1
summarize backwardclass if AFT==0 & treat_new==0

summarize hindu if AFT==0 & treat_new==1
summarize hindu if AFT==0 & treat_new==0

summarize muslim if AFT==0 & treat_new==1
summarize muslim if AFT==0 & treat_new==0

summarize otherreligion if AFT==0 & treat_new==1
summarize otherreligion if AFT==0 & treat_new==0

summarize AFT

summarize totalnumhh if AFT==0 & treat_new==1
summarize totalnumhh if AFT==0 & treat_new==0

summarize dayexpend if AFT==0 & treat_new==1
summarize dayexpend if AFT==0 & treat_new==0

summarize femalemaker if AFT==0 & treat_new==1
summarize femalemaker if AFT==0 & treat_new==0


summarize useLPG if AFT==0 & treat_new==1
summarize useLPG if AFT==0 & treat_new==0


summarize smallcylinder if AFT==0 & treat_new==1
summarize smallcylinder if AFT==0 & treat_new==0

summarize dummysmallcylinder if AFT==0 & treat_new==1
summarize dummysmallcylinder if AFT==0 & treat_new==0

summarize largecylinder if AFT==0 & treat_new==1
summarize largecylinder if AFT==0 & treat_new==0

summarize dummylargecylinder if AFT==0 & treat_new==1
summarize dummylargecylinder if AFT==0 & treat_new==0

summarize kgLPG if AFT==0 & treat_new==1
summarize kgLPG if AFT==0 & treat_new==0

summarize dummykglpg if AFT==0 & treat_new==1
summarize dummykglpg if AFT==0 & treat_new==0

summarize homedeliver if AFT==0 & treat_new==1
summarize homedeliver if AFT==0 & treat_new==0


frame copy TreatControl3 TreatControlonly15
frame change TreatControlonly15
keep if AFT==0


*tests to check statistical differences at baseline
ttest male, by(treat_new)
ttest age, by(treat_new)


ttest bihar, by(treat_new)


ttest madhyapradesh, by(treat_new)


ttest jharkhand, by(treat_new)


ttest odisha, by(treat_new)


ttest uttarpradesh, by(treat_new)


ttest westbengal, by(treat_new)


ttest noedu, by(treat_new)


ttest upto5edu, by(treat_new)


ttest upto10edu, by(treat_new)


ttest upto12edu, by(treat_new)


ttest gradedu, by(treat_new)


ttest schedcaste, by(treat_new)


ttest schedtribe, by(treat_new)

ttest general, by(treat_new)


ttest backwardclass, by(treat_new)


ttest hindu, by(treat_new)


ttest muslim, by(treat_new)


ttest otherreligion, by(treat_new)


ttest totalnumhh, by(treat_new)


ttest dayexpend, by(treat_new)


ttest femalemaker, by(treat_new)


ttest dummykglpg, by(treat_new)


ttest dummysmallcylinder, by(treat_new)


ttest dummylargecylinder, by(treat_new)


ttest kgLPG, by(treat_new)


ttest largecylinder, by(treat_new)


ttest smallcylinder, by(treat_new)


ttest homedeliver, by(treat_new)

*All good (2-17-2021)

