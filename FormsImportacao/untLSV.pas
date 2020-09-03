unit untLSV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids, Vcl.CheckLst;
type
  TfrmImportPadrao = class(TForm)
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
    procedure RELAC_DESC; //IMPORTA O RELACIONAMENTO QUE CONTENHA SOMENTE A DESCRIÇÃO NO IMPORT_PRODUTOS
    procedure PESSOAS; //QUANDO O MESMO CADASTRO PODE SER CLIENTE, FORNECEDOR E/OU TRANSPORTADORA
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportPadrao: TfrmImportPadrao;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmImportPadrao.CLIENTES;
var
  CLI: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
  CPF: String;
  CNPJ: String;
  DATATMP: String;
  COD_PESSOA: Integer;
begin
  with DM do
  begin
    ConectaGiga;
    try
      DM.ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_CLIENTES ADD COD_PESSOA INTEGER');
    except
    end;
//    qrImport.Open('SELECT * FROM IMPORT_CLIENTES');
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
      COD_PESSOA  := GeraCod('SPESSOAS');
      CLI.PESSOAS.COD_PESSOA := COD_PESSOA;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('COD').AsString;
      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOME').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TIPO_FJ').AsString;
      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CGC_CPF').AsString;
      CLI.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('RG_INSCR').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDERECO').AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIRRO').AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDADE').AsString;
      CLI.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('DDD').AsString+qrImport.FieldByName('FONE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('FONE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ETIQUETA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TOTAL_COMPRAS').AsString;
      CLI.PESSOAS.EMAIL := qrImport.FieldByName('E_MAIL').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('QTE_COMPRAS').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('DIAS_ATRASO').AsString;
      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('OBS').AsString;
      if Trim(qrImport.FieldByName('NASCTO').AsString)<>'' then
        CLI.CLIENTES.DATA_NASCIMENTO := qrImport.FieldByName('NASCTO').AsDateTime
      else
        CLI.CLIENTES.DATA_NASCIMENTO := StrToDate('01/01/1900');
//      CLI.CLIENTES.LIMITE_CREDITO := qrImport.FieldByName('LIMITE').AsFloat;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ULT_COMPRA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CONVENIO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('SITUACAO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('MATRICULA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CPF_NUMERO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('BLOQUEIA_VENDA').AsString;
      CLI.CLIENTES.SEXO := SE(qrImport.FieldByName('SEXO').AsString='F',1,0);
      CLI.PESSOAS.RG := qrImport.FieldByName('RG_NUMERO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('INSC_PRODUTOR').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CONJUGE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NASC_CONJUGE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('DATA_CASAMENTO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CONCEITOS').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CPF_CONJUGE').AsString;
      CLI.PESSOAS_ENDERECOS[2].ENDERECO := qrImport.FieldByName('END_COMERC').AsString;
      CLI.PESSOAS_ENDERECOS[2].CEP := qrImport.FieldByName('CEP_COMERCIAL').AsString;
      CLI.PESSOAS_ENDERECOS[2].TELEFONE := qrImport.FieldByName('FONE_COMERCIAL').AsString;
      CLI.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('CELULAR').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CREDITO').AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('FAX').AsString;
      CLI.PESSOAS.SITE := qrImport.FieldByName('SITE').AsString;
      CLI.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('NOME_FANTASIA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CLASS_COD_RDZ').AsString;
      CLI.PESSOAS_ENDERECOS[2].NOME_MUNIC := qrImport.FieldByName('CIDADE_COM').AsString;
      CLI.PESSOAS_ENDERECOS[2].UF := qrImport.FieldByName('UF_COMERCIAL').AsString;
      CLI.PESSOAS_CONTATOS[1].TELEFONE := qrImport.FieldByName('FONE2').AsString;
      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO_COM').AsString;
      CLI.PESSOAS_CONTATOS[1].EMAIL := qrImport.FieldByName('EMAIL_COM').AsString;
      CLI.PESSOAS_ENDERECOS[2].BAIRRO := qrImport.FieldByName('BAIRRO_COM').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TIPO_ICMS').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ENTREGAD').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('SETOR').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('DOCTO_CASAMENTO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ESTADO_CIVIL').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('LOCAL_NASCTO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CASA_PROPRIA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TEMPOCASAPROP').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ALUGUEL').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('PENSAO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('LOCAL_TRABALHO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('FUNCAO_EMP').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('DATA_ADMISSAO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('REG_EMPREGADOR').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('SALARIO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('RG_CONJUGE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TRAB_CONJUGE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('END_TRAB_CONJUG').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CID_TRAB_CONJUG').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('FONE_TRAB_CONJU').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ADMISSAO_CONJUG').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('REG_EMP_CONJUGE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('SALARIO_CONJUGE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('LIMITE_CREDITO').AsString;
      if Trim(qrImport.FieldByName('DATA_CADASTRO').AsString)<>'' then
        CLI.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('DATA_CADASTRO').AsDateTime
      else
        CLI.PESSOAS.DATA_CADASTRO := Now;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('CONTROLA_CREDIT').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TP_MOVIMENTO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ULTIMA_REQ').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TEM_IPI').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('COD_CIDADE').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('COD_CIDADE_COM').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ORGAO_PUBLI').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('MENS_NOTA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('MENSAGEM_BOLETO').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('USA_VA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('TIPO_PESSOA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('ZONA_FRANCA').AsString;
//      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('INSCR_SUFRAMA').AsString;
      CLI.AppendOrEdit;
      qrImport.Edit;
      qrImport.FieldByName('COD_PESSOA').AsInteger:=COD_PESSOA;
      qrImport.Post;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    CLI.ApplyUpdates;
    qrImport.ApplyUpdates();
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmImportPadrao.FORNECEDORES;
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
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('ORDEM').AsString;
      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO').AsString;
      FORN.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOME').AsString;
      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CGC_CPF').AsString;
      FORN.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('INSC_RG').AsString;
      FORN.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('ENDERECO').AsString;
      FORN.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDADE').AsString;
      FORN.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF').AsString;
      FORN.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIRRO').AsString;
      FORN.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      FORN.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('DDD_1').AsString+qrImport.FieldByName('FONE_1').AsString;
      FORN.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('DDD_2').AsString+qrImport.FieldByName('FONE_2').AsString;
      FORN.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('DDD_FAX').AsString+qrImport.FieldByName('FONE_FAX').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('FONE_1').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('FONE_2').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('FONE_FAX').AsString;
      FORN.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO').AsString;
      FORN.PESSOAS.EMAIL := qrImport.FieldByName('E_MAIL').AsString;
      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('OBS').AsString;
      FORN.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('NOME_FANTASIA').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('CPF_NUMERO').AsString;
      FORN.PESSOAS.RG := qrImport.FieldByName('RG_NUMERO').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('CLASS_COD_RDZ').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('TP_MOVIMENTO').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('ORGAO_PUBLI').AsString;
//      FORN.PESSOAS.BAIRRO := qrImport.FieldByName('COD_CIDADE').AsString;
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

procedure TfrmImportPadrao.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmImportPadrao.GRUPOS_PRODUTOS;
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

procedure TfrmImportPadrao.MARCAS;
begin
  with DM do
  begin
    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO)'+
                                 'VALUES (1, ''MARCAS'')'+
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

procedure TfrmImportPadrao.PESSOAS;
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

procedure TfrmImportPadrao.PRODUTOS;
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
  DM.qrImport.Open('SELECT APLICACAO FROM IMPORT_PRODUTOS WHERE APLICACAO IS NOT NULL GROUP BY APLICACAO');
  dm.qrImport.First;
  try
    DM.ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_PRODUTOS ADD COD_GRUPOS_PRODUTO INT');
  except
  end;
  I:=0;
  while not DM.qrImport.Eof do
  begin
    inc(I);
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO GRUPOS_PRODUTO(COD_GRUPO, DESC_GRUPO,PERC_MARGEM)' +
                              'VALUES('+IntToStr(I)+',''' +
                              DM.qrImport.FieldByName('APLICACAO').AsString+''',0)' +
                              'MATCHING(COD_GRUPO)');
    DM.qrImport.Next;
  end;
  Exit;
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
  {VERIFICAR SE TODOS OS GRUPOS FORAM CDASTRADOS
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
//  PROD.Cadastra_imposto_padrao;
//  PROD.Cadastra_Grupo_Padrão;
//  PROD.CadastraRelacionamento(1,'CLASSE');
  I:=0;
//  DM.QR_GigaERP.Close;
//  DM.QR_GigaERP.Open('SELECT * FROM GRUPOS_PRODUTO');
//  DM.QR_GigaERP_Aux.Close;
//  DM.QR_GigaERP_Aux.Open('SELECT * FROM TABELA_DO_SISTEMA_ITEM WHERE COD_TABELA = 1');
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);

    Inc(I);
//    COD_PRODUTO:= StrZeros(IntToStr(I),13);
//    PROD.PRODUTOS.COD_PRODUTO:=COD_PRODUTO;
//    COD_PRODUTO := StrZeros(dm.qrImport.FieldByName('CODIGO').AsString,13);
//    PROD.PRODUTOS.COD_PRODUTO := COD_PRODUTO;
    PROD.PRODUTOS.COD_PRODUTO := StrZeros(dm.qrImport.FieldByName('CODIGO').AsString,13);
    PROD.PRODUTOS.CHAVE_OLD := dm.qrImport.FieldByName('ORDEM').AsString;
//    PROD.PRODUTOS.CHAVE_OLD := dm.qrImport.FieldByName('CODIGO').AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESCRICAO').AsString;
    PROD.PRODUTOS_APELIDOS_PROD[4].APELIDO := dm.qrImport.FieldByName('CODIGO_FABRICA').AsString;
    PROD.PRODUTOS_TABELA[1].COD_TABELA_ITEM := dm.qrImport.FieldByName('MARCA').AsInteger;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QTE_ESTOQUE').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QTE_PEDIDO').AsString;
    PROD.PRODUTOS_TAB_PRECOS_PROD[2].PRECO := dm.qrImport.FieldByName('PRECO_VENDA').AsFloat;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := dm.qrImport.FieldByName('PRECO_2').AsFloat;
    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := dm.qrImport.FieldByName('CUSTO_MEDIO').AsFloat;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MARGEM_LUCRO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ST').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ICMS').AsString;
    PROD.PRODUTOS_GRADE.ESTOQUE_MIN := dm.qrImport.FieldByName('EST_MINIMO').AsFloat;
    PROD.PRODUTOS_GRADE.ESTOQUE_MAX := dm.qrImport.FieldByName('EST_MAXIMO').AsFloat;
    PROD.PRODUTOS_TABELA[2].COD_TABELA_ITEM := dm.qrImport.FieldByName('FAMILIA').AsInteger;
    PROD.PRODUTOS.COD_GRUPO := dm.qrImport.FieldByName('GRUPO').AsInteger;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('SUB_GRUPO').AsString;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE := dm.qrImport.FieldByName('UN').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('FAIXA_ECF').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QTE_DISPONIVEL').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QTE_DISPONIVELX').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QTE_INVENTARIO').AsString;
    PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO := dm.qrImport.FieldByName('COD_REFERENCIA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VLR_ULT_COMPRA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ICMS_ULT_COMPRA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VLR_ULT_COMP_C').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ICMS_ULT_COMP_C').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VLR_ULT_COMP_S').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ICMS_ULT_COMP_S').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('BAIXA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('TOTAL_MONTAGEM').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('LOCALIZACAO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MARGEM_LUCRO2').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ORIGEM').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PAIS').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COMPOSICAO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MODO_TRATAR').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('LOTE_DE').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('NAO_INCIDE_ISS').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('NOME_FOTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PRECO_TABELA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('CFOP_DENTRO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('CFOP_FORA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('IPI').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('TP_MOVIMENTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('GRADE_UTILIZADA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('NCM').AsString;
    PROD.PRODUTOS.COD_CLASS := dm.qrImport.FieldByName('COD_FISCAL').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('TIPO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('EM_REQUISICAO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QTDE_MIN').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ULT_SIMULACAO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VLR_IPI').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VALIDADE').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VLR_LIQUIDO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COD_ALTERNATIVO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PESO_LIQUIDO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PESO_BRUTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PIS_CONF').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COFINS_CONF').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('NAO_SOMA_NF').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('TP_PROD_SPED').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('CST_VDF').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('EX_NCM').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COD_FCP').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COD_CEST').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('CST_IPI').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ENQ_IPI').AsString;
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

procedure TfrmImportPadrao.RELAC_DESC;
CONST
  DESC_RELAC: string = 'SUBGRUPO';
  COD_RELAC: String = '1';
  CAMPO_RELAC: String = 'SUBGRUPO';
var
  I: Integer;
begin
  with DM do
  begin
    ConectaGiga;
    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO)'+
                                 'VALUES ('+COD_RELAC+', '+QuotedStr(DESC_RELAC)+')'+
                               'MATCHING (COD_TABELA);');
    qrImport.Open('SELECT '+CAMPO_RELAC+' RELAC FROM IMPORT_PRODUTOS GROUP BY '+CAMPO_RELAC);
    qrImport.First;
    QR_GigaERP.Open('SELECT * FROM TABELA_DO_SISTEMA_ITEM');
    I := 0;
    while not qrImport.Eof do
    begin
      Inc(I);
      QR_GigaERP.Append;
      QR_GigaERP.FieldByName('COD_TABELA').AsFloat := StrToInt(COD_RELAC);
      QR_GigaERP.FieldByName('COD_TABELA_ITEM').AsInteger := I;
      QR_GigaERP.FieldByName('DESCRICAO').AsString := qrImport.FieldByName('RELAC').AsString;
      QR_GigaERP.Post;
      qrImport.Next;
    end;
    QR_GigaERP.ApplyUpdates();
    MessageRaul_AVISO('RELACIONAMENTO DE PRODUTOS IMPORTADO COM SUCESSO.');
  end;
end;

procedure TfrmImportPadrao.butImportClick(Sender: TObject);
begin
  if ComboBox1.Text='CLIENTES'        then CLIENTES        else
  if ComboBox1.Text='FORNECEDORES'    then FORNECEDORES    else
  if ComboBox1.Text='TRANSPORTADORAS' then TRANSPORTADORAS else
  if ComboBox1.Text='GRUPOS_PRODUTOS' then GRUPOS_PRODUTOS else
  if ComboBox1.Text='PRODUTOS'        then PRODUTOS        else
  if ComboBox1.Text='MARCAS'          then MARCAS          else
  if ComboBox1.Text='RELACIONAMENTO'  then RELAC_DESC      else
  MessageRaul_ATENCAO('Uma ação deve ser selecionada antes.');
end;

procedure TfrmImportPadrao.Button1Click(Sender: TObject);
var
 s: TArray<string>;
 i: string;
begin
  SetLength(s,3);
  if InputQuery('Dados',['Nome:','End.:','OBS.:'],s) then
    for I in s do
        MessageRaul_AVISO(I);
end;

procedure TfrmImportPadrao.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmImportPadrao.TRANSPORTADORAS;
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

procedure TfrmImportPadrao.ComboBox1Change(Sender: TObject);
begin
//  ComboBox1.Items.Add('CLIENTES');
//  ComboBox1.Items.Add('FORNECEDORES');
//  ComboBox1.Items.Add('TRANSPORTADORAS');
//  ComboBox1.Items.Add('GRUPOS_PRODUTOS');
//  ComboBox1.Items.Add('PRODUTOS');
end;

procedure TfrmImportPadrao.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmImportPadrao.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmImportPadrao.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
