cd "C:\Users\jboussard\OneDrive - International Monetary Fund (PRD)\6. Other\Various\Legislatives"

ssc install missings
********************************************************************************
***                     Import Data                                          ***
********************************************************************************
quietly{
import excel using data2022.xlsx, sheet("T1") firstrow clear
rename (Nom Prénom Nuance Voix Sièges) (Nom0 Prénom0 Nuance0 Voix0 Sièges0) 
rename 	 (AE AF AG AH AK) (Nom1 Prénom1 Nuance1 Voix1 Sièges1)
rename 	 (AN AO AP AQ AT) (Nom2 Prénom2 Nuance2 Voix2 Sièges2)
rename 	 (AW AX AY AZ BC) (Nom3 Prénom3 Nuance3 Voix3 Sièges3)
rename 	 (BF BG BH BI BL) (Nom4 Prénom4 Nuance4 Voix4 Sièges4)
rename 	 (BO BP BQ BR BU) (Nom5 Prénom5 Nuance5 Voix5 Sièges5)
rename 	 (BX BY BZ CA CD) (Nom6 Prénom6 Nuance6 Voix6 Sièges6)
rename 	 (CG CH CI CJ CM) (Nom7 Prénom7 Nuance7 Voix7 Sièges7)
rename 	 (CP CQ CR CS CV) (Nom8 Prénom8 Nuance8 Voix8 Sièges8)
rename 	 (CY CZ DA DB DE) (Nom9 Prénom9 Nuance9 Voix9 Sièges9)
rename 	 (DH DI DJ DK DN) (Nom10 Prénom10 Nuance10 Voix10 Sièges10)
rename 	 (DQ DR DS DT DW) (Nom11 Prénom11 Nuance11 Voix11 Sièges11)
rename 	 (DZ EA EB EC EF) (Nom12 Prénom12 Nuance12 Voix12 Sièges12)
rename 	 (EI EJ EK EL EO) (Nom13 Prénom13 Nuance13 Voix13 Sièges13)
rename 	 (ER ES ET EU EX) (Nom14 Prénom14 Nuance14 Voix14 Sièges14)
rename 	 (FA FB FC FD FG) (Nom15 Prénom15 Nuance15 Voix15 Sièges15)
rename 	 (FJ FK FL FM FP) (Nom16 Prénom16 Nuance16 Voix16 Sièges16)
rename 	 (FS FT FU FV FY) (Nom17 Prénom17 Nuance17 Voix17 Sièges17)
rename 	 (GB GC GD GE GH) (Nom18 Prénom18 Nuance18 Voix18 Sièges18)
rename 	 (GK GL GM GN GQ) (Nom19 Prénom19 Nuance19 Voix19 Sièges19)
rename 	 (GT GU GV GW GZ) (Nom20 Prénom20 Nuance20 Voix20 Sièges20)
rename 	 (HC HD HE HF)    (Nom21 Prénom21 Nuance21 Voix21)
tostring Sièges*, replace force
keep Codedudépartement Codedelacirconscription Inscrits Exprimés ///
	 Nom* Prénom* Nuance* Voix* Sièges*
drop VoixIns VoixExp
reshape long Nom Prénom Nuance Voix Sièges, i(Codedudépartement Codedelacirconscription Inscrits Exprimés) j(candidat_id)
drop if mi(Nom)
save data2022_T1.dta,replace
********************************************************************************
import excel using data2022.xlsx, sheet("T2") firstrow clear
destring Inscrits, replace force
rename (Nom Prénom Nuance Voix Sièges) (Nom0 Prénom0 Nuance0 Voix0 Sièges0) 
rename 	 (AE AF AG AH AK) (Nom1 Prénom1 Nuance1 Voix1 Sièges1)
rename 	 (AN AO AP AQ AT) (Nom2 Prénom2 Nuance2 Voix2 Sièges2)
keep Codedudépartement Codedelacirconscription Inscrits Exprimés ///
	 Nom* Prénom* Nuance* Voix* Sièges*
drop VoixIns VoixExp
reshape long Nom Prénom Nuance Voix Sièges, i(Codedudépartement Codedelacirconscription Inscrits Exprimés) j(j)
drop j
drop if mi(Nom)
save data2022_T2.dta,replace
********************************************************************************
use data2022_T1, clear
rename (Inscrits Exprimés Voix Sièges) (I2022T1 E2022T1 V2022T1 R2022T1)
merge m:1 Codedudépartement Codedelacirconscription Nom Prénom Nuance using data2022_T2, keepusing(Inscrits Exprimés Voix Sièges) nogen
rename (Inscrits Exprimés Voix Sièges)  (I2022T2 E2022T2 V2022T2 R2022T2)
egen circo_id = group(Codedudépartement Codedelacirconscription)
fillin circo_id Nuance
drop _fillin
bys circo_id (candidat_id) : replace candidat_id = candidat_id[_n-1] + 1 if mi(candidat_id)
bys circo_id (candidat_id) : replace Codedudépartement = Codedudépartement[_n-1] if mi(Codedudépartement)
bys circo_id (candidat_id) : replace Codedelacirconscription = Codedelacirconscription[_n-1] if mi(Codedelacirconscription)
bys circo_id (I2022T1) : replace I2022T1 = I2022T1[_n-1] if mi(I2022T1)
bys circo_id (I2022T2) : replace I2022T2 = I2022T2[_n-1] if mi(I2022T2)
bys circo_id (E2022T1) : replace E2022T1 = E2022T1[_n-1] if mi(E2022T1)
bys circo_id (E2022T2) : replace E2022T2 = E2022T2[_n-1] if mi(E2022T2)
replace V2022T1 = 0 if mi(V2022T1)
replace V2022T2 = 0 if mi(V2022T2)
gen S2022T1 = V2022T1 / E2022T1
gen S2022T2 = V2022T2 / E2022T2
replace R2022T1 = "" if R2022T1 != "Elu"
replace R2022T1 = "Passe" if mi(R2022T1) & V2022T2>0
gen R2022 = "Elu" if R2022T1 == "Elu" | R2022T2 == "Elu"
sort circo_id candidat_id
order circo_id Codedudépartement Codedelacirconscription Nom Prénom Nuance candidat_id ///
	  I2022T1 E2022T1 V2022T1 S2022T1 R2022T1 ///
	  I2022T2 E2022T2 V2022T2 S2022T2 R2022T2 ///
	  R2022
save fulldata2022,replace
}
********************************************************************************
***                     Calibration                                          ***
********************************************************************************
quietly{
use fulldata2022, clear
rename (*2022T1) (*)
keep circo_id candidat_id I E V S R Nuance R2022
/*Baseline = 2022 */
gen X = .
replace X = 0     if Nuance == "DXG"
replace X = 0.25  if Nuance == "NUP"
replace X = 0.25 if Nuance == "RDG"
replace X = 0.25 if Nuance == "DVG"
replace X = 0.25 if Nuance == "ECO"
replace X = 0.5  if Nuance == "DIV"
replace X = 0.5  if Nuance == "REG"
replace X = 0.5  if Nuance == "ENS"
replace X = 0.5  if Nuance == "DVC"
replace X = 0.5  if Nuance == "UDI"
replace X = 0.9 if Nuance == "LR"
replace X = 1 if Nuance == "DVD"
replace X = 1 if Nuance == "DSV"
replace X = 1 if Nuance == "REC"
replace X = 1 if Nuance == "RN"
replace X = 1 if Nuance == "DXD"
gen Xmin = -0.25
gen Xmax = 1.25
bys circo_id (X): egen runoff = total(R == "Passe")
levelsof runoff if runoff>=2, local(runoffs)
gen sortvar = X if R == "Passe"
sort circo_id sortvar
gen VV = 0
gen RR = "Elu" if R == "Elu" & runoff == 0
replace RR = "Elu" if R == "Passe" & runoff == 1
foreach r of local runoffs{
	local rp = `r'+1
	local rm = `r'-1
	gen X0_`r'  = Xmin
	forvalues c=1/`r'{
		local cc = `c'+1
		bys circo_id (sortvar): gen X`c'_`r' = X[`c'] if runoff==`r'
	}
	gen X`rp'_`r' = Xmax

	forvalues c=1/`r'{
		local cm = `c' - 1
		local cp = `c' + 1
		gen VV`c'_`r' = .
		replace VV`c'_`r' = (1-(X`c'_`r'-X)/(X`c'_`r'-X`cm'_`r')) * V if inrange(X,X`cm'_`r',X`c'_`r') & runoff==`r'
		replace VV`c'_`r' = (1-(X-X`c'_`r')/(X`cp'_`r'-X`c'_`r')) * V if inrange(X,X`c'_`r',X`cp'_`r') & runoff==`r'
	}	
	
	forvalues c=1/`r'{
		bys circo_id (sortvar): egen temp`c' = total(VV`c'_`r') if runoff==`r'
		bys circo_id (sortvar): replace VV = temp`c' if _n == `c' & runoff==`r'
	}
	drop temp*
	drop X*_`r'
	drop VV*_`r'
}	
bys circo_id (sortvar): egen temp = max(VV) if runoff >= 2
replace RR = "Elu" if VV == temp & R == "Passe"
drop temp
gen actual = (R2022 == "Elu")
gen predict = (RR == "Elu")
noisily{
disp "Résultat 2022" 	
tab Nuance if R2022 == "Elu"
disp "Prédiction 2022" 	
tab Nuance if RR == "Elu"
tw (scatter actual predict) (line actual predict)
tab actual predict
/*
           |        predict
    actual |         0          1 |     Total
-----------+----------------------+----------
         0 |     9,471         95 |     9,566 
         1 |        95        482 |       577 
-----------+----------------------+----------
     Total |     9,566        577 |    10,143 
*/

}
}


********************************************************************************
***                     Simulation 2024                                      ***
********************************************************************************
use fulldata2022,clear
rename (*2022T1) (*)
keep circo_id candidat_id I E V S R Nuance 

/* PARAMETRES */ /*<------------------------------------------------------------------------------------------------------------------------------ PARAMETRES ICI*/

* distance :
* si X1 < x < X2
* report de x vers Xi = 1-abs(x-Xi)/(X2-X1)
gen X = .
replace X = 0     if Nuance == "DXG"
replace X = 0.25  if Nuance == "NUP"
replace X = 0.25 if Nuance == "RDG"
replace X = 0.25 if Nuance == "DVG"
replace X = 0.25 if Nuance == "ECO"
replace X = 0.5  if Nuance == "DIV"
replace X = 0.5  if Nuance == "REG"
replace X = 0.5  if Nuance == "ENS"
replace X = 0.5  if Nuance == "DVC"
replace X = 0.5  if Nuance == "UDI"
replace X = 0.9 if Nuance == "LR"
replace X = 1 if Nuance == "DVD"
replace X = 1 if Nuance == "DSV"
replace X = 1 if Nuance == "REC"
replace X = 1 if Nuance == "RN"
replace X = 1 if Nuance == "DXD"
gen Xmin = -0.25 /* abstention de gauche */
gen Xmax = 1.25  /* abstention de droite */

/*Tendance Europeennes*/
replace V = min(max(0,V - 0.03435 * E),I) if X == 0
replace V = min(max(0,V - 0.05178 * E),I) if X == 0.5
replace V = min(max(0,V - 0.01215 * E),I) if X == 0.8
replace V = min(max(0,V + 0.09818 * E),I) if X == 1
drop E
bys circo_id (V) : egen E = total(V)

/* PARAMETRES */ /*<-------------------------------------------------------------------------------------------------------------------------------------------------------*/

/* RUN SIMUL */
quietly{
drop R
gen V_I = V/I
gen V_E = V/E
bys circo_id (V) : gen R = "Elu" if _n ==  _N &  V_E > 0.5 &  V_I > 0.25
bys circo_id (V) : replace R = "Passe" if _n > _N - 2 | V_I > 0.125

bys circo_id (X): egen runoff = total(R == "Passe")
levelsof runoff if runoff>=2, local(runoffs)
gen sortvar = X if R == "Passe"
sort circo_id sortvar
gen VV = 0
gen RR = "Elu" if R == "Elu" & runoff == 0
replace RR = "Elu" if R == "Passe" & runoff == 1
foreach r of local runoffs{
	local rp = `r'+1
	local rm = `r'-1
	gen X0_`r'  = Xmin
	forvalues c=1/`r'{
		local cc = `c'+1
		bys circo_id (sortvar): gen X`c'_`r' = X[`c'] if runoff==`r'
	}
	gen X`rp'_`r' = Xmax

	forvalues c=1/`r'{
		local cm = `c' - 1
		local cp = `c' + 1
		gen VV`c'_`r' = .
		replace VV`c'_`r' = (1-(X`c'_`r'-X)/(X`c'_`r'-X`cm'_`r')) * V if inrange(X,X`cm'_`r',X`c'_`r') & runoff==`r'
		replace VV`c'_`r' = (1-(X-X`c'_`r')/(X`cp'_`r'-X`c'_`r')) * V if inrange(X,X`c'_`r',X`cp'_`r') & runoff==`r'
	}	
	
	forvalues c=1/`r'{
		bys circo_id (sortvar): egen temp`c' = total(VV`c'_`r') if runoff==`r'
		bys circo_id (sortvar): replace VV = temp`c' if _n == `c' & runoff==`r'
	}
	drop temp*
	drop X*_`r'
	drop VV*_`r'
}	
bys circo_id (sortvar): egen temp = max(VV) if runoff >= 2
replace RR = "Elu" if VV == temp & R == "Passe"
drop temp
noisily{
disp "Prédiction 2024" 	
tab Nuance if RR == "Elu"
}
}
/**/