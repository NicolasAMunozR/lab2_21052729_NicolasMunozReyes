%-------------------------------------- TDA switchdrive -------------------------------------

ruta(Letra, [Letra]).

set_ruta(Sistema, Updated_Ruta, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, Usuario, _, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Drives, Usuarios, Usuario, Updated_Ruta, Carpetas, Papelera, Updated_Sistema).

get_ruta(Sistema, Ruta):-
    nth0(4, Sistema, Ruta).

unir([], "").
unir([Cadena|Cadenas], Resultado):-
    unir(Cadenas, Resto),
    atom_concat(Cadena, Resto, Resultado).

confirmar(Sistema, Letra, Updated_Sistema):-
    get_drives(Sistema, Drives),
    verificar_letra(Letra, Drives)->
    unir([Letra, ":/"], Letra_2),
    ruta(Letra_2, Updated_Ruta),
    set_ruta(Sistema, Updated_Ruta, Updated_Sistema)
    ;
    get_ruta(Sistema, Ruta),
    set_ruta(Sistema, Ruta, Updated_Sistema).

systemSwitchDrive(Sistema, Letra, Updated_Sistema):-
    get_usuario(Sistema, Usuario),
    es_vacia_lista(Usuario)->
    get_ruta(Sistema, Ruta),
    set_ruta(Sistema, Ruta, Updated_Sistema)
    ;
    confirmar(Sistema, Letra, Updated_Sistema).