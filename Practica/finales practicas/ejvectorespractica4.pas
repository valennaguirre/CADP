// 5. Una farmacia requiere el procesamiento de sus medicamentos. De cada medicamento se conoce su código, nombre, 
// laboratorio, componente principal, stock y precio unitario. 
// El procesamiento finaliza con el código -1 y se sabe que a lo sumo existen 1000 medicamentos.
// Se pide:
// Generar la estructura de datos que almacene los medicamentos.
// Leer un medicamento e insertarlo en una posición que también se lee. 
// Eliminar de la estructura el medicamento de una posición que se lee.

program EjVectores;
const 
    dimF = 1000;
    corte = -1;
type 
    cadena = string[40];
    medicamento = record 
        codigo: integer;
        nombre: cadena;
        laboratorio: cadena;
        componente: cadena;
        stock: integer;
        precio: real;
    end;
    vector = array [1..dimF] of medicamento;

procedure LeerMedicamento(var m: medicamento);
begin
    writeln ('Codigo: ');
    readln (m.codigo);
    if (m.codigo <> corte) then begin 
        writeln ('Nombre: ');
        readln (m.nombre);
        writeln ('Laboratorio: ');
        readln (m.laboratorio);
        writeln ('Componente principal: ');
        readln (m.componente);
        writeln ('Stock: ');
        readln (m.stock);
        writeln ('Precio: ');
        readln (m.precio);
    end;
end;

procedure CargarVector(var v: vector; var dimL: integer; m: medicamento);
begin
    LeerMedicamento(m);
    while (dimL<dimF) and (m.codigo <> corte) do begin 
        dimL:= dimL+1;
        v[dimL]:= m;
        LeerMedicamento(m);
    end;
end;

procedure InsertarElemento(var v: vector; var dimL: integer; m: medicamento; pos: integer);
var 
    i: integer;
    exito: boolean;
begin
exito:= false;
    if (pos <=dimL) and (pos>=1) and (dimL<dimF) then begin
        exito:= true;
        for i:= dimL downto pos do
            v[i+1]:= v[i];
        v[pos]:= m;
        dimL:= dimL+1;
    end;
if (exito = true) then 
    writeln ('La operacion se realizó con éxito')
else
    writeln ('Error.');
end;

procedure EliminarElemento(var v: vector; var dimL: integer; pos: integer);
var 
    i: integer;
    exito: boolean;
begin
    exito:= false;
    if (pos <= dimL) and (pos>=1) then begin
        for i:= pos +1 to dimL do 
            v[i-1]:= v[i];
        dimL:= dimL-1;
        exito:= true;
    end;
if (exito = true) then 
    writeln ('Se elimino la posicion correctamente.')
else
    writeln ('Error.');
end;

procedure RecorrerVector (v: vector; dimL: integer);
var
   i: integer;
begin
     for i:= 1 to dimL do
         writeln ('Codigo: ' ,v[i].codigo, ' nombre: ' ,v[i].nombre);
end;

var 
    v: vector;
    dimL: integer;
    m: medicamento;
    pos: integer;
begin 
    dimL:= 0;
    CargarVector(v, dimL, m);
    RecorrerVector (v, dimL);
    writeln ('Ingrese una posicion para insertar el medicamento (1-' ,dimL, ').');
    readln(pos);
    writeln ('A continuacion, complete los datos del medicamento a insertar:');
    LeerMedicamento(m);
    InsertarElemento(v, dimL, m, pos);
    RecorrerVector (v, dimL);
    writeln ('Ingrese la posicion del medicamento que quiere eliminar:');
    readln(pos);
    EliminarElemento(v, dimL, pos);
    RecorrerVector (v, dimL);
    readln();
end.
