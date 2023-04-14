// 2. Implementar un programa que lea y almacene información de clientes de una empresa
// aseguradora automotriz. De cada cliente se lee: código de cliente, DNI, apellido, nombre, código
// de póliza contratada (1..6) y monto básico que abona mensualmente. La lectura finaliza cuando
// llega el cliente con código 1122, el cual debe procesarse.

// La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que
// el cliente debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que
// tiene contratada.

// Una vez finalizada la lectura de todos los clientes, se pide:
// a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga
// mensualmente por su seguro automotriz (monto básico + monto adicional).
// b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.
// c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de
// la estructura.

program Ej2;
const
    dimF = 6;
    corte = 1122;
Type
    subrango = 1..dimF;
    cadena = string[20];
    cliente = record
        codigo: integer;
        dni: integer;
        apellido: cadena;
        nombre: cadena;
        poliza: subrango;
        monto: real;
    end;
    vector = array [subrango] of real;
    lista = ^nodo;
    nodo = record 
        dato: cliente;
        sig: lista;
    end;
    nueve = record 
        apellido: cadena;
        nombre: cadena;
    end;
    listanueve = ^nodonueve;
    nodonueve = record
        dato: nueve;
        sig: listanueve;
    end;

procedure CargarVector(var v: vector); //se dispone, pero establezco valores para poder analizar la ejecución.
var
    i: integer;
begin
    for i:= 1 to dimF do
        v[i]:= i*10.5; // 1: 10.5, 2: 20.5, 3: 30.5... 
end;

procedure LeerCliente (var c: cliente);
begin
    writeln ('Ingresar codigo:');
    readln(c.codigo);
    writeln ('Ingresar dni:');
    readln(c.dni);
    writeln ('Ingresar apellido:');
    readln(c.apellido);
    writeln ('Ingresar nombre:');
    readln(c.nombre);
    writeln ('Ingresar poliza:');
    readln(c.poliza);
    writeln ('Ingresar monto mensual:');
    readln(c.monto);
end;

procedure AgregarAdelante(var l: lista; c: cliente);
var 
    nue: lista;
begin
    new(nue);
    nue^.dato:= c;
    nue^.sig:= l;
    l:= nue;
end;

procedure AgregarAdelante(var ln: listanueve; n: nueve);
var 
    nue: listanueve;
begin
    new(nue);
    nue^.dato:= n;
    nue^.sig:= ln;
    ln:= nue;
end;

procedure CargarLista(var l: lista; var c: cliente);
begin
    repeat
        LeerCliente (c);
        AgregarAdelante (l, c);   
    until (c.codigo = corte);
end;

function TieneDosOMasNueve(l: lista):boolean;
var 
    num, dig, nueve: integer;
    exito: boolean;
begin
    exito:= false;
    num:= l^.dato.dni;
    nueve:= 0;
    while (num <> 0) do begin 
        dig:= num mod 10;
        if (dig = 9) then 
            nueve:= nueve+1;
        num:= num div 10;
    end;
    if (nueve >= 2) then 
        exito:= true;
    TieneDosOMasNueve:=exito;
end;

procedure RecorrerLista(l: lista; v: vector; var ln: listanueve; var n: nueve);
begin
    writeln ('Clientes: ');
    while (l <> nil) do begin
        writeln ('DNI:' ,l^.dato.dni, ' Apellido: ' ,l^.dato.apellido, ' Nombre: ' ,l^.dato.nombre, ' Monto Total: ' ,l^.dato.monto+v[l^.dato.poliza]:3:2);
        n.apellido:= l^.dato.apellido;
        n.nombre:= l^.dato.nombre;
        if (TieneDosOMasNueve(l)= true) then 
            AgregarAdelante(ln, n);       
        l:= l^.sig;
    end;
    
end;

procedure RecorrerListaNueve(ln: listanueve);
begin
    writeln ('ApeyNom de personas con DNIs con al menos dos digitos 9');
    while (ln <> nil) do begin 
        writeln ('Apellido: ' ,ln^.dato.apellido, ' Nombre: ' ,ln^.dato.nombre);
        ln:= ln^.sig;
    end;
end;

procedure BorrarElemento(var l: lista; codigocliente: integer; var exito: boolean);
var ant, act: lista;
begin
    exito:= false;
    act:= l;
while (act <> nil) and (act^.dato.dni <> codigocliente) do begin
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
    l: lista;
    ln: listanueve;
    n: nueve;
    v: vector;
    c: cliente;
    codigocliente: integer;
    exito: boolean;
begin
    CargarVector(v);
    CargarLista(l,c);
    writeln ('Ej 1:');
    RecorrerLista(l, v, ln, n);
    writeln ('Ej 2:');
    RecorrerListaNueve(ln);
    writeln('Ingrese un dni a eliminar:');
    readln(codigocliente);
    BorrarElemento(l, codigocliente, exito);
    RecorrerLista (l, v, ln, n);
    readln();
end.
