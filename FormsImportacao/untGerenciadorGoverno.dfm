object frmGerenciadorGoverno: TfrmGerenciadorGoverno
  Left = 0
  Top = 0
  Caption = 'Gerenciador Governo'
  ClientHeight = 454
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 0
    Top = 415
    Width = 376
    Height = 39
    Align = alBottom
    Progress = 0
    ExplicitTop = 369
    ExplicitWidth = 544
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 161
    Width = 376
    Height = 28
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 376
    Height = 161
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 393
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 202
      Height = 39
      Caption = 
        'Importador de dados do '#13#10'Emissor de Nota Fiscal Eletr'#244'nica (NF-e' +
        ') 3 '#13#10'do Governo'
    end
    object butClientes: TButton
      Left = 32
      Top = 57
      Width = 153
      Height = 94
      Caption = 'Clientes'
      TabOrder = 0
      OnClick = butClientesClick
    end
    object butProdutos: TButton
      Left = 215
      Top = 57
      Width = 153
      Height = 94
      Caption = 'Produtos'
      TabOrder = 1
      OnClick = butProdutosClick
    end
    object Button1: TButton
      Left = 256
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 2
      Visible = False
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 189
    Width = 376
    Height = 226
    Align = alClient
    TabOrder = 2
    ExplicitTop = 161
    ExplicitWidth = 331
    ExplicitHeight = 225
    DesignSize = (
      376
      226)
    object vleConexao: TValueListEditor
      Left = 1
      Top = 1
      Width = 374
      Height = 224
      Align = alClient
      Strings.Strings = (
        'Database=C:\Gigatron\GigaERP\Base\GigaERP.FDB'
        'User_Name=sysdba'
        'Password=lib1503'
        'Server=LocalHost'
        'Port=3060'
        'DriverID=FB'
        'Pooled=False'
        'path_clientes='
        'path_produtos=')
      TabOrder = 0
      TitleCaptions.Strings = (
        'Key'
        'Value'
        'Padrao')
      ExplicitWidth = 329
      ExplicitHeight = 223
      ColWidths = (
        94
        274)
    end
    object Button2: TButton
      Left = 294
      Top = 197
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar'
      TabOrder = 1
      OnClick = Button2Click
      ExplicitLeft = 301
    end
    object butDatabase: TButton
      Left = 350
      Top = 22
      Width = 21
      Height = 18
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 2
      OnClick = butDatabaseClick
      ExplicitLeft = 357
    end
    object butPathClientes: TButton
      Left = 350
      Top = 155
      Width = 21
      Height = 18
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 3
      OnClick = butPathClientesClick
      ExplicitLeft = 357
    end
    object butPathProdutos: TButton
      Left = 350
      Top = 175
      Width = 21
      Height = 18
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 4
      OnClick = butPathProdutosClick
      ExplicitLeft = 357
    end
  end
  object FileListBox1: TFileListBox
    Left = 46
    Top = 107
    Width = 210
    Height = 76
    ItemHeight = 13
    Mask = '*.xml'
    TabOrder = 3
    Visible = False
  end
  object DataSource1: TDataSource
    Left = 112
    Top = 208
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 128
    Top = 96
  end
  object cdsImport: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'xml'
    Left = 16
    Top = 64
  end
  object xml: TXMLTransformProvider
    Left = 72
    Top = 64
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 320
    Top = 16
  end
  object FileOpenDialog2: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Banco GigaERP (*.FDB)'
        FileMask = '*.fdb'
      end>
    Options = []
    Left = 184
    Top = 8
  end
end
