cd "C:\Users\jboussard\OneDrive - International Monetary Fund (PRD)\6. Other\Various\Legislatives"

ssc install missings
********************************************************************************
***                     Import Data                                          ***
********************************************************************************
quietly{
import excel using "resultats-par-niveau-cirlg-t1-france-entiere-legis2022", firstrow clear
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
replace Codedudépartement = "971" if Codedudépartement == "ZA"
replace Codedudépartement = "972" if Codedudépartement == "ZB"
replace Codedudépartement = "973" if Codedudépartement == "ZC"
replace Codedudépartement = "974" if Codedudépartement == "ZD"
replace Codedudépartement = "976" if Codedudépartement == "ZM"
replace Codedudépartement = "988" if Codedudépartement == "ZN"
replace Codedudépartement = "987" if Codedudépartement == "ZP"
replace Codedudépartement = "975" if Codedudépartement == "ZS"
replace Codedudépartement = "986" if Codedudépartement == "ZW"
gen Codecirconscriptionlégislative = Codedudépartement + Codedelacirconscription
keep Codecirconscriptionlégislative Inscrits Exprimés Nom* Prénom* Nuance* Voix* Sièges*
drop VoixIns VoixExp
reshape long Nom Prénom Nuance Voix Sièges, i(Codecirconscriptionlégislative Inscrits Exprimés) j(candidat_id)
drop if mi(Nom)
save data2022_T1.dta,replace
********************************************************************************
import excel using "resultats-par-niveau-cirlg-t2-france-entiere-legis2022", firstrow clear
destring Inscrits, replace force
rename (Nom Prénom Nuance Voix Sièges) (Nom0 Prénom0 Nuance0 Voix0 Sièges0) 
rename 	 (AE AF AG AH AK) (Nom1 Prénom1 Nuance1 Voix1 Sièges1)
rename 	 (AN AO AP AQ AT) (Nom2 Prénom2 Nuance2 Voix2 Sièges2)
replace Codedudépartement = "971" if Codedudépartement == "ZA"
replace Codedudépartement = "972" if Codedudépartement == "ZB"
replace Codedudépartement = "973" if Codedudépartement == "ZC"
replace Codedudépartement = "974" if Codedudépartement == "ZD"
replace Codedudépartement = "976" if Codedudépartement == "ZM"
replace Codedudépartement = "988" if Codedudépartement == "ZN"
replace Codedudépartement = "987" if Codedudépartement == "ZP"
replace Codedudépartement = "975" if Codedudépartement == "ZS"
replace Codedudépartement = "986" if Codedudépartement == "ZW"
gen Codecirconscriptionlégislative = Codedudépartement + Codedelacirconscription
keep Codecirconscriptionlégislative Inscrits Exprimés Nom* Prénom* Nuance* Voix* Sièges*
drop VoixIns VoixExp
reshape long Nom Prénom Nuance Voix Sièges, i(Codecirconscriptionlégislative Inscrits Exprimés) j(j)
drop j
drop if mi(Nom)
save data2022_T2.dta,replace
********************************************************************************
import excel using "resultats-definitifs-par-circonscription-europ2019", firstrow clear
rename (NomTêtedeListe Voix) (NomTêtedeListe0 Voix0)
rename (AC AD) (NomTêtedeListe1 Voix1)
rename (AJ AK) (NomTêtedeListe2 Voix2)
rename (AQ AR) (NomTêtedeListe3 Voix3)
rename (AX AY) (NomTêtedeListe4 Voix4)
rename (BE BF) (NomTêtedeListe5 Voix5)
rename (BL BM) (NomTêtedeListe6 Voix6)
rename (BS BT) (NomTêtedeListe7 Voix7)
rename (BZ CA) (NomTêtedeListe8 Voix8)
rename (CG CH) (NomTêtedeListe9 Voix9)
rename (CN CO) (NomTêtedeListe10 Voix10)
rename (CU CV) (NomTêtedeListe11 Voix11)
rename (DB DC) (NomTêtedeListe12 Voix12)
rename (DI DK) (NomTêtedeListe13 Voix13)
rename (DP DQ) (NomTêtedeListe14 Voix14)
rename (DW DX) (NomTêtedeListe15 Voix15)
rename (ED EF) (NomTêtedeListe16 Voix16)
rename (EK EL) (NomTêtedeListe17 Voix17)
rename (ER ES) (NomTêtedeListe18 Voix18)
rename (EY EZ) (NomTêtedeListe19 Voix19)
rename (FF FG) (NomTêtedeListe20 Voix20)
rename (FM FN) (NomTêtedeListe21 Voix21)
rename (FT FU) (NomTêtedeListe22 Voix22)
rename (GA GB) (NomTêtedeListe23 Voix23)
rename (GH GI) (NomTêtedeListe24 Voix24)
rename (GO GP) (NomTêtedeListe25 Voix25)
rename (GV GW) (NomTêtedeListe26 Voix26)
rename (HC HD) (NomTêtedeListe27 Voix27)
rename (HJ HK) (NomTêtedeListe28 Voix28)
rename (HQ HR) (NomTêtedeListe29 Voix29)
rename (HX HY) (NomTêtedeListe30 Voix30)
rename (IE IF) (NomTêtedeListe31 Voix31)
rename (IL IM) (NomTêtedeListe32 Voix32)
rename (IS IT) (NomTêtedeListe33 Voix33)
replace Codedudépartement = "971" if Codedudépartement == "ZA"
replace Codedudépartement = "972" if Codedudépartement == "ZB"
replace Codedudépartement = "973" if Codedudépartement == "ZC"
replace Codedudépartement = "974" if Codedudépartement == "ZD"
replace Codedudépartement = "976" if Codedudépartement == "ZM"
replace Codedudépartement = "988" if Codedudépartement == "ZN"
replace Codedudépartement = "987" if Codedudépartement == "ZP"
replace Codedudépartement = "975" if Codedudépartement == "ZS"
replace Codedudépartement = "986" if Codedudépartement == "ZW"
gen Codecirconscriptionlégislative = Codedudépartement + Codedelacirconscription
keep Codecirconscriptionlégislative Inscrits Exprimés NomTêtedeListe* Voix* 
drop VoixIns VoixExp
reshape long NomTêtedeListe Voix , i(Codecirconscriptionlégislative Inscrits Exprimés) j(liste_id)
drop if mi(NomTêtedeListe)
gen     group = "XG" if inlist(NomTêtedeListe,"TRAORÉ Hamada","ARTHAUD Nathalie","SANCHEZ Antonio")	  
replace group = "G"  if inlist(NomTêtedeListe,"AUBRY Manon","ALEXANDRE Audric","BOURG Dominique","GLUCKSMANN Raphaël","DELFEL Thérèse","ARTHAUD Nathalie")
replace group = "G"  if inlist(NomTêtedeListe,"BROSSAT Ian","HAMON Benoît","SANCHEZ Antonio","JADOT Yannick","THOUY Hélène","AZERGUI Nagib")
replace group = "C"  if inlist(NomTêtedeListe,"MARIE Florie","LOISEAU Nathalie","LAGARDE Jean-Christophe","CAILLAUD Sophie","TOMASINI Nathalie","CORBET Cathy Denise Ginette")
replace group = "C"  if inlist(NomTêtedeListe,"DIEUMEGARD Pierre","CHALENÇON Christophe","LALANNE Francis","BIDOU Olivier")	  
replace group = "D"  if inlist(NomTêtedeListe,"BELLAMY François-Xavier")	  
replace group = "ED" if inlist(NomTêtedeListe,"DE PREVOISIN Robert","CAMUS Renaud","PHILIPPOT Florian","VAUCLIN Vincent","GERNIGON Yves","HELGEN Gilles")
replace group = "ED" if inlist(NomTêtedeListe,"DUPONT-AIGNAN Nicolas","ASSELINEAU François","BARDELLA Jordan","PERSON Christian Luc")	  
save data2019.dta,replace
********************************************************************************
import excel using "resultats-definitifs-par-circonscription-europ2024", firstrow clear
keep Codecirconscriptionlégislative Inscrits Exprimés Libellédeliste* Nuanceliste* Voix* 
drop Voixins* Voixexp*
reshape long Libellédeliste Nuanceliste Voix , i(Codecirconscriptionlégislative Inscrits Exprimés) j(liste_id)
drop if mi(Libellédeliste)
gen     group = "XG" if inlist(Nuance, "LEXG")	  
replace group = "G"  if inlist(Nuance, "LCOM", "LUG", "LDVG", "LECO", "LFI", "LVEC")	  
replace group = "C"  if inlist(Nuance, "LDIV", "LENS")	  
replace group = "D"  if inlist(Nuance, "LLR")	  
replace group = "ED" if inlist(Nuance, "LDVD", "LREC", "LRN", "LEXD")	  
save data2024.dta,replace
********************************************************************************
import excel using "lg2024-resultats-circonscriptions-une-ligne-par-candidat2", firstrow clear
keep CodCirElec Inscrits Exprimes NomPsn PrenomPsn CodNuaCand NbVoix Elu
save data2024_T1.dta,replace
********************************************************************************
use data2024_T1, clear

/*CodNuaCand	LibNuaCand
EXG	Extrême gauche
RN	Rassemblement National
LR	Les Républicains
UG	Union de la gauche
DSV	Droite souverainiste
ENS	Ensemble ! (Majorité présidentielle)
EXD	Extrême droite
DIV	Divers
ECO	Ecologistes
DVD	Divers droite
REC	Reconquête !
UXD	Union de l'extrême droite
DVG	Divers gauche
UDI	Union des Démocrates et Indépendants
REG	Régionaliste
DVC	Divers centre
HOR	Horizons
COM	Parti communiste français
SOC	Parti socialiste
FI	La France insoumise
VEC	Les Ecologistes
RDG	Parti radical de gauche*/

gen     group = "XG" if inlist(CodNuaCand, "EXG")	  
replace group = "G"  if inlist(CodNuaCand, "COM","SOC", "UG", "DVG", "ECO", "FI", "RDG")	  
replace group = "C"  if inlist(CodNuaCand,  "ENS", "DVC", "UDI","HOR", "VEC")	  
replace group = "D"  if inlist(CodNuaCand, "LR","DVD")	  
replace group = "ED" if inlist(CodNuaCand,  "REC", "RN", "EXD", "DSV", "UXD")	  
replace group = "DIV" if inlist(CodNuaCand, "DIV","REG")

gen X = .
replace X = 0    if group == "XG" 
replace X = 0.25 if group == "G"
replace X = 0.5  if group == "C" | group == "DIV"
replace X = 0.9 if group == "D"
replace X = 1    if group == "ED"
gen Xmin = -0.25 /* abstention de gauche */
gen Xmax = 1.25  /* abstention de droite */

rename NbVoix V


/* Sans desistement*/
gen R = "Passe" if inlist(Elu, "OUI","QUALIF T2")
bys CodCirElec (X): egen runoff = total(R == "Passe")
gen sortvar = X if R == "Passe"
sort CodCirElec sortvar
gen VV = 0
gen RR = "Elu" if R == "Passe" & runoff == 1
levelsof runoff if runoff>=2, local(runoffs)
foreach r of local runoffs{
	local rp = `r'+1
	local rm = `r'-1
	gen X0_`r'  = Xmin
	forvalues c=1/`r'{
		local cc = `c'+1
		bys CodCirElec (sortvar): gen X`c'_`r' = X[`c'] if runoff==`r'
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
		bys CodCirElec (sortvar): egen temp`c' = total(VV`c'_`r') if runoff==`r'
		bys CodCirElec (sortvar): replace VV = temp`c' if _n == `c' & runoff==`r'
	}
	drop temp*
	drop X*_`r'
	drop VV*_`r'
}	
bys CodCirElec (VV) : egen EE = total(VV)

bys CodCirElec (sortvar): egen temp = max(VV) if runoff >= 2
replace RR = "Elu" if VV == temp & R == "Passe"
drop temp
disp "Prédiction 2024 Sans desistement" 	
tab CodNuaCand if RR == "Elu"

/* Avec 100% desistement*/
drop R runoff sortvar VV RR EE
gen mV = -V
gen R = "Passe" if inlist(Elu, "OUI","QUALIF T2")  
gen temp = inlist(group, "ED") & Elu == "QUALIF T2"
bys CodCirElec (mV): egen hasED = total(temp)
drop temp 
bys CodCirElec (mV): replace R = "Desist" if Elu == "QUALIF T2" & inlist(group, "G", "C") & hasED & _n >= 3

bys CodCirElec (X): egen runoff = total(R == "Passe")
gen sortvar = X if R == "Passe"
sort CodCirElec sortvar
gen VV = 0
gen RR = "Elu" if R == "Passe" & runoff == 1
levelsof runoff if runoff>=2, local(runoffs)
foreach r of local runoffs{
	local rp = `r'+1
	local rm = `r'-1
	gen X0_`r'  = Xmin
	forvalues c=1/`r'{
		local cc = `c'+1
		bys CodCirElec (sortvar): gen X`c'_`r' = X[`c'] if runoff==`r'
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
		bys CodCirElec (sortvar): egen temp`c' = total(VV`c'_`r') if runoff==`r'
		bys CodCirElec (sortvar): replace VV = temp`c' if _n == `c' & runoff==`r'
	}
	drop temp*
	drop X*_`r'
	drop VV*_`r'
}	
bys CodCirElec (VV) : egen EE = total(VV)

bys CodCirElec (sortvar): egen temp = max(VV) if runoff >= 2
replace RR = "Elu" if VV == temp & R == "Passe"
drop temp
disp "Prédiction 2024 Avec 227 desistements" 	
tab CodNuaCand if RR == "Elu"

































/*

use data2022_T1, clear
rename (Inscrits Exprimés Voix Sièges) (I2022T1 E2022T1 V2022T1 R2022T1)
merge m:1 Codecirconscriptionlégislative Nom Prénom Nuance using data2022_T2, keepusing(Inscrits Exprimés Voix Sièges) nogen
rename (Inscrits Exprimés Voix Sièges)  (I2022T2 E2022T2 V2022T2 R2022T2)
egen circo_id = group(Codecirconscriptionlégislative)
fillin circo_id Nuance
drop _fillin
bys circo_id (candidat_id) : replace candidat_id = candidat_id[_n-1] + 1 if mi(candidat_id)
bys circo_id (candidat_id) : replace Codecirconscriptionlégislative = Codecirconscriptionlégislative[_n-1] if mi(Codecirconscriptionlégislative)
bys circo_id (I2022T1) : replace I2022T1 = I2022T1[_n-1] if mi(I2022T1)
bys circo_id (I2022T2) : replace I2022T2 = I2022T2[_n-1] if mi(I2022T2)
bys circo_id (E2022T1) : replace E2022T1 = E2022T1[_n-1] if mi(E2022T1)
bys circo_id (E2022T2) : replace E2022T2 = E2022T2[_n-1] if mi(E2022T2)
replace V2022T1 = 0 if mi(V2022T1)
replace V2022T2 = 0 if mi(V2022T2)
replace R2022T1 = "" if R2022T1 != "Elu"
replace R2022T1 = "Passe" if mi(R2022T1) & V2022T2>0
gen R2022 = "Elu" if R2022T1 == "Elu" | R2022T2 == "Elu"
sort circo_id candidat_id

gen     group = "XG" if inlist(Nuance, "DXG")	  
replace group = "G" if inlist(Nuance, "NUP", "RDG", "DVG", "ECO")	  
replace group = "C" if inlist(Nuance, "DIV", "REG", "ENS", "DVC", "UDI")	  
replace group = "D" if inlist(Nuance, "LR")	  
replace group = "ED" if inlist(Nuance, "DVD", "DSV", "REC", "RN", "DXD")	  

preserve 
	use data2019, clear
	collapse (mean) Inscrits Exprimés (sum) Voix, by(Codecirconscriptionlégislative group)
	rename (Inscrits Exprimés Voix )  (I2019 E2019 V2019)
	tempfile temp
	save `temp'
restore
merge m:1 Codecirconscriptionlégislative group using `temp', nogen

preserve 
	use data2024, clear
	collapse (mean) Inscrits Exprimés (sum) Voix, by(Codecirconscriptionlégislative group)
	rename (Inscrits Exprimés Voix )  (I2024 E2024 V2024)
	tempfile temp
	save `temp'
restore
merge m:1 Codecirconscriptionlégislative group using `temp', nogen

order circo_id Codecirconscriptionlégislative Nom Prénom Nuance candidat_id group ///
	  I2022T1 E2022T1 V2022T1 R2022T1 ///
	  I2022T2 E2022T2 V2022T2 R2022T2 ///
	  R2022 ///
	  I2019 E2019 V2019 I2024 E2024 V2024

save fulldata,replace
}
********************************************************************************
***                     Calibration                                          ***
********************************************************************************
quietly{
use fulldata, clear
gen pass = R2022T1 == "Passe"
bys circo_id: egen runoff = total(pass)
drop if runoff < 2
egen g = group(group)

rename V2022T1 V
rename V2022T2 VV
gen A = I2022T1 - E2022T1
gen AA = I2022T1 - E2022T2
collapse (sum) V VV pass, by(circo_id g A AA)
preserve 
	keep circo_id A AA
	rename (A AA) (V VV)
	duplicates drop
	gen g = 0
	gen pass = 1
	tempfile abstention
	save `abstention'
restore
drop A AA
append using `abstention'
sort circo_id g 
drop if pass > 1
tostring g, gen(gpass) force
replace gpass = "" if !pass
gen temp = ""
bys circo_id (g): replace temp = gpass if _n == 1
bys circo_id (g): replace temp = temp[_n-1] + gpass if _n > 1
bys circo_id (g): gen duel = temp[_N]
drop gpass pass temp
levelsof duel, local(duels)
levelsof g, local(gs)
foreach duel of local duels{
	foreach g of local gs{
		disp "`duel' `g'"
		quiet gen VV`duel'_`g' =  
	}
}




reshape wide V VV, i(circo_id A AA ) j(g)









gen V6 = A
gen VV6 = AA 
drop A AA
order circo_id V? VV?




mata
	void myeval(todo, x, y, g, H)
	{
	* g = A = 0 / C=1 / D=2 / ED=3 / G=4 / XG=5 	
	
	
	
	V = st_data(., "V")		
	VV = st_data(., "V")		
	g = st_data(., "g")
	c = st_data(., "circo_id")	
		
	y = exp(-x^2 + x - 3)
	}
	S = optimize_init()

	optimize_init_evaluator(S, &myeval())
	optimize_init_params(S, 0)
	x = optimize(S)
	x
end

rename (*2022T1) (*)
keep circo_id candidat_id I E V R Nuance group R2022
/*Baseline = 2022 */
gen X = .
replace X = 0    if group == "XG"
replace X = 0.25 if group == "G"
replace X = 0.5  if group == "C"
replace X = 0.9  if group == "D"
replace X = 1    if group == "ED"
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
tab actual predict
/*

           |        predict
    actual |         0          1 |     Total
-----------+----------------------+----------
         0 |     9,468         98 |     9,566 
         1 |        98        479 |       577 
-----------+----------------------+----------
     Total |     9,566        577 |    10,143 

*/

}
}


********************************************************************************
***                     Simulation 2024                                      ***
********************************************************************************
use fulldata,clear
keep circo_id Codecirconscriptionlégislative candidat_id I* E* V* R* group Nuance
/* PARAMETRES */ /*<------------------------------------------------------------------------------------------------------------------------------ PARAMETRES ICI*/
* distance :
* si X1 < x < X2
* report de x vers Xi = 1-abs(x-Xi)/(X2-X1)
gen X = .
replace X = 0    if group == "XG" 
replace X = 0.25 if group == "G"
replace X = 0.5 /*0.5*/  if group == "C"
replace X = 0.9 /*0.9*/ if group == "D"
replace X = 1    if group == "ED"
gen Xmin = -0.25 /* abstention de gauche */
gen Xmax = 1.25  /* abstention de droite */
/* PARAMETRES */ /*<-------------------------------------------------------------------------------------------------------------------------------------------------------*/

/* RUN SIMUL */
quietly{
gen I = I2024

/*Tendance Europeennes*/
gen trend2224 = (V2024/E2024 - V2019/E2019) * 2/5
gen V = min(max((V2022T1+trend2224*E2022T1)*I/I2022T1,0),I)
bys circo_id (V) : egen E = total(V)
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
bys circo_id (VV) : egen EE = total(VV)

bys circo_id (sortvar): egen temp = max(VV) if runoff >= 2
replace RR = "Elu" if VV == temp & R == "Passe"
drop temp
noisily{
disp "Prédiction 2024" 	
tab Nuance if RR == "Elu"
}
}
/**/
preserve 
collapse (sum) V2019 E2019 V2024 E2024 V2022T1 V2022T2 E2022T1 E2022T2 V E VV EE , by(Nuance)
gen VE2019 = V2019/E2019
gen VE2024 = V2024/E2024
gen VE2022T1 = V2022T1/E2022T1
gen VE2022T2 = V2022T2/E2022T2
restore



use data2019, clear
collapse (mean) Inscrits Exprimés (sum) Voix, by(Codecirconscriptionlégislative group)
rename (Inscrits Exprimés Voix )  (I2019 E2019 V2019)
preserve 
	use data2024, clear
	collapse (mean) Inscrits Exprimés (sum) Voix, by(Codecirconscriptionlégislative group)
	rename (Inscrits Exprimés Voix )  (I2024 E2024 V2024)
	tempfile temp
	save `temp'
restore
merge m:1 Codecirconscriptionlégislative group using `temp', nogen



gen VE2019 = V2019/E2019
gen VE2024 = V2024/E2024
gen DVE = VE2024 - VE2019
replace group = "_" + group

drop I2019 E2019 V2019 I2024 E2024 V2024
reshape wide VE2019 VE2024 DVE,i(Codecirconscriptionlégislative) j(group) string

tw (scatter DVE_ED VE2019_ED) (qfit DVE_ED VE2019_ED ), xtitle("Vote Extreme-Droite, EU2019") ytitle("Variation Vote Extreme-Droite, EU2024-2019") legend(off) 
graph export voteED.png, replace

tw (scatter DVE_C VE2019_C) (qfit DVE_C VE2019_C ), xtitle("Vote Centre, EU2019") ytitle("Variation Vote Centre, EU2024-2019") legend(off) 
graph export voteC.png, replace

tw (scatter DVE_D VE2019_D) (qfit DVE_D VE2019_D ), xtitle("Vote Droite, EU2019") ytitle("Variation Vote Droite, EU2024-2019") legend(off)
graph export voteD.png, replace

tw (scatter DVE_G VE2019_G) (qfit DVE_G VE2019_G ), xtitle("Vote Gauche, EU2019") ytitle("Variation Vote Gauche, EU2024-2019") legend(off)
graph export voteG.png, replace



tw (scatter DVE_C VE2019_ED) (qfit DVE_C VE2019_ED ), xtitle("Vote Extreme-Droite, EU2019") ytitle("Variation Vote Centre, EU2024-2019") legend(off)

tw (scatter DVE_D VE2019_ED) (qfit DVE_D VE2019_ED ), xtitle("Vote Extreme-Droite, EU2019") ytitle("Variation Vote Droite, EU2024-2019") legend(off)

tw (scatter DVE_G VE2019_ED) (qfit DVE_G VE2019_ED ), xtitle("Vote Extreme-Droite, EU2019") ytitle("Variation Vote Gauche, EU2024-2019") legend(off)

