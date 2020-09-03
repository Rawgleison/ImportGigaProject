unit untSisCom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids, Vcl.CheckLst;
type
  TfrmSisCom = class(TForm)
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
  private
    procedure ConectaGiga;
    procedure CLIENTES;
    procedure FORNECEDORES;
    procedure TRANSPORTADORAS;
    procedure GRUPOS_PRODUTOS;
    procedure PRODUTOS;
    procedure MARCAS;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSisCom: TfrmSisCom;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmSisCom.CLIENTES;
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
      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CODCLI').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOMCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ERRCOD').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ENDCOB').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CIDCOB').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CEPCOB').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('BAICOB').AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAICLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEPCLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDCLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('ESTCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ENDENT').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CIDENT').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('BAIENT').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('HORENT').AsString;
      CLI.PESSOAS.RG := qrImport.FieldByName('REGCLI').AsString;
//      CLI.CLIENTES.DATA_NASCIMENTO := qrImport.FieldByName('DATNAC').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('NOMLOJ').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('TELCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('COMTEL').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('FUNCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('SALCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('IESCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('PAICLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('MAECLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('OBSCLI').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('DATCAD').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('DATMOV').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('LOCTRA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ENDTRA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('BAITRA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CEPTRA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CIDTRA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ESTTRA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TELTRA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('NOMRE1').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ENDRE1').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('BAIRE1').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CEPRE1').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CIDRE1').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ESTRE1').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TELRE1').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('NOMRE2').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ENDRE2').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('BAIRE2').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CEPRE2').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CIDRE2').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ESTRE2').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TELRE2').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('NOMCON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TRACON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ENDCON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CIDCON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('BAICON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CEPCON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ESTCON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TELCON').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('NOMAVA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ENDAVA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('BAIAVA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CEPAVA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CIDAVA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('ESTAVA').AsString;
//      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TELAVA').AsString;
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

procedure TfrmSisCom.FORNECEDORES;
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
      FORN.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CODFOR').AsString;
      FORN.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOMFOR').AsString;
      FORN.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDFOR').AsString;
      FORN.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIFOR').AsString;
      FORN.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEPFOR').AsString;
      FORN.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('ESTFOR').AsString;
      FORN.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDFOR').AsString;
      FORN.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('IESFOR').AsString;
      FORN.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('TELFOR').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('DATMOV').AsString;
      if Trim(qrImport.FieldByName('DATCAD').AsString)<>'' then
        FORN.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('DATCAD').AsDateTime;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('TIPFOR').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('INDICM').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('INDOUT').AsString;
//      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('INDFRE').AsString;
      FORN.PESSOAS.OBS_PESSOA := qrImport.FieldByName('PESCON').AsString;
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

procedure TfrmSisCom.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmSisCom.GRUPOS_PRODUTOS;
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

procedure TfrmSisCom.MARCAS;
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

procedure TfrmSisCom.PRODUTOS;
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
  //* GRUPOS DE PRODUTOS *//
  DM.ConexaoGigaERP.ExecSQL('UPDATE IMPORT_PRODUTOS SET CODCAT = NULL WHERE CODCAT=0');
  DM.ConexaoGigaERP.ExecSQL('UPDATE IMPORT_PRODUTOS SET CODMAR = NULL WHERE CODMAR=0');
  DM.qrImport.Open('SELECT '+
                   'IIF(CODCAT IS NULL,99,CODCAT) CODCAT, '+
                   'COALESCE(CATEGORIA,''GERAL'') CATEGORIA '+
                   'FROM IMPORT_PRODUTOS '+
                   'GROUP BY CODCAT,CATEGORIA');
  dm.qrImport.First;
  while not DM.qrImport.Eof do
  begin
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO GRUPOS_PRODUTO(COD_GRUPO, DESC_GRUPO,PERC_MARGEM)' +
                              'VALUES('+DM.qrImport.FieldByName('CODCAT').AsString+',''' +
                              DM.qrImport.FieldByName('CATEGORIA').AsString+''',0)' +
                              'MATCHING(COD_GRUPO)');
    DM.qrImport.Next;
  end;
  //* UNIDADES DE MEDIDAS *//
//  DM.qrImport.Open('SELECT '+
//                   'COALESCE(UNIDADE,''UND'') UNIDADE '+
//                   'FROM IMPORT_PRODUTOS '+
//                   'GROUP BY UNIDADE');
//  dm.qrImport.First;
//  while not DM.qrImport.Eof do
//  begin
//    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO UNIDADES_MEDIDA(UNIDADE,DESC_UNIDADE,FATOR_CONVERSAO)' +
//                              'VALUES('''+DM.qrImport.FieldByName('UNIDADE').AsString+''',''' +
//                              DM.qrImport.FieldByName('UNIDADE').AsString+''',1)' +
//                              'MATCHING(UNIDADE)');
//    DM.qrImport.Next;
//  end;
//  DM.qrUNIDADES_MEDIDA.Close;
//  DM.qrUNIDADES_MEDIDA.Open;
  //* MARCAS DE PRODUTOS *//
  DM.qrImport.Open('SELECT '+
                   'CODMAR, '+
                   'MARCA '+
                   'FROM IMPORT_PRODUTOS '+
                   'WHERE CODMAR > 0 '+
                   'GROUP BY CODMAR,MARCA');
  dm.qrImport.First;
  DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO)VALUES (1, ''MARCA'')MATCHING (COD_TABELA)');
  while not DM.qrImport.Eof do
  begin
    MARCA:=StringReplace(DM.qrImport.FieldByName('MARCA').AsString,'''',' ',[rfReplaceAll]);
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO)'+
                              'VALUES (1,'+DM.qrImport.FieldByName('CODMAR').AsString+','''+
                              MARCA+''')' +
                              'MATCHING (COD_TABELA, COD_TABELA_ITEM)');
    DM.qrImport.Next;
  end;
//  ShowMessage('Testando os 100 primeiros');
  DM.qrImport.Open('SELECT * FROM IMPORT_PRODUTOS WHERE PRODUTO = 1');
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
    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODIGO').AsString;
    PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO := dm.qrImport.FieldByName('REFERENCIA').AsString;
    PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO := dm.qrImport.FieldByName('BARRA').AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESCRICAO').AsString;
    PROD.PRODUTOS.FLAG_SERVICO := dm.qrImport.FieldByName('SERVICO').AsInteger;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PRODUTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('TIPO').AsString;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE := SE(dm.qrImport.FieldByName('UNIDADE').IsNull,'UND',dm.qrImport.FieldByName('UNIDADE').AsString);
    PROD.PRODUTOS.COD_GRUPO := SE(dm.qrImport.FieldByName('CODCAT').IsNull,99,dm.qrImport.FieldByName('CODCAT').AsInteger);
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('CATEGORIA').AsString;
    PROD.PRODUTOS_TABELA[1].COD_TABELA_ITEM := dm.qrImport.FieldByName('CODMAR').AsInteger;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MARCA').AsString;
    PROD.PRODUTOS_GRADE[1].ESTOQUE_MIN := dm.qrImport.FieldByName('QUANT_MINI').AsFloat;
    PROD.PRODUTOS_GRADE[1].QTD_ESTOQUE := dm.qrImport.FieldByName('QUANT_ATUA').AsFloat;
    PROD.PRODUTOS_GRADE[1].ESTOQUE_MAX := dm.qrImport.FieldByName('QUANT_MAX').AsFloat;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QUANT_UNID').AsString;
    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := dm.qrImport.FieldByName('P_CUSTO').AsFloat;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := dm.qrImport.FieldByName('P_VENDA').AsFloat;
    PROD.PRODUTOS.OBS := dm.qrImport.FieldByName('MENSAGEM').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('IPI').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COD_SIT').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COD_IPI').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('AL_IPI').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('CLAS_FIS').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('AL_ICMS').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('FOTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('OBS').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('IMPRESSO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PECA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('QUANTIDADE').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('GRUPO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('M3').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('FIELD32').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('COMPRADO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESCONTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DATA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ENTANT').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('SAIANT').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('SALDOANT').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ENTRADA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('SAIDA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('SALDO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MARGEM').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('AVISOMIN').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('AVISOZER').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('FALTA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MAIS_VEND').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MAIS_QUAN').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PRAZO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MARGEM2').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('ATACADO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('MARGEM3').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('FOTO1').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('FOTO2').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('CODNATIVO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('LOCALIZA').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VENZER').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('VENCIMENTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('LUCRO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('TOT_CUSTO').AsString;
//    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('LUCROP').AsString;
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

procedure TfrmSisCom.butImportClick(Sender: TObject);
begin
  if ComboBox1.Text='CLIENTES'        then CLIENTES        else
  if ComboBox1.Text='FORNECEDORES'    then FORNECEDORES    else
  if ComboBox1.Text='TRANSPORTADORAS' then TRANSPORTADORAS else
  if ComboBox1.Text='GRUPOS_PRODUTOS' then GRUPOS_PRODUTOS else
  if ComboBox1.Text='PRODUTOS'        then PRODUTOS        else
  if ComboBox1.Text='MARCAS'          then MARCAS          else
  MessageRaul_ATENCAO('Uma ação deve ser selecionada antes.');
end;

procedure TfrmSisCom.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmSisCom.TRANSPORTADORAS;
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

procedure TfrmSisCom.ComboBox1Change(Sender: TObject);
begin
  ComboBox1.Items.Add('CLIENTES');
  ComboBox1.Items.Add('FORNECEDORES');
//  ComboBox1.Items.Add('TRANSPORTADORAS');
//  ComboBox1.Items.Add('GRUPOS_PRODUTOS');
  ComboBox1.Items.Add('PRODUTOS');
end;

procedure TfrmSisCom.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmSisCom.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmSisCom.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
