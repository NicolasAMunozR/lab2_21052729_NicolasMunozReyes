%-------------------------------------------- TDA systemFormat ------------------------------------

get_Nom(Lista, Nombre):-
    nth0(1, Lista, Nombre).

systemFormat(Sistema, Letra, Nombre, Updated_Sistema):-
    get_drives(Sistema, Drives),
    get_Carpetas(Sistema, Carpetas),
    filtro_lista_contiene_valor(Drives, Letra, Lista),
    primer_elemento(Lista, Lista1),
    get_Nom(Lista1, Nom_ant),
    reemplazar_elemento(Lista1, Nom_ant, Nombre, Resultado),
    reemplazar_elemento(Drives, Lista1, Resultado, Resultado1), 
    unir([Letra, ":/"], Probar),
    filtrar_por_subcadena(Carpetas, Probar, Disco),
    eliminar_elementos_iguales(Carpetas, Disco, Updated_carpeta),
    set_Drives(Sistema, Resultado1, Updated_Sistema1),
    set_Carpetas(Updated_Sistema1, Updated_carpeta, Updated_Sistema).