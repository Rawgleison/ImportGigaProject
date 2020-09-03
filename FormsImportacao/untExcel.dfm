object frmExcel: TfrmExcel
  Left = 0
  Top = 0
  Caption = 'Importador de Arquivo Excel'
  ClientHeight = 462
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbStatus: TLabel
    Left = 0
    Top = 299
    Width = 581
    Height = 21
    Align = alBottom
    Alignment = taCenter
    Caption = 'lbStatus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 60
  end
  object Panel1: TPanel
    Left = 0
    Top = 388
    Width = 581
    Height = 55
    Align = alBottom
    TabOrder = 0
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 579
      Height = 30
      Align = alBottom
      ForeColor = clLime
      Progress = 0
      ExplicitLeft = 8
      ExplicitTop = -16
      ExplicitWidth = 573
    end
    object lbProgress: TLabel
      Left = 1
      Top = 1
      Width = 579
      Height = 19
      Align = alTop
      Alignment = taCenter
      Caption = 'lbProgress'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 74
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 320
    Width = 581
    Height = 68
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 581
    Height = 123
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'PRODUTOS'
      object Label3: TLabel
        Left = 107
        Top = 22
        Width = 76
        Height = 13
        Caption = 'Imposto padr'#227'o'
      end
      object Label4: TLabel
        Left = 117
        Top = 55
        Width = 66
        Height = 13
        Caption = 'Grupo padr'#227'o'
      end
      object lbNCM: TLabel
        Left = 277
        Top = 21
        Width = 59
        Height = 13
        Caption = 'NCM padr'#227'o'
      end
      object Button1: TButton
        Left = 3
        Top = 3
        Width = 102
        Height = 72
        Caption = 'PRODUTOS'
        TabOrder = 0
        OnClick = Button1Click
      end
      object edtImposto: TEdit
        Left = 189
        Top = 14
        Width = 33
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 1
        Text = '1'
      end
      object Button3: TButton
        Left = 228
        Top = 14
        Width = 37
        Height = 27
        Caption = 'Novo'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 228
        Top = 47
        Width = 37
        Height = 27
        Caption = 'Novo'
        TabOrder = 3
        OnClick = Button4Click
      end
      object butCampos: TButton
        Left = 450
        Top = 3
        Width = 113
        Height = 30
        Caption = 'Campos Poss'#237'veis'
        TabOrder = 4
        OnClick = butCamposClick
      end
      object edtGrupo: TEdit
        Left = 189
        Top = 47
        Width = 33
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 5
        Text = '1'
      end
      object edtNCM: TEdit
        Left = 344
        Top = 12
        Width = 81
        Height = 27
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 6
        Text = '99'
      end
      object edtEmpresa: TLabeledEdit
        Left = 344
        Top = 52
        Width = 46
        Height = 21
        Alignment = taRightJustify
        EditLabel.Width = 63
        EditLabel.Height = 13
        EditLabel.Caption = 'Cod Empresa'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 7
        Text = '1'
        OnExit = edtEmpresaExit
      end
    end
    object tsClientes: TTabSheet
      Caption = 'CLIENTES'
      ImageIndex = 1
      object butClientes: TButton
        Left = 3
        Top = 9
        Width = 102
        Height = 72
        Caption = 'CLIENTES'
        TabOrder = 0
        OnClick = butClientesClick
      end
      object butCamposClientes: TButton
        Left = 450
        Top = 3
        Width = 113
        Height = 30
        Caption = 'Campos Poss'#237'veis'
        TabOrder = 1
        OnClick = butCamposClientesClick
      end
      object checkDataInvalida: TCheckBox
        Left = 126
        Top = 9
        Width = 147
        Height = 17
        Hint = 
          'Se marcado, quando o programa encontrar uma '#13#10'data (Nascimento o' +
          'u cadastro) inv'#225'lida, ao inv'#233'z de dar erro, ele '#225#13#10'substitui por' +
          ' 01/01/1900'#13#10
        Caption = 'Ignorar Data inv'#225'lida'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = chkVerStringGridClick
      end
      object checkMesmoCodigo: TCheckBox
        Left = 126
        Top = 32
        Width = 147
        Height = 17
        Caption = 'Usar o c'#243'digo do arquivo'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        OnClick = checkMesmoCodigoClick
      end
      object edtUFpadrao: TLabeledEdit
        Left = 182
        Top = 55
        Width = 19
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 50
        EditLabel.Height = 13
        EditLabel.Caption = 'UF Padr'#227'o'
        LabelPosition = lpLeft
        TabOrder = 4
        Text = 'SP'
      end
    end
    object tsForn: TTabSheet
      Caption = 'FORNECEDORES'
      ImageIndex = 2
      object butFORNECEDORES: TButton
        Left = 11
        Top = 3
        Width = 102
        Height = 72
        Caption = 'FORNECEDORES'
        TabOrder = 0
        OnClick = butFORNECEDORESClick
      end
      object butCAMPOSFORN: TButton
        Left = 450
        Top = 3
        Width = 113
        Height = 30
        Caption = 'Campos Poss'#237'veis'
        TabOrder = 1
        OnClick = butCAMPOSFORNClick
      end
    end
  end
  object pnlList: TPanel
    Left = 0
    Top = 123
    Width = 581
    Height = 176
    Align = alClient
    Caption = 'pnlList'
    TabOrder = 3
    DesignSize = (
      581
      176)
    object vleConexao: TValueListEditor
      Left = 1
      Top = 1
      Width = 579
      Height = 174
      Align = alClient
      Strings.Strings = (
        'Database=C:\Gigatron\GigaERP\Base\GigaERP.FDB'
        'User_Name=sysdba'
        'Password=lib1503'
        'Server=LocalHost'
        'Port=3060'
        'DriverID=FB'
        'Pooled=False')
      TabOrder = 1
      TitleCaptions.Strings = (
        'Key'
        'Value'
        'Padrao')
      ColWidths = (
        75
        498)
    end
    object butBancoGiga: TButton
      Left = 554
      Top = 22
      Width = 21
      Height = 18
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 2
      OnClick = butBancoGigaClick
    end
    object butGravar: TButton
      Left = 500
      Top = 134
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = butGravarClick
    end
  end
  object chkVerStringGrid: TCheckBox
    Left = 454
    Top = 79
    Width = 97
    Height = 17
    Caption = 'Mostrar Arquivo'
    TabOrder = 4
    OnClick = chkVerStringGridClick
  end
  object stat1: TStatusBar
    Left = 0
    Top = 443
    Width = 581
    Height = 19
    Panels = <
      item
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = 'Desenvolvido por Rawgleison (18) 99711-8782  '
        Width = 50
      end>
  end
  object OpenDialog1: TOpenDialog
    Left = 40
    Top = 80
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 56
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 364
    Top = 80
  end
end
