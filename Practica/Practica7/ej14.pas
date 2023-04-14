// 14. La oficina de becas y subsidios desea optimizar los distintos tipos de ayuda financiera que se brinda a alumnos de
// la UNLP. Para ello, esta oficina cuenta con un registro detallado de todos los viajes realizados por una muestra de
// 1300 alumnos durante el mes de marzo. De cada viaje se conoce el código de alumno (entre 1 y 1300), día del mes,
// Facultad a la que pertenece y medio de transporte (1. colectivo urbano; 2. colectivo interurbano; 3. tren
// universitario; 4. tren Roca; 5. bicicleta). Tener en cuenta que un alumno puede utilizar más de un medio de
// transporte en un mismo día.

// Además, esta oficina cuenta con una tabla con información sobre el precio de cada tipo de viaje.
// Realizar un programa que lea la información de los viajes de los alumnos y los almacene en una estructura de datos
// apropiada. La lectura finaliza al ingresarse el código de alumno -1, que no debe procesarse.

// Una vez finalizada la lectura, informar:
// a. La cantidad de alumnos que realizan más de 6 viajes por día
// b. La cantidad de alumnos que gastan en transporte más de $80 por día
// c. Los dos medios de transporte más utilizados.
// d. La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte.

program Ej14;
const 
    fin = 10; // 1300
    corte = -1;
type 
    subrango = 1..fin;
    medio = 1..5;
    cadena = string[30];
    viaje = record 
        codigo: integer;
        dia: integer;
        facultad: cadena;
        transporte: medio;
    end;
    mediotransporte = record 
        cant: integer;
        precio: real;
    end;   
    tipoviaje = array [medio] of integer; // medios de transporte utilizados por los alumnos
    alumno = record 
        cantviajes: integer;
        gastos: real;
        viajes: tipoviaje;
    end;
    contador = array [subrango] of alumno; // vector que almacena cant. de viajes por alumno y cuanto gastó
    precioycantviajes = array [medio] of mediotransporte; // se dispone (precios de los transportes) y cantidad de usos de cada transporte
    lista = ^nodo;
    nodo = record 
        dato: viaje;
        sig: lista;
    end;

procedure InicializarVectorTransporte (var ve: precioycantviajes);
var 
    i: medio;
    num: real;
begin
num:= 20;
    for i:= 1 to 5 do begin
        ve[i].precio:= num;
        writeln ('Precio del transporte ' ,i, ': ' ,ve[i].precio:3:2);
        ve[i].cant:= 0;
        num:= num+13.5;
    end;
end;

procedure CargarContador (var c: contador);
var 
    i: subrango;
    j: medio;
begin
    for i:= 1 to fin do begin
        c[i].cantviajes:= 0;
        c[i].gastos:= 0;
        for j:= 1 to 5 do
            c[i].viajes[j]:= 0;
    end;
end;

procedure LeerViaje(var v: viaje);
begin
    writeln ('Ingrese codigo de alumno: ');
    readln(v.codigo);
    if (v.codigo <> corte) then begin 
        writeln ('Dia del viaje: ');
        readln(v.dia);
        writeln ('Facultad: ');
        readln(v.facultad);
        writeln ('Medio de Transporte (1-5): ');
        readln(v.transporte);
    end;
end;

procedure AgregarAdelante(var l: lista; var v: viaje);
var 
    nue: lista;
begin
    new(nue);
    nue^.dato:= v;
    nue^.sig:= l;
    l:= nue;
end;

procedure CargarLista(var l: lista; var v: viaje);
var
   cont: integer;
begin
cont:= 1;
    LeerViaje(v);
    while (v.codigo <> corte) do begin 
        AgregarAdelante(l, v);
        cont:= cont+1;
        writeln ('Eje n�' ,cont);
        LeerViaje(v);
    end;
end;

// a. La cantidad de alumnos que realizan más de 6 viajes por día
// b. La cantidad de alumnos que gastan en transporte más de $80 por día
// c. Los dos medios de transporte más utilizados.
// d. La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte.

procedure RecorrerLista(l: lista; var c: contador; var ve: precioycantviajes);
begin
    while (l <> nil) do begin
        c[l^.dato.codigo].cantviajes:= c[l^.dato.codigo].cantviajes+1;
        c[l^.dato.codigo].gastos:= c[l^.dato.codigo].gastos+ve[l^.dato.transporte].precio;
        c[l^.dato.codigo].viajes[l^.dato.transporte]:= c[l^.dato.codigo].viajes[l^.dato.transporte]+1;
        ve[l^.dato.transporte].cant:= ve[l^.dato.transporte].cant+1;
    l:= l^.sig; 
    end; 
end;

procedure Informar(pos: integer; pos2: integer; cm: integer; mdo: integer; bym: integer);
begin
    writeln ('Cantidad de alumnos con mas de 2 viajes: ' ,cm);
    writeln ('Cantidad de alumnos con mas de 80 pesos de gastos: ' ,mdo);
    writeln ('Cantidad de alumnos que combinan bicicleta con otro medio: ' ,bym);
    writeln ('Medios de transporte mas utilizados: ' ,pos, ' y ' ,pos2);
end;

procedure RecorrerVectorTransportes(ve: precioycantviajes; cm: integer; mdo: integer; bym: integer);
var 
    i: medio;
    max, max2, pos, pos2: integer;
begin
max:= -1;
max2:= -1;
pos:= 0;
pos2:= 0;
    for i:= 1 to 5 do begin 
        writeln ('Transporte n�' ,i, ': ' ,ve[i].cant, 'usos.');
        if (ve[i].cant>max) then begin 
            max2:= max;
            max:= ve[i].cant;
            pos2:= pos;
            pos:= i;
        end
        else if (ve[i].cant>max2) then begin 
            max2:= ve[i].cant;
            pos2:= i;
        end; 
     end;
Informar (pos, pos2, cm, mdo, bym);
end;

procedure RecorrerContador(c: contador; ve: precioycantviajes);
var 
    i: subrango;
    cantmasseis, masdeochenta, bicicletayotromedio: integer;
    exito: boolean;
    j: medio;
begin
cantmasseis:= 0;
masdeochenta:= 0;
bicicletayotromedio:= 0;
    for i:= 1 to fin do begin
        exito:= false;
        if (c[i].cantviajes>2) then // debe ser > 6, puse > 2 para ejecutar
            cantmasseis:= cantmasseis+1;
        if (c[i].gastos>80) then 
            masdeochenta:= masdeochenta+1;
            for j:= 5 downto 1 do begin
                if (c[i].viajes[5] >= 1) then
                    if (c[j].viajes[j] >= 1) and (exito = false) then begin
                        bicicletayotromedio:= bicicletayotromedio+1;
                        exito:= true;
                    end;
            end;
    end;
writeln ('Valor en cantmasseis (mas de dos viajes): ' ,cantmasseis);
writeln ('Valor en masdeochenta: ' ,masdeochenta);
writeln ('Valor en bicicletayotromedio: ' ,bicicletayotromedio);
RecorrerVectorTransportes(ve, cantmasseis, masdeochenta, bicicletayotromedio);
end;

var
    ve: precioycantviajes;
    c: contador;
    l: lista;
    v: viaje;
begin 
    InicializarVectorTransporte(ve);
    CargarContador(c);
    CargarLista(l, v);
    writeln('llego');
    RecorrerLista(l, c, ve);
    RecorrerContador (c, ve);
    readln();
end.





    
