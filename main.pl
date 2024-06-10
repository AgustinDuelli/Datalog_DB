% Cargar archivos de hechos
:- [consejo_revisor].
:- [departamento].
:- [empresa].
:- [historial_academico].
:- [historial_proyecto].
:- [informe_avance_palabra_clave].
:- [informe_avance].
:- [investigador].
:- [palabra_clave].
:- [patrocinio].
:- [proyecto].

% Cargar reglas
:- [reglas].

% Inicializar programa
:- initialization(main).

main :-
    writeln('Bienvenido a Datalog: Instituto de Investigacion!'),
    writeln('Puedes realizar consultas sobre los investigadores, proyectos y publicaciones del instituto.'),
    writeln('Posibles consultas:'),
    writeln('1. aporto_fondos(Empresa,Proyecto).'),
    writeln('2. proyectos_investigadores_localidad(Localidad,Proyecto).'),
    writeln('3. fondos_no_superados(Proyecto).'),
    writeln('4. un_solo_director(Director).'),
    writeln(''),
    prolog.