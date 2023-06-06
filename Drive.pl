%----------------------------- TDA drive ----------------------------------

drive(Letra, Nombre, Capacidad, [Letra, Nombre, Capacidad]).

addDrive_to_Drives(New_Drive, Drives, Updated_Drive):-
    append(Drives, [New_Drive], Updated_Drive).

set_Drives(Sistema, Updated_Drive, Updated_Sistema):-
    filesystem(Nombre, _, Usuarios, Usuario, Ruta, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Updated_Drive, Usuarios, Usuario, Ruta, Carpetas, Papelera, Updated_Sistema).     

get_drives(Sistema, Drives):-
    nth0(1, Sistema, Drives).  

get_letra(Elemento, Posicion):-
    nth0(0, Elemento, Posicion).

get_drives_2(Sistema, Drives_2):-
    nth0(1, Sistema, Drives_2).

verificar_letra(Letra, Elemento):-
    get_letra(Elemento, Posicion),
    member(Letra, Posicion).

verificar_letra(Letra, [_|Resto]):-
    verificar_letra(Letra, Resto).

systemAddDrive(Sistema, Letra, Nombre, Capacidad, Updated_Sistema):-
    get_drives(Sistema, Drives),
    \+ verificar_letra(Letra, Drives), 
    get_drives_2(Sistema, Drives_2),
    drive(Letra, Nombre, Capacidad, New_Drive),
    addDrive_to_Drives(New_Drive, Drives_2, Updated_Drive),
    set_Drives(Sistema, Updated_Drive, Updated_Sistema).

