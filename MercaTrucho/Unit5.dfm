object Form5: TForm5
  Left = 360
  Top = 154
  Width = 928
  Height = 508
  Caption = 'Administrador'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 912
    Height = 69
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 176
      Top = 32
      Width = 55
      Height = 20
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 380
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 910
      Height = 378
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Categorias'
        object Label2: TLabel
          Left = 16
          Top = 80
          Width = 49
          Height = 19
          Caption = 'Clave:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 16
          Top = 120
          Width = 146
          Height = 19
          Caption = 'Nombre del Rubro:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 16
          Top = 160
          Width = 79
          Height = 19
          Caption = 'Comision:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edit1: TEdit
          Left = 80
          Top = 80
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 176
          Top = 120
          Width = 177
          Height = 21
          TabOrder = 1
        end
        object Edit3: TEdit
          Left = 104
          Top = 160
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object StringGrid1: TStringGrid
          Left = 408
          Top = 40
          Width = 465
          Height = 241
          ColCount = 3
          DefaultColWidth = 153
          FixedCols = 0
          RowCount = 2
          TabOrder = 3
        end
        object Button1: TButton
          Left = 40
          Top = 224
          Width = 83
          Height = 33
          Caption = 'Alta'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 136
          Top = 224
          Width = 83
          Height = 33
          Caption = 'Baja'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 232
          Top = 224
          Width = 83
          Height = 33
          Caption = 'Modificar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = Button3Click
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Usuarios'
        ImageIndex = 1
      end
      object TabSheet3: TTabSheet
        Caption = 'Arbol'
        ImageIndex = 2
        object TreeView1: TTreeView
          Left = 120
          Top = 16
          Width = 241
          Height = 297
          Indent = 19
          TabOrder = 0
        end
        object Button4: TButton
          Left = 472
          Top = 248
          Width = 75
          Height = 25
          Caption = 'Button4'
          TabOrder = 1
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 48
    object Inicio1: TMenuItem
      Caption = 'Reportes'
      object N1: TMenuItem
        Caption = '-'
      end
      object Salir1: TMenuItem
        Caption = 'Salir'
      end
    end
    object Estado1: TMenuItem
      Caption = 'Estado'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 104
    Top = 392
  end
end
