%-------------------------------------- TDA logout -----------------------------------------

systemLogout(Sistema, Updated_Sistema):-
    get_usuario(Sistema, Usuario),
    \+ es_vacia_lista(Usuario),
    set_usuario(Sistema, [], Updated_Sistema_1),
    set_ruta(Updated_Sistema_1, [], Updated_Sistema).
