unit ME_Compras;

interface

const
  _PosNula = -1;
  _MAX = 50;

type
  nuevo_usado = (New, Used);
  TipoCalificacion  = (None, Good, Neutral, Bad);
  TipoRangoVector = _PosNula.._MAX;
  TipoPosicion=longint;
  TipoClave = string[50];
  TipoRegDatos = record
                     id_comprador: TipoClave;
                     id_publicado: longint;
                     nombre_articulo: string[50];
                     precio_venta: double;
                     fecha_publicacion: TDateTime;
                     fecha_venta: TDateTime;
                     tipo_articulo: nuevo_usado;
                     calificacion_comprador: TipoCalificacion;
                     porcentaje_comision: double;
                     comision_cobrada : boolean;
                     proximo  : TipoRangoVector;
                     anterior : TipoRangoVector;
                end;
  TipoArchivoDatos= file of TipoRegDatos;

  TipoControl = record
                 borrados_venta : TipoPosicion;
                end;
  TipoArchivoControl= file of TipoControl;

  TipoRegHash= record
                 primero : TipoRangoVector;
                 ultimo  : TipoRangoVector;
                 total : integer;
               end;
  TipoArchHash = file of TipoRegHash;

  TipoMe = record
             D : TipoArchivoDatos;
             C : TipoArchivoControl;
             Hash : TipoArchHash;
           end;

var
 ME:TipoMe  ;

procedure CrearHash(var ME:TipoMe;NombreMe:string;RutaMe:string);

implementation

procedure CrearHash(var ME:TipoMe;NombreMe:string;RutaMe:string);
var
 RH:TipoRegHash;
 RC:TipoControl;
 i:integer;
 errorHash,errorD,errorC:boolean;
begin
 {$I-}
 assign(ME.Hash,RutaMe+NombreMe+'.HASH');
 assign(ME.D,RutaMe+NombreMe+'.DAT');
 assign(ME.C,RutaMe+NombreMe+'.CON');
 reset(ME.Hash);
 errorHash:=IOResult<>0;
 reset(ME.D);
 errorD:=IOResult<>0;
 reset(ME.C);
 errorC:=IOResult<>0;
 if (errorHash) and (errorD) and(errorC) then
   begin
    rewrite(ME.D);
    RC.borrados_venta:=_PosNula;
    rewrite(ME.C);
    write(ME.C,RC);
    RH.primero:=_PosNula;
    RH.ultimo:=_PosNula;
    RH.total:=0;
    for i:=0 to _MAX do
      seek(ME.Hash,i);
      write(ME.Hash,RH);
   end;
   close(ME.Hash);
   close(ME.D);
   close(ME.C);
 {$I+}
end;

end.
