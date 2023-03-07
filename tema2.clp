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

(defrule tari 
   =>
   (printout t "Tari separate de un spatiu: ")
   (bind ?line (readline))
   (bind ?words (explode$ ?line))
   (foreach ?word ?words
      (assert (tara ?word)))
)


(defrule read-vecini
   =>
   (printout t "Tara si dupa vecinii ei totul separat de spatii: ")
   (bind ?line (readline))
   (bind ?words (explode$ ?line))
   (bind ?tara (nth$ 1 ?words))
   (bind ?vecini (rest$ (rest$ ?words)))
   (assert (tara-cu-vecini (tara ?tara)(vecini ?vecini)))
)