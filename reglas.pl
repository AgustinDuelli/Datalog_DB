% Reglas
% 1. aporto_fondos/2: Relaciona una empresa con un proyecto si la empresa aporto fondos al proyecto.
% 2. Sirve para saber proyectos donde una empresa aporto fondos.
aporto_fondos(Empresa, Proyecto) :-
    patrocinio(_,Empresa, _, _, Proyecto).


% 3. proyectos_investigadores_localidad/2: Devuelve los proyectos en los que participaron investigadores de una localidad.
proyectos_investigadores_localidad(Localidad, Proyecto) :-
    investigador(_, _, Dni, Localidad),
    historial_proyecto(Dni, Proyecto).



% 4. fondos_no_superados/1: Devuelve si el proyecto superó sus fondos.
% Hecho base para corte.
suma_patrocinio(_, 0, 0).
% Recursividad para suma de patrocinios con el mismo nombre.
suma_patrocinio(Name, TotalAmount, N) :-
    N > 0,
    patrocinio(N,_,_, Amount, Name),
    N1 is N - 1,
    suma_patrocinio(Name, SubTotalAmount, N1),
    TotalAmount is SubTotalAmount + Amount.
% Skip IDs that do not match the given name and continue the recursion
suma_patrocinio(Name, TotalAmount, N) :-
    N > 0,
    \+ patrocinio(N,_,_,_, Name),
    N1 is N - 1,
    suma_patrocinio(Name, TotalAmount, N1).
% Encontrar id máximo de patrocinio.
max_id_patrocinio(MaxId) :-
    patrocinio(MaxId,_,_,_,_),
    not((patrocinio(Id,_,_,_,_), Id > MaxId)).
% Sumar patrocinios de un proyecto.
total_suma_patrocinio(Proyecto, Total) :-
    max_id_patrocinio(MaxId),
    suma_patrocinio(Proyecto, Total, MaxId),
    Total > 0.

fondos_superados_inner(Proyecto) :-
    proyecto(Proyecto, _, _, _, _, _, Presupuesto),
    total_suma_patrocinio(Proyecto, PatrocinioTotal),
    PatrocinioTotal > Presupuesto.

%Consulta a realizar para verificar.
fondos_no_superados(Proyecto):-
    not(fondos_superados_inner(Proyecto)),
    proyecto(Proyecto, _, _, _, _, _, _).



% 6. no_un_solo_director/1: Verifica que un director esté en más de un proyecto.
no_un_solo_director(Director) :-
    proyecto(Nombre, _, Director, _, _, _, _),
    proyecto(N2, _, DifDirector, _, _, _, _),
    Director = DifDirector, Nombre \= N2.
% 7. un_solo_director/1: Verifica que ningun director esté en más de un proyecto.
% Si se manda un director, verifica si está en más de un proyecto o no.
% Depende de no_un_solo_director/1.
un_solo_director(Director) :-
    not(no_un_solo_director(Director)).