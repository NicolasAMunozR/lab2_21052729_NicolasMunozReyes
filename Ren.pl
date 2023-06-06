%------------------------------------ TDA systemRen -------------------------------------------------------------

reemplazar_elemento([], _, _, []).
reemplazar_elemento([X|Xs], Elemento, NuevoElemento, [NuevoElemento|Ys]) :-
    X = Elemento, 
    reemplazar_elemento(Xs, Elemento, NuevoElemento, Ys).
reemplazar_elemento([X|Xs], Elemento, NuevoElemento, [X|Ys]) :-
    X \= Elemento, 
    reemplazar_elemento(Xs, Elemento, NuevoElemento, Ys).

modificar_nombre([], [], _, _).
modificar_nombre([X|Xs], [Y|Ys], New_Name, Sistema) :-
    modificar_elementos(X, Y, New_Name, Sistema),
    modificar_nombre(Xs, Ys, New_Name, Sistema).

modificar_elementos(Elemento, Modificado, New_Name, Sistema) :-
    funcion_modificar_Nombre(Elemento, Modificado, New_Name, Sistema).

get_dir(Elemento, Modificado):-
    nth0(0, Elemento, Modificar).

funcion_modificar_Nombre(Elemento, Modificado, New_Name, Sistema) :-
    get_segundo(Elemento, Modificado1),
    primer_elemento(Modificado1, Nombre),
    reemplazar_elemento(Modificado1, Nombre, New_Name, Resultado),
    get_dir(Elemento, Modificado3),
    get_tercero(Elemento, Modificado2),
    add_carpeta(Modificado3, Carpeta_creada),
    get_Carpetas(Sistema, Carpetas),
    get_usuario(Sistema, Usuario),
    primer_elemento(Usuario, User_to),
    tiempo(User_to, User_tiempo),
    get_user_tocarpeta(Carpeta_creada, Usuario_de_carpeta),   
    adduser_to_carpeta(User_tiempo, Usuario_de_carpeta, Updated_carpeta),
    set_Carpeta(Carpeta_creada, Updated_carpeta, Creada_carpeta),
    get_contenido(Carpeta_creada, Contenido_carpeta),
    addcontenido_to_carpeta(Resultado, Contenido_carpeta, Updated_Contenido),
    set_contenido(Creada_carpeta, Updated_Contenido, Creada_carpeta_1),
    get_Seguridad(Carpeta_creada, Seguridad_Carpeta),
    addseguridad_to_carpeta(Modificado2, Seguridad_Carpeta, Updated_Seguridad),
    set_seguridad(Creada_carpeta_1, Updated_Seguridad, Creada_carpeta_2),
    addruta_to_carpeta(Creada_carpeta_2, Carpetas, Updated_Carpetas),
    set_Carpetas(Sistema, Updated_Carpetas, Modificado).

ren(Disco, Sistema, Name, New_Name, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    filtro_lista_contiene_valor(Disco, New_Name, Lista1),
    filtro_lista_contiene_valor(Disco, Name, Lista),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    modificar_nombre(Lista, Updated_Sistema, New_Name, Updated_Sistema_1).

ren(Disco, Sistema, Name, New_Name, Updated_Sistema):-


systemRen(Sistema, Name, New_Name, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    ren(Disco, Sistema, Name, New_Name, Updated_Sistema).