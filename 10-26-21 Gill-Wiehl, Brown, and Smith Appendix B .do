** Appendix B Code File--- 5 out of 5 code sets
** This appendix is all the analysis/sensitivity analysis but including observations that switched groups between the two waves of data. 
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


* Generate a new treatment variable for only the households who maintained bpl status throughout the two years
by hhidfe: egen trt_sum=total(trt)
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

*** Results for Appendix B
frame copy TreatControl3 TreatControlonly18 
frame change TreatControlonly18
keep if AFT==1

**Panel A
frame change TreatControlonly15

* kg of LPG for treatment group in 2015 
summarize dummykglpg if treat_new==1 

* kg of LPG for comparison group in 2015 
summarize dummykglpg if treat_new==0 

frame change TreatControlonly18
* kg of LPG for treatment group in 2018
summarize dummykglpg if treat_new==1 

* kg of LPG for comparison group in 2018 
summarize dummykglpg if treat_new==0


**Panel B
frame change TreatControlonly15

* kg of LPG for treatment group in 2015 
summarize kgLPG if treat_new==1 

* kg of LPG for comparison group in 2015 
summarize kgLPG if treat_new==0 

frame change TreatControlonly18
* kg of LPG for treatment group in 2018
summarize kgLPG if treat_new==1 

* kg of LPG for comparison group in 2018 
summarize kgLPG if treat_new==0



* Results.A KG LPG 
frame change TreatControl3

*First stage decision to get gas

xtreg dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregfirststage.doc, replace 


* 2nd stage decision to use gas 



xtreg kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage.doc, replace 

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders


xtreg dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage.doc, append

* 2nd stage decision to use large cylinders



xtreg largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage.doc, append

* 2nd stage decision to use small cylinders


xtreg smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtregsecondstage.doc, append




*Home Deliver

* decision to get homeliver

xtreg homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtreghomedeliver.doc, replace 

*** Sensitivity Analysis 
** Income level of 500

frame change TreatControl500
* Results.A KG LPG 

*First stage decision to get gas

xtreg dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregfirststage500.doc, replace 


* 2nd stage decision to use gas 



xtreg kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage500.doc, replace 

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders


xtreg dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage500.doc, append

* 2nd stage decision to use large cylinders



xtreg largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage500.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage500.doc, append

* 2nd stage decision to use small cylinders


xtreg smallcylinder treat_new aft interaction_new age totalnumhh dayexpend  femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtregsecondstage500.doc, append





*Home Deliver

* decision to get homeliver

xtreg homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtreghomedeliver.doc, append

** All Observations

frame change Allobservations
* Results.A KG LPG 

*First stage decision to get gas


xtreg dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregfirststageAll.doc, replace 


* 2nd stage decision to use gas 



xtreg kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstageAll.doc, replace 

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders


xtreg dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststageAll.doc, append

* 2nd stage decision to use large cylinders



xtreg largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstageAll.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststageAll.doc, append

* 2nd stage decision to use small cylinders


xtreg smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtregsecondstageAll.doc, append








*Home Deliver

* decision to get homeliver

xtreg homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtreghomedeliver.doc, append

*** Adding in Age^2 


frame change TreatControl3
* Results.A KG LPG 

*First stage decision to get gas
xtreg dummykglpg treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregagesq.doc, replace

* 2nd stage decision to use gas 

xtreg kglpg treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregagesq2.doc, replace

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders
xtreg dummylargecylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregagesq.doc, append

* 2nd stage decision to use large cylinders

xtreg largecylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregagesq2.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregagesq.doc, append



* 2nd stage decision to use small cylinders

xtreg smallcylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregagesq2.doc, append




*Home Deliver

* decision to get homeliver 

xtreg homedeliver treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtreghomedeliver.doc, append

*** Further Sensitivity Analysis: csdid, drdid, 2stage
*csdid
* dummykglpg
frame change TreatControl3

csdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdiddummylpg.doc, replace

csdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdiddummylpg.doc, append


*dummylargecylinder

csdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdiddummylarge.doc, replace

csdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdiddummylarge.doc, append



* dummy small cylinder
csdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdiddummysmall.doc, replace

csdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdiddummysmall.doc, append



* kglpg
frame change TreatControl3

csdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidlpg.doc, replace

csdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidlpg.doc, append



*largecylinder

csdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidlarge.doc, replace

csdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidlarge.doc, append



* small cylinder
csdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidsmall.doc, replace

csdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidsmall.doc, append





* homedeliver
frame change TreatControl3

csdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidhome.doc, replace

csdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidhome.doc, append




***drdid 
*dummykglpg
drdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdiddummykglpg.doc, replace

drdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdiddummykglpg.doc, append 

*dummylargecylinder
drdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdiddummylarge.doc, replace

drdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdiddummylarge.doc, append 

*dummysmallcylinder
drdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdiddummysmall.doc, replace

drdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdiddummysmall.doc, append 

*kglpg
drdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidkglpg.doc, replace

drdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidkglpg.doc, append 

*largecylinder
drdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidlarge.doc, replace

drdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidlarge.doc, append 

*smallcylinder
drdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidsmall.doc, replace

drdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidsmall.doc, append 


* home 
drdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidhome.doc, replace

drdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidhome.doc, append




*** Placebo test with different dependent varriables
** heard about a microwave
xtreg m2_q56_micro_aware treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using placebotest.doc, replace

** Number of kids
xtreg m1_q29_no_children treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using placebotest.doc, append

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

xtset hhidfe (aft)

by hhidfe: egen trt_sum=total(trt)
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
ttest moveuptier by(treat_new)

* Results.B. Change in Tier 
*  move up any tier
frame change TierTreatControl3

xtreg moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregtier.doc, replace 

** 500 Rs Cutoff

frame change TierTreatControl500

* Results.B. Change in Tier 
*  move up any tier
xtreg moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregtier.doc, append

** All Observations
frame change DeltaTier

* Results.B. Change in Tier 
*  move up any tier

xtreg moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregtier.doc, append

** Add in age^2

frame change TierTreatControl3

* Results.B. Change in Tier 
*  move up any tier
xtreg moveuptier treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregtier.doc, append

** Sensitivity Analysis with crdid and drdid

frame change TierTreatControl3

csdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidtier.doc, replace

csdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidtier.doc, append



** drdid
drdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidtier.doc, replace

drdid moveuptier treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidtier.doc, append


* Propensity Score Results for Appendix B

*** from the Set-Up Code, we only extract the recoded variables that we want for the propensity score matching

*** your file will be differently named ***

use  homedeliver dummykglpg dummylargecylinder dummysmallcylinder smallcylinder largecylinder kglpg treat_new aft interaction_new age agesq bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass totalnumhh dayexpend femalemaker m1_q11_village_code finalhhid m1_q3_hhid treat_new hhidfe interaction_new  using "/Users/annelisewiehl/Downloads/CEEW - ACCESS20152018 Appended (6).dta"


flexpaneldid_preprocessing, id(hhidfe) treatment(treat_new) time(aft) matchvars(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker age totalnumhh dayexpend) matchtimerel(0)prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data_appendb.dta) replace

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/fulldata.dta"

***** All Observations 
flexpaneldid dummykglpg, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel test prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data_appendb.dta)

outreg2 using flexpaneldidAllobservationsdummkglpg.doc, replace

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/fulldata.dta"

flexpaneldid dummylargecylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidAllobservationsdummylarge.doc, replace

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/fulldata.dta"

flexpaneldid dummysmallcylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel test prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidAllobservationsdummysmall.doc, replace

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/fulldata.dta"

drop if kglpg==0

flexpaneldid kglpg, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data_appendb.dta)

outreg2 using flexpaneldidAllobservationskglpg.doc, replace

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/fulldata.dta"

drop if kglpg==0

flexpaneldid largecylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidAllobservationslarge.doc, replace

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/fulldata.dta"

drop if kglpg==0

flexpaneldid smallcylinder, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidAllobservationssmall.doc, replace

* you have to re-open the orginal data set
use "/Users/annelisewiehl/Downloads/fulldata.dta"

drop if kglpg==0

flexpaneldid homedeliver, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel test prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidAllobservationshomedeliver.doc, replace



*** Tier analysis 
use "/Users/annelisewiehl/Downloads/fulldata.dta"
merge m:m m1_q3_hhid using "/Users/annelisewiehl/ACCESS-INDIA/DeltaTier.dta"
 
 ** generate moveuptier variable
gen moveuptier=deltatier 
recode moveuptier 0=0 *=1

** remove double observations (the DeltaTier originally has all observations)
bys hhidfe: gen nyear=_N
tabulate nyear aft
drop if nyear==1



use "/Users/annelisewiehl/ACCESS-INDIA/2-14-21 Tier Analysis.dta"

flexpaneldid moveuptier, id(hhidfe) treatment(treat_new) time(aft) statmatching(con(age totalnumhh dayexpend) cat(bihar jharkhand madhyapradesh odisha uttarpradesh  upto5edu upto10edu upto12edu gradedu hindu muslim schedcaste schedtribe backwardclass femalemaker)) outcometimerelstart(1) didmodel prepdataset(/Users/annelisewiehl/Downloads/preprocessed_data.dta)

outreg2 using flexpaneldidAllobservationstier.doc, replace
