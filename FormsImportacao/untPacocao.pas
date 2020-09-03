unit untPacocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids, Vcl.CheckLst;
type
  TfrmPacocao = class(TForm)
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
    Label2: TLabel;
    Label3: TLabel;
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
  frmPacocao: TfrmPacocao;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmPacocao.CLIENTES;
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
      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODIGO').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOME').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TIPO_FJ').AsString;
      CLI.PESSOAS.CNPJ_CPF := CoalesceStr(qrImport.FieldByName('CGC_CPF').AsString,qrImport.FieldByName('CPF_NUMERO').AsString);
      CLI.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('RG_INSCR').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDERECO').AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAIRRO').AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDADE').AsString;
      CLI.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('UF').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEP').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('DDD').AsString+qrImport.FieldByName('FONE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('FONE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ETIQUETA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TOTAL_COMPRAS').AsString;
      CLI.PESSOAS.EMAIL := qrImport.FieldByName('E_MAIL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('QTE_COMPRAS').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DIAS_ATRASO').AsString;
      CLI.PESSOAS.OBS_PESSOA := qrImport.FieldByName('OBS').AsString;
      CLI.CLIENTES.DATA_NASCIMENTO := qrImport.FieldByName('NASCTO').AsDateTime;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LIMITE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ULT_COMPRA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CONVENIO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('SITUACAO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MATRICULA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CPF_NUMERO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('BLOQUEIA_VENDA').AsString;
      CLI.CLIENTES.SEXO := SE(qrImport.FieldByName('SEXO').AsString='M',1,0);
      CLI.PESSOAS.RG := qrImport.FieldByName('RG_NUMERO').AsString;
//      CLI.PESSOAS.SUFRAMA := qrImport.FieldByName('INSC_PRODUTOR').AsString;
      CLI.CLIENTES.CONJ_NOME := qrImport.FieldByName('CONJUGE').AsString;
//      CLI.CLIENTES.CNPJ_CPF := qrImport.FieldByName('NASC_CONJUGE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DATA_CASAMENTO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CONCEITOS').AsString;
      CLI.CLIENTES.CONJ_CPF := qrImport.FieldByName('CPF_CONJUGE').AsString;
      CLI.PESSOAS_ENDERECOS[2].ENDERECO := qrImport.FieldByName('END_COMERCIAL').AsString;
      CLI.PESSOAS_ENDERECOS[2].CEP := qrImport.FieldByName('CEP_COMERCIAL').AsString;
      CLI.PESSOAS_ENDERECOS[2].TELEFONE := qrImport.FieldByName('FONE_COMERCIAL').AsString;
      CLI.PESSOAS_CONTATOS[1].CELULAR := qrImport.FieldByName('CELULAR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CREDITO').AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX := qrImport.FieldByName('DDD').AsString+qrImport.FieldByName('FAX').AsString;
      CLI.PESSOAS.SITE := qrImport.FieldByName('SITE').AsString;
      CLI.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('NOME_FANTASIA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CLASS_COD_RDZ').AsString;
      CLI.PESSOAS_ENDERECOS[2].NOME_MUNIC := qrImport.FieldByName('CIDADE_COM').AsString;
      CLI.PESSOAS_ENDERECOS[2].UF := qrImport.FieldByName('UF_COMERCIAL').AsString;
      CLI.PESSOAS_CONTATOS[1].TELEFONE := qrImport.FieldByName('FONE2').AsString;
      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO_COM').AsString;
      CLI.PESSOAS_CONTATOS[1].EMAIL := qrImport.FieldByName('EMAIL_COM').AsString;
      CLI.PESSOAS_ENDERECOS[2].BAIRRO := qrImport.FieldByName('BAIRRO_COM').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TIPO_ICMS').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ENTREGADOR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('SETOR').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DOCTO_CASAMENTO').AsString;
      CLI.CLIENTES.CONJ_ESTADO_CIVIL := qrImport.FieldByName('ESTADO_CIVIL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LOCAL_NASCTO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CASA_PROPRIA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TEMPOCASAPROP').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ALUGUEL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('PENSAO').AsString;
      CLI.CLIENTES.TRAB_LOCAL := qrImport.FieldByName('LOCAL_TRABALHO').AsString;
      CLI.CLIENTES.TRAB_PROFISSAO := qrImport.FieldByName('FUNCAO_EMP').AsString;
//      CLI.CLIENTES.CNPJ_CPF := qrImport.FieldByName('DATA_ADMISSAO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('REG_EMPREGADOR').AsString;
      CLI.CLIENTES.TRAB_RENDA := qrImport.FieldByName('SALARIO').AsFloat;
      CLI.CLIENTES.CONJ_RG := qrImport.FieldByName('RG_CONJUGE').AsString;
      CLI.CLIENTES.CONJ_PROFISSAO := qrImport.FieldByName('TRAB_CONJUGE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('END_TRAB_CONJUG').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CID_TRAB_CONJUG').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('FONE_TRAB_CONJU').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ADMISSAO_CONJUG').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('REG_EMP_CONJUGE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('SALARIO_CONJUGE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('LIMITE_CREDITO').AsString;
      CLI.PESSOAS.DATA_CADASTRO := qrImport.FieldByName('DATA_CADASTRO').AsDateTime;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CONTROLA_CREDIT').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TP_MOVIMENTO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('DESC_PONTUAL').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ULTIMA_REQ').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TEM_IPI').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('COD_CIDADE').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('COD_CIDADE_COM').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ORGAO_PUBLI').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MENS_NOTA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('MENSAGEM_BOLETO').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('USA_VA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('TIPO_PESSOA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('ZONA_FRANCA').AsString;
//      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('INSCR_SUFRAMA').AsString;
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

procedure TfrmPacocao.FORNECEDORES;
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

procedure TfrmPacocao.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmPacocao.GRUPOS_PRODUTOS;
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

procedure TfrmPacocao.MARCAS;
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

procedure TfrmPacocao.PRODUTOS;
var
  PROD: TCadastro_Produtos;
  QTD: Double;
  COD: Integer;
  COD_GRADE: string;
  SQL: string;
  I: Integer;
  MARCA: String;
  FAMILIA: String;
begin
  ConectaGiga;
  PROD:=TCadastro_Produtos.Create;
  try
  PROD.Open;
  PROD.Cadastra_imposto_padrao;
  PROD.Cadastra_Grupo_Padrão;
  //* GRUPOS DE PRODUTOS *//
  DM.qrImport.Open('SELECT * FROM IMPORT_FAMILIA');
  dm.qrImport.First;
  while not DM.qrImport.Eof do
  begin
    FAMILIA:=StringReplace(DM.qrImport.FieldByName('DESCRICAO').AsString,'''','',[rfReplaceAll]);
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO GRUPOS_PRODUTO(COD_GRUPO, DESC_GRUPO,PERC_MARGEM)' +
                              'VALUES('+DM.qrImport.FieldByName('CODIGO').AsString+',''' +
                              FAMILIA+''',0)' +
                              'MATCHING(COD_GRUPO)');
    DM.qrImport.Next;
  end;
  //* MARCAS DE PRODUTOS *//
  DM.qrImport.Close;
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
  //VERIFICAR SE TODOS OS GRUPOS FORAM CDASTRADOS
  DM.qrImport.Open('SELECT P.FAMILIA FROM IMPORT_PRODUTOS P LEFT JOIN GRUPOS_PRODUTO G ON G.COD_GRUPO = P.FAMILIA WHERE G.COD_GRUPO IS NULL');
  dm.qrImport.Last;
  if not DM.qrImport.IsEmpty then
  begin
    MessageRaul_ATENCAO('Existem grupos nos cadastros do produtos que não estão cadastrados.');
    Exit;
  end;
  //VERIFICAR SE TODAS AS MARCAS FORAM CDASTRADAS
  DM.qrImport.Open('SELECT P.MARCA FROM IMPORT_PRODUTOS P LEFT JOIN TABELA_DO_SISTEMA_ITEM T ON T.COD_TABELA_ITEM = P.MARCA WHERE T.COD_TABELA_ITEM IS NULL');
  dm.qrImport.Last;
  if not DM.qrImport.IsEmpty then
  begin
    MessageRaul_ATENCAO('Existem MARCAS nos cadastros do produtos que não estão cadastradas.');
    Exit;
  end;

//  ShowMessage('Testando os 100 primeiros');
  DM.qrImport.Open('select * from import_produtos ');
  dm.qrImport.Last;
  dm.qrImport.First;
  Gauge1.MaxValue:=dm.qrImport.RecordCount+1;
  Gauge1.Progress:=0;
//  PROD.CadastraRelacionamento(1,'CLASSE');
  I:=0;
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);

//    Inc(I);
//    PROD.PRODUTOS.COD_PRODUTO:=IntToStr(I);
    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODIGO').AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESCRICAO').AsString;
    PROD.PRODUTOS.COD_GRUPO := dm.qrImport.FieldByName('FAMILIA').AsInteger;
    PROD.PRODUTOS.COD_CLASS := dm.qrImport.FieldByName('COD_FISCAL').AsString;
    PROD.PRODUTOS_TABELA[1].COD_TABELA_ITEM := dm.qrImport.FieldByName('MARCA').AsInteger;
    PROD.AppendOrEditPRODUTOS;
    DM.qrImportAux.Close;
    DM.qrImportAux.Open('select P.*, PG.*, COALESCE(PG.tamanho||''/''||pg.cor,''*'') COD_GRADE '+
                        'from import_produtos p left join import_produtos_grade PG ON '+
                        '(PG.cod_produtos = P.codigo) WHERE P.CODIGO = '+PROD.PRODUTOS.COD_PRODUTO);
    DM.qrImportAux.First;
    while not DM.qrImportAux.Eof do
    begin
      PROD.PRODUTOS_GRADE.COD_GRADE := dm.qrImportAux.FieldByName('COD_GRADE').AsString;
      PROD.PRODUTOS_GRADE.OBS := dm.qrImportAux.FieldByName('COR').AsString;
      PROD.PRODUTOS_GRADE.QTD_ESTOQUE := dm.qrImportAux.FieldByName('ESTOQUE').AsFloat;
      PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO := dm.qrImportAux.FieldByName('COD_BARRA').AsString;
      PROD.PRODUTOS_TAB_PRECOS_PROD[2].PRECO := dm.qrImportAux.FieldByName('PRECO_VENDA').AsFloat;
      PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := dm.qrImportAux.FieldByName('PRECO_2').AsFloat;
      PROD.PRODUTOS_GRADE.ESTOQUE_MIN := dm.qrImportAux.FieldByName('EST_MINIMO').AsFloat;
      PROD.PRODUTOS_GRADE.ESTOQUE_MAX := dm.qrImportAux.FieldByName('EST_MAXIMO').AsFloat;
      PROD.PRODUTOS_GRADE_UND[1].UNIDADE := dm.qrImportAux.FieldByName('UN').AsString;
      PROD.AppendOrEditGRADES;
      DM.qrImportAux.Next;
      Application.ProcessMessages;
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

procedure TfrmPacocao.butImportClick(Sender: TObject);
begin
  if ComboBox1.Text='CLIENTES'        then CLIENTES        else
  if ComboBox1.Text='FORNECEDORES'    then FORNECEDORES    else
  if ComboBox1.Text='TRANSPORTADORAS' then TRANSPORTADORAS else
  if ComboBox1.Text='GRUPOS_PRODUTOS' then GRUPOS_PRODUTOS else
  if ComboBox1.Text='PRODUTOS'        then PRODUTOS        else
  if ComboBox1.Text='MARCAS'          then MARCAS          else
  MessageRaul_ATENCAO('Uma ação deve ser selecionada antes.');
end;

procedure TfrmPacocao.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmPacocao.TRANSPORTADORAS;
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

procedure TfrmPacocao.ComboBox1Change(Sender: TObject);
begin
  ComboBox1.Items.Add('CLIENTES');
  ComboBox1.Items.Add('FORNECEDORES');
//  ComboBox1.Items.Add('TRANSPORTADORAS');
//  ComboBox1.Items.Add('GRUPOS_PRODUTOS');
  ComboBox1.Items.Add('PRODUTOS');
end;

procedure TfrmPacocao.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmPacocao.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmPacocao.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
