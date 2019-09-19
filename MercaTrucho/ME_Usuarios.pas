unit ME_Usuarios;

interface

const
  _PosNula     = -1;
  _MAX         = 80;
  _clave_admin = 'palo_y_a_la_bolsa';

type
  RangoVector = _PosNula+1.._MAX;
  TipoString  = string[50];
  TipoPosicion= _PosNula+1.._MAX;
  TipoRegDatos = record
                     email : TipoString;
                     clave : TipoString;
                     apellido_nombre : TipoString;
                     domicilio : TipoString;
                     provincia : 0..25;
                     fecha_hora : TDateTime; {creation timestamp}
                     foto : TipoString;
                     id_usuario:longint;
                     estado : boolean;
                     fecha_hora_ult_conexion : TDateTime; {login timestamp}
                     borrado:boolean;
                  end;
  TipoArchDatos  = file of TipoRegDatos;
  TipoRegControl = record
                     ultimo_id : longint;
                     cantidad_claves : RangoVector;
                   end;
  TipoArchControl = file of TipoRegControl;

  TipoMe = record
            D : TipoArchDatos;
            C : TipoArchControl;
           end;

var
 ME:TipoMe;

procedure CrearHash(var ME:TipoMe;NombreMe:string;RutaMe:string);
function DameHash(var ME:TipoMe;email:string) : integer;
function ProximaPos():TipoPosicion;
function BuscarHash(var ME:TipoMe;email:string;var pos:TipoPosicion):boolean;
function ExploracionLineal(var ME:TipoMe;email:string;var pos:TipoPosicion):boolean;
procedure InsertarHasH(var ME:TipoME; reg:TipoRegDatos; var pos:TipoPosicion);
procedure EliminarHasH(var ME:TipoME;var pos:TipoPosicion);

implementation

procedure CrearHash(var ME:TipoMe;NombreMe:string;RutaMe:string);
var
 RC:TipoRegControl;
 RD:TipoRegDatos;
 i:integer;
 errorD,errorC:boolean;
begin
 {$I-}
 assign(ME.D,RutaMe+NombreMe+'.DAT');
 assign(ME.C,RutaMe+NombreMe+'.CON');
 reset(ME.D);
 errorD:=IOResult<>0;
 reset(ME.C);
 errorC:=IOResult<>0;
 if (errorD) and(errorC) then
   begin
    rewrite(ME.D);
    rewrite(ME.C);
    RC.ultimo_id:=0;
    RC.cantidad_claves:=0;
    write(ME.C,RC);
    RD.email:='pepe@gmail.com';
    RD.borrado:=false;
    for i:=0 to _MAX do
     begin
      seek(ME.D, i);
      write(ME.D,RD);
     end;
   end;
   close(ME.D);
   close(ME.C);
 {$I+}
end;

//------funciones aleatorias---------------

function DameHash(var ME:TipoMe;email:string) : integer;
var
  i: integer;
begin
  result:= 0;
  // Obtener el valor numérico
  for i:=1 to Length(email) do
    result := result + Ord(email[i]);

  // Ajustar al tamaño de la tabla
  result := result mod _MAX;
  DameHash:=result;
end;

function ProximaPos():TipoPosicion;
begin
    ProximaPos := (pos + 1) mod (_MAX + 1);
end;

//-------funciones principales----------

function BuscarHash(var ME:TipoMe;email:string;var pos:TipoPosicion):boolean;
var
 rd:TipoRegDatos;
begin
    pos:= DameHash(ME,email);
    seek(ME.D,pos);
    read(ME.D,rd);
    if(rd.email=email)and(rd.borrado=false)then
       BuscarHash:=true
    else
       BuscarHash:=ExploracionLineal(ME,email,pos);
end;

function ExploracionLineal(var ME:TipoMe;email:string;var pos:TipoPosicion):boolean;
var
 posI,posF,posVacio:TipoPosicion;
 encontre:boolean;
 regI,regF:TipoRegDatos;
begin
encontre:=false;
posVacio:=_PosNula+1;
 if pos>0 then
   posI:=pos-1
 else
   pos:=_MAX;

 if pos<_MAX then
   posF:=pos+1
 else
   pos:=0;

 while (posI<>posF) and (not encontre) do
 begin
   seek(ME.D,posI);
   read(ME.D,regI);
   if (regI.email=email) and (regI.borrado=false) then
     begin
       encontre:=true;
       pos:=posI;
     end
   else
     begin
       if posI>0 then
        posI:=posI-1
       else
        posI:=_MAX;

       seek(ME.D,posF);
       read(ME.D,regF);
       if (regF.email=email) and (regF.borrado=false) then
        begin
         encontre:=true;
         pos:=posF;
        end
       else
        begin
         if posF<_MAX then
           posF:=posF+1
         else
           posF:=0;
        end;

       if (not encontre) and (posVacio=_PosNula+1) then
         begin
          if regF.borrado=true then
            posVacio:=posF
          else
           begin
            if regI.borrado=true then
             posVacio:=posI;
           end;
         end;

     end; //termina el primer else
 end; //termina el bucle while

 ExploracionLineal:=encontre;
 if (not encontre) then
  pos:=posVacio;
end;

procedure InsertarHasH(var ME:TipoME; reg:TipoRegDatos; var pos:TipoPosicion);
var
 rc:TipoRegControl;
begin
 seek(ME.C, 0);
 read(ME.C, rc);
 if(rc.ultimo_id=_PosNula+1)then
  rc.ultimo_id:=pos
 else
  if pos>rc.ultimo_id then
   rc.ultimo_id:=pos;
 rc.cantidad_claves:=rc.cantidad_claves+1;
 reg.borrado:=false;
 reg.id_usuario:=rc.ultimo_id;
 seek(ME.C, 0);
 write(ME.C, rc);
 seek(ME.D, pos);
 write(ME.D, reg);
end;

procedure EliminarHasH(var ME:TipoME;var pos:TipoPosicion);
var
 rd,regNueva:TipoRegDatos;
 rc:TipoRegControl;
 encontrado:boolean;
 posNueva:TipoPosicion;
begin
 seek(ME.D,pos);
 read(ME.D,rd);
 rd.borrado:=true;
 seek(ME.D,pos);
 write(ME.D,rd);

 seek(ME.C, 0);
 read(ME.C, rc);
 rc.cantidad_claves:=rc.cantidad_claves-1;
 if(pos=rc.ultimo_id)then
   begin
     encontrado:=false;
     posNueva:=rc.ultimo_id-1;
     while not encontrado do
      begin
        seek(ME.D, posNueva);
        read(ME.D, regNueva);
        if regNueva.borrado=false then
         encontrado:=true
        else
         posNueva:=posNueva-1;
      end;
     rc.ultimo_id:=posNueva;
   end;
 seek(ME.C,0);
 write(ME.C,rc);
end;

end.
