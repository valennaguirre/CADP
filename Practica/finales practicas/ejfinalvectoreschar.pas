// Práctico: Se dispone de un vector de caracteres ordenados alfabéticamente (de a lo suma 100 elementos) 
// que puede aparecer repetidos Se pide generar un vector que contenga la cantidad total de repeticiones 
// de cada uno de los caracteres alfabeticos. Luego se debe imprimir el vector resultante

program EjFinal1;
const
  dimF = 100;
  corte = 'q';
type 
  vcaracteres = array [1..dimF] of char;
  vector = array ['a'..'z'] of integer;

procedure CargarVectorContador(var v: vector);
var 
  c: char;
begin
  for c := 'a' to 'z' do
    v[c]:= 0;  
end;

procedure LeerVector(var ve: vcaracteres; var v: vector);
var 
  dimL: integer;
  dato: char;
begin
  dimL:= 1;
  writeln('Ingrese un caracter alfabetico');
  readln(dato);
  while (dimL<=dimF) and (dato <> corte) do begin 
    ve[dimL]:= dato;
    v[dato]:= v[dato]+1;
    dimL:= dimL+1;
    writeln('Ingrese un caracter alfabetico');
    readln(dato);
  end;  
end;

procedure RecorrerVector(v: vector);
var 
  c: char;
begin
  for c:= 'a' to 'z' do
      if (v[c] <> 0) then
         writeln ('Letra ' ,c, ': ' ,v[c], ' repeticiones.');
end;

var 
  v: vector;
  ve: vcaracteres;
begin 
  CargarVectorContador(v);
  LeerVector(ve, v);
  RecorrerVector(v);
  readln();
end.

// Procedure InsertarElemOrd (var v: vector;  var dimL: indice; elem : TipoElem; 
//                                          var exito: boolean);

//   Function DeterminarPosicion ( x: integer;  v:Vector; dimL: Indice): Indice;
//      var pos : Indice;
//     begin
//         pos:=1;
//          while (pos<=dimL) and (x > v[pos]) do 
//           pos:=pos+1;
//         DeterminarPosicion:= pos;
//       end; 

//   Procedure Insertar (var v:vector; var dimL:Indice; pos: Indice; elem:integer);
//     var j: indice;
//     begin
//         for j:= dimL downto pos do 
//           v [ j +1 ] := v [ j ] ;
//         v [ pos ] := elem; 
//         dimL := dimL + 1;
//     End;

//  var pos: indice;

// Begin
//    exito := false;  
//    if (dimL < dimF) then begin
//                         pos:= DeterminarPosicion (elem, v, dimL);
//                                     Insertar (v, dimL, pos, elem);
//                                     exito := true;
//                                end;
// end;

