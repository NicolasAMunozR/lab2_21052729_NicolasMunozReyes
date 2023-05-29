%----------------------------- TDA register -------------------------------------------------------------

user(Nombre_user, [Nombre_user]).

adduser_to_user(New_user, Usuarios, Updated_usuarios):-
    append(Usuarios, [New_user], Updated_usuarios).

set_user(Sistema, Updated_usuarios, Updated_Sistema):-
    filesystem(Nombre, Drives, _, Usuario, Ruta, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Drives, Updated_usuarios, Usuario, Ruta, Carpetas, Papelera, Updated_Sistema).     

get_user(Sistema, Usuarios):-
    nth0(2, Sistema, Usuarios).  

get_nombre(Elemento, Posicion):-
    nth0(0, Elemento, Posicion).

get_user_2(Sistema, Usuarios_2):-
    nth0(2, Sistema, Usuarios_2).

verificar_nombre(Nombre_user, Elemento):-
    get_nombre(Elemento, Posicion),
    member(Nombre_user, Posicion).

verificar_nombre(Nombre_user, [_|Resto]):-
    verificar_nombre(Nombre_user, Resto).

systemRegister(Sistema, Nombre_user, Updated_Sistema):-
    get_user(Sistema, Usuarios),
    verificar_nombre(Nombre_user, Usuarios)-> 
    get_user(Sistema, Usuarios),
    set_user(Sistema, Usuarios, Updated_Sistema)
    ;
    get_user_2(Sistema, Usuarios_2),
    user(Nombre_user, New_user),
    adduser_to_user(New_user, Usuarios_2, Updated_usuarios),
    set_user(Sistema, Updated_usuarios, Updated_Sistema).