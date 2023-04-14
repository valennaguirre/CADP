// La Facultad de Informatica organizara el congreso WICC, en donde se expondrán trabajos de investigación. 
// Realizar un programa que lea la información de cada publicación: 
// titulo de la publicación, nombre del autor, DNI del autor 
// y tipo de publicación (1.12). 
// La lectura de publicaciones finaliza al ingresar un DNI de autor con valor 0 (el cual no debe procesarse).
// La información se lee ordenada por DNI del autor y un autor puede tener varias publicaciones. 

// Se pide escribir un programa que:

// a. Informe el tipo de publicación con mayor cantidad de publicaciones. 
// b. Informar para cada autor la cantidad de publicaciones presentadas.

program Ej;
const 
  corte = 0;
  dimF = 12;
type
  subrango = 1..dimF;
  cadena = string[30];
  vcontador = array [subrango] of integer;
  publicacion = record 
    titulo: cadena;
    nombre: cadena;
    dni: integer;
    tipo: subrango;
  end;
  lista = ^nodo;
  nodo = record 
    dato: publicacion;
    sig: lista;
  end;
  autor = record
    dni: integer;
    cantidad: integer;
  end;
  sublista = ^subnodo;
  subnodo = record 
    dato: autor;
    sig: sublista;
  end;

procedure CargarVector (var v: vcontador);
var 
  i: subrango;
begin
  for i := 1 to dimF do
    v[i]:= 0;
end;

procedure LeerPublicacion(var p: publicacion);
begin
  writeln ('Ingrese titulo');
  readln(p.titulo);
  writeln ('Ingrese nombre del autor');
  readln(p.nombre);
  writeln ('Ingrese dni');
  readln(p.dni);
  if (p.dni <> 0) then begin 
    writeln ('Ingrese tipo de publicacion (1..12)');
    readln(p.tipo);
  end;
end;

procedure InsertarOrdenado(var l: lista; p: publicacion);
var 
  ant, act, nue: lista;
begin
  new(nue);
  nue^.dato:= p;
  act:= l;
  ant:= l;
  while (act <> nil) and (act^.dato.dni<p.dni) do begin 
    ant:= act;
    act:= act^.sig;
  end;
  if (ant=act) then 
    l:= nue
  else 
    ant^.sig:= nue;
  nue^.sig:= act; 
end;

procedure CargarLista (var l: lista; var p: publicacion);
begin
  LeerPublicacion (p);
  while (p.dni <> corte) do begin 
    InsertarOrdenado(l, p);
    LeerPublicacion(p);
  end;
end;

procedure AgregarAdelante(var s: sublista; a: autor);
var 
  nue: sublista;
begin
  new(nue);
  nue^.dato:= a;
  nue^.sig:= s;
  s:= nue;  
end;

procedure RecorrerLista (l: lista; var v: vcontador; var s: sublista; var a: autor);
var 
  act, ant, cant: integer;
begin
cant:= 0;
ant:= 0;
  while (l <> nil) do begin
    act:= l^.dato.dni;
    v[l^.dato.tipo]:= v[l^.dato.tipo]+1;
    if (act <> ant) and (cant > 0) then begin
      AgregarAdelante (s, a);
      cant:= 0;
    end;
    cant:= cant+1;
    ant:= l^.dato.dni;
    a.dni:= ant;
    a.cantidad:= cant;
    l:= l^.sig;
  end;
  AgregarAdelante (s,a);
end;

procedure RecorrerSublista (s: sublista);
begin
  while (s <> nil) do begin 
    writeln ('DNI: ' ,s^.dato.dni);
    writeln ('Cant. de publicaciones: ' ,s^.dato.cantidad);
    writeln ('------');
    s:= s^.sig;
  end;
end;

procedure RecorrerVector(v: vcontador);
var 
  max: integer;
  i, maxpos: subrango;
begin
max:= -1;
maxpos:= 1;
  for i:= 1 to dimF do 
    if (v[i]>max) then begin 
      max:= v[i];
      maxpos:= i;
    end;
  writeln ('Tipo de publicacion mas elegido: ' ,maxpos, ' con ' ,max, ' publicaciones');
end;

var 
  v: vcontador;
  p: publicacion;
  l: lista;
  s: sublista;
  a: autor;
begin 
  CargarVector(v);
  CargarLista(l, p);
  RecorrerLista(l, v, s, a);
  writeln ('Ej 1:');
  RecorrerVector(v);
  writeln ('Ej 2: ');
  RecorrerSublista(s);
  readln();
end.
