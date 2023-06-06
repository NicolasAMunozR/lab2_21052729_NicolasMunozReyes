%---------------------------------------- TDA systemMove --------------------------------------------------

move(Disco, Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    filtro_lista_contiene_valor(Disco, Carpeta_Archivo, Lista),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    modificar_lista(Lista, Updated_Sistema, Direccion, Updated_Sistema_1).

systemMove(Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    move(Disco, Sistema, Carpeta_Archivo, Direccion, Updated_Sistema).