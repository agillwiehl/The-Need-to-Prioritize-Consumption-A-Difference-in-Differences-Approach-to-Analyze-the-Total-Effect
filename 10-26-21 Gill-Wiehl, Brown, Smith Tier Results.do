** ALL TIER ANALYSIS (3/5)

* Open the data set from R-CODE 
* please not that the import with be different based on your path

frame create DeltaTier

frame change DeltaTier

import delimited "/Users/annelisewiehl/ACCESS-INDIA/C:\Users\agillwiehl\Desktop\TierAppendDF.csv", clear 

* Recode co-variates, independent, and dependent variables
*year
gen AFT=aft
* Age

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
destring pmuybenefit, replace force
recode pmuybenefit  1=1 0=0
replace pmuybenefit=0 if missing(pmuybenefit)

* Use LPG

gen useLPG=m4_q103_lpg

* Age of Connection 

gen connectionage=m4_q103_1_lpg_year

* Home Delivery

gen homedeliver=m4_q103_14_lpg_cyl_deliver 

* LPG Refills 

gen smallcylinder=m4_q103_7_lpg_scyl
destring smallcylinder, replace force


replace smallcylinder=0 if missing(smallcylinder)



gen largecylinder=m4_q103_4_lpg_lcyl

destring largecylinder, replace force

replace largecylinder=0 if missing(largecylinder)



gen kgLPG= smallcylinder*5+largecylinder*14.2
gen kglpg=kgLPG

* Below Poverty Line/Treatment Status 

gen TRT=m1_q26_ration
 
recode TRT 0=0 1=0 2=1 3=1
gen trt=TRT

* Interaction Term 

gen interaction=AFT*TRT

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

destring moveuptier, replace force

encode finalhhid, gen(hhidfe)
duplicates tag hhidfe aft, gen(isdup)
drop if isdup==1

xtset hhidfe (aft)

by hhidfe: egen trt_sum=total(trt)
drop if trt_sum==1
gen treat_new=trt_sum 
recode treat_new 2=1 *=0
xtsum treat_new 

gen interaction_new=treat_new*aft

** Drop Observations only from 2018 as they may produce bias

bys hhidfe: gen nyear=[_N]

summarize nyear

drop if nyear!=2

by hhidfe: egen dayexpend_sum=total(dayexpend)

frame copy DeltaTier TierTreatControl3
frame copy DeltaTier  TierTreatControl500
 
frame change TierTreatControl3

keep if dayexpend_sum<=600

frame change TierTreatControl500

keep if dayexpend_sum<=1000


frame change TierTreatControl3

*value for table 5 comparing treat and control 
frame copy TierTreatControl3 Tieronly15
frame change Tieronly15
keep if aft==0
ttest moveuptier, by(treat_new)

* Results.B. Change in Tier 
*  move up any tier
frame change TierTreatControl3

xtreg moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregtier102621.doc, replace 

** 500 Rs Cutoff

frame change TierTreatControl500

* Results.B. Change in Tier 
*  move up any tier
xtreg moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregtier102621.doc, append

** All Observations
frame change DeltaTier

* Results.B. Change in Tier 
*  move up any tier

xtreg moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregtier102621.doc, append

** Add in age^2

frame change TierTreatControl3

* Results.B. Change in Tier 
*  move up any tier
xtreg moveuptier treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregtier102621.doc, append

** Sensitivity Analysis with crdid and drdid

frame change TierTreatControl3

csdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidtier102621.doc, replace

csdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidtier102621.doc, append



** drdid
drdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidtier102621.doc, replace

drdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidtier102621.doc, append
