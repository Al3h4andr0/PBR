(deftemplate tara-cu-vecini
   (slot tara)
   (multislot vecini))

(defrule culori 
   =>
   (printout t "Culori separate de un spatiu: ")
   (bind ?line (readline))
   (bind ?words (explode$ ?line))
   (foreach ?word ?words
      (assert (culoare ?word)))
)


; (defrule tari 
;    =>
;    (printout t "Tari separate de un spatiu: ")
;    (bind ?line (readline))
;    (bind ?words (explode$ ?line))
;    (foreach ?word ?words
;       (assert (tara ?word)))
; )


(defrule read-vecini
   =>
   (bind ?done FALSE)
   (while (not ?done)
   (printout t "Tara si dupa vecinii ei totul separat de spatii: ")
   (bind ?line (readline))
   (if (eq ?line "")
      then 
         (bind ?done TRUE)
      else 
         (bind ?words (explode$ ?line))
         (bind ?tara (nth$ 1 ?words))
         (bind ?vecini (rest$ ?words))
         (assert (tara-cu-vecini (tara ?tara)(vecini ?vecini)))
   );if
   ) ; while
)

(defrule assign-culori
   (declare (salience -10))
   =>
   (do-for-all-facts ((?f tara-cu-vecini)) TRUE
      (printout t "Country: ")
      (printout t (fact-slot-value ?f tara) crlf)
      (printout t " Neighbours: ")
      (bind ?vecini (fact-slot-value ?f vecini))
      (foreach ?vecin ?vecini
         (printout t "|" ?vecin "|"crlf)
      )
      (printout t crlf)
   )
)
