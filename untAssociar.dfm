object frmAssociar: TfrmAssociar
  Left = 0
  Top = 0
  Caption = 'frmAssociar'
  ClientHeight = 505
  ClientWidth = 930
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 930
    Height = 505
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'CLIENTES'
      'FORNECEDORES'
      'PRODUTOS')
    TabIndex = 0
    object Splitter1: TSplitter
      Left = 374
      Top = 24
      Height = 477
      ExplicitLeft = 376
      ExplicitTop = 224
      ExplicitHeight = 100
    end
    object dbgridASSOCIA: TDBGrid
      Left = 377
      Top = 24
      Width = 549
      Height = 477
      Align = alClient
      DataSource = DS_Associa
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = dbgridASSOCIAKeyDown
      Columns = <
        item
          DropDownRows = 10
          Expanded = False
          FieldName = 'CAMPOGIGA'
          PickList.Strings = (
            'PESSOAS_COD_PESSOA'#9
            'PESSOAS_RAZAO_SOCIAL'
            'PESSOAS_NOME_FANTASIA'
            'PESSOAS_CNPJ_CPF'
            'PESSOAS_TIPO_CLASSIFICACAO'
            'PESSOAS_SITE'
            'PESSOAS_DATA_CADASTRO'
            'PESSOAS_OBS_PESSOA'
            'PESSOAS_FLAG_ATIVO'
            'PESSOAS_OBS_INATIVO'
            'PESSOAS_HISTORICO'
            'PESSOAS_FLAG_CLIENTE'
            'PESSOAS_FLAG_FORNECEDOR'
            'PESSOAS_FLAG_VENDEDOR'
            'PESSOAS_FLAG_TRANSPORT'
            'PESSOAS_FLAG_CONVENIO'
            'PESSOAS_DATA_ALTERACAO'
            'PESSOAS_INSCR_ESTADUAL'
            'PESSOAS_RG'
            'PESSOAS_SUFRAMA'
            'PESSOAS_EMAIL'
            'PESSOAS_IGN_FLAG_HOMONIMO'
            'PESSOAS_FLAG_RAMO_RURAL'
            'PESSOAS_FLAG_FUNC'
            'PESSOAS_INSCR_MUNICIPAL'
            'PESSOAS_CHAVE_OLD'
            'PESSOAS_FLAG_CONTRIB_ICMS')
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAMPOIMPORT'
          Width = 250
          Visible = True
        end>
    end
    object Panel1: TPanel
      Left = 4
      Top = 24
      Width = 370
      Height = 477
      Align = alLeft
      Caption = 'Panel1'
      TabOrder = 1
      object memoSQL: TMemo
        Left = 1
        Top = 80
        Width = 368
        Height = 396
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        ExplicitLeft = -1
      end
      object Button1: TButton
        Left = 246
        Top = 4
        Width = 102
        Height = 70
        Caption = 'Atualizar'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 126
        Top = 2
        Width = 99
        Height = 72
        Caption = 'Salvar'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
  end
  object DS_Associa: TDataSource
    DataSet = DM.qrASSOC
    Left = 456
    Top = 24
  end
end
