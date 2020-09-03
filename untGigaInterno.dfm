object frmGigaInterno: TfrmGigaInterno
  Left = 0
  Top = 0
  Caption = 'Importar dados Para GigaERP  de tabela interna'
  ClientHeight = 537
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 329
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 962
    object Button2: TButton
      Left = 16
      Top = 8
      Width = 106
      Height = 81
      Caption = 'Clientes'
      TabOrder = 0
      OnClick = Button2Click
    end
    object butFornecedores: TButton
      Left = 131
      Top = 8
      Width = 111
      Height = 81
      Caption = 'Fornecedores'
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 103
      Width = 97
      Height = 16
      Caption = 'DBGrid Show'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object butProdutos: TButton
      Left = 248
      Top = 8
      Width = 110
      Height = 81
      Caption = 'Produtos/Grade'
      TabOrder = 3
    end
    object rbPessoas: TRadioButton
      Left = 128
      Top = 95
      Width = 65
      Height = 17
      Caption = 'Pessoas'
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = rbPessoasClick
    end
    object rbProdutos: TRadioButton
      Left = 128
      Top = 118
      Width = 65
      Height = 17
      Caption = 'Produtos'
      TabOrder = 5
      OnClick = rbProdutosClick
    end
    object ComboBox1: TComboBox
      Left = 200
      Top = 95
      Width = 145
      Height = 21
      ItemIndex = 0
      TabOrder = 6
      Text = '  '
      Visible = False
      OnCloseUp = ComboBox1CloseUp
      Items.Strings = (
        '  ')
    end
    object cbGradeAtiva: TCheckBox
      Left = 199
      Top = 130
      Width = 97
      Height = 16
      Caption = 'Grade Ativa'
      TabOrder = 7
    end
    object edtBaseGiga: TLabeledEdit
      Left = 72
      Top = 152
      Width = 121
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = 'edtBaseGiga'
      LabelPosition = lpLeft
      TabOrder = 8
    end
    object edtServer: TLabeledEdit
      Left = 72
      Top = 184
      Width = 121
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'edtServer'
      LabelPosition = lpLeft
      TabOrder = 9
    end
    object edtPort: TLabeledEdit
      Left = 72
      Top = 216
      Width = 121
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'edtPort'
      LabelPosition = lpLeft
      TabOrder = 10
    end
    object edtUser: TLabeledEdit
      Left = 72
      Top = 248
      Width = 121
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = 'edtUser'
      LabelPosition = lpLeft
      TabOrder = 11
    end
    object edtPassword: TLabeledEdit
      Left = 72
      Top = 280
      Width = 121
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'edtPassword'
      LabelPosition = lpLeft
      TabOrder = 12
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 469
    Width = 400
    Height = 68
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 962
    object Label1: TLabel
      Left = 1
      Top = 0
      Width = 60
      Height = 25
      Align = alBottom
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Gauge1: TGauge
      Left = 1
      Top = 25
      Width = 398
      Height = 42
      Align = alBottom
      Progress = 0
      ExplicitLeft = 8
      ExplicitTop = 151
      ExplicitWidth = 100
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 403
    Width = 400
    Height = 66
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object DataSource1: TDataSource
    Left = 336
    Top = 336
  end
  object OpenDialog1: TOpenDialog
    Left = 128
    Top = 168
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 128
    object Associar1: TMenuItem
      Caption = 'Associar'
      OnClick = Associar1Click
    end
    object GravarPerfil1: TMenuItem
      Caption = 'Gravar Perfil'
    end
  end
  object dsConfig: TDataSource
    DataSet = DM.qrPERFIL
    Left = 72
    Top = 144
  end
end
