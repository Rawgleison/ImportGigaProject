object frmSGI: TfrmSGI
  Left = 0
  Top = 0
  Caption = 'Sistema SGI'
  ClientHeight = 548
  ClientWidth = 909
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    909
    548)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 493
    Width = 909
    Height = 55
    Align = alBottom
    TabOrder = 1
    object Gauge1: TGauge
      Left = 1
      Top = 24
      Width = 907
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
      Width = 907
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
  object vleConexao: TValueListEditor
    Left = 0
    Top = 303
    Width = 909
    Height = 190
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
    ColWidths = (
      150
      753)
  end
  object butGravar: TButton
    Left = 826
    Top = 462
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = butGravarClick
  end
  object Button2: TButton
    Left = 884
    Top = 343
    Width = 21
    Height = 18
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object butImportar: TButton
    Left = 8
    Top = 40
    Width = 145
    Height = 57
    Caption = 'IMPORTAR'
    TabOrder = 0
    OnClick = butImportarClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 103
    Width = 909
    Height = 200
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'CLIENTE = BACCLI.DBF'
      'FORNECEDORES=BACFOR.DBF'
      'GRUPOS_PRODUTOS=BACGRU.DBF'
      'MARCA=BACSUB.DBF'
      'PRODUTOS=BACMER.DBF'
      ''
      'Criar Indice em todas as tabelas.'
      ''
      'OBS: O grupo e a marca dos produtos j'#225' s'#227'o importados junto'
      'com os produtos, no mesmo bot'#227'o. (uso do EDIT OR INSERT)'
      ''
      'Os arquivos BACGRU.DBF e BACSUB.DBF devem ser procurado '
      'os que contenham mais registros.'
      ''
      'Acertar o COD_PESSOA do IMPORT_RECEBER na m'#227'o, garantindo'
      'que todo registro seja um cliente.')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object cbSelect: TComboBox
    Left = 8
    Top = 13
    Width = 145
    Height = 21
    TabOrder = 6
    Items.Strings = (
      'CLIENTES'
      'FORNECEDORES'
      'PRODUTOS'
      'RECEBER')
  end
  object memoFornecedores: TMemo
    Left = 159
    Top = 8
    Width = 185
    Height = 89
    Lines.Strings = (
      'EXECUTE BLOCK AS'
      'DECLARE VARIABLE COD_PESSOA '
      'INT;'
      'DECLARE VARIABLE CHAVE_OLD '
      'VARCHAR(60);'
      'BEGIN'
      '   FOR SELECT P.COD_PESSOA, '
      'P.CHAVE_OLD'
      '   FROM PESSOAS P'
      '   INTO :COD_PESSOA, '
      ':CHAVE_OLD DO'
      '   BEGIN'
      '      UPDATE '
      'IMPORT_FORNECEDORES F SET '
      'F.COD_PESSOA = :COD_PESSOA'
      '      WHERE F.CODFOR = '
      ':CHAVE_OLD;'
      '   END'
      'END')
    TabOrder = 7
    Visible = False
  end
  object memoClientes: TMemo
    Left = 360
    Top = 8
    Width = 185
    Height = 89
    Lines.Strings = (
      'EXECUTE BLOCK AS'
      'DECLARE VARIABLE COD_PESSOA '
      'INT;'
      'DECLARE VARIABLE CHAVE_OLD '
      'VARCHAR(60);'
      'BEGIN'
      '   FOR SELECT P.COD_PESSOA, '
      'P.CHAVE_OLD'
      '   FROM PESSOAS P'
      '   INTO :COD_PESSOA, '
      ':CHAVE_OLD DO'
      '   BEGIN'
      '      UPDATE IMPORT_CLIENTES C '
      'SET C.COD_PESSOA = '
      ':COD_PESSOA'
      '      WHERE C.CODCLI = '
      ':CHAVE_OLD;'
      '   END'
      'END')
    TabOrder = 8
    Visible = False
  end
  object memoReceber: TMemo
    Left = 159
    Top = 8
    Width = 742
    Height = 89
    Lines.Strings = (
      'EXECUTE BLOCK AS'
      'DECLARE VARIABLE COD_PESSOA INT;'
      'DECLARE VARIABLE CHAVE_OLD VARCHAR(60);'
      'declare variable FLAG_CLIENTE INT;'
      'BEGIN'
      '   FOR SELECT P.COD_PESSOA, P.CHAVE_OLD, '
      'P.flag_cliente'
      '   FROM PESSOAS P'
      '   INTO :COD_PESSOA, :CHAVE_OLD, :FLAG_CLIENTE '
      'DO'
      '   BEGIN'
      '      UPDATE IMPORT_RECEBER R SET R.COD_PESSOA '
      '= :COD_PESSOA'
      '      WHERE R.clifor = :CHAVE_OLD;'
      '      if (:FLAG_CLIENTE = 0) then'
      '      BEGIN'
      '        UPDATE PESSOAS SET FLAG_CLIENTE = 1;'
      '        UPDATE OR INSERT INTO CLIENTES '
      '(COD_CLIENTE, DATA_NASCIMENTO, SEXO, '
      'NACIONALIDADE, BLOQUEIO_DIAS_INADIMP, '
      'INTERVALO_DIAS_VENDA, PERC_DESCONTO_VENDA, '
      'FLAG_HABILITA_DUPLICATA, '
      'FLAG_HABILITA_CHEQUE, FLAG_EMITE_NOTA, '
      'FLAG_EMITE_BOLETO, FLAG_SERASA, '
      'FLAG_TELE_CHEQUE, FLAG_SPC, FLAG_OUTROS, '
      'DESC_BLOQUEIO, LIMITE_CREDITO, '
      'COD_COBRANCA, COD_VENDEDOR, '
      'DATA_MENSAGEM, TEXTO_MENSAGEM, DIRETORIO, '
      'REFERENCIA_COMERCIAL1, '
      'REFERENCIA_COMERCIAL2, '
      'REFERENCIA_COMERCIAL3, '
      'REFERENCIA_COMERCIAL4, TRAB_PROFISSAO, '
      'TRAB_LOCAL, TRAB_COD_FUNC, TRAB_CARGO, '
      'TRAB_RENDA, CONJ_ESTADO_CIVIL, CONJ_NOME, '
      'CONJ_RENDA, CONJ_CPF, CONJ_PROFISSAO, '
      'CONJ_REGIME, CONJ_TRABALHO, CONJ_RG, '
      'CHAVE_OLD, COD_TABELA, '
      'COD_PLANO_PAGAMENTO, DIA_VENCIMENTO, '
      'SITUACAO, BLOQUEADO, FLAG_ECF_RESTRICAO, '
      'FLAG_RETENCAO_ISS, PP_TIMESTAMP, '
      'PP_CLOCK_UPDATE, PP_CLOCK_INSERT, '
      'PP_NOT_UPDATED, PP_ID_GLOBAL, PP_ID_LOCAL, '
      'COD_TRANSPORTADORA, DIA_FECHAMENTO, '
      'DEMONSTRATIVO_BOLETO)'
      '                        VALUES (:COD_PESSOA, NULL, 0, NULL, '
      '0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, NULL, 0, 1, 1, NULL, '
      'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '
      'NULL, NULL, NULL, '#39'Solteiro(a)'#39', NULL, NULL, NULL, '
      'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '
      'NULL, NULL, NULL, 0, '#39'2016-07-22 00:25:17'#39', 160752, '
      '160752, 0, '#39'eVZz49QL5UCWvCrKQF4ZPQ'#39', 157385, '
      'NULL, NULL, NULL)'
      '                      MATCHING (COD_CLIENTE);'
      '      END'
      '   END'
      'END')
    TabOrder = 9
  end
  object memoProdutos: TMemo
    Left = 568
    Top = 8
    Width = 153
    Height = 89
    Lines.Strings = (
      'EXECUTE BLOCK AS'
      'DECLARE VARIABLE '
      'COD_PRODUTO VARCHAR'
      '(13);'
      'DECLARE VARIABLE '
      'APELIDO VARCHAR(25);'
      'DECLARE VARIABLE '
      'COD_GRUPO INT;'
      'DECLARE VARIABLE MARCA '
      'INT;'
      'BEGIN'
      '    FOR SELECT '
      'COD_PRODUTO, APELIDO '
      'FROM '
      'PRODUTOS_APELIDOS_PRO'
      'D'
      '    WHERE COD_APELIDO = '
      '3'
      '    INTO '
      ':COD_PRODUTO,:APELIDO '
      'DO'
      '    BEGIN'
      '       COD_GRUPO = '
      'SUBSTRING(:APELIDO FROM '
      '1 FOR 3);'
      '       MARCA = SUBSTRING'
      '(:APELIDO FROM 5 FOR 3);'
      '       UPDATE PRODUTOS SET '
      'COD_GRUPO=:COD_GRUPO'
      '       WHERE '
      'COD_PRODUTO=:COD_PRO'
      'DUTO;'
      '       INSERT INTO '
      'PRODUTOS_TABELA'
      '(COD_PRODUTO, '
      'COD_TABELA,COD_TABELA_'
      'ITEM)'
      '       VALUES'
      '(:COD_PRODUTO,1,:MARCA'
      ');'
      '    END'
      'END')
    TabOrder = 10
    Visible = False
  end
  object OpenDialog1: TOpenDialog
    Left = 504
    Top = 176
  end
end
