unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit4, Unit5, Unit2;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
Application.Initialize;
Application.CreateForm(TForm4, Form4);
if Edit2.Text='palo' then
  begin
    Form5.Show;
  end
else
  begin
    Form4.Show;
  end;

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
Application.Initialize;
Application.CreateForm(TForm2, Form2);
Form2.Show;
end;

end.
