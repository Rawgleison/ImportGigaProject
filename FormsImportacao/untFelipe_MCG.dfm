object frmATENA: TfrmATENA
  Left = 0
  Top = 0
  Caption = 'Felipe MCG'
  ClientHeight = 633
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
    633)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 578
    Width = 575
    Height = 55
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 457
    ExplicitWidth = 605
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 573
      Height = 30
      Align = alBottom
      Progress = 0
      ExplicitTop = 12
      ExplicitWidth = 906
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
    TabOrder = 2
    OnClick = butProdutosClick
  end
  object vleConexao: TValueListEditor
    Left = 0
    Top = 407
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
    ExplicitWidth = 580
    ColWidths = (
      150
      419)
  end
  object butGravar: TButton
    Left = 492
    Top = 547
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 5
    OnClick = butGravarClick
    ExplicitLeft = 522
    ExplicitTop = 426
  end
  object Button2: TButton
    Left = 550
    Top = 428
    Width = 21
    Height = 18
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 6
    OnClick = Button2Click
    ExplicitLeft = 580
    ExplicitTop = 307
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
    TabOrder = 7
    OnClick = butTransportadorasClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 113
    Width = 575
    Height = 294
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'CLIENTES = SELECT'
      '    CAST(TAB.OBSERVACAO AS VARCHAR( 1000)) OBSERVACAO,'
      
        '    CAST(TAB.OBSERVACAOATENDIMENTO AS VARCHAR(1000)) OBSERVACAOA' +
        'TENDIMENTO,'
      
        '    CAST(TAB.OBSERVACAOQUALIDADE AS VARCHAR(1000)) OBSERVACAOQUA' +
        'LIDADE,'
      
        '    CAST(TAB.OBSERVACAOSERASA AS VARCHAR(1000)) OBSERVACAOSERASA' +
        ','
      '    TAB.*'
      'FROM CRP002 TAB'
      ''
      'FORNECEDORES = EST'#193' JUNTO COM CLIENTES'
      ''
      'TRANSPORTADORAS = TRANSPOR'
      ''
      'GRUPOS_PRODUTO = GRUPOFRPRODUTO'
      ''
      'PRODUTOS = SELECT'
      '  CAST(P.DESCRICAO AS VARCHAR(120)) DESCRICAO,'
      '  CAST(P.OBSERVACAO AS VARCHAR(500)) OBSERVACAO,'
      '  C.DESCRICAO CLASSE_DESC,'
      '  P.*'
      'FROM PRODUTOSALMOX P'
      'LEFT JOIN CLASSEDOPRODUTO C ON'
      '(C.GRUPO = P.GRUPO AND'
      ' C.CLASSE = P.CLASSE)')
    ReadOnly = True
    TabOrder = 8
    ExplicitWidth = 605
    ExplicitHeight = 173
  end
  object butGruposProduto: TButton
    Left = 351
    Top = 8
    Width = 105
    Height = 89
    Caption = 'GRUPOS'#13'PRODUTO'
    TabOrder = 9
    OnClick = butGruposProdutoClick
  end
  object OpenDialog1: TOpenDialog
    Left = 400
    Top = 136
  end
end
