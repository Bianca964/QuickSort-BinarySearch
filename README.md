
# TASK 2

  ## SUBTASK 1 - QUICK_SORT
        Acest subtask realizeaza implementarea recursiva a algoritmului de
    quicksort, urmand pasii aferenti. Se incepe prin a se salva toti registri
    prin punerea lor pe stiva (pusha) si restaurarea lor la finalul functiei
    (popa) pentru a ramane neschimbati la iesirea din functie.
        Pentru aceasta functie am avut nevoie de implementarea unei functii
    auxiliare: functia de partitionare regasita la sfarsitul functiei
    quick_sort. 

        Functia de `partitionare` incepe prin a prelua parametrii de pe stiva,
    retine pivotul si contorul 'i', dupa care incep bucla
    for (int j = start; j <= end; j++), 'ecx' fiind pe post de 'j'. La fiecare
    iteratie a buclei verific daca buff[j] < pivot, caz in care cresc 'i' si
    interschimb buff[i] cu buff[j], iar daca buff[j] >= pivot trec la urmatorul
    'j'. La finalul buclei cresc 'i' si interschimb buff[end] (fostul pivot)
    cu termenul de pe pozitia curenta a noului pivot (i) pe care o si returnez
    prin registrul 'eax' (pozitia noua a pivotului).

        Incep algoritmul propriu-zis de quick_sort:
    ~ se preiau parametrii functiei in registrii
    ~ se compara daca punctul de start a depasit punctul de sfarsit, caz in
    care sare direct la finalul functiei quicksort
    ~ altfel, se apeleaza functia de partitionare regasita imediat dupa functia
    quick_sort, nu inainte de a salva registrii si de ai restaura imediat dupa
    functia 'partition'
    ~ dupa apelarea 'partition', pozitia noului pivot va fi returnata prin 'eax'
    ~ urmeaza apelarea de sortare recursiva a functiei quick_sort pentru prima
    jumatate (se modifica punctul de final), dupa care apelarea recursiva pentru
    a doua jumatate (se modifica punctul de inceput).

  ## SUBTASK 2 - BINARY_SEARCH
        Cel de-al doilea subtask realizeaza implementarea recursiva a
    algoritmului de cautare binara intr-un vector sortat, utilizand conceptul
    de 'fastcall (primele 2 argumente sunt deja retinute in registrele 'ecx'
    si 'edx'). Dupa preluarea urmatorilor parametri ai functiei, se verifica
    cazul de baza : daca start > end nu s-a gasit termenul cautat, returnand
    -1. Daca trece de aceasta verificare, calculeaza mijlocul, ia elemntul de
    pe pozitia din mijloc si il compara cu termenul cautat (tinta) :
        ~ daca sunt egali inseamna ca l-a gasit si returneaza pozitia pastrata
    deja in 'eax'
        ~ daca este mai mic decat tinta, caut in jumatatea superioara :
    inlocuiesc punctul de start cu middle si apelez recursiv functia (salvand
    in prealabil registrii si punand pe stiva parametrii necesari in ordinea
    corespunzatoare)
        ~ daca este mai mare decat tinta, caut in jumatatea inferiora :
    inlocuiesc  punctul de final cu midlle si apelez recursiv functia (salvand
    in prealabil registrii si punand pe stiva parametrii necesari in ordinea
    corespunzatoare)
