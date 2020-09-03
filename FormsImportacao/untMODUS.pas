unit untMODUS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids;
type
  TfrmMODUS = class(TForm)
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
    edtImpostoTrib: TLabeledEdit;
    edtImpostoST: TLabeledEdit;
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
  frmMODUS: TfrmMODUS;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmMODUS.butClientesClick(Sender: TObject);
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
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEMP').AsString;
      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODPES').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPPES').AsString;
      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CGCCPF').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('DESPES').AsString;
      CLI.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('DESABV').AsString;
      CLI.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('INSEST').AsString;
      CLI.PESSOAS.INSCR_MUNICIPAL := qrImport.FieldByName('INSMUN').AsString;
      CLI.PESSOAS.RG := qrImport.FieldByName('DOCPES').AsString;
//      CLI.CLIENTES.DATA_NASCIMENTO := qrImport.FieldByName('DATNAS').AsString;
      CLI.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('DATCAD').AsDateTime;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('SITPES').AsString;
      CLI.CLIENTES.SEXO := StrToInt(IfThen(qrImport.FieldByName('SEXPES').AsString='F','1','0'));
      CLI.CLIENTES.CONJ_ESTADO_CIVIL := IfThen(qrImport.FieldByName('ESTCIV').AsString='2','Casado(a)','Solteiro(a)');
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODRLG').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODTPT').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODCNA').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('INDRTR').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODDIG').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('ALTREG').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEND').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPEND').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEPEND').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODCID').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODLGR').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODBAI').AsString;
      CLI.PESSOAS_ENDERECOS[1].NUMERO := qrImport.FieldByName('NUMEND').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMCOM').AsString;
      CLI.PESSOAS_ENDERECOS[1].COMPLEMENTO := qrImport.FieldByName('COMEND').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMCXP').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODTPL').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESTPL').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('ABRTPL').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('NOMLOG').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESLOG').AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('DESBAI').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('ABRBAI').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODPAI').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEST').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESCID').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CEPINI').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CEPFIM').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESEST').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('SIGEST').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESPAI').AsString;
      CLI.PESSOAS_ENDERECOS[1].COD_MUNIC := qrImport.FieldByName('CODRAI').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODFON').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('CODDDD').AsString+qrImport.FieldByName('NUMFN1').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFN1').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMRM1').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFN2').AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('CODDDD').AsString+qrImport.FieldByName('NUMFN2').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMRM2').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFN3').AsString;
      CLI.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('CODDDD').AsString+qrImport.FieldByName('NUMFN3').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMRM3').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEML').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPEML').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESEML').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODHTM').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPHTM').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESHTM').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODFOT').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('IMGFOT').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESFOT').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFOT').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODLGO').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('IMGLGO').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESLGO').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPLGO').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODTPS').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESTPS').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('IDEINT').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODCLI').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODREP').AsString;
//      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODSFR').AsString;
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

procedure TfrmMODUS.butFornecedoresClick(Sender: TObject);
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
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEMP').AsString;
      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODPES').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPPES').AsString;
      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CGCCPF').AsString;
      FORN.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('DESPES').AsString;
      FORN.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('DESABV').AsString;
      FORN.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('INSEST').AsString;
      FORN.PESSOAS.INSCR_MUNICIPAL := qrImport.FieldByName('INSMUN').AsString;
      FORN.PESSOAS.RG := qrImport.FieldByName('DOCPES').AsString;
//      FORN.CLIENTES.DATA_NASCIMENTO := qrImport.FieldByName('DATNAS').AsString;
      FORN.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('DATCAD').AsDateTime;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('SITPES').AsString;
//      FORN.CLIENTES.SEXO := StrToInt(IfThen(qrImport.FieldByName('SEXPES').AsString='F','1','0'));
//      FORN.CLIENTES.CONJ_ESTADO_CIVIL := IfThen(qrImport.FieldByName('ESTCIV').AsString='2','Casado(a)','Solteiro(a)');
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODRLG').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODTPT').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODCNA').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('INDRTR').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODDIG').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('ALTREG').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEND').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPEND').AsString;
      FORN.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEPEND').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODCID').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODLGR').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODBAI').AsString;
      FORN.PESSOAS_ENDERECOS[1].NUMERO := qrImport.FieldByName('NUMEND').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMCOM').AsString;
      FORN.PESSOAS_ENDERECOS[1].COMPLEMENTO := qrImport.FieldByName('COMEND').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMCXP').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODTPL').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESTPL').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('ABRTPL').AsString;
      FORN.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('NOMLOG').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESLOG').AsString;
      FORN.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('DESBAI').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('ABRBAI').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODPAI').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEST').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESCID').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CEPINI').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CEPFIM').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESEST').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('SIGEST').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESPAI').AsString;
      FORN.PESSOAS_ENDERECOS[1].COD_MUNIC := qrImport.FieldByName('CODRAI').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODFON').AsString;
      FORN.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('CODDDD').AsString+qrImport.FieldByName('NUMFN1').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFN1').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMRM1').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFN2').AsString;
      FORN.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('CODDDD').AsString+qrImport.FieldByName('NUMFN2').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMRM2').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFN3').AsString;
      FORN.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('CODDDD').AsString+qrImport.FieldByName('NUMFN3').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('NUMRM3').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODEML').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPEML').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESEML').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODHTM').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPHTM').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESHTM').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODFOT').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('IMGFOT').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESFOT').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPFOT').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODLGO').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('IMGLGO').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESLGO').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('TIPLGO').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODTPS').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('DESTPS').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('IDEINT').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODCLI').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODREP').AsString;
//      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('CODSFR').AsString;
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

procedure TfrmMODUS.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmMODUS.butGruposProdutoClick(Sender: TObject);
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_GRUPOS_PRODUTO');
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

procedure TfrmMODUS.butProdutosClick(Sender: TObject);
var
  PROD: TCadastro_Produtos;
  QTD: Double;
  COD: Integer;
  COD_GRADE: string;
  SQL: string;
  ImpSub, ImpST: Integer;
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
  PROD.Cadastra_imposto_padrao('2','SUBSTITUIÇÃO TRIBUTARIA');
  PROD.Cadastra_NCM_99;
//  PROD.Cadastra_Grupo_Padrão;
//  PROD.CadastraRelacionamento(1,'CLASSE');

  ImpSub:=StrToInt(edtImpostoTrib.Text);
  ImpST:=StrToInt(edtImpostoST.Text);
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
    if dm.qrImport.FieldByName('CODTRI').AsString = edtImpostoTrib.Text then PROD.PRODUTOS.COD_IMPOSTO := 1
    else PROD.PRODUTOS.COD_IMPOSTO := 2;
//    PROD.PRODUTOS.COD_IMPOSTO := StrToInt(IfThen(dm.qrImport.FieldByName('CODTRI').AsString='','1',dm.qrImport.FieldByName('CODTRI').AsString));
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
      PROD.PRODUTOS_GRADE.COD_GRADE := cod_grade;
      PROD.PRODUTOS_GRADE.OBS := DM.qrImportAux.FieldByName('CPLPRO').AsString;
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
      PROD.PRODUTOS_GRADE.ESTOQUE_MIN := DM.qrImportAux.FieldByName('QTDDIM').AsFloat;
      PROD.PRODUTOS_GRADE.ESTOQUE_MAX := DM.qrImportAux.FieldByName('QTDMAX').AsFloat;
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
      PROD.PRODUTOS_GRADE.FLAG_ATIVO := StrToInt(IfThen(DM.qrImportAux.FieldByName('SITITE').AsString='A','1','0'));
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

procedure TfrmMODUS.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmMODUS.butTransportadorasClick(Sender: TObject);
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

procedure TfrmMODUS.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmMODUS.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmMODUS.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
