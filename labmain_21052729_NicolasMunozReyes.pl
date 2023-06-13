:- consult('TDAs_21052729_NicolasMunozReyes.pl').

%----------------------------- TDA system --------------------------------

% Metas Primarias: Función que permite crear la estructura del sistema ingresandole un nombre a este
% Metas secundarias: Las funciones empleadas para implementar esta función son la función Sistema y filesystem
% Dominio: Para esta función entra el nombre que se le quiere ingresar al sistema y entra el sistema creado
system(Nombre_system, Sistema):-
    tiempo(Nombre_system, Nombre),
    filesystem(Nombre, [], [], [], [], [], [], Sistema).

%----------------------------- TDA drive ----------------------------------

% Metas Primarias: Función que permite añadir una unidad (Drive) al sistema anteriormente creado
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_drive, verificar_elemento, drive, addDrive_to_Drive y set_Drives
% Dominio: Para esta función entra el sistema, la letra, el nombre y la capacidad de la unidad, ademas de el sistema actualizado
systemAddDrive(Sistema, Letra, Nombre, Capacidad, Updated_Sistema):-
    get_drives(Sistema, Drives),
    \+ verificar_elemento(Letra, Drives), 
    get_drives(Sistema, Drives_2),
    drive(Letra, Nombre, Capacidad, New_Drive),
    addDrive_to_Drives(New_Drive, Drives_2, Updated_Drive),
    set_Drives(Sistema, Updated_Drive, Updated_Sistema).

%----------------------------- TDA register -------------------------------------------------------------

% Metas Primarias: Función que permite añadir o dejar registrado un usuario en el sistema
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_user, verificar_elemento, user, adduser_to_user y set_user
% Dominio: Para esta función entra el sistema, el nombre del usuario a registrar y el sistema actualizado
systemRegister(Sistema, Nombre_user, Updated_Sistema):-
    get_user(Sistema, Usuarios),
    \+ verificar_elemento(Nombre_user, Usuarios),
    get_user(Sistema, Usuarios_2),
    user(Nombre_user, New_user),
    adduser_to_user(New_user, Usuarios_2, Updated_usuarios),
    set_user(Sistema, Updated_usuarios, Updated_Sistema).

%-------------------------------------- TDA login --------------------------------------

% Metas Primarias: Función que permite logear (iniciar sección) a un usuario que este registrado en el sistema
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_usuario, es_vacia_lista, get_user, verificar_elemento, adduser_to_usuario, set_usuario, get_drives, primer_elemento, ruta y set_ruta
% Dominio: Para esta función entra el sistema, el nombre del usuario que se quiere logear y el sistema actualizado
systemLogin(Sistema, User, Updated_Sistema):-
    get_usuario(Sistema, Usuario),
    es_vacia_lista(Usuario),
    get_user(Sistema, Usuarios),
    verificar_elemento(User, Usuarios),
    get_usuario(Sistema, Usuario_2),
    adduser_to_usuario(User, Usuario_2, Updated_Usuario),
    set_usuario(Sistema, Updated_Usuario, Updated_Sistema_1),
    get_drives(Sistema, Drives),
    primer_elemento(Drives, Drives_1),
    primer_elemento(Drives_1, Drives_2),
    unir([Drives_2, ":/"], Letra_2),
    ruta(Letra_2, Updated_Ruta),
    set_ruta(Updated_Sistema_1, Updated_Ruta, Updated_Sistema).
    
%-------------------------------------- TDA logout -----------------------------------------

% Metas Primarias: Función que permite hacer un logout (cerrar sección) en el sistema
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_usuario, es_vacia_lista, set_usuario y set_ruta
% Dominio: Para esta función entra el sistema y el sistema actualizado
systemLogout(Sistema, Updated_Sistema):-
    get_usuario(Sistema, Usuario),
    \+ es_vacia_lista(Usuario),
    set_usuario(Sistema, [], Updated_Sistema_1),
    set_ruta(Updated_Sistema_1, [], Updated_Sistema).

%-------------------------------------- TDA switchdrive -------------------------------------

% Metas Primarias: Función que permite cambiar la unidad (Drive) en la cual se este trabajando (Ruta)
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_usuario, es_vacia_lista, get_drives, verificar_elemento, unir, ruta, set_ruta
% Dominio: Para esta función entra el sistema, la letra de la unidad (Drive) a la que se quiere cambiar y el sistema actualizado
systemSwitchDrive(Sistema, Letra, Updated_Sistema):-
    get_usuario(Sistema, Usuario),
    \+ es_vacia_lista(Usuario),
    get_drives(Sistema, Drives),
    verificar_elemento(Letra, Drives),
    unir([Letra, ":/"], Letra_2),
    ruta(Letra_2, Updated_Ruta),
    set_ruta(Sistema, Updated_Ruta, Updated_Sistema).

%------------------------------- TDA systemmkdir ------------------------------------------

% Metas Primarias: Función que permite crear una carpeta con nombre unico en la ruta que se este trabajando
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_ruta, es_vacia_lista, primer_elemento, unir_ get,Carpetas, buscar_elemento:en_sublista_1, add_carpeta, get_usuario, tiempo, get_user_tocarpeta, adduser_to_carpeta, set_Carpeta, addruta_to_carpeta, set_Carpetas
% Dominio: Para esta función entra el sistema, el nombre de la carpeta y el sistema actualizado
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

%----------------------------- TDA systemcd --------------------------------------------------

% Metas Primarias: Función que permite ingresar o retrocer con respecto a la ruta en que se quiera trabajar
% Metas secundarias: Las funciones empleadas para implementar esta función son la función condición
% Dominio: Para esta función entra el sistema, el paramatro segun lo que se desee realizar y el sistema actualizado
systemCd(Sistema, Parametro, Updated_Sistema):-
    condicion(Sistema, Parametro, Updated_Sistema).

%------------------------------------ TDA systemAddFile --------------------------------------------

% Metas Primarias: Función que permite añadir un archivo al las carpetas y/o unidades del sistema
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_ruta, es_vacia_lista, primer_elemento, unir, get_Carpetas, buscar_elemento_en_sublista_1, add_carpeta, get_usuario, tiempo, get_user_tocarpeta, adduser_to_carpeta, set_Carpeta, get_contenido, addcontenido_to_carpeta, set_contenido, addruta_to_carpeta, set_Carpetas
% Dominio: Para esta función entra el sistema, el archivo a ingresar y el sistema actualizado
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

%----------------------------------- TDA systemDel ----------------------------------------------

% Metas Primarias: Función que permite eliminar archivos y/o  carpetas por nombre o por un parametro especifico
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_Carpetas, get_ruta, primer_elemento, filtrar_por elemento, eliminar
% Dominio: Para esta función entra el sistema, el paramtro para eliminar una carpeta y/o archivo y el sistema actualizado
systemDel(Sistema, Parametro_eliminar, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema).

%----------------------------------- TDA systemCopy ----------------------------------------------

% Metas Primarias: Función que permite copiar una carpeta y/o archivo desde un lugar de origen a una ruta especifica
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_Carpetas, get_ruta, primer_elemento, filtrar_por_subcadena, copiar y primer_elemento
% Dominio: Para esta función entra el sistema, la carpeta y/o archivo a copiar, la ruta especifica donde se va a copiar y el sistema actualizado
systemCopy(Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    copiar(Disco, Sistema, Carpeta_Archivo, Direccion, Lista),
    primer_elemento(Lista, Updated_Sistema).

%---------------------------------------- TDA systemMove --------------------------------------------------

% Metas Primarias: Función que permite mover una carpeta y/o archivo desde un lugar de origen a una ruta especifica
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_Carpetas, get_ruta, primer_elemento, filtrar_por_subcadena, move y primer_elemento
% Dominio: Para esta función entra el sistema, la carpeta y/o archivo a copiar, la ruta especifica donde se va a mover y el sistema actualizado
systemMove(Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    move(Disco, Sistema, Carpeta_Archivo, Direccion, Lista),
    primer_elemento(Lista, Updated_Sistema).

%------------------------------------ TDA systemRen -------------------------------------------------------------

% Metas Primarias: Función que permite cambiarle el nombre a una carpeta y/o archivo 
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_Carpetas, get_ruta, primer_elemento, filtrar_por_subcadena, ren y primer_elemento
% Dominio: Para esta función entra el sistema, el nombre original de la carpeta y/o archivo, el nombre nuevo y el sistema actualizado
systemRen(Sistema, Name, New_Name, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    ren(Disco, Sistema, Name, New_Name, Lista),
    primer_elemento(Lista, Updated_Sistema).

%-------------------------------------------- TDA systemDir ----------------------------------

% Metas Primarias: Función que muestra un string resultantes en concordancia con el parametro de entrada
% Metas secundarias: Las funciones empleadas para implementar esta función son la función dir
% Dominio: Para esta función entra el sistema, un parametro de entrada y el string resultante
systemDir(Sistema, Parametro, String):-
    dir(Sistema, Parametro, String).

%-------------------------------------------- TDA systemFormat ------------------------------------

% Metas Primarias: Función que permite formatear toda una unidad (drive)
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_drives, get_Carpetas, contiene_valor, primer_elemento, get_Nom, reemplazar_elemento, unir, filtrar_por_subcadena, eliminar_elementos_iguales, set_Drives, set_Carpetas
% Dominio: Para esta función entra el sistema, la letra de la unidad, el nuevo nombre de esta y el sistema actualizado
systemFormat(Sistema, Letra, Nombre, Updated_Sistema):-
    get_drives(Sistema, Drives),
    get_Carpetas(Sistema, Carpetas),
    contiene_valor(Drives, Letra, Lista),
    primer_elemento(Lista, Lista1),
    get_Nom(Lista1, Nom_ant),
    reemplazar(Lista1, Nom_ant, Nombre, Resultado),
    reemplazar(Drives, Lista1, Resultado, Resultado1),
    unir([Letra, ":/"], Probar),
    filtrar_por_subcadena(Carpetas, Probar, Disco),
    eliminar_elementos_iguales(Carpetas, Disco, Updated_carpeta),
    set_Drives(Sistema, Resultado1, Updated_Sistema1),
    set_Carpetas(Updated_Sistema1, Updated_carpeta, Updated_Sistema).

%----------------------------------------- TDA systemEncrypt ----------------------------------------

% Metas Primarias:
% Metas secundarias:
% Dominio:

%----------------------------------------- TDA systemDecrypt ----------------------------------------

% Metas Primarias:
% Metas secundarias:
% Dominio:

%----------------------------------------- TDA systemGrep ----------------------------------------

% Metas Primarias: Función que muestra las veces que una palabra se encuentra en el contendio de los archivos de una ruta o de un arhico especifico, ademas de la posición en la que se encuentra
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_Carpetas, get_ruta, primer_elemento, filtrar_por_subcadena y directorio
% Dominio: Para esta función entra el sistema, la palabra a buscar, el donde buscarla y el string con las veces que se repite y en que posición
systemGrep(Sistema, Palabra, Archivo, Strin):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, Disco),
    directorio(Disco, Sistema, Palabra, Archivo, Strin).

%----------------------------------------- TDA systemViewTrash --------------------------------------

% Metas Primarias: Función que muestra el contenido que se encuentra en la papelera 
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get_papelera
% Dominio: Para esta función entra el sistema, el string con lo que se encuentra en la papelera
systemViewTrash(Sistema, String):-
    get_papelera(Sistema, String).

%----------------------------------------- TDA systemRestore ----------------------------------------

% Metas Primarias: Función que permite restaurar segun un parametro cierta cantidad de cosas de la papelera
% Metas secundarias: Las funciones empleadas para implementar esta función son la función get,papelera, get_Carpetas, filtrar_por_subcadena, eliminar_elementos_iguales, set_papelera, append y set_Carpetas
% Dominio: Para esta función entra el sistema, el parametro de las cosas a restaurar y el sistema actualizado
systemRestore(Sistema, Parametro_agregar, Updated_Sistema):-
    get_papelera(Sistema, Papelera),
    get_Carpetas(Sistema, Carpetas),
    filtrar_por_subcadena(Papelera, Parametro_agregar, Disco),
    eliminar_elementos_iguales(Papelera, Disco, Updated_Papelera),
    set_Papelera(Sistema, Updated_Papelera, Updated_Sistema1),
    append(Carpetas, Disco, Updated_Carpetas),
    set_Carpetas(Updated_Sistema1, Updated_Carpetas, Updated_Sistema).

