object frmCompusoft: TfrmCompusoft
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'M&A'
  ClientHeight = 469
  ClientWidth = 512
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
    512
    469)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 414
    Width = 512
    Height = 55
    Align = alBottom
    TabOrder = 1
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 510
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
      Width = 46
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
    end
  end
  object vleConexao: TValueListEditor
    Left = 0
    Top = 243
    Width = 512
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
  end
  object butGravar: TButton
    Left = 429
    Top = 383
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 487
    Top = 264
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
    Width = 512
    Height = 131
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
    Items.Strings = (
      'PESSOAS'
      'RECEBER'
      'PAGAR'
      'PRODUTOS')
  end
  object memoSQL: TMemo
    Left = 192
    Top = 8
    Width = 271
    Height = 81
    Lines.Strings = (
      'EXECUTE BLOCK AS'
      'DECLARE VARIABLE CODIGO INT;'
      'DECLARE VARIABLE COD_PESSOA INT;'
      'BEGIN'
      '   FOR SELECT'
      '            IP.CODIGO,'
      '            P.COD_PESSOA'
      '        FROM IMPORT_PAGAR IP'
      '        LEFT JOIN PESSOAS P ON'
      '        (P.CHAVE_OLD = IP.CODIGO)'
      '        GROUP BY IP.CODIGO, P.COD_PESSOA'
      '   INTO :CODIGO, :COD_PESSOA DO'
      '   BEGIN'
      '      UPDATE OR INSERT INTO FORNECEDORES '
      '(COD_FORNECEDOR)VALUES'
      '(:COD_PESSOA)MATCHING (COD_FORNECEDOR);'
      '      UPDATE PESSOAS SET FLAG_FORNECEDOR = 1 '
      'WHERE COD_PESSOA = :COD_PESSOA;'
      '      UPDATE IMPORT_PAGAR SET '
      'COD_FORNECEDOR = :COD_PESSOA WHERE '
      'CODIGO = :CODIGO;'
      ''
      '   END'
      'END')
    TabOrder = 7
    Visible = False
  end
  object OpenDialog1: TOpenDialog
    Left = 480
    Top = 112
  end
end
