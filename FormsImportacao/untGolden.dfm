object frmGolden: TfrmGolden
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Golden Celulares'
  ClientHeight = 336
  ClientWidth = 586
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
    586
    336)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 281
    Width = 586
    Height = 55
    Align = alBottom
    TabOrder = 1
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 584
      Height = 30
      Align = alBottom
      Progress = 0
      ExplicitLeft = 8
      ExplicitTop = -16
      ExplicitWidth = 573
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 584
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
    Top = 115
    Width = 586
    Height = 166
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
      430)
  end
  object butGravar: TButton
    Left = 503
    Top = 250
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 561
    Top = 131
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
    Left = 159
    Top = 0
    Width = 427
    Height = 115
    Align = alRight
    Lines.Strings = (
      ' - IMPORTA'#199#195'O POR XLS'
      
        ' - ANTES DE IMPORTAR ARQUIVOS, ABRIR ARQUIVO DOS PRODUTOS E CONV' +
        'ERTER AS COLUNAS DE VALORES DE TEXTO PARA NUMERO PARA SAIR O r$ ' +
        'DO PREFIXO'
      ' - IMPORTAR NORMALMENTE PELO IB (N'#195'O TEM SCRIPT)')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
    WantTabs = True
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
    OnChange = ComboBox1Change
    Items.Strings = (
      'CLIENTES'
      'GRUPOS_PRODUTOS'
      'PRODUTOS')
  end
  object OpenDialog1: TOpenDialog
    Left = 504
    Top = 176
  end
end
