program ejercicio2;
  var total:integer;

procedure calcular(var dig3:integer;var dig1:integer;dig2:integer);
  begin
    total:= dig3+(dig1 MOD 3);
    dig2:= dig2+(total DIV 2);
    writeln('dig2=',dig2);
  end;
  
var
  DNI,dig1,dig2,dig3:integer;
begin
  total:=-1;
  writeln ('Ingrese DNI');
  readln(DNI);
  dig1:= DNI DIV 1000;
  dig2:= DNI DIV 10000;
  dig3:= DNI DIV 1000000;
  calcular(dig1,dig2,dig3);
  writeln('total=',total);
  writeln('dig1=',dig1);
  writeln('dig2=',dig2);
  writeln('dig3=',dig3);
  readln();
end.
