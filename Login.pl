%-------------------------------------- TDA login --------------------------------------

usuario(User, User).

adduser_to_usuario(New_usuario, Usuario, Updated_Usuario):-
    append(Usuario, [New_usuario], Updated_Usuario).

set_usuario(Sistema, Updated_Usuario, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, _, Ruta, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Drives, Usuarios, Updated_Usuario, Ruta, Carpetas, Papelera, Updated_Sistema). 

get_usuario(Sistema, Usuario):-
    nth0(3, Sistema, Usuario).

get_usuario_2(Sistema, Usuario_2):-
    nth0(3, Sistema, Usuario_2).

es_vacia_lista(Usuario):-
    length(Usuario, 0).

agregar(Sistema, User, Updated_Sistema):-
    get_user(Sistema, Usuarios),
    verificar_nombre(User, Usuarios)->
    get_usuario_2(Sistema, Usuario_2),
    usuario(User, New_usuario),
    adduser_to_usuario(New_usuario, Usuario_2, Updated_Usuario),
    set_usuario(Sistema, Updated_Usuario, Updated_Sistema)
    ;
    get_usuario(Sistema, Usuario),
    set_usuario(Sistema, Usuario, Updated_Sistema).

systemLogin(Sistema, User, Updated_Sistema):-
    get_usuario(Sistema, Usuario),
    es_vacia_lista(Usuario)-> 
    agregar(Sistema, User, Updated_Sistema)
    ;
    get_usuario(Sistema, Usuario),
    set_usuario(Sistema, Usuario, Updated_Sistema).