unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, StdCtrls;

type
  TForm4 = class(TForm)
    MainMenu1: TMainMenu;
    Registros1: TMenuItem;
    Movimientos1: TMenuItem;
    PublicarVenta1: TMenuItem;
    Comprar1: TMenuItem;
    N1: TMenuItem;
    Salir1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Ayuda1: TMenuItem;
    Timer1: TTimer;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    Edit1: TEdit;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Timer1Timer(Sender: TObject);
begin
 Label1.Caption := 'Fecha: ' + DateToStr(Date) + '  Hora: '+ TimeToStr(Time);
end;

end.
