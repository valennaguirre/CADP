// 1. Una productora nacional realiza un casting de personas para la selección de actores extras de una
// nueva película, para ello se debe leer y almacenar la información de las personas que desean
// participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de
// género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La
// lectura finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.
// Una vez finalizada la lectura de todas las personas, se pide:
// a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
// b. Informar los dos códigos de género más elegidos.
// c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede
// no existir.

//Terminado en 52 min 44 seg despues de 1 año sin tocar pascal

program Ej1;
const 
    dimF = 5;
    corte = 55; // para ejecutar en terminal colocar un corte <= 32767
Type
subrango = 1..5;
cadena = string[30];
vcategorias = array [subrango] of integer;
productora = record
  dni: integer;
  apeynom: cadena;
  edad: integer;
  codigo: subrango;
end;
lista = ^nodo;
nodo = record
    dato: productora;
    sig: lista;
end;

procedure CargarContador (var v: vcategorias);
var
    i: integer;
begin
    for i:= 1 to dimF do
        v[i]:= 0;
end;

procedure LeerRegistro(var p: productora);
begin
    writeln ('Ingrese dni');
    readln(p.dni);
        //writeln ('Ingrese apellido y nombre');
        //readln(p.apeynom);
        //writeln ('Ingrese edad');
        //readln(p.edad);
        writeln ('Ingrese código de genero de actuacion');
        readln(p.codigo);
end;

procedure AgregarAdelante(var l: lista; var p: productora);
var 
    nue: lista;
begin
    new(nue);
    nue^.dato:= p;
    nue^.sig:= l;
    l:= nue;
end;

procedure CargarLista (var l: lista; var v: vcategorias; var p: productora);
begin
repeat
    LeerRegistro(p);
    AgregarAdelante(l, p);
    v[p.codigo]:= v[p.codigo]+1;    
until (p.dni = corte); 
end;

function DniPar(l: lista):boolean;
var
    num, dig, par, impar: integer;
    exito: boolean;
begin
    num:= l^.dato.dni;
    par:= 0;
    impar:= 0;
    exito:= false;
    while (num <> 0) do begin 
        dig:= num mod 10;
        if (dig mod 2 = 0) then
            par:= par+1
        else 
            impar:= impar+1;
        num:= num div 10;
    end;
    if (par>impar) then 
        exito:= true
    else
        exito:= false;
    DniPar:= exito;
end;

procedure RecorrerLista (l: lista);
var
    cant: integer;
begin
cant:= 0;
    while (l <> nil) do begin 
        if DniPar(l) = true then
            cant:= cant+1;
        l:= l^.sig;    
    end;
    writeln ('Cantidad de DNIs con más pares que impares: ' ,cant);
end;

procedure RecorrerVector(v: vcategorias);
var
    i: integer;
    posmax, posmax2, max, max2: integer;
begin
posmax:= 0;
posmax2:= 0;
max:= -1;
max2:= -2;
    for i:= 1 to dimF do begin 
        if (v[i]>max) then begin
            max2:= max;
            max:= v[i]; 
            posmax2:= posmax;
            posmax:= i;
        end
        else if (v[i]>max2) then begin 
            max2:= v[i];
            posmax2:= i;
        end;
    end;    
    writeln ('Géneros más seleccionados: ' ,posmax, ' con ' ,max, ' selecciones y ' ,posmax2, ' con ' ,max2, ' selecciones.');
end;

procedure BorrarElemento(var l: lista; dni: integer; var exito: boolean);
var ant, act: lista;
begin
    exito:= false;
    act:= l;
while (act <> nil) and (act^.dato.dni <> dni) do begin 
    ant:= act;
    act:= act^.sig;
end;
if (act <> nil) then begin 
    exito:= true;
        if (act = l) then 
            l:= act^.sig
        else
            ant^.sig:= act^.sig;
        dispose(act);
    end;
end;


var
    v: vcategorias;
    l: lista;
    p: productora;
    numdni: integer;
    exito: boolean;
begin 
    exito:= false;
    CargarContador(v);
    CargarLista (l, v, p);
    RecorrerLista (l);
    RecorrerVector(v);
    writeln ('Ingrese un dni para buscar:');
    readln(numdni);
    BorrarElemento (l, numdni, exito);
    if (exito = true) then
       writeln('Se eliminó el dni n°' ,numdni)
    else
        writeln ('No se encontró el dni especificado');
    readln();
end.
