unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_login = class(TForm)
    GroupBox1: TGroupBox;
    btn_login: TButton;
    Label1: TLabel;
    user: TEdit;
    Label2: TLabel;
    pass: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_login: TForm_login;

implementation

{$R *.dfm}

end.
