(defrule read-colors-and-countries 
    (declare (salience 30))
    =>
    (printout t "Introduceti culorile:" crlf)
    (assert (colors (explode$ (readline))))
    (printout t "Introduceti tarile" crlf)
    (assert (countries (explode$ (readline))))
)

(defrule read-and-set-neighbours
    (declare (salience 20))
	(countries $? ?country $?)
	=>
	(printout t "Introduceti vecinii tarii " ?country crlf)
	(bind ?neighbours (explode$ (readline)))
	(assert (neighbours ?country ?neighbours))
	(foreach ?n ?neighbours
	(assert (neighbour ?country ?n))
	(assert (neighbour ?n ?country)))
)


 (defrule assert-colors
    (declare (salience 0))
    (colors $? ?colorr $?)
    (countries $? ?countryy $?)
    (not (coloring ?countryy ?))
    (not(and(neighbour ?countryy ?neighbour)(coloring ?neighbour ?colorr)))
    =>
    (assert( coloring ?countryy ?colorr))
 )

(defrule check-solution
    (declare (salience -10))
    (countries $? ?country $?)
    (not (coloring ?country ?))
    =>
    (assert (solution false))
)

(defrule solution-true
    (declare (salience -20))
    (not (solution false))
    (coloring ?country ?color)
    =>
    (printout t ?country " --> " ?color crlf)
)

(defrule solution-false
    (declare (salience -20))
    (solution false)
    =>
    (printout t "Nu exista solutie" crlf)
)
