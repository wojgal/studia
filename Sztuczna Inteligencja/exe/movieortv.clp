;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))



;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

=>

(assert (UI-state (display WelcomeMessage)
				(relation-asserted start)
				(state initial)
				(valid-answers))))


;;;***************
;;;* QUERY RULES *
;;;***************

;;;*** 1st Question ***
(defrule choose-movieortv ""
	(logical (start))

	=>

	(assert (UI-state (display StartQuestion)
				(relation-asserted movieortv)
				(valid-answers Movie Television))))

;;;*** 2nd Question ***
(defrule choose-M-category ""
	(logical (movieortv Movie))
	
	=>
	
	(assert (UI-state (display dis-M)
				(relation-asserted cat-M)
				(valid-answers M-TiCl M-Ac M-Co M-Dr M-Ho M-Cr M-Do))))

(defrule choose-T-category ""
	(logical (movieortv Television))
	
	=>
	
	(assert (UI-state (display dis-T)
				(relation-asserted cat-T)
				(valid-answers T-Co T-Ac T-Dr))))

;;;*** 3rd Question Movie***
(defrule choose-M-TiCl-category ""
	(logical (cat-M M-TiCl))

	=>

	(assert (UI-state (display dis-M-TiCl)
				(relation-asserted cat-M-TiCl)
				(valid-answers M-TiCl-Sc M-TiCl-La M-TiCl-Ge))))

(defrule choose-M-Ac-category ""
	(logical (cat-M M-Ac))

	=>

	(assert (UI-state (display dis-M-Ac)
				(relation-asserted cat-M-Ac)
				(valid-answers M-Ac-MaAr M-Ac-Se M-Ac-Go))))

(defrule choose-M-Co-category ""
	(logical (cat-M M-Co))

	=>

	(assert (UI-state (display dis-M-Co)
				(relation-asserted cat-M-Co)
				(valid-answers M-Co-CoBr M-Co-Ta M-Co-An M-Co-LiAc))))

(defrule choose-M-Dr-category ""
	(logical (cat-M M-Dr))

	=>

	(assert (UI-state (display dis-M-Dr)
				(relation-asserted cat-M-Dr)
				(valid-answers M-Dr-NeNo M-Dr-Cu M-Dr-PoBi))))

(defrule choose-M-Ho-category ""
	(logical (cat-M M-Ho))

	=>

	(assert (UI-state (display dis-M-Ho)
				(relation-asserted cat-M-Ho)
				(valid-answers M-Ho-CuHo M-Ho-ClHo M-Ho-CoHo))))

(defrule choose-M-Cr-category ""
	(logical (cat-M M-Cr))

	=>

	(assert (UI-state (display dis-M-Cr)
				(relation-asserted cat-M-Cr)
				(valid-answers M-Cr-Ac M-Cr-My M-Cr-SoDi))))

(defrule choose-M-Do-category ""
	(logical (cat-M M-Do))

	=>

	(assert (UI-state (display dis-M-Do)
				(relation-asserted cat-M-Do)
				(valid-answers M-Do-In M-Do-No M-Do-Dr M-Do-St))))

;;;*** 4th Question Movie***
(defrule choose-M-Ac-MaAr-category ""
	(logical (cat-M-Ac M-Ac-MaAr))

	=>

	(assert (UI-state (display dis-M-Ac-MaAr)
				(relation-asserted cat-M-Ac-MaAr)
				(valid-answers M-Ac-MaAr-Re M-Ac-MaAr-Ta M-Ac-MaAr-Sp))))

(defrule choose-M-Ac-Se-category ""
	(logical (cat-M-Ac M-Ac-Se))

	=>

	(assert (UI-state (display dis-M-Ac-Se)
				(relation-asserted cat-M-Ac-Se)
				(valid-answers M-Ac-Se-Co M-Ac-Se-ScFi))))

(defrule choose-M-Ac-Go-category ""
	(logical (cat-M-Ac M-Ac-Go))

	=>

	(assert (UI-state (display dis-M-Ac-Go)
				(relation-asserted cat-M-Ac-Go)
				(valid-answers M-Ac-Go-Br M-Ac-Go-NoBr))))

(defrule choose-M-Co-CoBr-category ""
	(logical (cat-M-Co M-Co-CoBr))

	=>

	(assert (UI-state (display dis-M-Co-CoBr)
				(relation-asserted cat-M-Co-CoBr)
				(valid-answers M-Co-CoBr-Gr M-Co-CoBr-Od M-Co-CoBr-Mi))))

(defrule choose-M-Co-An-categoryy ""
	(logical (cat-M-Co M-Co-An))

	=>

	(assert (UI-state (display dis-M-Co-An)
				(relation-asserted cat-M-Co-An)
				(valid-answers M-Co-An-Ad M-Co-An-SeFu))))

(defrule choose-M-Co-LiAc-category ""
	(logical (cat-M-Co M-Co-LiAc))

	=>

	(assert (UI-state (display dis-M-Co-LiAc)
				(relation-asserted cat-M-Co-LiAc)
				(valid-answers M-Co-LiAc-So M-Co-LiAc-Ho M-Co-LiAc-Po M-Co-LiAc-We M-Co-LiAc-Cl))))

(defrule choose-M-Dr-NeNo-category ""
	(logical (cat-M-Dr M-Dr-NeNo))

	=>

	(assert (UI-state (display dis-M-Dr-NeNo)
				(relation-asserted cat-M-Dr-NeNo)
				(valid-answers M-Dr-NeNo-Ke M-Dr-NeNo-Ir M-Dr-NeNo-Ch))))

(defrule choose-M-Dr-Cu-category ""
	(logical (cat-M-Dr M-Dr-Cu))

	=>

	(assert (UI-state (display dis-M-Dr-Cu)
				(relation-asserted cat-M-Dr-Cu)
				(valid-answers M-Dr-Cu-Te M-Dr-Cu-Fr M-Dr-Cu-We))))

(defrule choose-M-Dr-PoBi-category ""
	(logical (cat-M-Dr M-Dr-PoBi))

	=>

	(assert (UI-state (display dis-M-Dr-PoBi)
				(relation-asserted cat-M-Dr-PoBi)
				(valid-answers M-Dr-PoBi-Ww M-Dr-PoBi-Ji M-Dr-PoBi-Ce M-Dr-PoBi-Do))))

(defrule choose-M-Ho-CuHo-category ""
	(logical (cat-M-Ho M-Ho-CuHo))

	=>

	(assert (UI-state (display dis-M-Ho-CuHo)
				(relation-asserted cat-M-Ho-CuHo)
				(valid-answers M-Ho-CuHo-Ex M-Ho-CuHo-Ha))))

(defrule choose-M-Ho-ClHo-category ""
	(logical (cat-M-Ho M-Ho-ClHo))

	=>

	(assert (UI-state (display dis-M-Ho-ClHo)
				(relation-asserted cat-M-Ho-ClHo)
				(valid-answers M-Ho-ClHo-So M-Ho-ClHo-Co))))

(defrule choose-M-Ho-CoHo-category ""
	(logical (cat-M-Ho M-Ho-CoHo))

	=>

	(assert (UI-state (display dis-M-Ho-CoHo)
				(relation-asserted cat-M-Ho-CoHo)
				(valid-answers M-Ho-CoHo-De M-Ho-CoHo-Sp))))

(defrule choose-M-Cr-Ac-category ""
	(logical (cat-M-Cr M-Cr-Ac))

	=>

	(assert (UI-state (display dis-M-Cr-Ac)
				(relation-asserted cat-M-Cr-Ac)
				(valid-answers M-Cr-Ac-Ma M-Cr-Ac-Co M-Cr-Ac-Jo))))

(defrule choose-M-Cr-My-category ""
	(logical (cat-M-Cr M-Cr-My))

	=>

	(assert (UI-state (display dis-M-Cr-My)
				(relation-asserted cat-M-Cr-My)
				(valid-answers M-Cr-My-Fa M-Cr-My-Jo))))

(defrule choose-M-Cr-SoDi-category ""
	(logical (cat-M-Cr M-Cr-SoDi))

	=>

	(assert (UI-state (display dis-M-Cr-SoDi)
				(relation-asserted cat-M-Cr-SoDi)
				(valid-answers M-Cr-SoDi-Ma M-Cr-SoDi-Jo))))

;;;*** 5th Question Movie***
(defrule choose-M-Ac-Se-Co-category ""
	(logical (cat-M-Ac-Se M-Ac-Se-Co))

	=>

	(assert (UI-state (display dis-M-Ac-Se-Co)
				(relation-asserted cat-M-Ac-Se-Co)
				(valid-answers M-Ac-Se-Co-No M-Ac-Se-Co-Ro))))

(defrule choose-M-Ac-Se-ScFi-category ""
	(logical (cat-M-Ac-Se M-Ac-Se-ScFi))

	=>

	(assert (UI-state (display dis-M-Ac-Se-ScFi)
				(relation-asserted cat-M-Ac-Se-ScFi)
				(valid-answers M-Ac-Se-ScFi-Cy M-Ac-Se-ScFi-As))))

(defrule choose-M-Ac-Go-NoBr-category ""
	(logical (cat-M-Ac-Go M-Ac-Go-NoBr))

	=>

	(assert (UI-state (display dis-M-Ac-Go-NoBr)
				(relation-asserted cat-M-Ac-Go-NoBr)
				(valid-answers M-Ac-Go-NoBr-Ho M-Ac-Go-NoBr-Ac M-Ac-Go-NoBr-Ta))))

(defrule choose-M-Co-LiAc-So-category ""
	(logical (cat-M-Co-LiAc M-Co-LiAc-So))

	=>

	(assert (UI-state (display dis-M-Co-LiAc-So)
				(relation-asserted cat-M-Co-LiAc-So)
				(valid-answers M-Co-LiAc-So-Lo M-Co-LiAc-So-Li))))

(defrule choose-M-Co-LiAc-Ho-category ""
	(logical (cat-M-Co-LiAc M-Co-LiAc-Ho))

	=>

	(assert (UI-state (display dis-M-Co-LiAc-Ho)
				(relation-asserted cat-M-Co-LiAc-Ho)
				(valid-answers M-Co-LiAc-Ho-Ki M-Co-LiAc-Ho-Sh M-Co-LiAc-Ho-Pl))))

(defrule choose-M-Co-LiAc-We-category ""
	(logical (cat-M-Co-LiAc M-Co-LiAc-We))

	=>

	(assert (UI-state (display dis-M-Co-LiAc-We)
				(relation-asserted cat-M-Co-LiAc-We)
				(valid-answers M-Co-LiAc-We-Ma M-Co-LiAc-We-Hi))))

(defrule choose-M-Co-LiAc-Cl-category ""
	(logical (cat-M-Co-LiAc M-Co-LiAc-Cl))

	=>

	(assert (UI-state (display dis-M-Co-LiAc-Cl)
				(relation-asserted cat-M-Co-LiAc-Cl)
				(valid-answers M-Co-LiAc-Cl-Go M-Co-LiAc-Cl-Sh M-Co-LiAc-Cl-Cu))))

;;;*** 6th Question Movie***
(defrule choose-M-Co-LiAc-Cl-Sh-category ""
	(logical (cat-M-Co-LiAc-Cl M-Co-LiAc-Cl-Sh))

	=>

	(assert (UI-state (display dis-M-Co-LiAc-Cl-Sh)
				(relation-asserted cat-M-Co-LiAc-Cl-Sh)
				(valid-answers M-Co-LiAc-Cl-Sh-Se M-Co-LiAc-Cl-Sh-No))))

(defrule choose-M-Co-LiAc-Cl-Cu-category ""
	(logical (cat-M-Co-LiAc-Cl M-Co-LiAc-Cl-Cu))

	=>

	(assert (UI-state (display dis-M-Co-LiAc-Cl-Cu)
				(relation-asserted cat-M-Co-LiAc-Cl-Cu)
				(valid-answers M-Co-LiAc-Cl-Cu-Pl M-Co-LiAc-Cl-Cu-Ta M-Co-LiAc-Cl-Cu-St M-Co-LiAc-Cl-Cu-Hi M-Co-LiAc-Cl-Cu-Sa))))

;;;*** 7th Question Movie***
(defrule choose-M-Co-LiAc-Cl-Cu-Ta-category ""
	(logical (cat-M-Co-LiAc-Cl-Cu M-Co-LiAc-Cl-Cu-Ta))

	=>

	(assert (UI-state (display dis-M-Co-LiAc-Cl-Cu-Ta)
				(relation-asserted cat-M-Co-LiAc-Cl-Cu-Ta)
				(valid-answers M-Co-LiAc-Cl-Cu-Ta-Ki M-Co-LiAc-Cl-Cu-Ta-Se))))

;;;*** 3rd Question Television***
(defrule choose-T-Co-category ""
	(logical (cat-T T-Co))

	=>

	(assert (UI-state (display dis-T-Co)
				(relation-asserted cat-T-Co)
				(valid-answers T-Co-LiAc T-Co-An))))

(defrule choose-T-Ac-category ""
	(logical (cat-T T-Ac))

	=>

	(assert (UI-state (display dis-T-Ac)
				(relation-asserted cat-T-Ac)
				(valid-answers T-Ac-LiAc T-Ac-An))))

(defrule choose-T-Dr-category ""
	(logical (cat-T T-Dr))

	=>

	(assert (UI-state (display dis-T-Dr)
				(relation-asserted cat-T-Dr)
				(valid-answers T-Dr-Cr T-Dr-Mi T-Dr-No))))
;;;*** 4th Question Television***
(defrule choose-T-Co-LiAc-category ""
	(logical (cat-T-Co T-Co-LiAc))

	=>

	(assert (UI-state (display dis-T-Co-LiAc)
				(relation-asserted cat-T-Co-LiAc)
				(valid-answers T-Co-LiAc-Wo T-Co-LiAc-Fa T-Co-LiAc-Fr))))

(defrule choose-T-Co-An-category ""
	(logical (cat-T-Co T-Co-An))

	=>

	(assert (UI-state (display dis-T-Co-An)
				(relation-asserted cat-T-Co-An)
				(valid-answers T-Co-An-Ad T-Co-An-Ch))))

(defrule choose-T-Ac-LiAc-category ""
	(logical (cat-T-Ac T-Ac-LiAc))

	=>

	(assert (UI-state (display dis-T-Ac-LiAc)
				(relation-asserted cat-T-Ac-LiAc)
				(valid-answers T-Ac-LiAc-Dc T-Ac-LiAc-Ma T-Ac-LiAc-ScFi))))

(defrule choose-T-Ac-An-category ""
	(logical (cat-T-Ac T-Ac-An))

	=>

	(assert (UI-state (display dis-T-Ac-An)
				(relation-asserted cat-T-Ac-An)
				(valid-answers T-Ac-An-Hi T-Ac-An-Am T-Ac-An-Ja T-Ac-An-So T-Ac-An-Co))))

(defrule choose-T-Dr-Cr-category ""
	(logical (cat-T-Dr T-Dr-Cr))

	=>

	(assert (UI-state (display dis-T-Dr-Cr)
				(relation-asserted cat-T-Dr-Cr)
				(valid-answers T-Dr-Cr-Go T-Dr-Cr-Ba))))

(defrule choose-T-Dr-Mi-category ""
	(logical (cat-T-Dr T-Dr-Mi))

	=>

	(assert (UI-state (display dis-T-Dr-Mi)
				(relation-asserted cat-T-Dr-Mi)
				(valid-answers T-Dr-Mi-Cl T-Dr-Mi-Mo T-Dr-Mi-Su))))

(defrule choose-T-Dr-No-category ""
	(logical (cat-T-Dr T-Dr-No))

	=>

	(assert (UI-state (display dis-T-Dr-No)
				(relation-asserted cat-T-Dr-No)
				(valid-answers T-Dr-No-Ki T-Dr-No-Ba))))

;;;*** 5th Question Television***
(defrule choose-T-Co-LiAc-Wo-category ""
	(logical (cat-T-Co-LiAc T-Co-LiAc-Wo))

	=>

	(assert (UI-state (display dis-T-Co-LiAc-Wo)
				(relation-asserted cat-T-Co-LiAc-Wo)
				(valid-answers T-Co-LiAc-Wo-Am T-Co-LiAc-Wo-Br))))

(defrule choose-T-Co-LiAc-Fa-category ""
	(logical (cat-T-Co-LiAc T-Co-LiAc-Fa))

	=>

	(assert (UI-state (display dis-T-Co-LiAc-Fa)
				(relation-asserted cat-T-Co-LiAc-Fa)
				(valid-answers T-Co-LiAc-Fa-Su T-Co-LiAc-Fa-Ri))))

(defrule choose-T-Co-LiAc-Fr-category ""
	(logical (cat-T-Co-LiAc T-Co-LiAc-Fr))

	=>

	(assert (UI-state (display dis-T-Co-LiAc-Fr)
				(relation-asserted cat-T-Co-LiAc-Fr)
				(valid-answers T-Co-LiAc-Fr-St T-Co-LiAc-Fr-Ma T-Co-LiAc-Fr-Ex))))

(defrule choose-T-Co-An-Ad-category ""
	(logical (cat-T-Co-An T-Co-An-Ad))

	=>

	(assert (UI-state (display dis-T-Co-An-Ad)
				(relation-asserted cat-T-Co-An-Ad)
				(valid-answers T-Co-An-Ad-Ol T-Co-An-Ad-Pa T-Co-An-Ad-Ve))))

(defrule choose-T-Co-An-Ch-category ""
	(logical (cat-T-Co-An T-Co-An-Ch))

	=>

	(assert (UI-state (display dis-T-Co-An-Ch)
				(relation-asserted cat-T-Co-An-Ch)
				(valid-answers T-Co-An-Ch-Ch T-Co-An-Ch-Cl))))

(defrule choose-T-Ac-LiAc-Dc-category ""
	(logical (cat-T-Ac-LiAc T-Ac-LiAc-Dc))

	=>

	(assert (UI-state (display dis-T-Ac-LiAc-Dc)
				(relation-asserted cat-T-Ac-LiAc-Dc)
				(valid-answers T-Ac-LiAc-Dc-Ba T-Ac-LiAc-Dc-Gu))))

(defrule choose-T-Ac-LiAc-Ma-category ""
	(logical (cat-T-Ac-LiAc T-Ac-LiAc-Ma))

	=>

	(assert (UI-state (display dis-T-Ac-LiAc-Ma)
				(relation-asserted cat-T-Ac-LiAc-Ma)
				(valid-answers T-Ac-LiAc-Ma-Su T-Ac-LiAc-Ma-Bl T-Ac-LiAc-Ma-Ex))))

(defrule choose-T-Ac-LiAc-ScFi-category ""
	(logical (cat-T-Ac-LiAc T-Ac-LiAc-ScFi))

	=>

	(assert (UI-state (display dis-T-Ac-LiAc-ScFi)
				(relation-asserted cat-T-Ac-LiAc-ScFi)
				(valid-answers T-Ac-LiAc-ScFi-ScFi T-Ac-LiAc-ScFi-Fa))))

(defrule choose-T-Dr-Cr-Go-category ""
	(logical (cat-T-Dr-Cr T-Dr-Cr-Go))

	=>

	(assert (UI-state (display dis-T-Dr-Cr-Go)
				(relation-asserted cat-T-Dr-Cr-Go)
				(valid-answers T-Dr-Cr-Go-Mo T-Dr-Cr-Go-Fb))))

(defrule choose-T-Dr-Cr-Ba-category ""
	(logical (cat-T-Dr-Cr T-Dr-Cr-Ba))

	=>

	(assert (UI-state (display dis-T-Dr-Cr-Ba)
				(relation-asserted cat-T-Dr-Cr-Ba)
				(valid-answers T-Dr-Cr-Ba-Ca T-Dr-Cr-Ba-Bi T-Dr-Cr-Ba-Me))))

;;;*** 6th Question Television***
(defrule choose-T-Co-LiAc-Wo-Am-category ""
	(logical (cat-T-Co-LiAc-Wo T-Co-LiAc-Wo-Am))

	=>

	(assert (UI-state (display dis-T-Co-LiAc-Wo-Am)
				(relation-asserted cat-T-Co-LiAc-Wo-Am)
				(valid-answers T-Co-LiAc-Wo-Am-On T-Co-LiAc-Wo-Am-Tw T-Co-LiAc-Wo-Am-Pu T-Co-LiAc-Wo-Am-Lo T-Co-LiAc-Wo-Am-Re))))

(defrule choose-T-Co-LiAc-Wo-Br-category ""
	(logical (cat-T-Co-LiAc-Wo T-Co-LiAc-Wo-Br))

	=>

	(assert (UI-state (display dis-T-Co-LiAc-Wo-Br)
				(relation-asserted cat-T-Co-LiAc-Wo-Br)
				(valid-answers T-Co-LiAc-Wo-Br-Re T-Co-LiAc-Wo-Br-So))))

(defrule choose-T-Ac-LiAc-ScFi-ScFi-category ""
	(logical (cat-T-Ac-LiAc-ScFi T-Ac-LiAc-ScFi-ScFi))

	=>

	(assert (UI-state (display dis-T-Ac-LiAc-ScFi-ScFi)
				(relation-asserted cat-T-Ac-LiAc-ScFi-ScFi)
				(valid-answers T-Ac-LiAc-ScFi-ScFi-Su T-Ac-LiAc-ScFi-ScFi-Nu T-Ac-LiAc-ScFi-ScFi-Pe))))

(defrule choose-T-Ac-LiAc-ScFi-Fa-category ""
	(logical (cat-T-Ac-LiAc-ScFi T-Ac-LiAc-ScFi-Fa))

	=>

	(assert (UI-state (display dis-T-Ac-LiAc-ScFi-Fa)
				(relation-asserted cat-T-Ac-LiAc-ScFi-Fa)
				(valid-answers T-Ac-LiAc-ScFi-Fa-Tw T-Ac-LiAc-ScFi-Fa-Mu T-Ac-LiAc-ScFi-Fa-Re))))

;;;*** 7th Question Television***
(defrule choose-T-Ac-LiAc-ScFi-ScFi-Nu-category ""
	(logical (cat-T-Ac-LiAc-ScFi-ScFi T-Ac-LiAc-ScFi-ScFi-Nu))

	=>

	(assert (UI-state (display dis-T-Ac-LiAc-ScFi-ScFi-Nu)
				(relation-asserted cat-T-Ac-LiAc-ScFi-ScFi-Nu)
				(valid-answers T-Ac-LiAc-ScFi-ScFi-Nu-Ge T-Ac-LiAc-ScFi-ScFi-Nu-Im))))

;;;*****************
;;;* FINAL ANSWERS *
;;;*****************

;;;*** MovieTimelessClassicsAnswers ***
(defrule answer-M-TiCl-Sc ""
	(logical (cat-M-TiCl M-TiCl-Sc))

	=>
	
	(assert (UI-state (display film-M-TiCl-Sc)
				(state final))))

(defrule answer-M-TiCl-La ""
	(logical (cat-M-TiCl M-TiCl-La))

	=>
	
	(assert (UI-state (display film-M-TiCl-La)
				(state final))))
(defrule answer-M-TiCl-Ge ""
	(logical (cat-M-TiCl M-TiCl-Ge))

	=>
	
	(assert (UI-state (display film-M-TiCl-Ge)
				(state final))))
;;;*** MovieActionAnswers ***
(defrule answer-M-Ac-MaAr-Re ""
	(logical (cat-M-Ac-MaAr M-Ac-MaAr-Re))

	=>
	
	(assert (UI-state (display film-M-Ac-MaAr-Re)
				(state final))))
(defrule answer-M-Ac-MaAr-Ta ""
	(logical (cat-M-Ac-MaAr M-Ac-MaAr-Ta))

	=>
	
	(assert (UI-state (display film-M-Ac-MaAr-Ta)
				(state final))))
(defrule answer-M-Ac-MaAr-Sp ""
	(logical (cat-M-Ac-MaAr M-Ac-MaAr-Sp))

	=>
	
	(assert (UI-state (display film-M-Ac-MaAr-Sp)
				(state final))))
(defrule answer-M-Ac-Se-Co-No ""
	(logical (cat-M-Ac-Se-Co M-Ac-Se-Co-No))

	=>
	
	(assert (UI-state (display film-M-Ac-Se-Co-No)
				(state final))))
(defrule answer-M-Ac-Se-Co-Ro ""
	(logical (cat-M-Ac-Se-Co M-Ac-Se-Co-Ro))

	=>
	
	(assert (UI-state (display film-M-Ac-Se-Co-Ro)
				(state final))))
(defrule answer-M-Ac-Se-ScFi-Cy ""
	(logical (cat-M-Ac-Se-ScFi M-Ac-Se-ScFi-Cy))

	=>
	
	(assert (UI-state (display film-M-Ac-Se-ScFi-Cy)
				(state final))))
(defrule answer-M-Ac-Se-ScFi-As ""
	(logical (cat-M-Ac-Se-ScFi M-Ac-Se-ScFi-As))

	=>
	
	(assert (UI-state (display film-M-Ac-Se-ScFi-As)
				(state final))))
(defrule answer-M-Ac-Go-Br ""
	(logical (cat-M-Ac-Go M-Ac-Go-Br))

	=>
	
	(assert (UI-state (display film-M-Ac-Go-Br)
				(state final))))
(defrule answer-M-Ac-Go-NoBr-Ho ""
	(logical (cat-M-Ac-Go-NoBr M-Ac-Go-NoBr-Ho))

	=>
	
	(assert (UI-state (display film-M-Ac-Go-NoBr-Ho)
				(state final))))
(defrule answer-M-Ac-Go-NoBr-Ac ""
	(logical (cat-M-Ac-Go-NoBr M-Ac-Go-NoBr-Ac))

	=>
	
	(assert (UI-state (display film-M-Ac-Go-NoBr-Ac)
				(state final))))
(defrule answer-M-Ac-Go-NoBr-Ta ""
	(logical (cat-M-Ac-Go-NoBr M-Ac-Go-NoBr-Ta))

	=>
	
	(assert (UI-state (display film-M-Ac-Go-NoBr-Ta)
				(state final))))
;;;*** MovieComedyAnswers ***
(defrule answer-M-Co-CoBr-Gr ""
	(logical (cat-M-Co-CoBr M-Co-CoBr-Gr))

	=>
	
	(assert (UI-state (display film-M-Co-CoBr-Gr)
				(state final))))
(defrule answer-M-Co-CoBr-Od ""
	(logical (cat-M-Co-CoBr M-Co-CoBr-Od))

	=>
	
	(assert (UI-state (display film-M-Co-CoBr-Od)
				(state final))))
(defrule answer-M-Co-CoBr-Mi ""
	(logical (cat-M-Co-CoBr M-Co-CoBr-Mi))

	=>
	
	(assert (UI-state (display film-M-Co-CoBr-Mi)
				(state final))))
(defrule answer-M-Co-Ta ""
	(logical (cat-M-Co M-Co-Ta))

	=>
	
	(assert (UI-state (display film-M-Co-Ta)
				(state final))))
(defrule answer-M-Co-An-Ad ""
	(logical (cat-M-Co-An M-Co-An-Ad))

	=>
	
	(assert (UI-state (display film-M-Co-An-Ad)
				(state final))))
(defrule answer-M-Co-An-SeFu ""
	(logical (cat-M-Co-An M-Co-An-SeFu))

	=>
	
	(assert (UI-state (display film-M-Co-An-SeFu)
				(state final))))
(defrule answer-M-Co-LiAc-So-Lo ""
	(logical (cat-M-Co-LiAc-So M-Co-LiAc-So-Lo))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-So-Lo)
				(state final))))
(defrule answer-M-Co-LiAc-So-Li ""
	(logical (cat-M-Co-LiAc-So M-Co-LiAc-So-Li))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-So-Li)
				(state final))))
(defrule answer-M-Co-LiAc-Ho-Ki ""
	(logical (cat-M-Co-LiAc-Ho M-Co-LiAc-Ho-Ki))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Ho-Ki)
				(state final))))
(defrule answer-M-Co-LiAc-Ho-Sh ""
	(logical (cat-M-Co-LiAc-Ho M-Co-LiAc-Ho-Sh))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Ho-Sh)
				(state final))))
(defrule answer-M-Co-LiAc-Ho-Pl ""
	(logical (cat-M-Co-LiAc-Ho M-Co-LiAc-Ho-Pl))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Ho-Pl)
				(state final))))
(defrule answer-M-Co-LiAc-Po ""
	(logical (cat-M-Co-LiAc M-Co-LiAc-Po))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Po)
				(state final))))
(defrule answer-M-Co-LiAc-We-Ma ""
	(logical (cat-M-Co-LiAc-We M-Co-LiAc-We-Ma))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-We-Ma)
				(state final))))
(defrule answer-M-Co-LiAc-We-Hi ""
	(logical (cat-M-Co-LiAc-We M-Co-LiAc-We-Hi))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-We-Hi)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Go ""
	(logical (cat-M-Co-LiAc-Cl M-Co-LiAc-Cl-Go))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Go)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Sh-Se ""
	(logical (cat-M-Co-LiAc-Cl-Sh M-Co-LiAc-Cl-Sh-Se))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Sh-Se)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Sh-No ""
	(logical (cat-M-Co-LiAc-Cl-Sh M-Co-LiAc-Cl-Sh-No))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Sh-No)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Cu-Pl ""
	(logical (cat-M-Co-LiAc-Cl-Cu M-Co-LiAc-Cl-Cu-Pl))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Cu-Pl)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Cu-Ta-Ki ""
	(logical (cat-M-Co-LiAc-Cl-Cu-Ta M-Co-LiAc-Cl-Cu-Ta-Ki))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Cu-Ta-Ki)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Cu-Ta-Se ""
	(logical (cat-M-Co-LiAc-Cl-Cu-Ta M-Co-LiAc-Cl-Cu-Ta-Se))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Cu-Ta-Se)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Cu-St ""
	(logical (cat-M-Co-LiAc-Cl-Cu M-Co-LiAc-Cl-Cu-St))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Cu-St)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Cu-Hi ""
	(logical (cat-M-Co-LiAc-Cl-Cu M-Co-LiAc-Cl-Cu-Hi))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Cu-Hi)
				(state final))))
(defrule answer-M-Co-LiAc-Cl-Cu-Sa ""
	(logical (cat-M-Co-LiAc-Cl-Cu M-Co-LiAc-Cl-Cu-Sa))

	=>
	
	(assert (UI-state (display film-M-Co-LiAc-Cl-Cu-Sa)
				(state final))))
;;;*** MovieDramaAnswers ***
(defrule answer-M-Dr-NeNo-Ke ""
	(logical (cat-M-Dr-NeNo M-Dr-NeNo-Ke))

	=>
	
	(assert (UI-state (display film-M-Dr-NeNo-Ke)
				(state final))))
(defrule answer-M-Dr-NeNo-Ir ""
	(logical (cat-M-Dr-NeNo M-Dr-NeNo-Ir))

	=>
	
	(assert (UI-state (display film-M-Dr-NeNo-Ir)
				(state final))))
(defrule answer-M-Dr-NeNo-Ch ""
	(logical (cat-M-Dr-NeNo M-Dr-NeNo-Ch))

	=>
	
	(assert (UI-state (display film-M-Dr-NeNo-Ch)
				(state final))))
(defrule answer-M-Dr-Cu-Te ""
	(logical (cat-M-Dr-Cu M-Dr-Cu-Te))

	=>
	
	(assert (UI-state (display film-M-Dr-Cu-Te)
				(state final))))
(defrule answer-M-Dr-Cu-Fr ""
	(logical (cat-M-Dr-Cu M-Dr-Cu-Fr))

	=>
	
	(assert (UI-state (display film-M-Dr-Cu-Fr)
				(state final))))
(defrule answer-M-Dr-Cu-We ""
	(logical (cat-M-Dr-Cu M-Dr-Cu-We))

	=>
	
	(assert (UI-state (display film-M-Dr-Cu-We)
				(state final))))
(defrule answer-M-Dr-PoBi-Ww ""
	(logical (cat-M-Dr-PoBi M-Dr-PoBi-Ww))

	=>
	
	(assert (UI-state (display film-M-Dr-PoBi-Ww)
				(state final))))
(defrule answer-M-Dr-PoBi-Ji ""
	(logical (cat-M-Dr-PoBi M-Dr-PoBi-Ji))

	=>
	
	(assert (UI-state (display film-M-Dr-PoBi-Ji)
				(state final))))
(defrule answer-M-Dr-PoBi-Ce ""
	(logical (cat-M-Dr-PoBi M-Dr-PoBi-Ce))

	=>
	
	(assert (UI-state (display film-M-Dr-PoBi-Ce)
				(state final))))
(defrule answer-M-Dr-PoBi-Do ""
	(logical (cat-M-Dr-PoBi M-Dr-PoBi-Do))

	=>
	
	(assert (UI-state (display film-M-Dr-PoBi-Do)
				(state final))))
;;;*** MovieHorrorAnswers ***
(defrule answer-M-Ho-CuHo-Ex ""
	(logical (cat-M-Ho-CuHo M-Ho-CuHo-Ex))

	=>
	
	(assert (UI-state (display film-M-Ho-CuHo-Ex)
				(state final))))
(defrule answer-M-Ho-CuHo-Ha ""
	(logical (cat-M-Ho-CuHo M-Ho-CuHo-Ha))

	=>
	
	(assert (UI-state (display film-M-Ho-CuHo-Ha)
				(state final))))
(defrule answer-M-Ho-ClHo-So ""
	(logical (cat-M-Ho-ClHo M-Ho-ClHo-So))

	=>
	
	(assert (UI-state (display film-M-Ho-ClHo-So)
				(state final))))
(defrule answer-M-Ho-ClHo-Co ""
	(logical (cat-M-Ho-ClHo M-Ho-ClHo-Co))

	=>
	
	(assert (UI-state (display film-M-Ho-ClHo-Co)
				(state final))))
(defrule answer-M-Ho-CoHo-De ""
	(logical (cat-M-Ho-CoHo M-Ho-CoHo-De))

	=>
	
	(assert (UI-state (display film-M-Ho-CoHo-De)
				(state final))))
(defrule answer-M-Ho-CoHo-Sp ""
	(logical (cat-M-Ho-CoHo M-Ho-CoHo-Sp))

	=>
	
	(assert (UI-state (display film-M-Ho-CoHo-Sp)
				(state final))))
;;;*** MovieCrimeAnswers ***
(defrule answer-M-Cr-Ac-Ma ""
	(logical (cat-M-Cr-Ac M-Cr-Ac-Ma))

	=>
	
	(assert (UI-state (display film-M-Cr-Ac-Ma)
				(state final))))
(defrule answer-M-Cr-Ac-Co ""
	(logical (cat-M-Cr-Ac M-Cr-Ac-Co))

	=>
	
	(assert (UI-state (display film-M-Cr-Ac-Co)
				(state final))))
(defrule answer-M-Cr-Ac-Jo ""
	(logical (cat-M-Cr-Ac M-Cr-Ac-Jo))

	=>
	
	(assert (UI-state (display film-M-Cr-Ac-Jo)
				(state final))))
(defrule answer-M-Cr-My-Fa ""
	(logical (cat-M-Cr-My M-Cr-My-Fa))

	=>
	
	(assert (UI-state (display film-M-Cr-My-Fa)
				(state final))))
(defrule answer-M-Cr-My-Jo ""
	(logical (cat-M-Cr-My M-Cr-My-Jo))

	=>
	
	(assert (UI-state (display film-M-Cr-My-Jo)
				(state final))))
(defrule answer-M-Cr-SoDi-Ma ""
	(logical (cat-M-Cr-SoDi M-Cr-SoDi-Ma))

	=>
	
	(assert (UI-state (display film-M-Cr-SoDi-Ma)
				(state final))))
(defrule answer-M-Cr-SoDi-Jo ""
	(logical (cat-M-Cr-SoDi M-Cr-SoDi-Jo))

	=>
	
	(assert (UI-state (display film-M-Cr-SoDi-Jo)
				(state final))))
;;;*** MovieDocumentariesAnswers ***
(defrule answer-M-Do-In ""
	(logical (cat-M-Do M-Do-In))

	=>
	
	(assert (UI-state (display film-M-Do-In)
				(state final))))
(defrule answer-M-Do-No ""
	(logical (cat-M-Do M-Do-No))

	=>
	
	(assert (UI-state (display film-M-Do-No)
				(state final))))
(defrule answer-M-Do-Dr ""
	(logical (cat-M-Do M-Do-Dr))

	=>
	
	(assert (UI-state (display film-M-Do-Dr)
				(state final))))
(defrule answer-M-Do-St ""
	(logical (cat-M-Do M-Do-St))

	=>
	
	(assert (UI-state (display film-M-Do-St)
				(state final))))
;;;*** TelevisionComedyAnswers ***
(defrule answer-T-Co-LiAc-Wo-Am-On ""
	(logical (cat-T-Co-LiAc-Wo-Am T-Co-LiAc-Wo-Am-On))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Wo-Am-On)
				(state final))))
(defrule answer-T-Co-LiAc-Wo-Am-Tw ""
	(logical (cat-T-Co-LiAc-Wo-Am T-Co-LiAc-Wo-Am-Tw))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Wo-Am-Tw)
				(state final))))
(defrule answer-T-Co-LiAc-Wo-Am-Pu ""
	(logical (cat-T-Co-LiAc-Wo-Am T-Co-LiAc-Wo-Am-Pu))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Wo-Am-Pu)
				(state final))))
(defrule answer-T-Co-LiAc-Wo-Am-Lo ""
	(logical (cat-T-Co-LiAc-Wo-Am T-Co-LiAc-Wo-Am-Lo))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Wo-Am-Lo)
				(state final))))
(defrule answer-T-Co-LiAc-Wo-Am-Re ""
	(logical (cat-T-Co-LiAc-Wo-Am T-Co-LiAc-Wo-Am-Re))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Wo-Am-Re)
				(state final))))
(defrule answer-T-Co-LiAc-Wo-Br-Re ""
	(logical (cat-T-Co-LiAc-Wo-Br T-Co-LiAc-Wo-Br-Re))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Wo-Br-Re)
				(state final))))
(defrule answer-T-Co-LiAc-Wo-Br-So ""
	(logical (cat-T-Co-LiAc-Wo-Br T-Co-LiAc-Wo-Br-So))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Wo-Br-So)
				(state final))))
(defrule answer-T-Co-LiAc-Fa-Su ""
	(logical (cat-T-Co-LiAc-Fa T-Co-LiAc-Fa-Su))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Fa-Su)
				(state final))))
(defrule answer-T-Co-LiAc-Fa-Ri ""
	(logical (cat-T-Co-LiAc-Fa T-Co-LiAc-Fa-Ri))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Fa-Ri)
				(state final))))
(defrule answer-T-Co-LiAc-Fr-St ""
	(logical (cat-T-Co-LiAc-Fr T-Co-LiAc-Fr-St))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Fr-St)
				(state final))))
(defrule answer-T-Co-LiAc-Fr-Ma ""
	(logical (cat-T-Co-LiAc-Fr T-Co-LiAc-Fr-Ma))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Fr-Ma)
				(state final))))
(defrule answer-T-Co-LiAc-Fr-Ex ""
	(logical (cat-T-Co-LiAc-Fr T-Co-LiAc-Fr-Ex))

	=>
	
	(assert (UI-state (display film-T-Co-LiAc-Fr-Ex)
				(state final))))
(defrule answer-T-Co-An-Ad-Ol ""
	(logical (cat-T-Co-An-Ad T-Co-An-Ad-Ol))

	=>
	
	(assert (UI-state (display film-T-Co-An-Ad-Ol)
				(state final))))
(defrule answer-T-Co-An-Ad-Pa ""
	(logical (cat-T-Co-An-Ad T-Co-An-Ad-Pa))

	=>
	
	(assert (UI-state (display film-T-Co-An-Ad-Pa)
				(state final))))
(defrule answer-T-Co-An-Ad-Ve ""
	(logical (cat-T-Co-An-Ad T-Co-An-Ad-Ve))

	=>
	
	(assert (UI-state (display film-T-Co-An-Ad-Ve)
				(state final))))
(defrule answer-T-Co-An-Ch-Ch ""
	(logical (cat-T-Co-An-Ch T-Co-An-Ch-Ch))

	=>
	
	(assert (UI-state (display film-T-Co-An-Ch-Ch)
				(state final))))
(defrule answer-T-Co-An-Ch-Cl ""
	(logical (cat-T-Co-An-Ch T-Co-An-Ch-Cl))

	=>
	
	(assert (UI-state (display film-T-Co-An-Ch-Cl)
				(state final))))
;;;*** TelevisionActionAnswers ***
(defrule answer-T-Ac-LiAc-Dc-Ba ""
	(logical (cat-T-Ac-LiAc-Dc T-Ac-LiAc-Dc-Ba))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-Dc-Ba)
				(state final))))
(defrule answer-T-Ac-LiAc-Dc-Gu ""
	(logical (cat-T-Ac-LiAc-Dc T-Ac-LiAc-Dc-Gu))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-Dc-Gu)
				(state final))))
(defrule answer-T-Ac-LiAc-Ma-Su ""
	(logical (cat-T-Ac-LiAc-Ma T-Ac-LiAc-Ma-Su))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-Ma-Su)
				(state final))))
(defrule answer-T-Ac-LiAc-Ma-Bl ""
	(logical (cat-T-Ac-LiAc-Ma T-Ac-LiAc-Ma-Bl))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-Ma-Bl)
				(state final))))
(defrule answer-T-Ac-LiAc-Ma-Ex ""
	(logical (cat-T-Ac-LiAc-Ma T-Ac-LiAc-Ma-Ex))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-Ma-Ex)
				(state final))))
(defrule answer-T-Ac-LiAc-ScFi-ScFi-Su ""
	(logical (cat-T-Ac-LiAc-ScFi-ScFi T-Ac-LiAc-ScFi-ScFi-Su))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-ScFi-ScFi-Su)
				(state final))))
(defrule answer-T-Ac-LiAc-ScFi-ScFi-Nu-Ge ""
	(logical (cat-T-Ac-LiAc-ScFi-ScFi-Nu T-Ac-LiAc-ScFi-ScFi-Nu-Ge))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-ScFi-ScFi-Nu-Ge)
				(state final))))
(defrule answer-T-Ac-LiAc-ScFi-ScFi-Nu-Im ""
	(logical (cat-T-Ac-LiAc-ScFi-ScFi-Nu T-Ac-LiAc-ScFi-ScFi-Nu-Im))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-ScFi-ScFi-Nu-Im)
				(state final))))
(defrule answer-T-Ac-LiAc-ScFi-ScFi-Pe ""
	(logical (cat-T-Ac-LiAc-ScFi-ScFi T-Ac-LiAc-ScFi-ScFi-Pe))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-ScFi-ScFi-Pe)
				(state final))))
(defrule answer-T-Ac-LiAc-ScFi-Fa-Tw ""
	(logical (cat-T-Ac-LiAc-ScFi-Fa T-Ac-LiAc-ScFi-Fa-Tw))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-ScFi-Fa-Tw)
				(state final))))
(defrule answer-T-Ac-LiAc-ScFi-Fa-Mu ""
	(logical (cat-T-Ac-LiAc-ScFi-Fa T-Ac-LiAc-ScFi-Fa-Mu))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-ScFi-Fa-Mu)
				(state final))))
(defrule answer-T-Ac-LiAc-ScFi-Fa-Re ""
	(logical (cat-T-Ac-LiAc-ScFi-Fa T-Ac-LiAc-ScFi-Fa-Re))

	=>
	
	(assert (UI-state (display film-T-Ac-LiAc-ScFi-Fa-Re)
				(state final))))
(defrule answer-T-Ac-An-Hi ""
	(logical (cat-T-Ac-An T-Ac-An-Hi))

	=>
	
	(assert (UI-state (display film-T-Ac-An-Hi)
				(state final))))
(defrule answer-T-Ac-An-Am ""
	(logical (cat-T-Ac-An T-Ac-An-Am))

	=>
	
	(assert (UI-state (display film-T-Ac-An-Am)
				(state final))))
(defrule answer-T-Ac-An-Ja ""
	(logical (cat-T-Ac-An T-Ac-An-Ja))

	=>
	
	(assert (UI-state (display film-T-Ac-An-Ja)
				(state final))))
(defrule answer-T-Ac-An-So ""
	(logical (cat-T-Ac-An T-Ac-An-So))

	=>
	
	(assert (UI-state (display film-T-Ac-An-So)
				(state final))))
(defrule answer-T-Ac-An-Co ""
	(logical (cat-T-Ac-An T-Ac-An-Co))

	=>
	
	(assert (UI-state (display film-T-Ac-An-Co)
				(state final))))
;;;*** TelevisionDramaAnswers ***
(defrule answer-T-Dr-Cr-Go-Mo ""
	(logical (cat-T-Dr-Cr-Go T-Dr-Cr-Go-Mo))

	=>
	
	(assert (UI-state (display film-T-Dr-Cr-Go-Mo)
				(state final))))
(defrule answer-T-Dr-Cr-Go-Fb ""
	(logical (cat-T-Dr-Cr-Go T-Dr-Cr-Go-Fb))

	=>
	
	(assert (UI-state (display film-T-Dr-Cr-Go-Fb)
				(state final))))
(defrule answer-T-Dr-Cr-Ba-Ca ""
	(logical (cat-T-Dr-Cr-Ba T-Dr-Cr-Ba-Ca))

	=>
	
	(assert (UI-state (display film-T-Dr-Cr-Ba-Ca)
				(state final))))
(defrule answer-T-Dr-Cr-Ba-Bi ""
	(logical (cat-T-Dr-Cr-Ba T-Dr-Cr-Ba-Bi))

	=>
	
	(assert (UI-state (display film-T-Dr-Cr-Ba-Bi)
				(state final))))
(defrule answer-T-Dr-Cr-Ba-Me ""
	(logical (cat-T-Dr-Cr-Ba T-Dr-Cr-Ba-Me))

	=>
	
	(assert (UI-state (display film-T-Dr-Cr-Ba-Me)
				(state final))))
(defrule answer-T-Dr-Mi-Cl ""
	(logical (cat-T-Dr-Mi T-Dr-Mi-Cl))

	=>
	
	(assert (UI-state (display film-T-Dr-Mi-Cl)
				(state final))))
(defrule answer-T-Dr-Mi-Mo ""
	(logical (cat-T-Dr-Mi T-Dr-Mi-Mo))

	=>
	
	(assert (UI-state (display film-T-Dr-Mi-Mo)
				(state final))))
(defrule answer-T-Dr-Mi-Su ""
	(logical (cat-T-Dr-Mi T-Dr-Mi-Su))

	=>
	
	(assert (UI-state (display film-T-Dr-Mi-Su)
				(state final))))
(defrule answer-T-Dr-No-Ki ""
	(logical (cat-T-Dr-No T-Dr-No-Ki))

	=>
	
	(assert (UI-state (display film-T-Dr-No-Ki)
				(state final))))
(defrule answer-T-Dr-No-Ba ""
	(logical (cat-T-Dr-No T-Dr-No-Ba))

	=>
	
	(assert (UI-state (display film-T-Dr-No-Ba)
				(state final))))

;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   