unit untGarimpoDasJoias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids, Vcl.CheckLst;
type
  TfrmGarimpoDasJoias = class(TForm)
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
  frmGarimpoDasJoias: TfrmGarimpoDasJoias;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmGarimpoDasJoias.CLIENTES;
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
      Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);
      CLI.PESSOAS.COD_PESSOA := qrImport.FieldByName('ID_CLIENTE').AsInteger;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ATUALIZADO').AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIRRO').AsString;
      CLI.PESSOAS.DATA_CADASTRO := SE(qrImport.FieldByName('CADASTRO').AsString<>'',qrImport.FieldByName('CADASTRO').AsDateTime,Now);
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CARTAOFID').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      CLI.PESSOAS.CNPJ_CPF := CoalesceStr(qrImport.FieldByName('CIC').AsString,qrImport.FieldByName('CNPJ').AsString);
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDADE').AsString;
      CLI.PESSOAS_ENDERECOS[1].COMPLEMENTO := qrImport.FieldByName('COMPL').AsString;
      if qrImport.FieldByName('DANA').AsString<>'' then
        CLI.CLIENTES.DATA_NASCIMENTO := qrImport.FieldByName('DANA').AsDateTime;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DMAIORCOMP').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DSEGCOMP').AsString;
      CLI.PESSOAS.EMAIL := qrImport.FieldByName('EMAIL').AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('FAX').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('FONE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_UNICO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_VENDA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('IMPRIMIR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('INFORMACAO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ITENS').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LOJA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('NEGATIVO').AsString;
      CLI.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('NOME').AsString;
      CLI.PESSOAS_ENDERECOS[1].NUMERO := qrImport.FieldByName('NUMERO').AsString;
      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('OBS').AsString;
      CLI.PESSOAS.HISTORICO := qrImport.FieldByName('OBS1').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('PECAS').AsString;
      CLI.PESSOAS.RG := qrImport.FieldByName('RG').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('RUA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('SCORE').AsString;
      CLI.CLIENTES.SEXO := SE(qrImport.FieldByName('SEXO').AsString='F',1,0);
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('SUGESTOES').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('T_COMENTA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('T_SUGESTAO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TEMPO_REL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TIPO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TRANSF').AsString;
      CLI.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ULT_COMPR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('VALOR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('VENDEDOR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('VISITAS').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('VMAIORCOMP').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('VSEGCOMP').AsString;
      CLI.PESSOAS_CONTATOS[1].TELEFONE := qrImport.FieldByName('FONE1').AsString;
      CLI.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('FONE2').AsString;
      CLI.PESSOAS_CONTATOS[1].FAX := qrImport.FieldByName('FONE3').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('FJ').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('RAZAOSOC').AsString;
      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO').AsString;
      CLI.CLIENTES.TRAB_CARGO := qrImport.FieldByName('CARGO').AsString;
      CLI.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('IE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CNPJ').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CODGRUPO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('PAIS').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LRETORNO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MKT1').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MKT2').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MKT3').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MKT4').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CONTRATO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_ONLINE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LOGIN').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('SENHA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('STATUS').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_EMPRESA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_CANAL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('RENDA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_PAI').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('EMISSAO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('L_INATIVO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('L_MENSAL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DIA_BASE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TABELA_PR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_VENDED').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('AUT_EMAIL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('AUT_SMS').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('AUT_FONE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('AUT_CARTA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CELULAR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('AVISO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MAPA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('COD_SEG').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('PERFIL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ID_PROF').AsString;
      CLI.PESSOAS.SITE := qrImport.FieldByName('HOMEPAGE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LATITUDE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LONGITUDE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MSN').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('SKYPE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LIMITE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('PDESCONTO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('INSCMUN').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('GUID').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DATASINC').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ESTADOSINC').AsString;
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

procedure TfrmGarimpoDasJoias.FORNECEDORES;
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

procedure TfrmGarimpoDasJoias.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmGarimpoDasJoias.GRUPOS_PRODUTOS;
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

procedure TfrmGarimpoDasJoias.MARCAS;
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

procedure TfrmGarimpoDasJoias.PESSOAS;
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

procedure TfrmGarimpoDasJoias.PRODUTOS;
var
  PROD: TCadastro_Produtos;
  QTD: Double;
  COD: Integer;
  COD_GRADE: string;
  SQL: string;
  I: Integer;
  MARCA: String;
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
    MessageRaul_ATENCAO('Existem grupos nos cadastros do produtos que não estão cadastrados.');
    Exit;
  end;
  {VERIFICAR SE TODAS AS MARCAS FORAM CDASTRADAS
  DM.qrImport.Open('SELECT P.FAMILIA FROM IMPORT_PRODUTOS P LEFT JOIN TABELA_DO_SISTEMA_ITEM T ON T.COD_TABELA_ITEM = P.MARCA WHERE T.COD_TABELA_ITEM IS NULL');
  dm.qrImport.Last;
  if not DM.qrImport.IsEmpty then
  begin
    MessageRaul_ATENCAO('Existem MARCAS nos cadastros do produtos que não estão cadastradas.');
    Exit;
  end;
  {}
//  ShowMessage('Testando os 100 primeiros');
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
  I:=0;
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);

    Inc(I);
//    PROD.PRODUTOS.COD_PRODUTO:=IntToStr(I);
    PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO := dm.qrImport.FieldByName('CODBAR').AsString;
    PROD.PRODUTOS_FORNECIMENTOS.COD_PRODUTO_FORNECEDOR := dm.qrImport.FieldByName('CODFORN').AsString;
    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODIGO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODRELAT1').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODRELAT2').AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESCRICAO').AsString;
    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := dm.qrImport.FieldByName('COMPRA').AsFloat;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := dm.qrImport.FieldByName('VENDA').AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDA2').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDA3').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDA4').AsString;
    try
      PROD.PRODUTOS_FORNECIMENTOS.COD_FORNECEDOR_OLD := dm.qrImport.FieldByName('ID_FORN').AsInteger;
    except
    end;
    PROD.PRODUTOS.COD_GRUPO := dm.qrImport.FieldByName('CODGRUPO').AsInteger;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODLINHA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ST').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CST').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VALIQUOTA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('IPI').AsString;
    PROD.PRODUTOS.COD_CLASS := dm.qrImport.FieldByName('CFISCAL').AsString;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE := Copy(dm.qrImport.FieldByName('UNID_NF').AsString,0,3);
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VACINA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('TIPOPROD').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('FOTO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LGRANEL').AsString;
    PROD.PRODUTOS.OBS := dm.qrImport.FieldByName('OBS').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CCUSTO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PCOMISSAO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('FICHATEC').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('QTDUNIT').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('UNIDADE').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('KIT').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PDF').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CONSIGN').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PROMOCAO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LRETORNO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PONTFIDELI').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LINK').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('BASEICMS').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LOUTCAT').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LOGIN').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DATAHORA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ID_ALIQ').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDAP2').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDAP3').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDAP4').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ID_ESPECIE').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('MODELO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DT_PRECOC').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DT_PRECOV').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PDESC').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBPUB').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBDISP').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('VENDA5').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PESO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBVITRINE').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PDESCWEB').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DATA_INI').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DATA_FIM').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('SINC_N').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('SINC_DT').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('SINC_FLAG').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBNPROMO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBLPROMO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBFRETE').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBSUBTIPO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('WEBDESATIV').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ID_GFISCAL').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ORIGEM').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('RUPTURA').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODSERVICO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PERFIL').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ID_GRUPO_F').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('TRIBUTO').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CSOSN').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('PCREDSN').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CFOPNFCE').AsString;
    PROD.AppendOrEdit;
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

procedure TfrmGarimpoDasJoias.butImportClick(Sender: TObject);
begin
  if ComboBox1.Text='CLIENTES'        then CLIENTES        else
  if ComboBox1.Text='FORNECEDORES'    then FORNECEDORES    else
  if ComboBox1.Text='TRANSPORTADORAS' then TRANSPORTADORAS else
  if ComboBox1.Text='GRUPOS_PRODUTOS' then GRUPOS_PRODUTOS else
  if ComboBox1.Text='PRODUTOS'        then PRODUTOS        else
  if ComboBox1.Text='MARCAS'          then MARCAS          else
  MessageRaul_ATENCAO('Uma ação deve ser selecionada antes.');
end;

procedure TfrmGarimpoDasJoias.Button1Click(Sender: TObject);
var
 s: TArray<string>;
 i: string;
begin
  SetLength(s,3);
  if InputQuery('Dados',['Nome:','End.:','OBS.:'],s) then
    for I in s do
        MessageRaul_AVISO(I);
end;

procedure TfrmGarimpoDasJoias.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmGarimpoDasJoias.TRANSPORTADORAS;
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

procedure TfrmGarimpoDasJoias.ComboBox1Change(Sender: TObject);
begin
  ComboBox1.Items.Add('CLIENTES');
  ComboBox1.Items.Add('FORNECEDORES');
//  ComboBox1.Items.Add('TRANSPORTADORAS');
//  ComboBox1.Items.Add('GRUPOS_PRODUTOS');
  ComboBox1.Items.Add('PRODUTOS');
end;

procedure TfrmGarimpoDasJoias.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmGarimpoDasJoias.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmGarimpoDasJoias.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
