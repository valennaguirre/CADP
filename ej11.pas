// 11. Realizar un programa para una empresa productora que necesita organizar 100 eventos
// culturales. De cada evento se dispone la siguiente información: nombre del evento, tipo de evento
// (1: música, 2: cine, 3: obra de teatro, 4: unipersonal y 5: monólogo), lugar del evento, cantidad
// máxima de personas permitidas para el evento y costo de la entrada. Se pide:

// 1. Generar una estructura con las ventas de entradas para tales eventos culturales. De cada
// venta se debe guardar: código de venta, número de evento (1..100), DNI del comprador y
// cantidad de entradas adquiridas. La lectura de las ventas finaliza con código de venta -1.

// 2. Una vez leída y almacenada la información de las ventas, calcular e informar:
// a. El nombre y lugar de los dos eventos que han tenido menos recaudación.
// b. La cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos
// pares que impares y que sean para el evento de tipo “obra de teatro”.
// c. Si la cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad
// máxima de personas permitidas.

program Ej11;
const
  dimF = 5; //cambiar a un num mas chico para la ejecucion
  corte = -1;
  EjC = 2; // cambiar a un num mas chico para la ejecucion
type
  cadena = string[30];
  subrango = 1..dimF;
  subrangotipo = 1..5;
  evento = record
    nombre: cadena;
    tipo: subrangotipo;
    lugar: cadena;
    maxpersona: integer;
    costo: real;
  end;
  vector = array [subrango] of evento;
  venta = record 
    codigo: integer;
    numero: subrango;
    dni: integer;
    entradastotal: integer;
  end;
  lista = ^nodo;
  nodo = record 
    dato: venta;
    sig: lista;
  end;
  vectorrecaudacion = array [subrango] of real;

procedure LeerEvento (var e: evento);
  begin
    writeln ('Ingrese nombre del evento');
    readln(e.nombre);
    writeln ('Ingrese tipo de evento (1-5)');
    readln(e.tipo);
    writeln ('Ingrese lugar del evento');
    readln(e.lugar);
    writeln ('Ingrese cant. max de personas permitidas');
    readln(e.maxpersona);
    writeln ('Ingrese costo');
    readln(e.costo);
  end;

procedure CargarVector (var ve: vector; var e: evento);
var
  i: integer;
begin
  for i := 1 to dimF do begin 
    writeln ('Evento ' ,i, ':');
    LeerEvento(e);
    ve[i]:= e;
  end;
end;

procedure LeerVenta (var v: venta);
begin
  writeln ('Ingrese codigo de venta');
  readln(v.codigo);
  if (v.codigo <> corte) then begin
    writeln ('Ingrese numero de evento');
    readln(v.numero);
    writeln ('Ingrese dni del comprador');
    readln(v.dni);
    writeln ('Ingrese cantidad de entradas adquiridas');
    readln(v.entradastotal);
  end;
end;

procedure AgregarAdelante (var l: lista; var v: venta);
var
  nue: lista;
begin
  new(nue);
  nue^.dato:= v;
  nue^.sig:= l;
  l:= nue;
end;

procedure CargarLista (var l: lista; var v: venta);
begin
  LeerVenta(v);
  while (v.codigo <> corte) do begin 
    AgregarAdelante(l, v);
    LeerVenta(v);
  end;
end;

procedure EjA(vr: vectorrecaudacion; var posmin: subrango; var posmin2: subrango);
var 
  min, min2: real;
  i: subrango;
begin
  min:= 32767;
  min2:= 32767;
  for i:= 1 to dimF do begin 
    if (vr[i]<min) then begin 
      min2:= min;
      min:= vr[i];
      posmin2:= posmin;
      posmin:= i;
    end
    else if (vr[i]<min2) then begin 
      min2:= vr[i];
      posmin2:= i;
    end;
  end;
end;

function MasParQueImpar(l: lista):boolean;
var 
  par, impar, dig, num: integer;
  exito: boolean;
begin
  exito:= false;
  par:= 0;
  impar:= 0;
  num:= l^.dato.dni;
  while (num <> 0) do begin
    dig:= num mod 2;
    if (dig = 0) then 
      par:= par+1
    else
      impar:= impar+1;
    num:= num div 10;
  end;
if (par>impar) then 
  exito:= true;
MasParQueImpar:= exito;
end;

// 2. Una vez leída y almacenada la información de las ventas, calcular e informar:
// a. El nombre y lugar de los dos eventos que han tenido menos recaudación.
// b. La cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos
// pares que impares y que sean para el evento de tipo “obra de teatro”.
// c. Si la cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad
// máxima de personas permitidas.

procedure RecorrerLista (l: lista; ve: vector; var vr: vectorrecaudacion);
var 
  posmin, posmin2: subrango;
  cant: integer;
  alcanzo: boolean;
begin
cant:= 0;
alcanzo:= false;
  while (l <> nil) do begin
    vr[l^.dato.numero]:= l^.dato.entradastotal*ve[l^.dato.numero].costo+vr[l^.dato.numero]; //datos Eja
    if (MasParQueImpar(l)=true) and (ve[l^.dato.numero].tipo = 3) then 
      cant:= cant+1;
    if (l^.dato.numero = EjC) and (ve[l^.dato.numero].maxpersona = l^.dato.entradastotal) then 
      alcanzo:= true;
    l:= l^.sig;
  end;
  EjA(vr, posmin, posmin2);
  writeln ('Eventos con menos recaudacion (nombre y lugar)');
  writeln ('',ve[posmin].nombre, 'lugar: ',ve[posmin].lugar);
  writeln ('',ve[posmin2].nombre, 'lugar: ',ve[posmin2].lugar); //EjA
  writeln ('Cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos pares que impares y que sean para el evento de tipo “obra de teatro”: ' ,cant); //EjB
  if (alcanzo = true) then 
    writeln ('La cantidad de entradas vendidas para el evento EjC alcanzó la cantidad máxima')
  else
    writeln ('EjC no alcanzó a llenar'); //EjC
end;

var 
  l: lista;
  ve: vector;
  vr: vectorrecaudacion;
  e: evento;
  v: venta;
begin 
  CargarVector (ve, e);
  CargarLista (l, v);
  RecorrerLista (l, ve, vr);
  readln();
end.




