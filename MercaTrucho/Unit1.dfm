object Form1: TForm1
  Left = 319
  Top = 195
  Width = 929
  Height = 480
  Caption = 'MercaTrucho'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 913
    Height = 73
    Align = alTop
    BorderWidth = 5
    TabOrder = 0
    object Button1: TButton
      Left = 744
      Top = 16
      Width = 75
      Height = 41
      Caption = 'Registrarse'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 824
      Top = 16
      Width = 75
      Height = 41
      Caption = 'Mi Cuenta'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 73
    Width = 913
    Height = 328
    Caption = 'Panel2'
    TabOrder = 1
  end
end
