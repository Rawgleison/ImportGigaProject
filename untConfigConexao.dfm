object frmConfigConexao: TfrmConfigConexao
  Left = 0
  Top = 0
  Caption = 'frmConfigConexao'
  ClientHeight = 247
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    488
    247)
  PixelsPerInch = 96
  TextHeight = 13
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 488
    Height = 175
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Strings.Strings = (
      
        'Database=D:\Documentos\Gigatron\Clientes\Felipe\Lanchao\GigaERP.' +
        'FDB'
      'User_Name=sysdba'
      'Password=*****'
      'Server=LocalHost'
      'Port=3060'
      'DriverID=FB'
      'Pooled=False')
    TabOrder = 0
    TitleCaptions.Strings = (
      'Key'
      'Value'
      'Padrao')
    ExplicitWidth = 506
    ColWidths = (
      150
      332)
  end
  object butOK: TButton
    Left = 241
    Top = 188
    Width = 113
    Height = 48
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    ModalResult = 1
    TabOrder = 1
    ExplicitLeft = 234
    ExplicitTop = 306
  end
  object butCancel: TButton
    Left = 361
    Top = 188
    Width = 113
    Height = 48
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
    ExplicitLeft = 354
    ExplicitTop = 306
  end
end
