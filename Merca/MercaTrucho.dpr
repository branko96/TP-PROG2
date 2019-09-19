program MercaTrucho;

uses
  Forms,
  Login in 'Login.pas' {Form_login};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm_login, Form_login);
  Application.Run;
end.
