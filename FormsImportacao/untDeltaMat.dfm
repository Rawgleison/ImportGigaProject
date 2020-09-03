object frmDeltaMat: TfrmDeltaMat
  Left = 0
  Top = 0
  Caption = 'Sistema DeltaMat'
  ClientHeight = 469
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
    469)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 414
    Width = 575
    Height = 55
    Align = alBottom
    TabOrder = 3
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
  object butProdutos: TButton
    Left = 462
    Top = 8
    Width = 105
    Height = 89
    Caption = 'PRODUTOS'
    Enabled = False
    TabOrder = 2
    OnClick = butProdutosClick
  end
  object vleConexao: TValueListEditor
    Left = 0
    Top = 243
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
    TabOrder = 4
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
    Top = 383
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 5
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 550
    Top = 264
    Width = 21
    Height = 18
    Anchors = [akRight, akBottom]
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
  object butTransportadoras: TButton
    Left = 224
    Top = 8
    Width = 121
    Height = 89
    Caption = 'TRANSPORTADORAS'
    Enabled = False
    TabOrder = 7
    OnClick = butTransportadorasClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 112
    Width = 575
    Height = 131
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'CLIENTES = SELECT'
      '    C.*,'
      '    CEND.*,'
      '    CADD.*'
      'FROM CLIENTES C'
      'LEFT JOIN CLI_ENDERECOS CEND ON'
      '(CEND.CODIGO = C.CODIGO)'
      'LEFT JOIN CLI_ADICIONAIS CADD ON'
      '(CADD.CODIGO = C.CODIGO)'
      ''
      'FORNECEDORES = SELECT'
      '    F.*,'
      '    FEND.*,'
      '    FADD.*'
      'FROM FORNECEDORES F'
      'LEFT JOIN FOR_ENDERECOS FEND ON'
      '(FEND.CODIGO = F.CODIGO)'
      'LEFT JOIN FOR_ADICIONAIS FADD ON'
      '(FADD.CODIGO = F.CODIGO)')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 8
  end
  object butGruposProduto: TButton
    Left = 351
    Top = 8
    Width = 105
    Height = 89
    Caption = 'GRUPOS'#13'PRODUTO'
    Enabled = False
    TabOrder = 9
    OnClick = butGruposProdutoClick
  end
  object OpenDialog1: TOpenDialog
    Left = 504
    Top = 176
  end
end
