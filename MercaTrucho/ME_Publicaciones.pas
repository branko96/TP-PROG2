unit ME_Publicaciones;

interface

const
  _Null = - 1 ;

type                                  //arbol binario avl
  TipoLongint = longint;
  TipoPosicion=longint;
  TipoEntero=integer;
  TipoArticulos = (Usado , Nuevo);
  TipoEstado = (Publicar, Pausado, Vendido, Anulado, Bloqueado);
  TipoString  = string[50];
  TipoRangoIndice = _Null..MAXINT;
  TipoNiveles=longint;
  TipoDatos = record
               id_publicado:TipoEntero;
               id_categoria:TipoEntero;
               id_vendedor:TipoString;
               nom_articulo:TipoString;
               descripcion:TipoString;
               precio_venta:double;
               fecha_publicacion:TDateTime;
               fecha_cierre:TDateTime;
               tipo_articulo:TipoArticulos;
               estado:TipoEstado;
               enlace:TipoPosicion;
              end ;
  TipoArchivoDatos = file of TipoDatos;

  TipoControl=record
               ult_id_interno:TipoLongint;
               raiz_indice_1:TipoRangoIndice;
               raiz_indice_2:TipoRangoIndice;
               borrados_indice_1:TipoRangoIndice;
               borrados_indice_2:TipoRangoIndice;
               borrados_ventas:TipoRangoIndice;
               primero_ventas:TipoRangoIndice;
               ultimo_ventas:TipoRangoIndice;
               cantidad_indice_1: integer;
               cant_niveles_indice_1: integer;
               cantidad_indice_2: integer;
               cant_niveles_indice_2: integer;
              end;
  TipoArchivoControl=file of TipoControl;

  TipoNTX_1=record
             id_vendedor:TipoEntero;
             posicion:TipoPosicion;//es la posicion del elemento en el archivo TipoArchivoDatos
             hijo_izq,hijo_der,padre:TipoPosicion;
             borrado: boolean;
             nivel:integer;
            end;
  TipoArchivoNTX1=file of TipoNTX_1;

  TipoNTX_2=record
             id_categoria:TipoEntero;
             hijo_izq,hijo_der,padre:TipoPosicion;
             posicion:TipoPosicion;
             borrado: boolean;
             nivel:integer;
            end;
  TipoArchivoNTX2=file of TipoNTX_2;

  TipoMe=record
          D:TipoArchivoDatos;
          C:TipoArchivoControl;
          NTX1:TipoArchivoNTX1;
          NTX2:TipoArchivoNTX2;
         end;

var
 Me:TipoMe;

Procedure CrearArbol(var Me:TipoMe;Ruta:String);
//-------------metodos del archivo de Datos-----------------
function BuscarDatos(var Me:TipoMe;clave:TipoEntero;var Pos:TipoPosicion):boolean;
procedure InsertarDatos(var Me:TipoMe;Pos:TipoPosicion;Reg:TipoDatos);
procedure Eliminar(var ME:TipoMe;Pos:TipoPosicion);
procedure Capturar(var ME:TipoMe; Pos:TipoPosicion;var Reg:TipoDatos);
procedure Modificar(var ME:TipoMe; Pos:TipoPosicion;var Reg:TipoDatos);
function Primero(var ME:TipoMe):TipoPosicion;
function Proximo(var ME:TipoMe;Pos:TipoPosicion):TipoPosicion;
function Anterior(var ME:TipoMe;Pos:TipoPosicion):TipoPosicion;
function Ultimo(var ME:TipoMe):TipoPosicion;
function MeVacio(var ME:TipoMe):boolean;
//-------------finalizacion de metodos del archivo de Datos-----------------

//-------------metodos del archivo de NTX1 vendedores-----------------
function BuscarNTX1(var Me:TipoMe;clave:TipoEntero; var Pos:TipoPosicion):boolean;
procedure InsertarNTX1(var Me:TipoMe;Pos:TipoPosicion;RegNTX1:TipoNTX_1);
Procedure AjustarNivelesNTX1(var Me:TipoMe;Pos:TipoPosicion);
Function TieneHijoIzquierdoNTX1(Var Me:TipoMe; Pos:TipoPosicion):boolean;
Function TieneHijoDerechoNTX1(Var Me:TipoMe; Pos:TipoPosicion):boolean;
Procedure RecorrerArbol_AjustarNivelesNTX1(var Me:TipoMe; pos:TipoPosicion);
function PadreAnteriorNTX1(var Me:TipoMe;Pos:TipoPosicion):TipoPosicion;
function HijoIzqNTX1(var Me:TipoMe;Pos:TipoPosicion):TipoPosicion;
function HijoDerNTX1(var Me:TipoMe;Pos:TipoPosicion):TipoPosicion;
function ArbolVacioNTX1(var Me:TipoMe):boolean;
procedure CapturarNTX1(var Me:TipoMe;Pos:TipoPosicion;var RegNTX1:TipoNTX_1);
procedure ModificarNTX1(var Me:TipoMe;Pos:TipoPosicion;RegNTX1:TipoNTX_1);
//-------------finalizacion de metodos del archivo de NTX1 vendedores-----------------

implementation

procedure CrearArbol(var Me:TipoMe;Ruta:String);
var
 ErrorControl,ErrorDatos,ErrorNtx1,ErrorNtx2:integer;
 rc:TipoControl;
begin
  assign(Me.C,Ruta+'\publicados.con');
  assign(Me.D,Ruta+'\publicados.dat');
  assign(Me.NTX1,Ruta+'\publicados.ntx1');
  assign(Me.NTX2,Ruta+'\publicados.ntx2');

{$I-}
 reset(Me.C);
 ErrorControl:=IOResult;
 if ErrorControl<>0 then
  begin
   rewrite(Me.C);
   rc.ult_id_interno:=_Null;
   rc.raiz_indice_1:=_Null;
   rc.raiz_indice_2:=_Null;
   rc.borrados_indice_1:=_Null;
   rc.borrados_indice_2:=_Null;
   rc.borrados_ventas:=_Null;
   rc.primero_ventas:=_Null;
   rc.ultimo_ventas:=_Null;
   rc.cantidad_indice_1:=_Null;
   rc.cant_niveles_indice_1:=_Null;
   rc.cantidad_indice_2:=_Null;
   rc.cant_niveles_indice_2:=_Null;
   write(Me.C,rc);
   close(Me.C);
   reset(Me.C);
  end;

 reset(Me.D);
 ErrorDatos:=IOResult;
 if ErrorDatos<>0 then
  begin
   rewrite(Me.D);
   close(Me.D);
   reset(Me.D);
  end;

 reset(Me.NTX1);
 ErrorNtx1:=IOResult;
 if ErrorNtx1<>0 then
  begin
   rewrite(Me.NTX1);
   close(Me.NTX1);
   reset(Me.NTX1);
  end;

 reset(Me.NTX2);
 ErrorNtx2:=IOResult;
 if ErrorNtx2<>0 then
  begin
   rewrite(Me.NTX2);
   close(Me.NTX2);
   reset(Me.NTX2);
  end;

{$I+}
end;

//-------------metodos del archivo de Datos-----------------

function BuscarDatos(var Me:TipoMe;clave:TipoEntero;var Pos:TipoPosicion):boolean;
var
 posActual,posAnterior:TipoPosicion;
 encontre,corte:boolean;
 rd:TipoDatos;
 rc:TipoControl;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 posAnterior:=_Null;
 posActual:=rc.primero_ventas;
 encontre:=false;
 corte:=false;
 while(not encontre)and(not corte)and(posActual<>_Null)do
  begin
   seek(ME.D,posActual);
   read(ME.D,rd);
   if rd.id_publicado=clave then
    encontre:=true
   else
    if rd.id_publicado<clave then
     begin
      posAnterior:=posActual;
      posActual:=rd.enlace;
     end
    else
     corte:=true;
  end;
 BuscarDatos:=encontre;
 Pos:=posAnterior;
end;

procedure InsertarDatos(var Me:TipoMe;Pos:TipoPosicion;Reg:TipoDatos);
var
 rdUlt,rdAux,rdAnt:TipoDatos;
 rc:TipoControl;
 posNueva:TipoPosicion;
 ultId:TipoEntero;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 ultId:=rc.ult_id_interno+1;
 if rc.borrados_ventas=_Null then //no hay registro borrado genero un lugar al final del archivo
  posNueva:=FileSize(ME.D)
 else
  begin
   posNueva:=rc.borrados_ventas;
   seek(ME.D,rc.borrados_ventas);
   read(ME.D,rdAux);
   rc.borrados_ventas:=rdAux.enlace;
  end;

 if rc.primero_ventas=_Null then //primer caso ME vacio
  begin
   rc.primero_ventas:=posNueva;
   rc.ultimo_ventas:=posNueva;
   rc.ult_id_interno:=ultId;
   Reg.id_publicado:=ultId;
   Reg.enlace:=_Null;
  end
 else
  if Pos=_Null then //segundo caso inserto al ppio
   begin
    Reg.enlace:=rc.primero_ventas;
    rc.ult_id_interno:=ultId;
    Reg.id_publicado:=ultId;
    rc.primero_ventas:=posNueva;
   end
  else
   if Pos=rc.ultimo_ventas then //insertar al final
    begin
     seek(ME.D,rc.ultimo_ventas);
     read(ME.D,rdUlt);
     rdUlt.enlace:=posNueva;
     Reg.enlace:=_Null;
     rc.ultimo_ventas:=posNueva;
     rc.ult_id_interno:=ultId;
     Reg.id_publicado:=ultId;
     seek(ME.D,Pos);
     write(ME.D,rdUlt);
    end
   else //cuarto caso insero al medio
    begin
     seek(ME.D,Pos);
     read(ME.D,rdAnt);
     Reg.enlace:=rdAnt.enlace;
     rdAnt.enlace:=posNueva;
     rc.ult_id_interno:=ultId;
     Reg.id_publicado:=ultId;
     seek(ME.D,Pos);
     write(ME.D,rdAnt);
    end;
 //grabo todo
 seek(ME.C,0);
 write(ME.C,rc);
 seek(ME.D,posNueva);
 write(ME.D,Reg);
end;

procedure Eliminar(var ME:TipoMe;Pos:TipoPosicion);
var
 rc:TipoControl;
 rd,rdBorrado:TipoDatos;
 posBorrado:TipoPosicion;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 if rc.primero_ventas=rc.ultimo_ventas then //hay una sola celda borro y me vacio
  begin
   posBorrado:=rc.primero_ventas;
   rc.primero_ventas:=_Null;
   rc.ultimo_ventas:=_Null;
  end
 else
  if Pos=_Null then //borro al ppio
   begin
    posBorrado:=rc.primero_ventas;
    seek(ME.D,rc.primero_ventas);
    read(ME.D,rd);
    rc.primero_ventas:=rd.enlace;
   end
  else
   begin
    seek(ME.D,Pos);
    read(ME.D,rd);
    if rd.enlace=rc.ultimo_ventas then //borrado al final
     begin
      posBorrado:=rc.ultimo_ventas;
      rd.enlace:=_Null;
      rc.ultimo_ventas:=Pos;
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
rdBorrado.enlace:=rc.borrados_ventas;
rc.borrados_ventas:=posBorrado;
//----------grabo todo------------
seek(ME.C,0);
write(ME.C,rc);
seek(ME.D,posBorrado);
write(ME.D,rdBorrado);
end;

procedure Capturar(var ME:TipoMe; Pos:TipoPosicion;var Reg:TipoDatos);
var
 rc:TipoControl;
 rdAux:TipoDatos;
begin
seek(ME.C,0);
read(ME.C,rc);
 if Pos=_Null then //capturo al ppio
  begin
   seek(ME.D,rc.primero_ventas);
   read(ME.D,Reg);
  end
 else
  if Pos=rc.ultimo_ventas then //capturo al final
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

procedure Modificar(var ME:TipoMe; Pos:TipoPosicion;var Reg:TipoDatos);
var
 rc:TipoControl;
 rdAux,r1,r2:TipoDatos;
begin
 if Pos=_Null then   //modifico al ppio
  begin
   seek(ME.C,0);
   read(ME.C,rc);
   seek(ME.D,rc.primero_ventas);
   read(ME.D,rdAux);
   Reg.enlace:=rdAux.enlace;
   seek(ME.D,rc.primero_ventas);
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

function Primero(var ME:TipoMe):TipoPosicion;
var
 rc:TipoControl;
begin
 Primero:=_Null;
end;

function Proximo(var ME:TipoMe;Pos:TipoPosicion):TipoPosicion;
var
 rc:TipoControl;
 rd:TipoDatos;
begin
 if Pos<>_Null then
  begin
   seek(ME.D,Pos);
   read(ME.D,rd);
   Proximo:=rd.enlace;
  end
 else
  begin
   seek(ME.C,0);
   read(ME.C,rc);
   Proximo:=rc.primero_ventas;
  end;
end;

function Anterior(var ME:TipoMe;Pos:TipoPosicion):TipoPosicion;
var
 posAnt:TipoPosicion;
 rc:TipoControl;
 rd:TipoDatos;
 encontre:boolean;
begin
 encontre:=false;
 seek(ME.C,0);
 read(ME.C,rc);
 if rc.primero_ventas=Pos then
  Anterior:=_Null
 else
  begin
   posAnt:=rc.primero_ventas;
   while (not encontre) and (posAnt<>_Null) do
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

function Ultimo(var ME:TipoMe):TipoPosicion;
var
 posAnt:TipoPosicion;
 rc:TipoControl;
 rd:TipoDatos;
 encontre:boolean;
begin
 encontre:=false;
 seek(ME.C,0);
 read(ME.C,rc);
 if rc.primero_ventas=rc.ultimo_ventas then   //hay una sola celda
  Ultimo:=_Null
 else
  begin
   posAnt:=rc.primero_ventas;
   while (not encontre) and (posAnt<>_Null) do
    begin
     seek(ME.D,posAnt);
     read(ME.D,rd);
     if rd.enlace=rc.ultimo_ventas then
      encontre:=true
     else
      posAnt:=rd.enlace;
    end;
    Ultimo:=posAnt;
  end;
end;

function MeVacio(var ME:TipoMe):boolean;
var
 rc:TipoControl;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 MeVacio:=rc.ultimo_ventas=_Null;
end;
//-------------finalizacion del archivo de Datos------------

//-------------metodos del archivo de NTX1 Vendedores(Arbol AVL con rotacion)-----------------
function BuscarNTX1(var Me:TipoMe;clave:TipoEntero; var Pos:TipoPosicion):boolean;
var
 encontre:boolean;
 PosAnt:TipoPosicion;
 rc:TipoControl;
 rntx1:TipoNTX_1;
begin
 seek(ME.C,0);
 read(ME.C,rc);
 Pos:=rc.raiz_indice_1;
 encontre:=false;
 PosAnt:=_Null;
 while (not encontre)and(Pos<>_Null)do
  begin
   seek(ME.NTX1,Pos);
   read(ME.NTX1,rntx1);
   if rntx1.id_vendedor=clave then
    encontre:=true
   else
    begin
     PosAnt:=Pos;
     if clave<=rntx1.id_vendedor then
      Pos:=rntx1.hijo_izq
     else
      Pos:=rntx1.hijo_der;
    end;
  end;
  if not encontre then
   Pos:=PosAnt;       //devuelve la posicion del padre
 BuscarNTX1:=encontre;
end;

procedure InsertarNTX1(var Me:TipoMe;Pos:TipoPosicion;RegNTX1:TipoNTX_1);
var
 rc:TipoControl;
 RegAux,regAux2:TipoNTX_1;
 PosNueva:TipoPosicion;
begin
 seek(Me.C,0);
 read(Me.C,rc);
 if rc.borrados_indice_1=_Null then
  PosNueva:=FileSize(Me.NTX1)
 else
  begin
   PosNueva:=rc.borrados_indice_1;
   seek(ME.NTX1,PosNueva);
   read(ME.NTX1,RegAux);
   rc.borrados_indice_1:=RegAux.hijo_der;
  end;

 if rc.raiz_indice_1=_Null then //arbol vacio
  begin
   RegNTX1.padre:=_Null;
   RegNTX1.nivel:=0;
   RegNTX1.borrado:=false;
   rc.raiz_indice_1:=PosNueva;
  end
 else //insertar hoja
  begin
   seek(ME.NTX1,Pos);
   read(ME.NTX1,RegAux);
   if RegNTX1.id_vendedor<=RegAux.id_vendedor then
     RegAux.hijo_izq:=PosNueva
   else
     RegAux.hijo_der:=PosNueva;
   RegNTX1.padre:=Pos;
   seek(ME.NTX1,Pos);
   write(ME.NTX1,RegAux);
  end;
 RegNTX1.hijo_izq:=_Null;
 RegNTX1.hijo_der:=_Null;
 seek(ME.C,0);
 write(ME.C,rc);
 seek(ME.NTX1,PosNueva);
 write(ME.NTX1,RegNTX1);

end;

Procedure AjustarNivelesNTX1(var Me:TipoMe;Pos:TipoPosicion);
var
 RI:TipoNTX_1;
 nivel:integer;
 hijod,hijoi:TipoPosicion;
begin
  Seek(Me.NTX1,Pos);    //el nodo ntx1
  Read(Me.NTX1,RI);
  nivel:=RI.nivel;
  hijod:=RI.hijo_der;
  hijoi:=RI.hijo_izq;
  if hijod<>_Null then
       begin
        Seek(Me.NTX1,hijod);
        Read(Me.NTX1,RI);
        RI.nivel:=nivel+1;
        Seek(Me.NTX1,hijod);
        Write(Me.NTX1,RI);
       end;
  if hijoi<>_Null then
       begin
        Seek(Me.NTX1,hijoi);
        Read(Me.NTX1,RI);
        RI.nivel:=nivel+1;
        Seek(Me.NTX1,hijoi);
        Write(Me.NTX1,RI);
       end;

end;

Function TieneHijoIzquierdoNTX1(Var Me:TipoMe; Pos:TipoPosicion):boolean;
var
 RI:TipoNTX_1;
begin
  Seek(Me.NTX1,Pos);
  Read(Me.NTX1,RI);
  if RI.hijo_izq <> _Null
  then TieneHijoIzquierdoNTX1:=true
  else TieneHijoIzquierdoNTX1:=false;
end;

Function TieneHijoDerechoNTX1(Var Me:TipoMe; Pos:TipoPosicion):boolean;
var RI:TipoNTX_1;
begin
  Seek(Me.NTX1,pos);
  Read(Me.NTX1,RI);
  if RI.hijo_der <> _Null
  then TieneHijoDerechoNTX1:=true
  else TieneHijoDerechoNTX1:=false;
end;

Procedure RecorrerArbol_AjustarNivelesNTX1(var Me:TipoMe; pos:TipoPosicion);
var
 RI:TipoNTX_1;
begin
Seek(Me.NTX1,pos);
Read(Me.NTX1,RI);
AjustarNivelesNTX1(Me,pos);
if TieneHijoIzquierdoNTX1(Me,pos)
  then begin
        RecorrerArbol_AjustarNivelesNTX1(Me,RI.hijo_izq);
       end;

if TieneHijoDerechoNTX1(Me,pos)
then begin
      RecorrerArbol_AjustarNivelesNTX1(Me,RI.hijo_der);
     end;
end;

function PadreAnteriorNTX1(var Me:TipoMe;Pos:TipoPosicion):TipoPosicion;
var
 rntx1:TipoNTX_1;
begin
 seek(Me.NTX1,Pos);
 read(Me.NTX1,rntx1);
 PadreAnteriorNTX1:=rntx1.padre;
end;

function HijoIzqNTX1(var Me:TipoMe;Pos:TipoPosicion):TipoPosicion;
var
 rntx1:TipoNTX_1;
begin
 seek(Me.NTX1,Pos);
 read(Me.NTX1,rntx1);
 HijoIzqNTX1:=rntx1.hijo_izq;
end;

function HijoDerNTX1(var Me:TipoMe;Pos:TipoPosicion):TipoPosicion;
var
 rntx1:TipoNTX_1;
begin
 seek(Me.NTX1,Pos);
 read(Me.NTX1,rntx1);
 HijoDerNTX1:=rntx1.hijo_der;
end;

function ArbolVacioNTX1(var Me:TipoMe):boolean;
var
 rc:TipoControl;
begin
 seek(Me.C,0);
 read(Me.C,rc);
 ArbolVacioNTX1:=rc.raiz_indice_1=_Null;
end;

procedure CapturarNTX1(var Me:TipoMe;Pos:TipoPosicion;var RegNTX1:TipoNTX_1);
begin
 seek(Me.NTX1,Pos);
 read(Me.NTX1,RegNTX1);
end;

procedure ModificarNTX1(var Me:TipoMe;Pos:TipoPosicion;RegNTX1:TipoNTX_1);
var
 Raux:TipoNTX_1;
begin
 seek(Me.NTX1,Pos);
 read(Me.NTX1,Raux);
 RegNTX1.padre:=Raux.padre;
 RegNTX1.hijo_izq:=Raux.hijo_izq;
 RegNTX1.hijo_der:=Raux.hijo_der;
 seek(Me.NTX1,Pos);
 write(Me.NTX1,RegNTX1);
end;
//-------------finalizacion del archivo de NTX1 Vendedores------------

//-------------metodos del archivo de NTX2 Categorias-----------------
//-------------finalizacion del archivo de NTX2 Categorias------------

end.
