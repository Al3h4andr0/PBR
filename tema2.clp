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
   (printout t "Tari separate de un spatiu ")
   (bind ?line (readline))
   (bind ?words (explode$ ?line))
   (foreach ?word ?words
      (assert (tara ?word)))
)


; (defrule read-vecini
;    =>
;    (printout t "Tara si dupa vecinii ei totul separat de spatii")
;    (bind ?line (readline))
;    (bind ?words (explode$ ?line))
;    (foreach ?word ?words
;       (bind ?vecini-lista (create$))
;       (if (eq (word-index ?word) 1)
;          then (bind ?tara (nth$ 1 ?word))
;          else (bind ?vecini ?word)
;               (else (bind ?vecini-lista (create$ ?vecini-lista)))
;       )
;       (if (and (eq ?word (length$ ?words)) (neq ?vecini-lista NIL))
;          then (assert (tara-cu-vecini (tara ?tara)(vecini $? ?vecini-lista)))
;          else (assert (tara-cu-vecini (tara ?tara)))
;       )
;    )
; )