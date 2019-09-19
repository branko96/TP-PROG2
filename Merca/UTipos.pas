unit UTipos;
Interface
uses
  SysUtils;
Const
  _PosNula = -1;
  _MenosUno = -1;
  _TopeReg = 200;
  _Cero = 0;
  _Uno = 1;
  _Mil = 1000;
  _Ruta='C:\Users\BRANKO\Desktop\JUAN 23 TODO\TP FINAL PROG 2\TP-PROG2\Merca\';
  _RutaCompartida='\\DESKTOP-TGJ9CFQ\wasapocompartida\';
  //_RutaCompartida='\\ANITA-PC\Users\';
  _ArchivoDUsuarios= 'Usuarios.dat';
  _ArchivoCUsuarios= 'Usuarios.con';
  _ArchivoDChatsCompartido= 'ChatsCompartido.dat';
  _ArchivoCChatsCompartido= 'ChatsCompartido.con';
  _ArchivoXChatsCompartido= 'ChatsCompartido.ntx';
  _ArchivoNChatsCompartido= 'ChatsCompartido.niv';
  _ArchivoDContactos= 'Contactos.dat';
  _ArchivoCContactos= 'Contactos.con';
  _ArchivoDEstados= 'Estados.dat';
  _ArchivoCEstados = 'Estados.con';
  _ArchivoDChatsLocal= 'ChatsLocal.dat';
  _ArchivoCChatsLocal= 'ChatsLocal.con';
  _ArchivoDEstadosAux= 'EstadosDAux.dat';
  _ArchivoCEstadosAux = 'EstadosCAux.con';
  _ArchivoDEstadosUsuario= 'EstadosDUsuario.dat';
  _ArchivoCEstadosUsuario= 'EstadosCUsuario.con';
  _ArchivoDEstadosUsuarioAux= 'EstadosDUsuarioAux.dat';
  _ArchivoCEstadosUsuarioAux= 'EstadosCUsuarioAux.con';
type
  TBooleano=Boolean;
  TCantidad=Longint;
  TCodigoLocalidad=String[4];
  TCodigoPais=String[2];
  TEntero=Int64;
  TFechaHora=String[25];
  TNivel=Tentero;
  TNumeroCelular=String[15];
  TPosicion=Longint;
  TString=String[100];
  TRuta=String[100];
//*****HASH CON COLISIONES ABIERTO*****
  TRDUsuarios = Record
                 Id_Interno:TEntero;
                 Nro:TEntero;
                 Nombre:TString;
                 Apellido:TString;
                 Contrasenia:TString;
                 Fecha_Hora:TFechaHora;
                 En_Linea:TBooleano;
                 Estado:TString;
                 Ultima_Conexion:TFechaHora;
                 Visible:TBooleano;
                end;
//*****LISTA DOBLE*****
  TRDChatsCompartido = Record
                        Numero_Mensaje:TEntero;
                        Id_UsuarioEmisor:TEntero;
                        Id_UsuarioReceptor:TEntero;
                        Mensaje:TString;
                        Fecha_Hora:TFechaHora;
                        Mensaje_Enviado:TBooleano;
                        Mensaje_Recibido:TBooleano;
                        Mensaje_Leido:Tbooleano;
                        Anterior:TPosicion;
                        Siguiente:TPosicion;
                      end;
//*****ARBOL BINARIO*****
  TRDContactos = Record
                  Id_Interno:TEntero;
                  Numero_Celular:TEntero;
                  Nombre:TString;
                  Apellido:TString;
                  Registrado:TBooleano;
                  Bloqueado:TBooleano;
                  Estado:TString;
                  En_Linea:TBooleano;
                  Ultima_Conexion:TFechaHora;
                  Padre:TPosicion;
                  Hijo_Izquierdo:TPosicion;
                  Hijo_Derecho:TPosicion;
                 end;
//*****PILA*****
  TRDEstados = Record
                Id_Interno:TEntero;
                Texto:TString;
                Fecha_Hora:TFechaHora;
                Enlace:TPosicion;
               end;

//*****LISTA DOBLE*****
  TRDChatsLocal = Record
                   Clave:TEntero;
                   Numero_Mensaje:TEntero;
                   Mensaje_Usuario:TString;
                   Fecha_Hora:TFechaHora;
                   Mensaje_Enviado:TBooleano;
                   Mensaje_Recibido:TBooleano;
                   Mensaje_Leido:Tbooleano;
                   Anterior:TPosicion;
                   Siguiente:TPosicion;
                  end;

//*****Arbol Trinario*****
   TRXChatsCompartido = Record
                         Clave:TEntero;
                         IDUsuarioA:TEntero;
                         IDUsuarioB:TEntero;
                         Primero:TPosicion;
                         Ultimo:TPosicion;
                         CantMensaje:TEntero;
                         Padre:TPosicion;
                         HijoDerecho:TPosicion;
                         HijoIzquierdo:TPosicion;
                         HijoMedio:TPosicion;
                        end;
//*****Control*****
  TRCChatsCompartido = Record
                        Raiz:TPosicion;
                        Borrados:TPosicion;
                        UltimoNivel:TEntero;
                        Porcentaje:TEntero;
                        Cant:TEntero;
                        CantMensajesTotal:TEntero;
                       end;
  TRCContactos = Record
                  Raiz:TPosicion;
                  RutaMECompartido:TString;
                  Cantidad:TEntero;
                  Borrados:TPosicion;
                  HayConexion:TBooleano;
                  UltIdInterno:TEntero;
                 end;
  TRControl = Record
               Primero:Tposicion;
               Ultimo:TPosicion;
               Borrado:TPosicion;
               Cant:TEntero;
               UltIdInterno:TEntero;
              end;
  TRCEstados = Record
                Incremental:TEntero;
                Borrados:TPosicion;
                Primero:TPosicion;
                Cant:TEntero;
               end;
  TRNChatsCompartido = Record
                        Nivel: TNivel;
                       end;

  TArchivoDChatsCompartido=File of TRDChatsCompartido;
  TArchivoCChatsCompartido=File of TRCChatsCompartido;
  TArchivoNChatsCompartido=File of TRNChatsCompartido;
  TArchivoXChatsCompartido=File of TRXChatsCompartido;

  TArchivoDUsuarios=File of TRDUsuarios;
  TArchivoCUsuarios=File of TRControl;

  TArchivoCBloqueados=File of TRControl;

  TArchivoDContactos=File of TRDContactos;
  TArchivoCContactos=File of TRCContactos;

  TArchivoDEstados=File of TRDEstados;
  TArchivoCEstados=File of TRCEstados;

  TArchivoDChatsLocal=File of TRDChatsLocal;
  TArchivoCChatsLocal=File of TRControl;

  TipoMEUsuarios = Record
                    D:TArchivoDUsuarios;
                    C:TArchivoCUsuarios;
                   end;
  TipoMEChatsCompartido = Record
                           D:TArchivoDChatsCompartido;
                           C:TArchivoCChatsCompartido;
                           X:TArchivoXChatsCompartido;
                           N:TArchivoNChatsCompartido;
                          end;
  TipoMEContactos = Record
                     D:TArchivoDContactos;
                     C:TArchivoCContactos;
                    end;
  TipoMEEstados = Record
                   D:TArchivoDEstados;
                   C:TArchivoCEstados;
                  end;

  TipoMEChatsLocal = Record
                      D:TArchivoDChatsLocal;
                      C:TArchivoCChatsLocal;
                     end;
Implementation
End.
