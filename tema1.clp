(deffacts fapte
(pachet1 PBR)
(pachet1 TPPM)
(pachet1 ACTN)
(pachet1 PJ)
(pachet2 PCPIT)
(pachet2 CC)
(pachet2 HCI)
(pachet2 ARMS)
(pachet3 RPA)
(pachet3 SCA)
(pachet3 ISSA)
(pachet3 IIL)
(facultativ PC)
)

(defrule prefer-platforme-mobile
  (not (pachet1Optiune ?))
  =>
  (printout t "Pachet1" crlf)
  (printout t "Ati prefera sa programati pe platforme mobile? (da/nu)")
  (bind ?choice (read))
  (if (eq ?choice "da")
    then
    (assert (pachet1Optiune "Tehnici de programare pe platforme mobile")))
)

(defrule prefer-matematica
    (not (pachet1Optiune ?))
    =>
    (printout t "Aveti o pasiune pentru matematica?(da/nu)")
    (bind ?choice (read))
    (if (eq ?choice "da")
        then
        (assert (pachet1Optiune "Aspecte Computationale in Teoria Numerelor")))
)

(defrule preferPBR
    (not (pachet1Optiune ?))
    =>
    (printout t "Ati prefera sa invatati un limbaj nou de programare bazat pe reguli sau sa le folositi pe cele deja invatate pentru a dezvolta jocuri?(1/2)")
    (bind ?choice (read))
    (if (eq ?choice "1")
        then 
        (assert (pachet1Optiune "Programare Bazata pe Reguli"))
        else
        (assert (pachet1Optiune "Proiectarea Jocurilor")))
)

(defrule prefer-cloud-dev
    (not (pachet2Optiune ?))
    =>
    (printout t "Pachet2" crlf)
    (printout t "Doriti sa aveti o cariera in Cloud Development?(da/nu)" crlf)
    (bind ?choice (read))
    (if (eq ?choice "da")
        then 
        (assert (pachet2Optiune "Cloud Computing")))
)

(defrule prefer-social-media
    (not (pachet2Optiune ?))
    =>
    (printout t "Doriti sa analizati stiinta din spatele retelelor media sociale?(da/nu)")
    (bind ?choice (read))
    (if (eq ?choice "da")
        then
        (assert (pachet2Optiune "Analiza Retelelor Media Sociale")))
)

(defrule prefer-interactiune-om-calculator
    (not (pachet2Optiune ?))
    =>
    (printout t "Doriti sa invatati cum un om si un compute \"Dialogheaza\"?(da/nu)")
    (bind ?choice (read))
    (if (eq ?choice "da")
        then 
        (assert (pachet2Optiune "Interactiune om-calculator"))
        else 
        (assert (pachet2Optiune "Psihologia Comunicarii Profesionale in Domeniul IT-lui")))
)

(defrule prefer-automobile
    (not (pachet3Optiune ?))
    =>
    (printout t "Pachet3" crlf)
    (printout t "Sunteti pasionat de automobile si ati dori sa lucrati in domeniu?(da/nu)" crlf)
    (bind ?choice (read))
    (if (eq ?choice "da")
        then 
        (assert (pachet3Optiune "Inginerie Software Specifica Automobilelor")))
)

(defrule prefer-smartcarduri
    (not (pachet3Optiune ?))
    => 
    (printout t "Doriti sa aflati mai multe despre smart card-uri si rolul lor in modernizare?(da/nu)" crlf)
    (bind ?choice (read))
    (if (eq ?choice "da")
        then
        (assert (pachet3Optiune "Smart Card-uri si Aplicatii")))
)

(defrule prefer-retele-petri
    (not (pachet3Optiune ?))
    =>
    (printout t "Ati prefera sa va implicati in modelarea sistemelor sau sa aflati mai multe lucruri despre internet si utilitatile sale?(1/2)" crlf)
    (bind ?choice (read))
    (if (eq ?choice "da")
        then
        (assert (pachet3Optiune "Retele Petri si Aplicatii"))
        else 
        (assert (pachet3Optiune "Introducere in Internetul Lucrurilor"))
    )
)

(defrule prefer-materie-facultativa
    (not (facultativAles ?))
    =>
    (printout t "Doriti sa va inscriem si la materia facultativa Programare Competitiva?(da/nu)" crlf)
    (bind ?choice (read))
    (if (eq ?choice "da")
        then 
        (assert (facultativAles "Programare Competitva")))
)

(defrule facultativ-ales 
    (facultativAles)
    =>
    (printout t "Ati ales sa participati si la materia facultativa Programare Competitiva" crlf)
)

(defrule optiunile-alese
    (pachet1Optiune ?p1)
    (pachet2Optiune ?p2)
    (pachet3Optiune ?p3)
    =>
    (printout t "Pentru pachetul 1 aveti materia " ?p1 crlf)
    (printout t "Pentru pachetul 2 aveti materia " ?p2 crlf)
    (printout t "Pentru pachetul 3 aveti materia " ?p3 crlf)
)

