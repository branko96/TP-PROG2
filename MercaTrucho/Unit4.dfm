object Form4: TForm4
  Left = 200
  Top = 127
  Width = 928
  Height = 480
  Caption = 'Mi Cuenta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 360
    Align = alClient
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 910
      Height = 358
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Publicar Articulo'
        object Label2: TLabel
          Left = 264
          Top = 112
          Width = 32
          Height = 13
          Caption = 'Label2'
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Comprar Articulo'
        ImageIndex = 1
        object Edit1: TEdit
          Left = 416
          Top = 88
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 360
    Width = 912
    Height = 61
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 1
    object Label1: TLabel
      Left = 240
      Top = 24
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
  object MainMenu1: TMainMenu
    Left = 48
    Top = 80
    object Registros1: TMenuItem
      Caption = 'Registros'
      object PublicarVenta1: TMenuItem
        Caption = 'Publicar Venta'
      end
      object Comprar1: TMenuItem
        Caption = 'Comprar'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Salir1: TMenuItem
        Caption = 'Salir'
      end
    end
    object Movimientos1: TMenuItem
      Caption = 'Estado'
    end
    object Ayuda1: TMenuItem
      Caption = 'Ayuda'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 184
    Top = 376
  end
end
