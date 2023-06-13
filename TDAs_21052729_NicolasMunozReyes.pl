%----------------------------- TDA system --------------------------------

% Hecho: Estructura del sistema a crear
filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, Papelera, [Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, Papelera]).

% Función que ayuda a ingresar un elemento junto a la fecha de creación de esta 
tiempo(Elemento, [Elemento, Tiempo]):- 
    get_time(Tiempo).

%----------------------------- TDA drive ----------------------------------

% Hecho: estructura que tendran los las unidades (Drives) que se añadiran
drive(Letra, Nombre, Capacidad, [Letra, Nombre, Capacidad]).

% Función que ayuda a añadir las nuevas unidades (Drives)
addDrive_to_Drives(New_Drive, Drives, Updated_Drive):-
    append(Drives, [New_Drive], Updated_Drive).

% Función que ayuda a añadir las unidades (Drives) al sistema
set_Drives(Sistema, Updated_Drive, Updated_Sistema):-
    filesystem(Nombre, _, Usuarios, Usuario, Ruta, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Updated_Drive, Usuarios, Usuario, Ruta, Carpetas, Papelera, Updated_Sistema).     

% Función que ayuda a tomar el segundo elemento de la estructura del sistema 
get_drives(Sistema, Drives):-
    nth0(1, Sistema, Drives).  

% Función que ayuda a tomar el primer elemento 
get_elemento(Elemento, Posicion):-
    nth0(0, Elemento, Posicion).

% Función que ayuda a verificar si es que se encuentra algun elemento en el sistema
verificar_elemento(Letra, Elemento):-   
    get_elemento(Elemento, Posicion),
    member(Letra, Posicion).
verificar_elemento(Letra, [_|Resto]):-
    verificar_elemento(Letra, Resto).

%----------------------------- TDA register -------------------------------------------------------------

% Hecho: estructura que tendran los nuevos usuarios registrados
user(Nombre_user, [Nombre_user]).

% Función que ayuda a añadir los nuevos usuarios
adduser_to_user(New_user, Usuarios, Updated_usuarios):-
    append(Usuarios, [New_user], Updated_usuarios).

% Función que ayuda a añadir los usuarios al sistema 
set_user(Sistema, Updated_usuarios, Updated_Sistema):-
    filesystem(Nombre, Drives, _, Usuario, Ruta, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Drives, Updated_usuarios, Usuario, Ruta, Carpetas, Papelera, Updated_Sistema).     

% Función que ayuda a tomar el tercer elemento de la estructura del sistema 
get_user(Sistema, Usuarios):-
    nth0(2, Sistema, Usuarios).  

%-------------------------------------- TDA login --------------------------------------

% Función que ayuda a añadir el usuario logeado
adduser_to_usuario(New_usuario, Usuario, Updated_Usuario):-
    append(Usuario, [New_usuario], Updated_Usuario).

% Función que ayuda a ingresar el usuario logeado al sistema
set_usuario(Sistema, Updated_Usuario, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, _, Ruta, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Drives, Usuarios, Updated_Usuario, Ruta, Carpetas, Papelera, Updated_Sistema). 

% Función que ayuda a tomar el cuarto elemento de la estructura del sistema
get_usuario(Sistema, Usuario):-
    nth0(3, Sistema, Usuario).

% Función que ayuda a verificar si una lista esta vacia
es_vacia_lista(Usuario):-
    length(Usuario, 0).
    
%-------------------------------------- TDA logout -----------------------------------------

%-------------------------------------- TDA switchdrive -------------------------------------

% Hechos: estructura que tendra la ruta actual del sistema
ruta(Letra, [Letra]).

% Función que ayuda a añadir la nueva ruta al sistema
set_ruta(Sistema, Updated_Ruta, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, Usuario, _, Carpetas, Papelera, Sistema),
    filesystem(Nombre, Drives, Usuarios, Usuario, Updated_Ruta, Carpetas, Papelera, Updated_Sistema).

% Función que ayuda a tomar el quinto elemento de la estructura del sistema
get_ruta(Sistema, Ruta):-
    nth0(4, Sistema, Ruta).

% Función que ayuda a unir string 
unir([], "").
unir([Cadena|Cadenas], Resultado):-
    unir(Cadenas, Resto),
    atom_concat(Cadena, Resto, Resultado).

%------------------------------- TDA systemmkdir ------------------------------------------

% Función que ayuda a añadir las nuevas carpetas al sistema 
set_Carpetas(Sistema, Updated_Carpetas, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, _, Papelera, Sistema),
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Updated_Carpetas, Papelera, Updated_Sistema).

% Función que ayuda a tomar el sexto elemento de la estructura del sistema
get_Carpetas(Sistema, Carpetas):-
    nth0(5, Sistema, Carpetas).

% Funcioón que ayuda a tomar el primer elemento de una lista
primer_elemento([Cabeza | _], Cabeza).

% Función que ayuda a buscar un elemento en una sublista
buscar_elemento_en_sublista_1(Elemento, [Sublista|_]) :-
    is_list(Sublista),
    buscar_elemento_en_sublista_1(Elemento, Sublista).
buscar_elemento_en_sublista_1(Elemento, [Elemento|_]).
buscar_elemento_en_sublista_1(Elemento, [_|Resto]) :-
    buscar_elemento_en_sublista_1(Elemento, Resto).

% Hecho: estructura que tendran las carpetas del sistema
filecarpeta(Ruta, Contenido, Seguridad, Usuario, [Ruta, Contenido, Seguridad, Usuario]).

% Función que ayuda a añadir una carpeta nueva
add_carpeta(Ruta, Updated_Carpetas):-
    filecarpeta(Ruta, [], [], [], Updated_Carpetas).

% Función que ayuda a añadir la ruta actual a la carpeta creada
addruta_to_carpeta(Carpeta, Carpetas, Updated_Carpetas):-
    append(Carpetas, [Carpeta], Updated_Carpetas).

% Función que ayuda a añadir una nueva carpeta al sistema
set_Carpeta(Carpeta, User_Car, Updated_carpeta):-
    filecarpeta(Ruta, Contenido, Seguridad, _, Carpeta),
    filecarpeta(Ruta, Contenido, Seguridad, User_Car, Updated_carpeta).

% Función que ayuda a tomar el usuario logeado
get_user_tocarpeta(Carpetas, Usuario):-
    nth0(3, Carpetas, Usuario).

% Función que ayuda a añadir el usuario logeado en la carpeta creada
adduser_to_carpeta(New_usuario, Usuario, Updated_Usuario):-
    append(Usuario, New_usuario, Updated_Usuario).

%----------------------------- TDA systemcd --------------------------------------------------

% Función que ayuda a eliminar los ultimos elementos de una lista
eliminar_ultimos(N, Lista, Eliminados):-
    length(Lista, Longitud),
    Longitud >= N,
    LongitudFinal is Longitud - N,
    eliminar_ultimos_1(N, Lista, LongitudFinal, [], Reversa),
    reverse(Reversa, Eliminados).
eliminar_ultimos_1(_, _, 0, Eliminados, Eliminados):- !.
eliminar_ultimos_1(N, [Elemento|Resto], LongitudFinal, Acumulador, Eliminados):-
    LongitudActual is LongitudFinal - 1,
    eliminar_ultimos_1(N, Resto, LongitudActual, [Elemento|Acumulador], Eliminados).

% Función que ayuda a dividir un string segun un separador
dividir_string(String, Separador, Subcadenas):-
    split_string(String, Separador, "", Subcadenas).

% Función que ayuda a unir elementos segun un parametro
unir_elementos(Lista, Caracter, Resultado):-
    atomic_list_concat(Lista, Caracter, Resultado).

% Función que ayuda a ver si dos elementos son iguales
iguales(Palabra1, Palabra2):-
    Palabra1 == Palabra2.

% Función que ayuda tomar los ultimos elementos de una lista 
ultimos(N, Lista, Resultado):-
    length(Lista, Longitud),
    Longitud >= N,
    LongitudFinal is Longitud - N,
    ultimos(N, Lista, LongitudFinal, Resultado).
ultimos(_, Resultado, 0, Resultado):- !.
ultimos(N, [_|Resto], LongitudFinal, Resultado):-
    LongitudActual is LongitudFinal - 1,
    ultimos(N, Resto, LongitudActual, Resultado).

% Función que ayuda a trabajar todas las condiciones quue tiene el cd
condicion(Sistema, Parametro, Updated_Sistema):-
    dividir_string(Parametro, "/", Lista),
    ultimos(1, Lista, New),
    primer_elemento(New, Ruta_2),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Ruta_2, "/"], Probar),
    get_Carpetas(Sistema, Carpetas),
    primer_elemento(Lista, Confirmar),
    (iguales(".", Confirmar), buscar_elemento_en_sublista_1(Probar, Carpetas)),
    dividir_string(Parametro, "/", Lista),
    ultimos(1, Lista, New),
    primer_elemento(New, Ruta_2),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Ruta_2, "/"], Probar),
    ruta(Probar, Probar_1),
    set_ruta(Sistema, Probar_1, Updated_Sistema).
condicion(Sistema, Parametro, Updated_Sistema):-
    iguales("/", Parametro),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    dividir_string(Ruta_1, "/", Lista),
    primer_elemento(Lista, Ruta_2),
    unir([Ruta_2, "/"], New_lista),
    ruta(New_lista, Probar),
    set_ruta(Sistema, Probar, Updated_Sistema).
condicion(Sistema, Parametro, Updated_Sistema):-
    iguales("..", Parametro),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    dividir_string(Ruta_1, "/", Lista),
    eliminar_ultimos(2, Lista, New_lista),
    unir_elementos(New_lista, "/", New_lista_2),
    unir([New_lista_2, "/"], New_lista_3),
    ruta(New_lista_3, Probar_1),
    set_ruta(Sistema, Probar_1, Updated_Sistema).
condicion(Sistema, Parametro, Updated_Sistema):-
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir(["../", Ruta_1], Prueba),
    unir([Parametro], Parametro_1),
    iguales(Prueba, Parametro_1),
    get_ruta(Sistema, Ruta),
    set_ruta(Sistema, Ruta, Updated_Sistema).
condicion(Sistema, Parametro, Updated_Sistema):-
    (iguales("./", Parametro); iguales("././././", Parametro); iguales(".", Parametro)),
    get_ruta(Sistema, Ruta),
    set_ruta(Sistema, Ruta, Updated_Sistema).
condicion(Sistema, Parametro, Updated_Sistema):-
    get_ruta(Sistema, Ruta),
    get_Carpetas(Sistema, Carpetas),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Parametro, "/"], Probar),
    buscar_elemento_en_sublista_1(Probar, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta_1),
    unir([Ruta_1, Parametro, "/"], Probar),
    ruta(Probar, Probar_1),
    set_ruta(Sistema, Probar_1, Updated_Sistema).

%------------------------------------ TDA systemAddFile --------------------------------------------

% Hecho: estructuta de los archivos que se quieren ingresar
files(Nombre_Archivo, Contenido, [Nombre_Archivo, Contenido]).

% Función que crea el archivo que se quiere ingresar
file(Nombre_Archivo, Contenido, Archivo):-
    files(Nombre_Archivo, Contenido, Archivo).

% Función que toma el segundo elemento de las carpeta
get_contenido(Carpeta_creada, Contenido_carpeta):-
    nth0(1, Carpeta_creada, Contenido_carpeta).

% Función que ayuda a añadir un nuevo contenido (archivos) 
addcontenido_to_carpeta(New_contenido, Contenido, Updated_Contenido):-
    append(Contenido, New_contenido, Updated_Contenido).

% Función que ayuda a añadir el contenido a las carpetas 
set_contenido(Carpeta, Contenido_Car, Updated_carpeta):-
    filecarpeta(Ruta, _, Seguridad, Usuario, Carpeta),
    filecarpeta(Ruta, Contenido_Car, Seguridad, Usuario, Updated_carpeta).

%------------------------------------ TDA systemDel --------------------------------------------

% Función que ayuda a revisar si es que una carpeta contiene cierto elemmento y entrega este o estos elementos
contiene_valor([], _, []).
contiene_valor([Lista|Listas], Valor, [Lista|Resto]) :-
    sublistas_contienen(Lista, Valor),
    contiene_valor(Listas, Valor, Resto).
contiene_valor([_|Listas], Valor, Resultado) :-
    contiene_valor(Listas, Valor, Resultado).

% Función que ayuda a añadir un nuevo elemento a la papelera
addPape_to_Pape(New_pape, Papelera, Updated_Papelera):-
    append(Papelera, [New_pape], Updated_Papelera).

% Función que ayuda a añadir la papelera al sistema 
set_Papelera(Sistema, Updated_Papelera, Updated_Sistema):-
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, _, Sistema),
    filesystem(Nombre, Drives, Usuarios, Usuario, Ruta, Carpetas, Updated_Papelera, Updated_Sistema). 

% Función que toma el septimo elemento del sistema
get_papelera(Sistema, Papelera):-
    nth0(6, Sistema, Papelera).

% Función que ayuda a revisar si es que una sublista contiene cierto elemmento y entrega este o estos elementos
sublistas_contienen(Sublista, Valor) :-
    valor_aux(Sublista, Valor).
valor_aux([], _) :- false.
valor_aux([Valor|_], Valor) :- true.
valor_aux([Sublista|Resto], Valor) :-
    sublistas_contienen(Sublista, Valor);
    valor_aux(Resto, Valor).

% Función que ayuda a elimnar elementos de una lista
eliminar_elementos_iguales(Lista1, Lista2, Resultado) :-
    subtract(Lista1, Lista2, Resultado).

% Función que ayuda a filtar elementos contenidos en una sublista
filtrar_por_subcadena(Lista, Subcadena, Resultado) :-
    findall(Sublista, (member(Sublista, Lista), contiene_subcadena(Subcadena, Sublista)), Resultado).
contiene_subcadena(Subcadena, Lista) :-
    member(Elemento, Lista),
    atomic(Elemento),
    atom_string(Elemento, Cadena),
    sub_string(Cadena, _, _, _, Subcadena).
member(Elemento, [Elemento|_]).
member(Elemento, [_|Resto]):-
    member(Elemento, Resto).

% Función que verifica si la lista esta vacia
verdadero(Lista, []):-
	Lista = [].

% Función que ayuda a filtar elementos contenidos en una lista
filtrar([], []).
filtrar([Lista|Resto], [Lista|Resultado]) :-
    segunda_posicion(Lista),
    filtrar(Resto, Resultado).
filtrar([_|Resto], Resultado) :-
    filtrar(Resto, Resultado).
segunda_posicion([_, Segundo|_]) :-
    is_list(Segundo),
    length(Segundo, 2).

% Funcón que ayuda a trabajar las condicones para ejecutar el del
eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema):- 
    get_Carpetas(Sistema, Carpetas),
    contiene_valor(Disco, Parametro_eliminar, Lista),
    \+ verdadero(Lista, []),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    get_papelera(Sistema, Papelera),
   	append(Papelera, Lista, Updated_Papelera),
    set_Papelera(Updated_Sistema_1, Updated_Papelera, Updated_Sistema).
eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    unir([Ruta1, Parametro_eliminar], Probar),
    filtrar_por_subcadena(Disco, Probar, Lista),
    \+ verdadero(Lista, []),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    get_papelera(Sistema, Papelera),
   	append(Papelera, Lista, Updated_Papelera),
    set_Papelera(Updated_Sistema_1, Updated_Papelera, Updated_Sistema).
eliminar(Disco, Sistema, Parametro_eliminar, Updated_Sistema):-
    (iguales("*", Parametro_eliminar); iguales("*.*", Parametro_eliminar)),
    filtrar(Disco, Lista),
    get_Carpetas(Sistema, Carpetas),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    get_papelera(Sistema, Papelera),
   	append(Papelera, Lista, Updated_Papelera),
    set_Papelera(Updated_Sistema_1, Updated_Papelera, Updated_Sistema).

%----------------------------------- TDA systemCopy ----------------------------------------------

% Función que toma el segundo elemento de una lista
get_segundo(Elemento, Modificado):-
    nth0(1, Elemento , Modificado).

% Función que toma el tercer elemento de una lista
get_tercero(Elemento, Modificado):-
    nth0(2, Elemento , Modificado).

% Función que ayuda a modificar los elementos interiores de una listas de listas
modificar_lista([], [], _, _).
modificar_lista([X|Xs], [Y|Ys], Dir, Sistema) :-
    modificar_elemento(X, Y, Dir, Sistema),
    modificar_lista(Xs, Ys, Dir, Sistema).
modificar_elemento(Elemento, Modificado, Dir, Sistema) :-
    funcion_modificar(Elemento, Modificado, Dir, Sistema).

% Función que ayuda a añadir una nueva seguridad
addseguridad_to_carpeta(New_Seguridad, Seguridad, Updated_Seguridad):-
    append(Seguridad, New_Seguridad, Updated_Seguridad).

% Función que ayuda a añadir la seguridad a una carpeta
set_seguridad(Carpeta, Seguridad_Car, Updated_carpeta):-
    filecarpeta(Ruta, Contenido, _, Usuario, Carpeta),
    filecarpeta(Ruta, Contenido, Seguridad_Car, Usuario, Updated_carpeta).

% Función que toma el tercer elemento de una lista
get_Seguridad(Carpeta_creada, Seguridad_carpeta):-
    nth0(2, Carpeta_creada, Seguridad_carpeta).

% Función que ayuda a modificar un elemento dentro de una lista de listas
funcion_modificar(Elemento, Modificado, Dir, Sistema) :-
    get_segundo(Elemento, Modificado1),
    get_tercero(Elemento, Modificado2),
    unir([Dir],Dir1),
    add_carpeta(Dir1, Carpeta_creada),
    get_Carpetas(Sistema, Carpetas),
    get_usuario(Sistema, Usuario),
    primer_elemento(Usuario, User_to),
    tiempo(User_to, User_tiempo),
    get_user_tocarpeta(Carpeta_creada, Usuario_de_carpeta),   
    adduser_to_carpeta(User_tiempo, Usuario_de_carpeta, Updated_carpeta),
    set_Carpeta(Carpeta_creada, Updated_carpeta, Creada_carpeta),
    get_contenido(Carpeta_creada, Contenido_carpeta),
    addcontenido_to_carpeta(Modificado1, Contenido_carpeta, Updated_Contenido),
    set_contenido(Creada_carpeta, Updated_Contenido, Creada_carpeta_1),
    get_Seguridad(Carpeta_creada, Seguridad_Carpeta),
    addseguridad_to_carpeta(Modificado2, Seguridad_Carpeta, Updated_Seguridad),
    set_seguridad(Creada_carpeta_1, Updated_Seguridad, Creada_carpeta_2),
    addruta_to_carpeta(Creada_carpeta_2, Carpetas, Updated_Carpetas),
    set_Carpetas(Sistema, Updated_Carpetas, Modificado).

% Función que ayuda a copiar los archivos de una carpeta a otra
copiar(Disco, Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    contiene_valor(Disco, Carpeta_Archivo, Lista),
    modificar_lista(Lista, Updated_Sistema, Direccion, Sistema).

%---------------------------------------- TDA systemMove --------------------------------------------------

% Función que ayuda a mover los archivos de una carpeta a otra
move(Disco, Sistema, Carpeta_Archivo, Direccion, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    contiene_valor(Disco, Carpeta_Archivo, Lista),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    modificar_lista(Lista, Updated_Sistema, Direccion, Updated_Sistema_1).

%------------------------------------ TDA systemRen -------------------------------------------------------------

% Función que ayuda a remplazar un elemento por otro
reemplazar([], _, _, []).
reemplazar([X|Xs], Elemento, NuevoElemento, [NuevoElemento|Ys]) :-
    X = Elemento, 
    reemplazar(Xs, Elemento, NuevoElemento, Ys).
reemplazar([X|Xs], Elemento, NuevoElemento, [X|Ys]) :-
    X \= Elemento, 
    reemplazar(Xs, Elemento, NuevoElemento, Ys).

% Función que ayuda a modificar los elementos interiores de una listas de listas
modificar_nombre([], [], _, _).
modificar_nombre([X|Xs], [Y|Ys], New_Name, Sistema) :-
    modificar_elementos(X, Y, New_Name, Sistema),
    modificar_nombre(Xs, Ys, New_Name, Sistema).
modificar_elementos(Elemento, Modificado, New_Name, Sistema) :-
    funcion_modificar_Nombre(Elemento, Modificado, New_Name, Sistema).

% Función que toma el primer elemento de una lista
get_dir(Elemento, Modificado):-
    nth0(0, Elemento, Modificado).

% Función que ayuda a modificar el nombre de un elemento dentro de una lista de listas
funcion_modificar_Nombre(Elemento, Modificado, New_Name, Sistema) :-
    get_segundo(Elemento, Modificado1),
    primer_elemento(Modificado1, Nombre),
    reemplazar(Modificado1, Nombre, New_Name, Resultado),
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

% Función que ayuda a trabajar las condiciones del ren 
ren(Disco, Sistema, Name, New_Name, Updated_Sistema):-
    get_Carpetas(Sistema, Carpetas),
    contiene_valor(Disco, Name, Lista),
    eliminar_elementos_iguales(Carpetas, Lista, Updated_carpeta),
    set_Carpetas(Sistema, Updated_carpeta, Updated_Sistema_1),
    modificar_nombre(Lista, Updated_Sistema, New_Name, Updated_Sistema_1).

%-------------------------------------------- TDA systemDir ----------------------------------

% Función que ayuda a trabajar las condiciones del dir 
dir(Sistema, Parametro, String):-
    iguales(["/s"], Parametro),
    get_Carpetas(Sistema, Carpetas),
    get_ruta(Sistema, Ruta),
    primer_elemento(Ruta, Ruta1),
    filtrar_por_subcadena(Carpetas, Ruta1, String). 
dir(_, Parametro, String):-
    iguales(["/?"], Parametro),
    String = "Si no se ingresa nada solo se mostra el contenido del directorio actual, excluyendo subdirectorios y contenido oculto.
Si ingresa /s se mostrara el contenido del directorio actual junto a subdirectorios.
Si ingresa /a se mostrara solo el contenido del directorio actual incluyendo el contenido oculto.
Si ingresa /s /a se mostra el contenido del directorio actual y subdirectorios, incluyendo contenido oculto.
Si ingresa /N se mostrara el contenido del directorio actual en orden alfabético ascendente.
Si ingresa /o D se mostrara el contenido del directorio actual según fecha de creación, en orden ascendente. 
Si ingresa /o D se mostrara el contenido del directorio actual según fecha de creación, en orden descendente".

%-------------------------------------------- TDA systemFormat ------------------------------------

% Función que toma el segundo elemento de una lista
get_Nom(Lista, Nombre):-
    nth0(1, Lista, Nombre).

%----------------------------------------- TDA systemEncrypt ----------------------------------------


%----------------------------------------- TDA systemDecrypt ----------------------------------------


%----------------------------------------- TDA systemGrep ----------------------------------------

% Función para ver la contidad de repeticones de una palabra y las posiciones de esta
contiene_y_posiciones(Lista, Cadena, Cantidad, Posiciones) :-
    contiene_y_posiciones(Lista, Cadena, 0, Cantidad, [], Posiciones).
contiene_y_posiciones([], _, Cantidad, Cantidad, Posiciones, Posiciones).
contiene_y_posiciones([Cadena|Resto], Cadena, Cantidad_Actual, Cantidad, Posiciones_Parcial, Posiciones) :-
    Nueva_Cantidad is Cantidad_Actual + 1,
    Nueva_Posicion is Cantidad_Actual,
    append(Posiciones_Parcial, [Nueva_Posicion], Nuevas_Posiciones),
    contiene_y_posiciones(Resto, Cadena, Nueva_Cantidad, Cantidad, Nuevas_Posiciones, Posiciones).
contiene_y_posiciones([_|Resto], Cadena, Cantidad_Actual, Cantidad, Posiciones_Parcial, Posiciones) :-
    contiene_y_posiciones(Resto, Cadena, Cantidad_Actual, Cantidad, Posiciones_Parcial, Posiciones).
    
% Función que toma el segundo elemento de una lista
get_cont(Lista, Lista1):-
    nth0(1, Lista, Lista1).

% Función que ayuda a pasar de numero a cadena de caracteres
numero_a_cadena(Numero, Cadena) :-
    number_codes(Numero, Codigo),
    atom_codes(Cadena, Codigo).
numeros_a_cadenas([], []).
numeros_a_cadenas([Numero|Resto], [Cadena|CadenasRestantes]) :-
    numero_a_cadena(Numero, Cadena),
    numeros_a_cadenas(Resto, CadenasRestantes).

% Función que ayuda a trabajar las condiciones del grep 
directorio(Disco, _, Palabra, Archivo, Strin):-
    contiene_valor(Disco, Archivo, Lista),
    primer_elemento(Lista, Lista1),
    get_cont(Lista1, Lista2),
    get_cont(Lista2, Elemento),
    dividir_string(Elemento, " ", Lista3),
    contiene_y_posiciones(Lista3, Palabra, Cantidad, Posiciones),
    numero_a_cadena(Cantidad, CantidadCadena),
    numeros_a_cadenas(Posiciones, PosicionesCadenas),
    unir(["La Cantidad de veces que se repite la palabra es igual a: ", CantidadCadena, " y se encuentra en la o las posiciones: "], Probar),
    atom_string(Probar, Str),
    atomic_list_concat([Str|PosicionesCadenas], Strin1),
    atom_string(Strin1, Strin).

%----------------------------------------- TDA systemViewTrash --------------------------------------

%----------------------------------------- TDA systemRestore ----------------------------------------
