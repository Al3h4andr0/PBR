(deftemplate student
    (slot nume (type SYMBOL))
    (slot prenume (type SYMBOL))
    (slot punctajExamen (default 0))
    (slot punctajProiect(default 0))
    (multislot punctajeLaborator(default 0))
)

(deffunction punctulUnu ()
    (printout t "Introduceti informatiile studentului:" crlf "Nume, Prenume, Punctaj Examen, Punctaj Proiect, Punctaje laborator." crlf "Toate aceste informatii vor fi separate de spatii" crlf)
    (bind ?linie (readline))
    (bind ?split (explode$ ?linie))
    (bind ?nume (nth$ 1 ?split))
    (bind ?prenume (nth$ 2 ?split))
    (bind ?punctajExamen (if (> (length$ ?split) 2) then (nth$ 3 ?split) else 0))
    (bind ?punctajProiect (if (> (length$ ?split) 3) then (nth$ 4 ?split) else 0))
    (bind ?punctajeLaborator (if (> (length$ ?split) 4) then (explode$ (implode$ (subseq$ ?split 5 (length$ ?split)))) else 0))
    (assert (student (nume ?nume)(prenume ?prenume)(punctajExamen ?punctajExamen)(punctajProiect ?punctajProiect)(punctajeLaborator ?punctajeLaborator)))
)

(deffunction punctulDoi (?numeCautat ?prenumeCautat ?optiune)
    (bind ?gasit FALSE)
    (do-for-all-facts ((?s student)) TRUE
        (if (and (eq (fact-slot-value ?s nume) ?numeCautat)
                 (eq (fact-slot-value ?s prenume) ?prenumeCautat))
            then 
                (printout t "Student gasit --------------------------------------------------------------------------------------" crlf )
                (bind ?gasit TRUE)
                (printout t "Introduceti punctajele (separate de spatii): ")
                (bind ?punctajeNoi (explode$ (readline)))
                (switch ?optiune
                    (case 0 then 
                        (modify ?s (punctajeLaborator ?punctajeNoi))
                    )
                    (case 1 then
                        (bind ?punctajVechi (fact-slot-value ?s punctajeLaborator))
                        (modify ?s (punctajeLaborator (create$ ?punctajVechi ?punctajeNoi)))
                    )
                )
        )
    )
    (if (not ?gasit)
        then 
            (printout t "Nu am gasit un student cu numele " ?numeCautat " " ?prenumeCautat)
    )

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
            (printout t "Introduceti numele si prenumele studentului. "crlf "De asemenea, introduceti 0 daca doriti sa inlocuiti notele pe care le are deja,"crlf "sau 1 daca doriti sa adaugati note la cele curente.")
            (bind ?linie (readline))
            (bind ?split (explode$ ?linie))
            (bind ?nume (nth$ 1 ?split))
            (bind ?prenume (nth$ 2 ?split))
            (bind ?optiune (nth$ 3 ?split))
            (printout t "apeles punctulDoi cu " ?nume " " ?prenume " " ?optiune)
            (punctulDoi ?nume ?prenume ?optiune)
            (printout t "Done :D" crlf))
         (case 3 then (printout t "You chose command 3" crlf))
         (case 4 then (printout t "You chose command 4" crlf))
         (case 5 then (printout t "You chose command 5" crlf))
         (case 6 then (printout t "You chose command 6" crlf))
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
