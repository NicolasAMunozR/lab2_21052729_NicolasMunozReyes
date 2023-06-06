%------------------------------- TDA systemmkdir ------------------------------------------

set_Carpetas(Sistema, Updated_Carpetas, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, _, Papelera, Sistema),
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Updated_Carpetas, Papelera, Updated_Sistema).

get_Carpetas(Sistema, Carpetas):-
    nth0(5, Sistema, Carpetas).

primer_elemento([Cabeza | _], Cabeza).

buscar_elemento_en_sublista_1(Elemento, [Sublista|_]) :-
    is_list(Sublista),
    buscar_elemento_en_sublista_1(Elemento, Sublista).
buscar_elemento_en_sublista_1(Elemento, [Elemento|_]).
buscar_elemento_en_sublista_1(Elemento, [_|Resto]) :-
    buscar_elemento_en_sublista_1(Elemento, Resto).

filecarpeta(Ruta, Contenido, Seguridad, Usuario, [Ruta, Contenido, Seguridad, Usuario]).

tiempo(Ruta, [Ruta, Tiempo]):- 
    get_time(Tiempo).

add_carpeta(Ruta, Updated_Carpetas):-
    filecarpeta(Ruta, [], [], [], Updated_Carpetas).

addruta_to_carpeta(Carpeta, Carpetas, Updated_Carpetas):-
    append(Carpetas, [Carpeta], Updated_Carpetas).

set_Carpeta(Carpeta, User_Car, Updated_carpeta):-
    filecarpeta(Ruta, Contenido, Seguridad, _, Carpeta),
    filecarpeta(Ruta, Contenido, Seguridad, User_Car, Updated_carpeta).

get_user_tocarpeta(Carpetas, Usuario):-
    nth0(3, Carpetas, Usuario).

adduser_to_carpeta(New_usuario, Usuario, Updated_Usuario):-
    append(Usuario, New_usuario, Updated_Usuario).

systemMkdir(Sistema, Name, Updated_Sistema):-
    get_ruta(Sistema, Ruta),
    \+ es_vacia_lista(Ruta),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Name, "/"], Probar),
    get_Carpetas(Sistema, Carpetas),
    \+ buscar_elemento_en_sublista_1(Probar, Carpetas),
    get_ruta(Sistema, Ruta),
    get_Carpetas(Sistema, Carpetas),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Name, "/"], Probar),
    add_carpeta(Probar, Carpeta_creada),
    get_usuario(Sistema, Usuario),
    primer_elemento(Usuario, User_to),
    tiempo(User_to, User_tiempo),
    get_user_tocarpeta(Carpeta_creada, Usuario_de_carpeta),   
    adduser_to_carpeta(User_tiempo, Usuario_de_carpeta, Updated_carpeta),
    set_Carpeta(Carpeta_creada, Updated_carpeta, Creada_carpeta),
    addruta_to_carpeta(Creada_carpeta, Carpetas, Updated_Carpetas),
    set_Carpetas(Sistema, Updated_Carpetas, Updated_Sistema).