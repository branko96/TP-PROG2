object Form_login: TForm_login
  Left = 226
  Top = 266
  Width = 928
  Height = 480
  Caption = 'Form_login'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 160
    Top = 56
    Width = 417
    Height = 225
    Caption = 'Login'
    TabOrder = 0
    object Label1: TLabel
      Left = 80
      Top = 40
      Width = 36
      Height = 13
      Caption = 'Usuario'
    end
    object Label2: TLabel
      Left = 80
      Top = 104
      Width = 56
      Height = 13
      Caption = 'Contrase'#241'a'
    end
    object btn_login: TButton
      Left = 152
      Top = 168
      Width = 75
      Height = 25
      Caption = 'Ingresar'
      TabOrder = 0
    end
    object user: TEdit
      Left = 168
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object pass: TEdit
      Left = 168
      Top = 104
      Width = 121
      Height = 21
      TabOrder = 2
    end
  end
end
