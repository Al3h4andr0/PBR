(deftemplate student
    (slot nume)
    (slot prenume)
    (slot punctajExamen (default 0))
    (slot punctajProiect(default 0))
    (multislot punctajeLaborator(default 0))
)

(deffacts example-facts
  (student (nume "Doe") (prenume "John") (punctajExamen 38) (punctajProiect 25)(punctajeLaborator 4 5 5 1 2 3))
  (student (nume "Doe") (prenume "John") (punctajExamen 8) (punctajProiect 22)(punctajeLaborator 4 5 5 1 2 3))
  (student (nume "Ionescu") (prenume "Maricica") (punctajExamen 40) (punctajProiect 25)(punctajeLaborator 4 1 2))
  (student (nume "Popescu") (prenume "Vasile") (punctajExamen 24) (punctajProiect 2)(punctajeLaborator 4 1 2 3))
  (student (nume "Vasilescu") (prenume "Mihai") (punctajExamen 12) (punctajProiect 10)(punctajeLaborator 4 5 5))
  (student (nume "Randomescu") (prenume "Ion") (punctajExamen 23) (punctajProiect 12)(punctajeLaborator 4 5 2 3))
  (student (nume "Lalala") (prenume "Blalala") (punctajExamen 14) (punctajProiect 5)(punctajeLaborator 4 5 3))
)
(deffunction sum (?numbers)
  (bind ?suma 0)
  (if (multifieldp ?numbers)
    then 
    (foreach ?number ?numbers
         (bind ?suma (+ ?suma ?number))
      )
    else 
        (bind ?suma ?numbers)
    ))

(deffunction punctulUnu ()
    (printout t "Introduceti informatiile studentului:" crlf "Nume, Prenume, Punctaj Examen, Punctaj Proiect, Punctaje laborator." crlf "Toate aceste informatii vor fi separate de spatii" crlf)
    (bind ?linie (readline))
    (bind ?split (explode$ ?linie))
    (bind ?nume (nth$ 1 ?split))
    (bind ?prenume (nth$ 2 ?split))
    (bind ?punctajExamen (if (> (length$ ?split) 2) then (nth$ 3 ?split) else 0))
    (bind ?punctajProiect (if (> (length$ ?split) 3) then (nth$ 4 ?split) else 0))
    (bind ?punctajeLaborator (if (> (length$ ?split) 4) then (explode$ (implode$ (subseq$ ?split 5 (length$ ?split)))) else 0))
    (if (and (< ?punctajExamen 41)(< ?punctajProiect 31)(< (sum ?punctajeLaborator) 31)(>= ?punctajExamen 0)(>= ?punctajProiect 0)(>= (sum ?punctajeLaborator) 0))
        then
        (assert (student (nume ?nume)(prenume ?prenume)(punctajExamen ?punctajExamen)(punctajProiect ?punctajProiect)(punctajeLaborator ?punctajeLaborator)))
        else 
        (printout t "Reincercati cu valori care respecta regulile de pe pagina laboratorului" crlf)
    )
)

(deffunction punctulDoi (?numeCautat ?prenumeCautat ?optiune)
    (bind ?gasit FALSE)
    (do-for-all-facts ((?s student)) TRUE
        (if (and (eq (fact-slot-value ?s nume) ?numeCautat)
                 (eq (fact-slot-value ?s prenume) ?prenumeCautat))
            then 
                (printout t "Student gasit :D" crlf )
                (bind ?gasit TRUE)
                (printout t "Introduceti punctajele (separate de spatii): ")
                (bind ?punctajeNoi (explode$ (readline)))
                (switch ?optiune
                    (case 0 then 
                        (if (< (sum ?punctajeNoi) 31)
                            then
                            (modify ?s (punctajeLaborator ?punctajeNoi))
                            else 
                            (printout t "Reincercati cu valori care respecta regulile de pe pagina laboratorului" crlf)
                        )
                        
                    )
                    (case 1 then
                        (bind ?punctajVechi (fact-slot-value ?s punctajeLaborator))
                        (bind ?adunari (sum (fact-slot-value ?s punctajeLaborator)))
                        (bind ?adunari2 (sum ?punctajeNoi))
                        (if (< (+ ?adunari ?adunari2) 31)
                            then 
                            (modify ?s (punctajeLaborator (create$ ?punctajVechi ?punctajeNoi)))
                            else 
                            (printout t "Reincercati cu valori care respecta regulile de pe pagina laboratorului" crlf)
                        )
                    )
                )
        )
    )
    (if (not ?gasit)
        then 
            (printout t "Nu am gasit un student cu numele " ?numeCautat " " ?prenumeCautat)
    )

)

(deffunction punctulTrei (?nume ?prenume ?nota)
    (bind ?gasit FALSE)
    (do-for-all-facts ((?s student)) TRUE 
        (if (and (eq (fact-slot-value ?s nume) ?nume)
                 (eq (fact-slot-value ?s prenume) ?prenume))
            then 
                (bind ?gasit TRUE)
                (if (< ?nota 41)
                    then 
                    (printout t "Student gasit, modificam nota" crlf)
                    (modify ?s (punctajExamen ?nota))
                    else 
                    (printout t "Reincercati cu valori care respecta regulile de pe pagina laboratorului" crlf)
                )
        )
    )
    (if (not ?gasit)
        then 
            (printout t "Nu am gasit un student cu numele " ?nume " " ?prenume)
    )
)

(deffunction punctulPatru (?nume ?prenume ?nota)
    (bind ?gasit FALSE)
    (do-for-all-facts ((?s student)) TRUE 
        (if (and (eq (fact-slot-value ?s nume) ?nume)
                 (eq (fact-slot-value ?s prenume) ?prenume))
            then 
                (bind ?gasit TRUE)
                (if (< ?nota 31)
                    then 
                    (printout t "Student gasit, modificam nota" crlf)
                    (modify ?s (punctajProiect ?nota))
                    else
                    (printout t "Reincercati cu valori care respecta regulile de pe pagina laboratorului" crlf)
                )
                
        )
    )
    (if (not ?gasit)
        then 
            (printout t "Nu am gasit un student cu numele " ?nume " " ?prenume)
    )
)

(deffunction punctulCinci (?nume ?prenume)
    (bind ?gasit FALSE)
     (do-for-all-facts ((?s student)) TRUE 
        (if (and (eq (fact-slot-value ?s nume) ?nume)
                 (eq (fact-slot-value ?s prenume) ?prenume))
            then 
                (bind ?gasit TRUE)
                (printout t "Student gasit, aceasta este situatia lui scolara" crlf)
                (bind ?lab (fact-slot-value ?s punctajeLaborator))
                (bind ?proiect (fact-slot-value ?s punctajProiect))
                (bind ?examen (fact-slot-value ?s punctajExamen))
                (printout t "Situatia actuala a studentului " ?nume " " ?prenume " este urmatoarea " crlf
                            "Nota examen : " ?examen crlf 
                            "Nota proiect : " ?proiect crlf 
                            "Note laborator : " ?lab crlf)
        )
    )
    (if (not ?gasit)
        then 
            (printout t "Nu am gasit un student cu numele " ?nume " " ?prenume)
    )
)

(deffunction print-students (?list)
  (foreach ?student ?list
    (printout t ?student " "))
)

(deffunction punctulSase ()
    (bind ?listaPromovati "")
    (bind ?listaNepromovati "")
    (do-for-all-facts ((?s student)) TRUE
      (bind ?sumlab (sum (fact-slot-value ?s punctajeLaborator)))
      (bind ?student (create$ (fact-slot-value ?s nume) (fact-slot-value ?s prenume) ,))
      (if (> (+ ?sumlab (fact-slot-value ?s punctajProiect) (fact-slot-value ?s punctajExamen)) 50)
        then 
            (if (eq ?listaPromovati "")
                then
                (bind ?listaPromovati (create$ ?student))
                else
                (bind ?listaPromovati (create$ ?listaPromovati ?student))
            )
        else 
            (if (eq ?listaNepromovati "")
                then
                (bind ?listaNepromovati (create$ ?student))
                else
                (bind ?listaNepromovati (create$ ?listaNepromovati ?student))
            )
      )
    )
    (printout t "Lista promovati:" crlf)
    (print-students ?listaPromovati)
    (printout t crlf)
    (printout t crlf "Lista nepromovati:" crlf)
    (print-students ?listaNepromovati)
    (printout t crlf)

)



(defrule menu-loop
   =>
   (printout t "Introduceti instructiune: " crlf)
   (printout t "1. Adauga student: " crlf)
   (printout t "2. Adauga punctaje la laborator pentru un student: " crlf)
   (printout t "3. Adauga punctaj la examen pentru un student: " crlf)
   (printout t "4. Adauga punctaj la proiect pentru un student: " crlf)
   (printout t "5. Afiseaza situatie student: " crlf)
   (printout t "6. Afiseaza studentii promovati si cei nepromovati: " crlf)
   (printout t "7. Iesire: " crlf)
   (printout t "------------------------------------------------------------" crlf)

      (bind ?input (read))
   (while (not (eq ?input 7)) do
      (switch ?input
         (case 1 then 
            (punctulUnu)
            (printout t "Done :D" crlf)
         )
         (case 2 then 
            (printout t "Introduceti numele si prenumele studentului. "crlf "De asemenea, introduceti 0 daca doriti sa inlocuiti notele pe care le are deja,"crlf "sau 1 daca doriti sa adaugati note la cele curente." crlf)
            (bind ?linie (readline))
            (bind ?split (explode$ ?linie))
            (bind ?nume (nth$ 1 ?split))
            (bind ?prenume (nth$ 2 ?split))
            (bind ?optiune (nth$ 3 ?split))
            (punctulDoi ?nume ?prenume ?optiune)
         )
         (case 3 then 
            (printout t "Introducet numele prenumele si nota de la examen pentru acel student" crlf)
            (bind ?linie (readline))
            (bind ?split (explode$ ?linie))
            (bind ?nume (nth$ 1 ?split))
            (bind ?prenume (nth$ 2 ?split))
            (bind ?nota (nth$ 3 ?split))
            (punctulTrei ?nume ?prenume ?nota)
         )
         (case 4 then 
            (printout t "Introducet numele prenumele si nota de la proiect pentru acel student" crlf)
            (bind ?linie (readline))
            (bind ?split (explode$ ?linie))
            (bind ?nume (nth$ 1 ?split))
            (bind ?prenume (nth$ 2 ?split))
            (bind ?nota (nth$ 3 ?split))
            (punctulPatru ?nume ?prenume ?nota)
         )
         (case 5 then 
            (printout t "Introducet numele prenumele studentului" crlf)
            (bind ?linie (readline))
            (bind ?split (explode$ ?linie))
            (bind ?nume (nth$ 1 ?split))
            (bind ?prenume (nth$ 2 ?split))
            (punctulCinci ?nume ?prenume)
         )
         (case 6 then (punctulSase))
         (case 7 then (printout t "Iesim... " crlf)(halt))
         (default then (printout t "Invalid command!" crlf))
      )
        (printout t "------------------------------------------------------------" crlf)
        (printout t "Introduceti instructiune: " crlf)
        (printout t "1. Adauga student: " crlf)
        (printout t "2. Adauga punctaje la laborator pentru un student: " crlf)
        (printout t "3. Adauga punctaj la examen pentru un student: " crlf)
        (printout t "4. Adauga punctaj la proiect pentru un student: " crlf)
        (printout t "5. Afiseaza situatie student: " crlf)
        (printout t "6. Afiseaza studentii promovati si cei nepromovati: " crlf)
        (printout t "7. Iesire: " crlf)
        (printout t "------------------------------------------------------------" crlf)
            (bind ?input (read))
   )
)
