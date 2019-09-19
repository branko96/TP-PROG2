program MercaTrucho;

uses
  Forms,
  Login in 'Login.pas' {Form_login},
  LO_Hash in 'LO_Hash.pas',
  UTipos in 'UTipos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm_login, Form_login);
  Application.Run;
end.
