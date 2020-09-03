object frmListaCamposFORN: TfrmListaCamposFORN
  Left = 0
  Top = 0
  Caption = 'Lista de campos possiveis'
  ClientHeight = 632
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFoot: TPanel
    Left = 0
    Top = 582
    Width = 514
    Height = 50
    Align = alBottom
    TabOrder = 0
    object butFechar: TButton
      Left = 200
      Top = 6
      Width = 113
      Height = 35
      Caption = 'OK'
      TabOrder = 0
      OnClick = butFecharClick
    end
  end
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 514
    Height = 582
    Align = alClient
    DefaultColWidth = 200
    DrawingStyle = gdsGradient
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
    Strings.Strings = (
      'COD_FORNECEDOR       = INTEIRO'
      'RAZAO_SOCIAL         = Texto at'#233' 60 caractere'
      'NOME_FANTASIA        = Pega RAZAO_SOCIAL se vazio'
      'CNPJ_CPF             = Com ou sem M'#225'scara'
      'IE                   = Com ou Sem M'#225'scara'
      'IM                   = Com ou Sem M'#225'scara'
      'RG                   = Com ou Sem M'#225'scara'
      'DATA_CADASTRO        = Tipo Data "dd/mm/yyyy"'
      'FLAG_ATIVO           = (0 = Inativo; 1 = Ativo)'
      'OBS                  = Texto at'#233' 80 caractere'
      'EMAIL                = Texto at'#233' 60 caractere'
      '---------------------=---------------------'
      'CONTATO_DESC_CONTATO = Texto at'#233' 40 caractere'
      'CONTATO_OCUPACAO     = Texto at'#233' 30 caractere'
      'CONTATO_DATA_NASC    = Tipo Data "dd/mm/yyyy"'
      'CONTATO_EMAIL        = Texto at'#233' 40 caractere'
      'CONTATO_TELEFONE     = Com ou Sem M'#225'scara'
      'CONTATO_RAMAL        = INTEIRO'
      'CELULAR              = Com ou Sem M'#225'scara (Tela)'
      'CONTATO_FAX          = Com ou Sem M'#225'scara'
      '---------------------=---------------------'
      'ENDERECO             = Texto at'#233' 60 caractere'
      'NUMERO               = Texto at'#233' 10 caractere'
      'COMPLEMENTO          = Texto at'#233' 25 caractere'
      'BAIRRO               = Texto at'#233' 30 caractere'
      'CEP                  = Com ou sem M'#225'scara'
      'PONTO_REFERENCIA     = Texto at'#233' 40 caractere'
      'COD_MUNIC            = Se preenchido NOME_MUNIC ser'#225' ignorado'
      
        'NOME_MUNIC           = Caso tenha somente o nome da Cidade, o ap' +
        'p busca o cod por esse nome'
      'TELEFONE             = Com ou Sem M'#225'scara (Tela)'
      'FAX                  = Com ou Sem M'#225'scara (Tela)'
      '---------------------=---------------------'
      'ENDERECO2             = Texto at'#233' 60 caractere'
      'NUMERO2               = Texto at'#233' 10 caractere'
      'COMPLEMENTO2          = Texto at'#233' 25 caractere'
      'BAIRRO2               = Texto at'#233' 30 caractere'
      'CEP2                  = Com ou sem M'#225'scara'
      'PONTO_REFERENCIA2     = Texto at'#233' 40 caractere'
      'COD_MUNIC2            = Se preenchido NOME_MUNIC ser'#225' ignorado'
      
        'NOME_MUNIC2           = Caso tenha somente o nome da Cidade, o a' +
        'pp busca o cod por esse nome'
      'TELEFONE2             = Com ou Sem M'#225'scara (Tela)'
      'FAX2                  = Com ou Sem M'#225'scara (Tela)'
      '')
    TabOrder = 1
    TitleCaptions.Strings = (
      'CAMPO'
      'TIPO')
    ColWidths = (
      200
      291)
  end
end
