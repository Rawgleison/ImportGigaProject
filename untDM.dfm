object DM: TDM
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 826
  Width = 1103
  object QR_Origem: TFDQuery
    Connection = conexaoOrigem
    Left = 144
    Top = 96
  end
  object QR_Destino: TFDQuery
    CachedUpdates = True
    Connection = conexaoDestino
    Left = 144
    Top = 176
  end
  object conexaoOrigem: TFDConnection
    Params.Strings = (
      
        'Database=D:\Documentos\Gigatron\Clientes\Felipe\Lanchao\GigaERP.' +
        'FDB'
      'User_Name=sysdba'
      'Password=lib1503'
      'Server=LocalHost'
      'Port=3060'
      'DriverID=FB'
      'Pooled=False')
    LoginPrompt = False
    Left = 48
    Top = 96
  end
  object conexaoDestino: TFDConnection
    Params.Strings = (
      
        'Database=D:\Documentos\Gigatron\Clientes\Felipe\Lanchao\GigaERP.' +
        'FDB'
      'User_Name=sysdba'
      'Password=*****'
      'Server=LocalHost'
      'Port=3060'
      'DriverID=FB'
      'Pooled=False')
    LoginPrompt = False
    Left = 48
    Top = 176
  end
  object QR_PK: TFDQuery
    CachedUpdates = True
    Connection = conexaoDestino
    SQL.Strings = (
      'SELECT'
      'RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME AS TABELA, '
      'RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_NAME AS CHAVE, '
      'RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME AS INDICE_DA_CHAVE, '
      'RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS CAMPO, '
      'RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION AS POSICAO '
      'FROM'
      'RDB$RELATION_CONSTRAINTS, '
      'RDB$INDICES, '
      'RDB$INDEX_SEGMENTS '
      
        'WHERE RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE = '#39'PRIMARY KE' +
        'Y'#39
      'AND RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME = :TABELA'
      
        'AND RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDICES.RDB$IN' +
        'DEX_NAME '
      
        'AND RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NA' +
        'ME '
      'ORDER BY RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_NAME, '
      'RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION')
    Left = 216
    Top = 176
    ParamData = <
      item
        Name = 'TABELA'
        DataType = ftFixedWideChar
        ParamType = ptInput
        Size = 31
        Value = Null
      end>
  end
  object conexaoSisco: TFDConnection
    Params.Strings = (
      'ConnectionDef=DB_CONF')
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object QR_Sisco: TFDQuery
    Connection = conexaoSisco
    Left = 144
    Top = 32
  end
  object QR_Tabelas: TFDQuery
    Connection = conexaoOrigem
    SQL.Strings = (
      'SELECT rdb$relation_name tabela from RDB$RELATION_FIELDS'
      'where not (rdb$relation_name like '#39'%$%'#39')'
      '  and not (rdb$relation_name like '#39'VW_%'#39')'
      'group by rdb$relation_name')
    Left = 216
    Top = 96
    object QR_TabelasTABELA: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'TABELA'
      Origin = 'TABELA'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 31
    end
  end
  object qrPESSOAS: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PESSOAS')
    Left = 568
    Top = 24
  end
  object ConexaoGigaERP: TFDConnection
    Params.Strings = (
      
        'Database=D:\Documentos\Gigatron\GigaProjetosXE8\Importa Giga2Gig' +
        'a\Win32\Debug\Base Teste\GigaERP.FDB'
      'User_Name=sysdba'
      'Password=lib1503'
      'Server=LOCALHOST'
      'Port=3060'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evRecordCountMode]
    FetchOptions.RecordCountMode = cmTotal
    ResourceOptions.AssignedValues = [rvDirectExecute]
    ResourceOptions.DirectExecute = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.AutoCommitUpdates = True
    TxOptions.DisconnectAction = xdNone
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 320
    Top = 24
  end
  object qrPESSOAS_CONTATOS: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOAS_CONTATOSReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PESSOAS_CONTATOS')
    Left = 568
    Top = 80
  end
  object qrPESSOAS_ENDERECOS: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PESSOAS_ENDERECOS')
    Left = 568
    Top = 136
  end
  object qrCLIENTES: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 568
    Top = 192
  end
  object qrDataCEP: TFDQuery
    CachedUpdates = True
    Connection = ConexaoDataCEP
    SQL.Strings = (
      
        'SELECT C.NOME, C.COD_IBGE, EST.UF, E.CEP FROM ENDERECO E INNER J' +
        'OIN CIDADES C ON (E.ID_CIDADE=C.ID)  INNER JOIN ESTADOS EST ON (' +
        'EST.ID = E.ID_UF) WHERE E.CEP = :CEP')
    Left = 144
    Top = 240
    ParamData = <
      item
        Name = 'CEP'
        DataType = ftString
        ParamType = ptInput
        Value = '16200001'
      end>
    object qrDataCEPNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 255
    end
    object qrDataCEPCOD_IBGE: TStringField
      FieldName = 'COD_IBGE'
      Origin = 'COD_IBGE'
      Size = 8
    end
    object qrDataCEPUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
    object qrDataCEPCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 9
    end
  end
  object ConexaoDataCEP: TFDConnection
    Params.Strings = (
      'Database=C:\Gigatron\BaseCEP\DataCep.FDB'
      'User_Name=sysdba'
      'Password=lib1503'
      'Server=LocalHost'
      'Port=3060'
      'DriverID=FB'
      'Pooled=False')
    LoginPrompt = False
    Left = 48
    Top = 240
  end
  object qrFORNECEDORES: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FORNECEDORES')
    Left = 568
    Top = 248
  end
  object QR_GigaERP: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FORNECEDORES')
    Left = 320
    Top = 88
  end
  object qrPRODUTOS: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPRODUTOSReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PRODUTOS')
    Left = 744
    Top = 24
  end
  object qrPRODUTOS_GRADE: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PRODUTOS_GRADE')
    Left = 744
    Top = 80
  end
  object qrPRODUTOS_APELIDOS_PROD: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PRODUTOS_APELIDOS_PROD')
    Left = 744
    Top = 136
  end
  object qrPRODUTOS_CUSTO: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PRODUTOS_CUSTO')
    Left = 744
    Top = 192
  end
  object qrPRODUTOS_GRADE_UND: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOS_GRADE_UNDUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PRODUTOS_GRADE_UND')
    Left = 744
    Top = 248
  end
  object qrPRODUTOS_TABELA: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PRODUTOS_TABELA')
    Left = 744
    Top = 304
  end
  object qrPRODUTOS_TAB_PRECOS_PROD: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM PRODUTOS_TAB_PRECOS_PROD')
    Left = 744
    Top = 360
  end
  object QR_GigaERP_Aux: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FORNECEDORES')
    Left = 320
    Top = 144
  end
  object qrUNIDADES_MEDIDA: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM UNIDADES_MEDIDA')
    Left = 744
    Top = 416
  end
  object TempPRODUTOS_APELIDOS_PROD: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 720
    object TempPRODUTOS_APELIDOS_PRODCOD_APELIDO: TIntegerField
      FieldName = 'COD_APELIDO'
    end
    object TempPRODUTOS_APELIDOS_PRODCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Size = 13
    end
    object TempPRODUTOS_APELIDOS_PRODCOD_GRADE: TStringField
      FieldName = 'COD_GRADE'
      Size = 25
    end
    object TempPRODUTOS_APELIDOS_PRODAPELIDO: TStringField
      FieldName = 'APELIDO'
      Size = 25
    end
  end
  object TempPRODUTOS_CUSTO: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 776
    object TempPRODUTOS_CUSTOCOD_EMPRESA: TIntegerField
      FieldName = 'COD_EMPRESA'
    end
    object TempPRODUTOS_CUSTOCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Size = 13
    end
    object TempPRODUTOS_CUSTOCOD_GRADE: TStringField
      FieldName = 'COD_GRADE'
      Size = 25
    end
    object TempPRODUTOS_CUSTOPRECO_CUSTO: TBCDField
      FieldName = 'PRECO_CUSTO'
      Size = 15
    end
    object TempPRODUTOS_CUSTOVR_OUTRAS_DESPESAS: TBCDField
      FieldName = 'VR_OUTRAS_DESPESAS'
      Size = 5
    end
    object TempPRODUTOS_CUSTOICMS_ALIQ: TBCDField
      FieldName = 'ICMS_ALIQ'
      Size = 5
    end
    object TempPRODUTOS_CUSTOIPI_ALIQ: TBCDField
      FieldName = 'IPI_ALIQ'
      Size = 5
    end
    object TempPRODUTOS_CUSTOST_IVA: TBCDField
      FieldName = 'ST_IVA'
      Size = 5
    end
    object TempPRODUTOS_CUSTOST_ICMS_ALIQ: TBCDField
      FieldName = 'ST_ICMS_ALIQ'
      Size = 5
    end
    object TempPRODUTOS_CUSTOPRECO_CUSTO_REAL: TBCDField
      FieldName = 'PRECO_CUSTO_REAL'
      Size = 5
    end
    object TempPRODUTOS_CUSTODATA_ULTIMO_REAJUSTE: TDateField
      FieldName = 'DATA_ULTIMO_REAJUSTE'
    end
    object TempPRODUTOS_CUSTOVR_FRETE: TBCDField
      FieldName = 'VR_FRETE'
      Size = 5
    end
    object TempPRODUTOS_CUSTOVR_SEGURO: TBCDField
      FieldName = 'VR_SEGURO'
      Size = 5
    end
    object TempPRODUTOS_CUSTOVR_DESC_CUSTO: TBCDField
      FieldName = 'VR_DESC_CUSTO'
      Size = 5
    end
    object TempPRODUTOS_CUSTOICMS_RED_BASE: TBCDField
      FieldName = 'ICMS_RED_BASE'
      Size = 5
    end
    object TempPRODUTOS_CUSTOST_ICMS_RED_BASE: TBCDField
      FieldName = 'ST_ICMS_RED_BASE'
      Size = 5
    end
    object TempPRODUTOS_CUSTOPIS_ALIQ: TBCDField
      FieldName = 'PIS_ALIQ'
      Size = 5
    end
    object TempPRODUTOS_CUSTOCOFINS_ALIQ: TBCDField
      FieldName = 'COFINS_ALIQ'
      Size = 5
    end
    object TempPRODUTOS_CUSTOIPI_TIPO_ALIQUOTA: TSmallintField
      FieldName = 'IPI_TIPO_ALIQUOTA'
    end
    object TempPRODUTOS_CUSTOPIS_TIPO_ALIQUOTA: TSmallintField
      FieldName = 'PIS_TIPO_ALIQUOTA'
    end
    object TempPRODUTOS_CUSTOCOFINS_TIPO_ALIQUOTA: TSmallintField
      FieldName = 'COFINS_TIPO_ALIQUOTA'
    end
    object TempPRODUTOS_CUSTOST_ICMS_VR_PAUTA: TBCDField
      FieldName = 'ST_ICMS_VR_PAUTA'
      Size = 5
    end
  end
  object TempPRODUTOS_TAB_PRECOS_PROD: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 592
    object TempPRODUTOS_TAB_PRECOS_PRODCOD_EMPRESA: TIntegerField
      FieldName = 'COD_EMPRESA'
    end
    object TempPRODUTOS_TAB_PRECOS_PRODCOD_TABELA: TIntegerField
      FieldName = 'COD_TABELA'
    end
    object TempPRODUTOS_TAB_PRECOS_PRODCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Size = 13
    end
    object TempPRODUTOS_TAB_PRECOS_PRODCOD_GRADE: TStringField
      FieldName = 'COD_GRADE'
      Size = 25
    end
    object TempPRODUTOS_TAB_PRECOS_PRODPRECO: TFloatField
      FieldName = 'PRECO'
    end
  end
  object qrImport: TFDQuery
    CachedUpdates = True
    ConstraintsEnabled = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    FormatOptions.AssignedValues = [fvSE2Null]
    FormatOptions.StrsEmpty2Null = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields]
    SQL.Strings = (
      'SELECT * FROM FORNECEDORES')
    Left = 320
    Top = 256
  end
  object conexaoConfig: TFDConnection
    Params.Strings = (
      
        'Database=D:\Documentos\Gigatron\GigaProjetosXE8\Importa Giga2Gig' +
        'a\Win32\Debug\app\Base.fdb'
      'User_Name=sysdba'
      'Password=lib1503'
      'Server=RAW-NOT'
      'Port=3060'
      'DriverID=FB')
    LoginPrompt = False
    Left = 56
    Top = 336
  end
  object qrPERFIL: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = conexaoConfig
    SQL.Strings = (
      'SELECT * FROM PERFIL')
    Left = 56
    Top = 392
    object qrPERFILCOD_PERFIL: TIntegerField
      FieldName = 'COD_PERFIL'
      Origin = 'COD_PERFIL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrPERFILNOME_PERFIL: TStringField
      FieldName = 'NOME_PERFIL'
      Origin = 'NOME_PERFIL'
      Size = 50
    end
    object qrPERFILBASECEP: TStringField
      FieldName = 'BASECEP'
      Origin = 'BASECEP'
      Size = 100
    end
    object qrPERFILBASEGIGA: TStringField
      FieldName = 'BASEGIGA'
      Origin = 'BASEGIGA'
      Size = 100
    end
    object qrPERFILUSER: TStringField
      FieldName = 'USER'
      Origin = '"USER"'
      Size = 50
    end
    object qrPERFILPASSWORD: TStringField
      FieldName = 'PASSWORD'
      Origin = '"PASSWORD"'
      Size = 50
    end
    object qrPERFILSQL_PESSOAS: TStringField
      FieldName = 'SQL_PESSOAS'
      Origin = 'SQL_PESSOAS'
      Size = 500
    end
  end
  object qrASSOC: TFDQuery
    AfterOpen = qrASSOCAfterOpen
    BeforePost = qrASSOCBeforePost
    CachedUpdates = True
    MasterFields = 'COD_PERFIL'
    DetailFields = 'COD_PERFIL'
    OnReconcileError = qrPESSOASReconcileError
    Connection = conexaoConfig
    SQL.Strings = (
      'SELECT * FROM ASSOCIAR')
    Left = 56
    Top = 448
    object qrASSOCCOD_PERFIL: TIntegerField
      FieldName = 'COD_PERFIL'
      Origin = 'COD_PERFIL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrASSOCCOD_ASSOCIA: TIntegerField
      FieldName = 'COD_ASSOCIA'
      Origin = 'COD_ASSOCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrASSOCCAMPOGIGA: TStringField
      FieldName = 'CAMPOGIGA'
      Origin = 'CAMPOGIGA'
      Size = 50
    end
    object qrASSOCCAMPOIMPORT: TStringField
      FieldName = 'CAMPOIMPORT'
      Origin = 'CAMPOIMPORT'
      Size = 50
    end
  end
  object QR_Config: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = conexaoConfig
    SQL.Strings = (
      'SELECT * FROM PERFIL')
    Left = 136
    Top = 336
  end
  object qrCLASS_FISCAIS: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM CLASS_FISCAIS')
    Left = 744
    Top = 472
  end
  object TempManutencaoEstoque: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 648
    object TempManutencaoEstoqueCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Size = 13
    end
    object TempManutencaoEstoqueCOD_GRADE: TStringField
      FieldName = 'COD_GRADE'
      Size = 25
    end
    object TempManutencaoEstoqueQTD: TFloatField
      FieldName = 'QTD'
    end
    object TempManutencaoEstoqueUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 5
    end
  end
  object qrMANUTENCOES_ESTOQUES_ITENS: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM MANUTENCOES_ESTOQUES_ITENS')
    Left = 744
    Top = 592
    object qrMANUTENCOES_ESTOQUES_ITENSCOD_EMPRESA: TIntegerField
      FieldName = 'COD_EMPRESA'
      Origin = 'COD_EMPRESA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrMANUTENCOES_ESTOQUES_ITENSCOD_MANUTENCAO: TIntegerField
      FieldName = 'COD_MANUTENCAO'
      Origin = 'COD_MANUTENCAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrMANUTENCOES_ESTOQUES_ITENSCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 13
    end
    object qrMANUTENCOES_ESTOQUES_ITENSCOD_GRADE: TStringField
      FieldName = 'COD_GRADE'
      Origin = 'COD_GRADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 25
    end
    object qrMANUTENCOES_ESTOQUES_ITENSUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      Required = True
    end
    object qrMANUTENCOES_ESTOQUES_ITENSQTD_ESTOQUE: TBCDField
      FieldName = 'QTD_ESTOQUE'
      Origin = 'QTD_ESTOQUE'
      Required = True
      Precision = 18
      Size = 3
    end
    object qrMANUTENCOES_ESTOQUES_ITENSQTD_DIGITADA: TBCDField
      FieldName = 'QTD_DIGITADA'
      Origin = 'QTD_DIGITADA'
      Required = True
      Precision = 18
      Size = 3
    end
    object qrMANUTENCOES_ESTOQUES_ITENSFLAG_ZERAR_QTD: TIntegerField
      FieldName = 'FLAG_ZERAR_QTD'
      Origin = 'FLAG_ZERAR_QTD'
      Required = True
    end
    object qrMANUTENCOES_ESTOQUES_ITENSQTD_ESTOQUE_DESTINO: TBCDField
      FieldName = 'QTD_ESTOQUE_DESTINO'
      Origin = 'QTD_ESTOQUE_DESTINO'
      Required = True
      Precision = 18
      Size = 3
    end
    object qrMANUTENCOES_ESTOQUES_ITENSPP_TIMESTAMP: TSQLTimeStampField
      FieldName = 'PP_TIMESTAMP'
      Origin = 'PP_TIMESTAMP'
    end
    object qrMANUTENCOES_ESTOQUES_ITENSPP_CLOCK_UPDATE: TLargeintField
      FieldName = 'PP_CLOCK_UPDATE'
      Origin = 'PP_CLOCK_UPDATE'
    end
    object qrMANUTENCOES_ESTOQUES_ITENSPP_CLOCK_INSERT: TLargeintField
      FieldName = 'PP_CLOCK_INSERT'
      Origin = 'PP_CLOCK_INSERT'
    end
    object qrMANUTENCOES_ESTOQUES_ITENSPP_NOT_UPDATED: TSmallintField
      FieldName = 'PP_NOT_UPDATED'
      Origin = 'PP_NOT_UPDATED'
    end
    object qrMANUTENCOES_ESTOQUES_ITENSPP_ID_GLOBAL: TStringField
      FieldName = 'PP_ID_GLOBAL'
      Origin = 'PP_ID_GLOBAL'
      FixedChar = True
      Size = 22
    end
    object qrMANUTENCOES_ESTOQUES_ITENSPP_ID_LOCAL: TLargeintField
      FieldName = 'PP_ID_LOCAL'
      Origin = 'PP_ID_LOCAL'
    end
  end
  object qrTRANSPORTADORAS: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM TRANSPORTADORAS')
    Left = 568
    Top = 304
  end
  object qrImportAux: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FORNECEDORES')
    Left = 320
    Top = 312
  end
  object qrFATURAS_RECEBER: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_RECEBER'
      '')
    Left = 928
    Top = 24
  end
  object qrFATURAS_RECEBER_RATEIO: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_RECEBER_RATEIO')
    Left = 928
    Top = 80
  end
  object qrFATURAS_RECEBER_PARCELAS: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_RECEBER_PARCELAS')
    Left = 928
    Top = 136
  end
  object qrFATURAS_RECEBER_PARCELAS_BX: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_RECEBER_PARCELAS_BX')
    Left = 928
    Top = 192
  end
  object qrCLIENTES_TABELA: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM CLIENTES_TABELA')
    Left = 568
    Top = 360
  end
  object qrFATURAS_PAGAR: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_PAGAR'
      '')
    Left = 928
    Top = 288
  end
  object qrFATURAS_PAGAR_RATEIO: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_PAGAR_RATEIO')
    Left = 928
    Top = 344
  end
  object qrFATURAS_PAGAR_PARCELAS: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_PAGAR_PARCELAS')
    Left = 928
    Top = 400
  end
  object qrFATURAS_PAGAR_PARCELAS_BX: TFDQuery
    CachedUpdates = True
    OnUpdateError = qrPRODUTOSUpdateError
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FATURAS_PAGAR_PARCELAS_BX')
    Left = 928
    Top = 456
  end
  object qrFORNECIMENTOS: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FORNECIMENTOS')
    Left = 744
    Top = 656
  end
  object qr_GEN_ID: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FORNECEDORES')
    Left = 320
    Top = 200
  end
  object qrGRUPOS_PRODUTO: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM GRUPOS_PRODUTO')
    Left = 744
    Top = 528
  end
  object FDQuery1: TFDQuery
    CachedUpdates = True
    OnReconcileError = qrPESSOASReconcileError
    Connection = ConexaoGigaERP
    SQL.Strings = (
      'SELECT * FROM FORNECIMENTOS')
    Left = 264
    Top = 544
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 432
    Top = 48
  end
end
