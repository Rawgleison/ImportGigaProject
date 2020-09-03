unit untFelipe_MCG;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils;
type
  TfrmATENA = class(TForm)
    Panel1: TPanel;
    Gauge1: TGauge;
    Label1: TLabel;
    butProdutos: TButton;
    vleConexao: TValueListEditor;
    butGravar: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    butClientes: TButton;
    butFornecedores: TButton;
    butTransportadoras: TButton;
    Memo1: TMemo;
    butGruposProduto: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butGravarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure butProdutosClick(Sender: TObject);
    procedure butClientesClick(Sender: TObject);
    procedure butFornecedoresClick(Sender: TObject);
    procedure butTransportadorasClick(Sender: TObject);
    procedure butGruposProdutoClick(Sender: TObject);
  private
    procedure ConectaGiga;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmATENA: TfrmATENA;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmATENA.butClientesClick(Sender: TObject);
var
  CLI: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
  CPF: String;
  CNPJ: String;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_CLIENTES WHERE IDENTIFICACAO = ''C''');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;
    
    Gauge1.Progress:=0;
    CLI:=TCadastro_Pessoas.Create;
    CLI.TIPO_CADASTRO:=1;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      CLI.PESSOAS.OBS_PESSOA                := qrImport.FieldByName('OBSERVACAO'              ).AsString;	
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAOATENDIMENTO'   ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAOQUALIDADE'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAOSERASA'        ).AsString;
      CLI.PESSOAS.CHAVE_OLD                 := qrImport.FieldByName('CODIGO'                  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IDENTIFICACAO'           ).AsString;
      CLI.PESSOAS.RAZAO_SOCIAL              := qrImport.FieldByName('RAZAOSOCIAL'             ).AsString;
      CLI.PESSOAS.FLAG_ATIVO                := StrToInt(IfThen(qrImport.FieldByName('CLIENTEINATIVO'          ).AsString='F','1','0'));
      CLI.PESSOAS.NOME_FANTASIA             := qrImport.FieldByName('NOMEFANTASIA'            ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODRAMOATIVIDADE'        ).AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO     := qrImport.FieldByName('ENDERECO'                ).AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO       := qrImport.FieldByName('BAIRRO'                  ).AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC   := qrImport.FieldByName('MUNICIPIO'               ).AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP          := qrImport.FieldByName('CEP'                     ).AsString;
      CLI.PESSOAS_ENDERECOS[1].UF           := qrImport.FieldByName('ESTADO'                  ).AsString;
      CLI.PESSOAS_ENDERECOS[2].Create;
      CLI.PESSOAS_ENDERECOS[2].ENDERECO     := qrImport.FieldByName('ENDERECODECOBRANCA'      ).AsString;
      CLI.PESSOAS_ENDERECOS[2].NOME_MUNIC   := qrImport.FieldByName('MUNICIPIOENDCOBRANCA'    ).AsString;
      CLI.PESSOAS_ENDERECOS[2].CEP          := qrImport.FieldByName('CEPDOENDCOBRANCA'        ).AsString;
      CLI.PESSOAS_ENDERECOS[2].UF           := qrImport.FieldByName('ESTADODOENDCOBRANCA'     ).AsString;
      CLI.PESSOAS_ENDERECOS[2].BAIRRO       := qrImport.FieldByName('BAIRROCOBRANCA'          ).AsString;
      CPF                                   := qrImport.FieldByName('NUMEROCPF'               ).AsString;
      CNPJ                                  :=qrImport.FieldByName('CGC'                     ).AsString;
      CLI.PESSOAS.CNPJ_CPF                  := IfThen(CNPJ='',CPF,CNPJ);
      CLI.PESSOAS.RG                        := qrImport.FieldByName('NUMERORG'                ).AsString;
      CLI.PESSOAS.INSCR_ESTADUAL            := qrImport.FieldByName('INSCRICAOESTADUAL'       ).AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE     := qrImport.FieldByName('NUMEROTELEFONE'          ).AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX          := qrImport.FieldByName('NUMEROFAX'               ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODTRANSPORTADORA'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO'        ).AsString;
      CLI.CLIENTES.PERC_DESCONTO_VENDA      := qrImport.FieldByName('PORCDEDESCONTO'          ).AsFloat;
      CLI.CLIENTES.LIMITE_CREDITO           := qrImport.FieldByName('LIMITEDECREDITO'         ).AsFloat;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOTAFISCALULTCOMPRA'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADAULTIMACOMPRA'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALORDAULTIMACOMPRA'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADOMAIORATRASO'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MAIORATRASO'             ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADOCADASTRO'          ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADACONSTITUICAO'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODIGOABC'               ).AsString;
      CLI.CLIENTES.FLAG_OUTROS              := StrToInt(IfThen(qrImport.FieldByName('RESTRICAODEVENDA').AsString='T','1','0'));
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODDOREPRESENTANTE'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMEDOCOMPRADOR'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('POTENCIALDEVENDA'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA1'                 ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA2'                 ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA3'                 ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA4'                 ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA5'                 ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA6'                 ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FREQUENCIADEVISITA'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMEALTERNATIVO'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CONSUMIDORFINAL'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('GRUPODEFORNECEDOR'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DESCONTOCOMPLEMENTO'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SENHATELEVENDAS'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VENDASOAVISTA'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO1'              ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO1'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF1'                    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO2'              ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO2'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF2'                    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO3'              ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO3'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF3'                    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO4'              ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO4'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF4'                    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO5'              ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO5'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF5'                    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO6'              ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO6'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF6'                    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATAULTIMOCATALOGO'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAODESCONTO'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('METRAGEMDEEXPOSICAO'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALOREMINVESTIMENTO'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPODECONTA'             ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('GRANDESCONTAS'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPODECLIENTE'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MEDIAULTIMOS4MESES'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MEDIAULTIMOS12MESES'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBJETIVODEVENDA'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TAMANHODOPDV'            ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBJETIVOPRECOMEDIO'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPOTRANSPORTE'          ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PAIS'                    ).AsString;
      CLI.PESSOAS.EMAIL                     := qrImport.FieldByName('ENDERECOEMAIL'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RECADASTRADO'            ).AsString;
      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO  := qrImport.FieldByName('CONTATOPRINCIPAL'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREACONTATOPRINCIPAL'    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOCONTATOPRINCIPAL'   ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECONTATOPRINCIPAL'    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIACONTATOPRINC' ).AsString;	
//      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO:= qrImport.FieldByName('CONTATOOPCIONAL'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREACONTATOOPCIONAL'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOCONTATOOPCIONAL'    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECONTATOOPCIONAL'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIOCONTATOOP'    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CONTATOMARKETING'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREAMARKETING'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOMARKETING'          ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEMARKETING'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIOMARKETING'    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MARKETINGOPCIONAL'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREAMARKETINGOP'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOMARKETINGOP'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEMARKETINGOP'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIOMARKETINGOP'  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CATEGORIADOCLIENTE'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('QTDADEDELOJAS'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CENTRALDECOMPRAS'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('QTDADEBALCONISTA'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREADEEXPOSICAO'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COBRANCABANCARIA'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL1'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL2'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL3'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL4'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL5'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL6'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('HOMEPAGE'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPOFORNECIMENTO'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('STATUS'                  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MOTIVODESQUALIFICACAO'   ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZO'                   ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TAXAFINANCEIRA'          ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DESCONTO'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('QUALIDADEDOATENDIMENTO'  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SISTEMAQUALIDADE'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SISTEMAQUALIDADEOUTROS'  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR1'             ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR1'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR2'             ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR2'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR3'             ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR3'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR4'             ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR4'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE1'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE1'            ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE2'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE2'            ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE3'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE3'            ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE4'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE4'            ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('REFERENCIABANCARIA'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('APROVADO'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATARECADASTRO'          ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TRANSFERIDOSAC'          ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CIFFOB'                  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CAPITALIZACAOSOCIAL'     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOEMISSAONF'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL1'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL2'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL3'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL4'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL5'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL6'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CONTACC'                 ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SUBCONTACC'              ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FLAG'                    ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IQ'                      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IP'                      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IQF'                     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IQP'                     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('P'                       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NQA'                     ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CATEGORIA'               ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALIDADEAVALIACAO'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('USUARIOALTERACAO'        ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALORCREDITO'            ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO2'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO3'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AVALIARPERFORMANCE'      ).AsString;
      CLI.PESSOAS.HISTORICO                 := qrImport.FieldByName('ANOTACAO'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DIASPAGAMENTO'           ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('REGIME'                  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NIVEL'                   ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATAMAIORCOMPRA'         ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALORMAIORCOMPRA'        ).AsString;
      CLI.PESSOAS_ENDERECOS[1].COMPLEMENTO  := qrImport.FieldByName('COMPLEMENTO'             ).AsString;
      CLI.PESSOAS.INSCR_MUNICIPAL           := qrImport.FieldByName('INSCRICAOMUNICIPAL'      ).AsString;
      CLI.PESSOAS.SUFRAMA                   := qrImport.FieldByName('SUFRAMA'                 ).AsString;
      CLI.PESSOAS_ENDERECOS[1].NUMERO       := qrImport.FieldByName('NUMERO'                  ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RETENCAODEIMPOSTOS'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODSEGMENTO'             ).AsString;
//      CLI.PESSOAS.EMAIL                   := qrImport.FieldByName('EMAILNFE'                ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODREGIAO'               ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO4'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO5'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO6'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO7'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO8'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO9'       ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO10'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO11'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO12'      ).AsString;
//      CLI.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NUMEROTELEFONECOBRANCA'  ).AsString;
      CLI.AppendOrEdit;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    CLI.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmATENA.butFornecedoresClick(Sender: TObject);
var
  FORN: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
  CPF: String;
  CNPJ: String;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_CLIENTES WHERE IDENTIFICACAO = ''F''');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;       
    Gauge1.Progress:=0;
    FORN:=TCadastro_Pessoas.Create;
    FORN.TIPO_CADASTRO:=2;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      FORN.PESSOAS.OBS_PESSOA                := qrImport.FieldByName('OBSERVACAO'              ).AsString;	
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAOATENDIMENTO'   ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAOQUALIDADE'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAOSERASA'        ).AsString;
      FORN.PESSOAS.CHAVE_OLD                 := qrImport.FieldByName('CODIGO'                  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IDENTIFICACAO'           ).AsString;
      FORN.PESSOAS.RAZAO_SOCIAL              := qrImport.FieldByName('RAZAOSOCIAL'             ).AsString;
      FORN.PESSOAS.FLAG_ATIVO                := StrToInt(IfThen(qrImport.FieldByName('CLIENTEINATIVO').AsString='F','1','0'));
      FORN.PESSOAS.NOME_FANTASIA             := qrImport.FieldByName('NOMEFANTASIA'            ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODRAMOATIVIDADE'        ).AsString;
      FORN.PESSOAS_ENDERECOS[1].ENDERECO     := qrImport.FieldByName('ENDERECO'                ).AsString;
      FORN.PESSOAS_ENDERECOS[1].BAIRRO       := qrImport.FieldByName('BAIRRO'                  ).AsString;
      FORN.PESSOAS_ENDERECOS[1].NOME_MUNIC   := qrImport.FieldByName('MUNICIPIO'               ).AsString;
      FORN.PESSOAS_ENDERECOS[1].CEP          := qrImport.FieldByName('CEP'                     ).AsString;
      FORN.PESSOAS_ENDERECOS[1].UF           := qrImport.FieldByName('ESTADO'                  ).AsString;
      FORN.PESSOAS_ENDERECOS[2].Create;
      FORN.PESSOAS_ENDERECOS[2].ENDERECO     := qrImport.FieldByName('ENDERECODECOBRANCA'      ).AsString;
      FORN.PESSOAS_ENDERECOS[2].NOME_MUNIC   := qrImport.FieldByName('MUNICIPIOENDCOBRANCA'    ).AsString;
      FORN.PESSOAS_ENDERECOS[2].CEP          := qrImport.FieldByName('CEPDOENDCOBRANCA'        ).AsString;
      FORN.PESSOAS_ENDERECOS[2].UF           := qrImport.FieldByName('ESTADODOENDCOBRANCA'     ).AsString;
      FORN.PESSOAS_ENDERECOS[2].BAIRRO       := qrImport.FieldByName('BAIRROCOBRANCA'          ).AsString;
      CPF                                    := qrImport.FieldByName('NUMEROCPF'               ).AsString;
      CNPJ                                   := qrImport.FieldByName('CGC'                     ).AsString;
      FORN.PESSOAS.CNPJ_CPF                  := IfThen(CNPJ='',CPF,CNPJ);
      FORN.PESSOAS.RG                        := qrImport.FieldByName('NUMERORG'                ).AsString;
      FORN.PESSOAS.INSCR_ESTADUAL            := qrImport.FieldByName('INSCRICAOESTADUAL'       ).AsString;
      FORN.PESSOAS_ENDERECOS[1].TELEFONE     := qrImport.FieldByName('NUMEROTELEFONE'          ).AsString;
      FORN.PESSOAS_ENDERECOS[1].FAX          := qrImport.FieldByName('NUMEROFAX'               ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODTRANSPORTADORA'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO'        ).AsString;
//      FORN.CLIENTES.PERC_DESCONTO_VENDA      := qrImport.FieldByName('PORCDEDESCONTO'          ).AsFloat;
//      FORN.CLIENTES.LIMITE_CREDITO           := qrImport.FieldByName('LIMITEDECREDITO'         ).AsFloat;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOTAFISCALULTCOMPRA'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADAULTIMACOMPRA'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALORDAULTIMACOMPRA'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADOMAIORATRASO'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MAIORATRASO'             ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADOCADASTRO'          ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATADACONSTITUICAO'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODIGOABC'               ).AsString;
//      FORN.CLIENTES.FLAG_OUTROS              := StrToInt(IfThen(qrImport.FieldByName('RESTRICAODEVENDA').AsString='T','1','0'));
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODDOREPRESENTANTE'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMEDOCOMPRADOR'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('POTENCIALDEVENDA'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA1'                 ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA2'                 ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA3'                 ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA4'                 ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA5'                 ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COMPRA6'                 ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FREQUENCIADEVISITA'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMEALTERNATIVO'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CONSUMIDORFINAL'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('GRUPODEFORNECEDOR'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DESCONTOCOMPLEMENTO'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SENHATELEVENDAS'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VENDASOAVISTA'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO1'              ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO1'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF1'                    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO2'              ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO2'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF2'                    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO3'              ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO3'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF3'                    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO4'              ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO4'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF4'                    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO5'              ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO5'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF5'                    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NOMESOCIO6'              ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PARTICIPACAO6'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CPF6'                    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATAULTIMOCATALOGO'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBSERVACAODESCONTO'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('METRAGEMDEEXPOSICAO'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALOREMINVESTIMENTO'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPODECONTA'             ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('GRANDESCONTAS'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPODECLIENTE'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MEDIAULTIMOS4MESES'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MEDIAULTIMOS12MESES'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBJETIVODEVENDA'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TAMANHODOPDV'            ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('OBJETIVOPRECOMEDIO'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPOTRANSPORTE'          ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PAIS'                    ).AsString;
      FORN.PESSOAS.EMAIL                     := qrImport.FieldByName('ENDERECOEMAIL'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RECADASTRADO'            ).AsString;
      FORN.PESSOAS_CONTATOS[1].DESC_CONTATO  := qrImport.FieldByName('CONTATOPRINCIPAL'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREACONTATOPRINCIPAL'    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOCONTATOPRINCIPAL'   ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECONTATOPRINCIPAL'    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIACONTATOPRINC' ).AsString;	
//      FORN.PESSOAS_CONTATOS[1].DESC_CONTATO:= qrImport.FieldByName('CONTATOOPCIONAL'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREACONTATOOPCIONAL'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOCONTATOOPCIONAL'    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECONTATOOPCIONAL'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIOCONTATOOP'    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CONTATOMARKETING'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREAMARKETING'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOMARKETING'          ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEMARKETING'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIOMARKETING'    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MARKETINGOPCIONAL'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREAMARKETINGOP'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CARGOMARKETINGOP'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEMARKETINGOP'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('ANIVERSARIOMARKETINGOP'  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CATEGORIADOCLIENTE'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('QTDADEDELOJAS'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CENTRALDECOMPRAS'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('QTDADEBALCONISTA'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AREADEEXPOSICAO'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('COBRANCABANCARIA'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL1'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL2'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL3'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL4'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL5'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PREFERENCIALOCAL6'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('HOMEPAGE'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TIPOFORNECIMENTO'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('STATUS'                  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('MOTIVODESQUALIFICACAO'   ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZO'                   ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TAXAFINANCEIRA'          ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DESCONTO'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('QUALIDADEDOATENDIMENTO'  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SISTEMAQUALIDADE'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SISTEMAQUALIDADEOUTROS'  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR1'             ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR1'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR2'             ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR2'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR3'             ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR3'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FORNECEDOR4'             ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONEFORNECEDOR4'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE1'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE1'            ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE2'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE2'            ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE3'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE3'            ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CLIENTE4'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FONECLIENTE4'            ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('REFERENCIABANCARIA'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('APROVADO'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATARECADASTRO'          ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('TRANSFERIDOSAC'          ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CIFFOB'                  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CAPITALIZACAOSOCIAL'     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOEMISSAONF'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL1'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL2'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL3'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL4'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL5'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RESTRICAOLOCAL6'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CONTACC'                 ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('SUBCONTACC'              ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('FLAG'                    ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IQ'                      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IP'                      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IQF'                     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('IQP'                     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('P'                       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NQA'                     ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CATEGORIA'               ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALIDADEAVALIACAO'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('USUARIOALTERACAO'        ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALORCREDITO'            ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO2'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO3'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('AVALIARPERFORMANCE'      ).AsString;
      FORN.PESSOAS.HISTORICO                 := qrImport.FieldByName('ANOTACAO'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DIASPAGAMENTO'           ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('REGIME'                  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NIVEL'                   ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('DATAMAIORCOMPRA'         ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('VALORMAIORCOMPRA'        ).AsString;
      FORN.PESSOAS_ENDERECOS[1].COMPLEMENTO  := qrImport.FieldByName('COMPLEMENTO'             ).AsString;
      FORN.PESSOAS.INSCR_MUNICIPAL           := qrImport.FieldByName('INSCRICAOMUNICIPAL'      ).AsString;
      FORN.PESSOAS.SUFRAMA                   := qrImport.FieldByName('SUFRAMA'                 ).AsString;
      FORN.PESSOAS_ENDERECOS[1].NUMERO       := qrImport.FieldByName('NUMERO'                  ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('RETENCAODEIMPOSTOS'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODSEGMENTO'             ).AsString;
//      FORN.PESSOAS.EMAIL                   := qrImport.FieldByName('EMAILNFE'                ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('CODREGIAO'               ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO4'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO5'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO6'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO7'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO8'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO9'       ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO10'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO11'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('PRAZODEPAGAMENTO12'      ).AsString;
//      FORN.PESSOAS.CHAVE_OLD               := qrImport.FieldByName('NUMEROTELEFONECOBRANCA'  ).AsString;
      FORN.AppendOrEdit;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    FORN.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmATENA.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmATENA.butGruposProdutoClick(Sender: TObject);
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_GRUPOS_PRODUTO');
    qrImport.First;
    QR_GigaERP.Open('SELECT * FROM GRUPOS_PRODUTO');
    while not qrImport.Eof do
    begin
      QR_GigaERP.Append;
      QR_GigaERP.FieldByName('COD_GRUPO').AsInteger := qrImport.FieldByName('CODIGO').AsInteger;
      QR_GigaERP.FieldByName('DESC_GRUPO').AsString := qrImport.FieldByName('DESCRICAO').AsString;
      QR_GigaERP.FieldByName('PERC_MARGEM').AsFloat := 0;
      QR_GigaERP.Post;
      qrImport.Next;
    end;
    QR_GigaERP.ApplyUpdates();
    MessageRaul_AVISO('GRUPOS DE PRODUTOS IMPORTADOS COM SUCESSO.');
  end;
end;

procedure TfrmATENA.butProdutosClick(Sender: TObject);
var
  PROD: TCadastro_Produtos;
  QTD: Double;
  COD: Integer;
begin
  ConectaGiga;
  DM.qrImport.Open('SELECT * FROM IMPORT_PRODUTOS');
  dm.qrImport.Last;
  dm.qrImport.First;
  Gauge1.MaxValue:=dm.qrImport.RecordCount+1;
  Gauge1.Progress:=0;
  PROD:=TCadastro_Produtos.Create;
  PROD.Open;
  PROD.Cadastra_imposto_padrao;
//  PROD.Cadastra_Grupo_Padrão;
  COD:=0;
  PROD.CadastraRelacionamento(1,'CLASSE');
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    iNC(COD);
    PROD.PRODUTOS.COD_PRODUTO                := IntToStr(COD);
    PROD.PRODUTOS.DESC_PRODUTO               := dm.qrImport.FieldByName('DESCRICAO'            ).AsString;
    PROD.PRODUTOS.OBS                        := dm.qrImport.FieldByName('OBSERVACAO'           ).AsString;
    PROD.PRODUTOS_TABELA[1].TABELA_ITEM_DESC := dm.qrImport.FieldByName('CLASSE_DESC'          ).AsString;
    PROD.PRODUTOS.COD_GRUPO                  := dm.qrImport.FieldByName('GRUPO'                ).AsInteger;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('CLASSE'               ).AsString;
    PROD.PRODUTOS.CHAVE_OLD                  := dm.qrImport.FieldByName('CODIGO'               ).AsString;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE       := dm.qrImport.FieldByName('UNIDADE'              ).AsString;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO   := 0.00;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('ITEMDEESTOQUE'        ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('TIPODEPRODUTO'        ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('ALIQICMS'             ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('ALIQIPI'              ).AsString;
    PROD.PRODUTOS.COD_CLASS                  := dm.qrImport.FieldByName('CLASSIFICACAOFISCAL'  ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('NECESSIDADEINSPECAO'  ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('ITEMDESEGURANCA'      ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('LEADTIME'             ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('VALORIZACAO'          ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('DESCRICAORAPIDA'      ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('FORADELINHA'          ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('RECUPERAICMS'         ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('APROPRIACAODIRETA'    ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('BENSEATIVO'           ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('PRODUTOFISICO'        ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('UNIDADEDECOMPRA'      ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('FATORDECONVERSAO'     ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('PRODUTOESPECIAL'      ).AsString;
    PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO   := dm.qrImport.FieldByName('CODIGOEAN13'          ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('MODELO'               ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('QUANTPOREMBALAGEM'    ).AsString;
    PROD.PRODUTOS.PESO_BRUTO                 := dm.qrImport.FieldByName('PESOBRUTOPOREMBALAGEM').AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('PORCCOMISSAO'         ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('CODIGONBM'            ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('CODFORNECEDOR'        ).AsString;
    PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO   := dm.qrImport.FieldByName('CODIGOINTERNO'        ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('CODIGOLINHA'          ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('FLAG'                 ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('CRITICIDADE'          ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('UNIDADEDEMEDIDA'      ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('PRODUTORASTREADO'     ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('CAVIDADE'             ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('TEMPOCICLO'           ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('TEMPOCUSTO'           ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('PESO'                 ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('ESTIMATIVA'           ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('MARGEMDELUCRO'        ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO              := dm.qrImport.FieldByName('IMAGEM'               ).AsString;
    PROD.AppendOrEdit;
    dm.qrImport.Next;
  end;
  PROD.ApplyUpdates;
  Gauge1.Progress:=Gauge1.MaxValue;
  MessageRaul_AVISO('PROCESSO CONCLUIDO...');
  Gauge1.Progress:=0;
end;

procedure TfrmATENA.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmATENA.butTransportadorasClick(Sender: TObject);
var
  TRANS: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_TRANSPORTADORAS');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;
    Gauge1.Progress:=0;
    TRANS:=TCadastro_Pessoas.Create;
    TRANS.TIPO_CADASTRO:=3;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      TRANS.PESSOAS.CHAVE_OLD                := qrImport.FieldByName('CODIGO'           ).AsString;
      TRANS.PESSOAS.RAZAO_SOCIAL             := qrImport.FieldByName('RAZAOSOCIAL'      ).AsString;
      TRANS.PESSOAS_ENDERECOS[1].ENDERECO    := qrImport.FieldByName('ENDERECO'         ).AsString;
      TRANS.PESSOAS_ENDERECOS[1].BAIRRO      := qrImport.FieldByName('BAIRRO'           ).AsString;
      TRANS.PESSOAS_ENDERECOS[1].NOME_MUNIC  := qrImport.FieldByName('MUNICIPIO'        ).AsString;
      TRANS.PESSOAS_ENDERECOS[1].CEP         := qrImport.FieldByName('CEP'              ).AsString;
      TRANS.PESSOAS_ENDERECOS[1].UF          := qrImport.FieldByName('ESTADO'           ).AsString;
      TRANS.PESSOAS.INSCR_ESTADUAL           := qrImport.FieldByName('INSCRICAOESTADUAL').AsString;
      TRANS.PESSOAS.CNPJ_CPF                 := qrImport.FieldByName('CGC'              ).AsString;
      TRANS.PESSOAS_ENDERECOS[1].TELEFONE    := qrImport.FieldByName('NUMEROTELEFONE'   ).AsString;
      TRANS.PESSOAS_ENDERECOS[1].FAX         := qrImport.FieldByName('NUMEROFAX'        ).AsString;
      TRANS.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('NOMEDOCONTATO'    ).AsString;
      TRANS.PESSOAS.EMAIL                    := qrImport.FieldByName('EMAIL'            ).AsString;
//      TRANS.PESSOAS.CHAVE_OLD              := qrImport.FieldByName('FLAG'             ).AsString;
      TRANS.PESSOAS.NOME_FANTASIA            := qrImport.FieldByName('NOMEFANTASIA'     ).AsString;
//      TRANS.PESSOAS.CHAVE_OLD              := qrImport.FieldByName('VINCULADO'        ).AsString;
      TRANS.AppendOrEdit;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    TRANS.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmATENA.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmATENA.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmATENA.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
