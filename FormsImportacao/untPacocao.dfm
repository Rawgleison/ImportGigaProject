object frmPacocao: TfrmPacocao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Pacocao'
  ClientHeight = 388
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    575
    388)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 175
    Top = 8
    Width = 381
    Height = 50
    Alignment = taCenter
    Caption = 'VERIFICAR CODIFICA'#199#195'O DO ARQUIVO'#13#10'(Acentua'#231#227'o)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
  end
  object Label3: TLabel
    Left = 288
    Top = 64
    Width = 158
    Height = 26
    Alignment = taCenter
    Caption = 'Basta abrir o arquivo '#13#10'e cliecar em converter para ANSI'
  end
  object Panel1: TPanel
    Left = 0
    Top = 333
    Width = 575
    Height = 55
    Align = alBottom
    TabOrder = 1
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 573
      Height = 30
      Align = alBottom
      Progress = 0
      ExplicitLeft = 8
      ExplicitTop = -16
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 573
      Height = 19
      Align = alTop
      Alignment = taCenter
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 46
    end
  end
  object vleConexao: TValueListEditor
    Left = 0
    Top = 162
    Width = 575
    Height = 171
    Align = alBottom
    Strings.Strings = (
      'Database=C:\Gigatron\GigaERP\Base\GigaERP.FDB'
      'User_Name=sysdba'
      'Password=lib1503'
      'Server=LocalHost'
      'Port=3060'
      'DriverID=FB'
      'Pooled=False')
    TabOrder = 2
    TitleCaptions.Strings = (
      'Key'
      'Value'
      'Padrao')
    ColWidths = (
      150
      419)
  end
  object butGravar: TButton
    Left = 492
    Top = 302
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 550
    Top = 183
    Width = 21
    Height = 18
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object butImport: TButton
    Left = 8
    Top = 40
    Width = 145
    Height = 65
    Caption = 'IMPORTAR'
    TabOrder = 0
    OnClick = butImportClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 112
    Width = 575
    Height = 50
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'USAR SCRIPTS PARA IMPORTAR ARQUIVOS')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 145
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'PRODUTOS'
    OnChange = ComboBox1Change
    Items.Strings = (
      'PRODUTOS'
      'CLIENTES')
  end
  object OpenDialog1: TOpenDialog
    Left = 504
    Top = 176
  end
end
