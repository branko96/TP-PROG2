program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ME_Usuarios in 'ME_Usuarios.pas',
  ME_Categorias in 'ME_Categorias.pas',
  ME_Publicaciones in 'ME_Publicaciones.pas',
  ME_Compras in 'ME_Compras.pas',
  ME_Mensajes in 'ME_Mensajes.pas',
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
