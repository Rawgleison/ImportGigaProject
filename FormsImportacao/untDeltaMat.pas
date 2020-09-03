unit untDeltaMat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids;
type
  TfrmDeltaMat = class(TForm)
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
  frmDeltaMat: TfrmDeltaMat;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmDeltaMat.butClientesClick(Sender: TObject);
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
    qrImport.Open('SELECT * FROM IMPORT_CLIENTES');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;

    Gauge1.Progress:=0;
    CLI:=TCadastro_Pessoas.Create;
    CLI.TIPO_CADASTRO:=1;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOME').AsString;
      CLI.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('FANTASIA').AsString;
      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO').AsString;
      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CNPJ').AsString;
      CLI.PESSOAS.CNPJ_CPF := IfThen(CLI.PESSOAS.CNPJ_CPF='',qrImport.FieldByName('CPF').AsString,CLI.PESSOAS.CNPJ_CPF);
      CLI.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('IE').AsString;
      CLI.PESSOAS.RG := qrImport.FieldByName('RG').AsString;
//      CLI.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('TELEFONE').AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('FAX').AsString;
      CLI.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('CELULAR').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('FIS_JUR').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TIPO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('VENDEDOR').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('LIMITE_CREDITO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('COD_CONVENIO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CONVENIO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('DIA_ACERTO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('PER_CONVENIO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('A_RECEBER').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CONCEDER_CREDITO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ATRASADO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('RECEBIDO').AsString;
      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('OBSERVACOES').AsString;
      CLI.PESSOAS.FLAG_ATIVO := qrImport.FieldByName('ATIVO').AsInteger;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('OPERADOR').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('COD_TABELA_PRECO').AsString;
      CLI.PESSOAS.SUFRAMA := qrImport.FieldByName('SUFRAMA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('USA_DESCONTO_SUFRAMA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('IDESTRANGEIRO').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO1').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDERECO').AsString;
      CLI.PESSOAS_ENDERECOS[1].COMPLEMENTO := qrImport.FieldByName('COMPLEMENTO').AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIRRO').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDADE').AsString;
      CLI.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF1').AsString;
      CLI.PESSOAS_ENDERECOS[2].ENDERECO := qrImport.FieldByName('ENDERECO_ENT').AsString;
      CLI.PESSOAS_ENDERECOS[2].COMPLEMENTO := qrImport.FieldByName('COMPLEMENTO_ENT').AsString;
      CLI.PESSOAS_ENDERECOS[2].BAIRRO := qrImport.FieldByName('BAIRRO_ENT').AsString;
      CLI.PESSOAS_ENDERECOS[2].CEP := qrImport.FieldByName('CEP_ENT').AsString;
      CLI.PESSOAS_ENDERECOS[2].NOME_MUNIC := qrImport.FieldByName('CIDADE_ENT').AsString;
      CLI.PESSOAS_ENDERECOS[2].UF := qrImport.FieldByName('UF_ENT').AsString;
      CLI.PESSOAS_ENDERECOS[1].NUMERO := qrImport.FieldByName('NUMERO').AsString;
      CLI.PESSOAS_ENDERECOS[2].NUMERO := qrImport.FieldByName('NUMERO_ENT').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('PAIS').AsString;
      CLI.PESSOAS_ENDERECOS[3].ENDERECO := qrImport.FieldByName('ENDERECO_COB').AsString;
      CLI.PESSOAS_ENDERECOS[3].NUMERO := qrImport.FieldByName('NUMERO_COB').AsString;
      CLI.PESSOAS_ENDERECOS[3].COMPLEMENTO := qrImport.FieldByName('COMPLEMENTO_COB').AsString;
      CLI.PESSOAS_ENDERECOS[3].BAIRRO := qrImport.FieldByName('BAIRRO_COB').AsString;
      CLI.PESSOAS_ENDERECOS[3].CEP := qrImport.FieldByName('CEP_COB').AsString;
      CLI.PESSOAS_ENDERECOS[3].NOME_MUNIC := qrImport.FieldByName('CIDADE_COB').AsString;
      CLI.PESSOAS_ENDERECOS[3].UF := qrImport.FieldByName('UF_COB').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO2').AsString;
      CLI.PESSOAS.EMAIL := qrImport.FieldByName('EMAIL').AsString;
      CLI.PESSOAS.SITE := qrImport.FieldByName('SITE').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ULTIMA_VENDA').AsString;
      CLI.CLIENTES.DATA_NASCIMENTO := qrImport.FieldByName('NASCIMENTO').AsDateTime;
//      CLI.CLIENTES.CHAVE_OLD := qrImport.FieldByName('NOME_PAI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('NOME_MAE').AsString;
      CLI.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('DATA_CADASTRO').AsDateTime;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('APELIDO').AsString;
      CLI.CLIENTES.TRAB_PROFISSAO := qrImport.FieldByName('PROFISSAO').AsString;
      CLI.CLIENTES.TRAB_LOCAL := qrImport.FieldByName('TELEFONE_RECADO').AsString;
      CLI.CLIENTES.CONJ_NOME := qrImport.FieldByName('CONJUGE').AsString;
      CLI.CLIENTES.NACIONALIDADE := qrImport.FieldByName('NATURALIDADE').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('DOC_UF').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('DOC_EXPEDIDOR').AsString;
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

procedure TfrmDeltaMat.butFornecedoresClick(Sender: TObject);
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
    qrImport.Open('SELECT * FROM IMPORT_FORNECEDORES');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;

    Gauge1.Progress:=0;
    FORN:=TCadastro_Pessoas.Create;
    FORN.TIPO_CADASTRO:=tpFORNECEDORES;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO').AsString;
      FORN.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOME').AsString;
      FORN.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('FANTASIA').AsString;
      FORN.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO').AsString;
      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CNPJ').AsString;
      FORN.PESSOAS.CNPJ_CPF := IfThen(FORN.PESSOAS.CNPJ_CPF='',qrImport.FieldByName('CPF').AsString,FORN.PESSOAS.CNPJ_CPF);
      FORN.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('IE').AsString;
      FORN.PESSOAS.RG := qrImport.FieldByName('RG').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('UF').AsString;
      FORN.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('TELEFONE').AsString;
      FORN.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('FAX').AsString;
      FORN.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('CELULAR').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('DIA_ACERTO').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('A_PAGAR').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ATRASADO').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('PAGO').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('JUROS').AsString;
      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('OBSERVACOES').AsString;
      FORN.PESSOAS.FLAG_ATIVO := qrImport.FieldByName('ATIVO').AsInteger;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('OPERADOR').AsString;
      FORN.PESSOAS.SUFRAMA := qrImport.FieldByName('SUFRAMA').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO1').AsString;
      FORN.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDERECO').AsString;
      FORN.PESSOAS_ENDERECOS[1].COMPLEMENTO := qrImport.FieldByName('COMPLEMENTO').AsString;
      FORN.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIRRO').AsString;
      FORN.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      FORN.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDADE').AsString;
      FORN.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF1').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('PAIS').AsString;
      FORN.PESSOAS_ENDERECOS[1].NUMERO := qrImport.FieldByName('NUMERO').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO2').AsString;
      FORN.PESSOAS.EMAIL := qrImport.FieldByName('EMAIL').AsString;
      FORN.PESSOAS.SITE := qrImport.FieldByName('SITE').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ULTIMA_COMPRA').AsString;
      FORN.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('DATA_CADASTRO').AsDateTime;
      FORN.PESSOAS_CONTATOS[1].TELEFONE := qrImport.FieldByName('TELEFONE_RECADO').AsString;
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

procedure TfrmDeltaMat.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmDeltaMat.butGruposProdutoClick(Sender: TObject);
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_GRUPOS_PRODUTOS');
    qrImport.First;
    QR_GigaERP.Open('SELECT * FROM GRUPOS_PRODUTO');
    while not qrImport.Eof do
    begin
      if QR_GigaERP.Locate('COD_GRUPO',qrImport.FieldByName('CODFAM').AsInteger,[]) then
        QR_GigaERP.Edit
      else
        QR_GigaERP.Append;
      QR_GigaERP.FieldByName('COD_GRUPO').AsInteger := qrImport.FieldByName('CODFAM').AsInteger;
      QR_GigaERP.FieldByName('DESC_GRUPO').AsString := qrImport.FieldByName('DESFAM').AsString;
      QR_GigaERP.FieldByName('PERC_MARGEM').AsFloat := 0;
      QR_GigaERP.Post;
      qrImport.Next;
    end;
    QR_GigaERP.ApplyUpdates();
    MessageRaul_AVISO('GRUPOS DE PRODUTOS IMPORTADOS COM SUCESSO.');
  end;
end;

procedure TfrmDeltaMat.butProdutosClick(Sender: TObject);
var
  PROD: TCadastro_Produtos;
  QTD: Double;
  COD: Integer;
  COD_GRADE: string;
  SQL: string;
begin
  ConectaGiga;
  DM.qrImport.Open('SELECT * FROM IMPORT_PRODUTOS');
  dm.qrImport.Last;
  dm.qrImport.First;
  Gauge1.MaxValue:=dm.qrImport.RecordCount+1;
  Gauge1.Progress:=0;
  PROD:=TCadastro_Produtos.Create;
  try
  PROD.Open;
  PROD.Cadastra_imposto_padrao;
//  PROD.Cadastra_Grupo_Padrão;
//  PROD.CadastraRelacionamento(1,'CLASSE');
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('CODEMP').AsString;
    PROD.PRODUTOS.COD_PRODUTO := Trim(dm.qrImport.FieldByName('CODPRO').AsString);
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESPRO').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('DESFAT').AsString;
    PROD.PRODUTOS.COD_GRUPO := dm.qrImport.FieldByName('CODFAM').AsInteger;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('CODORI').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('QTDESM').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('QTDDIM').AsString;
    PROD.PRODUTOS.PESO_BRUTO := dm.qrImport.FieldByName('PESBRU').AsFloat;
    PROD.PRODUTOS.PESO_LIQUIDO := dm.qrImport.FieldByName('PESLIQ').AsFloat;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('INDLOT').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('INDGRD').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('INDCNV').AsString;
    PROD.PRODUTOS.FLAG_ATIVO := StrToInt(IfThen(dm.qrImport.FieldByName('SITPRO').AsString='A','1','0'));
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('DATCAD').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('ORIPRO').AsString;
    PROD.PRODUTOS.COD_CLASS := dm.qrImport.FieldByName('NUMCLA').AsString;
    PROD.PRODUTOS.COD_IMPOSTO := StrToInt(IfThen(dm.qrImport.FieldByName('CODTRI').AsString='','1',dm.qrImport.FieldByName('CODTRI').AsString));
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('ENQIPI').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('CODCES').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('PERMRG').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('OBSPRO').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('INDSIN').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('CODITE').AsString;
//    PROD.PRODUTOS. := dm.qrImport.FieldByName('ALTREG').AsString;
    DM.qrImportAux.Close;
    SQL:='SELECT PG.*, '+
                        ' (select first 1 tab.vlruni from IMPORT_PRODUTOS_TAB_PRECOS_PROD TAB where TAB.CODPRO = PG.CODPRO AND TAB.CODITE = PG.CODITE) vlruni '+
                        'FROM IMPORT_PRODUTOS_GRADE PG WHERE PG.CODPRO ='+QuotedStr(PROD.PRODUTOS.COD_PRODUTO);
    DM.qrImportAux.Open(SQL);
    DM.qrImportAux.First;
    COD:=1;
    while not DM.qrImportAux.Eof do
    begin
      //Inc(COD);
      COD_GRADE:=Trim(DM.qrImportAux.FieldByName('CODITE').AsString);
      if COD_GRADE='' then
        raise Exception.Create('Erro de cod_grade vazio.');
//      PROD.PRODUTOS_GRADE[COD].IniciarVariaveis;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODEMP').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODPRO').AsString;
      PROD.PRODUTOS_GRADE[COD].COD_GRADE := cod_grade;
      PROD.PRODUTOS_GRADE[COD].OBS := DM.qrImportAux.FieldByName('CPLPRO').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CPLFAT').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('ITEGRD').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODGRD').AsString;
//      PROD.PRODUTOS_GRADE_UND[COD].IniciarVariaveis;
//      PROD.PRODUTOS_GRADE_UND[COD].COD_GRADE := PROD.PRODUTOS_GRADE[COD].COD_GRADE;
      PROD.PRODUTOS_GRADE_UND[COD].UNIDADE := DM.qrImportAux.FieldByName('CODUNI').AsString;
//      PROD.PRODUTOS_APELIDOS_PROD[COD].IniciarVariaveis;
//      PROD.PRODUTOS_APELIDOS_PROD[COD].COD_APELIDO := 2;
//      PROD.PRODUTOS_APELIDOS_PROD[COD].COD_GRADE := PROD.PRODUTOS_GRADE[COD].COD_GRADE;
      PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO := DM.qrImportAux.FieldByName('PRDECF').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('UNICNV').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODFAB').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PRDFAB').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODMCA').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODBAR').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('NUMBAR').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PRDCNV').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODANP').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PERGNP').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('INDMAE').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('INDEFC').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('INDEFV').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODAGR').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('QTDESM').AsString;
      PROD.PRODUTOS_GRADE[COD].ESTOQUE_MIN := DM.qrImportAux.FieldByName('QTDDIM').AsFloat;
      PROD.PRODUTOS_GRADE[COD].ESTOQUE_MAX := DM.qrImportAux.FieldByName('QTDMAX').AsFloat;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('DIMALT').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('DIMLAR').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('DIMCPM').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PESBRU').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PESLIQ').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PERLUC').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('QTDDGA').AsString;
//      PROD.PRODUTOS_CUSTO[COD].IniciarVariaveis;
//      PROD.PRODUTOS_CUSTO[COD].COD_GRADE := PROD.PRODUTOS_GRADE[COD].COD_GRADE;
      PROD.PRODUTOS_CUSTO[COD].PRECO_CUSTO := DM.qrImportAux.FieldByName('PRECUI').AsFloat;
//      PROD.PRODUTOS_TAB_PRECOS_PROD[COD].IniciarVariaveis;
//      PROD.PRODUTOS_TAB_PRECOS_PROD[COD].COD_TABELA:=1;
//      PROD.PRODUTOS_TAB_PRECOS_PROD[COD].COD_GRADE := PROD.PRODUTOS_GRADE[COD].COD_GRADE;
      PROD.PRODUTOS_TAB_PRECOS_PROD[COD].PRECO := DM.qrImportAux.FieldByName('VLRUNI').AsFloat;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('DATCUI').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PRECUS').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('DATCUS').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PREMED').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('DATMED').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('FATPRE').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODPRP').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODITP').AsString;
      PROD.PRODUTOS_GRADE[COD].FLAG_ATIVO := StrToInt(IfThen(DM.qrImportAux.FieldByName('SITITE').AsString='A','1','0'));
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('ULTLOT').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('DATCAD').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('CODTRI').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('PERMRG').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('OBSITE').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('OBSDER').AsString;
//      PROD.PRODUTOS_GRADE[COD].COD_GRADE := DM.qrImportAux.FieldByName('QTDVEN').AsString;
        PROD.AppendOrEdit;
      DM.qrImportAux.Next;
    end;
    dm.qrImport.Next;
    Application.ProcessMessages;
  end;
  PROD.ApplyUpdates;
  Gauge1.Progress:=Gauge1.MaxValue;
  MessageRaul_AVISO('PROCESSO CONCLUIDO...');
  Gauge1.Progress:=0;
  finally
    PROD.Free;
  end;
end;

procedure TfrmDeltaMat.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmDeltaMat.butTransportadorasClick(Sender: TObject);
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

procedure TfrmDeltaMat.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmDeltaMat.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmDeltaMat.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
