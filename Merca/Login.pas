unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LO_Hash;

type
  TForm_login = class(TForm)
    GroupBox1: TGroupBox;
    btn_login: TButton;
    Label1: TLabel;
    user: TEdit;
    Label2: TLabel;
    pass: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_loginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_login: TForm_login;

implementation

{$R *.dfm}

procedure TForm_login.FormCreate(Sender: TObject);
begin
LO_Hash.CrearME(LO_Hash.ME);
end;

procedure TForm_login.btn_loginClick(Sender: TObject);
begin
 //WriteLn(user.Text);
 Label1.Caption:=user.Text;
end;

end.
