(deftemplate tara-cu-vecini
   (slot tara)
   (multislot vecini))

; (defrule culori 
;    =>
;    (printout t "Culori separate de un spatiu: ")
;    (bind ?line (readline))
;    (bind ?words (explode$ ?line))
;    (foreach ?word ?words
;       (assert (culoare ?word)))
; )

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
         (bind ?tara (nth$ 0 ?words))
         (bind ?vecini (rest$ ?words))
         (assert (tara-cu-vecini (tara ?tara)(vecini ?vecini)))
   );if
   ) ; while
)