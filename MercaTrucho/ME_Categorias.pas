unit ME_Categorias;
         //fdfdsdf
interface

const
   _NomDatos='/categorias.dat';
   _NomControl='/categorias.con';
   _PosNula=-1;
type
   TipoClave=integer;
   TipoPos=longint;
   TipoRegDatos=record
                  clave:TipoClave;
                  nombreCategoria:string[50];
                  comision:double;
                  enlace:TipoPos;
                end;
    TipoArchivoDatos=file of TipoRegDatos;
    TipoRegControl=record
                     primero,ultimo:TipoPos;
                     borrado:TipoPos;
                     cantidad:integer;
                   end;
    TipoArchivoControl=file of TipoRegControl;
    TipoMe=record
            D:TipoArchivoDatos;
            C:TipoArchivoControl;
           end;

var
 ME:TipoMe;     //lista simplemente enlazada

procedure CrearMe(var ME:TipoMe;RutaMe:string);
function Buscar(var ME:TipoMe;clave:TipoClave;var Pos:TipoPos):boolean;
procedure Insertar(var ME:TipoMe;Pos:TipoPos;Reg:TipoRegDatos);
procedure Eliminar(var ME:TipoMe;Pos:TipoPos);
procedure Capturar(var ME:TipoMe; Pos:TipoPos;var Reg:TipoRegDatos);
procedure Modificar(var ME:TipoMe; Pos:TipoPos;var Reg:TipoRegDatos);
function Primero(var ME:TipoMe):TipoPos;
function Proximo(var ME:TipoMe;Pos:TipoPos):TipoPos;
function Anterior(var ME:TipoMe;Pos:TipoPos):TipoPos;
function Ultimo(var ME:TipoMe):TipoPos;
function MeVacio(var ME:TipoMe):boolean;

implementation

procedure CrearMe(var ME:TipoMe;RutaMe:string);
var
 rc:TipoRegControl;
 errorD,errorC:integer;
begin
{$I-}
assign(ME.D,RutaMe+'\categorias.DAT');
assign(ME.C,RutaMe+'\categorias.CON');
reset(ME.D);
errorD:=IOResult;
reset(ME.C);
errorC:=IOResult;

if errorD<>0 then
 rewrite(ME.D);

if errorC<>0 then
 begin
  rewrite(ME.C);
  rc.primero:=_PosNula;
  rc.ultimo:=_PosNula;
  rc.borrado:=_PosNula;
  rc.cantidad:=_PosNula+1;
  write(ME.C,rc);
 end;

close(ME.D);
close(ME.C);
reset(ME.D);
reset(ME.C);

{$I+}
end;

function Buscar(var ME:TipoMe;clave:TipoClave;var Pos:TipoPos):boolean;
var
 posActual,posAnterior:TipoPos;
 encontre,corte:boolean;
 rd:TipoRegDatos;
 rc:TipoRegControl;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 posAnterior:=_PosNula;
 posActual:=rc.primero;
 encontre:=false;
 corte:=false;
 while(not encontre)and(not corte)and(posActual<>_PosNula)do
  begin
   seek(ME.D,posActual);
   read(ME.D,rd);
   if rd.clave=clave then
    encontre:=true
   else
    if rd.clave<clave then
     begin
      posAnterior:=posActual;
      posActual:=rd.enlace;
     end
    else
     corte:=true;
  end;
 Buscar:=encontre;
 Pos:=posAnterior;
end;

procedure Insertar(var ME:TipoMe;Pos:TipoPos;Reg:TipoRegDatos);
var
 rdUlt,rdAux,rdAnt:TipoRegDatos;
 rc:TipoRegControl;
 posNueva:TipoPos;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 if rc.borrado=_PosNula then //no hay registro borrado genero un lugar al final del archivo
  posNueva:=FileSize(ME.D)
 else
  begin
   posNueva:=rc.borrado;
   seek(ME.D,rc.borrado);
   read(ME.D,rdAux);
   rc.borrado:=rdAux.enlace;
  end;

 if rc.primero=_PosNula then //primer caso ME vacio
  begin
   rc.primero:=posNueva;
   rc.ultimo:=posNueva;
   Reg.enlace:=_PosNula;
   rc.cantidad:=rc.cantidad+1;
  end
 else
  if Pos=_PosNula then //segundo caso inserto al ppio
   begin
    Reg.enlace:=rc.primero;
    rc.primero:=posNueva;
    rc.cantidad:=rc.cantidad+1;
   end
  else
   if Pos=rc.ultimo then //insertar al final
    begin
     seek(ME.D,rc.ultimo);
     read(ME.D,rdUlt);
     rdUlt.enlace:=posNueva;
     Reg.enlace:=_PosNula;
     rc.ultimo:=posNueva;
     rc.cantidad:=rc.cantidad+1;
     seek(ME.D,Pos);
     write(ME.D,rdUlt);
    end
   else //cuarto caso insero al medio
    begin
     seek(ME.D,Pos);
     read(ME.D,rdAnt);
     Reg.enlace:=rdAnt.enlace;
     rdAnt.enlace:=posNueva;
     rc.cantidad:=rc.cantidad+1;
     seek(ME.D,Pos);
     write(ME.D,rdAnt);
    end;
 //grabo todo
 seek(ME.C,0);
 write(ME.C,rc);
 seek(ME.D,posNueva);
 write(ME.D,Reg);
end;

procedure Eliminar(var ME:TipoMe;Pos:TipoPos);
var
 rc:TipoRegControl;
 rd,rdBorrado:TipoRegDatos;
 posBorrado:TipoPos;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 if rc.primero=rc.ultimo then //hay una sola celda borro y me vacio
  begin
   posBorrado:=rc.primero;
   rc.primero:=_Posnula;
   rc.ultimo:=_PosNula;
  end
 else
  if Pos=_PosNula then //borro al ppio
   begin
    posBorrado:=rc.primero;
    seek(ME.D,rc.primero);
    read(ME.D,rd);
    rc.primero:=rd.enlace;
   end
  else
   begin
    seek(ME.D,Pos);
    read(ME.D,rd);
    if rd.enlace=rc.ultimo then //borrado al final
     begin
      posBorrado:=rc.ultimo;
      rd.enlace:=_PosNula;
      rc.ultimo:=Pos;
      seek(ME.D,Pos);
      write(ME.D,rd);
     end
    else
     begin //borrado al medio
      posBorrado:=rd.enlace;
      seek(ME.D,posBorrado);
      read(ME.D,rdBorrado);
      rd.enlace:=rdBorrado.enlace;
      seek(ME.D,Pos);
      write(ME.D,rd);
     end;
   end;
//-------borrado-------------
seek(ME.D,posBorrado);
read(ME.D,rdBorrado);
rdBorrado.enlace:=rc.borrado;
rc.borrado:=posBorrado;
//----------grabo todo------------
rc.cantidad:=rc.cantidad-1;
seek(ME.C,0);
write(ME.C,rc);
seek(ME.D,posBorrado);
write(ME.D,rdBorrado);
end;

procedure Capturar(var ME:TipoMe; Pos:TipoPos;var Reg:TipoRegDatos);
var
 rc:TipoRegControl;
 rdAux:TipoRegDatos;
begin
seek(ME.C,0);
read(ME.C,rc);
 if Pos=_PosNula then //capturo al ppio
  begin
   seek(ME.D,rc.primero);
   read(ME.D,Reg);
  end
 else
  if Pos=rc.ultimo then //capturo al final
   begin
    seek(ME.D,Pos);
    read(ME.D,Reg);
   end
  else   //capturo al medio
   begin
    seek(ME.D,Pos);
    read(ME.D,rdAux);
    seek(ME.D,rdAux.enlace);
    read(ME.D,Reg);
   end;
end;

procedure Modificar(var ME:TipoMe; Pos:TipoPos;var Reg:TipoRegDatos);
var
 rc:TipoRegControl;
 rdAux,r1,r2:TipoRegDatos;
begin
 if Pos=_PosNula then   //modifico al ppio
  begin
   seek(ME.C,0);
   read(ME.C,rc);
   seek(ME.D,rc.primero);
   read(ME.D,rdAux);
   Reg.enlace:=rdAux.enlace;
   seek(ME.D,rc.primero);
   write(ME.D,Reg);
  end
 else
  begin
   seek(ME.D,Pos);
   read(ME.D,r1);
   seek(ME.D,r1.enlace);
   read(ME.D,r2);
   Reg.enlace:=r2.enlace;
   seek(ME.D,r1.enlace);
   write(ME.D,Reg);
  end;
end;

function Primero(var ME:TipoMe):TipoPos;
var
 rc:TipoRegControl;
begin
{ seek(ME.C,0);
 read(ME.C,rc);
 Primero:=rc.primero; }
 Primero:=_PosNula;
end;

function Proximo(var ME:TipoMe;Pos:TipoPos):TipoPos;
var
 rc:TipoRegControl;
 rd:TipoRegDatos;
begin
 if Pos<>_PosNula then
  begin
   seek(ME.D,Pos);
   read(ME.D,rd);
   Proximo:=rd.enlace;
  end
 else
  begin
   seek(ME.C,0);
   read(ME.C,rc);
   Proximo:=rc.primero;
  end;
end;

function Anterior(var ME:TipoMe;Pos:TipoPos):TipoPos;
var
 posAnt:TipoPos;
 rc:TipoRegControl;
 rd:TipoRegDatos;
 encontre:boolean;
begin
 encontre:=false;
 seek(ME.C,0);
 read(ME.C,rc);
 if rc.primero=Pos then
  Anterior:=_PosNula
 else
  begin
   posAnt:=rc.primero;
   while (not encontre) and (posAnt<>_PosNula) do
    begin
     seek(ME.D,posAnt);
     read(ME.D,rd);
     if rd.enlace=Pos then
      encontre:=true
     else
      posAnt:=rd.enlace;
    end;
    Anterior:=posAnt;
  end;
end;

function Ultimo(var ME:TipoMe):TipoPos;
var
 posAnt:TipoPos;
 rc:TipoRegControl;
 rd:TipoRegDatos;
 encontre:boolean;
begin
 encontre:=false;
 seek(ME.C,0);
 read(ME.C,rc);
 if rc.primero=rc.ultimo then   //hay una sola celda
  Ultimo:=_PosNula
 else
  begin
   posAnt:=rc.primero;
   while (not encontre) and (posAnt<>_PosNula) do
    begin
     seek(ME.D,posAnt);
     read(ME.D,rd);
     if rd.enlace=rc.ultimo then
      encontre:=true
     else
      posAnt:=rd.enlace;
    end;
    Ultimo:=posAnt;
  end;
end;

function MeVacio(var ME:TipoMe):boolean;
var
 rc:TipoRegControl;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 MeVacio:=rc.ultimo=_PosNula;
end;

end.
