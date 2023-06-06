%------------------------------------ TDA systemAddFile --------------------------------------------

files(Nombre_Archivo, Contenido, [Nombre_Archivo, Contenido]).

file(Nombre_Archivo, Contenido, Archivo):-
    files(Nombre_Archivo, Contenido, Archivo).

get_contenido(Carpeta_creada, Contenido_carpeta):-
    nth0(1, Carpeta_creada, Contenido_carpeta).

addcontenido_to_carpeta(New_contenido, Contenido, Updated_Contenido):-
    append(Contenido, New_contenido, Updated_Contenido).

set_contenido(Carpeta, Contenido_Car, Updated_carpeta):-
    filecarpeta(Ruta, _, Seguridad, Usuario, Carpeta),
    filecarpeta(Ruta, Contenido_Car, Seguridad, Usuario, Updated_carpeta).

systemAddFile(Sistema, Archivo, Updated_Sistema):-
    get_ruta(Sistema, Ruta),
    \+ es_vacia_lista(Ruta),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    primer_elemento(Archivo, Nombre_Archivo),
    unir([Ruta_1, Nombre_Archivo], Probar),
    get_Carpetas(Sistema, Carpetas),
    \+ buscar_elemento_en_sublista_1(Probar, Carpetas),
    get_ruta(Sistema, Ruta),
    get_Carpetas(Sistema, Carpetas),
	primer_elemento(Ruta, Ruta_1),
    add_carpeta(Ruta_1, Carpeta_creada),
    get_usuario(Sistema, Usuario),
    primer_elemento(Usuario, User_to),
    tiempo(User_to, User_tiempo),
    get_user_tocarpeta(Carpeta_creada, Usuario_de_carpeta),   
    adduser_to_carpeta(User_tiempo, Usuario_de_carpeta, Updated_carpeta),
    set_Carpeta(Carpeta_creada, Updated_carpeta, Creada_carpeta),
    get_contenido(Carpeta_creada, Contenido_carpeta),
    addcontenido_to_carpeta(Archivo, Contenido_carpeta, Updated_Contenido),
    set_contenido(Creada_carpeta, Updated_Contenido, Creada_carpeta_1),
    addruta_to_carpeta(Creada_carpeta_1, Carpetas, Updated_Carpetas),
    set_Carpetas(Sistema, Updated_Carpetas, Updated_Sistema).