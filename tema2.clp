(deftemplate country
   (slot name (type SYMBOL))
   (slot color (type SYMBOL) (default none))
)

(deftemplate list-of-countries
   (multislot countries (type SYMBOL) (default ()))
)

(deffacts initial-facts
   (list-of-countries)
)

(deffunction read-line ()
   (bind ?line (readline))
   (if (eq ?line FALSE) then (return ""))
   ?line
)

(defrule get-country-input
   (initial-facts)
   (list-of-countries (countries $?c&:(eq (length$ ?c) 0)))
   =>
   (printout t "Enter a list of countries (separated by spaces): ")
   (bind ?input (read-line))
   (bind ?country-names (explode$ ?input))
   (foreach ?name ?country-names
      (assert (country (name ?name)))
   )
   (retract (list-of-countries (countries $?)))
   (assert (list-of-countries (countries ?country-names)))
)

(defrule get-color-input
   (not (country (color ?)))
   =>
   (printout t "Enter a list of colors (separated by spaces): ")
   (bind ?input (read-line))
   (bind ?colors (explode$ ?input))
   (foreach ?color ?colors
      (assert (country (color ?color)))
   )
)

(defrule set-color
   (country (name ?c:name) (color none))
   (not (country (name ?n:name) (color ?c:color&~eq ?c:name)))
   =>
   (bind ?colors (find-all-facts ((?c country)) (eq ?c:color none)))
   (bind ?possible-colors (create$))
   (foreach ?color (find-all-facts ((?c country)) (neq ?c:name) (eq ?c:color ?))
     (bind ?possible-colors (create$ ?color ?possible-colors))
   )
   (if (neq (length$ ?possible-colors) 0) then
      (bind ?new-color (nth$ (random (length$ ?possible-colors)) ?possible-colors))
      (modify ?c (color ?new-color))
   )
)

(defrule check-conflict
   ?c1 <- (country (name ?n1) (color ?c1))
   ?c2 <- (country (name ?n2&~eq ?n1) (color ?c1))
   =>
   (printout t "Conflict detected between " ?n1 " and " ?n2 "!" crlf)
   (retract ?c2)
   (assert (country (name ?n2) (color none)))
)

(defrule done
   (not (country (color none)))
   =>
   (printout t "Solution found!" crlf)
   (foreach ?c (find-all-facts ((?c country)) TRUE)
      (printout t (str-cat (fact-slot-value ?c name) ": " (fact-slot-value ?c color)) crlf)
   )
   (halt)
)
