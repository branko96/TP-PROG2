unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, ME_Categorias, Grids;

type
  TForm5 = class(TForm)
    MainMenu1: TMainMenu;
    Inicio1: TMenuItem;
    Estado1: TMenuItem;
    N1: TMenuItem;
    Salir1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    TabSheet3: TTabSheet;
    TreeView1: TTreeView;
    Button4: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure actualizarTable(var ME:ME_Categorias.TipoMe);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}



procedure TForm5.Timer1Timer(Sender: TObject);
begin
Label1.Caption := 'Fecha: ' + DateToStr(Date) + '  Hora: '+ TimeToStr(Time);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='Clave';
  StringGrid1.Cells[1,0]:='Nombre del Rubro';
  StringGrid1.Cells[2,0]:='Comision';
  Form5.actualizarTable(ME_Categorias.ME);
end;

procedure TForm5.Button1Click(Sender: TObject);
var
 p:ME_Categorias.TipoPos;
 b:boolean;
 rd:ME_Categorias.TipoRegDatos;
begin
  b:=ME_Categorias.Buscar(ME_Categorias.ME,StrToInt(Edit1.Text),p);
  if b=false then
    begin
     rd.clave:=StrToInt(Edit1.Text);
     rd.nombreCategoria:=Edit2.Text;
     rd.comision:=StrToFloat(Edit3.Text);
     ME_Categorias.Insertar(ME_Categorias.ME,p,rd);
   //  showMessage('categoria insertada');
     Form5.actualizarTable(ME_Categorias.ME);
     Edit1.Text:='';
     Edit2.Text:='';
     Edit3.Text:='';
    end;
end;

procedure TForm5.actualizarTable(var ME:ME_Categorias.TipoMe);
var
 posActual,posSig,ult:ME_Categorias.TipoPos;
 corte:boolean;
 rd:ME_Categorias.TipoRegDatos;
 i:integer;
begin
if ME_Categorias.MeVacio(ME_Categorias.ME)=false then
begin
 posActual:=ME_Categorias.Primero(ME_Categorias.ME);
 ult:=ME_Categorias.Ultimo(ME_Categorias.ME);
 corte:=false;
 i:=1 ;
   while (not corte) do
    begin
     StringGrid1.RowCount := i + 1;
     ME_Categorias.Capturar(ME_Categorias.ME,posActual,rd);
     StringGrid1.Cells[0,i]:=inttostr(rd.clave);
     StringGrid1.Cells[1,i]:=rd.nombreCategoria;
     StringGrid1.Cells[2,i]:=floattostr(rd.comision);
     if posActual=ult then
      corte:=true
     else
      begin
       posSig:=posActual;
       posActual:=ME_Categorias.Proximo(ME_Categorias.ME,posSig);
       i:=i+1;
      end;
    end;
end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
 p:ME_Categorias.TipoPos;
 b:boolean;
 rd:ME_Categorias.TipoRegDatos;
 botonSeleccionado : Integer;
begin
 b:=ME_Categorias.Buscar(ME_Categorias.ME,StrToInt(Edit1.Text),p);
  if b=true then
    begin
     botonSeleccionado := messagedlg('Seguro que desea Eliminarlo',mtError, mbOKCancel, 0);
     if botonSeleccionado = mrOK     then
      begin
       ME_Categorias.Eliminar(ME_Categorias.ME,p);
       Form5.actualizarTable(ME_Categorias.ME);
       Edit1.Text:='';
      end;
    end
   else
    showMessage('No se encontro el Registro');
end;

procedure TForm5.Button3Click(Sender: TObject);
var
 p:ME_Categorias.TipoPos;
 b:boolean;
 rd:ME_Categorias.TipoRegDatos;
 botonSeleccionado : Integer;
begin
 b:=ME_Categorias.Buscar(ME_Categorias.ME,StrToInt(Edit1.Text),p);
  if b=true then
    begin
     rd.clave:=strtoint(Edit1.Text);
     rd.nombreCategoria:=Edit2.Text;
     rd.comision:=strtofloat(Edit3.Text);
     ME_Categorias.Modificar(ME_Categorias.ME,p,rd);
     Form5.actualizarTable(ME_Categorias.ME);
     Edit1.Text:='';
    end
   else
    showMessage('No se encontro el Registro');
end;

end.
