%----------------------------- TDA systemcd --------------------------------------------------

eliminar_ultimos(N, Lista, Eliminados):-
    length(Lista, Longitud),
    Longitud >= N,
    LongitudFinal is Longitud - N,
    eliminar_ultimos_1(N, Lista, LongitudFinal, [], Reversa),
    reverse(Reversa, Eliminados).

eliminar_ultimos_1(_, _, 0, Eliminados, Eliminados):- !.
eliminar_ultimos_1(N, [Elemento|Resto], LongitudFinal, Acumulador, Eliminados):-
    LongitudActual is LongitudFinal - 1,
    eliminar_ultimos_1(N, Resto, LongitudActual, [Elemento|Acumulador], Eliminados).

dividir_string(String, Separador, Subcadenas):-
    split_string(String, Separador, "", Subcadenas).

unir_elementos(Lista, Caracter, Resultado):-
    atomic_list_concat(Lista, Caracter, Resultado).

iguales(Palabra1, Palabra2):-
    Palabra1 == Palabra2.

ultimos(N, Lista, Resultado):-
    length(Lista, Longitud),
    Longitud >= N,
    LongitudFinal is Longitud - N,
    ultimos(N, Lista, LongitudFinal, Resultado).

ultimos(_, Resultado, 0, Resultado):- !.
ultimos(N, [_|Resto], LongitudFinal, Resultado):-
    LongitudActual is LongitudFinal - 1,
    ultimos(N, Resto, LongitudActual, Resultado).

condicion(Sistema, Parametro, Updated_Sistema):-
    dividir_string(Parametro, "/", Lista),
    ultimos(1, Lista, New),
    primer_elemento(New, Ruta_2),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Ruta_2, "/"], Probar),
    get_Carpetas(Sistema, Carpetas),
    primer_elemento(Lista, Confirmar),
    (iguales(".", Confirmar), buscar_elemento_en_sublista_1(Probar, Carpetas)),
    dividir_string(Parametro, "/", Lista),
    ultimos(1, Lista, New),
    primer_elemento(New, Ruta_2),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Ruta_2, "/"], Probar),
    ruta(Probar, Probar_1),
    set_ruta(Sistema, Probar_1, Updated_Sistema).

condicion(Sistema, Parametro, Updated_Sistema):-
    iguales("/", Parametro),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    dividir_string(Ruta_1, "/", Lista),
    primer_elemento(Lista, Ruta_2),
    unir([Ruta_2, "/"], New_lista),
    ruta(New_lista, Probar),
    set_ruta(Sistema, Probar, Updated_Sistema).

condicion(Sistema, Parametro, Updated_Sistema):-
    iguales("..", Parametro),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    dividir_string(Ruta_1, "/", Lista),
    eliminar_ultimos(2, Lista, New_lista),
    unir_elementos(New_lista, "/", New_lista_2),
    unir([New_lista_2, "/"], New_lista_3),
    ruta(New_lista_3, Probar_1),
    set_ruta(Sistema, Probar_1, Updated_Sistema).

condicion(Sistema, Parametro, Updated_Sistema):-
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir(["../", Ruta_1], Prueba),
    unir([Parametro], Parametro_1),
    iguales(Prueba, Parametro_1),
    get_ruta(Sistema, Ruta),
    set_ruta(Sistema, Ruta, Updated_Sistema).


condicion(Sistema, Parametro, Updated_Sistema):-
    (iguales("./", Parametro); iguales("././././", Parametro); iguales(".", Parametro)),
    get_ruta(Sistema, Ruta),
    set_ruta(Sistema, Ruta, Updated_Sistema).

condicion(Sistema, Parametro, Updated_Sistema):-
    get_ruta(Sistema, Ruta),
    get_Carpetas(Sistema, Carpetas),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Parametro, "/"], Probar),
    buscar_elemento_en_sublista_1(Probar, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Parametro, "/"], Probar),
    ruta(Probar, Probar_1),
    set_ruta(Sistema, Probar_1, Updated_Sistema).

systemCd(Sistema, Parametro, Updated_Sistema):-
    condicion(Sistema, Parametro, Updated_Sistema).