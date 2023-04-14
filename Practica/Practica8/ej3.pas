// 3. Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de
// 2018. De cada viaje se conoce: número de viaje, código de auto, dirección de origen, dirección
// de destino y kilómetros recorridos durante el viaje. Esta información se encuentra ordenada por
// código de auto y para un mismo código de auto pueden existir 1 o más viajes. Se pide:

// a. Informar los dos códigos de auto que más kilómetros recorrieron.
// b. Generar una lista nueva con los viajes de más de 5 kilómetros recorridos, ordenada por
// número de viaje.

program Ej3;
const 
    corte = -1;
type 
    cadena = string[30];
    viaje = record
        num: integer;
        codigo: integer;
        origen: cadena;
        destino: cadena;
        km: real;
    end;
    lista = ^nodo;
    nodo = record
        dato: viaje;
        sig: lista;
    end;

procedure LeerViaje (var v: viaje);
begin
    writeln ('Ingrese numero de viaje:');
    readln (v.num);
    if (v.num <> corte) then begin 
        writeln ('Ingrese codigo:');
        readln (v.codigo);
        writeln ('Ingrese origen:');
        readln (v.origen);
        writeln ('Ingrese destino:');
        readln (v.destino);
        writeln ('Ingrese km recorridos:');
        readln (v.km);
    end;
end;

procedure InsertarOrdenado(var l: lista; v: viaje);
var
    ant, nue, act: lista;
begin
    new(nue);
    nue^.dato:= v;
    act:= l;
    ant:= l;
    while (act <> nil) and (act^.dato.codigo < v.codigo) do begin 
        ant:= act;
        act:= act^.sig;
    end;
    if (ant = act) then 
        l:= nue
    else
        ant^.sig:= nue;
    nue^.sig:= act;
end;

procedure InsertarOrdenadoEjDos(var ln: lista; num: integer; l: lista);
var
    ant, nue, act: lista;
begin
    new(nue);
    nue^.dato:= l^.dato;
    act:= ln;
    ant:= ln;
    while (act <> nil) and (act^.dato.codigo < num) do begin 
        ant:= act;
        act:= act^.sig;
    end;
    if (ant = act) then 
        ln:= nue
    else
        ant^.sig:= nue;
    nue^.sig:= act;
end;

procedure CargarLista (var l: lista; var v: viaje);
begin
LeerViaje(v);
    while (v.num <> -1) do begin
        InsertarOrdenado(l, v);
        LeerViaje(v);
    end;
end;

function IgualCodigo(ant: integer; act: integer):boolean;
var
    exito: boolean;
begin
    exito:= false;
    if (ant = act) then
        exito:= true;
IgualCodigo:=exito;
end;

procedure RecorrerLista (l: lista; var ln: lista);
var 
    codmax, codmax2, num, ant, act: integer;
    max, max2, suma: real;
begin
max:= -2;
max2:= -1;
codmax2:= 0;
codmax:= 0;
    while (l <> nil) do begin 
    act:= l^.dato.codigo;
    if (IgualCodigo(ant, act) = true) then 
        suma:= suma+l^.dato.km
    else begin
        if (suma > max) then begin
            max2:= max;
            max:= suma;
            codmax2:= codmax;
            codmax:= ant;
        end
        else if (suma > max2) then begin
            max2:= suma;
            codmax2:= ant;
        end;
        suma:= 0;
    end;

        if (l^.dato.km>5) then begin 
            num:= l^.dato.num;
            InsertarOrdenadoEjDos(ln, num, l);
        end;    
    ant:= l^.dato.codigo;
    l:= l^.sig;
    end;
    writeln ('Los dos codigos de auto con mayor distancia recorrida son: ' ,codmax, ' (' ,max, ') y ' ,codmax2, ' (' ,max2, ')');
end;

procedure RecorrerListaEjDos(ln: lista);
begin
    while (ln <> nil) do begin 
        writeln ('Numero Viaje: ' ,ln^.dato.num, ' kms: ' ,ln^.dato.km:3:2);
    ln:= ln^.sig;
    end;
end;

var 
    l: lista;
    ln: lista;
    v: viaje;
begin
    CargarLista(l, v);
    RecorrerLista(l, ln);
    writeln ('Lista de viajes con más de 5 kms recorridos:');
    RecorrerListaEjDos (ln);
    readln();
end.

    

