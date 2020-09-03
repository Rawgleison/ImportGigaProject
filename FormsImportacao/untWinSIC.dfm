object frmWinSIC: TfrmWinSIC
  Left = 0
  Top = 0
  Caption = 'WinSIC'
  ClientHeight = 403
  ClientWidth = 409
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
    409
    403)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 348
    Width = 409
    Height = 55
    Align = alBottom
    TabOrder = 3
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 407
      Height = 30
      Align = alBottom
      Progress = 0
      ExplicitTop = 12
      ExplicitWidth = 906
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 407
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
  object butProdutos: TButton
    Left = 224
    Top = 8
    Width = 97
    Height = 89
    Caption = 'PRODUTOS'
    TabOrder = 2
    OnClick = butProdutosClick
  end
  object vleConexao: TValueListEditor
    Left = 0
    Top = 184
    Width = 409
    Height = 164
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Strings.Strings = (
      'Database=C:\Gigatron\GigaERP\Base\GigaERP.FDB'
      'User_Name=sysdba'
      'Password=lib1503'
      'Server=LocalHost'
      'Port=3060'
      'DriverID=FB'
      'Pooled=False')
    TabOrder = 4
    TitleCaptions.Strings = (
      'Key'
      'Value'
      'Padrao')
    ColWidths = (
      150
      253)
  end
  object butGravar: TButton
    Left = 326
    Top = 317
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 5
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 387
    Top = 205
    Width = 21
    Height = 18
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 6
    OnClick = Button2Click
  end
  object butClientes: TButton
    Left = 8
    Top = 8
    Width = 98
    Height = 89
    Caption = 'CLIENTES'
    TabOrder = 0
    OnClick = butClientesClick
  end
  object butFornecedores: TButton
    Left = 112
    Top = 8
    Width = 106
    Height = 89
    Caption = 'FORNECEDORES'
    TabOrder = 1
    OnClick = butFornecedoresClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 103
    Width = 409
    Height = 81
    Align = alBottom
    Lines.Strings = (
      
        'Para o uso dessa tela, antes, utilizando o IBExpert 2012 ou post' +
        'erior, importar as '
      
        'tabelas TabCli.db, TabFor.db e TabEst1.db, que constam no diret'#243 +
        'rio raiz do '
      
        'WinSic, especificamente com os respectivos nomes de tabela no Gi' +
        'gaERP, '
      'IMPORT_CLIENTES, IMPORT_FORNECEDORES E IMPORT_PRODUTOS.')
    TabOrder = 7
  end
  object OpenDialog1: TOpenDialog
    Left = 288
    Top = 168
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 184
    Top = 160
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 128
  end
end
