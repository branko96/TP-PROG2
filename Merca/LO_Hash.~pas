unit LO_Hash;
Interface
uses
  UTipos, Messages, Dialogs, SysUtils;
//Declaración de funciones y procedimientos************************************************************
Procedure CrearMe(Var Me:TipoMeUsuarios);
Procedure AbrirMe(Var Me:TipoMeUsuarios);
Procedure CerrarMe(Var Me:TipoMeUsuarios);
Function BuscarPos(Var Me:TipoMeUsuarios; Num:TEntero):TPosicion;
Function ExisteNro(Var Me:TipoMeUsuarios; Num:TEntero; Pos:TPosicion):TBooleano;
Function CapturarRD(Var Me:TipoMeUsuarios; Pos:TPosicion):TRDUsuarios;
Function CapturarRC(Var Me:TipoMeUsuarios):TRControl;
Procedure ModificarRD(Var Me:TipoMeUsuarios; Pos:TPosicion; RD:TRDUsuarios);
Procedure EliminarRD(Var Me:TipoMeUsuarios; Pos:TPosicion; RD:TRDUsuarios);
Procedure InsertarRD(Var Me:TipoMeUsuarios; Pos:TPosicion; RD:TRDUsuarios);
//Implementación de funciones y procedimientos*********************************************************
implementation
//Crea el método estructural***************************************************************************
Procedure CrearMe(Var Me:TipoMEUsuarios);
Var
 RC:TRControl;
 RD:TRDUsuarios;
 Pos:TPosicion;
 I:TEntero;
Begin
 {$I-}
 AssignFile(Me.C,_RutaCompartida+_ArchivoCUsuarios);
 AssignFile(Me.D,_RutaCompartida+_ArchivoDUsuarios);
 Pos:=_Cero;
 Reset(Me.C);
 If (IOResult<>_Cero) then
  begin
   ReWrite(Me.C);
   Seek (Me.C,Pos);
   RC.Primero:=_PosNula;
   RC.Ultimo:=_PosNula;
   RC.Borrado:=_PosNula;
   RC.Cant:=_Cero;
   RC.UltIdInterno:=_Cero;
   Write(Me.C,RC);
  end;
  Reset(Me.D);
  If (IOResult<>_Cero) then
   begin
    Rewrite(Me.D);
    I:=_Cero;
    RD.Nro:=_MenosUno;
    RD.Id_Interno:=_MenosUno;
    RD.Nombre:='';
    RD.Apellido:='';
    RD.Contrasenia:='';
    RD.Fecha_Hora:=DateToStr(Now) + ' ' + TimeToStr(Now);
    RD.Estado:='';
    RD.Ultima_Conexion:=DateToStr(Now) + ' ' + TimeToStr(Now);
    RD.Visible:=false;
    While (I<_TopeReg) do
     begin
      Seek(Me.D,I);
      Write(Me.D,RD);
      I:=I+_Uno;
     end;
   end;
 Close(Me.D);
 Close(Me.C);
 {$I+}
End;
//Abre el método estructural***************************************************************************
Procedure AbrirMe(Var Me:TipoMeUsuarios);
Begin
 AssignFile(Me.D,_RutaCompartida+_ArchivoDUsuarios);
 AssignFile(Me.C,_RutaCompartida+_ArchivoCUsuarios);
 Reset(Me.D);
 Reset(Me.C);
End;
//Cierra el método estructural**************************************************************************
Procedure CerrarMe(Var Me:TipoMeUsuarios);
Begin
 Close(Me.D);
 Close(Me.C);
End;
//Devuelve la posición en la que se encuentra el número pasado por parámetro****************************
Function BuscarPos(Var Me:TipoMeUsuarios; Num:TEntero):TPosicion;
Var
 K,I:TEntero;
 Posaux:TEntero;
 Encontre:TBooleano;
 RD:TRDUsuarios;
Begin
  AbrirMe(Me);
  I:=_Cero;
  Encontre:=false;
  K:=Num div _TopeReg;
  While (not Encontre) and (I<=_TopeReg) do
   begin
    PosAux:=(Num + (K*I))mod _TopeReg;
    AbrirMe(Me);
    Seek(Me.D,PosAux);
    Read(Me.D,RD);
    If (RD.Nro=_MenosUno) then
     Encontre:=true
    else
     If (RD.Nro=Num) then
      Encontre:=true
     else
      I:=I+_Uno;
   end;
  BuscarPos:=PosAux;
  Close(Me.D);
  Close(Me.C);
End;
//Devuelve verdadero si existe el número en la posición pasada por parámetro, falso en caso contrario***
Function ExisteNro(Var Me:TipoMeUsuarios; Num:TEntero; Pos:TPosicion):TBooleano;
Var
 RD:TRDUsuarios;
 Existe:TBooleano;
Begin
 Reset(Me.D);
 Reset(Me.C);
 Seek(Me.D,Pos);
 Read(Me.D,RD);
 Existe:=false;
 if (RD.Nro=Num) then
  Existe:=true;
 ExisteNro:= Existe;
 Close(Me.D);
End;
//Devuelve el registro de datos*************************************************************************
Function CapturarRD(Var Me:TipoMeUsuarios; Pos:TPosicion):TRDUsuarios;
Var
 RD:TRDUsuarios;
Begin
 Reset(Me.D);
 Seek(Me.D,Pos);
 Read(Me.D,RD);
 CapturarRD:=RD;
End;
//Devuelve el registro de control***********************************************************************
Function CapturarRC(Var Me:TipoMeUsuarios):TRControl;
Var
 RC:TRControl;
Begin
 Reset(Me.C);
 While not(EoF(Me.C)) do
  begin
   Seek(Me.C,_Cero);
   Read (Me.C,RC);
   CapturarRC:=RC;
  end;
 Close(Me.C);
End;
//Modifica un registro de datos*************************************************************************
Procedure ModificarRD(Var Me:TipoMeUsuarios; Pos:TPosicion; RD:TRDUsuarios );
Begin
 Reset(Me.D);
 Seek(Me.D,Pos);
 Write(Me.D,RD);
End;
//Elimina un registro de datos**************************************************************************
Procedure EliminarRD(Var Me:TipoMeUsuarios; Pos:TPosicion; RD:TRDUsuarios );
Var
 RC: TRControl;
Begin
 Reset(Me.C);
 Reset(Me.D);
 Seek(Me.D,Pos);
 Seek(Me.C,_Cero);
 Read(Me.C,RC);
 RC.Cant:= RC.Cant-_Uno;
 Write(Me.D,RD);
 Seek(Me.C,_Cero);
 Write(Me.C,RC);
End;
//Inserta un RD en la posición pasada por parámetro*****************************************************
Procedure InsertarRD(Var Me:TipoMeUsuarios; Pos:TPosicion; RD:TRDUsuarios);
Var
 RC:TRControl;
Begin
 Reset(Me.D);
 Reset(Me.C);
 Seek(Me.D,Pos);
 Seek(Me.C,_Cero);
 Read(Me.C,RC);
 RC.Cant:=RC.Cant+_Uno;
 RC.UltIdInterno:=RC.Cant;
 RD.Id_Interno:=RC.UltIdInterno;
 Write(Me.D,RD);
 Seek(Me.C,_Cero);
 Write(Me.C,RC);
End;
//*****************************************************************************************************
End.
