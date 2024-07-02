cd "C:\Users\jboussard\OneDrive - International Monetary Fund (PRD)\6. Other\Various\Legislatives"

ssc install missings

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

gen     group = "UG" if inlist(CodNuaCand, "UG","COM","SOC","ECO", "FI","DVG", "RDG")	  
replace group = "OG" if inlist(CodNuaCand, "EXG")	  
replace group = "C"  if inlist(CodNuaCand,  "ENS","DVC", "UDI","HOR", "VEC")	  
replace group = "OC"  if inlist(CodNuaCand, "LR","DVD", "DSV")	  
replace group = "XD" if inlist(CodNuaCand,  "RN","UXD")	  
replace group = "OXD" if inlist(CodNuaCand, "REC", "EXD")
replace group = "O" if inlist(CodNuaCand, "DIV","REG")

rename NbVoix V
gen mV = -V

global desistement "Y" /*"Y" "N"*/

if "$desistement" == "N"{
	gen R = "Passe" if inlist(Elu, "OUI","QUALIF T2")
}
if "$desistement" == "Y"{
	gen R = "Passe" if inlist(Elu, "OUI","QUALIF T2")  
	gen temp = inlist(group, "XD","OXD") & Elu == "QUALIF T2"
	bys CodCirElec (mV): egen hasXD = total(temp)
	bys CodCirElec (mV): replace R = "Desist" if Elu == "QUALIF T2" & inlist(group, "UG", "C") & hasXD & _n >= 3
	drop temp hasXD
}
/**/
bys CodCirElec : egen runoff = total(R == "Passe")
levelsof group,local(glist)
levelsof runoff, local(runoffs)
gen Type = ""
foreach g of local glist {
	gen temp = inlist(group, "`g'") & R=="Passe"
	bys CodCirElec (mV): egen has`g' = total(temp)
	drop temp 
}
foreach runoff of local runoffs {
	replace Type = "`runoff'" if runoff == `runoff'
	local i = 1
	foreach g of loca glist {
		replace Type = Type + "-`g'" if has`g'==1	& runoff == `runoff'
		replace Type = Type + "-`g'-`g'" if has`g'==2 & runoff == `runoff'	
		replace Type = Type + "-`g'-`g'-`g'" if has`g'==3	& runoff == `runoff'
	}
}
preserve 
	keep CodCirElec runoff Type 
	duplicates drop
	tab runoff
	tab Type
restore

gen RR = "Elu" if R == "Passe" & runoff == 1
bys CodCirElec (mV) : gen rank = _n if R == "Passe"

/**/
foreach g in `glist' {
	gen VV_`g' = .
}	
foreach g in `glist' {
	local glist2: list glist - g
	/*Initialise avec report uniforme */
	replace VV_`g' = (1/(runoff+1))*V*has`g' if R != "Passe"
	/*Report 100% si le candidat passe*/
	replace VV_`g' =  V if R == "Passe" & group == "`g'"
	foreach g2 in `glist2' {
		replace VV_`g2' = 0 if R == "Passe" & group == "`g'"
	}
}
/* Cas 2-C-UG */
replace VV_C = 0*V if group == "UG" & Type == "2-C-UG"
replace VV_C = 0.2*V if group == "OG" & Type == "2-C-UG"
replace VV_C = V if group == "C" & Type == "2-C-UG"
replace VV_C = 0.7*V if group == "OC" & Type == "2-C-UG"
replace VV_C = 0.2*V if group == "XD" & Type == "2-C-UG"
replace VV_C = 0.2*V if group == "OXD" & Type == "2-C-UG"

replace VV_UG = V if group == "UG" & Type == "2-C-UG"
replace VV_UG = 0.7*V if group == "OG" & Type == "2-C-UG"
replace VV_UG = 0*V if group == "C" & Type == "2-C-UG"
replace VV_UG = 0*V if group == "OC" & Type == "2-C-UG"
replace VV_UG = 0.2*V if group == "XD" & Type == "2-C-UG"
replace VV_UG = 0.2*V if group == "OXD" & Type == "2-C-UG"

/* Cas 2-C-XD */
replace VV_C = 0.5*V if group == "UG" & Type == "2-C-XD"
replace VV_C = 0.5*V if group == "OG" & Type == "2-C-XD"
replace VV_C = V if group == "C" & Type == "2-C-XD"
replace VV_C = 0.5*V if group == "OC" & Type == "2-C-XD"
replace VV_C = 0*V if group == "XD" & Type == "2-C-XD"
replace VV_C = 0*V if group == "OXD" & Type == "2-C-XD"

replace VV_XD = 0.2*V if group == "UG" & Type == "2-C-XD"
replace VV_XD = 0.2*V if group == "OG" & Type == "2-C-XD"
replace VV_XD = 0*V if group == "C" & Type == "2-C-XD"
replace VV_XD = 0.3*V if group == "OC" & Type == "2-C-XD"
replace VV_XD = V if group == "XD" & Type == "2-C-XD"
replace VV_XD = 0.9*V if group == "OXD" & Type == "2-C-XD"

/* Cas 2-UG-XD */
replace VV_UG = V if group == "UG" & Type == "2-UG-XD"
replace VV_UG = 0.7*V if group == "OG" & Type == "2-UG-XD"
replace VV_UG = 0.5*V if group == "C" & Type == "2-UG-XD"
replace VV_UG = 0.5*V if group == "OC" & Type == "2-UG-XD"
replace VV_UG = 0*V if group == "XD" & Type == "2-UG-XD"
replace VV_UG = 0*V if group == "OXD" & Type == "2-UG-XD"

replace VV_XD = 0*V if group == "UG" & Type == "2-UG-XD"
replace VV_XD = 0.2*V if group == "OG" & Type == "2-UG-XD"
replace VV_XD = 0.2*V if group == "C" & Type == "2-UG-XD"
replace VV_XD = 0.3*V if group == "OC" & Type == "2-UG-XD"
replace VV_XD = V if group == "XD" & Type == "2-UG-XD"
replace VV_XD = V if group == "OXD" & Type == "2-UG-XD"
	
/**/
gen VV = .
foreach g of local glist{
	bys CodCirElec (mV) : egen temp`g' = total(VV_`g')
	replace VV = temp`g' if group == "`g'" & R == "Passe" 
}
gen mVV = -VV
bys CodCirElec (mVV) : egen EE = total(VV)
bys CodCirElec (mVV): egen temp = max(VV) if runoff >= 2
bys CodCirElec mVV (mV) : replace RR = "Elu" if VV == temp & R == "Passe" & _n == 1
drop temp*
disp "Prédiction 2024, desistement = $desistement" 	
tab CodNuaCand if RR == "Elu"


