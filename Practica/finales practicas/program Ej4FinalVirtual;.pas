program Ej4FinalVirtual;
const 
    dimF = 10; //debe ser 100
type
    subrango = 1..dimF;
    vector = array [subrango] of integer;
    lista = ^nodo;
    nodo = record 
        dato: integer;
        sig: lista;
    end;

procedure CargarVector (var v: vector);
var 
    num, i: integer;
begin
    for i:= 1 to dimF do begin 
        writeln ('Ingrese un numero: ');
        readln(num);
        v[i]:= num;
    end;
end;

procedure InsertarOrdenado(var l: lista; num: integer);
var 
    nue, act, ant: lista;
begin
    new(nue);
    nue^.dato:= num;
    ant:= l;
    act:= l;
    while (act<>nil) and (act^.dato < num) do begin 
        ant:= act;
        act:= act^.sig;
    end;
    if (ant = act) then 
        l:= nue
    else 
        ant^.sig:= nue;
    nue^.sig:= act;
end;

function EsImpar(num: integer):boolean;
var 
    exito: boolean;
begin
exito:= false;
    if (num mod 2 = 1) then 
        exito:= true;
EsImpar:= exito;
end;

procedure RecorrerVector(v: vector; var l: lista);
var 
    i: integer;
begin
    for i:= 1 to dimF do 
        if (EsImpar(v[i])=true) then 
            InsertarOrdenado (l, v[i]);   
end;

procedure RecorrerLista(l: lista);
begin
    while (l <> nil) do begin 
        writeln (l^.dato);
        l:= l^.sig;
    end;
end;

var 
    v: vector;
    l: lista;
begin 
    CargarVector(v);
    RecorrerVector(v, l);
    RecorrerLista(l);
    readln();
end.
