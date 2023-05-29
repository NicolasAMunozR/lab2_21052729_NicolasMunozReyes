%----------------------------- TDA system --------------------------------

filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, Papelera, [Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, Papelera]).

sistema(Nombre, [Nombre, Tiempo]):- 
    get_time(Tiempo).

system(Nombre_system, Sistema):-
    sistema(Nombre_system, Nombre),
    filesystem(Nombre, [], [], [], [], [], [], Sistema).

