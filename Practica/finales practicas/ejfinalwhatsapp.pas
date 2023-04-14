// producto: Cod, nom, rubro (1..20), precio
// Se pide implementar un programa que guarde en una estructura adecuada los productos de
// los rubros que tengan 10 productos

program EjExam;
const 
    fin = 20;
    corte = -1;
    condicion = 10;
type 
    cadena = string[30];
    subrango = 1..fin;
    producto = record 
        codigo: integer;
        nombre: cadena;
        rubro: subrango;
        precio: real;
    end;
    vector = array [subrango] of integer;
    lista = ^nodo;
    nodo = record 
        dato: producto;
        sig: lista;
    end;
    sublista = ^subnodo;
    subnodo = record 
        dato: producto;
        sig: sublista;
    end;

procedure CargarContador (var v: vector);
var 
    i: integer;
begin
    for i:= 1 to fin do 
        v[i]:= 0;
end;

procedure LeerProducto (var p: producto; var v: vector);
begin
    writeln ('Ingrese codigo del producto');
    readln (p.codigo);
    if (p.codigo <> corte) then begin
        writeln ('Ingrese nombre del producto');
        readln (p.nombre);
        writeln ('Ingrese rubro del producto (1-20)');
        readln (p.rubro);
        v[p.rubro]:= v[p.rubro]+1;
        writeln ('Ingrese precio del producto');
        readln (p.precio);
    end;
end;

procedure AgregarAdelante (var l: lista; var p: producto);
var 
    nue: lista;
begin
    new(nue);
    nue^.dato:= p;
    nue^.sig:= l;
    l:= nue;
end;

procedure CargarLista (var l: lista; var v: vector; var p: producto);
begin
    CargarContador (v);
    LeerProducto(p, v);
    while (p.codigo <> corte) do begin 
        AgregarAdelante(l, p);
        LeerProducto(p, v);
    end;
end;

procedure ArmarSublista(var s: sublista; l: lista);
var 
    nue: sublista;
begin
    new(nue);
    nue^.dato:= l^.dato;
    nue^.sig:= s;
    s:= nue;
end;

procedure RecorrerContador(l: lista; var s: sublista; v: vector);
begin
    while (l <> nil) do begin
        if (v[l^.dato.rubro] = condicion) then
            ArmarSublista (s, l);
    l:= l^.sig;
    end;
end;

procedure RecorrerSublista(s: sublista);
begin
    while (s <> nil) do begin 
        writeln ('Codigo: ' ,s^.dato.codigo, ' Nombre: ' ,s^.dato.nombre, ' Rubro: ' ,s^.dato.rubro);
        s:= s^.sig;
    end;
end;

var 
    s: sublista;
    v: vector;
    l: lista;
    p: producto;
begin 
    CargarLista(l, v, p);
    RecorrerContador (l, s, v);
    RecorrerSublista(s);
    readln();
end.

