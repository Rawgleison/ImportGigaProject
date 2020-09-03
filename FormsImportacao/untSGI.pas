unit untSGI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids;
type
  TfrmSGI = class(TForm)
    Panel1: TPanel;
    Gauge1: TGauge;
    Label1: TLabel;
    vleConexao: TValueListEditor;
    butGravar: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    butImportar: TButton;
    Memo1: TMemo;
    cbSelect: TComboBox;
    memoFornecedores: TMemo;
    memoClientes: TMemo;
    memoReceber: TMemo;
    memoProdutos: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butGravarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure butImportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ConectaGiga;
    procedure CLIENTES;
    procedure FORNECEDORES;
    procedure TRANSPORTADORAS;
    procedure GRUPOS_PRODUTO;
    procedure PRODUTOS;
    procedure RECEBER;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSGI: TfrmSGI;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmSGI.CLIENTES;
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
    try
      ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_CLIENTES ADD COD_PESSOA INTEGER');
    except

    end;
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
      CLI.PESSOAS.COD_PESSOA := GeraCod('SPESSOAS');
      CLI.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODCLI').AsString;
      CLI.PESSOAS.CNPJ_CPF := qrImport.FieldByName('CODCLI').AsString;
      CLI.PESSOAS.RAZAO_SOCIAL := qrImport.FieldByName('NOMCLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO := qrImport.FieldByName('ENDCLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO := qrImport.FieldByName('BAICLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP := qrImport.FieldByName('CEPCLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC := qrImport.FieldByName('CIDCLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].UF := qrImport.FieldByName('ESTCLI').AsString;
      CLI.PESSOAS.RG := qrImport.FieldByName('REGCLI').AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE := qrImport.FieldByName('TELCLI').AsString;
      qrImport.Edit;
      qrImport.FieldByName('COD_PESSOA').AsInteger:=CLI.PESSOAS.COD_PESSOA;
      qrImport.Post;
      CLI.AppendOrEdit;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    CLI.ApplyUpdates;
    qrImport.ApplyUpdates();
    ConexaoGigaERP.ExecSQL(memoClientes.Text);
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmSGI.FORNECEDORES;
var
  FORN: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
  CPF: String;
  CNPJ: String;
  COD_PESSOA: Integer;
begin
  with DM do
  begin
    ConectaGiga;
    try
      ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_FORNECEDORES ADD COD_PESSOA INTEGER');
    except

    end;
    ConexaoGigaERP.ExecSQL(memoFornecedores.Text);
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
      FORN.PESSOAS.CHAVE_OLD := qrImport.FieldByName('CODFOR').AsString;
      if not qrImport.FieldByName('COD_PESSOA').IsNull then
      begin
        COD_PESSOA:=qrImport.FieldByName('COD_PESSOA').AsInteger;
        DM.ConexaoGigaERP.ExecSQL('UPDATE PESSOAS SET FLAG_FORNECEDOR = 1 WHERE COD_PESSOA ='+IntToStr(COD_PESSOA));
        qrFORNECEDORES.Append;
        qrFORNECEDORES.FieldByName('COD_FORNECEDOR').AsInteger := COD_PESSOA;
        qrFORNECEDORES.Post;
        qrImport.Next;
        Application.ProcessMessages;
        Continue;
      end;

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
    ConexaoGigaERP.ExecSQL(memoFornecedores.Text);
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmSGI.butImportarClick(Sender: TObject);
begin
  if cbSelect.Text='CLIENTES' then
    CLIENTES
  else if cbSelect.Text='FORNECEDORES' then
       FORNECEDORES
  else if cbSelect.Text='TRANSPORTADORAS' then
       TRANSPORTADORAS
  else if cbSelect.Text='GRUPOS_PRODUTOS' then
       GRUPOS_PRODUTO
  else if cbSelect.Text='PRODUTOS' then
       PRODUTOS
  else if cbSelect.Text='RECEBER' then
       RECEBER
end;

procedure TfrmSGI.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmSGI.GRUPOS_PRODUTO;
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

procedure TfrmSGI.PRODUTOS;
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
  DM.qrImport.Open('SELECT * FROM IMPORT_GRUPOS_PRODUTO');
  dm.qrImport.First;
  while not DM.qrImport.Eof do
  begin
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO GRUPOS_PRODUTO(COD_GRUPO, DESC_GRUPO,PERC_MARGEM)' +
                              'VALUES('+DM.qrImport.FieldByName('CODGRU').AsString+',''' +
                              DM.qrImport.FieldByName('NOMGRU').AsString+''',0)' +
                              'MATCHING(COD_GRUPO)');
    DM.qrImport.Next;
  end;
  //* MARCAS DE PRODUTOS *//
  DM.qrImport.Open('SELECT * FROM IMPORT_MARCAS');
  dm.qrImport.First;
  DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO)VALUES (1, ''MARCA'')MATCHING (COD_TABELA)');
  while not DM.qrImport.Eof do
  begin
    MARCA:=StringReplace(DM.qrImport.FieldByName('NOMSUB').AsString,'''',' ',[rfReplaceAll]);
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO)'+
                              'VALUES (1,'+DM.qrImport.FieldByName('CODSUB').AsString+','''+
                              MARCA+''')' +
                              'MATCHING (COD_TABELA, COD_TABELA_ITEM)');
    DM.qrImport.Next;
  end;
  try
    DM.ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_PRODUTOS ADD COD_PRODUTO VARCHAR(13)');
  except
  end;
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
    PROD.PRODUTOS.COD_PRODUTO:=IntToStr(I);
    PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO := dm.qrImport.FieldByName('CODMER').AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESMER').AsString;
    PROD.PRODUTOS.QTD_VOLUME := dm.qrImport.FieldByName('VOLUME').AsInteger;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE := dm.qrImport.FieldByName('UNDMER').AsString;
//    PROD.PRODUTOS_GRADE.QTD_ESTOQUE := dm.qrImport.FieldByName('QTDM01').AsFloat;
    PROD.PRODUTOS_GRADE.ESTOQUE_MIN := dm.qrImport.FieldByName('QTDMIN').AsFloat;
    PROD.PRODUTOS_GRADE.ESTOQUE_MAX := dm.qrImport.FieldByName('QTDMAX').AsFloat;
    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := dm.qrImport.FieldByName('CUSMER').AsFloat;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := dm.qrImport.FieldByName('PREMER').AsFloat;
    PROD.PRODUTOS_TAB_PRECOS_PROD[4].IniciarVariaveis;
    PROD.PRODUTOS_TAB_PRECOS_PROD[4].PRECO := dm.qrImport.FieldByName('PROMOC').AsFloat;
    PROD.AppendOrEdit;
    DM.qrImport.Edit;
    DM.qrImport.FieldByName('COD_PRODUTO').AsString:=StrZeros(PROD.PRODUTOS.COD_PRODUTO,13);
    DM.qrImport.Post;
    dm.qrImport.Next;
    Application.ProcessMessages;
  end;
  PROD.ApplyUpdates;
  DM.qrImport.ApplyUpdates();
  Gauge1.Progress:=Gauge1.MaxValue;
  MessageRaul_AVISO('PROCESSO CONCLUIDO...');
  Gauge1.Progress:=0;
  finally
    PROD.Free;
  end;
end;

procedure TfrmSGI.RECEBER;
var
  REC: TCadastro_Receber;
  CHAVE_OLD: String;
  DATA_NASC: String;
  COD_EMPRESA: String;
  VR_DIF: Real;
  COD_FATURA: Integer;
  I: Integer;
begin
  with DM do
  begin
    ConectaGiga;
    Label1.Caption:='AGUARDE... PREPARANDO TABELA IMPORT_RECEBER';
    Application.ProcessMessages;
    try
      ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_RECEBER ADD COD_PESSOA INTEGER');
    ConexaoGigaERP.ExecSQL(memoReceber.Text);
    except
    end;
//    MessageRaul_ATENCAO('TESTANDO 1000 ULTIMOS REGISTROS');
    qrImport.Open('SELECT                    '+
                  '    REC.CODEMP,           '+
                  '    REC.DATCAI,           '+
                  '    REC.NUMPED,           '+
                  '    REC.COD_PESSOA,       '+
                  '    SUM(REC.vallan) VALOR '+
                  'FROM IMPORT_RECEBER REC   '+
                  'WHERE REC.COD_PESSOA IS NOT NULL '+
                  '  AND REC.VALPAG = 0        '+
                  '  AND REC.NATFLU = 4        '+
                  '  AND REC.DATVEN > ''01.01.2016'' '+
//                  'AND REC.LANCTO > 137000 '+ //TETANDO OS 1000 ULTIMOS
                  'GROUP BY                  '+
                  '    REC.CODEMP,           '+
                  '    REC.DATCAI,           '+
                  '    REC.NUMPED,           '+
                  '    REC.COD_PESSOA        ');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;
    Gauge1.Progress:=0;
    REC:=TCadastro_Receber.Create;
    REC.Open;
    while not qrImport.Eof do
    begin
      Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);
      Gauge1.AddProgress(1);
      COD_FATURA:=DM.GeraCod('SFATURAS_RECEBER');
      REC.FATURAS_RECEBER.COD_FATURA:=COD_FATURA;
      CHAVE_OLD:= qrImport.FieldByName('NUMPED').AsString;
      REC.FATURAS_RECEBER.CHAVE_OLD := CHAVE_OLD;
      COD_EMPRESA:= qrImport.FieldByName('CODEMP').AsString;
      REC.FATURAS_RECEBER.COD_EMPRESA := qrImport.FieldByName('CODEMP').AsInteger;
      REC.FATURAS_RECEBER.CHAVE_OLD := CHAVE_OLD;
      REC.FATURAS_RECEBER.DATA_EMISSAO := qrImport.FieldByName('DATCAI').AsDateTime;
      REC.FATURAS_RECEBER.COD_CLIENTE := qrImport.FieldByName('COD_PESSOA').AsInteger;
      REC.FATURAS_RECEBER.VR_BRUTO := qrImport.FieldByName('VALOR').AsFloat;
      REC.AppendFatura;
      qrImportAux.Open('SELECT * FROM IMPORT_RECEBER WHERE VALPAG = 0 AND NATFLU = 4 AND NUMPED='+QuotedStr(CHAVE_OLD)+' AND CODEMP='+COD_EMPRESA);
      qrImportAux.First;
      I:=0;
      while not qrImportAux.Eof do
      begin
        Inc(I);
        REC.FATURAS_RECEBER_PARCELAS.IniciarVariaveis;
        REC.FATURAS_RECEBER_PARCELAS_BX.IniciarVariaveis;

        REC.FATURAS_RECEBER_PARCELAS.COD_FATURA := COD_FATURA;
        REC.FATURAS_RECEBER_PARCELAS.COD_EMPRESA := qrImportAux.FieldByName('CODEMP').AsInteger;
        REC.FATURAS_RECEBER_PARCELAS.CHAVE_OLD := qrImportAux.FieldByName('LANCTO').AsString;
        REC.FATURAS_RECEBER_PARCELAS.COD_PARC := IntToStr(I);
        REC.FATURAS_RECEBER_PARCELAS.VR_PARCELA := qrImportAux.FieldByName('VALLAN').AsFloat;
        REC.FATURAS_RECEBER_PARCELAS.DATA_VENCIMENTO := qrImportAux.FieldByName('DATVEN').AsDateTime;
        REC.FATURAS_RECEBER_PARCELAS.OBS := qrImportAux.FieldByName('HISFLU').AsString;

        REC.FATURAS_RECEBER_PARCELAS_BX.COD_FATURA := COD_FATURA;
        REC.FATURAS_RECEBER_PARCELAS_BX.COD_EMPRESA := qrImportAux.FieldByName('CODEMP').AsInteger;
        REC.FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA := qrImportAux.FieldByName('VALPAG').AsFloat;
        VR_DIF:= REC.FATURAS_RECEBER_PARCELAS.VR_PARCELA-REC.FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA;
        if (VR_DIF<0) then
        begin
          REC.FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA:=REC.FATURAS_RECEBER_PARCELAS.VR_PARCELA;
          REC.FATURAS_RECEBER_PARCELAS_BX.VR_ACRESCIMOS:=ABS(VR_DIF);
        end;
        if (VR_DIF>0) and (VR_DIF<1) then
        begin
          REC.FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA:=REC.FATURAS_RECEBER_PARCELAS.VR_PARCELA;
          REC.FATURAS_RECEBER_PARCELAS_BX.VR_DESCONTOS:=ABS(VR_DIF);
        end;

        if qrImportAux.FieldByName('DATPAG').AsString<>'' then REC.FATURAS_RECEBER_PARCELAS_BX.DATA_RECEBIMENTO := SE(qrImportAux.FieldByName('DATPAG').AsString<>'',qrImportAux.FieldByName('DATPAG').AsDateTime,Null);
        REC.AppendParcela;
        qrImportAux.Next;
        Application.ProcessMessages;
      end;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    Label1.Caption:='AGUARDE... APLICANDO ALTERAÇÕES';
    REC.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
    Label1.Caption:='';
  end;
end;

procedure TfrmSGI.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmSGI.TRANSPORTADORAS;
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

procedure TfrmSGI.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmSGI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.ConexaoGigaERP.Close;
end;

procedure TfrmSGI.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmSGI.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
