%------------------------------------ TDA systemdel -------------------------------------------------

filtro_lista_contiene_valor([], _, []).
filtro_lista_contiene_valor([Lista|Listas], Valor, [Lista|Resto]) :-
    sublistas_contienen_valor(Lista, Valor),
    filtro_lista_contiene_valor(Listas, Valor, Resto).
filtro_lista_contiene_valor([_|Listas], Valor, Resultado) :-
    filtro_lista_contiene_valor(Listas, Valor, Resultado).

addPape_to_Pape(New_pape, Papelera, Updated_Papelera):-
    append(Papelera, [New_pape], Updated_Papelera).

set_Papelera(Sistema, Updated_Papelera, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, _, Sistema),
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, Updated_Papelera, Updated_Sistema). 

get_papelera(Sistema, Papelera):-
    nth0(6, Sistema, Papelera).

sublistas_contienen_valor(Sublista, Valor) :-
    sublistas_contienen_valor_aux(Sublista, Valor).

sublistas_contienen_valor_aux([], _) :- false.
sublistas_contienen_valor_aux([Valor|_], Valor) :- true.
sublistas_contienen_valor_aux([Sublista|Resto], Valor) :-
    sublistas_contienen_valor(Sublista, Valor);
    sublistas_contienen_valor_aux(Resto, Valor).

eliminar_elementos_iguales(Lista1, Lista2, Resultado) :-
    subtract(Lista1, Lista2, Resultado).

filtrar_por_subcadena(Lista, Subcadena, Resultado) :-
    findall(Sublista, (member(Sublista, Lista), contiene_subcadena(Subcadena, Sublista)), Resultado).

contiene_subcadena(Subcadena, Lista) :-
    member(Elemento, Lista),
    atomic(Elemento),
    atom_string(Elemento, Cadena),
    sub_string(Cadena, _, _, _, Subcadena).

member(Elemento, [Elemento|_]).
member(Elemento, [_|Resto]):-
    member(Elemento, Resto).

verdadero(Lista, []):-
	Lista = [].
    
filtrar_por_segundo_elemento([], []).
filtrar_por_segundo_elemento([Lista|Resto], [Lista|Resultado]) :-
    segunda_posicion_es_lista_dos_elementos(Lista),
    filtrar_por_segundo_elemento(Resto, Resultado).
filtrar_por_segundo_elemento([_|Resto], Resultado) :-
    filtrar_por_segundo_elemento(Resto, Resultado).

segunda_posicion_es_lista_dos_elementos([_, Segundo|_]) :-
    is_list(Segundo),
    length(Segundo, 2).

eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema):- 
    get_Carpetas(Sistema, Carpetas),
    member(Disco, Parametro_eliminar),
    filtro_lista_contiene_valor(Disco, Parametro_eliminar, Lista),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    get_papelera(Sistema, Papelera),
   	append(Papelera, Lista, Updated_Papelera),
    set_Papelera(Updated_Sistema_1, Updated_Papelera, Updated_Sistema).

eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    unir([Ruta1, Parametro_eliminar], Probar),
    filtrar_por_subcadena(Disco, Probar, Lista),
    \+ verdadero(Lista, []),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    get_papelera(Sistema, Papelera),
   	append(Papelera, Lista, Updated_Papelera),
    set_Papelera(Updated_Sistema_1, Updated_Papelera, Updated_Sistema).

eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema):-
    (iguales("*", Parametro_eliminar); iguales("*.*", Parametro_eliminar)),
    filtrar_por_segundo_elemento(Disco, Lista),
    get_Carpetas(Sistema, Carpetas),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    get_papelera(Sistema, Papelera),
   	append(Papelera, Lista, Updated_Papelera),
    set_Papelera(Updated_Sistema_1, Updated_Papelera, Updated_Sistema).

systemDel(Sistema, Parametro_eliminar, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema).