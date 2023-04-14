//15. La empresa distribuidora de una app móvil para corredores ha organizado una competencia mundial, 
//en la que corredores de todos los países participantes salen a correr en el mismo momento en 
//distintos puntos del planeta. 
//La app registra, para cada corredor, el nombre y apellido, la distancia recorrida (en kilómetros), 
//el tiempo (en minutos) durante el que corrió, el país y la ciudad desde donde partió, 
//y la ciudad donde finalizó su recorrido.

//Realizar un programa que permita leer y almacenar toda la información registrada durante la competencia. 
//Una vez que se han almacenado todos los datos, informar:

//a. La cantidad total de corredores, la distancia total recorrida y el tiempo total de carrera de todos los corredores.
//b. El nombre de la ciudad que convocó la mayor cantidad de corredores y la cantidad total de kilómetros recorridos
//por los corredores de esa ciudad.
//c. La distancia promedio recorrida por corredores de Brasil.
//d. La cantidad de corredores que partieron de una ciudad y finalizaron en otra ciudad.
//e. El paso (cantidad de minutos por km) promedio de los corredores de la ciudad de Boston.


program Ej15;
const
    corte = 'corte';
type
cadena = string[30];
corredor = record 
    nomape: cadena;
    distancia: real;
    tiempo: integer;
    pais: cadena;
    origen: cadena;
    destino: cadena;
end;
totales = record 
    totalcorredores: integer;
    totaldistancia: real;
    totaltiempo: integer;
    maxciudad: cadena;
    maxcantidad: integer;
    maxkm: real;
    prom: real;
    distintos: integer;
end;
boston = record 
    nomyape: cadena;
    pasoprom: real;
end;
lista = ^nodo;
nodo = record 
    dato: corredor;
    sig: lista;
end;
listaboston = ^nodoboston;
nodoboston = record 
    dato: boston;
    sig: listaboston;
end;

procedure LeerCorredor(var c: corredor);
begin
    writeln ('Ingrese nombre y apellido del corredor');
    readln(c.nomape);
    if (c.nomape <> corte) then begin 
        writeln ('Ingrese distancia recorrida en km');
        readln(c.distancia);
        writeln ('Ingrese tiempo empleado en la carrera (minutos)');
        readln(c.tiempo);
        writeln ('Ingrese pais del corredor');
        readln(c.pais);
        writeln ('Ingrese origen (ciudad donde comenzó la carrera)');
        readln(c.origen);
        writeln ('Ingrese destino (ciudad donde terminó la carrera)');
        readln(c.destino);
    end;
end;

procedure InsertarOrdenado(var l: lista; c: corredor);
var 
  ant, act, nue: lista;
begin
  new(nue);
  nue^.dato:= c;
  act:= l;
  ant:= l;
  while (act <> nil) and (act^.dato.origen<c.origen) do begin 
    ant:= act;
    act:= act^.sig;
  end;
  if (ant=act) then 
    l:= nue
  else 
    ant^.sig:= nue;
  nue^.sig:= act; 
end;

procedure CargarLista(var l: lista; var c: corredor);
begin
LeerCorredor(c);
    repeat
        InsertarOrdenado(l,c);
        LeerCorredor(c); 
    until (c.nomape = corte);
end;

procedure AgregarAdelante(var lb: listaboston; b: boston);
var 
    nue: listaboston;
begin
    new(nue);
    nue^.dato:= b;
    nue^.sig:= lb;
    lb:= nue;
end;

procedure RecorrerLista(l: lista; var t: totales; var lb: listaboston; var b: boston);
var 
    ant: cadena;
    cant: integer;
    sumakm: real;
    brasil: real;
    cantbrasil: integer;
begin
ant:= ' ';
cant:= 0;
sumakm:= 0;
brasil:= 0;
cantbrasil:= 0;
    while (l <> nil) do begin 
        writeln ('Nom: ' ,l^.dato.nomape, ' Dist: '  ,l^.dato.distancia:3:2, ' T: ' ,l^.dato.tiempo, ' P: ' ,l^.dato.pais, ' Ciudad Origen: ' ,l^.dato.origen, ' Destino: ' ,l^.dato.destino);
        t.totalcorredores:= t.totalcorredores+1;
        t.totaltiempo:= t.totaltiempo+l^.dato.tiempo;
        t.totaldistancia:= t.totaldistancia+l^.dato.distancia;
        if (l^.dato.pais = 'brasil') then begin 
            brasil:= brasil+l^.dato.distancia;
            cantbrasil:= cantbrasil+1;
        end;
        if (l^.dato.origen <> l^.dato.destino) then 
            t.distintos:= t.distintos+1;
        if (l^.dato.origen <> ant) and (ant <> ' ') then begin
            if (cant>t.maxcantidad) then begin 
                t.maxcantidad:= cant;
                t.maxciudad:= ant;
                t.maxkm:= sumakm;
            end;
            cant:= 0;
            sumakm:= 0;
        end;
        cant:= cant+1;
        sumakm:= sumakm+l^.dato.distancia;
        if (l^.sig = nil) then
           if (cant>t.maxcantidad) then begin 
                t.maxcantidad:= cant;
                t.maxciudad:= ant;
                t.maxkm:= sumakm;
            end;
        if (l^.dato.origen = 'boston') then begin 
            b.nomyape:= l^.dato.nomape;
            b.pasoprom:= l^.dato.tiempo/l^.dato.distancia;
            AgregarAdelante(lb, b);
        end;
        ant:= l^.dato.origen;
        l:= l^.sig;
    end;
    t.prom:= brasil/cantbrasil;
end;

procedure Informar(t: totales);
begin
    writeln ('Total de corredores: ' ,t.totalcorredores);
    writeln ('Tiempo total de carrera: ' ,t.totaltiempo);
    writeln ('Distancia total recorrida: ' ,t.totaldistancia:3:2);
    writeln ('La ciudad con mas corredores es: ' ,t.maxciudad, ', con una cantidad de ' ,t.maxcantidad, ', los cuales sumaron ' ,t.maxkm:3:2, 'km recorridos.');
    writeln ('La distancia promedio recorrida por corredores brasileños es: ' ,t.prom:3:2);
    writeln ('Cantidad de corredores que iniciaron en una ciudad y finalizaron en otra: ' ,t.distintos);
end;

procedure RecorrerSublista(lb: listaboston);
begin
    while (lb<> nil) do begin 
        writeln ('Corredor: ' ,lb^.dato.nomyape, ', paso promedio (min/km): ' ,lb^.dato.pasoprom:3:2);
        lb:= lb^.sig;
    end;
end;

var 
    l: lista;
    c: corredor;
    t: totales;
    lb: listaboston;
    b: boston;
begin 
    t.maxcantidad:= 0;
    t.maxciudad:= ' ';
    t.distintos:= 0;
    t.prom:= 0;
    CargarLista(l, c);
    RecorrerLista(l, t, lb, b);
    Informar (t);
    RecorrerSublista(lb);
    readln();
end.
