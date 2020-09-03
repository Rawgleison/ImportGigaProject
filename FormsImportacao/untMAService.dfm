object frmMAService: TfrmMAService
  Left = 0
  Top = 0
  Caption = 'frmMAService'
  ClientHeight = 366
  ClientWidth = 403
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
    403
    366)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 403
    Height = 55
    Align = alBottom
    TabOrder = 0
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 401
      Height = 30
      Align = alBottom
      Progress = 0
      ExplicitTop = 12
      ExplicitWidth = 906
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 401
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
    Left = 8
    Top = 8
    Width = 97
    Height = 89
    Caption = 'PRODUTOS'
    TabOrder = 1
    OnClick = butProdutosClick
  end
  object vleConexao: TValueListEditor
    Left = 0
    Top = 112
    Width = 403
    Height = 199
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
    TabOrder = 2
    TitleCaptions.Strings = (
      'Key'
      'Value'
      'Padrao')
    ColWidths = (
      150
      247)
  end
  object butGravar: TButton
    Left = 320
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 378
    Top = 133
    Width = 21
    Height = 18
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 288
    Top = 168
  end
end
