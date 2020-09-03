unit untCompusoft;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, Data.DB, Vcl.DBGrids, Vcl.CheckLst;
type
  TfrmCompusoft = class(TForm)
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
    memoSQL: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butGravarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure butImportClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure ConectaGiga;
    procedure InsereRelacionamentoClientes(COD_PESSOA, COD_TABELA, COD_TABELA_ITEM, DESC_TABELA_ITEM: STRING);
    procedure CLIENTES;
    procedure FORNECEDORES;
    procedure TRANSPORTADORAS;
    procedure GRUPOS_PRODUTOS;
    procedure PRODUTOS;
    procedure MARCAS;
    procedure PESSOAS; //QUANDO O MESMO CADASTRO PODE SER CLIENTE, FORNECEDOR E/OU TRANSPORTADORA
    procedure RECEBER;
    procedure PAGAR;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCompusoft: TfrmCompusoft;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmCompusoft.CLIENTES;
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

procedure TfrmCompusoft.FORNECEDORES;
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

procedure TfrmCompusoft.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmCompusoft.GRUPOS_PRODUTOS;
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

procedure TfrmCompusoft.InsereRelacionamentoClientes(COD_PESSOA, COD_TABELA, COD_TABELA_ITEM, DESC_TABELA_ITEM: STRING);
begin
  with DM do
  begin
    if (COD_TABELA_ITEM<>'') and (DESC_TABELA_ITEM<>'') then
    begin
      ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO) VALUES ('+COD_TABELA+', '+COD_TABELA_ITEM+', '''+DESC_TABELA_ITEM+''') MATCHING (COD_TABELA, COD_TABELA_ITEM);');
      if not qrCLIENTES_TABELA.Locate('COD_CLIENTE;COD_TABELA;COD_TABELA_ITEM',VarArrayOf([COD_PESSOA,COD_TABELA,COD_TABELA_ITEM]),[]) then
      begin
        qrCLIENTES_TABELA.Append;
        qrCLIENTES_TABELA.FieldByName('COD_CLIENTE').AsInteger:=StrToInt(COD_PESSOA);
        qrCLIENTES_TABELA.FieldByName('COD_TABELA').AsString:=COD_TABELA;
        qrCLIENTES_TABELA.FieldByName('COD_TABELA_ITEM').AsString:=COD_TABELA_ITEM;
        qrCLIENTES_TABELA.Post;
      end;
    end;
  end;
end;

procedure TfrmCompusoft.MARCAS;
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

procedure TfrmCompusoft.PAGAR;
var
  PAG: TCadastro_Pagar;
  CHAVE_OLD: String;
  DATA_NASC: String;
  COD_EMPRESA: String;
  VR_DIF: Real;
  COD_SEQUENCIA: Integer;
begin
  with DM do
  begin
    ConectaGiga;
    Label1.Caption:='PREPARANDO FORNECEDORES AGUARDE...';
    Application.ProcessMessages;
//    QR_GigaERP.Open( 'SELECT                                 '
//                  +'  PG.CODIGO, COUNT(*)                  '
//                  +'FROM IMPORT_PAGAR PG                   '
//                  +'LEFT JOIN FORNECEDORES F ON            '
//                  +'(F.COD_FORNECEDOR = PG.COD_FORNECEDOR) '
//                  +'WHERE F.COD_FORNECEDOR IS NULL         '
//                  +'GROUP BY PG.CODIGO                     ');
//    if QR_GigaERP.IsEmpty then
    if 1=2 then
    begin
      ConexaoGigaERP.ExecSQL(memoSQL.Text);
//    MessageRaul_ATENCAO('TESTANDO 1000 ULTIMOS REGISTROS');
      QR_GigaERP.Open( 'SELECT                                 '
                    +'  PG.CODIGO, COUNT(*)                  '
                    +'FROM IMPORT_PAGAR PG                   '
                    +'LEFT JOIN FORNECEDORES F ON            '
                    +'(F.COD_FORNECEDOR = PG.COD_FORNECEDOR) '
                    +'WHERE F.COD_FORNECEDOR IS NULL         '
                    +'GROUP BY PG.CODIGO                     ');
      if not QR_GigaERP.IsEmpty then
        raise Exception.Create('Existem Fornecedores não cadastrados');
    end;
    qrImport.Open( 'SELECT * FROM IMPORT_PAGAR');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;
    Gauge1.Progress:=0;
    PAG:=TCadastro_Pagar.Create;
    PAG.Open;
    while not qrImport.Eof do
    begin
      {PAUSA DEVIDO A VERIFICAÇÃO DO PORQUE EXISTEM FORNECEDORES NO CONTAS A PAGAR QUE NÃO VIERAM NO CLIENTES}
      Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);
      Gauge1.AddProgress(1);
      COD_SEQUENCIA:=DM.GeraCod('SFATURAS_PAGAR');
      PAG.FATURAS_PAGAR.COD_SEQUENCIA:=COD_SEQUENCIA;
      CHAVE_OLD:= qrImport.FieldByName('TIPO').AsString+'/'+qrImport.FieldByName('DOCTO').AsString;
      PAG.FATURAS_PAGAR.COD_EMPRESA := 1;
      PAG.FATURAS_PAGAR.CHAVE_OLD := CHAVE_OLD;
      PAG.FATURAS_PAGAR.DATA_EMISSAO := qrImport.FieldByName('EMISSAO').AsDateTime;
      PAG.FATURAS_PAGAR.COD_FORNECEDOR := qrImport.FieldByName('COD_FORNECEDOR').AsInteger;
//      PAG.FATURAS_PAGAR.VR_BRUTO := qrImport.FieldByName('VR_FATURA').AsFloat;
      PAG.FATURAS_PAGAR_PARCELAS.COD_SEQUENCIA := COD_SEQUENCIA;
      PAG.FATURAS_PAGAR_PARCELAS.COD_EMPRESA := 1;
      PAG.FATURAS_PAGAR_PARCELAS.CHAVE_OLD := CHAVE_OLD+'/'+qrImport.FieldByName('PARC').AsString;
      PAG.FATURAS_PAGAR_PARCELAS.COD_PARC := qrImport.FieldByName('PARC').AsString;
      PAG.FATURAS_PAGAR_PARCELAS.VR_PARCELA := qrImport.FieldByName('VR_PARCELA').AsFloat;
      PAG.FATURAS_PAGAR_PARCELAS.DATA_VENCIMENTO := qrImport.FieldByName('VCTO').AsDateTime;
      PAG.FATURAS_PAGAR_PARCELAS.OBS := qrImport.FieldByName('OBS').AsString;
      PAG.FATURAS_PAGAR_PARCELAS_BX.COD_SEQUENCIA := COD_SEQUENCIA;
      PAG.FATURAS_PAGAR_PARCELAS_BX.COD_EMPRESA := 1;
      PAG.FATURAS_PAGAR_PARCELAS_BX.VR_BAIXA := qrImport.FieldByName('VR_BAIXADO').AsFloat;
      PAG.FATURAS_PAGAR_PARCELAS_BX.VR_ACRESCIMOS:=SE(qrImport.FieldByName('VR_OCORRENCIA').AsFloat>0,qrImport.FieldByName('VR_OCORRENCIA').AsFloat,-99999);
      PAG.FATURAS_PAGAR_PARCELAS_BX.VR_DESCONTOS:=SE(qrImport.FieldByName('VR_OCORRENCIA').AsFloat<0,qrImport.FieldByName('VR_OCORRENCIA').AsFloat*(-1),-99999);
      PAG.FATURAS_PAGAR_PARCELAS_BX.DATA_PAGAMENTO := qrImport.FieldByName('DT_PAGTO').AsDateTime;
      PAG.AppendFatura;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    Label1.Caption:='AGUARDE... APLICANDO ALTERAÇÕES';
    Application.ProcessMessages;
    PAG.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
    Label1.Caption:='';
  end;
end;

procedure TfrmCompusoft.PESSOAS;
var
  PES: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
  CPF: String;
  CNPJ: String;
  COD_PESSOA: String;
  CIDADE: String;
  UF: String;
  COD_TABELA_ITEM: String;
  DESC_TABELA_ITEM: String;
  I: Integer;
  MAX_COD_PESSOA: Integer;
begin
  with DM do
  begin
    ConectaGiga;
//    try
//      ConexaoGigaERP.ExecSQL('ALTER TABLE IMPORT_CLIENTES ADD COD_PESSOA INTEGER');
//    except
//
//    end;
//      ConexaoGigaERP.ExecSQL('UPDATE IMPORT_CLIENTES C SET C.COD_PESSOA = SUBSTRING(C.RAZAO_SOCIAL FROM 1 FOR POSITION('-',C.RAZAO_SOCIAL)-1)');
    qrImport.Close;
    qrImport.Open('SELECT MAX(COD_PESSOA) COD FROM IMPORT_CLIENTES');
    MAX_COD_PESSOA:=qrImport.FieldByName('COD').AsInteger;
    qrImport.Close;
    qrImport.Open('SELECT * FROM IMPORT_CLIENTES');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;

    Gauge1.Progress:=0;
    PES:=TCadastro_Pessoas.Create;
    PES.TIPO_CADASTRO:=1;
    qrCLIENTES_TABELA.Open();
    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO) VALUES (1, ''TIPO FORNECEDOR'') MATCHING (COD_TABELA);');
    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO) VALUES (2, ''GRUPO TIPO FORNECEDOR'') MATCHING (COD_TABELA);');
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);
      COD_PESSOA:= qrImport.FieldByName('COD_PESSOA').AsString;
      PES.PESSOAS.CHAVE_OLD := COD_PESSOA;
      if StrToInt(COD_PESSOA)<4 then
        COD_PESSOA := IntToStr(StrToInt(COD_PESSOA)+MAX_COD_PESSOA);
      PES.PESSOAS.COD_PESSOA := StrToInt(COD_PESSOA);
      PES.PESSOAS.RAZAO_SOCIAL := StringReplace(qrImport.FieldByName('RAZAO_SOCIAL').AsString,COD_PESSOA+' - ','',[]);
      PES.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('NOME_FANTASIA').AsString;
      PES.PESSOAS.INSCR_ESTADUAL := qrImport.FieldByName('IE_RG').AsString;
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
        COD_TABELA_ITEM := Trim(qrImport.FieldByName('COD_TIPO_FORN_'+IntToStr(I)).AsString);
        DESC_TABELA_ITEM := Trim(Copy(qrImport.FieldByName('TIPO_FORNECEDOR_'+IntToStr(I)).AsString,0,30));
        InsereRelacionamentoClientes(COD_PESSOA,'1',COD_TABELA_ITEM,DESC_TABELA_ITEM);

        //GRUPO TIPO FORNECEDOR
        COD_TABELA_ITEM := Trim(qrImport.FieldByName('COD_GRUPO_TIPO_FORN_'+IntToStr(I)).AsString);
        DESC_TABELA_ITEM := Trim(Copy(qrImport.FieldByName('GRUPO_TIPO_FORNECEDOR_'+IntToStr(I)).AsString,0,30));
        InsereRelacionamentoClientes(COD_PESSOA,'2',COD_TABELA_ITEM,DESC_TABELA_ITEM);

      end;

      qrImport.Next;
      Application.ProcessMessages;
    end;
    try
      PES.ApplyUpdates;
      qrCLIENTES_TABELA.ApplyUpdates();
    except
      on E:Exception do
        raise Exception.Create(E.Message);
    end;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmCompusoft.PRODUTOS;
var
  PROD: TCadastro_Produtos;
  QTD: Double;
  COD: Integer;
  COD_GRADE: string;
  SQL: string;
  I: Integer;
  FAMILIA: String;
begin
  ConectaGiga;
  //* GRUPOS DE PRODUTOS *//
  DM.qrImport.Open('SELECT * FROM IMPORT_GRUPOS_PRODUTO');
  dm.qrImport.First;
  while not DM.qrImport.Eof do
  begin
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO GRUPOS_PRODUTO(COD_GRUPO, DESC_GRUPO,PERC_MARGEM)' +
                              'VALUES('+DM.qrImport.FieldByName('COD').AsString+',''' +
                              DM.qrImport.FieldByName('DESCRICAO').AsString+''',0)' +
                              'MATCHING(COD_GRUPO)');
    DM.qrImport.Next;
  end;
  {* MARCAS DE PRODUTOS *}
  DM.qrImport.Open('SELECT FAM FROM IMPORT_PRODUTOS GROUP BY FAM');
  dm.qrImport.First;
  DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO)VALUES (1, ''FAMILIA'')MATCHING (COD_TABELA)');
  while not DM.qrImport.Eof do
  begin
    FAMILIA:='FAMILIA '+DM.qrImport.FieldByName('FAM').AsString;
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA_ITEM (COD_TABELA, COD_TABELA_ITEM, DESCRICAO)'+
                              'VALUES (1,'+DM.qrImport.FieldByName('FAM').AsString+','''+
                              FAMILIA+''')' +
                              'MATCHING (COD_TABELA, COD_TABELA_ITEM)');
    DM.qrImport.Next;
  end;
  { VERIFICAR SE TODOS OS GRUPOS FORAM CDASTRADOS }
  DM.qrImport.Open('SELECT P.GRUPO FROM IMPORT_PRODUTOS P LEFT JOIN GRUPOS_PRODUTO G ON G.COD_GRUPO = P.GRUPO WHERE G.COD_GRUPO IS NULL');
  dm.qrImport.Last;
  if not DM.qrImport.IsEmpty then
  begin
    MessageRaul_ATENCAO('Existem GRUPOS nos cadastros do produtos que não estão cadastrados.');
    Exit;
  end;
  {VERIFICAR SE TODAS AS MARCAS FORAM CDASTRADAS}
  DM.qrImport.Open('SELECT P.FAM FROM IMPORT_PRODUTOS P LEFT JOIN TABELA_DO_SISTEMA_ITEM T ON T.COD_TABELA_ITEM = P.FAM WHERE T.COD_TABELA_ITEM IS NULL');
  dm.qrImport.Last;
  if not DM.qrImport.IsEmpty then
  begin
    MessageRaul_ATENCAO('Existem FAMILIAS nos cadastros do produtos que não estão cadastradas.');
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
//  PROD.CadastraRelacionamento(1,'FAMILIA');
  I:=0;
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption:=IntToStr(Gauge1.Progress)+'/'+IntToStr(Gauge1.MaxValue);

    Inc(I);
//    PROD.PRODUTOS.COD_PRODUTO:=IntToStr(I);
    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODIGO').AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('DESCRICAO').AsString;
    PROD.PRODUTOS_GRADE_UND[1].COD_PRODUTO := dm.qrImport.FieldByName('UND').AsString;
    PROD.PRODUTOS_TABELA[1].COD_TABELA_ITEM := dm.qrImport.FieldByName('FAM').AsInteger;
    PROD.PRODUTOS.COD_GRUPO := dm.qrImport.FieldByName('GRUPO').AsInteger;
    PROD.PRODUTOS.COD_CLASS := dm.qrImport.FieldByName('NCM').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('DESC_NCM').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('IPI').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ALM').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LOCAL').AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('GFM').AsString;
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

procedure TfrmCompusoft.RECEBER;
var
  REC: TCadastro_Receber;
  CHAVE_OLD: String;
  DATA_NASC: String;
  COD_EMPRESA: String;
  VR_DIF: Real;
  COD_FATURA: Integer;
begin
  with DM do
  begin
    ConectaGiga;
    Application.ProcessMessages;
//    MessageRaul_ATENCAO('TESTANDO 1000 ULTIMOS REGISTROS');
    qrImport.Open( 'SELECT                           '
                  +'    P.COD_PESSOA,                '
                  +'    R.TIPO,                      '
                  +'    R.DOCTO,                     '
                  +'    R.EMISSAO,                   '
                  +'    SUM(R.VR_PARCELA) VR_FATURA, '
                  +'    COUNT(*)                     '
                  +'FROM IMPORT_RECEBER R            '
                  +'LEFT JOIN PESSOAS P ON           '
                  +'(R.CODIGO = P.CHAVE_OLD)         '
                  +'WHERE R.VR_PARCELA > 0           '
                  +'GROUP BY                         '
                  +'    P.COD_PESSOA,                '
                  +'    R.TIPO,                      '
                  +'    R.EMISSAO,                   '
                  +'    R.DOCTO                      ');
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
      CHAVE_OLD:= qrImport.FieldByName('TIPO').AsString+'/'+qrImport.FieldByName('DOCTO').AsString;
      REC.FATURAS_RECEBER.COD_EMPRESA := 1;
      REC.FATURAS_RECEBER.CHAVE_OLD := CHAVE_OLD;
      REC.FATURAS_RECEBER.DATA_EMISSAO := qrImport.FieldByName('EMISSAO').AsDateTime;
      REC.FATURAS_RECEBER.COD_CLIENTE := qrImport.FieldByName('COD_PESSOA').AsInteger;
      REC.FATURAS_RECEBER.VR_BRUTO := qrImport.FieldByName('VR_FATURA').AsFloat;
      REC.AppendFatura;
      qrImportAux.Open('SELECT * FROM IMPORT_RECEBER WHERE TIPO='+qrImport.FieldByName('TIPO').AsString+' AND DOCTO='+qrImport.FieldByName('DOCTO').AsString);
      qrImportAux.First;
      while not qrImportAux.Eof do
      begin
        REC.FATURAS_RECEBER_PARCELAS.IniciarVariaveis;
        REC.FATURAS_RECEBER_PARCELAS_BX.IniciarVariaveis;

        REC.FATURAS_RECEBER_PARCELAS.COD_FATURA := COD_FATURA;
        REC.FATURAS_RECEBER_PARCELAS.COD_EMPRESA := 1;
        REC.FATURAS_RECEBER_PARCELAS.CHAVE_OLD := CHAVE_OLD+'/'+qrImportAux.FieldByName('PARC').AsString;
        REC.FATURAS_RECEBER_PARCELAS.COD_PARC := qrImportAux.FieldByName('PARC').AsString;
        REC.FATURAS_RECEBER_PARCELAS.VR_PARCELA := qrImportAux.FieldByName('VR_PARCELA').AsFloat;
        REC.FATURAS_RECEBER_PARCELAS.DATA_VENCIMENTO := qrImportAux.FieldByName('VCTO').AsDateTime;
        REC.FATURAS_RECEBER_PARCELAS.OBS := 'TIPO/DOCTO/PARC: '+REC.FATURAS_RECEBER_PARCELAS.CHAVE_OLD+#13+
          IfThen(qrImportAux.FieldByName('NR_NF').AsString<>'','NF: '+qrImportAux.FieldByName('NR_NF').AsString);
        REC.FATURAS_RECEBER_PARCELAS_BX.COD_FATURA := COD_FATURA;
        REC.FATURAS_RECEBER_PARCELAS_BX.COD_EMPRESA := 1;
        REC.FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA := qrImportAux.FieldByName('VR_BAIXADO').AsFloat;
        REC.FATURAS_RECEBER_PARCELAS_BX.VR_ACRESCIMOS:=SE(qrImportAux.FieldByName('VR_OCORRENCIA').AsFloat>0,qrImportAux.FieldByName('VR_OCORRENCIA').AsFloat,-99999);
        REC.FATURAS_RECEBER_PARCELAS_BX.VR_DESCONTOS:=SE(qrImportAux.FieldByName('VR_OCORRENCIA').AsFloat<0,qrImportAux.FieldByName('VR_OCORRENCIA').AsFloat*(-1),-99999);
        REC.FATURAS_RECEBER_PARCELAS_BX.DATA_RECEBIMENTO := qrImportAux.FieldByName('DT_PAGTO').AsDateTime;
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

procedure TfrmCompusoft.butImportClick(Sender: TObject);
begin
  if ComboBox1.Text='CLIENTES'        then CLIENTES        else
  if ComboBox1.Text='FORNECEDORES'    then FORNECEDORES    else
  if ComboBox1.Text='TRANSPORTADORAS' then TRANSPORTADORAS else
  if ComboBox1.Text='GRUPOS_PRODUTOS' then GRUPOS_PRODUTOS else
  if ComboBox1.Text='PRODUTOS'        then PRODUTOS        else
  if ComboBox1.Text='MARCAS'          then MARCAS          else
  if ComboBox1.Text='PESSOAS'         then PESSOAS         else
  if ComboBox1.Text='RECEBER'         then RECEBER         else
  if ComboBox1.Text='PAGAR'           then PAGAR           else
  MessageRaul_ATENCAO('Uma ação deve ser selecionada antes.');
end;

procedure TfrmCompusoft.Button1Click(Sender: TObject);
var
 s: TArray<string>;
 i: string;
begin
  SetLength(s,3);
  if InputQuery('Dados',['Nome:','End.:','OBS.:'],s) then
    for I in s do
        MessageRaul_AVISO(I);
end;

procedure TfrmCompusoft.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmCompusoft.TRANSPORTADORAS;
var
  TRANS: TCadastro_Pessoas;
  DATA_CAD: String;
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

procedure TfrmCompusoft.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmCompusoft.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmCompusoft.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
