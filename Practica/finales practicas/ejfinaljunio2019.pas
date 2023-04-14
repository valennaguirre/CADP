// PRACTICA: Se lee Información de las ventas de productos de un comercio. 
// De cada venta se conoce código de venta, código de producto y cantidad vendida. 
// La lectura finaliza cuando se ingresa el código de venta 9999. 

// Se pide implementar un programa que genere una lista ordenada por código de producto. 
// Una vez generada la lista se debe informar la cantidad total de productos vendidos, 
// para un código de producto que se ingresa por teclado

program Ej;
const 
  corte = 9999;
type 
  venta = record 
    codigo: integer;
    codproducto: integer;
    cantidad: integer;
  end;
  lista = ^nodo;
  nodo = record 
    dato: venta;
    sig: lista;
  end;

procedure LeerVenta(var v: venta);
begin
  writeln ('Ingrese codigo de venta');
  readln(v.codigo);
  if (v.codigo <> corte) then begin
    writeln ('Ingrese codigo de producto');
    readln(v.codproducto);
    writeln ('Ingrese cantidad vendida');
    readln(v.cantidad);
  end;
end;

procedure InsertarOrdenado(var l: lista; v: venta);
var 
  ant, nue, act: lista;
begin
  new(nue);
  nue^.dato:= v;
  act:= l;
  ant:= l;
  while (act<>nil) and (act^.dato.codproducto < v.codproducto) do begin 
    ant:= act;
    act:= act^.sig;
  end;
  if (ant = act) then
    l:= nue
  else
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure CargarLista(var l: lista; var v: venta);
begin
  LeerVenta(v);
  while (v.codigo <> corte) do begin 
    InsertarOrdenado(l, v);
    LeerVenta(v);
  end;
end;

procedure RecorrerLista(l: lista; num: integer);
var 
  ventas: integer;
begin
ventas:= 0;
  while (l <> nil) do begin 
    writeln ('codigo producto: ' ,l^.dato.codproducto, ' codigo venta: ' ,l^.dato.codigo,  ' cantidad vendida: ' ,l^.dato.cantidad);
    if (num = l^.dato.codproducto) then 
      ventas:= ventas+l^.dato.cantidad;
    l:= l^.sig;
  end;
  writeln ('La cantidad de ventas del codigo de producto ' ,num, ' ha sido ' ,ventas, '.');  
end;

var 
  num: integer;
  l: lista;
  v: venta;
begin 
  CargarLista (l, v);
  writeln ('Ingrese un codigo de producto para que se informe la cantidad de ventas del mismo');
  readln(num);
  RecorrerLista(l, num);
  readln();
end.
