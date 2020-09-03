object frmMODUS: TfrmMODUS
  Left = 0
  Top = 0
  Caption = 'Sistema ATENA'
  ClientHeight = 528
  ClientWidth = 703
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
    703
    528)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 473
    Width = 703
    Height = 55
    Align = alBottom
    TabOrder = 3
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 701
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
      Width = 701
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
    Top = 302
    Width = 703
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
      547)
  end
  object butGravar: TButton
    Left = 620
    Top = 442
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 5
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 678
    Top = 323
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
    Width = 703
    Height = 190
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'CLIENTES = VPESCLI'
      'FORNECEDORES = VPESFOR'
      'GRUPOS_PRODUTO = TPROFAM'
      
        'PRODUTOS = SELECT P.*,NCM.NUMCLA, NCM.DESCLA FROM TPROPRI P LEFT' +
        ' JOIN TIMPCLA NCM ON (NCM.CODCLA = P.CODCLA)'
      'PRODUTOS_GRADE = TPROITE'
      'PRODUTOS_CUSTO = TPROCUS'
      'PRODUTOS_TAB_PRECOS_PROD = TTPRITE'
      ''
      '')
    ReadOnly = True
    TabOrder = 8
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
  object edtImpostoTrib: TLabeledEdit
    Left = 592
    Top = 24
    Width = 83
    Height = 21
    Hint = 'Aqui '#233' informado o c'#243'digo do imposto tributado no MODUSCOM.'
    Alignment = taRightJustify
    EditLabel.Width = 88
    EditLabel.Height = 13
    EditLabel.Caption = 'Imposto Tributado'
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    Text = '1'
  end
  object edtImpostoST: TLabeledEdit
    Left = 592
    Top = 64
    Width = 83
    Height = 21
    Hint = 
      'Aqui '#233' informado o c'#243'digo do imposto com Substitui'#231#227'o tributaria' +
      ' no MODUSCOM.'
    Alignment = taRightJustify
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = 'Imposto ST'
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    Text = '2'
  end
  object OpenDialog1: TOpenDialog
    Left = 504
    Top = 176
  end
end
