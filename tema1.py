def tema1():
    pachet1 = ["Programare bazata pe reguli", "Tehnici de programare pe platforme mobile",
               "Aspecte computationale in teoria numerelor", "Proiectarea jocurilor"]
    pachet2 = ["Psihologia comunicarii profesionale in domeniul IT-lui", "Cloud Computing",
               "Interactiune om-calculator", "Analiza retelelor media sociale"]
    pachet3 = ["Retele petri si aplicatii", "Smart Card-uri si Aplicatii", "Inginerie software specifica automobilelor",
               "Introducere in Internetul lucrurilor"]
    pachet4 = ["Programare competitiva"]
    materiiAlese = []

    print("Pachet1")
    choice = input("Ati prefera sa programati pe platforme mobile? (da/nu)")
    if choice == "da":
        materiiAlese.append(pachet1[1])
    else:
        choice = input("Aveti o pasiune pentru matematica?(da/nu)")
        if choice == "da":
            materiiAlese.append(pachet1[2])
        else:
            choice = input(
                "Ati prefera sa invatati un limbaj nou de programare bazat pe reguli sau sa le folositi pe cele deja invatate pentru a dezvolta jocuri?(1/2)")
            if choice == "1":
                materiiAlese.append(pachet1[0])
            else:
                materiiAlese.append(pachet1[3])

    print("Urmeaza intrebari pentru a decide ce materie din pachetul 2 de optionale vi se potriveste\n")
    choice = input("Doriti sa aveti o cariera in Cloud Development?(da/nu)\n")
    if choice == "da":
        materiiAlese.append(pachet2[1])
    else:
        choice = input("Doriti sa analizati stiinta din spatele retelelor media sociale? (da/nu)\n")
        if choice == "da":
            materiiAlese.append(pachet2[3])
        else:
            choice = input("Doriti sa invatati cum un om si un computer \"Dialogheaza\"?(da/nu)\n")
            if choice == "da":
                materiiAlese.append(pachet2[2])
            else:
                materiiAlese.append(pachet2[0])

    print("Urmeaza intrebari pentru a decide ce materie din pachetul 3 de optionale vi se potriveste")
    choice = input("Sunteti pasionat de automobile si ati dori sa lucrati in domeniu? (da/nu)")
    if choice == 'da':
        materiiAlese.append(pachet3[2])
    else:
        choice = input("Doriti sa aflati mai multe despre smart card-uri si rolul lor in modernizare? (da/nu)")
        if choice == 'da':
            materiiAlese.append(pachet3[1])
        else:
            choice = input(
                "Ati prefera sa va implicati in modelarea sistemelor sau sa aflati mai multe lucruri despre internet si utilitatile sale? (1/2)")
            if choice == '1':
                materiiAlese.append(pachet3[0])
            else:
                materiiAlese.append(pachet3[3])

    choice = input("Doriti sa va inscriem si la materia facultativa Programare Competitiva?(da/nu)\n")
    if choice == "da":
        materiiAlese.append(pachet4[0])

    return materiiAlese


print(tema1())