unit untDM;

interface

uses
  Forms, StrUtils, Variants, System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RotinasRaul, Datasnap.DBClient,
  FireDAC.VCLUI.Error, FireDAC.Comp.UI;

{$REGION 'DM'}

type
  TDM = class(TDataModule)
    QR_Origem: TFDQuery;
    QR_Destino: TFDQuery;
    conexaoOrigem: TFDConnection;
    conexaoDestino: TFDConnection;
    QR_PK: TFDQuery;
    conexaoSisco: TFDConnection;
    QR_Sisco: TFDQuery;
    QR_Tabelas: TFDQuery;
    QR_TabelasTABELA: TWideStringField;
    qrPESSOAS: TFDQuery;
    ConexaoGigaERP: TFDConnection;
    qrPESSOAS_CONTATOS: TFDQuery;
    qrPESSOAS_ENDERECOS: TFDQuery;
    qrCLIENTES: TFDQuery;
    qrDataCEP: TFDQuery;
    ConexaoDataCEP: TFDConnection;
    qrDataCEPNOME: TStringField;
    qrDataCEPCOD_IBGE: TStringField;
    qrDataCEPUF: TStringField;
    qrDataCEPCEP: TStringField;
    qrFORNECEDORES: TFDQuery;
    QR_GigaERP: TFDQuery;
    qrPRODUTOS: TFDQuery;
    qrPRODUTOS_GRADE: TFDQuery;
    qrPRODUTOS_APELIDOS_PROD: TFDQuery;
    qrPRODUTOS_CUSTO: TFDQuery;
    qrPRODUTOS_GRADE_UND: TFDQuery;
    qrPRODUTOS_TABELA: TFDQuery;
    qrPRODUTOS_TAB_PRECOS_PROD: TFDQuery;
    QR_GigaERP_Aux: TFDQuery;
    qrUNIDADES_MEDIDA: TFDQuery;
    TempPRODUTOS_APELIDOS_PROD: TClientDataSet;
    TempPRODUTOS_CUSTO: TClientDataSet;
    TempPRODUTOS_TAB_PRECOS_PROD: TClientDataSet;
    TempPRODUTOS_APELIDOS_PRODCOD_APELIDO: TIntegerField;
    TempPRODUTOS_APELIDOS_PRODCOD_PRODUTO: TStringField;
    TempPRODUTOS_APELIDOS_PRODCOD_GRADE: TStringField;
    TempPRODUTOS_APELIDOS_PRODAPELIDO: TStringField;
    TempPRODUTOS_TAB_PRECOS_PRODCOD_EMPRESA: TIntegerField;
    TempPRODUTOS_TAB_PRECOS_PRODCOD_TABELA: TIntegerField;
    TempPRODUTOS_TAB_PRECOS_PRODCOD_PRODUTO: TStringField;
    TempPRODUTOS_TAB_PRECOS_PRODCOD_GRADE: TStringField;
    TempPRODUTOS_TAB_PRECOS_PRODPRECO: TFloatField;
    TempPRODUTOS_CUSTOPRECO_CUSTO: TBCDField;
    TempPRODUTOS_CUSTODATA_ULTIMO_REAJUSTE: TDateField;
    TempPRODUTOS_CUSTOIPI_TIPO_ALIQUOTA: TSmallintField;
    qrImport: TFDQuery;
    conexaoConfig: TFDConnection;
    qrPERFIL: TFDQuery;
    qrPERFILCOD_PERFIL: TIntegerField;
    qrPERFILNOME_PERFIL: TStringField;
    qrPERFILBASECEP: TStringField;
    qrPERFILBASEGIGA: TStringField;
    qrPERFILUSER: TStringField;
    qrPERFILPASSWORD: TStringField;
    qrASSOC: TFDQuery;
    qrASSOCCOD_PERFIL: TIntegerField;
    qrASSOCCOD_ASSOCIA: TIntegerField;
    qrASSOCCAMPOGIGA: TStringField;
    qrASSOCCAMPOIMPORT: TStringField;
    qrPERFILSQL_PESSOAS: TStringField;
    QR_Config: TFDQuery;
    qrCLASS_FISCAIS: TFDQuery;
    TempManutencaoEstoque: TClientDataSet;
    TempManutencaoEstoqueCOD_PRODUTO: TStringField;
    TempManutencaoEstoqueCOD_GRADE: TStringField;
    TempManutencaoEstoqueQTD: TFloatField;
    qrMANUTENCOES_ESTOQUES_ITENS: TFDQuery;
    qrMANUTENCOES_ESTOQUES_ITENSCOD_EMPRESA: TIntegerField;
    qrMANUTENCOES_ESTOQUES_ITENSCOD_MANUTENCAO: TIntegerField;
    qrMANUTENCOES_ESTOQUES_ITENSCOD_PRODUTO: TStringField;
    qrMANUTENCOES_ESTOQUES_ITENSCOD_GRADE: TStringField;
    qrMANUTENCOES_ESTOQUES_ITENSUNIDADE: TStringField;
    qrMANUTENCOES_ESTOQUES_ITENSQTD_ESTOQUE: TBCDField;
    qrMANUTENCOES_ESTOQUES_ITENSQTD_DIGITADA: TBCDField;
    qrMANUTENCOES_ESTOQUES_ITENSFLAG_ZERAR_QTD: TIntegerField;
    qrMANUTENCOES_ESTOQUES_ITENSQTD_ESTOQUE_DESTINO: TBCDField;
    qrMANUTENCOES_ESTOQUES_ITENSPP_TIMESTAMP: TSQLTimeStampField;
    qrMANUTENCOES_ESTOQUES_ITENSPP_CLOCK_UPDATE: TLargeintField;
    qrMANUTENCOES_ESTOQUES_ITENSPP_CLOCK_INSERT: TLargeintField;
    qrMANUTENCOES_ESTOQUES_ITENSPP_NOT_UPDATED: TSmallintField;
    qrMANUTENCOES_ESTOQUES_ITENSPP_ID_GLOBAL: TStringField;
    qrMANUTENCOES_ESTOQUES_ITENSPP_ID_LOCAL: TLargeintField;
    TempManutencaoEstoqueUNIDADE: TStringField;
    qrTRANSPORTADORAS: TFDQuery;
    qrImportAux: TFDQuery;
    qrFATURAS_RECEBER: TFDQuery;
    qrFATURAS_RECEBER_RATEIO: TFDQuery;
    qrFATURAS_RECEBER_PARCELAS: TFDQuery;
    qrFATURAS_RECEBER_PARCELAS_BX: TFDQuery;
    qrCLIENTES_TABELA: TFDQuery;
    qrFATURAS_PAGAR: TFDQuery;
    qrFATURAS_PAGAR_RATEIO: TFDQuery;
    qrFATURAS_PAGAR_PARCELAS: TFDQuery;
    qrFATURAS_PAGAR_PARCELAS_BX: TFDQuery;
    qrFORNECIMENTOS: TFDQuery;
    qr_GEN_ID: TFDQuery;
    qrGRUPOS_PRODUTO: TFDQuery;
    FDQuery1: TFDQuery;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    procedure qrPESSOASReconcileError(DataSet: TFDDataSet; E: EFDException; UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);
    procedure qrPRODUTOSUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
    procedure DataModuleDestroy(Sender: TObject);
    procedure qrASSOCBeforePost(DataSet: TDataSet);
    procedure qrASSOCAfterOpen(DataSet: TDataSet);
    procedure qrPESSOAS_CONTATOSReconcileError(DataSet: TFDDataSet; E: EFDException; UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);
    procedure qrPRODUTOSReconcileError(DataSet: TFDDataSet;
      E: EFDException; UpdateKind: TFDDatSRowState;
      var Action: TFDDAptReconcileAction);
    procedure qrPRODUTOS_GRADE_UNDUpdateError(ASender: TDataSet;
      AException: EFDException; ARow: TFDDatSRow;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
  private
    function isNull(Valor: Variant; Res: Variant; Data: boolean = False): Variant;
    { Private declarations }
  public
    Cod_Assoc: Integer;
    Base     : String;
    Port     : String;
    Server   : String;
    User     : String;
    Password : String;
    procedure ConectaCEP(DataCEP: String; Port: String = '3060'; Server: String = 'LocalHost'; User: String = 'SYSDBA'; Pass: String = 'lib1503');
    function GeraCod(Gen: String): Integer;
    procedure ConnectaGigaERP;
    procedure FechaConexoes;
    { Public declarations }
  end;
{$ENDREGION}
{$REGION 'PESSOAS'}
{$REGION 'TABELAS PESSOAS'}

type
  TPESSOAS = Record
    COD_PESSOA: Integer;
    RAZAO_SOCIAL: STRING[60];
    NOME_FANTASIA: STRING[60];
    CNPJ_CPF: STRING;
    TIPO_CLASSIFICACAO: Integer;
    SITE: STRING[40];
    DATA_CADASTRO: TDATE;
    OBS_PESSOA: STRING[80];
    FLAG_ATIVO: Integer;
    OBS_INATIVO: STRING[80];
    HISTORICO: STRING;
    FLAG_CLIENTE: Integer;
    FLAG_FORNECEDOR: Integer;
    FLAG_VENDEDOR: Integer;
    FLAG_TRANSPORT: Integer;
    FLAG_CONVENIO: Integer;
    DATA_ALTERACAO: TDATE;
    INSCR_ESTADUAL: STRING[30];
    RG: STRING[14];
    SUFRAMA: STRING[9];
    EMAIL: STRING[60];
    IGN_FLAG_HOMONIMO: Integer;
    FLAG_RAMO_RURAL: Integer;
    FLAG_FUNC: Integer;
    INSCR_MUNICIPAL: STRING[14];
    CHAVE_OLD: STRING[60];
    FLAG_CONTRIB_ICMS: Integer;
    procedure Create;
  end;

type
  TPESSOAS_CONTATOS = Record
    COD_PESSOA: Integer;
    COD_CONTATO: Integer;
    DESC_CONTATO: STRING[40];
    OCUPACAO: STRING[30];
    DATA_NASCIMENTO: TDATE;
    EMAIL: STRING[40];
    TELEFONE: STRING[10];
    RAMAL: Integer;
    CELULAR: STRING[11];
    FAX: STRING[10];
    FLAG_ENVIA_NFE: Integer;
    FLAG_ENVIA_BOLETO: Integer;
    procedure Create;
  end;

type
  TPESSOAS_ENDERECOS = Record
    COD_PESSOA: Integer;
    SEQ_PES_END: Integer;
    ENDERECO: STRING[40];
    NUMERO: STRING[10];
    COMPLEMENTO: STRING[25];
    BAIRRO: STRING[30];
    CEP: STRING[8];
    PONTO_REFERENCIA: STRING[40];
    COD_MUNIC: STRING[7];
    TELEFONE: STRING;
    FAX: STRING[15];
    FLAG_PRINCIPAL: Integer;
    FLAG_ENTREGA: Integer;
    FLAG_COBRANCA: Integer;
    FLAG_OUTROS: Integer;
    DESC_OUTROS: STRING[30];
    COD_PAIS: STRING[5];
    NOME_MUNIC: STRING;
    UF: STRING;
    procedure Create;
  end;

type
  TCLIENTES = Record
    COD_CLIENTE: Integer;
    DATA_NASCIMENTO: TDATE;
    SEXO: Integer;
    NACIONALIDADE: STRING[10];
    BLOQUEIO_DIAS_INADIMP: Integer;
    INTERVALO_DIAS_VENDA: Integer;
    PERC_DESCONTO_VENDA: REAL;
    FLAG_HABILITA_DUPLICATA: Integer;
    FLAG_HABILITA_CHEQUE: Integer;
    FLAG_EMITE_NOTA: Integer;
    FLAG_EMITE_BOLETO: Integer;
    FLAG_SERASA: Integer;
    FLAG_TELE_CHEQUE: Integer;
    FLAG_SPC: Integer;
    FLAG_OUTROS: Integer;
    DESC_BLOQUEIO: STRING[50];
    LIMITE_CREDITO: REAL;
    COD_COBRANCA: Integer;
    COD_VENDEDOR: Integer;
    DATA_MENSAGEM: TDATE;
    TEXTO_MENSAGEM: STRING[80];
    DIRETORIO: STRING[200];
    REFERENCIA_COMERCIAL1: STRING[50];
    REFERENCIA_COMERCIAL2: STRING[50];
    REFERENCIA_COMERCIAL3: STRING[50];
    REFERENCIA_COMERCIAL4: STRING[50];
    TRAB_PROFISSAO: STRING[30];
    TRAB_LOCAL: STRING[30];
    TRAB_COD_FUNC: STRING[10];
    TRAB_CARGO: STRING[200];
    TRAB_RENDA: REAL;
    CONJ_ESTADO_CIVIL: STRING[20];
    CONJ_NOME: STRING[30];
    CONJ_RENDA: REAL;
    CONJ_CPF: STRING[11];
    CONJ_PROFISSAO: STRING[30];
    CONJ_REGIME: STRING[30];
    CONJ_TRABALHO: STRING[50];
    CONJ_RG: STRING[14];
    CHAVE_OLD: Integer;
    COD_TABELA: Integer;
    COD_PLANO_PAGAMENTO: Integer;
    DIA_VENCIMENTO: Integer;
    SITUACAO: STRING[4];
    BLOQUEADO: Integer;
    FLAG_ECF_RESTRICAO: Integer;
    FLAG_RETENCAO_ISS: Integer;
    COD_TRANSPORTADORA: Integer;
    DIA_FECHAMENTO: Integer;
    DEMONSTRATIVO_BOLETO: STRING;
    FLAG_ATIVO: Integer;
    OBS_INATIVO: string;
    procedure Create;
  end;

type
  TCLIENTES_TABELA = Record
    COD_CLIENTE: Integer;
    COD_TABELA: Integer;
    COD_TABELA_ITEM: Integer;
    DESC_TABELA: STRING;
    DESC_TABELA_ITEM: STRING;
    procedure Create;
  end;

type
  TFORNECEDORES = Record
    COD_FORNECEDOR: Integer;
    CHAVE_OLD: Integer;
    FLAG_ATIVO: Integer;
    OBS_INATIVO: string;
    procedure Create;
  end;

type
  TTRANSPORTADORAS = Record
    COD_TRANSPORTADORA: Integer;
    CHAVE_OLD: Integer;
    PLACA_PADRAO_VEICULO: String;
    UF_PADRAO_VEICULO: String;
    FLAG_ATIVO: Integer;
    OBS_INATIVO: string;
    procedure Create;
  end;
{$ENDREGION}

type
  TCadastro_Pessoas = Class
    TIPO_CADASTRO: Integer; { 1 = CLIENTES; 2 = FORNECEDORES; 3 = TRANSPORTADORAS }
    PESSOAS: TPESSOAS;
    CLIENTES: TCLIENTES;
    CLIENTES_TABELA: array of TCLIENTES_TABELA;
    FORNECEDORES: TFORNECEDORES;
    TRANSPORTADORAS: TTRANSPORTADORAS;
    PESSOAS_CONTATOS: array [1 .. 5] of TPESSOAS_CONTATOS;
    PESSOAS_ENDERECOS: array [1 .. 5] of TPESSOAS_ENDERECOS;
    constructor Create;
  private
    COD_PESSOA         : Integer;
    FLAG_CLIENTE       : Integer;
    FLAG_FORNECEDOR    : Integer;
    FLAG_TRANSPORTADORA: Integer;
    procedure PESSOAS_VALORES;
    procedure PESSOAS_CONTATOS_VALORES(I: Integer);
    procedure PESSOAS_ENDERECOS_VALORES(I: Integer);
    procedure CLIENTES_VALORES;
    procedure FORNECEDORES_VALORE;
    procedure TRANSPORTADORAS_VALORES;
    function BuscaCOD_MUNIC(NOME_MUNIC, UF: STRING): STRING;
  public
    procedure Refresh;
    procedure AppendOrEditRELACIONAMENTO(I: Integer);
    procedure AppendOrEdit;
    procedure ApplyUpdates;
    procedure Connect;
    procedure Open;
    procedure AtribuiValor(CAMPO, Valor: Variant);
  end;
{$ENDREGION}
{$REGION 'PRODUTOS'}
{$REGION 'TABELAS DE PRODUTOS'}
{$REGION 'Tabela: PRODUTOS'}

type
  TPRODUTOS = Record
    T: Integer;
    COD_PRODUTO: STRING;
    DESC_PRODUTO: STRING;
    DESC_PRODUTO_FISCAL: STRING;
    COD_GRUPO: Integer;
    FLAG_MARGEM_LUCRO: Integer;
    PERC_MARGEM_LUCRO: REAL;
    OBS: STRING;
    PESO_LIQUIDO: REAL;
    PESO_BRUTO: REAL;
    COD_LISTA_SERVICO: STRING;
    FLAG_BAIXA_ESTOQUE: Integer;
    FLAG_SERVICO: Integer;
    FLAG_DESC_ADICIONAL: Integer;
    FLAG_METRO_CUBICO: Integer;
    FLAG_ATIVO: Integer;
    FLAG_AGRUPA_SERVICO: Integer;
    FLAG_PESO: Integer;
    COD_CLASS: STRING;
    FLAG_RMA: Integer;
    FLAG_QTD_PECAS: Integer;
    COD_IMPOSTO: Integer;
    TIPO_PRODUCAO: STRING;
    COD_TIPO_ITEM: Integer;
    PERC_COMISSAO_VISTA: REAL;
    PERC_COMISSAO_PRAZO: REAL;
    FLAG_PROD_ESPECIFICO: Integer;
    FLAG_PROD_ACABADO: Integer;
    QTD_VOLUME: Integer;
    COMB_COD_ANP: STRING;
    COMB_CODIF: STRING;
    COD_SETOR: Integer;
    FLAG_MT_QUADRADO: Integer;
    FLAG_ENVIA_CARDAPIO: Integer;
    COD_NBS: STRING;
    ALIQ_NAC: REAL;
    GF_FLAG_AGRUP: Integer;
    GF_COD_PRODUTO: STRING;
    GF_INGREDIENTES: STRING;
    EC_FLAG_ENVIA: Integer;
    EC_INFORMACOES: STRING;
    GF_FLAG_COMPLEMENTO: Integer;
    GF_FLAG_CORTESIA: Integer;
    CHAVE_OLD: STRING;
    COMB_DERIVADO_PETROLEO: Integer;
    COMB_PERC_GAS_NATURAL: REAL;
    // DESC_PRODUTO_FISCAL_OLD: STRING;
    ALIQ_FEDERAL: REAL;
    ALIQ_ESTADUAL: REAL;
    ALIQ_MUNICIPAL: REAL;
    FLAG_VENDAFF: Integer;
    COD_CEST: STRING;
    FLAG_MATERIA_PRIMA: Integer;
    FLAG_VRTOTAL: Integer;
  public
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$REGION 'Tabela: PRODUTOS_GRADE'}

type
  TPRODUTOS_GRADE = Record
    T: Integer;
    COD_PRODUTO: STRING;
    COD_GRADE: STRING;
    ORDEM: Integer;
    FLAG_ATIVO: Integer;
    ESTOQUE_MIN: REAL;
    ESTOQUE_MAX: REAL;
    COD_BALANCA: Integer;
    DIAS_VALIDADE: Integer;
    DATA_VALIDADE: TDATE;
    OBS: STRING;
    ECF_ESTOQUE: REAL;
    COD_PRODUTO_ANT: STRING;
    COD_GRADE_ANT: STRING;
    QTD_ESTOQUE: REAL;
  public
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$REGION 'Tabela: PRODUTOS_APELIDOS_PROD'}

type
  TPRODUTOS_APELIDOS_PROD = Record
    T: Integer;
    COD_APELIDO: Integer;
    COD_PRODUTO: STRING;
    COD_GRADE: STRING;
    APELIDO: STRING;
  public
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$REGION 'Tabela: PRODUTOS_CUSTO'}

type
  TPRODUTOS_CUSTO = Record
    T: Integer;
    COD_EMPRESA: Integer;
    COD_PRODUTO: STRING;
    COD_GRADE: STRING;
    PRECO_CUSTO: REAL;
    VR_OUTRAS_DESPESAS: REAL;
    ICMS_ALIQ: REAL;
    IPI_ALIQ: REAL;
    ST_IVA: REAL;
    ST_ICMS_ALIQ: REAL;
    PRECO_CUSTO_REAL: REAL;
    DATA_ULTIMO_REAJUSTE: TDATE;
    VR_FRETE: REAL;
    VR_SEGURO: REAL;
    VR_DESC_CUSTO: REAL;
    ICMS_RED_BASE: REAL;
    ST_ICMS_RED_BASE: REAL;
    PIS_ALIQ: REAL;
    COFINS_ALIQ: REAL;
    IPI_TIPO_ALIQUOTA: Integer;
    PIS_TIPO_ALIQUOTA: Integer;
    COFINS_TIPO_ALIQUOTA: Integer;
    ST_ICMS_VR_PAUTA: REAL;
  public
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$REGION 'Tabela: PRODUTOS_GRADE_UND'}

type
  TPRODUTOS_GRADE_UND = Record
    T: Integer;
    COD_PRODUTO: STRING;
    COD_GRADE: STRING;
    UNIDADE: STRING;
    ID: STRING;
    FLAG_PADRAO: Integer;
    FLAG_ATIVO: Integer;
    FLAG_HABILITA_ENTRADA: Integer;
    FLAG_HABILITA_SAIDA: Integer;
    IGN_ALTERADO: Integer;
  public
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$REGION 'Tabela: PRODUTOS_TABELA'}

type
  TPRODUTOS_TABELA = Record
    T: Integer;
    COD_PRODUTO: STRING;
    COD_TABELA: Integer;
    COD_TABELA_ITEM: Integer;
    TABELA_ITEM_DESC: String;
  public
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$REGION 'Tabela: PRODUTOS_TAB_PRECOS_PROD'}

type
  TPRODUTOS_TAB_PRECOS_PROD = Record
    T: Integer;
    COD_EMPRESA: Integer;
    COD_TABELA: Integer;
    COD_PRODUTO: STRING;
    COD_GRADE: STRING;
    PRECO: REAL;
  public
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$REGION 'PRODUTOS_FORNECIMENTOS'}

type
  TFORNECIMENTOS = Record
    COD_FORNECIMENTO: Integer;
    COD_EMPRESA: Integer;
    COD_FORNECEDOR: Integer;
    COD_FORNECEDOR_OLD: Integer;
    COD_PRODUTO_FORNECEDOR: STRING;
    COD_PRODUTO: STRING;
    COD_GRADE: STRING;
    COD_PRODUTO_DIGITADO: STRING;
    procedure IniciarVariaveis;
  end;
{$ENDREGION}
{$ENDREGION}

type
  TCadastro_Produtos = Class
    PRODUTOS: TPRODUTOS;
    PRODUTOS_GRADE: TPRODUTOS_GRADE;
    PRODUTOS_FORNECIMENTOS: TFORNECIMENTOS;
    PRODUTOS_APELIDOS_PROD: array [1 .. 100] of TPRODUTOS_APELIDOS_PROD;
    PRODUTOS_CUSTO: array [1 .. 100] of TPRODUTOS_CUSTO;
    PRODUTOS_GRADE_UND: array [1 .. 100] of TPRODUTOS_GRADE_UND;
    PRODUTOS_TABELA: array [1 .. 3] of TPRODUTOS_TABELA;
    PRODUTOS_TAB_PRECOS_PROD: array [1 .. 100] of TPRODUTOS_TAB_PRECOS_PROD;
    constructor Create;
    procedure Cadastra_imposto_padrao(COD_IMPOSTO: String = '1'; DESC_IMPOSTO: String = 'TRIBUTADO');
    procedure Cadastra_Grupo_Padrão;
    procedure Cadastra_NCM_99;
    procedure CadastraRelacionamento(COD_RELAC: Integer; DESC_RELAC: String);
    procedure Reseta_Todas_Sequencias;
    procedure AppendOrEdit;
    procedure AppendOrEditPRODUTOS;
    procedure AppendOrEditGRADES;
    procedure ApplyUpdates;
    procedure Open;
    procedure ConfereUND(UND: String);
    procedure ConfereNCM(NCM: String);
  private
    COD_PRODUTO: String;
    COD_GRADE  : String;
    UNIDADE    : String;
    ESTOQUE    : boolean;
    procedure PRODUTOS_VALORES;
    procedure PRODUTOS_FORNECIMENTOS_VALORES;
    procedure PRODUTOS_GRADE_VALORES;
    procedure PRODUTOS_APELIDOS_PROD_VALORES(I: Integer);
    procedure PRODUTOS_CUSTO_VALORES(I: Integer);
    procedure PRODUTOS_GRADE_UND_VALORES(I: Integer);
    procedure PRODUTOS_TABELA_VALORES(I: Integer);
    procedure PRODUTOS_TAB_PRECOS_PROD_VALORES(I: Integer);
    procedure MANUTENCAO_ESTOQUE;

    function PRODUTOS_APELIDOS_PROD_APLICA: Integer;
    function PRODUTOS_CUSTO_APLICA: Integer;
    function PRODUTOS_TAB_PRECOS_PROD_APLICA: Integer;
    function Coalesce(Valor, Resp: String): String;
  public
    COD_EMPRESA: Integer;
  end;
{$ENDREGION}
{$REGION 'RECEBER'}
{$REGION 'TABELAS FATURAS'}

type
  TFATURAS_RECEBER = Record
    COD_EMPRESA: Integer;
    TIPO_FATURA: STRING;
    COD_FATURA: Integer;
    COD_CLIENTE: Integer;
    COD_CLIENTE_OLD: STRING;
    COD_VENDEDOR: Integer;
    DATA_EMISSAO: TDATE;
    VR_BRUTO: REAL;
    VR_DESCONTOS: REAL;
    VR_ACRESCIMOS: REAL;
    VR_LIQUIDO: REAL;
    CHAVE_OLD: STRING;
    FLAG_DUPL_IMPRESSA: Integer;
    procedure IniciarVariaveis;
  end;

type
  TFATURAS_RECEBER_RATEIO = Record
    COD_EMPRESA: Integer;
    TIPO_FATURA: STRING;
    COD_FATURA: Integer;
    COD_RATEIO: Integer;
    COD_PC: Integer;
    COD_CC: Integer;
    VR_RATEIO: REAL;
    PERC_RATEIO: REAL;
    HISTORICO: STRING;
    FLAG_DEMONSTRATIVO: Integer;
    procedure IniciarVariaveis;
  end;

type
  TFATURAS_RECEBER_PARCELAS = Record
    COD_EMPRESA: Integer;
    TIPO_FATURA: STRING;
    COD_FATURA: Integer;
    COD_PARC: STRING;
    COD_BANCO: Integer;
    COD_BANCO_SEQ: Integer;
    DATA_VENCIMENTO: TDATE;
    DATA_RECEBIMENTO: TDATE;
    VR_PARCELA: REAL;
    VR_BAIXA: REAL;
    VR_BAIXA_OUTRAS: REAL;
    DATA_LIMITE_DESCONTO: TDATE;
    PERC_DESCONTO: REAL;
    FLAG_CARTORIO: Integer;
    VR_CARTORIO: REAL;
    DATA_CARTORIO: TDATE;
    FLAG_PROTESTO: Integer;
    VR_PROTESTO: REAL;
    DATA_PROTESTO: TDATE;
    OBS: STRING;
    COD_COBRANCA: Integer;
    NOSSO_NUMERO: STRING;
    CHAVE_OLD: STRING;
    CHAVE_ECF: STRING;
    FLAG_TP_NOTA: Integer;
    procedure IniciarVariaveis;
  end;

type
  TFATURAS_RECEBER_PARCELAS_BX = Record
    COD_EMPRESA: Integer;
    TIPO_FATURA: STRING;
    COD_FATURA: Integer;
    COD_PARC: STRING;
    COD_BAIXA: Integer;
    TIPO_BAIXA: STRING;
    COD_BANCO: Integer;
    COD_BANCO_SEQ: Integer;
    DESC_BAIXA: STRING;
    DATA_RECEBIMENTO: TDATE;
    DATA_CONTABIL: TDATE;
    VR_BAIXA: REAL;
    VR_DESCONTOS: REAL;
    VR_JUROS: REAL;
    VR_ACRESCIMOS: REAL;
    VR_CARTORIO: REAL;
    VR_PROTESTO: REAL;
    HISTORICO1: STRING;
    HISTORICO2: STRING;
    HISTORICO3: STRING;
    ANO_MES: Integer;
    LANCAMENTO: Integer;
    FLAG_BAIXA: Integer;
    DEV_COD_EMPRESA: Integer;
    DEV_COD_DEV: Integer;
    CHAVE_OLD: STRING;
    VR_HAVER: REAL;
    VR_MULTA: REAL;
    procedure IniciarVariaveis;
  end;
{$ENDREGION}

type
  TCadastro_Receber = Class
    FATURAS_RECEBER: TFATURAS_RECEBER;
    FATURAS_RECEBER_RATEIO: TFATURAS_RECEBER_RATEIO;
    FATURAS_RECEBER_PARCELAS: TFATURAS_RECEBER_PARCELAS;
    FATURAS_RECEBER_PARCELAS_BX: TFATURAS_RECEBER_PARCELAS_BX;
    constructor Create;
  private
    COD_EMPRESA: Integer;
    COD_FATURA : Integer;
    TIPO_FATURA: String;
    COD_PARC   : String;
    COD_BAIXA  : Integer;
    procedure FATURAS_RECEBER_VALORES;
    procedure FATURAS_RECEBER_RATEIO_VALORES;
    procedure FATURAS_RECEBER_PARCELAS_VALORES;
    procedure FATURAS_RECEBER_PARCELAS_BX_VALORES;
  public
    procedure Open;
    procedure AppendFatura;
    procedure AppendParcela;
    procedure ApplyUpdates;
  end;
{$ENDREGION}
{$REGION 'PAGAR'}
{$REGION 'TABELAS FATURAS'}

type
  TFATURAS_PAGAR = Record
    COD_EMPRESA: Integer;
    COD_SEQUENCIA: Integer;
    TIPO_FATURA: Integer;
    COD_FORNECEDOR: Integer;
    COD_FORNECEDOR_OLD: STRING;
    DOCUMENTO: STRING;
    DATA_EMISSAO: TDATE;
    DATA_ENTRADA: TDATE;
    DESCRICAO: STRING;
    VR_BRUTO: REAL;
    VR_DESCONTOS: REAL;
    VR_ACRESCIMOS: REAL;
    VR_LIQUIDO: REAL;
    ANO_MES: Integer;
    SEQ_DESP_FIXA: Integer;
    COD_DESP_FIXA: Integer;
    DEV_COD_EMPRESA: Integer;
    DEV_COD_DEV: Integer;
    CHAVE_OLD: STRING;
    procedure IniciarVariaveis;
  end;

type
  TFATURAS_PAGAR_RATEIO = Record
    COD_EMPRESA: Integer;
    COD_SEQUENCIA: Integer;
    COD_RATEIO: Integer;
    COD_CC: Integer;
    COD_PC: Integer;
    VR_RATEIO: REAL;
    HISTORICO: STRING;
    FLAG_DEMONSTRATIVO: Integer;
    procedure IniciarVariaveis;
  end;

type
  TFATURAS_PAGAR_PARCELAS = Record
    COD_EMPRESA: Integer;
    COD_SEQUENCIA: Integer;
    COD_PARC: STRING;
    DATA_VENCIMENTO: TDATE;
    DATA_PAGAMENTO: TDATE;
    VR_PARCELA: REAL;
    VR_BAIXA: REAL;
    VR_BAIXA_OUTRAS: REAL;
    COD_BANCO: Integer;
    COD_COBRANCA: Integer;
    OBS: STRING;
    FLAG_PREVISAO: Integer;
    CHAVE_OLD: STRING;
    procedure IniciarVariaveis;
  end;

type
  TFATURAS_PAGAR_PARCELAS_BX = Record
    COD_EMPRESA: Integer;
    COD_SEQUENCIA: Integer;
    COD_PARC: STRING;
    COD_BAIXA: Integer;
    TIPO_BAIXA: STRING;
    DESC_BAIXA: STRING;
    DATA_PAGAMENTO: TDATE;
    DATA_CONTABIL: TDATE;
    VR_BAIXA: REAL;
    VR_JUROS: REAL;
    VR_ACRESCIMOS: REAL;
    VR_DESCONTOS: REAL;
    COD_BANCO: Integer;
    COD_BANCO_SEQ: Integer;
    HISTORICO1: STRING;
    HISTORICO2: STRING;
    HISTORICO3: STRING;
    N_DOCUMENTO: STRING;
    ANO_MES: Integer;
    LANCAMENTO: Integer;
    FLAG_BLOQUEADO: Integer;
    FLAG_BAIXA: Integer;
    CHAVE_OLD: STRING;
    procedure IniciarVariaveis;
  end;
{$ENDREGION}

type
  TCadastro_Pagar = Class
    FATURAS_PAGAR: TFATURAS_PAGAR;
    FATURAS_PAGAR_RATEIO: TFATURAS_PAGAR_RATEIO;
    FATURAS_PAGAR_PARCELAS: TFATURAS_PAGAR_PARCELAS;
    FATURAS_PAGAR_PARCELAS_BX: TFATURAS_PAGAR_PARCELAS_BX;
    constructor Create;
  private
    COD_EMPRESA  : Integer;
    COD_SEQUENCIA: Integer;
    TIPO_FATURA  : String;
    COD_PARC     : Integer;
    COD_BAIXA    : Integer;
    procedure FATURAS_PAGAR_VALORES;
    procedure FATURAS_PAGAR_RATEIO_VALORES;
    procedure FATURAS_PAGAR_PARCELAS_VALORES;
    procedure FATURAS_PAGAR_PARCELAS_BX_VALORES;
  public
    procedure Open;
    procedure AppendFatura;
    procedure ApplyUpdates;
  end;
{$ENDREGION}

const
  tpCLIENETS: Integer        = 1;
  tpFORNECEDORES: Integer    = 2;
  tpTRANSPORTADORAS: Integer = 3;

var
  DM: TDM;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }


{$R *.dfm}
{$REGION 'TCadastro_Pessoas' }

procedure TCadastro_Pessoas.ApplyUpdates;
begin
  try
    if DM.qrPESSOAS.ApplyUpdates(0) = 0 then
      if DM.qrPESSOAS_CONTATOS.ApplyUpdates(0) = 0 then
        if DM.qrPESSOAS_ENDERECOS.ApplyUpdates(0) = 0 then
        begin
          case TIPO_CADASTRO of
            1:
              DM.qrCLIENTES.ApplyUpdates();
            2:
              DM.qrFORNECEDORES.ApplyUpdates();
            3:
              DM.qrTRANSPORTADORAS.ApplyUpdates();
          end;
        end;
    DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Pessoas.AtribuiValor(CAMPO, Valor: Variant);
begin
  with DM do
  begin
    if Trim(CAMPO) = 'PESSOAS_COD_PESSOA' then
      PESSOAS.COD_PESSOA := Valor;
    if Trim(CAMPO) = 'PESSOAS_RAZAO_SOCIAL' then
      PESSOAS.RAZAO_SOCIAL := Valor;
    if Trim(CAMPO) = 'PESSOAS_NOME_FANTASIA' then
      PESSOAS.NOME_FANTASIA := Valor;
    if Trim(CAMPO) = 'PESSOAS_CNPJ_CPF' then
      PESSOAS.CNPJ_CPF := Valor;
    if Trim(CAMPO) = 'PESSOAS_TIPO_CLASSIFICACAO' then
      PESSOAS.TIPO_CLASSIFICACAO := Valor;
    if Trim(CAMPO) = 'PESSOAS_SITE' then
      PESSOAS.SITE := Valor;
    if Trim(CAMPO) = 'PESSOAS_DATA_CADASTRO' then
      PESSOAS.DATA_CADASTRO := Valor;
    if Trim(CAMPO) = 'PESSOAS_OBS_PESSOA' then
      PESSOAS.OBS_PESSOA := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_ATIVO' then
      PESSOAS.FLAG_ATIVO := Valor;
    if Trim(CAMPO) = 'PESSOAS_OBS_INATIVO' then
      PESSOAS.OBS_INATIVO := Valor;
    if Trim(CAMPO) = 'PESSOAS_HISTORICO' then
      PESSOAS.HISTORICO := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_CLIENTE' then
      PESSOAS.FLAG_CLIENTE := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_FORNECEDOR' then
      PESSOAS.FLAG_FORNECEDOR := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_VENDEDOR' then
      PESSOAS.FLAG_VENDEDOR := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_TRANSPORT' then
      PESSOAS.FLAG_TRANSPORT := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_CONVENIO' then
      PESSOAS.FLAG_CONVENIO := Valor;
    if Trim(CAMPO) = 'PESSOAS_DATA_ALTERACAO' then
      PESSOAS.DATA_ALTERACAO := Valor;
    if Trim(CAMPO) = 'PESSOAS_INSCR_ESTADUAL' then
      PESSOAS.INSCR_ESTADUAL := Valor;
    if Trim(CAMPO) = 'PESSOAS_RG' then
      PESSOAS.RG := Valor;
    if Trim(CAMPO) = 'PESSOAS_SUFRAMA' then
      PESSOAS.SUFRAMA := Valor;
    if Trim(CAMPO) = 'PESSOAS_EMAIL' then
      PESSOAS.EMAIL := IfThen(Valor = Null, '', Valor);
    if Trim(CAMPO) = 'PESSOAS_IGN_FLAG_HOMONIMO' then
      PESSOAS.IGN_FLAG_HOMONIMO := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_RAMO_RURAL' then
      PESSOAS.FLAG_RAMO_RURAL := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_FUNC' then
      PESSOAS.FLAG_FUNC := Valor;
    if Trim(CAMPO) = 'PESSOAS_INSCR_MUNICIPAL' then
      PESSOAS.INSCR_MUNICIPAL := Valor;
    if Trim(CAMPO) = 'PESSOAS_CHAVE_OLD' then
      PESSOAS.CHAVE_OLD := Valor;
    if Trim(CAMPO) = 'PESSOAS_FLAG_CONTRIB_ICMS' then
      PESSOAS.FLAG_CONTRIB_ICMS := Valor;
  end;
end;

function TCadastro_Pessoas.BuscaCOD_MUNIC(NOME_MUNIC, UF: STRING): STRING;
var
  SQL: string;
begin
  NOME_MUNIC := StringReplace(NOME_MUNIC, Chr(39), '', [rfReplaceAll]);
  SQL        := 'SELECT COD_MUNIC FROM MUNICIPIOS WHERE NOME_MUNIC = ''' + UpperCase(NOME_MUNIC) + ''' AND UF = ''' + UpperCase(UF) + '''';
  DM.QR_GigaERP.Open(SQL);
  Result := DM.QR_GigaERP.FieldByName('COD_MUNIC').AsString;
end;

procedure TCadastro_Pessoas.AppendOrEditRELACIONAMENTO(I: Integer);
begin
  with DM do
  begin
    QR_GigaERP.Close;
    QR_GigaERP.Open(' SELECT * FROM TABELA_DO_SISTEMA_ITEM' + ' WHERE COD_CLIENTE = ' + IntToStr(COD_PESSOA) + '   AND COD_TABELA = ' + IntToStr(I) + '   AND COD_TABELA_ITEM = ' +
      IntToStr(CLIENTES_TABELA[I].COD_TABELA_ITEM));
    if QR_GigaERP.IsEmpty then
    begin
      ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO) VALUES (' + IntToStr(I) + ', ' + CLIENTES_TABELA[I].DESC_TABELA + ') MATCHING (COD_TABELA);');
      ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO) VALUES (' + IntToStr(I) + ', ' + IntToStr(CLIENTES_TABELA[I].COD_TABELA_ITEM) + ', '
        + CLIENTES_TABELA[I].DESC_TABELA_ITEM + ') MATCHING (COD_TABELA, COD_TABELA_ITEM);');
    end;

    qrCLIENTES_TABELA.FieldByName('COD_CLIENTE').Value := COD_PESSOA;
    qrCLIENTES_TABELA.FieldByName('COD_TABELA').Value  := isNull(CLIENTES_TABELA[I].COD_TABELA, I);
    qrCLIENTES_TABELA.FieldByName('COD_TABELA').Value  := isNull(CLIENTES_TABELA[I].COD_TABELA_ITEM, Null);
  end;

end;

procedure TCadastro_Pessoas.CLIENTES_VALORES;
begin
  with DM do
  begin
    qrCLIENTES.FieldByName('COD_CLIENTE').Value           := COD_PESSOA;
    qrCLIENTES.FieldByName('DATA_NASCIMENTO').Value       := isNull(CLIENTES.DATA_NASCIMENTO, Null, True);
    qrCLIENTES.FieldByName('SEXO').Value                  := isNull(CLIENTES.SEXO, 0);
    qrCLIENTES.FieldByName('NACIONALIDADE').Value         := isNull(CLIENTES.NACIONALIDADE, Null);
    qrCLIENTES.FieldByName('BLOQUEIO_DIAS_INADIMP').Value := isNull(CLIENTES.BLOQUEIO_DIAS_INADIMP, 0);
    qrCLIENTES.FieldByName('INTERVALO_DIAS_VENDA').Value  := isNull(CLIENTES.INTERVALO_DIAS_VENDA, 0);
    qrCLIENTES.FieldByName('PERC_DESCONTO_VENDA').Value   := isNull(CLIENTES.PERC_DESCONTO_VENDA, 0.00);
    qrCLIENTES.FieldByName('FLAG_HABILITA_DUPLICATA').Value := isNull(CLIENTES.FLAG_HABILITA_DUPLICATA, 1);
    qrCLIENTES.FieldByName('FLAG_HABILITA_CHEQUE').Value  := isNull(CLIENTES.FLAG_HABILITA_CHEQUE, 1);
    qrCLIENTES.FieldByName('FLAG_EMITE_NOTA').Value       := isNull(CLIENTES.FLAG_EMITE_NOTA, 1);
    qrCLIENTES.FieldByName('FLAG_EMITE_BOLETO').Value     := isNull(CLIENTES.FLAG_EMITE_BOLETO, 1);
    qrCLIENTES.FieldByName('FLAG_SERASA').Value           := isNull(CLIENTES.FLAG_SERASA, 0);
    qrCLIENTES.FieldByName('FLAG_TELE_CHEQUE').Value      := isNull(CLIENTES.FLAG_TELE_CHEQUE, 0);
    qrCLIENTES.FieldByName('FLAG_SPC').Value              := isNull(CLIENTES.FLAG_SPC, 0);
    qrCLIENTES.FieldByName('FLAG_OUTROS').Value           := isNull(CLIENTES.FLAG_OUTROS, 0);
    qrCLIENTES.FieldByName('DESC_BLOQUEIO').Value         := isNull(CLIENTES.DESC_BLOQUEIO, Null);
    qrCLIENTES.FieldByName('LIMITE_CREDITO').Value        := isNull(CLIENTES.LIMITE_CREDITO, 0.00);
    qrCLIENTES.FieldByName('COD_COBRANCA').Value          := isNull(CLIENTES.COD_COBRANCA, 1);
    qrCLIENTES.FieldByName('COD_VENDEDOR').Value          := isNull(CLIENTES.COD_VENDEDOR, 1);
    qrCLIENTES.FieldByName('DATA_MENSAGEM').Value         := isNull(CLIENTES.DATA_MENSAGEM, Null, True);
    qrCLIENTES.FieldByName('TEXTO_MENSAGEM').Value        := isNull(CLIENTES.TEXTO_MENSAGEM, Null);
    qrCLIENTES.FieldByName('DIRETORIO').Value             := isNull(CLIENTES.DIRETORIO, Null);
    qrCLIENTES.FieldByName('REFERENCIA_COMERCIAL1').Value := isNull(CLIENTES.REFERENCIA_COMERCIAL1, Null);
    qrCLIENTES.FieldByName('REFERENCIA_COMERCIAL2').Value := isNull(CLIENTES.REFERENCIA_COMERCIAL2, Null);
    qrCLIENTES.FieldByName('REFERENCIA_COMERCIAL3').Value := isNull(CLIENTES.REFERENCIA_COMERCIAL3, Null);
    qrCLIENTES.FieldByName('REFERENCIA_COMERCIAL4').Value := isNull(CLIENTES.REFERENCIA_COMERCIAL4, Null);
    qrCLIENTES.FieldByName('TRAB_PROFISSAO').Value        := isNull(CLIENTES.TRAB_PROFISSAO, Null);
    qrCLIENTES.FieldByName('TRAB_LOCAL').Value            := isNull(CLIENTES.TRAB_LOCAL, Null);
    qrCLIENTES.FieldByName('TRAB_COD_FUNC').Value         := isNull(CLIENTES.TRAB_COD_FUNC, Null);
    qrCLIENTES.FieldByName('TRAB_CARGO').Value            := isNull(CLIENTES.TRAB_CARGO, Null);
    qrCLIENTES.FieldByName('TRAB_RENDA').Value            := isNull(CLIENTES.TRAB_RENDA, Null);
    qrCLIENTES.FieldByName('CONJ_ESTADO_CIVIL').Value     := isNull(CLIENTES.CONJ_ESTADO_CIVIL, 'Solteiro(a)');
    qrCLIENTES.FieldByName('CONJ_NOME').Value             := isNull(CLIENTES.CONJ_NOME, Null);
    qrCLIENTES.FieldByName('CONJ_RENDA').Value            := isNull(CLIENTES.CONJ_RENDA, Null);
    qrCLIENTES.FieldByName('CONJ_CPF').Value              := isNull(CLIENTES.CONJ_CPF, Null);
    qrCLIENTES.FieldByName('CONJ_PROFISSAO').Value        := isNull(CLIENTES.CONJ_PROFISSAO, Null);
    qrCLIENTES.FieldByName('CONJ_REGIME').Value           := isNull(CLIENTES.CONJ_REGIME, Null);
    qrCLIENTES.FieldByName('CONJ_TRABALHO').Value         := isNull(CLIENTES.CONJ_TRABALHO, Null);
    qrCLIENTES.FieldByName('CONJ_RG').Value               := isNull(CLIENTES.CONJ_RG, Null);
    qrCLIENTES.FieldByName('CHAVE_OLD').Value             := isNull(CLIENTES.CHAVE_OLD, Null);
    qrCLIENTES.FieldByName('COD_TABELA').Value            := isNull(CLIENTES.COD_TABELA, Null);
    qrCLIENTES.FieldByName('COD_PLANO_PAGAMENTO').Value   := isNull(CLIENTES.COD_PLANO_PAGAMENTO, Null);
    qrCLIENTES.FieldByName('DIA_VENCIMENTO').Value        := isNull(CLIENTES.DIA_VENCIMENTO, Null);
    qrCLIENTES.FieldByName('SITUACAO').Value              := isNull(CLIENTES.SITUACAO, Null);
    qrCLIENTES.FieldByName('BLOQUEADO').Value             := isNull(CLIENTES.BLOQUEADO, Null);
    qrCLIENTES.FieldByName('FLAG_ECF_RESTRICAO').Value    := isNull(CLIENTES.FLAG_ECF_RESTRICAO, Null);
    qrCLIENTES.FieldByName('FLAG_RETENCAO_ISS').Value     := isNull(CLIENTES.FLAG_RETENCAO_ISS, 0);
    qrCLIENTES.FieldByName('COD_TRANSPORTADORA').Value    := isNull(CLIENTES.COD_TRANSPORTADORA, Null);
    qrCLIENTES.FieldByName('DIA_FECHAMENTO').Value        := isNull(CLIENTES.DIA_FECHAMENTO, Null);
    qrCLIENTES.FieldByName('DEMONSTRATIVO_BOLETO').Value  := isNull(CLIENTES.DEMONSTRATIVO_BOLETO, Null);
    qrCLIENTES.FieldByName('FLAG_ATIVO').Value            := isNull(CLIENTES.FLAG_ATIVO, 1);
    qrCLIENTES.FieldByName('OBS_INATIVO').Value        := isNull(CLIENTES.OBS_INATIVO, Null);
  end;
end;

procedure TCadastro_Pessoas.Connect;
begin
  try
    with DM do
    begin
      ConectaGigaERP(ConexaoGigaERP);
    end;
  except
    on E: Exception do
      raise Exception.Create('TClientes.Connect' + #13 + E.Message);
  end;
end;

constructor TCadastro_Pessoas.Create;
begin
  Refresh;
  Open;
end;

procedure TCadastro_Pessoas.FORNECEDORES_VALORE;
begin
  with DM do
  begin
    qrFORNECEDORES.FieldByName('COD_FORNECEDOR').Value := COD_PESSOA;
    qrFORNECEDORES.FieldByName('CHAVE_OLD').Value      := isNull(FORNECEDORES.CHAVE_OLD, Null);
    qrFORNECEDORES.FieldByName('FLAG_ATIVO').Value     := isNull(FORNECEDORES.FLAG_ATIVO, 1);
    qrFORNECEDORES.FieldByName('OBS_INATIVO').Value    := isNull(FORNECEDORES.OBS_INATIVO, Null);
  end;
end;

procedure TCadastro_Pessoas.Open;
begin
  DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
  DM.qrPESSOAS.Open();
  DM.qrPESSOAS_CONTATOS.Open();
  DM.qrPESSOAS_ENDERECOS.Open();
  // if TIPO_CADASTRO = 1 then
  DM.qrCLIENTES.Open();
  // if TIPO_CADASTRO = 2 then
  DM.qrFORNECEDORES.Open();
  DM.qrTRANSPORTADORAS.Open();
end;

procedure TCadastro_Pessoas.AppendOrEdit;
var
  I: Integer;
begin
  with DM do
  begin
    if PESSOAS.COD_PESSOA = (-99999) then
      COD_PESSOA := DM.GeraCod('SPESSOAS')
    else
      COD_PESSOA := PESSOAS.COD_PESSOA;
    if COD_PESSOA < 4 then
      raise Exception.Create('O codigo precisa ser maior que 3');

    if qrPESSOAS.Locate('COD_PESSOA', COD_PESSOA, []) then
      qrPESSOAS.Edit
    else
      qrPESSOAS.Append;
    PESSOAS_VALORES;
    qrPESSOAS.Post;

    I := 1;
    while (PESSOAS_CONTATOS[I].COD_CONTATO > 0) or (I = 1) do
    begin
      if qrPESSOAS_CONTATOS.Locate('COD_PESSOA;COD_CONTATO', VarArrayOf([COD_PESSOA, isNull(PESSOAS_CONTATOS[I].COD_CONTATO, 1)]), []) then
        qrPESSOAS_CONTATOS.Edit
      else
        qrPESSOAS_CONTATOS.Append;
      PESSOAS_CONTATOS_VALORES(I);
      qrPESSOAS_CONTATOS.Post;
      Inc(I);
    end;

    I := 1;
    while (Trim(PESSOAS_ENDERECOS[I].ENDERECO) <> '') or (I = 1) do
    begin
      if qrPESSOAS_ENDERECOS.Locate('COD_PESSOA;SEQ_PES_END', VarArrayOf([COD_PESSOA, isNull(PESSOAS_ENDERECOS[I].SEQ_PES_END, I)]), []) then
        qrPESSOAS_ENDERECOS.Edit
      else
        qrPESSOAS_ENDERECOS.Append;
      PESSOAS_ENDERECOS_VALORES(I);
      qrPESSOAS_ENDERECOS.Post;
      Inc(I);
    end;

    case TIPO_CADASTRO of
      1:
        begin
          if qrCLIENTES.Locate('COD_CLIENTE', COD_PESSOA, []) then
            qrCLIENTES.Edit
          else
            qrCLIENTES.Append;
          CLIENTES_VALORES;
          qrCLIENTES.Post;
        end;
      2:
        begin
          if qrFORNECEDORES.Locate('COD_FORNECEDOR', COD_PESSOA, []) then
            qrFORNECEDORES.Edit
          else
            qrFORNECEDORES.Append;
          FORNECEDORES_VALORE;
          qrFORNECEDORES.Post;
        end;
      3:
        begin
          if qrTRANSPORTADORAS.Locate('COD_TRANSPORTADORA', COD_PESSOA, []) then
            qrTRANSPORTADORAS.Edit
          else
            qrTRANSPORTADORAS.Append;
          TRANSPORTADORAS_VALORES;
          qrTRANSPORTADORAS.Post;
        end;
    end;
  end;
end;

procedure TCadastro_Pessoas.PESSOAS_CONTATOS_VALORES(I: Integer);
begin
  with DM do
  begin
    qrPESSOAS_CONTATOS.FieldByName('COD_PESSOA').Value   := COD_PESSOA;
    qrPESSOAS_CONTATOS.FieldByName('COD_CONTATO').Value  := I;
    qrPESSOAS_CONTATOS.FieldByName('DESC_CONTATO').Value := isNull(PESSOAS_CONTATOS[I].DESC_CONTATO, Null);
    qrPESSOAS_CONTATOS.FieldByName('OCUPACAO').Value     := isNull(PESSOAS_CONTATOS[I].OCUPACAO, Null);
    qrPESSOAS_CONTATOS.FieldByName('DATA_NASCIMENTO').Value := isNull(PESSOAS_CONTATOS[I].DATA_NASCIMENTO, Null, True);
    qrPESSOAS_CONTATOS.FieldByName('EMAIL').Value          := isNull(PESSOAS_CONTATOS[I].EMAIL, Null);
    qrPESSOAS_CONTATOS.FieldByName('TELEFONE').Value       := isNull(RetiraNaoNumero(PESSOAS_CONTATOS[I].TELEFONE), Null);
    qrPESSOAS_CONTATOS.FieldByName('RAMAL').Value          := isNull(PESSOAS_CONTATOS[I].RAMAL, Null);
    qrPESSOAS_CONTATOS.FieldByName('CELULAR').Value        := isNull(RetiraNaoNumero(PESSOAS_CONTATOS[I].CELULAR), Null);
    qrPESSOAS_CONTATOS.FieldByName('FAX').Value            := isNull(RetiraNaoNumero(PESSOAS_CONTATOS[I].FAX), Null);
    qrPESSOAS_CONTATOS.FieldByName('FLAG_ENVIA_NFE').Value := isNull(PESSOAS_CONTATOS[I].FLAG_ENVIA_NFE, Null);
    qrPESSOAS_CONTATOS.FieldByName('FLAG_ENVIA_BOLETO').Value := isNull(PESSOAS_CONTATOS[I].FLAG_ENVIA_BOLETO, 0);
  end;
end;

procedure TCadastro_Pessoas.PESSOAS_ENDERECOS_VALORES(I: Integer);
var
  COD_MUNIC : String;
  NOME_MUNIC: String;
  UF        : String;
begin
  with DM do
  begin
    qrPESSOAS_ENDERECOS.FieldByName('COD_PESSOA').Value  := COD_PESSOA;
    qrPESSOAS_ENDERECOS.FieldByName('SEQ_PES_END').Value := I;
    qrPESSOAS_ENDERECOS.FieldByName('ENDERECO').Value    := isNull(PESSOAS_ENDERECOS[I].ENDERECO, Null);
    qrPESSOAS_ENDERECOS.FieldByName('NUMERO').Value      := isNull(PESSOAS_ENDERECOS[I].NUMERO, Null);
    qrPESSOAS_ENDERECOS.FieldByName('COMPLEMENTO').Value := isNull(PESSOAS_ENDERECOS[I].COMPLEMENTO, Null);
    qrPESSOAS_ENDERECOS.FieldByName('BAIRRO').Value      := isNull(PESSOAS_ENDERECOS[I].BAIRRO, Null);
    qrPESSOAS_ENDERECOS.FieldByName('CEP').Value         := isNull(RetiraNaoNumero(PESSOAS_ENDERECOS[I].CEP), Null);
    qrPESSOAS_ENDERECOS.FieldByName('PONTO_REFERENCIA').Value := isNull(PESSOAS_ENDERECOS[I].PONTO_REFERENCIA, Null);
    COD_MUNIC  := PESSOAS_ENDERECOS[I].COD_MUNIC;
    NOME_MUNIC := PESSOAS_ENDERECOS[I].NOME_MUNIC;
    UF         := PESSOAS_ENDERECOS[I].UF;
    if (Trim(COD_MUNIC) = '') and (Trim(NOME_MUNIC) <> '') and (Trim(UF) <> '') then
      COD_MUNIC := BuscaCOD_MUNIC(NOME_MUNIC, UF)
    else if Trim(COD_MUNIC) <> '' then
    begin
      DM.QR_GigaERP.Open('SELECT * FROM MUNICIPIOS WHERE COD_MUNIC = ' + COD_MUNIC);
      if DM.QR_GigaERP.RecordCount = 0 then
      begin
        if (Trim(NOME_MUNIC) <> '') and (Trim(UF) <> '') then
          COD_MUNIC := BuscaCOD_MUNIC(NOME_MUNIC, UF)
        else
          COD_MUNIC := '';
      end;
    end;

    qrPESSOAS_ENDERECOS.FieldByName('COD_MUNIC').Value := isNull(COD_MUNIC, Null);
    qrPESSOAS_ENDERECOS.FieldByName('TELEFONE').Value  := isNull(RetiraNaoNumero(PESSOAS_ENDERECOS[I].TELEFONE), Null);
    qrPESSOAS_ENDERECOS.FieldByName('FAX').Value       := isNull(RetiraNaoNumero(PESSOAS_ENDERECOS[I].FAX), Null);
    qrPESSOAS_ENDERECOS.FieldByName('FLAG_PRINCIPAL').Value := isNull(PESSOAS_ENDERECOS[I].FLAG_PRINCIPAL, IfThen(I = 1, '1', '0'));
    qrPESSOAS_ENDERECOS.FieldByName('FLAG_ENTREGA').Value  := isNull(PESSOAS_ENDERECOS[I].FLAG_ENTREGA, 1);
    qrPESSOAS_ENDERECOS.FieldByName('FLAG_COBRANCA').Value := isNull(PESSOAS_ENDERECOS[I].FLAG_COBRANCA, 1);
    qrPESSOAS_ENDERECOS.FieldByName('FLAG_OUTROS').Value   := isNull(PESSOAS_ENDERECOS[I].FLAG_OUTROS, 0);
    qrPESSOAS_ENDERECOS.FieldByName('DESC_OUTROS').Value   := isNull(PESSOAS_ENDERECOS[I].DESC_OUTROS, Null);
    qrPESSOAS_ENDERECOS.FieldByName('COD_PAIS').Value      := '01058';
  end;
end;

procedure TCadastro_Pessoas.PESSOAS_VALORES;
var
  TIPO_CLASSIFICACAO, FLAG_CONTRIB_ICMS: Integer;
  Tipo                                 : Integer;
begin
  with DM do
  begin
    FLAG_CLIENTE        := 0;
    FLAG_FORNECEDOR     := 0;
    FLAG_TRANSPORTADORA := 0;
    case TIPO_CADASTRO of
      1:
        FLAG_CLIENTE := 1;
      2:
        FLAG_FORNECEDOR := 1;
      3:
        FLAG_TRANSPORTADORA := 1;
    end;

    if UpperCase(Trim(PESSOAS.INSCR_ESTADUAL)) = 'ISENTO' then
      PESSOAS.INSCR_ESTADUAL := '';

    qrPESSOAS.FieldByName('COD_PESSOA').Value    := COD_PESSOA;
    qrPESSOAS.FieldByName('RAZAO_SOCIAL').Value  := isNull(PESSOAS.RAZAO_SOCIAL, Null);
    qrPESSOAS.FieldByName('NOME_FANTASIA').Value := isNull(PESSOAS.NOME_FANTASIA, PESSOAS.RAZAO_SOCIAL);
    qrPESSOAS.FieldByName('CNPJ_CPF').Value      := isNull(RetiraNaoNumero(PESSOAS.CNPJ_CPF), Null);
    if Length(Trim(qrPESSOAS.FieldByName('CNPJ_CPF').AsString)) < 14 then
      TIPO_CLASSIFICACAO := 1
    else
      TIPO_CLASSIFICACAO                              := 0;
    qrPESSOAS.FieldByName('TIPO_CLASSIFICACAO').Value := isNull(TIPO_CLASSIFICACAO, 1);
    qrPESSOAS.FieldByName('SITE').Value               := isNull(PESSOAS.SITE, Null);
    qrPESSOAS.FieldByName('DATA_CADASTRO').Value      := isNull(PESSOAS.DATA_CADASTRO, NOW);
    qrPESSOAS.FieldByName('OBS_PESSOA').Value         := isNull(PESSOAS.OBS_PESSOA, Null);
    //qrPESSOAS.FieldByName('FLAG_ATIVO').Value         := isNull(PESSOAS.FLAG_ATIVO, 1);
    //qrPESSOAS.FieldByName('OBS_INATIVO').Value        := isNull(PESSOAS.OBS_INATIVO, Null);
    qrPESSOAS.FieldByName('HISTORICO').Value          := isNull(PESSOAS.HISTORICO, Null);
    qrPESSOAS.FieldByName('FLAG_CLIENTE').Value       := isNull(PESSOAS.FLAG_CLIENTE, FLAG_CLIENTE);
    qrPESSOAS.FieldByName('FLAG_FORNECEDOR').Value    := isNull(PESSOAS.FLAG_FORNECEDOR, FLAG_FORNECEDOR);
    qrPESSOAS.FieldByName('FLAG_VENDEDOR').Value      := isNull(PESSOAS.FLAG_VENDEDOR, 0);
    qrPESSOAS.FieldByName('FLAG_TRANSPORT').Value     := isNull(PESSOAS.FLAG_TRANSPORT, FLAG_TRANSPORTADORA);
    qrPESSOAS.FieldByName('FLAG_CONVENIO').Value      := isNull(PESSOAS.FLAG_CONVENIO, 0);
    qrPESSOAS.FieldByName('DATA_ALTERACAO').Value     := isNull(PESSOAS.DATA_ALTERACAO, Null, True);
    qrPESSOAS.FieldByName('INSCR_ESTADUAL').Value     := isNull(PESSOAS.INSCR_ESTADUAL, Null);
    qrPESSOAS.FieldByName('RG').Value                 := isNull(PESSOAS.RG, Null);
    qrPESSOAS.FieldByName('SUFRAMA').Value            := isNull(PESSOAS.SUFRAMA, Null);
    qrPESSOAS.FieldByName('EMAIL').Value              := isNull(PESSOAS.EMAIL, Null);
    qrPESSOAS.FieldByName('IGN_FLAG_HOMONIMO').Value  := isNull(PESSOAS.IGN_FLAG_HOMONIMO, 0);
    qrPESSOAS.FieldByName('FLAG_RAMO_RURAL').Value    := isNull(PESSOAS.FLAG_RAMO_RURAL, 0);
    qrPESSOAS.FieldByName('FLAG_FUNC').Value          := isNull(PESSOAS.FLAG_FUNC, 0);
    qrPESSOAS.FieldByName('INSCR_MUNICIPAL').Value    := isNull(PESSOAS.INSCR_MUNICIPAL, Null);
    qrPESSOAS.FieldByName('CHAVE_OLD').Value          := isNull(PESSOAS.CHAVE_OLD, Null);

    if (TIPO_CLASSIFICACAO = 0) and (isNull(PESSOAS.INSCR_ESTADUAL, Null) <> Null) then
      FLAG_CONTRIB_ICMS := 1
    else
      FLAG_CONTRIB_ICMS                              := 9;
    qrPESSOAS.FieldByName('FLAG_CONTRIB_ICMS').Value := isNull(FLAG_CONTRIB_ICMS, 9);
    qrPESSOAS.FieldByName('FLAG_REGIME_TRIB').Value  := 9;
  end;
end;

procedure TCadastro_Pessoas.Refresh;
begin
  PESSOAS.Create;
  CLIENTES.Create;
  FORNECEDORES.Create;
  TRANSPORTADORAS.Create;
  PESSOAS_CONTATOS[1].Create;
  PESSOAS_ENDERECOS[1].Create;
  FLAG_CLIENTE    := 0;
  FLAG_FORNECEDOR := 0;
  case TIPO_CADASTRO of
    1:
      FLAG_CLIENTE := 1;
    2:
      FLAG_FORNECEDOR := 1;
  end;
end;

procedure TCadastro_Pessoas.TRANSPORTADORAS_VALORES;
begin
  with DM do
  begin
    qrTRANSPORTADORAS.FieldByName('COD_TRANSPORTADORA').Value := COD_PESSOA;
    qrTRANSPORTADORAS.FieldByName('CHAVE_OLD').Value := isNull(TRANSPORTADORAS.CHAVE_OLD, Null);
    qrTRANSPORTADORAS.FieldByName('PLACA_PADRAO_VEICULO').Value := isNull(TRANSPORTADORAS.PLACA_PADRAO_VEICULO, Null);
    qrTRANSPORTADORAS.FieldByName('UF_PADRAO_VEICULO').Value := isNull(TRANSPORTADORAS.UF_PADRAO_VEICULO, Null);
    qrTRANSPORTADORAS.FieldByName('FLAG_ATIVO').Value     := isNull(TRANSPORTADORAS.FLAG_ATIVO, 1);
    qrTRANSPORTADORAS.FieldByName('OBS_INATIVO').Value        := isNull(TRANSPORTADORAS.OBS_INATIVO, Null);
  end;
end;

{$REGION 'TABELAS'}

procedure TPESSOAS.Create;
begin
  COD_PESSOA         := -99999;
  RAZAO_SOCIAL       := '';
  NOME_FANTASIA      := '';
  CNPJ_CPF           := '';
  TIPO_CLASSIFICACAO := -99999;
  SITE               := '';
  DATA_CADASTRO      := NOW;
  OBS_PESSOA         := '';
  FLAG_ATIVO         := -99999;
  OBS_INATIVO        := '';
  HISTORICO          := '';
  FLAG_CLIENTE       := -99999;
  FLAG_FORNECEDOR    := -99999;
  FLAG_VENDEDOR      := -99999;
  FLAG_TRANSPORT     := -99999;
  FLAG_CONVENIO      := -99999;
  // DATA_ALTERACAO: TDATE;
  INSCR_ESTADUAL    := '';
  RG                := '';
  SUFRAMA           := '';
  EMAIL             := '';
  IGN_FLAG_HOMONIMO := -99999;
  FLAG_RAMO_RURAL   := -99999;
  FLAG_FUNC         := -99999;
  INSCR_MUNICIPAL   := '';
  CHAVE_OLD         := '';
  FLAG_CONTRIB_ICMS := -99999;
end;

{ TPESSOAS_CONTATOS }

procedure TPESSOAS_CONTATOS.Create;
begin
  COD_PESSOA        := -99999;
  COD_CONTATO       := -99999;
  DESC_CONTATO      := '';
  OCUPACAO          := '';
  DATA_NASCIMENTO   := StrToDate('01/01/1899');
  EMAIL             := '';
  TELEFONE          := '';
  RAMAL             := -99999;
  CELULAR           := '';
  FAX               := '';
  FLAG_ENVIA_NFE    := -99999;
  FLAG_ENVIA_BOLETO := -99999;
end;

{ PESSOAS_ENDERECOS }

procedure TPESSOAS_ENDERECOS.Create;
begin
  COD_PESSOA       := -99999;
  SEQ_PES_END      := -99999;
  ENDERECO         := '';
  NUMERO           := '';
  COMPLEMENTO      := '';
  BAIRRO           := '';
  CEP              := '';
  PONTO_REFERENCIA := '';
  COD_MUNIC        := '';
  TELEFONE         := '';
  FAX              := '';
  FLAG_PRINCIPAL   := -99999;
  FLAG_ENTREGA     := -99999;
  FLAG_COBRANCA    := -99999;
  FLAG_OUTROS      := -99999;
  // DESC_OUTROS: STRING[30];
  // COD_PAIS: STRING[5];
end;

{ CLIENTES }

procedure TCLIENTES.Create;
begin
  COD_CLIENTE := -99999;
  // DATA_NASCIMENTO: TDATE;
  SEXO := -99999;
  // NACIONALIDADE: STRING[10];
  BLOQUEIO_DIAS_INADIMP   := -99999;
  INTERVALO_DIAS_VENDA    := -99999;
  PERC_DESCONTO_VENDA     := -99999;
  FLAG_HABILITA_DUPLICATA := -99999;
  FLAG_HABILITA_CHEQUE    := -99999;
  FLAG_EMITE_NOTA         := -99999;
  FLAG_EMITE_BOLETO       := -99999;
  FLAG_SERASA             := -99999;
  FLAG_TELE_CHEQUE        := -99999;
  FLAG_SPC                := -99999;
  FLAG_OUTROS             := -99999;
  // DESC_BLOQUEIO: STRING[50];
  LIMITE_CREDITO := -99999;
  COD_COBRANCA   := -99999;
  COD_VENDEDOR   := -99999;
  // DATA_MENSAGEM: TDATE;
  // TEXTO_MENSAGEM: STRING[80];
  // DIRETORIO: STRING[200];
  // REFERENCIA_COMERCIAL1: STRING[50];
  // REFERENCIA_COMERCIAL2: STRING[50];
  // REFERENCIA_COMERCIAL3: STRING[50];
  // REFERENCIA_COMERCIAL4: STRING[50];
  // TRAB_PROFISSAO: STRING[30];
  // TRAB_LOCAL: STRING[30];
  // TRAB_COD_FUNC: STRING[10];
  // TRAB_CARGO: STRING[200];
  TRAB_RENDA := -99999;
  // CONJ_ESTADO_CIVIL: STRING[20];
  // CONJ_NOME: STRING[30];
  CONJ_RENDA := -99999;
  // CONJ_CPF: STRING[11];
  // CONJ_PROFISSAO: STRING[30];
  // CONJ_REGIME: STRING[30];
  // CONJ_TRABALHO: STRING[50];
  // CONJ_RG: STRING[14];
  CHAVE_OLD           := -99999;
  COD_TABELA          := -99999;
  COD_PLANO_PAGAMENTO := -99999;
  DIA_VENCIMENTO      := -99999;
  // SITUACAO: STRING[4];
  BLOQUEADO          := -99999;
  FLAG_ECF_RESTRICAO := -99999;
  FLAG_RETENCAO_ISS  := -99999;
  COD_TRANSPORTADORA := -99999;
  DIA_FECHAMENTO     := -99999;
  // DEMONSTRATIVO_BOLETO: STRING;
  FLAG_ATIVO         := 1;
  OBS_INATIVO        := '';
end;

{ FORNECEDORES }

procedure TFORNECEDORES.Create;
begin
  COD_FORNECEDOR := -99999;
  CHAVE_OLD      := -99999;
  FLAG_ATIVO     := 1;
  OBS_INATIVO    := '';
end;

{ TTRANSPORTADORAS }

procedure TTRANSPORTADORAS.Create;
begin
  COD_TRANSPORTADORA := -99999;
  CHAVE_OLD          := -99999;
  FLAG_ATIVO         := 1;
  OBS_INATIVO        := '';
end;
{$ENDREGION}
{$ENDREGION}
{$REGION 'TDM'}

function TDM.isNull(Valor: Variant; Res: Variant; Data: boolean = False): Variant;
var
  Tipo: Word;
begin
  try
    if Data then
    begin

      if Valor < StrToDate('01/01/1900') then
        Result := Res
      else
        Result := Valor;
      Exit;
    end;
    Tipo := VarType(Valor);
    case VarType(Valor) of
      varInteger:
        begin
          if Valor = (-99999) then
            Result := Res
          else
            Result := Valor;
        end;
      varDouble:
        begin
          if Valor = (-99999) then
            Result := Res
          else
            Result := Valor;
        end;
      varUString:
        begin
          if Trim(Valor) = '' then
            Result := Res
          else
            Result := Valor;
        end;
      varFDAString:
        begin
          if Trim(Valor) = '' then
            Result := Res
          else
            Result := Valor;
        end;
    else
      begin
        if (VarType(Valor) in [varEmpty, varNull]) then
          Result := Res
        else
          Result := Valor;
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TDM.ConectaCEP(DataCEP: String; Port: String = '3060'; Server: String = 'LocalHost'; User: String = 'SYSDBA'; Pass: String = 'lib1503');
begin
  try
    if (Trim(DataCEP) = '') or (not FileExists(DataCEP)) then
      DataCEP := ExtractFilePath(Application.ExeName) + 'DataCEP.FDB';
    if not FileExists(DataCEP) then
      DataCEP := 'C:\Gigatron\BaseCEP\DataCep.FDB';
    if not FileExists(DataCEP) then
      raise Exception.Create('Banco de dados DataCEP não localizado no diretório da aplicação.' + #13 + DataCEP);
    ConexaoDataCEP.Close;
    ConexaoDataCEP.Params.Values['Database']  := DataCEP;
    ConexaoDataCEP.Params.Values['Port']      := Port;
    ConexaoDataCEP.Params.Values['Server']    := Server;
    ConexaoDataCEP.Params.Values['User_Name'] := User;
    ConexaoDataCEP.Params.Values['Password']  := Pass;
    ConexaoDataCEP.Open();
  except
    on E: Exception do
      raise Exception.Create('TDM.ConectaCEP' + #13 + E.Message);
  end;
end;

procedure TDM.ConnectaGigaERP;
begin
  try
    ConexaoGigaERP.Close;
    ConexaoGigaERP.Params.Values['Database']  := Base;
    ConexaoGigaERP.Params.Values['Port']      := Port;
    ConexaoGigaERP.Params.Values['Server']    := Server;
    ConexaoGigaERP.Params.Values['User_Name'] := User;
    ConexaoGigaERP.Params.Values['Password']  := Password;
    ConexaoGigaERP.Open();
  except
    on E: Exception do
      raise Exception.Create('TDM.ConnectGigaERP' + #13 + E.Message);
  end;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  ConexaoGigaERP.Connected := False;
end;

procedure TDM.FechaConexoes;
begin
  ConexaoGigaERP.Close;
  conexaoOrigem.Close;
  conexaoDestino.Close;
  conexaoSisco.Close;
  ConexaoDataCEP.Close;
  conexaoConfig.Close;
end;

function TDM.GeraCod(Gen: String): Integer;
begin
  try
    qr_GEN_ID.Close;
    qr_GEN_ID.Open('SELECT GEN_ID(' + Gen + ',1) COD FROM RDB$DATABASE');
    Result := qr_GEN_ID.FieldByName('COD').AsInteger;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TDM.qrASSOCAfterOpen(DataSet: TDataSet);
begin
  QR_Config.Open('SELECT (MAX(COD_ASSOCIA)+1) COD_ASSOCIA FROM ASSOCIAR WHERE COD_PERFIL = ' + qrPERFILCOD_PERFIL.AsString);
  Cod_Assoc := QR_Config.FieldByName('COD_ASSOCIA').AsInteger;
end;

procedure TDM.qrASSOCBeforePost(DataSet: TDataSet);
begin
  if qrASSOCCOD_PERFIL.isNull then
    qrASSOCCOD_PERFIL.AsInteger := qrPERFILCOD_PERFIL.AsInteger;
  if qrASSOCCOD_ASSOCIA.isNull then
  begin
    Inc(Cod_Assoc);
    qrASSOCCOD_ASSOCIA.AsInteger := Cod_Assoc;
  end;
end;

procedure TDM.qrPESSOASReconcileError(DataSet: TFDDataSet; E: EFDException; UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);
begin
  Action := TFDDAptReconcileAction(raSkip);
  Raise Exception.Create(E.Message + #13 + DataSet.Name);
end;

procedure TDM.qrPESSOAS_CONTATOSReconcileError(DataSet: TFDDataSet; E: EFDException; UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);
begin
  Action := TFDDAptReconcileAction(raSkip);
  Raise Exception.Create(E.Message + #13 + 'COD_PESSOA: ' + DataSet.FieldByName('COD_PESSOA').AsString);
end;

procedure TDM.qrPRODUTOSReconcileError(DataSet: TFDDataSet;
  E: EFDException; UpdateKind: TFDDatSRowState;
  var Action: TFDDAptReconcileAction);
begin
  Action := TFDDAptReconcileAction(raSkip);
  Raise Exception.Create('COD_PRODUTO:'+DataSet.FieldByName('COD_PRODUTO').AsString+#13+E.Message + #13 + DataSet.Name);

end;

procedure TDM.qrPRODUTOSUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
begin
  raise Exception.Create('COD_PRODUTO:'+ARow.Value['COD_PRODUTO']+#13+
                          AException.Message);
end;

procedure TDM.qrPRODUTOS_GRADE_UNDUpdateError(ASender: TDataSet;
  AException: EFDException; ARow: TFDDatSRow; ARequest: TFDUpdateRequest;
  var AAction: TFDErrorAction);
begin
  raise Exception.Create('['+ASender.Name+']'+#13+
                         'COD_PRODUTO:'+ARow.Value['COD_PRODUTO']+#13+
                         'COD_GRADE:'+ARow.Value['COD_GRADE']+#13+
                         'UNIDADE:'+ARow.Value['UNIDADE']+#13+
                          AException.Message);

end;

{$ENDREGION}
{$REGION 'TCadastro_Produtos'}

{ TProdutos }
procedure TCadastro_Produtos.AppendOrEdit;
var
  I  : Integer;
  Cod: Integer;
begin
  try
    with DM do
    begin
      ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_LOGAR(''ADMIN'');');
      COD_PRODUTO := StrZeros(PRODUTOS.COD_PRODUTO, 13);
      if qrPRODUTOS.Locate('COD_PRODUTO', COD_PRODUTO, []) then
        qrPRODUTOS.Edit
      else
        qrPRODUTOS.Append;
      PRODUTOS_VALORES;
      qrPRODUTOS.Post;

      { PRODUTOS_GRADE }
      PRODUTOS_GRADE.COD_PRODUTO := PRODUTOS.COD_PRODUTO;
      if qrPRODUTOS_GRADE.Locate('COD_PRODUTO;COD_GRADE', VarArrayOf([PRODUTOS_GRADE.COD_PRODUTO, Trim(PRODUTOS_GRADE.COD_GRADE)]), []) then
        qrPRODUTOS_GRADE.Edit
      else
        qrPRODUTOS_GRADE.Append;
      PRODUTOS_GRADE_VALORES;
      qrPRODUTOS_GRADE.Post;
      Inc(I);

      { FORNECIMENTOS }
      if (PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR > 0) OR (PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR_OLD > 0) then
      begin
        qrFORNECIMENTOS.Append;
        PRODUTOS_FORNECIMENTOS_VALORES;
        qrFORNECIMENTOS.Post;
      end;

      { UNIDADE DE MEDIDAS }
      I := 1;
      while (PRODUTOS_GRADE_UND[I].T = (-99999)) do
      begin
        PRODUTOS_GRADE_UND[I].COD_PRODUTO := PRODUTOS.COD_PRODUTO;
        if qrPRODUTOS_GRADE_UND.Locate('COD_PRODUTO;COD_GRADE;UNIDADE', VarArrayOf([COD_PRODUTO, COD_GRADE, PRODUTOS_GRADE_UND[I].UNIDADE]), []) then
          qrPRODUTOS_GRADE_UND.Edit
        else
          qrPRODUTOS_GRADE_UND.Append;
        PRODUTOS_GRADE_UND_VALORES(I);
        qrPRODUTOS_GRADE_UND.Post;
        Inc(I);
      end;

      I := 1;
      while (PRODUTOS_TABELA[I].COD_TABELA_ITEM > 0) or (Trim(PRODUTOS_TABELA[I].TABELA_ITEM_DESC) <> '') do
      begin
        PRODUTOS_TABELA[I].COD_PRODUTO := PRODUTOS.COD_PRODUTO;
        if qrPRODUTOS_TABELA.Locate('COD_PRODUTO;COD_TABELA;COD_TABELA_ITEM', VarArrayOf([PRODUTOS_TABELA[I].COD_PRODUTO, I, PRODUTOS_TABELA[I].COD_TABELA_ITEM]), []) then
          qrPRODUTOS_TABELA.Edit
        else
          qrPRODUTOS_TABELA.Append;
        PRODUTOS_TABELA_VALORES(I);
        qrPRODUTOS_TABELA.Post;
        Inc(I);
      end;

      { TABELAS TEMPORÁRIAS }
      { APELIDOS }
      I := 2;
      // O I é o codigo do apelido;
      while (PRODUTOS_APELIDOS_PROD[I].T = (-99999)) do
      begin
        TempPRODUTOS_APELIDOS_PROD.Append;
        PRODUTOS_APELIDOS_PROD_VALORES(I);
        TempPRODUTOS_APELIDOS_PROD.Post;
        Inc(I);
      end;
      { CUSTO }
      I := 1;
      while (PRODUTOS_CUSTO[I].T = (-99999)) do
      begin
        PRODUTOS_CUSTO[I].COD_PRODUTO := PRODUTOS.COD_PRODUTO;
        TempPRODUTOS_CUSTO.Append;
        PRODUTOS_CUSTO_VALORES(I);
        TempPRODUTOS_CUSTO.Post;
        Inc(I);
      end;
      { PRECOS }
      I := 1;
      while I < 5 do
      begin
        if (PRODUTOS_TAB_PRECOS_PROD[I].PRECO > 0) or (I < 3) then
        begin
          if (I = 2) and (PRODUTOS_TAB_PRECOS_PROD[2].PRECO = 0) then
            PRODUTOS_TAB_PRECOS_PROD[2].PRECO := PRODUTOS_TAB_PRECOS_PROD[1].PRECO;

          TempPRODUTOS_TAB_PRECOS_PROD.Append;
          PRODUTOS_TAB_PRECOS_PROD_VALORES(I);
          TempPRODUTOS_TAB_PRECOS_PROD.Post;
        end;
        Inc(I);
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.AppendOrEditGRADES;
var
  I: Integer;
begin
  with DM do
  begin
    { PRODUTOS_GRADE }
    PRODUTOS_GRADE.COD_PRODUTO := PRODUTOS.COD_PRODUTO;
    if qrPRODUTOS_GRADE.Locate('COD_PRODUTO;COD_GRADE', VarArrayOf([PRODUTOS_GRADE.COD_PRODUTO, PRODUTOS_GRADE.COD_GRADE]), []) then
      qrPRODUTOS_GRADE.Edit
    else
      qrPRODUTOS_GRADE.Append;
    PRODUTOS_GRADE_VALORES;
    qrPRODUTOS_GRADE.Post;

    I := 1;
    while (PRODUTOS_GRADE_UND[I].T = (-99999)) do
    begin
      PRODUTOS_GRADE_UND[I].COD_PRODUTO := PRODUTOS.COD_PRODUTO;
      if qrPRODUTOS_GRADE_UND.Locate('COD_PRODUTO;COD_GRADE;UNIDADE', VarArrayOf([COD_PRODUTO, COD_GRADE, PRODUTOS_GRADE_UND[I].UNIDADE]), []) then
        qrPRODUTOS_GRADE_UND.Edit
      else
        qrPRODUTOS_GRADE_UND.Append;
      PRODUTOS_GRADE_UND_VALORES(I);
      qrPRODUTOS_GRADE_UND.Post;
      Inc(I);
    end;

    { TABELAS TEMPORÁRIAS }
    { APELIDOS }
    I := 2;
    // O I é o codigo do apelido;
    while (PRODUTOS_APELIDOS_PROD[I].T = (-99999)) do
    begin
      TempPRODUTOS_APELIDOS_PROD.Append;
      PRODUTOS_APELIDOS_PROD_VALORES(I);
      TempPRODUTOS_APELIDOS_PROD.Post;
      Inc(I);
    end;
    { CUSTO }
    I := 1;
    while (PRODUTOS_CUSTO[I].T = (-99999)) do
    begin
      PRODUTOS_CUSTO[I].COD_PRODUTO := PRODUTOS.COD_PRODUTO;
      TempPRODUTOS_CUSTO.Append;
      PRODUTOS_CUSTO_VALORES(I);
      TempPRODUTOS_CUSTO.Post;
      Inc(I);
    end;
    { PRECOS }
    I := 1;
    while (PRODUTOS_TAB_PRECOS_PROD[I].T = (-99999)) do
    begin
      TempPRODUTOS_TAB_PRECOS_PROD.Append;
      PRODUTOS_TAB_PRECOS_PROD_VALORES(I);
      TempPRODUTOS_TAB_PRECOS_PROD.Post;
      Inc(I);
    end;
  end;
end;

procedure TCadastro_Produtos.AppendOrEditPRODUTOS;
var
  I: Integer;
begin
  with DM do
  begin
    ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_LOGAR(''ADMIN'');');
    COD_PRODUTO := StrZeros(PRODUTOS.COD_PRODUTO, 13);
    if qrPRODUTOS.Locate('COD_PRODUTO', COD_PRODUTO, []) then
      qrPRODUTOS.Edit
    else
      qrPRODUTOS.Append;
    PRODUTOS_VALORES;
    qrPRODUTOS.Post;

    I := 1;
    while (PRODUTOS_TABELA[I].COD_TABELA_ITEM > 0) or (Trim(PRODUTOS_TABELA[I].TABELA_ITEM_DESC) <> '') do
    begin
      PRODUTOS_TABELA[I].COD_PRODUTO := PRODUTOS.COD_PRODUTO;
      if qrPRODUTOS_TABELA.Locate('COD_PRODUTO;COD_TABELA;COD_TABELA_ITEM', VarArrayOf([PRODUTOS_TABELA[I].COD_PRODUTO, I, PRODUTOS_TABELA[I].COD_TABELA_ITEM]), []) then
        qrPRODUTOS_TABELA.Edit
      else
        qrPRODUTOS_TABELA.Append;
      PRODUTOS_TABELA_VALORES(I);
      qrPRODUTOS_TABELA.Post;
      Inc(I);
    end;
  end;
end;

procedure TCadastro_Produtos.ApplyUpdates;
begin
  try
    // DM.ConexaoGigaERP.ExecSQL('ALTER TRIGGER PRODUTOS_GRADE_AI0 INACTIVE;');
    try
      if DM.qrPRODUTOS.ApplyUpdates(0) = 0 then
        if DM.qrPRODUTOS_GRADE.ApplyUpdates(0) = 0 then
          if DM.qrFORNECIMENTOS.ApplyUpdates(0) = 0 then
            if DM.qrPRODUTOS_TABELA.ApplyUpdates(0) = 0 then
              if DM.qrPRODUTOS_GRADE_UND.ApplyUpdates(0) = 0 then
                if PRODUTOS_CUSTO_APLICA = 0 then
                  if PRODUTOS_APELIDOS_PROD_APLICA = 0 then
                    PRODUTOS_TAB_PRECOS_PROD_APLICA;
      MANUTENCAO_ESTOQUE;
      DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
    finally
      // DM.ConexaoGigaERP.ExecSQL('ALTER TRIGGER PRODUTOS_GRADE_AI0 ACTIVE;');
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.CadastraRelacionamento(COD_RELAC: Integer; DESC_RELAC: String);
begin
  DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA(COD_TABELA,DESCRICAO)' + 'VALUES(' + IntToStr(COD_RELAC) + ',''' + DESC_RELAC + ''')' + 'MATCHING(COD_TABELA)');
end;

procedure TCadastro_Produtos.Cadastra_Grupo_Padrão;
begin
  try
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO GRUPOS_PRODUTO (COD_GRUPO, DESC_GRUPO, PERC_MARGEM) ' + 'VALUES (1, ''GERAL'', 0) ' + 'MATCHING (COD_GRUPO);');
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.Cadastra_imposto_padrao(COD_IMPOSTO: String = '1'; DESC_IMPOSTO: String = 'TRIBUTADO');
begin
  try
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO IMPOSTOS (COD_IMPOSTO, DESC_IMPOSTO, FLAG_SERVICO) ' + 'VALUES (' + COD_IMPOSTO + ', ''' + DESC_IMPOSTO + ''', 0) ' + 'MATCHING (COD_IMPOSTO);');
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.Cadastra_NCM_99;
begin
  try
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO CLASS_FISCAIS (COD_CLASS, DESC_CLASS, FLAG_ATIVO) VALUES(''99'', ''OUTROS (CADASTRADO NA IMPORTAÇÃO)'', 1) MATCHING(COD_CLASS);');
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TCadastro_Produtos.Coalesce(Valor, Resp: String): String;
begin
  try
    if Trim(Valor) = '' then
      Result := Resp
    else
      Result := Valor;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.ConfereNCM(NCM: String);
begin
  NCM := Trim(NCM);
  if not(DM.qrCLASS_FISCAIS.Locate('COD_CLASS', NCM, [])) then
  begin
    DM.qrCLASS_FISCAIS.Append;
    DM.qrCLASS_FISCAIS.FieldByName('COD_CLASS').AsString   := NCM;
    DM.qrCLASS_FISCAIS.FieldByName('DESC_CLASS').AsString  := '***** CADASTRADO NA IMPORTAÇÃO DE DADOS ****** ';
    DM.qrCLASS_FISCAIS.FieldByName('FLAG_ATIVO').AsInteger := 1;
    DM.qrCLASS_FISCAIS.FieldByName('FLAG_PREVIDENCIA').AsInteger := 0;
    DM.qrCLASS_FISCAIS.FieldByName('ALIQ_PREVIDENCIA').AsFloat := 0.00;
    DM.qrCLASS_FISCAIS.Post;
    DM.qrCLASS_FISCAIS.ApplyUpdates();
    DM.qrCLASS_FISCAIS.Close;
    DM.qrCLASS_FISCAIS.Open;
  end;
end;

procedure TCadastro_Produtos.ConfereUND(UND: String);
begin
  try
    UND := Trim(UND);
    if (not(DM.qrUNIDADES_MEDIDA.Locate('UNIDADE', UND, []))) and (UND <> '') then
    begin
      DM.qrUNIDADES_MEDIDA.Append;
      DM.qrUNIDADES_MEDIDA.FieldByName('UNIDADE').AsString := UND;
      DM.qrUNIDADES_MEDIDA.FieldByName('DESC_UNIDADE').AsString := UND;
      DM.qrUNIDADES_MEDIDA.FieldByName('FATOR_CONVERSAO').AsInteger := 1;
      DM.qrUNIDADES_MEDIDA.Post;
      DM.qrUNIDADES_MEDIDA.ApplyUpdates();
      DM.qrUNIDADES_MEDIDA.Close;
      DM.qrUNIDADES_MEDIDA.Open;
    end;
  except
    on E: Exception do
      raise Exception.Create('ConfereUND(' + UND + ')' + #13 + E.Message);
  end;
end;

constructor TCadastro_Produtos.Create;
begin
  COD_EMPRESA := 1;
  PRODUTOS.IniciarVariaveis;
  PRODUTOS_FORNECIMENTOS.IniciarVariaveis;
  PRODUTOS_GRADE.IniciarVariaveis;
  PRODUTOS_APELIDOS_PROD[1].IniciarVariaveis;
  PRODUTOS_APELIDOS_PROD[2].IniciarVariaveis;
  PRODUTOS_APELIDOS_PROD[3].IniciarVariaveis;
  PRODUTOS_CUSTO[1].IniciarVariaveis;
  PRODUTOS_GRADE_UND[1].IniciarVariaveis;
  PRODUTOS_TABELA[1].IniciarVariaveis;
  PRODUTOS_TAB_PRECOS_PROD[1].IniciarVariaveis;
  PRODUTOS_TAB_PRECOS_PROD[2].IniciarVariaveis;
  try
    DM.TempPRODUTOS_APELIDOS_PROD.Open;
    DM.TempPRODUTOS_CUSTO.Open;
    DM.TempPRODUTOS_TAB_PRECOS_PROD.Open;
    DM.TempManutencaoEstoque.Open;
  except
    DM.TempPRODUTOS_APELIDOS_PROD.CreateDataSet;
    DM.TempPRODUTOS_CUSTO.CreateDataSet;
    DM.TempPRODUTOS_TAB_PRECOS_PROD.CreateDataSet;
    DM.TempManutencaoEstoque.CreateDataSet;
  end;
end;

procedure TCadastro_Produtos.MANUTENCAO_ESTOQUE;
var
  Cod: String;
begin
  { PARA USAR A ENTRADA DE ESTOQUE BASTA ADICIONAR A QTD DE ESTOQUE NA VARIAVEL QTD_ESTOQUE
    QUE CONSTA NA CLASSE PRODUTOS_GRADE }
  Sleep(1);
  if not ESTOQUE then
    Exit;
  with DM do
  begin
    QR_GigaERP.Open('SELECT GEN_ID(SMANUTENCOES_ESTOQUES,1) COD FROM RDB$DATABASE');
    Cod := QR_GigaERP.FieldByName('COD').AsString;
    ConexaoGigaERP.ExecSQL('   INSERT INTO MANUTENCOES_ESTOQUES (COD_EMPRESA, COD_MANUTENCAO, DATA_MANUTENCAO, HORA, ' +
      '                                   TIPO_MANUTENCAO, LOGIN, OBS, TIPO_ESTOQUE) ' + ' VALUES ('+IntToStr(COD_EMPRESA)+', ' + Cod +
      ', CURRENT_DATE, CURRENT_TIMESTAMP, 0, ''ADMIN'', ''AJUSTE DO ESTOQUE FISICO (IMPORTAÇÃO DE DADOS)'', 0);');
    TempManutencaoEstoque.First;
    qrMANUTENCOES_ESTOQUES_ITENS.Open();
    while not TempManutencaoEstoque.Eof do
    begin
      if not qrMANUTENCOES_ESTOQUES_ITENS.Locate('COD_EMPRESA;COD_MANUTENCAO;COD_PRODUTO;COD_GRADE',
        VarArrayOf([COD_EMPRESA, Cod, TempManutencaoEstoqueCOD_PRODUTO.AsString, TempManutencaoEstoqueCOD_GRADE.AsString])) then
      begin
        qrMANUTENCOES_ESTOQUES_ITENS.Append;
        qrMANUTENCOES_ESTOQUES_ITENSCOD_EMPRESA.AsInteger := COD_EMPRESA;
        qrMANUTENCOES_ESTOQUES_ITENSCOD_MANUTENCAO.AsString := Cod;
        qrMANUTENCOES_ESTOQUES_ITENSCOD_PRODUTO.AsString  := TempManutencaoEstoqueCOD_PRODUTO.AsString;
        qrMANUTENCOES_ESTOQUES_ITENSCOD_GRADE.AsString    := TempManutencaoEstoqueCOD_GRADE.AsString;
        qrMANUTENCOES_ESTOQUES_ITENSUNIDADE.AsString      := TempManutencaoEstoqueUNIDADE.AsString;
        qrMANUTENCOES_ESTOQUES_ITENSQTD_ESTOQUE.AsInteger := 0;
        qrMANUTENCOES_ESTOQUES_ITENSQTD_DIGITADA.AsString := TempManutencaoEstoqueQTD.AsString;
        qrMANUTENCOES_ESTOQUES_ITENSFLAG_ZERAR_QTD.AsInteger := 0;
        qrMANUTENCOES_ESTOQUES_ITENSQTD_ESTOQUE_DESTINO.AsInteger := 0;
        qrMANUTENCOES_ESTOQUES_ITENS.Post;
      end;
      TempManutencaoEstoque.Next;
    end;
    qrMANUTENCOES_ESTOQUES_ITENS.ApplyUpdates();
    QR_GigaERP.ExecSQL('EXECUTE PROCEDURE PR_ESTQ_FINALIZAR_MANUTENCAO(1,' + Cod + ');');
  end;
end;

procedure TCadastro_Produtos.Open;
begin
  try
    DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
    DM.qrPRODUTOS.Close;
    DM.qrPRODUTOS_GRADE.Close;
    DM.qrFORNECIMENTOS.Close;
    DM.qrFORNECEDORES.Close;
    DM.qrPRODUTOS_APELIDOS_PROD.Close;
    DM.qrPRODUTOS_CUSTO.Close;
    DM.qrPRODUTOS_GRADE_UND.Close;
    DM.qrPRODUTOS_TABELA.Close;
    DM.qrPRODUTOS_TAB_PRECOS_PROD.Close;
    DM.qrUNIDADES_MEDIDA.Close;
    DM.qrCLASS_FISCAIS.Close;

    DM.qrPRODUTOS.Open();
    DM.qrPRODUTOS_GRADE.Open();
    DM.qrFORNECIMENTOS.Open();
    DM.qrFORNECEDORES.Open();
    DM.qrPRODUTOS_APELIDOS_PROD.Open();
    DM.qrPRODUTOS_CUSTO.Open();
    DM.qrPRODUTOS_GRADE_UND.Open();
    DM.qrPRODUTOS_TABELA.Open();
    DM.qrPRODUTOS_TAB_PRECOS_PROD.Open();
    DM.qrUNIDADES_MEDIDA.Open();
    DM.qrCLASS_FISCAIS.Open();
    DM.TempPRODUTOS_APELIDOS_PROD.Open();
    DM.TempPRODUTOS_CUSTO.Open();
    DM.TempPRODUTOS_TAB_PRECOS_PROD.Open();

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TCadastro_Produtos.PRODUTOS_APELIDOS_PROD_APLICA: Integer;
var
  COD_APELIDO: Integer;
  SQL        : String;
begin
  Result := 1;
  try
    with DM do
    begin
      // qrPRODUTOS_APELIDOS_PROD.Close;
      // qrPRODUTOS_APELIDOS_PROD.Open;
      TempPRODUTOS_APELIDOS_PROD.First;
      while not TempPRODUTOS_APELIDOS_PROD.Eof do
      begin
        COD_APELIDO := TempPRODUTOS_APELIDOS_PROD.FieldByName('COD_APELIDO').Value;
        COD_PRODUTO := TempPRODUTOS_APELIDOS_PROD.FieldByName('COD_PRODUTO').Value;
        COD_GRADE   := TempPRODUTOS_APELIDOS_PROD.FieldByName('COD_GRADE').Value;

        qrPRODUTOS_APELIDOS_PROD.Close;
        SQL := 'SELECT * FROM PRODUTOS_APELIDOS_PROD WHERE COD_APELIDO = ' + IntToStr(COD_APELIDO) + ' AND COD_PRODUTO = ''' + COD_PRODUTO + ''' AND COD_GRADE = ''' + COD_GRADE + '''';
        qrPRODUTOS_APELIDOS_PROD.Open(SQL);

        if qrPRODUTOS_APELIDOS_PROD.IsEmpty then
          raise Exception.Create('Apelido não localizado' + #13 + SQL);

        // if not qrPRODUTOS_APELIDOS_PROD.Locate('COD_APELIDO;COD_PRODUTO;COD_GRADE',VarArrayOf([COD_APELIDO,COD_PRODUTO,COD_GRADE]),[]) then
        // raise Exception.Create('Apelido não localizado: '+IntToStr(COD_APELIDO)+'/'+COD_PRODUTO+'/'+COD_GRADE);
        qrPRODUTOS_APELIDOS_PROD.Edit;
        qrPRODUTOS_APELIDOS_PROD.FieldByName('COD_APELIDO').Value := COD_APELIDO;
        qrPRODUTOS_APELIDOS_PROD.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
        qrPRODUTOS_APELIDOS_PROD.FieldByName('COD_GRADE').Value := COD_GRADE;
        qrPRODUTOS_APELIDOS_PROD.FieldByName('APELIDO').Value := TempPRODUTOS_APELIDOS_PROD.FieldByName('APELIDO').Value;
        qrPRODUTOS_APELIDOS_PROD.Post;
        TempPRODUTOS_APELIDOS_PROD.Next;
        qrPRODUTOS_APELIDOS_PROD.ApplyUpdates();
      end;
    end;
    Result := 0;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.PRODUTOS_APELIDOS_PROD_VALORES(I: Integer);
begin
  try
    with DM do
    begin
      if PRODUTOS_APELIDOS_PROD[I].T > (-99999) then
        raise Exception.Create('[PRODUTOS_APELIDOS_PROD_VALORES]' + #13 + 'As variaveis devem ser iniciadas');
      TempPRODUTOS_APELIDOS_PROD.FieldByName('COD_APELIDO').Value := isNull(PRODUTOS_APELIDOS_PROD[I].COD_APELIDO, I);;
      TempPRODUTOS_APELIDOS_PROD.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
      TempPRODUTOS_APELIDOS_PROD.FieldByName('COD_GRADE').Value := COD_GRADE;
      TempPRODUTOS_APELIDOS_PROD.FieldByName('APELIDO').Value := isNull(PRODUTOS_APELIDOS_PROD[I].APELIDO, '');
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TCadastro_Produtos.PRODUTOS_CUSTO_APLICA: Integer;
Var
  SQL: string;
begin
  Result := 1;
  try
    with DM do
    begin
      // qrPRODUTOS_CUSTO.Close;
      // qrPRODUTOS_CUSTO.Open;
      TempPRODUTOS_CUSTO.First;
      while not TempPRODUTOS_CUSTO.Eof do
      begin
        //COD_EMPRESA := TempPRODUTOS_CUSTO.FieldByName('COD_EMPRESA').Value;
        COD_PRODUTO := TempPRODUTOS_CUSTO.FieldByName('COD_PRODUTO').Value;
        COD_GRADE   := Trim(TempPRODUTOS_CUSTO.FieldByName('COD_GRADE').Value);

        qrPRODUTOS_CUSTO.Close;
        SQL := 'SELECT * FROM PRODUTOS_CUSTO WHERE COD_EMPRESA = ' + IntToStr(COD_EMPRESA) + ' AND COD_PRODUTO = ''' + COD_PRODUTO + ''' AND COD_GRADE = ''' + COD_GRADE + '''';
        qrPRODUTOS_CUSTO.Open(SQL);

        if qrPRODUTOS_CUSTO.RecordCount = 0 then
          raise Exception.Create('Custo não localizado' + #13 + SQL);

        // if not qrPRODUTOS_CUSTO.Locate('COD_EMPRESA;COD_PRODUTO;COD_GRADE',VarArrayOf([COD_EMPRESA,COD_PRODUTO,COD_GRADE]),[]) then
        // MessageRaul_ERRO('Custo não localizado: '+IntToStr(COD_EMPRESA)+'/'+COD_PRODUTO+'/'+COD_GRADE+' ');
        // raise Exception.Create('Custo não localizado: '+IntToStr(COD_EMPRESA)+'/'+COD_PRODUTO+'/'+COD_GRADE+' ');

        qrPRODUTOS_CUSTO.Edit;
        qrPRODUTOS_CUSTO.FieldByName('COD_EMPRESA').Value := COD_EMPRESA;
        qrPRODUTOS_CUSTO.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
        qrPRODUTOS_CUSTO.FieldByName('COD_GRADE').Value   := COD_GRADE;
        qrPRODUTOS_CUSTO.FieldByName('PRECO_CUSTO').Value := TempPRODUTOS_CUSTO.FieldByName('PRECO_CUSTO').Value;
        qrPRODUTOS_CUSTO.FieldByName('VR_OUTRAS_DESPESAS').Value := TempPRODUTOS_CUSTO.FieldByName('VR_OUTRAS_DESPESAS').Value;
        qrPRODUTOS_CUSTO.FieldByName('ICMS_ALIQ').Value    := TempPRODUTOS_CUSTO.FieldByName('ICMS_ALIQ').Value;
        qrPRODUTOS_CUSTO.FieldByName('IPI_ALIQ').Value     := TempPRODUTOS_CUSTO.FieldByName('IPI_ALIQ').Value;
        qrPRODUTOS_CUSTO.FieldByName('ST_IVA').Value       := TempPRODUTOS_CUSTO.FieldByName('ST_IVA').Value;
        qrPRODUTOS_CUSTO.FieldByName('ST_ICMS_ALIQ').Value := TempPRODUTOS_CUSTO.FieldByName('ST_ICMS_ALIQ').Value;
        qrPRODUTOS_CUSTO.FieldByName('PRECO_CUSTO_REAL').Value := TempPRODUTOS_CUSTO.FieldByName('PRECO_CUSTO_REAL').Value;
        qrPRODUTOS_CUSTO.FieldByName('DATA_ULTIMO_REAJUSTE').Value := TempPRODUTOS_CUSTO.FieldByName('DATA_ULTIMO_REAJUSTE').Value;
        qrPRODUTOS_CUSTO.FieldByName('VR_FRETE').Value := TempPRODUTOS_CUSTO.FieldByName('VR_FRETE').Value;
        qrPRODUTOS_CUSTO.FieldByName('VR_SEGURO').Value := TempPRODUTOS_CUSTO.FieldByName('VR_SEGURO').Value;
        qrPRODUTOS_CUSTO.FieldByName('VR_DESC_CUSTO').Value := TempPRODUTOS_CUSTO.FieldByName('VR_DESC_CUSTO').Value;
        qrPRODUTOS_CUSTO.FieldByName('ICMS_RED_BASE').Value := TempPRODUTOS_CUSTO.FieldByName('ICMS_RED_BASE').Value;
        qrPRODUTOS_CUSTO.FieldByName('ST_ICMS_RED_BASE').Value := TempPRODUTOS_CUSTO.FieldByName('ST_ICMS_RED_BASE').Value;
        qrPRODUTOS_CUSTO.FieldByName('PIS_ALIQ').Value    := TempPRODUTOS_CUSTO.FieldByName('PIS_ALIQ').Value;
        qrPRODUTOS_CUSTO.FieldByName('COFINS_ALIQ').Value := TempPRODUTOS_CUSTO.FieldByName('COFINS_ALIQ').Value;
        qrPRODUTOS_CUSTO.FieldByName('IPI_TIPO_ALIQUOTA').Value := TempPRODUTOS_CUSTO.FieldByName('IPI_TIPO_ALIQUOTA').Value;
        qrPRODUTOS_CUSTO.FieldByName('PIS_TIPO_ALIQUOTA').Value := TempPRODUTOS_CUSTO.FieldByName('PIS_TIPO_ALIQUOTA').Value;
        qrPRODUTOS_CUSTO.FieldByName('COFINS_TIPO_ALIQUOTA').Value := TempPRODUTOS_CUSTO.FieldByName('COFINS_TIPO_ALIQUOTA').Value;
        qrPRODUTOS_CUSTO.FieldByName('ST_ICMS_VR_PAUTA').Value := TempPRODUTOS_CUSTO.FieldByName('ST_ICMS_VR_PAUTA').Value;
        qrPRODUTOS_CUSTO.Post;
        qrPRODUTOS_CUSTO.ApplyUpdates;
        TempPRODUTOS_CUSTO.Next;
      end;
    end;
    Result := 0;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.PRODUTOS_CUSTO_VALORES(I: Integer);
begin
  try
    with DM do
    begin
      if PRODUTOS_CUSTO[I].T > (-99999) then
        raise Exception.Create('[PRODUTOS_CUSTO_VALORES]' + #13 + 'As variaveis devem ser iniciadas');
      TempPRODUTOS_CUSTO.FieldByName('COD_EMPRESA').Value := COD_EMPRESA;
      TempPRODUTOS_CUSTO.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
      TempPRODUTOS_CUSTO.FieldByName('COD_GRADE').Value   := Trim(COD_GRADE);
      TempPRODUTOS_CUSTO.FieldByName('PRECO_CUSTO').Value := isNull(PRODUTOS_CUSTO[I].PRECO_CUSTO, 0.00);
      TempPRODUTOS_CUSTO.FieldByName('VR_OUTRAS_DESPESAS').Value := isNull(PRODUTOS_CUSTO[I].VR_OUTRAS_DESPESAS, 0);
      TempPRODUTOS_CUSTO.FieldByName('ICMS_ALIQ').Value    := isNull(PRODUTOS_CUSTO[I].ICMS_ALIQ, 0);
      TempPRODUTOS_CUSTO.FieldByName('IPI_ALIQ').Value     := isNull(PRODUTOS_CUSTO[I].IPI_ALIQ, 0);
      TempPRODUTOS_CUSTO.FieldByName('ST_IVA').Value       := isNull(PRODUTOS_CUSTO[I].ST_IVA, 0);
      TempPRODUTOS_CUSTO.FieldByName('ST_ICMS_ALIQ').Value := isNull(PRODUTOS_CUSTO[I].ST_ICMS_ALIQ, 0);
      TempPRODUTOS_CUSTO.FieldByName('PRECO_CUSTO_REAL').Value := isNull(PRODUTOS_CUSTO[I].PRECO_CUSTO_REAL, TempPRODUTOS_CUSTO.FieldByName('PRECO_CUSTO').Value);
      TempPRODUTOS_CUSTO.FieldByName('DATA_ULTIMO_REAJUSTE').Value := isNull(PRODUTOS_CUSTO[I].DATA_ULTIMO_REAJUSTE, 0, True);
      TempPRODUTOS_CUSTO.FieldByName('VR_FRETE').Value := isNull(PRODUTOS_CUSTO[I].VR_FRETE, 0);
      TempPRODUTOS_CUSTO.FieldByName('VR_SEGURO').Value := isNull(PRODUTOS_CUSTO[I].VR_SEGURO, 0);
      TempPRODUTOS_CUSTO.FieldByName('VR_DESC_CUSTO').Value := isNull(PRODUTOS_CUSTO[I].VR_DESC_CUSTO, 0);
      TempPRODUTOS_CUSTO.FieldByName('ICMS_RED_BASE').Value := isNull(PRODUTOS_CUSTO[I].ICMS_RED_BASE, 0);
      TempPRODUTOS_CUSTO.FieldByName('ST_ICMS_RED_BASE').Value := isNull(PRODUTOS_CUSTO[I].ST_ICMS_RED_BASE, 0);
      TempPRODUTOS_CUSTO.FieldByName('PIS_ALIQ').Value    := isNull(PRODUTOS_CUSTO[I].PIS_ALIQ, 0);
      TempPRODUTOS_CUSTO.FieldByName('COFINS_ALIQ').Value := isNull(PRODUTOS_CUSTO[I].COFINS_ALIQ, 0);
      TempPRODUTOS_CUSTO.FieldByName('IPI_TIPO_ALIQUOTA').Value := isNull(PRODUTOS_CUSTO[I].IPI_TIPO_ALIQUOTA, 0);
      TempPRODUTOS_CUSTO.FieldByName('PIS_TIPO_ALIQUOTA').Value := isNull(PRODUTOS_CUSTO[I].PIS_TIPO_ALIQUOTA, 0);
      TempPRODUTOS_CUSTO.FieldByName('COFINS_TIPO_ALIQUOTA').Value := isNull(PRODUTOS_CUSTO[I].COFINS_TIPO_ALIQUOTA, 0);
      TempPRODUTOS_CUSTO.FieldByName('ST_ICMS_VR_PAUTA').Value := isNull(PRODUTOS_CUSTO[I].ST_ICMS_VR_PAUTA, 0);
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.PRODUTOS_FORNECIMENTOS_VALORES;
var
  COD_FORNECIMENTO: Integer;
begin
  with DM do
  begin
    if not qrFORNECEDORES.Locate('COD_FORNECEDOR', PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR) then
      if qrFORNECEDORES.Locate('CHAVE_OLD', PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR_OLD) then
        PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR := qrFORNECEDORES.FieldByName('COD_FORNECEDOR').AsInteger
      else
        raise Exception.Create('Fornecedor não encontrado com o codigo ' + IntToStr(PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR) + ' e nem com a chave_old ' +
          IntToStr(PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR));

    COD_FORNECIMENTO := isNull(PRODUTOS_FORNECIMENTOS.COD_FORNECIMENTO, 0);
    if COD_FORNECIMENTO = 0 then
      COD_FORNECIMENTO                                    := GeraCod('SFORNECIMENTOS');
    qrFORNECIMENTOS.FieldByName('COD_FORNECIMENTO').Value := COD_FORNECIMENTO;
    qrFORNECIMENTOS.FieldByName('COD_EMPRESA').Value      := isNull(PRODUTOS_FORNECIMENTOS.COD_EMPRESA, COD_EMPRESA);
    qrFORNECIMENTOS.FieldByName('COD_FORNECEDOR').Value   := isNull(PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR, Null);
    qrFORNECIMENTOS.FieldByName('COD_PRODUTO_FORNECEDOR').Value := isNull(PRODUTOS_FORNECIMENTOS.COD_PRODUTO_FORNECEDOR, Null);
    qrFORNECIMENTOS.FieldByName('COD_PRODUTO').Value := isNull(PRODUTOS_FORNECIMENTOS.COD_PRODUTO, COD_PRODUTO);
    qrFORNECIMENTOS.FieldByName('COD_GRADE').Value   := isNull(PRODUTOS_FORNECIMENTOS.COD_GRADE, COD_GRADE);
    qrFORNECIMENTOS.FieldByName('COD_PRODUTO_DIGITADO').Value := isNull(PRODUTOS_FORNECIMENTOS.COD_PRODUTO_DIGITADO, Null);
  end;
  PRODUTOS_FORNECIMENTOS.IniciarVariaveis;
end;

procedure TCadastro_Produtos.PRODUTOS_GRADE_UND_VALORES(I: Integer);
begin
  try
    with DM do
    begin
      if UNIDADE <> 'un' then
        ConfereUND(UNIDADE);

      if PRODUTOS_GRADE_UND[I].T > (-99999) then
        raise Exception.Create('[PRODUTOS_GRADE_UND_VALORES]' + #13 + 'As variaveis devem ser iniciadas');
      qrPRODUTOS_GRADE_UND.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
      qrPRODUTOS_GRADE_UND.FieldByName('COD_GRADE').Value := COD_GRADE;
      qrPRODUTOS_GRADE_UND.FieldByName('UNIDADE').Value := UNIDADE;
      qrPRODUTOS_GRADE_UND.FieldByName('ID').Value      := isNull(PRODUTOS_GRADE_UND[I].ID, Null);
      qrPRODUTOS_GRADE_UND.FieldByName('FLAG_PADRAO').Value := isNull(PRODUTOS_GRADE_UND[I].FLAG_PADRAO, 1);
      qrPRODUTOS_GRADE_UND.FieldByName('FLAG_ATIVO').Value := isNull(PRODUTOS_GRADE_UND[I].FLAG_ATIVO, 1);
      qrPRODUTOS_GRADE_UND.FieldByName('FLAG_HABILITA_ENTRADA').Value := isNull(PRODUTOS_GRADE_UND[I].FLAG_HABILITA_ENTRADA, 1);
      qrPRODUTOS_GRADE_UND.FieldByName('FLAG_HABILITA_SAIDA').Value := isNull(PRODUTOS_GRADE_UND[I].FLAG_HABILITA_SAIDA, 1);
      qrPRODUTOS_GRADE_UND.FieldByName('IGN_ALTERADO').Value := isNull(PRODUTOS_GRADE_UND[I].IGN_ALTERADO, Null);
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.PRODUTOS_GRADE_VALORES;
var
  QTD: REAL;
begin
  try
    with DM do
    begin
      if PRODUTOS_GRADE.T > (-99999) then
        raise Exception.Create('[PRODUTOS_GRADE_VALORES]' + #13 + 'As variaveis devem ser iniciadas');
      COD_GRADE                                           := Trim(isNull(PRODUTOS_GRADE.COD_GRADE, '*'));
      qrPRODUTOS_GRADE.FieldByName('COD_PRODUTO').Value   := COD_PRODUTO;
      qrPRODUTOS_GRADE.FieldByName('COD_GRADE').Value     := COD_GRADE;
      qrPRODUTOS_GRADE.FieldByName('ORDEM').Value         := isNull(PRODUTOS_GRADE.ORDEM, 1);
      qrPRODUTOS_GRADE.FieldByName('FLAG_ATIVO').Value    := isNull(PRODUTOS_GRADE.FLAG_ATIVO, 1);
      qrPRODUTOS_GRADE.FieldByName('ESTOQUE_MIN').Value   := isNull(PRODUTOS_GRADE.ESTOQUE_MIN, 0.00);
      qrPRODUTOS_GRADE.FieldByName('ESTOQUE_MAX').Value   := isNull(PRODUTOS_GRADE.ESTOQUE_MAX, 0.00);
      qrPRODUTOS_GRADE.FieldByName('COD_BALANCA').Value   := isNull(PRODUTOS_GRADE.COD_BALANCA, Null);
      qrPRODUTOS_GRADE.FieldByName('DIAS_VALIDADE').Value := isNull(PRODUTOS_GRADE.DIAS_VALIDADE, Null);
      qrPRODUTOS_GRADE.FieldByName('DATA_VALIDADE').Value := isNull(PRODUTOS_GRADE.DATA_VALIDADE, Null, True);
      qrPRODUTOS_GRADE.FieldByName('OBS').Value           := isNull(PRODUTOS_GRADE.OBS, Null);
      qrPRODUTOS_GRADE.FieldByName('ECF_ESTOQUE').Value   := isNull(PRODUTOS_GRADE.ECF_ESTOQUE, Null);
      qrPRODUTOS_GRADE.FieldByName('COD_PRODUTO_ANT').Value := isNull(PRODUTOS_GRADE.COD_PRODUTO_ANT, Null);
      qrPRODUTOS_GRADE.FieldByName('COD_GRADE_ANT').Value := isNull(PRODUTOS_GRADE.COD_GRADE_ANT, Null);
      UNIDADE                                             := isNull(Trim(PRODUTOS_GRADE_UND[1].UNIDADE), 'un');

      QTD     := isNull(PRODUTOS_GRADE.QTD_ESTOQUE, 0);
      ESTOQUE := (ESTOQUE or (QTD > 0));
      if QTD > 0 then
      begin
        TempManutencaoEstoque.Append;
        TempManutencaoEstoqueCOD_PRODUTO.AsString := COD_PRODUTO;
        TempManutencaoEstoqueCOD_GRADE.AsString   := COD_GRADE;
        TempManutencaoEstoqueQTD.AsFloat          := QTD;
        TempManutencaoEstoqueUNIDADE.AsString     := UNIDADE;
        TempManutencaoEstoque.Post;
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.PRODUTOS_TABELA_VALORES(I: Integer);
var
  COD_TABELA_ITEM: Integer;
  SQL            : String;
begin
  try
    with DM do
    begin
      COD_TABELA_ITEM := isNull(PRODUTOS_TABELA[I].COD_TABELA_ITEM, 0);

      if (COD_TABELA_ITEM = 0) and (Trim(PRODUTOS_TABELA[I].TABELA_ITEM_DESC) <> '') then
      begin
        QR_GigaERP.Open('SELECT COD_TABELA_ITEM FROM TABELA_DO_SISTEMA_ITEM WHERE COD_TABELA = ' + IntToStr(I) + ' AND DESCRICAO = ' + QuotedStr(PRODUTOS_TABELA[I].TABELA_ITEM_DESC));
        COD_TABELA_ITEM := QR_GigaERP.FieldByName('COD_TABELA_ITEM').AsInteger;
        if COD_TABELA_ITEM = 0 then
        begin
          QR_GigaERP.Open('SELECT MAX(COD_TABELA_ITEM) COD FROM TABELA_DO_SISTEMA_ITEM WHERE COD_TABELA = ' + IntToStr(I));
          COD_TABELA_ITEM                     := QR_GigaERP.FieldByName('COD').AsInteger + 1;
          PRODUTOS_TABELA[I].TABELA_ITEM_DESC := copy(PRODUTOS_TABELA[I].TABELA_ITEM_DESC, 0, 30);
          SQL                                 := 'INSERT INTO TABELA_DO_SISTEMA_ITEM(COD_TABELA,COD_TABELA_ITEM,DESCRICAO)VALUES(' + IntToStr(I) + ',' + IntToStr(COD_TABELA_ITEM) + ',' +
            QuotedStr(PRODUTOS_TABELA[I].TABELA_ITEM_DESC) + ')';
          ConexaoGigaERP.ExecSQL(SQL);
        end;
      end;
      if COD_TABELA_ITEM > 0 then
      begin
        // raise Exception.Create('[PRODUTOS_TABELA_VALORES]'+#13+'As variaveis devem ser iniciadas');
        qrPRODUTOS_TABELA.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
        qrPRODUTOS_TABELA.FieldByName('COD_TABELA').Value  := I;
        qrPRODUTOS_TABELA.FieldByName('COD_TABELA_ITEM').Value := COD_TABELA_ITEM;
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TCadastro_Produtos.PRODUTOS_TAB_PRECOS_PROD_APLICA: Integer;
var
  COD_TABELA: String;
  SQL       : String;
begin
  Result := 1;
  try
    with DM do
    begin
      // qrPRODUTOS_TAB_PRECOS_PROD.Close;
      // qrPRODUTOS_TAB_PRECOS_PROD.Open;
      TempPRODUTOS_TAB_PRECOS_PROD.First;
      while not TempPRODUTOS_TAB_PRECOS_PROD.Eof do
      begin
        //COD_EMPRESA := TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_EMPRESA').Value;
        COD_TABELA  := TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_TABELA').Value;
        COD_PRODUTO := TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_PRODUTO').Value;
        COD_GRADE   := TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_GRADE').Value;

        qrPRODUTOS_TAB_PRECOS_PROD.Close;
        SQL := 'SELECT * FROM PRODUTOS_TAB_PRECOS_PROD WHERE COD_EMPRESA = ' + IntToStr(COD_EMPRESA) + 'AND COD_TABELA = ' + COD_TABELA + ' AND COD_PRODUTO = ''' + COD_PRODUTO +
          ''' AND COD_GRADE = ''' + COD_GRADE + '''';
        qrPRODUTOS_TAB_PRECOS_PROD.Open(SQL);

        if qrPRODUTOS_TAB_PRECOS_PROD.IsEmpty then
          raise Exception.Create('Tabela de preço não localizada' + #13 + SQL);

        // if not qrPRODUTOS_TAB_PRECOS_PROD.Locate('COD_EMPRESA;COD_TABELA;COD_PRODUTO;COD_GRADE',VarArrayOf([COD_EMPRESA,COD_TABELA,COD_PRODUTO,COD_GRADE]),[]) then
        // raise Exception.Create('Tabela de preço não localizada EMP/TAB/PROD/GRADE: '+IntToStr(COD_EMPRESA)+'/'+COD_TABELA+'/'+COD_PRODUTO+'/'+COD_GRADE);
        qrPRODUTOS_TAB_PRECOS_PROD.Edit;
        qrPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_EMPRESA').Value := COD_EMPRESA;
        qrPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_TABELA').Value := COD_TABELA;
        qrPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
        qrPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_GRADE').Value := COD_GRADE;
        qrPRODUTOS_TAB_PRECOS_PROD.FieldByName('PRECO').Value := TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('PRECO').Value;
        qrPRODUTOS_TAB_PRECOS_PROD.Post;
        TempPRODUTOS_TAB_PRECOS_PROD.Next;
        qrPRODUTOS_TAB_PRECOS_PROD.ApplyUpdates;
      end;
    end;
    Result := 0;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.PRODUTOS_TAB_PRECOS_PROD_VALORES(I: Integer);
begin
  try
    with DM do
    begin
      // if PRODUTOS_TAB_PRECOS_PROD[I].T>(-99999) then
      // raise Exception.Create('[PRODUTOS_TAB_PRECOS_PROD_VALORES]'+#13+'As variaveis devem ser iniciadas');
      if (isNull(PRODUTOS_TAB_PRECOS_PROD[I].PRECO, 0.00) = 0.00) and (I > 1) then
        PRODUTOS_TAB_PRECOS_PROD[I].PRECO := PRODUTOS_TAB_PRECOS_PROD[1].PRECO;
      TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_EMPRESA').Value := isNull(PRODUTOS_TAB_PRECOS_PROD[I].COD_EMPRESA, COD_EMPRESA);
      TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_TABELA').Value := I;
      TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_PRODUTO').Value := COD_PRODUTO;
      TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('COD_GRADE').Value := COD_GRADE;
      TempPRODUTOS_TAB_PRECOS_PROD.FieldByName('PRECO').Value := isNull(PRODUTOS_TAB_PRECOS_PROD[I].PRECO, 0.00);
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.PRODUTOS_VALORES;
var
  NCM: String;
begin
  try
    with DM do
    begin
      NCM := isNull(PRODUTOS.COD_CLASS, '99');
      NCM := RetiraNaoNumero(NCM);
      if NCM <> '99' then
        ConfereNCM(NCM);
      if PRODUTOS.T > (-99999) then
        raise Exception.Create('[PRODUTOS_VALORES]' + #13 + 'As variaveis devem ser iniciadas');
      qrPRODUTOS.FieldByName('COD_PRODUTO').Value          := COD_PRODUTO;
      qrPRODUTOS.FieldByName('DESC_PRODUTO').Value         := isNull(PRODUTOS.DESC_PRODUTO, 'SEM DESCRIÇÃO');
      qrPRODUTOS.FieldByName('DESC_PRODUTO_FISCAL').Value  := Coalesce(PRODUTOS.DESC_PRODUTO_FISCAL, PRODUTOS.DESC_PRODUTO);
      qrPRODUTOS.FieldByName('COD_GRUPO').Value            := isNull(PRODUTOS.COD_GRUPO, 1);
      qrPRODUTOS.FieldByName('FLAG_MARGEM_LUCRO').Value    := isNull(PRODUTOS.FLAG_MARGEM_LUCRO, 0);
      qrPRODUTOS.FieldByName('PERC_MARGEM_LUCRO').Value    := isNull(PRODUTOS.PERC_MARGEM_LUCRO, 0.00);
      qrPRODUTOS.FieldByName('OBS').Value                  := isNull(PRODUTOS.OBS, Null);
      qrPRODUTOS.FieldByName('PESO_LIQUIDO').Value         := isNull(PRODUTOS.PESO_LIQUIDO, 0.00);
      qrPRODUTOS.FieldByName('PESO_BRUTO').Value           := isNull(PRODUTOS.PESO_BRUTO, 0.00);
      qrPRODUTOS.FieldByName('COD_LISTA_SERVICO').Value    := isNull(PRODUTOS.COD_LISTA_SERVICO, Null);
      qrPRODUTOS.FieldByName('FLAG_BAIXA_ESTOQUE').Value   := isNull(PRODUTOS.FLAG_BAIXA_ESTOQUE, 1);
      qrPRODUTOS.FieldByName('FLAG_SERVICO').Value         := isNull(PRODUTOS.FLAG_SERVICO, 0);
      qrPRODUTOS.FieldByName('FLAG_DESC_ADICIONAL').Value  := isNull(PRODUTOS.FLAG_DESC_ADICIONAL, 0);
      qrPRODUTOS.FieldByName('FLAG_METRO_CUBICO').Value    := isNull(PRODUTOS.FLAG_METRO_CUBICO, Null);
      qrPRODUTOS.FieldByName('FLAG_ATIVO').Value           := isNull(PRODUTOS.FLAG_ATIVO, 1);
      qrPRODUTOS.FieldByName('FLAG_AGRUPA_SERVICO').Value  := isNull(PRODUTOS.FLAG_AGRUPA_SERVICO, 0);
      qrPRODUTOS.FieldByName('FLAG_PESO').Value            := isNull(PRODUTOS.FLAG_PESO, 0);
      qrPRODUTOS.FieldByName('COD_CLASS').Value            := NCM;
      qrPRODUTOS.FieldByName('FLAG_RMA').Value             := isNull(PRODUTOS.FLAG_RMA, 0);
      qrPRODUTOS.FieldByName('FLAG_QTD_PECAS').Value       := isNull(PRODUTOS.FLAG_QTD_PECAS, 0);
      qrPRODUTOS.FieldByName('COD_IMPOSTO').Value          := isNull(PRODUTOS.COD_IMPOSTO, 1);
      qrPRODUTOS.FieldByName('TIPO_PRODUCAO').Value        := isNull(PRODUTOS.TIPO_PRODUCAO, 'T');
      qrPRODUTOS.FieldByName('COD_TIPO_ITEM').Value        := isNull(PRODUTOS.COD_TIPO_ITEM, 0);
      qrPRODUTOS.FieldByName('PERC_COMISSAO_VISTA').Value  := isNull(PRODUTOS.PERC_COMISSAO_VISTA, 0.00);
      qrPRODUTOS.FieldByName('PERC_COMISSAO_PRAZO').Value  := isNull(PRODUTOS.PERC_COMISSAO_PRAZO, 0.00);
      qrPRODUTOS.FieldByName('FLAG_PROD_ESPECIFICO').Value := isNull(PRODUTOS.FLAG_PROD_ESPECIFICO, 0);
      qrPRODUTOS.FieldByName('FLAG_PROD_ACABADO').Value    := isNull(PRODUTOS.FLAG_PROD_ACABADO, 0);
      qrPRODUTOS.FieldByName('QTD_VOLUME').Value           := isNull(PRODUTOS.QTD_VOLUME, Null);
      qrPRODUTOS.FieldByName('COMB_COD_ANP').Value         := isNull(PRODUTOS.COMB_COD_ANP, Null);
      qrPRODUTOS.FieldByName('COMB_CODIF').Value           := isNull(PRODUTOS.COMB_CODIF, Null);
      qrPRODUTOS.FieldByName('COD_SETOR').Value            := isNull(PRODUTOS.COD_SETOR, Null);
      qrPRODUTOS.FieldByName('FLAG_MT_QUADRADO').Value     := isNull(PRODUTOS.FLAG_MT_QUADRADO, 0);
      qrPRODUTOS.FieldByName('FLAG_ENVIA_CARDAPIO').Value  := isNull(PRODUTOS.FLAG_ENVIA_CARDAPIO, 0);
      qrPRODUTOS.FieldByName('COD_NBS').Value              := isNull(PRODUTOS.COD_NBS, Null);
      qrPRODUTOS.FieldByName('ALIQ_NAC').Value             := isNull(PRODUTOS.ALIQ_NAC, Null);
      qrPRODUTOS.FieldByName('GF_FLAG_AGRUP').Value        := isNull(PRODUTOS.GF_FLAG_AGRUP, 0);
      qrPRODUTOS.FieldByName('GF_COD_PRODUTO').Value       := isNull(PRODUTOS.GF_COD_PRODUTO, Null);
      qrPRODUTOS.FieldByName('GF_INGREDIENTES').Value      := isNull(PRODUTOS.GF_INGREDIENTES, Null);
      qrPRODUTOS.FieldByName('EC_FLAG_ENVIA').Value        := isNull(PRODUTOS.EC_FLAG_ENVIA, 0);
      qrPRODUTOS.FieldByName('EC_INFORMACOES').Value       := isNull(PRODUTOS.EC_INFORMACOES, Null);
      qrPRODUTOS.FieldByName('GF_FLAG_COMPLEMENTO').Value  := isNull(PRODUTOS.GF_FLAG_COMPLEMENTO, 0);
      qrPRODUTOS.FieldByName('GF_FLAG_CORTESIA').Value     := isNull(PRODUTOS.GF_FLAG_CORTESIA, 0);
      qrPRODUTOS.FieldByName('CHAVE_OLD').Value            := isNull(PRODUTOS.CHAVE_OLD, Null);
      qrPRODUTOS.FieldByName('COMB_DERIVADO_PETROLEO').Value := isNull(PRODUTOS.COMB_DERIVADO_PETROLEO, Null);
      qrPRODUTOS.FieldByName('COMB_PERC_GAS_NATURAL').Value := isNull(PRODUTOS.COMB_PERC_GAS_NATURAL, Null);
      // qrPRODUTOS.FieldByName('DESC_PRODUTO_FISCAL_OLD').Value := isNull(PRODUTOS.DESC_PRODUTO_FISCAL_OLD,Null);
      qrPRODUTOS.FieldByName('ALIQ_FEDERAL').Value   := isNull(PRODUTOS.ALIQ_FEDERAL, Null);
      qrPRODUTOS.FieldByName('ALIQ_ESTADUAL').Value  := isNull(PRODUTOS.ALIQ_ESTADUAL, Null);
      qrPRODUTOS.FieldByName('ALIQ_MUNICIPAL').Value := isNull(PRODUTOS.ALIQ_MUNICIPAL, Null);
      qrPRODUTOS.FieldByName('FLAG_VENDAFF').Value   := isNull(PRODUTOS.FLAG_VENDAFF, 0);
      qrPRODUTOS.FieldByName('COD_CEST').Value       := isNull(PRODUTOS.COD_CEST, Null);
      qrPRODUTOS.FieldByName('FLAG_VRTOTAL').Value   := isNull(PRODUTOS.FLAG_VRTOTAL, 0);
      qrPRODUTOS.FieldByName('FLAG_MATERIA_PRIMA').Value   := isNull(PRODUTOS.FLAG_MATERIA_PRIMA, 0);
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TCadastro_Produtos.Reseta_Todas_Sequencias;
begin
  DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
end;

{ TPRODUTOS }

procedure TPRODUTOS.IniciarVariaveis;
begin
  try
{$REGION 'Tabela: PRODUTOS'}
    T := -99999;
    // COD_PRODUTO                            :=
    // DESC_PRODUTO                           :=
    // DESC_PRODUTO_FISCAL                    :=
    COD_GRUPO         := -99999;
    FLAG_MARGEM_LUCRO := -99999;
    PERC_MARGEM_LUCRO := -99999;
    // OBS                                    :=
    PESO_LIQUIDO := -99999;
    PESO_BRUTO   := -99999;
    // COD_LISTA_SERVICO                      :=
    FLAG_BAIXA_ESTOQUE  := -99999;
    FLAG_SERVICO        := -99999;
    FLAG_DESC_ADICIONAL := -99999;
    FLAG_METRO_CUBICO   := -99999;
    FLAG_ATIVO          := -99999;
    FLAG_AGRUPA_SERVICO := -99999;
    FLAG_PESO           := -99999;
    // COD_CLASS := '99';
    FLAG_RMA       := -99999;
    FLAG_QTD_PECAS := -99999;
    COD_IMPOSTO    := -99999;
    // TIPO_PRODUCAO := 'T';
    COD_TIPO_ITEM        := -99999;
    PERC_COMISSAO_VISTA  := -99999;
    PERC_COMISSAO_PRAZO  := -99999;
    FLAG_PROD_ESPECIFICO := -99999;
    FLAG_PROD_ACABADO    := -99999;
    QTD_VOLUME           := -99999;
    // COMB_COD_ANP                           :=
    // COMB_CODIF                             :=
    COD_SETOR           := -99999;
    FLAG_MT_QUADRADO    := -99999;
    FLAG_ENVIA_CARDAPIO := -99999;
    // COD_NBS                                :=
    ALIQ_NAC      := -99999;
    GF_FLAG_AGRUP := -99999;
    // GF_COD_PRODUTO                         :=
    // GF_INGREDIENTES                        :=
    EC_FLAG_ENVIA := -99999;
    // EC_INFORMACOES                         :=
    GF_FLAG_COMPLEMENTO := -99999;
    GF_FLAG_CORTESIA    := -99999;
    // CHAVE_OLD                              :=
    // COMB_DERIVADO_PETROLEO                 :=
    // COMB_PERC_GAS_NATURAL                  :=
    // DESC_PRODUTO_FISCAL_OLD                :=
    ALIQ_FEDERAL   := -99999;
    ALIQ_ESTADUAL  := -99999;
    ALIQ_MUNICIPAL := -99999;
    FLAG_VENDAFF   := -99999;
    // COD_CEST                               :=
    FLAG_VRTOTAL := -99999;
    FLAG_MATERIA_PRIMA := 0;
{$ENDREGION}
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TPRODUTOS_GRADE }

procedure TPRODUTOS_GRADE.IniciarVariaveis;
begin
  try
{$REGION 'Tabela: PRODUTOS_GRADE'}
    // .COD_PRODUTO                      :=
    // COD_GRADE := '*';
    T             := -99999;
    ORDEM         := -99999;
    FLAG_ATIVO    := -99999;
    ESTOQUE_MIN   := -99999;
    ESTOQUE_MAX   := -99999;
    COD_BALANCA   := -99999;
    DIAS_VALIDADE := -99999;
    DATA_VALIDADE := 0;
    // OBS                :=
    ECF_ESTOQUE := -99999;
    // COD_PRODUTO_ANT    :=
    // COD_GRADE_ANT      :=
    QTD_ESTOQUE := 0;
{$ENDREGION}
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TPRODUTOS_APELIDOS_PROD }

procedure TPRODUTOS_APELIDOS_PROD.IniciarVariaveis;
begin
  try
{$REGION 'Tabela: PRODUTOS_APELIDOS_PROD'}
    T           := -99999;
    COD_APELIDO := -99999;
    // COD_PRODUTO              :=
    // COD_GRADE                :=
    // APELIDO                  :=
{$ENDREGION}
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TPRODUTOS_CUSTO }

procedure TPRODUTOS_CUSTO.IniciarVariaveis;
begin
  try
{$REGION 'Tabela: PRODUTOS_CUSTO'}
    T           := -99999;
    COD_EMPRESA := -99999;
    // COD_PRODUTO                      :=
    // COD_GRADE := '*';
    PRECO_CUSTO          := -99999;
    VR_OUTRAS_DESPESAS   := -99999;
    ICMS_ALIQ            := -99999;
    IPI_ALIQ             := -99999;
    ST_IVA               := -99999;
    ST_ICMS_ALIQ         := -99999;
    PRECO_CUSTO_REAL     := -99999;
    DATA_ULTIMO_REAJUSTE := NOW;
    VR_FRETE             := -99999;
    VR_SEGURO            := -99999;
    VR_DESC_CUSTO        := -99999;
    ICMS_RED_BASE        := -99999;
    ST_ICMS_RED_BASE     := -99999;
    PIS_ALIQ             := -99999;
    COFINS_ALIQ          := -99999;
    IPI_TIPO_ALIQUOTA    := -99999;
    PIS_TIPO_ALIQUOTA    := -99999;
    COFINS_TIPO_ALIQUOTA := -99999;
    ST_ICMS_VR_PAUTA     := -99999;
{$ENDREGION}
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TPRODUTOS_GRADE_UND }

procedure TPRODUTOS_GRADE_UND.IniciarVariaveis;
begin
  try
{$REGION 'Tabela: PRODUTOS_GRADE_UND'}
    // COD_PRODUTO                  :=
    // COD_GRADE := '*';
    // UNIDADE := 'und';
    // ID                           :=
    T                     := -99999;
    FLAG_PADRAO           := -99999;
    FLAG_ATIVO            := -99999;
    FLAG_HABILITA_ENTRADA := -99999;
    FLAG_HABILITA_SAIDA   := -99999;
    IGN_ALTERADO          := -9999;
{$ENDREGION}
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TPRODUTOS_TABELA }

procedure TPRODUTOS_TABELA.IniciarVariaveis;
begin
  try
{$REGION 'Tabela: PRODUTOS_TABELA'}
    T := -99999;
    // COD_PRODUTO                     :=
    COD_TABELA      := -99999;
    COD_TABELA_ITEM := -99999;
{$ENDREGION}
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TPRODUTOS_TAB_PRECOS_PROD }

procedure TPRODUTOS_TAB_PRECOS_PROD.IniciarVariaveis;
begin
  try
{$REGION 'Tabela: PRODUTOS_TAB_PRECOS_PROD'}
    T           := -99999;
    COD_EMPRESA := -99999;
    COD_TABELA  := -99999;
    // COD_PRODUTO :=
    // COD_GRADE   := '*';
    PRECO := -99999;
{$ENDREGION}
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;
{$ENDREGION}
{$REGION 'TCadastroR_eceber'}
{ FATURAS_RECEBER_PARCELAS_BX }

procedure TFATURAS_RECEBER_PARCELAS_BX.IniciarVariaveis;
begin
  COD_EMPRESA      := -99999;
  TIPO_FATURA      := '';
  COD_FATURA       := -99999;
  COD_PARC         := '';
  COD_BAIXA        := -99999;
  TIPO_BAIXA       := '';
  COD_BANCO        := -99999;
  COD_BANCO_SEQ    := -99999;
  DESC_BAIXA       := '';
  DATA_RECEBIMENTO := 01 / 01 / 1899;
  DATA_CONTABIL    := 01 / 01 / 1899;
  VR_BAIXA         := -99999;
  VR_DESCONTOS     := -99999;
  VR_JUROS         := -99999;
  VR_ACRESCIMOS    := -99999;
  VR_CARTORIO      := -99999;
  VR_PROTESTO      := -99999;
  HISTORICO1       := '';
  HISTORICO2       := '';
  HISTORICO3       := '';
  ANO_MES          := -99999;
  LANCAMENTO       := -99999;
  FLAG_BAIXA       := -99999;
  DEV_COD_EMPRESA  := -99999;
  DEV_COD_DEV      := -99999;
  CHAVE_OLD        := '';
  VR_HAVER         := -99999;
  VR_MULTA         := -99999;
end;

{ FATURAS_RECEBER_PARCELAS }

procedure TFATURAS_RECEBER_PARCELAS.IniciarVariaveis;
begin
  COD_EMPRESA          := -99999;
  TIPO_FATURA          := '';
  COD_FATURA           := -99999;
  COD_PARC             := '';
  COD_BANCO            := -99999;
  COD_BANCO_SEQ        := -99999;
  DATA_VENCIMENTO      := 01 / 01 / 1899;
  DATA_RECEBIMENTO     := 01 / 01 / 1899;
  VR_PARCELA           := -99999;
  VR_BAIXA             := -99999;
  VR_BAIXA_OUTRAS      := -99999;
  DATA_LIMITE_DESCONTO := 01 / 01 / 1899;
  PERC_DESCONTO        := -99999;
  FLAG_CARTORIO        := -99999;
  VR_CARTORIO          := -99999;
  DATA_CARTORIO        := 01 / 01 / 1899;
  FLAG_PROTESTO        := -99999;
  VR_PROTESTO          := -99999;
  DATA_PROTESTO        := 01 / 011899;
  OBS                  := '';
  COD_COBRANCA         := -99999;
  NOSSO_NUMERO         := '';
  CHAVE_OLD            := '';
  CHAVE_ECF            := '';
  FLAG_TP_NOTA         := -99999;
end;

{ FATURAS_RECEBER_RATEIO }

procedure TFATURAS_RECEBER_RATEIO.IniciarVariaveis;
begin
  COD_EMPRESA        := -99999;
  TIPO_FATURA        := '';
  COD_FATURA         := -99999;
  COD_RATEIO         := -99999;
  COD_PC             := -99999;
  COD_CC             := -99999;
  VR_RATEIO          := -99999;
  PERC_RATEIO        := -99999;
  HISTORICO          := '';
  FLAG_DEMONSTRATIVO := -99999;
end;

{ FATURAS_RECEBER }

procedure TFATURAS_RECEBER.IniciarVariaveis;
begin
  COD_EMPRESA        := -99999;
  TIPO_FATURA        := '';
  COD_FATURA         := -99999;
  COD_CLIENTE        := -99999;
  COD_CLIENTE_OLD    := '';
  COD_VENDEDOR       := -99999;
  DATA_EMISSAO       := 01 / 01 / 1899;
  VR_BRUTO           := -99999;
  VR_DESCONTOS       := -99999;
  VR_ACRESCIMOS      := -99999;
  VR_LIQUIDO         := -99999;
  CHAVE_OLD          := '';
  FLAG_DUPL_IMPRESSA := -99999;
end;

{ TCadastro_Receber }

procedure TCadastro_Receber.AppendFatura;
begin
  if FATURAS_RECEBER.COD_FATURA < 0 then
    COD_FATURA := DM.GeraCod('SFATURAS_RECEBER')
  else
    COD_FATURA := FATURAS_RECEBER.COD_FATURA;
  COD_EMPRESA  := DM.isNull(FATURAS_RECEBER.COD_EMPRESA, COD_EMPRESA);
  DM.qrFATURAS_RECEBER.Append;
  FATURAS_RECEBER_VALORES;
  DM.qrFATURAS_RECEBER.Post;
  DM.qrFATURAS_RECEBER_RATEIO.Append;
  FATURAS_RECEBER_RATEIO_VALORES;
  DM.qrFATURAS_RECEBER_RATEIO.Post;
end;

procedure TCadastro_Receber.AppendParcela;
begin
  TIPO_FATURA := DM.isNull(FATURAS_RECEBER_PARCELAS.TIPO_FATURA, 'MA');
  COD_PARC    := DM.isNull(FATURAS_RECEBER_PARCELAS.COD_PARC, 1);
  if not DM.qrFATURAS_RECEBER_PARCELAS.Locate('COD_EMPRESA; TIPO_FATURA; COD_FATURA; COD_PARC', VarArrayOf([COD_EMPRESA, TIPO_FATURA, COD_FATURA, COD_PARC]), []) then
  begin
    DM.qrFATURAS_RECEBER_PARCELAS.Append;
    FATURAS_RECEBER_PARCELAS_VALORES;
    DM.qrFATURAS_RECEBER_PARCELAS.Post;
  end;
  if FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA > 0 then
  begin
    COD_BAIXA := DM.isNull(FATURAS_RECEBER_PARCELAS_BX.COD_BAIXA, 0);
    if COD_BAIXA = 0 then
    begin
      COD_BAIXA := 1;
      while DM.qrFATURAS_RECEBER_PARCELAS_BX.Locate('COD_EMPRESA; TIPO_FATURA; COD_FATURA; COD_PARC; COD_BAIXA', VarArrayOf([COD_EMPRESA, TIPO_FATURA, COD_FATURA, COD_PARC, COD_BAIXA]), []) do
        Inc(COD_BAIXA);
    end;
    DM.qrFATURAS_RECEBER_PARCELAS_BX.Append;
    FATURAS_RECEBER_PARCELAS_BX_VALORES;
    DM.qrFATURAS_RECEBER_PARCELAS_BX.Post;
  end;
end;

procedure TCadastro_Receber.ApplyUpdates;
begin
  if DM.qrFATURAS_RECEBER.ApplyUpdates(0) = 0 then
    if DM.qrFATURAS_RECEBER_RATEIO.ApplyUpdates(0) = 0 then
      if DM.qrFATURAS_RECEBER_PARCELAS.ApplyUpdates(0) = 0 then
        DM.qrFATURAS_RECEBER_PARCELAS_BX.ApplyUpdates(0);
  DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
end;

constructor TCadastro_Receber.Create;
begin
  DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_LOGAR(''ADMIN'')');
  FATURAS_RECEBER.IniciarVariaveis;
  FATURAS_RECEBER_RATEIO.IniciarVariaveis;
  FATURAS_RECEBER_PARCELAS.IniciarVariaveis;
  FATURAS_RECEBER_PARCELAS_BX.IniciarVariaveis;
end;

procedure TCadastro_Receber.FATURAS_RECEBER_PARCELAS_BX_VALORES;
begin
  with DM do
  begin
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('COD_EMPRESA').Value := COD_EMPRESA;
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('TIPO_FATURA').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.TIPO_FATURA, 'MA');
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('COD_FATURA').Value := COD_FATURA;
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('COD_PARC').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.COD_PARC, FATURAS_RECEBER_PARCELAS.COD_PARC);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('COD_BAIXA').Value := COD_BAIXA;
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('TIPO_BAIXA').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.TIPO_BAIXA, '00');
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('COD_BANCO').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.COD_BANCO, 999);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('COD_BANCO_SEQ').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.COD_BANCO_SEQ, 1);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('DESC_BAIXA').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.DESC_BAIXA, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('DATA_RECEBIMENTO').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.DATA_RECEBIMENTO, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('DATA_CONTABIL').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.DATA_CONTABIL, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_BAIXA').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_DESCONTOS').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_DESCONTOS, 0.00);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_JUROS').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_JUROS, 0.00);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_ACRESCIMOS').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_ACRESCIMOS, 0.00);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_CARTORIO').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_CARTORIO, 0.00);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_PROTESTO').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_PROTESTO, 0.00);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('HISTORICO1').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.HISTORICO1, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('HISTORICO2').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.HISTORICO2, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('HISTORICO3').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.HISTORICO3, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('ANO_MES').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.ANO_MES, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('LANCAMENTO').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.LANCAMENTO, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('FLAG_BAIXA').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.FLAG_BAIXA, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('DEV_COD_EMPRESA').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.DEV_COD_EMPRESA, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('DEV_COD_DEV').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.DEV_COD_DEV, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('CHAVE_OLD').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.CHAVE_OLD, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_HAVER').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_HAVER, Null);
    qrFATURAS_RECEBER_PARCELAS_BX.FieldByName('VR_MULTA').Value := isNull(FATURAS_RECEBER_PARCELAS_BX.VR_MULTA, Null);
  end;
end;

procedure TCadastro_Receber.FATURAS_RECEBER_PARCELAS_VALORES;
begin
  with DM do
  begin
    qrFATURAS_RECEBER_PARCELAS.FieldByName('COD_EMPRESA').Value := COD_EMPRESA;
    qrFATURAS_RECEBER_PARCELAS.FieldByName('TIPO_FATURA').Value := TIPO_FATURA;
    qrFATURAS_RECEBER_PARCELAS.FieldByName('COD_FATURA').Value := COD_FATURA;
    qrFATURAS_RECEBER_PARCELAS.FieldByName('COD_PARC').Value := COD_PARC;
    qrFATURAS_RECEBER_PARCELAS.FieldByName('COD_BANCO').Value := isNull(FATURAS_RECEBER_PARCELAS.COD_BANCO, 999);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('COD_BANCO_SEQ').Value := isNull(FATURAS_RECEBER_PARCELAS.COD_BANCO_SEQ, 1);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('DATA_VENCIMENTO').Value := isNull(FATURAS_RECEBER_PARCELAS.DATA_VENCIMENTO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('DATA_RECEBIMENTO').Value := isNull(FATURAS_RECEBER_PARCELAS.DATA_RECEBIMENTO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('VR_PARCELA').Value := isNull(FATURAS_RECEBER_PARCELAS.VR_PARCELA, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('VR_BAIXA').Value := isNull(FATURAS_RECEBER_PARCELAS.VR_BAIXA, 0.00);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('VR_BAIXA_OUTRAS').Value := isNull(FATURAS_RECEBER_PARCELAS.VR_BAIXA_OUTRAS, 0.00);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('DATA_LIMITE_DESCONTO').Value := isNull(FATURAS_RECEBER_PARCELAS.DATA_LIMITE_DESCONTO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('PERC_DESCONTO').Value := isNull(FATURAS_RECEBER_PARCELAS.PERC_DESCONTO, 0.00);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('FLAG_CARTORIO').Value := isNull(FATURAS_RECEBER_PARCELAS.FLAG_CARTORIO, 0);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('VR_CARTORIO').Value := isNull(FATURAS_RECEBER_PARCELAS.VR_CARTORIO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('DATA_CARTORIO').Value := isNull(FATURAS_RECEBER_PARCELAS.DATA_CARTORIO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('FLAG_PROTESTO').Value := isNull(FATURAS_RECEBER_PARCELAS.FLAG_PROTESTO, 0);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('VR_PROTESTO').Value := isNull(FATURAS_RECEBER_PARCELAS.VR_PROTESTO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('DATA_PROTESTO').Value := isNull(FATURAS_RECEBER_PARCELAS.DATA_PROTESTO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('OBS').Value := isNull(FATURAS_RECEBER_PARCELAS.OBS, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('COD_COBRANCA').Value := isNull(FATURAS_RECEBER_PARCELAS.COD_COBRANCA, 1);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('NOSSO_NUMERO').Value := isNull(FATURAS_RECEBER_PARCELAS.NOSSO_NUMERO, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('CHAVE_OLD').Value := isNull(FATURAS_RECEBER_PARCELAS.CHAVE_OLD, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('CHAVE_ECF').Value := isNull(FATURAS_RECEBER_PARCELAS.CHAVE_ECF, Null);
    qrFATURAS_RECEBER_PARCELAS.FieldByName('FLAG_TP_NOTA').Value := isNull(FATURAS_RECEBER_PARCELAS.FLAG_TP_NOTA, 2);
  end;
end;

procedure TCadastro_Receber.FATURAS_RECEBER_RATEIO_VALORES;
begin
  with DM do
  begin
    qrFATURAS_RECEBER_RATEIO.FieldByName('COD_EMPRESA').AsInteger := COD_EMPRESA;
    qrFATURAS_RECEBER_RATEIO.FieldByName('TIPO_FATURA').AsString := isNull(FATURAS_RECEBER_RATEIO.TIPO_FATURA, 'MA');
    qrFATURAS_RECEBER_RATEIO.FieldByName('COD_FATURA').AsInteger := COD_FATURA;
    qrFATURAS_RECEBER_RATEIO.FieldByName('COD_RATEIO').AsInteger := isNull(FATURAS_RECEBER_RATEIO.COD_RATEIO, 1);
    qrFATURAS_RECEBER_RATEIO.FieldByName('COD_PC').AsInteger := isNull(FATURAS_RECEBER_RATEIO.COD_PC, 11);
    qrFATURAS_RECEBER_RATEIO.FieldByName('COD_CC').AsInteger := isNull(FATURAS_RECEBER_RATEIO.COD_CC, 1);
    qrFATURAS_RECEBER_RATEIO.FieldByName('VR_RATEIO').AsFloat := isNull(FATURAS_RECEBER_RATEIO.VR_RATEIO, FATURAS_RECEBER.VR_LIQUIDO);
    qrFATURAS_RECEBER_RATEIO.FieldByName('PERC_RATEIO').AsFloat := isNull(FATURAS_RECEBER_RATEIO.PERC_RATEIO, 100);
    qrFATURAS_RECEBER_RATEIO.FieldByName('HISTORICO').AsString := isNull(FATURAS_RECEBER_RATEIO.HISTORICO, '');
    qrFATURAS_RECEBER_RATEIO.FieldByName('FLAG_DEMONSTRATIVO').AsInteger := isNull(FATURAS_RECEBER_RATEIO.FLAG_DEMONSTRATIVO, 0);
  end;
end;

procedure TCadastro_Receber.FATURAS_RECEBER_VALORES;
var
  COD_CLIENTE: Integer;
  SQL        : String;
begin
  with DM do
  begin
    if FATURAS_RECEBER.COD_CLIENTE < 0 then
    begin
      QR_GigaERP.Open('SELECT COD_PESSOA FROM PESSOAS WHERE CHAVE_OLD = ' + QuotedStr(FATURAS_RECEBER.COD_CLIENTE_OLD));
      COD_CLIENTE := QR_GigaERP.FieldByName('COD_PESSOA').AsInteger;
    end
    else
      COD_CLIENTE := FATURAS_RECEBER.COD_CLIENTE;

    qrFATURAS_RECEBER.FieldByName('COD_EMPRESA').AsInteger := COD_EMPRESA;
    qrFATURAS_RECEBER.FieldByName('TIPO_FATURA').AsString  := isNull(FATURAS_RECEBER.TIPO_FATURA, 'MA');
    qrFATURAS_RECEBER.FieldByName('COD_FATURA').AsInteger  := COD_FATURA;
    qrFATURAS_RECEBER.FieldByName('COD_CLIENTE').AsInteger := COD_CLIENTE;
    qrFATURAS_RECEBER.FieldByName('COD_VENDEDOR').AsInteger := isNull(FATURAS_RECEBER.COD_VENDEDOR, 1);
    qrFATURAS_RECEBER.FieldByName('DATA_EMISSAO').AsDateTime := isNull(FATURAS_RECEBER.DATA_EMISSAO, Null);
    qrFATURAS_RECEBER.FieldByName('VR_BRUTO').AsFloat := isNull(FATURAS_RECEBER.VR_BRUTO, Null);
    qrFATURAS_RECEBER.FieldByName('VR_DESCONTOS').AsFloat  := isNull(FATURAS_RECEBER.VR_DESCONTOS, 0.00);
    qrFATURAS_RECEBER.FieldByName('VR_ACRESCIMOS').AsFloat := isNull(FATURAS_RECEBER.VR_ACRESCIMOS, 0.00);
    qrFATURAS_RECEBER.FieldByName('VR_LIQUIDO').AsFloat    := isNull(FATURAS_RECEBER.VR_LIQUIDO, FATURAS_RECEBER.VR_BRUTO);
    qrFATURAS_RECEBER.FieldByName('CHAVE_OLD').AsString    := isNull(FATURAS_RECEBER.CHAVE_OLD, Null);
    qrFATURAS_RECEBER.FieldByName('FLAG_DUPL_IMPRESSA').AsInteger := isNull(FATURAS_RECEBER.FLAG_DUPL_IMPRESSA, 0);
  end;
end;

procedure TCadastro_Receber.Open;
begin
  try
    // DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
    DM.qrFATURAS_RECEBER.Close;
    DM.qrFATURAS_RECEBER_RATEIO.Close;
    DM.qrFATURAS_RECEBER_PARCELAS.Close;
    DM.qrFATURAS_RECEBER_PARCELAS_BX.Close;

    DM.qrFATURAS_RECEBER.Open();
    DM.qrFATURAS_RECEBER_RATEIO.Open();
    DM.qrFATURAS_RECEBER_PARCELAS.Open();
    DM.qrFATURAS_RECEBER_PARCELAS_BX.Open();

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TCLIENTES_TABELA }

procedure TCLIENTES_TABELA.Create;
begin
  COD_CLIENTE      := -99999;
  COD_TABELA       := -99999;
  COD_TABELA_ITEM  := -99999;
  DESC_TABELA      := '';
  DESC_TABELA_ITEM := '';
end;
{$ENDREGION}
{ TCadastro_Pagar }

procedure TCadastro_Pagar.AppendFatura;
begin
  COD_EMPRESA := DM.isNull(FATURAS_PAGAR.COD_EMPRESA, COD_EMPRESA);
  if Not DM.qrFATURAS_PAGAR.Locate('CHAVE_OLD', FATURAS_PAGAR.CHAVE_OLD, []) then
  begin
    if FATURAS_PAGAR.COD_SEQUENCIA < 0 then
      COD_SEQUENCIA := DM.GeraCod('SFATURAS_PAGAR')
    else
      COD_SEQUENCIA := FATURAS_PAGAR.COD_SEQUENCIA;
    DM.qrFATURAS_PAGAR.Append;
    FATURAS_PAGAR_VALORES;
    DM.qrFATURAS_PAGAR.Post;
    DM.qrFATURAS_PAGAR_RATEIO.Append;
    FATURAS_PAGAR_RATEIO_VALORES;
    DM.qrFATURAS_PAGAR_RATEIO.Post;
  end
  else
    COD_SEQUENCIA := DM.qrFATURAS_PAGAR.FieldByName('COD_SEQUENCIA').AsInteger;
  COD_PARC        := DM.isNull(FATURAS_PAGAR_PARCELAS.COD_PARC, 1);
  if not DM.qrFATURAS_PAGAR_PARCELAS.Locate('COD_EMPRESA; COD_SEQUENCIA; COD_PARC', VarArrayOf([COD_EMPRESA, COD_SEQUENCIA, COD_PARC]), []) then
  begin
    DM.qrFATURAS_PAGAR_PARCELAS.Append;
    FATURAS_PAGAR_PARCELAS_VALORES;
    DM.qrFATURAS_PAGAR_PARCELAS.Post;
  end;
  if FATURAS_PAGAR_PARCELAS_BX.VR_BAIXA > 0 then
  begin
    COD_BAIXA := DM.isNull(FATURAS_PAGAR_PARCELAS_BX.COD_BAIXA, 0);
    if COD_BAIXA = 0 then
    begin
      COD_BAIXA := 1;
      while DM.qrFATURAS_PAGAR_PARCELAS_BX.Locate('COD_EMPRESA; COD_SEQUENCIA; COD_PARC; COD_BAIXA', VarArrayOf([COD_EMPRESA, COD_SEQUENCIA, COD_PARC, COD_BAIXA]), []) do
        Inc(COD_BAIXA);
    end;
    DM.qrFATURAS_PAGAR_PARCELAS_BX.Append;
    FATURAS_PAGAR_PARCELAS_BX_VALORES;
    DM.qrFATURAS_PAGAR_PARCELAS_BX.Post;
  end;
end;

procedure TCadastro_Pagar.ApplyUpdates;
begin
  if DM.qrFATURAS_PAGAR.ApplyUpdates(0) = 0 then
    if DM.qrFATURAS_PAGAR_RATEIO.ApplyUpdates(0) = 0 then
      if DM.qrFATURAS_PAGAR_PARCELAS.ApplyUpdates(0) = 0 then
        DM.qrFATURAS_PAGAR_PARCELAS_BX.ApplyUpdates(0);
  DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
  DM.ConexaoGigaERP.ExecSQL('UPDATE FATURAS_PAGAR FP SET ' + 'FP.VR_BRUTO = (SELECT SUM(FPP.VR_PARCELA) FROM FATURAS_PAGAR_PARCELAS FPP ' + '               WHERE FPP.COD_EMPRESA = FP.COD_EMPRESA ' +
    '                 AND FPP.COD_SEQUENCIA = FP.COD_SEQUENCIA); ' + 'UPDATE FATURAS_PAGAR FP SET ' + 'FP.VR_LIQUIDO = FP.VR_BRUTO-FP.VR_DESCONTOS+FP.VR_ACRESCIMOS; ');
end;

constructor TCadastro_Pagar.Create;
begin
  COD_EMPRESA   := 1;
  COD_SEQUENCIA := 1;
  COD_PARC      := 1;
  COD_BAIXA     := 1;
  FATURAS_PAGAR.IniciarVariaveis;
  FATURAS_PAGAR_RATEIO.IniciarVariaveis;
  FATURAS_PAGAR_PARCELAS.IniciarVariaveis;
  FATURAS_PAGAR_PARCELAS_BX.IniciarVariaveis;
end;

procedure TCadastro_Pagar.FATURAS_PAGAR_PARCELAS_BX_VALORES;
begin
  with DM do
  begin
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('COD_EMPRESA').Value := COD_EMPRESA;
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('COD_SEQUENCIA').Value := COD_SEQUENCIA;
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('COD_PARC').Value := COD_PARC;
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('COD_BAIXA').Value := COD_BAIXA;
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('TIPO_BAIXA').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.TIPO_BAIXA, '00');
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('DESC_BAIXA').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.DESC_BAIXA, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('DATA_PAGAMENTO').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.DATA_PAGAMENTO, NOW);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('DATA_CONTABIL').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.DATA_CONTABIL, isNull(FATURAS_PAGAR_PARCELAS_BX.DATA_PAGAMENTO, NOW));
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('VR_BAIXA').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.VR_BAIXA, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('VR_JUROS').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.VR_JUROS, 0.00);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('VR_ACRESCIMOS').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.VR_ACRESCIMOS, 0.00);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('VR_DESCONTOS').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.VR_DESCONTOS, 0.00);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('COD_BANCO').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.COD_BANCO, 999);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('COD_BANCO_SEQ').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.COD_BANCO_SEQ, 1);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('HISTORICO1').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.HISTORICO1, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('HISTORICO2').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.HISTORICO2, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('HISTORICO3').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.HISTORICO3, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('N_DOCUMENTO').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.N_DOCUMENTO, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('ANO_MES').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.ANO_MES, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('LANCAMENTO').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.LANCAMENTO, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('FLAG_BLOQUEADO').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.FLAG_BLOQUEADO, Null);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('FLAG_BAIXA').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.FLAG_BAIXA, 1);
    qrFATURAS_PAGAR_PARCELAS_BX.FieldByName('CHAVE_OLD').Value := isNull(FATURAS_PAGAR_PARCELAS_BX.CHAVE_OLD, Null);
  end;
end;

procedure TCadastro_Pagar.FATURAS_PAGAR_PARCELAS_VALORES;
begin
  with DM do
  begin
    qrFATURAS_PAGAR_PARCELAS.FieldByName('COD_EMPRESA').Value := COD_EMPRESA;
    qrFATURAS_PAGAR_PARCELAS.FieldByName('COD_SEQUENCIA').Value := COD_SEQUENCIA;
    qrFATURAS_PAGAR_PARCELAS.FieldByName('COD_PARC').Value := COD_PARC;
    qrFATURAS_PAGAR_PARCELAS.FieldByName('DATA_VENCIMENTO').Value := isNull(FATURAS_PAGAR_PARCELAS.DATA_VENCIMENTO, Null);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('DATA_PAGAMENTO').Value := isNull(FATURAS_PAGAR_PARCELAS.DATA_PAGAMENTO, Null);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('VR_PARCELA').Value := isNull(FATURAS_PAGAR_PARCELAS.VR_PARCELA, Null);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('VR_BAIXA').Value := isNull(FATURAS_PAGAR_PARCELAS.VR_BAIXA, 0.00);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('VR_BAIXA_OUTRAS').Value := isNull(FATURAS_PAGAR_PARCELAS.VR_BAIXA_OUTRAS, 0.00);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('COD_BANCO').Value := isNull(FATURAS_PAGAR_PARCELAS.COD_BANCO, 999);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('COD_COBRANCA').Value := isNull(FATURAS_PAGAR_PARCELAS.COD_COBRANCA, 1);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('OBS').Value := isNull(FATURAS_PAGAR_PARCELAS.OBS, Null);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('FLAG_PREVISAO').Value := isNull(FATURAS_PAGAR_PARCELAS.FLAG_PREVISAO, 0);
    qrFATURAS_PAGAR_PARCELAS.FieldByName('CHAVE_OLD').Value := isNull(FATURAS_PAGAR_PARCELAS.CHAVE_OLD, Null);
  end;
end;

procedure TCadastro_Pagar.FATURAS_PAGAR_RATEIO_VALORES;
begin
  with DM do
  begin
    qrFATURAS_PAGAR_RATEIO.FieldByName('COD_EMPRESA').AsInteger := COD_EMPRESA;
    qrFATURAS_PAGAR_RATEIO.FieldByName('COD_SEQUENCIA').AsInteger := COD_SEQUENCIA;
    qrFATURAS_PAGAR_RATEIO.FieldByName('COD_RATEIO').AsString := isNull(FATURAS_PAGAR_RATEIO.COD_RATEIO, 1);
    qrFATURAS_PAGAR_RATEIO.FieldByName('COD_CC').AsString := isNull(FATURAS_PAGAR_RATEIO.COD_CC, 1);
    qrFATURAS_PAGAR_RATEIO.FieldByName('COD_PC').AsString := isNull(FATURAS_PAGAR_RATEIO.COD_PC, 26);
    qrFATURAS_PAGAR_RATEIO.FieldByName('VR_RATEIO').AsString := isNull(FATURAS_PAGAR_RATEIO.VR_RATEIO, FATURAS_PAGAR.VR_LIQUIDO);
    qrFATURAS_PAGAR_RATEIO.FieldByName('HISTORICO').AsString := isNull(FATURAS_PAGAR_RATEIO.HISTORICO, 'importação de dados');
    qrFATURAS_PAGAR_RATEIO.FieldByName('FLAG_DEMONSTRATIVO').AsString := isNull(FATURAS_PAGAR_RATEIO.FLAG_DEMONSTRATIVO, 0);
  end;
end;

procedure TCadastro_Pagar.FATURAS_PAGAR_VALORES;
var
  COD_FORNECEDOR: Integer;
  SQL           : String;
begin
  with DM do
  begin
    if FATURAS_PAGAR.COD_FORNECEDOR < 0 then
    begin
      QR_GigaERP.Open('SELECT COD_PESSOA FROM PESSOAS WHERE CHAVE_OLD = ' + QuotedStr(FATURAS_PAGAR.COD_FORNECEDOR_OLD));
      COD_FORNECEDOR := QR_GigaERP.FieldByName('COD_PESSOA').AsInteger;
    end
    else
      COD_FORNECEDOR := FATURAS_PAGAR.COD_FORNECEDOR;

    FATURAS_PAGAR.VR_LIQUIDO := isNull(isNull(FATURAS_PAGAR.VR_BRUTO, 0.00) - isNull(FATURAS_PAGAR.VR_DESCONTOS, 0.00) + isNull(FATURAS_PAGAR.VR_ACRESCIMOS, 0.00), 0.00);

    qrFATURAS_PAGAR.FieldByName('COD_EMPRESA').AsInteger   := COD_EMPRESA;
    qrFATURAS_PAGAR.FieldByName('COD_SEQUENCIA').AsInteger := isNull(FATURAS_PAGAR.COD_SEQUENCIA, Null);
    qrFATURAS_PAGAR.FieldByName('TIPO_FATURA').AsInteger   := isNull(FATURAS_PAGAR.TIPO_FATURA, 1);
    qrFATURAS_PAGAR.FieldByName('COD_FORNECEDOR').AsInteger := isNull(FATURAS_PAGAR.COD_FORNECEDOR, Null);
    qrFATURAS_PAGAR.FieldByName('DOCUMENTO').AsString      := isNull(FATURAS_PAGAR.DOCUMENTO, FATURAS_PAGAR.COD_SEQUENCIA);
    qrFATURAS_PAGAR.FieldByName('DATA_EMISSAO').AsDateTime := isNull(FATURAS_PAGAR.DATA_EMISSAO, NOW);
    qrFATURAS_PAGAR.FieldByName('DATA_ENTRADA').AsDateTime := isNull(FATURAS_PAGAR.DATA_ENTRADA, FATURAS_PAGAR.DATA_EMISSAO);
    qrFATURAS_PAGAR.FieldByName('DESCRICAO').AsString      := isNull(FATURAS_PAGAR.DESCRICAO, 'FATURA A PAGAR');
    qrFATURAS_PAGAR.FieldByName('VR_BRUTO').AsFloat        := isNull(FATURAS_PAGAR.VR_BRUTO, 0.00);
    qrFATURAS_PAGAR.FieldByName('VR_DESCONTOS').AsFloat    := isNull(FATURAS_PAGAR.VR_DESCONTOS, 0.00);
    qrFATURAS_PAGAR.FieldByName('VR_ACRESCIMOS').AsFloat   := isNull(FATURAS_PAGAR.VR_ACRESCIMOS, 0.00);
    qrFATURAS_PAGAR.FieldByName('VR_LIQUIDO').AsFloat      := FATURAS_PAGAR.VR_LIQUIDO;
    qrFATURAS_PAGAR.FieldByName('ANO_MES').Value           := isNull(FATURAS_PAGAR.ANO_MES, Null);
    qrFATURAS_PAGAR.FieldByName('SEQ_DESP_FIXA').Value     := isNull(FATURAS_PAGAR.SEQ_DESP_FIXA, Null);
    qrFATURAS_PAGAR.FieldByName('COD_DESP_FIXA').Value     := isNull(FATURAS_PAGAR.COD_DESP_FIXA, Null);
    qrFATURAS_PAGAR.FieldByName('DEV_COD_EMPRESA').Value   := isNull(FATURAS_PAGAR.DEV_COD_EMPRESA, Null);
    qrFATURAS_PAGAR.FieldByName('DEV_COD_DEV').Value       := isNull(FATURAS_PAGAR.DEV_COD_DEV, Null);
    qrFATURAS_PAGAR.FieldByName('CHAVE_OLD').Value         := isNull(FATURAS_PAGAR.CHAVE_OLD, Null);
  end;
end;

procedure TCadastro_Pagar.Open;
begin
  try
    // DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
    DM.qrFATURAS_PAGAR.Close;
    DM.qrFATURAS_PAGAR_RATEIO.Close;
    DM.qrFATURAS_PAGAR_PARCELAS.Close;
    DM.qrFATURAS_PAGAR_PARCELAS_BX.Close;

    DM.qrFATURAS_PAGAR.Open();
    DM.qrFATURAS_PAGAR_RATEIO.Open();
    DM.qrFATURAS_PAGAR_PARCELAS.Open();
    DM.qrFATURAS_PAGAR_PARCELAS_BX.Open();
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ TFATURAS_PAGAR }

procedure TFATURAS_PAGAR.IniciarVariaveis;
begin
  COD_EMPRESA     := -99999;
  COD_SEQUENCIA   := -99999;
  TIPO_FATURA     := -99999;
  COD_FORNECEDOR  := -99999;
  DOCUMENTO       := '';
  DATA_EMISSAO    := 01 / 01 / 1899;
  DATA_ENTRADA    := 01 / 01 / 1899;
  DESCRICAO       := '';
  VR_BRUTO        := -99999;
  VR_DESCONTOS    := -99999;
  VR_ACRESCIMOS   := -99999;
  VR_LIQUIDO      := -99999;
  ANO_MES         := -99999;
  SEQ_DESP_FIXA   := -99999;
  COD_DESP_FIXA   := -99999;
  DEV_COD_EMPRESA := -99999;
  DEV_COD_DEV     := -99999;
  CHAVE_OLD       := '';
end;

{ TFATURAS_PAGAR_RATEIO }

procedure TFATURAS_PAGAR_RATEIO.IniciarVariaveis;
begin
  COD_EMPRESA        := -99999;
  COD_SEQUENCIA      := -99999;
  COD_RATEIO         := -99999;
  COD_CC             := -99999;
  COD_PC             := -99999;
  VR_RATEIO          := -99999;
  HISTORICO          := '';
  FLAG_DEMONSTRATIVO := -99999;
end;

{ TFATURAS_PAGAR_PARCELAS }

procedure TFATURAS_PAGAR_PARCELAS.IniciarVariaveis;
begin
  COD_EMPRESA     := -99999;
  COD_SEQUENCIA   := -99999;
  COD_PARC        := '';
  DATA_VENCIMENTO := 01 / 01 / 1899;
  DATA_PAGAMENTO  := 01 / 01 / 1899;
  VR_PARCELA      := -99999;
  VR_BAIXA        := -99999;
  VR_BAIXA_OUTRAS := -99999;
  COD_BANCO       := -99999;
  COD_COBRANCA    := -99999;
  OBS             := '';
  FLAG_PREVISAO   := -99999;
  CHAVE_OLD       := '';
end;

{ TFATURAS_PAGAR_PARCELAS_BX }

procedure TFATURAS_PAGAR_PARCELAS_BX.IniciarVariaveis;
begin
  COD_EMPRESA    := -99999;
  COD_SEQUENCIA  := -99999;
  COD_PARC       := '';
  COD_BAIXA      := -99999;
  TIPO_BAIXA     := '';
  DESC_BAIXA     := '';
  DATA_PAGAMENTO := 01 / 01 / 1899;
  DATA_CONTABIL  := 01 / 01 / 1899;
  VR_BAIXA       := -99999;
  VR_JUROS       := -99999;
  VR_ACRESCIMOS  := -99999;
  VR_DESCONTOS   := -99999;
  COD_BANCO      := -99999;
  COD_BANCO_SEQ  := -99999;
  HISTORICO1     := '';
  HISTORICO2     := '';
  HISTORICO3     := '';
  N_DOCUMENTO    := '';
  ANO_MES        := -99999;
  LANCAMENTO     := -99999;
  FLAG_BLOQUEADO := -99999;
  FLAG_BAIXA     := -99999;
  CHAVE_OLD      := '';
end;

{ TFORNECIMENTOS }

procedure TFORNECIMENTOS.IniciarVariaveis;
begin
  COD_FORNECIMENTO       := -99999;
  COD_EMPRESA            := -99999;
  COD_FORNECEDOR         := -99999;
  COD_FORNECEDOR_OLD     := -99999;
  COD_PRODUTO_FORNECEDOR := '';
  COD_PRODUTO            := '';
  COD_GRADE              := '';
  COD_PRODUTO_DIGITADO   := '';
end;

end.
