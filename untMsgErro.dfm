object ExceptionDialog: TExceptionDialog
  Left = 310
  Top = 255
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'ExceptionDialog'
  ClientHeight = 350
  ClientWidth = 483
  Color = clBtnFace
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    483
    350)
  PixelsPerInch = 96
  TextHeight = 13
  object BevelDetails: TBevel
    Left = 2
    Top = 161
    Width = 476
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object SaveBtn: TButton
    Left = 400
    Top = 57
    Width = 75
    Height = 25
    Hint = 'Save bug report'
    Anchors = [akTop, akRight]
    Caption = '&Gravar'
    TabOrder = 0
    OnClick = SaveBtnClick
  end
  object TextMemo: TMemo
    Left = 56
    Top = 8
    Width = 332
    Height = 147
    Hint = 'Use Ctrl+C to copy the report to the clipboard'
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsNone
    Ctl3D = True
    ParentColor = True
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 1
    WantReturns = False
  end
  object OkBtn: TButton
    Left = 403
    Top = 4
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object DetailsBtn: TButton
    Left = 400
    Top = 98
    Width = 75
    Height = 57
    Hint = 'Mostrar os detalhes da mensagem de erro'
    Anchors = [akTop, akRight]
    Caption = '&Detalhar'
    Enabled = False
    TabOrder = 3
    OnClick = DetailsBtnClick
  end
  object DetailsMemo: TMemo
    Left = 4
    Top = 176
    Width = 472
    Height = 167
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
    WantReturns = False
    WordWrap = False
  end
end
