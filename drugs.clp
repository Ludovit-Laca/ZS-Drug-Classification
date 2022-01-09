(deffacts pomocne_fakty
	(menu))

(defrule zobraz_menu
?prec<-(menu)
=>
	(retract ?prec)
	(printout t "-----------<MENU>-----------" crlf)
    (printout t "Nájdi vhodný liek .........A" crlf)
	(printout t "Koniec programu ...........K" crlf)
	(printout t "----------------------------" crlf)
	(printout t " " crlf)
	(printout t "Zadajte vasu volbu:")
	(assert (moja_volba (read))))

;-------------------K - KONIEC PROGRAMU--------------------------
(defrule koniec
	(moja_volba K)
    ?prec1<-(moja_volba ?v)
=>
    (retract ?prec1)
	(printout t "Koniec programu!" crlf))

;zrus volbu
(defrule zrus_volbu
    (declare (salience -11))
    ?prec1<-(moja_volba ?v)
    ?prec2<-(Na_to_K ?x)
    ?prec3<-(BP ?y)
    ?prec4<-(Age ?a)
    ?prec5<-(Cholesterol ?c)
=>
    (retract ?prec1 ?prec2 ?prec3 ?prec4 ?prec5)
    (assert (menu))
)

;zla volba
(defrule zla_volba
    (declare (salience -12))
    ?prec1<-(moja_volba ?v)
=>
    (retract ?prec1)
    (assert (menu))
)

;-------------------A - NAJDI VHODNY LIEK---------------

(defrule najdi_liek
    (moja_volba A)
=>
    (printout t "Zadajte pomer sodíka a draslíka v krvi: " crlf)
    (bind ?x (read))
    (assert (Na_to_K ?x))
    (printout t "Zadajte úroveň krvného tlaku: " crlf)
    (bind ?x (read))
    (assert (BP ?x))
    (printout t "Zadajte Váš vek: " crlf)
    (bind ?x (read))
    (assert (Age ?x))
    (printout t "Zadajte Váš cholesterol: " crlf)
    (bind ?x (read))
    (assert (Cholesterol ?x))
)

;------------------- NAJDI VHODNY LIEK---------------

;vypis hodnotu drugY
(defrule drug_y
    (declare (salience -1))
    (moja_volba A)
    (Na_to_K ?na)
    (test (> ?na 14.829))
=>
    (printout t "Vhodný liek pre Vás: drugY" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka > 14.829" crlf)
)

;vypis hodnotu drugA
(defrule drug_a
    (declare (salience -2))
    (moja_volba A)
    (Na_to_K ?na)
    (BP ?bp)
    (Age ?age)
    (test (<= ?na 14.829))
    (test (<= ?bp 0.5))
    (test (<= ?age 50.5))
=>
    (printout t "Vhodný liek pre Vás je: drugA" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka <= 14.829" crlf)
    (printout t "úroveň krvného tlaku <= 0.5" crlf)
    (printout t "vek <= 50.5" crlf)
)

;vypis hodnotu drugB
(defrule drug_b
    (declare (salience -2))
    (moja_volba A)
    (Na_to_K ?na)
    (BP ?bp)
    (Age ?age)
    (test (<= ?na 14.829))
    (test (<= ?bp 0.5))
    (test (> ?age 50.5))
=>
    (printout t "Vhodný liek pre Vás je: drugB" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka <= 14.829" crlf)
    (printout t "úroveň krvného tlaku <= 0.5" crlf)
    (printout t "vek > 50.5" crlf)
)

;vypis hodnotu drugX
(defrule drug_x
    (declare (salience -2))
    (moja_volba A)
    (Na_to_K ?na)
    (BP ?bp)
    (test (<= ?na 14.829))
    (test (> ?bp 1.5))
=>
    (printout t "Vhodný liek pre Vás je: drugX" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka <= 14.829" crlf)
    (printout t "úroveň krvného tlaku > 1.5" crlf)
)

;vypis hodnotu drugX
(defrule drug_x2
    (declare (salience -3))
    (moja_volba A)
    (Na_to_K ?na)
    (BP ?bp)
    (Cholesterol ?c)
    (test (<= ?na 14.829))
    (test (> ?bp 0.5))
    (test (<= ?bp 1.5))
    (test (> ?c 1.5))
=>
    (printout t "Vhodný liek pre Vás je: drugX" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka <= 14.829" crlf)
    (printout t "úroveň krvného tlaku > 0.5 a <= 1.5" crlf)
    (printout t "cholesterol > 1.5" crlf)
)

;vypis hodnotu drugC
(defrule drug_c
    (declare (salience -4))
    (moja_volba A)
    (Na_to_K ?na)
    (BP ?bp)
    (Cholesterol ?c)
    (test (<= ?na 14.829))
    (test (> ?bp 0.5))
    (test (<= ?bp 1.5))
    (test (<= ?c 0.5))
=>
    (printout t "Vhodný liek pre Vás je: drugC" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka <= 14.829" crlf)
    (printout t "úroveň krvného tlaku > 0.5 a <= 1.5" crlf)
    (printout t "cholesterol <= 0.5" crlf)
)

;vypis hodnotu drugE
(defrule drug_e
    (declare (salience -5))
    (moja_volba A)
    (Na_to_K ?na)
    (BP ?bp)
    (Cholesterol ?c)
    (Age ?age)
    (test (<= ?na 14.829))
    (test (> ?bp 0.5))
    (test (<= ?bp 1.5))
    (test (<= ?c 1.5))
    (test (> ?c 0.5))
    (test (<= ?age 58.0))
=>
    (printout t "Vhodný liek pre Vás je: drugE" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka <= 14.829" crlf)
    (printout t "úroveň krvného tlaku > 0.5 a <= 1.5" crlf)
    (printout t "cholesterol > 0.5 a <= 1.5" crlf)
    (printout t "vek <= 58.0" crlf)
)

;vypis hodnotu drugD
(defrule drug_d
    (declare (salience -5))
    (moja_volba A)
    (Na_to_K ?na)
    (BP ?bp)
    (Cholesterol ?c)
    (Age ?age)
    (test (<= ?na 14.829))
    (test (> ?bp 0.5))
    (test (<= ?bp 1.5))
    (test (<= ?c 1.5))
    (test (> ?c 0.5))
    (test (> ?age 58.0))
=>
    (printout t "Vhodný liek pre Vás je: drugD" crlf)
    (printout t "---- Dôvod ----" crlf)
    (printout t "pomer sodíka a draslíka <= 14.829" crlf)
    (printout t "úroveň krvného tlaku > 0.5 a <= 1.5" crlf)
    (printout t "cholesterol > 0.5 a <= 1.5" crlf)
    (printout t "vek > 58.0" crlf)
)