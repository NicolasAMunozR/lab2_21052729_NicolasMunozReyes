%----------------------------------- TDA systemCopy ----------------------------------------------

get_segundo(Elemento, Modificado):-
    nth0(1, Elemento , Modificado).

get_tercero(Elemento, Modificado):-
    nth0(2, Elemento , Modificado).

modificar_lista([], [], _, _).
modificar_lista([X|Xs], [Y|Ys], Dir, Sistema) :-
    modificar_elemento(X, Y, Dir, Sistema),
    modificar_lista(Xs, Ys, Dir, Sistema).

modificar_elemento(Elemento, Modificado, Dir, Sistema) :-
    funcion_modificar(Elemento, Modificado, Dir, Sistema).

addseguridad_to_carpeta(New_Seguridad, Seguridad, Updated_Seguridad):-
    append(Seguridad, New_Seguridad, Updated_Seguridad).

set_seguridad(Carpeta, Seguridad_Car, Updated_carpeta):-
    filecarpeta(Ruta, Contenido, _, Usuario, Carpeta),
    filecarpeta(Ruta, Contenido, Seguridad_Car, Usuario, Updated_carpeta).

get_Seguridad(Carpeta_creada, Seguridad_carpeta):-
    nth0(2, Carpeta_creada, Seguridad_carpeta).

funcion_modificar(Elemento, Modificado, Dir, Sistema) :-
    get_segundo(Elemento, Modificado1),
    get_tercero(Elemento, Modificado2),
    add_carpeta(Dir, Carpeta_creada),
    get_Carpetas(Sistema, Carpetas),
    get_usuario(Sistema, Usuario),
    primer_elemento(Usuario, User_to),
    tiempo(User_to, User_tiempo),
    get_user_tocarpeta(Carpeta_creada, Usuario_de_carpeta),   
    adduser_to_carpeta(User_tiempo, Usuario_de_carpeta, Updated_carpeta),
    set_Carpeta(Carpeta_creada, Updated_carpeta, Creada_carpeta),
    get_contenido(Carpeta_creada, Contenido_carpeta),
    addcontenido_to_carpeta(Modificado1, Contenido_carpeta, Updated_Contenido),
    set_contenido(Creada_carpeta, Updated_Contenido, Creada_carpeta_1),
    get_Seguridad(Carpeta_creada, Seguridad_Carpeta),
    addseguridad_to_carpeta(Modificado2, Seguridad_Carpeta, Updated_Seguridad),
    set_seguridad(Creada_carpeta_1, Updated_Seguridad, Creada_carpeta_2),
    addruta_to_carpeta(Creada_carpeta_2, Carpetas, Updated_Carpetas),
    set_Carpetas(Sistema, Updated_Carpetas, Modificado).

copiar(Disco, Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    filtro_lista_contiene_valor(Disco, Carpeta_Archivo, Lista),
    modificar_lista(Lista, Updated_Sistema, Direccion, Sistema).

systemCopy(Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    copiar(Disco, Sistema, Carpeta_Archivo, Direccion, Updated_Sistema).