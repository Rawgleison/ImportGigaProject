unit untSigma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids, Vcl.CheckLst;
type
  TfrmSigma = class(TForm)
    Panel1: TPanel;
    Gauge1: TGauge;
    Label1: TLabel;
    vleConexao: TValueListEditor;
    butGravar: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    butImport: TButton;
    Memo1: TMemo;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butGravarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure butImportClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure ConectaGiga;
    procedure CLIENTES;
    procedure FORNECEDORES;
    procedure TRANSPORTADORAS;
    procedure GRUPOS_PRODUTOS;
    procedure PRODUTOS;
    procedure MARCAS;
    procedure PESSOAS; //QUANDO O MESMO CADASTRO PODE SER CLIENTE, FORNECEDOR E/OU TRANSPORTADORA
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSigma: TfrmSigma;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmSigma.CLIENTES;
var
  CLI: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
  CPF: String;
  CNPJ: String;
  DATATMP: String;
begin
  with DM do
  begin
    ConectaGiga;
//    qrImport.Open('SELECT * FROM IMPORT_CLIENTES');
    qrImport.Open('select '
                  +'    cli.*, '
                  +'    cliend.* '
                  +'from import_clientes cli '
                  +'left join import_clientes_enderecos cliend on '
                  +'(cliend.nr_cl = cli.nr_cl)'
                  +'where cli.nr_cl > 10000');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;

    Gauge1.Progress:=0;
    CLI:=TCadastro_Pessoas.Create;
    CLI.TIPO_CADASTRO:=1;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);
      CLI.PESSOAS.COD_PESSOA  := qrImport.FieldByName('NR_CL').AsInteger;
      CLI.PESSOAS.NOME_FANTASIA  := qrImport.FieldByName('ABREV').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL  := qrImport.FieldByName('NOME').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('LOC_FATU').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('LOC_COBR').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('LOC_ENTR').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('NR_GR').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('NR_VD').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('NR_IN').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CL_IN').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('NR_FO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('LST_PRECO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CLASSE').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT11').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT12').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT21').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT22').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT31').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT32').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT41').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT42').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT51').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TIT52').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('COMENTARIO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CP').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('ULTVENDA').AsString;
      CLI.PESSOAS.DATA_CADASTRO  := qrImport.FieldByName('DT_CAD').AsDateTime;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CREDITO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('BANCO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('REGIAO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CONSUMO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('VALCRED').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('COMCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('FATOR').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CTSERASA').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CTVALIDO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CTDIA').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CTVALOR').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CTTPDOC').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CTCATEG').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('CTOBS').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('SUFRAMA').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('INSCRMUN').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('OPTSIMPL').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('PRODRURAL').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('LOJA').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('NAT').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('NR_CL').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('LOCAL').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO  := qrImport.FieldByName('ENDERECO').AsString;
      CLI.PESSOAS_ENDERECOS[1].COMPLEMENTO  := qrImport.FieldByName('COMPL').AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC  := qrImport.FieldByName('CIDADE').AsString;
      CLI.PESSOAS_ENDERECOS[1].UF  := qrImport.FieldByName('ESTADO').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP  := qrImport.FieldByName('CEP').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE  := qrImport.FieldByName('FONE').AsString;
      CLI.PESSOAS.CNPJ_CPF  := CoalesceStr(qrImport.FieldByName('CGC').AsString,qrImport.FieldByName('CIC').AsString);
      CLI.PESSOAS.INSCR_ESTADUAL  := qrImport.FieldByName('IE').AsString;
      CLI.PESSOAS.RG  := qrImport.FieldByName('RG').AsString;
//      CLI.CLIENTES.DATA_NASCIMENTO  := qrImport.FieldByName('DT_NASC').AsDateTime;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TELEX').AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX  := qrImport.FieldByName('FAX').AsString;
      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO  := qrImport.FieldByName('CONTATO').AsString;
      CLI.PESSOAS.OBS_PESSOA  := qrImport.FieldByName('CONTATO1').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('NR_TR').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('ICM').AsString;
      CLI.PESSOAS.EMAIL  := qrImport.FieldByName('OBS').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('TANQUE').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('FILTRO').AsString;
//      CLI.PESSOAS.CHAVE_OLD  := qrImport.FieldByName('BOMBA').AsString;
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

procedure TfrmSigma.FORNECEDORES;
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
      FORN.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIRRO').AsString;
//      FORN.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('C_CONTATO').AsString;
      FORN.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('CADASTRO').AsDateTime;
      FORN.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CGC').AsString;
      FORN.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDADE').AsString;
      FORN.PESSOAS_ENDERECOS[1].COMPLEMENTO := qrImport.FieldByName('COMPLEM').AsString;
      FORN.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('FANTASIA').AsString;
      FORN.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('FAX1').AsString;
      FORN.PESSOAS_CONTATOS[1].FAX := qrImport.FieldByName('FAX2').AsString;
      FORN.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('FONE1').AsString;
      FORN.PESSOAS_CONTATOS[1].TELEFONE := qrImport.FieldByName('FONE2').AsString;
      FORN.FORNECEDORES.CHAVE_OLD := qrImport.FieldByName('ID_FORN').AsInteger;
      FORN.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('INS_EST').AsString;
      FORN.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('N_CONTATO').AsString;
      FORN.PESSOAS_ENDERECOS[1].NUMERO := qrImport.FieldByName('NUMERO').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('PAIS').AsString;
      FORN.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('RAZAO_SOC').AsString;
      FORN.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('RUA').AsString;
      FORN.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF').AsString;
      FORN.PESSOAS.EMAIL := qrImport.FieldByName('EMAIL').AsString;
      FORN.PESSOAS.SITE := qrImport.FieldByName('HOMEPAGE').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('FOTO').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('BANCO1').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('AGENCIA1').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('NUMCONTA1').AsString;
      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('OBS1').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('BANCO2').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('AGENCIA2').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('NUMCONTA2').AsString;
      FORN.PESSOAS.HISTORICO := qrImport.FieldByName('OBS2').AsString;
//      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TRANSPORT').AsString;
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

procedure TfrmSigma.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmSigma.GRUPOS_PRODUTOS;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_GRUPOS_PRODUTO');
    qrImport.First;
    QR_GigaERP.Open('SELECT * FROM GRUPOS_PRODUTO');
    while not qrImport.Eof do
    begin
      if QR_GigaERP.Locate('COD_GRUPO',qrImport.FieldByName('CODIGO').AsInteger,[]) then
        QR_GigaERP.Edit
      else
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

procedure TfrmSigma.MARCAS;
begin
  with DM do
  begin
    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO)'+
                                 'VALUES (1, ''MARCA'')'+
                               'MATCHING (COD_TABELA);');
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_MARCAS');
    qrImport.First;
    QR_GigaERP.Open('SELECT * FROM TABELA_DO_SISTEMA_ITEM');
    while not qrImport.Eof do
    begin
      if QR_GigaERP.Locate('COD_TABELA;COD_TABELA_ITEM',VarArrayOf([1,qrImport.FieldByName('CODIGO').AsInteger]),[]) then
        QR_GigaERP.Edit
      else
        QR_GigaERP.Append;
      QR_GigaERP.FieldByName('COD_TABELA').AsFloat := 1;
      QR_GigaERP.FieldByName('COD_TABELA_ITEM').AsInteger := qrImport.FieldByName('CODIGO').AsInteger;
      QR_GigaERP.FieldByName('DESCRICAO').AsString := qrImport.FieldByName('MARCA').AsString;
      QR_GigaERP.Post;
      qrImport.Next;
    end;
    QR_GigaERP.ApplyUpdates();
    MessageRaul_AVISO('MARCAS DE PRODUTOS IMPORTADO COM SUCESSO.');
  end;
end;

procedure TfrmSigma.PESSOAS;
var
  PES: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
  CPF: String;
  CNPJ: String;
  COD_PESSOA: String;
  CIDADE: String;
  UF: String;
  COD_TABELA: String;
  COD_TABELA_ITEM: String;
  DESC_TABELA_ITEM: String;
  DESC_TABELA: String;
  I: Integer;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_CLIENTES_FORNECEDORES');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;

    Gauge1.Progress:=0;
    PES:=TCadastro_Pessoas.Create;
    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO) VALUES (1, ''TIPO FORNECEDOR'') MATCHING (COD_TABELA);');
    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO) VALUES (2, ''GRUPO TIPO FORNECEDOR'') MATCHING (COD_TABELA);');
    while not qrImport.Eof do
    begin
      PES.TIPO_CADASTRO:=1;
      Gauge1.AddProgress(1);
      Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);
      COD_PESSOA:= qrImport.FieldByName('RAZAO_SOCIAL').AsString;
      COD_PESSOA:= Copy(COD_PESSOA,0,pos('-',COD_PESSOA)-1);
      ShowMessage(COD_PESSOA);
      PES.PESSOAS.CNPJ_CPF := COD_PESSOA;
      PES.PESSOAS.CNPJ_CPF := StringReplace(qrImport.FieldByName('RAZAO_SOCIAL').AsString,COD_PESSOA+' - ','',[]);
      PES.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('NOME_FANTASIA').AsString;
      PES.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('IE_RG').AsString;
//      PES.PESSOAS.CNPJ_CPF := qrImport.FieldByName('IE_SERVICO').AsString;
//      PES.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TIPO_COBRANCA').AsString;
      PES.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDERECO').AsString;

      CIDADE:= qrImport.FieldByName('CIDADE').AsString;
      UF:=Copy(CIDADE,Pos('/',CIDADE)+1,3);
      CIDADE:= Copy(CIDADE,pos('-',CIDADE)+1,Pos('/',CIDADE)-pos('-',CIDADE));
      PES.PESSOAS_ENDERECOS[1].NOME_MUNIC := Trim(CIDADE) ;
      PES.PESSOAS_ENDERECOS[1].UF := Trim(UF) ;

      PES.PESSOAS_ENDERECOS[1].COMPLEMENTO := qrImport.FieldByName('COMPL').AsString;
      PES.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CPNJ_CPF').AsString;
      PES.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO').AsString;
      PES.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('TEL_COM').AsString;
      PES.PESSOAS.EMAIL := qrImport.FieldByName('EMAIL').AsString;
      PES.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      PES.AppendOrEdit;

      //RELACIONAMENTO
      for I := 1 to 12 do
      begin
        //TIPO FORNECEDOR
        COD_TABELA_ITEM := qrImport.FieldByName('COD_TIPO_FORN_'+IntToStr(I)).AsString;
        DESC_TABELA_ITEM := qrImport.FieldByName('TIPO_FORNECEDOR_'+IntToStr(I)).AsString;
        ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO) VALUES (1, '+COD_TABELA_ITEM+', '''+DESC_TABELA_ITEM+''') MATCHING (COD_TABELA, COD_TABELA_ITEM);');
        ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO CLIENTES_TABELA (COD_CLIENTE, COD_TABELA, COD_TABELA_ITEM) VALUES ('+COD_PESSOA+', 1, '+COD_TABELA_ITEM+') MATCHING (COD_CLIENTE, COD_TABELA, COD_TABELA_ITEM);');

        //GRUPO TIPO FORNECEDOR
        COD_TABELA_ITEM := qrImport.FieldByName('COD_GRUPO_TIPO_FORN_'+IntToStr(I)).AsString;
        DESC_TABELA_ITEM := qrImport.FieldByName('GRUPO_TIPO_FORNECEDOR_'+IntToStr(I)).AsString;
        ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO) VALUES (2, '+COD_TABELA_ITEM+', '''+DESC_TABELA_ITEM+''') MATCHING (COD_TABELA, COD_TABELA_ITEM);');
        ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO CLIENTES_TABELA (COD_CLIENTE, COD_TABELA, COD_TABELA_ITEM) VALUES ('+COD_PESSOA+', 2, '+COD_TABELA_ITEM+') MATCHING (COD_CLIENTE, COD_TABELA, COD_TABELA_ITEM);');
      end;

      qrImport.Next;
      Application.ProcessMessages;
    end;
    PES.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmSigma.PRODUTOS;
var
  PROD: TCadastro_Produtos;
  QTD: Double;
  COD: Integer;
  COD_GRADE: string;
  SQL: string;
  I: Integer;
  MARCA: String;
  COD_PRODUTO: string;
begin
  ConectaGiga;
  { GRUPOS DE PRODUTOS
  DM.qrImport.Open('SELECT * FROM IMPORT_FAMILIA');
  dm.qrImport.First;
  while not DM.qrImport.Eof do
  begin
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO GRUPOS_PRODUTO(COD_GRUPO, DESC_GRUPO,PERC_MARGEM)' +
                              'VALUES('+DM.qrImport.FieldByName('CODIGO').AsString+',''' +
                              DM.qrImport.FieldByName('DESCRICAO').AsString+''',0)' +
                              'MATCHING(COD_GRUPO)');
    DM.qrImport.Next;
  end;
  { MARCAS DE PRODUTOS
  DM.qrImport.Open('SELECT * FROM IMPORT_MARCAS');
  dm.qrImport.First;
  DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO)VALUES (1, ''MARCA'')MATCHING (COD_TABELA)');
  while not DM.qrImport.Eof do
  begin
    MARCA:=StringReplace(DM.qrImport.FieldByName('NOME_MARCA').AsString,'''',' ',[rfReplaceAll]);
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO)'+
                              'VALUES (1,'+DM.qrImport.FieldByName('CODIGO').AsString+','''+
                              MARCA+''')' +
                              'MATCHING (COD_TABELA, COD_TABELA_ITEM)');
    DM.qrImport.Next;
  end;
  {ERIFICAR SE TODOS OS GRUPOS FORAM CDASTRADOS
  DM.qrImport.Open('SELECT P.FAMILIA FROM IMPORT_PRODUTOS P LEFT JOIN GRUPOS_PRODUTO G ON G.COD_GRUPO = P.FAMILIA WHERE G.COD_GRUPO IS NULL');
  dm.qrImport.Last;
  if not DM.qrImport.IsEmpty then
  begin
    MessageRaul_ATENCAO('Existem grupos nos cadastros do produtos que n�o est�o cadastrados.');
    Exit;
  end;
  {VERIFICAR SE TODAS AS MARCAS FORAM CDASTRADAS
  DM.qrImport.Open('SELECT P.FAMILIA FROM IMPORT_PRODUTOS P LEFT JOIN TABELA_DO_SISTEMA_ITEM T ON T.COD_TABELA_ITEM = P.MARCA WHERE T.COD_TABELA_ITEM IS NULL');
  dm.qrImport.Last;
  if not DM.qrImport.IsEmpty then
  begin
    MessageRaul_ATENCAO('Existem MARCAS nos cadastros do produtos que n�o est�o cadastradas.');
    Exit;
  end;
  {}
//  ShowMessage('Testando os 100 primeiros');
  try
    DM.ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_PRODUTOS ADD COD_PRODUTO VARCHAR(13)');
  except
  end;
  DM.qrImport.Open('SELECT * FROM IMPORT_PRODUTOS');
  dm.qrImport.Last;
  dm.qrImport.First;
  Gauge1.MaxValue:=dm.qrImport.RecordCount+1;
  Gauge1.Progress:=0;
  PROD:=TCadastro_Produtos.Create;
  try
  PROD.Open;
  {*** CADASTRANDO IMPOSTOS ***
  DM.ConexaoGigaERP.ExecSQL('ALTER SEQUENCE SIMPOSTOS RESTART WITH 0');
  DM.ConexaoGigaERP.ExecSQL('DELETE FROM IMPOSTOS;');
  DM.ConexaoGigaERP.ExecSQL( 'INSERT INTO IMPOSTOS(COD_IMPOSTO,DESC_IMPOSTO,FLAG_SERVICO) '
                            +'SELECT '
                            +'  GEN_ID(SIMPOSTOS,1) , '
                            +'  SUBSTRING(IMP.SITUACAOTRIBUTARIA||'' - ''||STIC.DESC_TRIB_ICMS FROM 1 FOR 45), '
                            +'  0 '
                            +'FROM IMPORT_PRODUTO IMP '
                            +'LEFT JOIN ST_TRIBUTACAO_ICMS STIC ON '
                            +'(CAST(STIC.COD_TRIB_ICMS AS INT) = CAST(IMP.SITUACAOTRIBUTARIA AS INT) AND '
                            +' STIC.SEQ_TRIB_ICMS = 1) '
                            +'GROUP BY IMP.SITUACAOTRIBUTARIA, STIC.DESC_TRIB_ICMS ');
  {}
  PROD.Cadastra_imposto_padrao;
  PROD.Cadastra_Grupo_Padr�o;
//  PROD.CadastraRelacionamento(1,'CLASSE');
  I:=0;
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);

    Inc(I);
    COD_PRODUTO:= StrZeros(IntToStr(I),13);
    PROD.PRODUTOS.COD_PRODUTO:=COD_PRODUTO;
    PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO := dm.qrImport.FieldByName('CODPROD').AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESCR').AsString;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := dm.qrImport.FieldByName('VENDA').AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('SALDOQT').AsString;
    PROD.PRODUTOS_GRADE_UND[1].COD_PRODUTO := dm.qrImport.FieldByName('UNID').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('STATUS').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('MARPESQ').AsString;
//    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := dm.qrImport.FieldByName('ULTCOMPRA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('COMPRTAB').AsString;
    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := dm.qrImport.FieldByName('PRECO').AsFloat;
    PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO := dm.qrImport.FieldByName('CODBAR').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDAME').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('MOEVEND').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('QTEMB').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LOCALIZ').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DESCRCB').AsString;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE := dm.qrImport.FieldByName('UNIDV').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('QTEMBV').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('EMIN').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('SALDOCR').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODFORN').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('COEF').AsString;
    PROD.PRODUTOS.COD_CLASS := dm.qrImport.FieldByName('CLFISCAL').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CONTROLE').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('COMPR').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('COMPRAME').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('IMPOSTO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('IMPVENDA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('"DESC"').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('FRETE').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('QTULTCOM').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDANT').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DTTAB').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DTINCL').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DTULTCOM').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('EPOCA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DIMENS1').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DIMENS2').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DIMENS3').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CLASSIF').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('EMP').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODFCRUZ').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODSIMPRO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('QTEMBC').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('FABR').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('REF').AsString;
    PROD.PRODUTOS_TAB_PRECOS_PROD[3].COD_EMPRESA := 1;
    PROD.PRODUTOS_TAB_PRECOS_PROD[3].PRECO := (1-(dm.qrImport.FieldByName('DESCMXVDA').AsFloat/100))*dm.qrImport.FieldByName('VENDA').AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ST').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('EX').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ORIGEM').AsString;
    PROD.AppendOrEdit;
    DM.qrImport.Edit;
    DM.qrImport.FieldByName('COD_PRODUTO').AsString:=COD_PRODUTO;
    DM.qrImport.Post;
    dm.qrImport.Next;
    Application.ProcessMessages;
  end;
  PROD.ApplyUpdates;
  DM.qrImport.ApplyUpdates;
  Gauge1.Progress:=Gauge1.MaxValue;
  MessageRaul_AVISO('PROCESSO CONCLUIDO...');
  Gauge1.Progress:=0;
  finally
    PROD.Free;
  end;
end;

procedure TfrmSigma.butImportClick(Sender: TObject);
begin
  if ComboBox1.Text='CLIENTES'        then CLIENTES        else
  if ComboBox1.Text='FORNECEDORES'    then FORNECEDORES    else
  if ComboBox1.Text='TRANSPORTADORAS' then TRANSPORTADORAS else
  if ComboBox1.Text='GRUPOS_PRODUTOS' then GRUPOS_PRODUTOS else
  if ComboBox1.Text='PRODUTOS'        then PRODUTOS        else
  if ComboBox1.Text='MARCAS'          then MARCAS          else
  MessageRaul_ATENCAO('Uma a��o deve ser selecionada antes.');
end;

procedure TfrmSigma.Button1Click(Sender: TObject);
var
 s: TArray<string>;
 i: string;
begin
  SetLength(s,3);
  if InputQuery('Dados',['Nome:','End.:','OBS.:'],s) then
    for I in s do
        MessageRaul_AVISO(I);
end;

procedure TfrmSigma.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmSigma.TRANSPORTADORAS;
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

procedure TfrmSigma.ComboBox1Change(Sender: TObject);
begin
  ComboBox1.Items.Add('CLIENTES');
  ComboBox1.Items.Add('FORNECEDORES');
//  ComboBox1.Items.Add('TRANSPORTADORAS');
//  ComboBox1.Items.Add('GRUPOS_PRODUTOS');
  ComboBox1.Items.Add('PRODUTOS');
end;

procedure TfrmSigma.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configura��o N�o encontrado.');
end;

procedure TfrmSigma.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmSigma.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
