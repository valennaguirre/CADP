program EjFinal;
const 
    dimF = 10;
    ultletra = 'z';
type 
    subrango = 1..dimF;
    alfabeto = 'a'..ultletra;
    vector = array [subrango] of char;
    vletras = array [alfabeto] of integer;

procedure CargarVector (var v: vector);
var i: subrango;
c: char;
begin
     for i:= 1 to dimF do  begin
         writeln('Ingrese un caracter');
         readln(c);
         v[i]:= c;
     end;
end;

procedure RecorrerVector (v: vector; var vl: vletras);
var 
    i: integer;
begin
    for i:= 1 to dimF do 
        vl[v[i]]:= vl[v[i]]+1;
end;

procedure ImprimirVectorLetras(vl: vletras);
var 
    c: char;
begin
    for c:= 'a' to 'z' do
        writeln ('Letra ' ,c, ': ' ,vl[c], ' repeticiones.');
end;

var 
    v: vector;
    vl: vletras;
begin 
    CargarVector(v);
    RecorrerVector(v, vl);
    ImprimirVectorLetras(vl);
    readln();
end.
        


