*** Results Code (2/5)
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

outreg2 using xtregfirststage102821.doc, replace 


* 2nd stage decision to use gas 



xtreg kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage102821.doc, replace 

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders


xtreg dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage102821.doc, append

* 2nd stage decision to use large cylinders



xtreg largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage102821.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage102821.doc, append

* 2nd stage decision to use small cylinders


xtreg smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtregsecondstage102821.doc, append







*Home Deliver

* decision to get homeliver

xtreg homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtreghomedeliver102821.doc, replace 

*** Sensitivity Analysis 
** Income level of 500

frame change TreatControl500
* Results.A KG LPG 

*First stage decision to get gas

xtreg dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregfirststage500_102821.doc, replace 


* 2nd stage decision to use gas 



xtreg kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage500_102821.doc, replace 

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders


xtreg dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage500_102821.doc, append

* 2nd stage decision to use large cylinders



xtreg largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstage500_102821.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststage500_102821.doc, append

* 2nd stage decision to use small cylinders


xtreg smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtregsecondstage500_102821.doc, append





*Home Deliver

* decision to get homeliver

xtreg homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtreghomedeliver102821.doc, append

** All Observations

frame change Allobservations
* Results.A KG LPG 

*First stage decision to get gas


xtreg dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using xtregfirststageAll_102821.doc, replace 


* 2nd stage decision to use gas 



xtreg kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstageAll_102821.doc, replace 

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders


xtreg dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststageAll_102821.doc, append

* 2nd stage decision to use large cylinders



xtreg largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregsecondstageAll_102821.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregfirststageAll_102821.doc, append

* 2nd stage decision to use small cylinders


xtreg smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtregsecondstageAll_102821.doc, append




*Home Deliver

* decision to get homeliver

xtreg homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtreghomedeliver102821.doc, append

*** Adding in Age^2 


frame change TreatControl3
* Results.A KG LPG 

*First stage decision to get gas
xtreg dummykglpg treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregagesq_102821.doc, replace

* 2nd stage decision to use gas 

xtreg kglpg treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregagesq2_102821.doc, replace

* Results.A.1 Large Cylinders

* First stage decision to get large cylinders
xtreg dummylargecylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregagesq_102821.doc, append

* 2nd stage decision to use large cylinders

xtreg largecylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregagesq2_102821.doc, append

* Results.A.2 Small Cylinders

* First stage decision to get small cylinders

xtreg dummysmallcylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)


outreg2 using xtregagesq_102821.doc, append



* 2nd stage decision to use small cylinders

xtreg smallcylinder treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)


outreg2 using xtregagesq2_102821.doc, append



*Home Deliver

* decision to get homeliver 

xtreg homedeliver treat_new aft interaction_new age agesq totalnumhh dayexpend femalemaker if kglpg>0, fe vce(cluster finalhhid)

outreg2 using xtreghomedeliver102821.doc, append


** stopped 10-28-21
*** Further Sensitivity Analysis: csdid and drdid
*csdid
* dummykglpg
frame change TreatControl3

csdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdiddummylpg102821.doc, replace

csdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdiddummylpg102821.doc, append



*dummylargecylinder

csdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdiddummylarge102821.doc, replace

csdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdiddummylarge102821.doc, append



* dummy small cylinder
csdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdiddummysmall102821.doc, replace

csdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdiddummysmall102821.doc, append



* kglpg
frame change TreatControl3

csdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidlpg102821.doc, replace

csdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidlpg102821.doc, append



*largecylinder

csdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidlarge102821.doc, replace

csdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidlarge102821.doc, append



* small cylinder
csdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidsmall102821.doc, replace

csdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidsmall102821.doc, append







* homedeliver
frame change TreatControl3

csdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(drimp) 

outreg2 using csdidhome102821.doc, replace

csdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) gvar(treat_new) method(reg) 

outreg2 using csdidhome102821.doc, append




***drdid 
*dummykglpg
drdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdiddummykglpg102821.doc, replace

drdid dummykglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdiddummykglpg102821.doc, append 

*dummylargecylinder
drdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdiddummylarge102821.doc, replace

drdid dummylargecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdiddummylarge102821.doc, append 

*dummysmallcylinder
drdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdiddummysmall102821.doc, replace

drdid dummysmallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdiddummysmall102821.doc, append 

*kglpg
drdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidkglpg102821.doc, replace

drdid kglpg treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidkglpg102821.doc, append 

*largecylinder
drdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidlarge102821.doc, replace

drdid largecylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidlarge102821.doc, append 

*smallcylinder
drdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidsmall102821.doc, replace

drdid smallcylinder treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidsmall102821.doc, append 




* home 
drdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) drimp

outreg2 using drdidhome102821.doc, replace

drdid homedeliver treat_new aft interaction_new age totalnumhh dayexpend femalemaker if kglpg>0, ivar(hhidfe) time(aft) treatment(treat_new) reg

outreg2 using drdidhome102821.doc, append



frame change TreatControl3
*** Placebo test with different dependent varriables
** heard about a microwave
xtreg m2_q56_micro_aware treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using placebotest102821.doc, replace
** Number of kids
xtreg m1_q29_no_children treat_new aft interaction_new age totalnumhh dayexpend femalemaker, fe vce(cluster finalhhid)

outreg2 using placebotest102821.doc, append


