unit untSoftLine;

interface

uses
  ShellAPI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul,
  Vcl.StdCtrls, StrUtils,
  Vcl.Samples.Gauges, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.StorageXML, JvComponentBase,
  JvAppStorage, JvAppIniStorage, System.ImageList, Vcl.ImgList;

type
  TfrmSoftLine = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    butRebuilder: TButton;
    butClientes: TButton;
    edtBancoGigaERP: TButtonedEdit;
    edtServer: TEdit;
    edtPorta: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    butFornecedores: TButton;
    CheckBox1: TCheckBox;
    butProdutos: TButton;
    edtDataCEP: TButtonedEdit;
    OpenDialog1: TOpenDialog;
    Label8: TLabel;
    edtNCMpadrao: TEdit;
    Label9: TLabel;
    edtLinha: TEdit;
    rbPessoas: TRadioButton;
    rbProdutos: TRadioButton;
    ComboBox1: TComboBox;
    Panel2: TPanel;
    Label1: TLabel;
    Gauge1: TGauge;
    cbGradeAtiva: TCheckBox;
    cbNovoCodCliente: TCheckBox;
    ButReceber: TButton;
    iniFile: TJvAppIniFileStorage;
    imgl1: TImageList;
    butCores: TButton;
    butTipo: TButton;
    butProdTemp: TButton;
    butGrupos: TButton;
    lb1: TLabel;
    edtCommit: TEdit;
    procedure butClientesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure butRebuilderClick(Sender: TObject);
    procedure edtBancoGigaERPRightButtonClick(Sender: TObject);
    procedure butFornecedoresClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure butProdutosClick(Sender: TObject);
    procedure butCoresClick(Sender: TObject);
    procedure butProdTempClick(Sender: TObject);
    procedure edtNCMpadraoExit(Sender: TObject);
    procedure rbPessoasClick(Sender: TObject);
    procedure rbProdutosClick(Sender: TObject);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure ButReceberClick(Sender: TObject);
    procedure butGruposClick(Sender: TObject);
    procedure butTipoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtServerExit(Sender: TObject);
  private
    { Private declarations }
  public
    function Rebuilder(Arq: String): String;
    procedure ConectGiga;
    procedure ConectaCEP;
    function IntToAlfa(I: integer): String;
    procedure AtribuiTabCombList;
    procedure AtribuiDataSet;
    procedure gravaParametros;
    procedure lerParametros;
    function VerifClassFiscal(COD_CLASS: String): String;
    { Public declarations }
  end;

var
  frmSoftLine: TfrmSoftLine;

implementation

{$R *.dfm}

uses untDM, unDmImagens;

{ TfrmSoftLine }

procedure TfrmSoftLine.butRebuilderClick(Sender: TObject);
var
  Arq: string;
begin
  try
    if OpenDialog1.Execute then
    begin
      gravaParametros;
      Arq := Rebuilder(OpenDialog1.FileName);
      if FileExists(Arq) then
        MessageRaul_AVISO('Arquivo gerado com sucesso.')
      else
        raise Exception.Create('Erro ao gerar arquivo.');
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TfrmSoftLine.butProdutosClick(Sender: TObject);
Var
  Arq, Erro, Grade, CodProd, Cod, Cor, CodCor, descricao, ncm, CodSoft: string;
  Prod: TStringList;
  I, countCommit, CodGrad, Cont, OldSisco, OldAux: integer;
  Error                             : boolean;
  PRODUTO                           : TCadastro_Produtos;
  UND                               : String;
  qtdCommit: Integer;
begin
  PRODUTO        := TCadastro_Produtos.Create;
  Label1.Caption := 'Localizando arquivo';
  Arq            := ExtractFilePath(Application.ExeName) + 'ArquivoTXT\GRADPROD.txt';
  if not FileExists(Arq) then
  begin
    if not OpenDialog1.Execute then
      exit;
    begin
      Label1.Caption := 'Convertendo Arquivo';
      Application.ProcessMessages;

      if UpperCase(ExtractFileExt(OpenDialog1.FileName)) = '.DAT' then
        Arq := Rebuilder(OpenDialog1.FileName)
      else
        raise Exception.Create('O arquivo deve conter a extensão .DAT');
    end;
    if Arq = '' then
    begin
      MessageDlg('Erro desconhecido ao tentar gerar txt.', mtError, [mbok], 0);
      exit;
    end;
    if Arq = 'Error' then
      exit;
  end;
  Label1.Caption := 'Arquivo Convertido. Preparando tabelas.';
  Application.ProcessMessages;
  ConectGiga;
  PRODUTO.Open;
  with DM do
  begin
    Prod  := TStringList.Create;
    Error := true;
    while Error do
    Begin
      try
        Prod.LoadFromFile(Arq);
        Error := false;
      Except
        Error := true;
      end;
      Application.ProcessMessages;
    End;
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO PRODUTOS_APELIDOS (COD_APELIDO, DESC_APELIDO) VALUES(4, ''Cod Fábrica'') MATCHING (COD_APELIDO);');
    PRODUTO.Cadastra_imposto_padrao;
    PRODUTO.Cadastra_imposto_padrao('2', 'SUBIST. TRIB.');
    PRODUTO.Cadastra_Grupo_Padrão;

    try
      QR_GigaERP.Close;
      QR_GigaERP.SQL.Text := 'SELECT LINHA FROM PRODUTOS_GRADE';
      QR_GigaERP.Open;
    Except
      on E: Exception do
      begin
        try
          ConexaoGigaERP.ExecSQL('ALTER TABLE PRODUTOS_GRADE ADD LINHA INTEGER');
        except

        end;
      end;
    end;

    I := strtoint(edtLinha.Text);
    if Prod.Count < I then
      Raise Exception.Create('Quantidade de linhas no arquivo menor que linha passada no Edit.');
    Gauge1.MaxValue := Prod.Count + 10;
    // Gauge1.MaxValue:=510;
    Gauge1.Progress := I;
  end;
  Label1.Caption := 'Inserindo Unidades de medidas.';
  DM.QR_GigaERP_Aux.Open('SELECT UND FROM IMPORT_PRODUTOS GROUP BY UND');
  DM.QR_GigaERP_Aux.First;
  while not DM.QR_GigaERP_Aux.Eof do
  begin
    PRODUTO.ConfereUND(DM.QR_GigaERP_Aux.FieldByName('UND').AsString);
    DM.QR_GigaERP_Aux.Next;
  end;
  DM.QR_GigaERP_Aux.Open('SELECT * FROM IMPORT_PRODUTOS');
  Cont := 0;

  DM.qrCLASS_FISCAIS.Close;
  DM.qrCLASS_FISCAIS.Open;
  if not DM.qrCLASS_FISCAIS.Locate('COD_CLASS','99',[]) then
    DM.ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO CLASS_FISCAIS (COD_CLASS, DESC_CLASS, FLAG_ATIVO) VALUES (''99'', ''OUTROS'', 1) MATCHING (COD_CLASS);');

   countCommit := 0;

  while (I < Prod.Count) do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption := 'Importando registros. ' + inttostr(I) + '/' + inttostr(Prod.Count);
    with DM do
    begin
      CodProd := StrZeros(Copy(Prod.Strings[I], 1, 6), 13);
      CodCor  := Copy(Prod.Strings[I], 77, 2);
      CodSoft := Copy(Prod.Strings[I], 1, 6) + Copy(Prod.Strings[I], 77, 2);
      // CodSoft := inttostr(I);

      QR_GigaERP.Close;
      QR_GigaERP.SQL.Clear;
      QR_GigaERP.SQL.Text := 'SELECT NOME_COR FROM IMPORT_CORES WHERE COD_COR =' + CodCor;
      QR_GigaERP.Open;
      Cor := QR_GigaERP.FieldByName('NOME_COR').AsString;
      if Trim(Cor) <> '' then
        Cor := 'COR: ' + Cor;

      if not QR_GigaERP_Aux.Locate('COD_PRODUTO', Copy(Prod.Strings[I], 1, 6), []) then
        Raise Exception.Create('Produto temp não localizado. Cod:' + Copy(Prod.Strings[I], 1, 6));

      PRODUTO.PRODUTOS.COD_PRODUTO               := StrZeros(CodSoft, 13);
      PRODUTO.PRODUTOS.DESC_PRODUTO              := QR_GigaERP_Aux.FieldByName('DESCRICAO').AsString + Cor;
      PRODUTO.PRODUTOS.COD_CLASS                 := QR_GigaERP_Aux.FieldByName('COD_CLASS').AsString;
      PRODUTO.PRODUTOS.COD_GRUPO                 := SE(QR_GigaERP_Aux.FieldByName('COD_GRUPO').AsInteger = 0, 1, QR_GigaERP_Aux.FieldByName('COD_GRUPO').AsInteger); // GRUPO
      PRODUTO.PRODUTOS.COD_IMPOSTO               := QR_GigaERP_Aux.FieldByName('COD_IMPOSTO').AsInteger; // GRUPO
      PRODUTO.PRODUTOS_TABELA[1].COD_TABELA_ITEM := QR_GigaERP_Aux.FieldByName('TIPO').AsInteger; // TIPO;
      UND                                        := Trim(DM.QR_GigaERP_Aux.FieldByName('UND').AsString);
    end;
    CodGrad := 1;
    Grade   := Copy(Prod.Strings[I], 395, 2);
    if Trim(Grade) = '' then
    begin
      if cbGradeAtiva.Checked then
        Grade := IntToAlfa(CodGrad)
      else
        Grade := '*';
    end;

    PRODUTO.PRODUTOS_GRADE.COD_GRADE := Grade;
    PRODUTO.PRODUTOS_GRADE.OBS       := CodSoft;

    PRODUTO.PRODUTOS_APELIDOS_PROD[2].APELIDO := Copy(Prod.Strings[I], 53, 13); // COD_BARRA
    PRODUTO.PRODUTOS_APELIDOS_PROD[3].APELIDO := Copy(Prod.Strings[I], 10, 20); // REFERENCIA
    PRODUTO.PRODUTOS_APELIDOS_PROD[4].APELIDO := Copy(Prod.Strings[I], 30, 20); // COD FABRICA

    PRODUTO.PRODUTOS_GRADE_UND[1].UNIDADE := UND;

    // Custo do Produto
    PRODUTO.PRODUTOS_CUSTO[1].PRECO_CUSTO := StrToFloat(Copy(Prod.Strings[I], 404, 5) + ',' + Copy(Prod.Strings[I], 409, 2));

    // Preço de Venda
    PRODUTO.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := StrToFloat(Copy(Prod.Strings[I], 219, 4) + ',' + Copy(Prod.Strings[I], 223, 2));

    // Preço de Venda
    PRODUTO.PRODUTOS_TAB_PRECOS_PROD[2].PRECO := StrToFloat(Copy(Prod.Strings[I], 400, 9) + ',' + Copy(Prod.Strings[I], 409, 2));

    PRODUTO.AppendOrEdit;

    Inc(I);
    Inc(countCommit);
    qtdCommit := StrToInt(edtCommit.Text);
    if (qtdCommit>0) and (countCommit = qtdCommit) then
    begin
      Label1.Caption := 'Gravando registros. ' + inttostr(I) + '/' + inttostr(Prod.Count)+' |'+FormatDateTime('hh:mm:ss',now);
      Application.ProcessMessages;
      PRODUTO.ApplyUpdates;
      countCommit := 0;
      DM.ConexaoGigaERP.ExecSQL('Update PRODUTOS_GRADE set LINHA = '+IntToStr(I)+' where COD_PRODUTO ='''+StrZeros(CodSoft, 13)+''' and COD_GRADE = '''+Grade+'''')
    end;
    Application.ProcessMessages;
  end;
  PRODUTO.ApplyUpdates;
  Gauge1.Progress := Gauge1.MaxValue;
  Label1.Caption  := 'Processo concluido.';
  MessageDlg('Processo concluido.', mtInformation, [mbok], 0);
end;

function TfrmSoftLine.IntToAlfa(I: integer): String;
begin
  Result := Copy('ABCDEFGHIJKLMNOPQRSTUVXYWZ', I, 1);
end;

procedure TfrmSoftLine.lerParametros;
begin
  edtDataCEP.Text      := iniFile.ReadString('dataCEP', 'C:\Gigatron\BaseCEP\datacep.fdb');
  edtBancoGigaERP.Text := iniFile.ReadString('GigaERP', 'C:\Gigatron\GigaERP\Base\GigaERP.fdb');
  edtServer.Text       := iniFile.ReadString('server', 'LocalHost');
  edtPorta.Text        := iniFile.ReadString('port', '3060');
  edtLogin.Text        := iniFile.ReadString('login', 'SYSDBA');
  edtSenha.Text        := iniFile.ReadString('senha', 'lib1503');
  edtNCMpadrao.Text    := iniFile.ReadString('ncm', '99');
  edtLinha.Text        := iniFile.ReadString('linha', '0');
  if Trim(edtLinha.Text)='' then
    edtLinha.Text := '0';
end;

procedure TfrmSoftLine.rbPessoasClick(Sender: TObject);
begin
  AtribuiTabCombList;
end;

procedure TfrmSoftLine.rbProdutosClick(Sender: TObject);
begin
  AtribuiTabCombList
end;

procedure TfrmSoftLine.butCoresClick(Sender: TObject);
var
  Arq  : string;
  Prod : TStringList;
  Error: boolean;
  I    : integer;
  Ext  : string;
begin
  try
    Label1.Caption := 'Localizando arquivo';
    Arq            := ExtractFilePath(Application.ExeName) + '\ArquivoTXT\CORES.txt';
    if not FileExists(Arq) then
    begin
      if not OpenDialog1.Execute then
        exit;
      begin
        Label1.Caption := 'Convertendo Arquivo';
        Application.ProcessMessages;
        Ext := UpperCase(ExtractFileExt(OpenDialog1.FileName));
        if UpperCase(ExtractFileExt(OpenDialog1.FileName)) = '.DAT' then
          Arq := Rebuilder(OpenDialog1.FileName)
        else
          Arq := OpenDialog1.FileName;
      end;
      if Arq = '' then
      begin
        MessageDlg('Erro desconhecido ao tentar gerar txt.', mtError, [mbok], 0);
        exit;
      end;
      if Arq = 'Error' then
        exit;
    end;

    Label1.Caption := 'Preparando tabelas.';
    Application.ProcessMessages;
    with DM do
    begin
      Prod  := TStringList.Create;
      Error := true;
      while Error do
      Begin
        try
          Prod.LoadFromFile(Arq);
          Error := false;
        Except
          Error := true;
        end;
        Application.ProcessMessages;
      End;
      ConectGiga;
      QR_GigaERP.Close;
      QR_GigaERP.SQL.Clear;
      QR_GigaERP.SQL.Text := 'SELECT RDB$RELATION_NAME ' + 'FROM RDB$RELATIONS       ' + 'WHERE RDB$FLAGS = 1      ' + 'AND RDB$VIEW_BLR IS NULL ' + 'AND RDB$RELATION_NAME = ''IMPORT_CORES''';
      // ShowMessage(QR_GigaERP.SQL.Text);
      QR_GigaERP.Open;
      if QR_GigaERP.RecordCount = 0 then
      begin
        ConexaoGigaERP.ExecSQL('CREATE TABLE IMPORT_CORES (COD_COR INTEGER NOT NULL, ' + 'NOME_COR VARCHAR(40));');

        ConexaoGigaERP.ExecSQL('alter table IMPORT_CORES                             ' + 'add constraint PK_IMPORT_CORES                       ' + 'primary key (COD_COR);                        ');
      end;
      QR_GigaERP.Close;
      QR_GigaERP.SQL.Text := 'SELECT * FROM IMPORT_CORES';
      QR_GigaERP.Open;
      QR_GigaERP.First;

      DBGrid1.DataSource  := DataSource1;
      DataSource1.DataSet := QR_GigaERP;

      Gauge1.MaxValue := Prod.Count + 10;
      Gauge1.Progress := 0;
      I               := 0;

      while I < Prod.Count - 1 do
      begin
        Gauge1.AddProgress(1);

        QR_GigaERP.Append;
        QR_GigaERP.FieldByName('COD_COR').AsString  := Copy(Prod.Strings[I], 1, 4);
        QR_GigaERP.FieldByName('NOME_COR').AsString := Copy(Prod.Strings[I], 5, 40);
        QR_GigaERP.Post;
        Inc(I);
        Application.ProcessMessages;
      end;
      QR_GigaERP.ApplyUpdates(-1);
      QR_GigaERP.Close;
      QR_GigaERP.Open;
      Gauge1.Progress := Gauge1.MaxValue;
      MessageDlg('Processo concluido.', mtInformation, [mbok], 0);
    end;
  Except
    on E: Exception do
      MessageDlg('Erro ao importar cores.' + #13 + 'Erro: ' + E.Message, mtError, [mbok], 0);
  end;
end;

procedure TfrmSoftLine.ButReceberClick(Sender: TObject);
var
  REC        : TCadastro_Receber;
  CHAVE_OLD  : String;
  DATA_NASC  : String;
  COD_EMPRESA: String;
  VR_DIF     : Real;
  COD_FATURA : integer;
begin
  //FATURAS A RECEBER, DEPENDE ANTES DE UMA IMPORTAÇÃO DE RELATÓRIO EM EXCEL PELO IB
  //POR ISSO ESSE BOTÃO NÃO ESTÁ DISPONÍVEL PARA DISTRIBUIÇÃO
  with DM do
  begin
    ConectGiga;
    Application.ProcessMessages;
    // MessageRaul_ATENCAO('TESTANDO 1000 ULTIMOS REGISTROS');
    qrImport.Open('SELECT                        ' + '    IR.COD_CLI,               ' + '    IR.EMPRESA,               ' + '    IR.DOCUMENTO,             ' + '    IR.NF,                    ' +
      '    IR.VENDA,                 ' + '    IR.LANCAMENTO,            ' + '    IR.EMISSAO,               ' + '    COUNT(*) QTD_PARC,        ' + '    SUM(IR.VR_DOCTO) VR_TOTAL ' +
      'FROM IMPORT_RECEBER IR        ' + 'LEFT JOIN PESSOAS P ON        ' + '(P.COD_PESSOA = IR.COD_CLI)   ' + 'GROUP BY                      ' + '    IR.COD_CLI,               ' +
      '    IR.EMPRESA,               ' + '    IR.DOCUMENTO,             ' + '    IR.NF,                    ' + '    IR.VENDA,                 ' + '    IR.LANCAMENTO,            ' +
      '    IR.EMISSAO                ');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue := qrImport.RecordCount + 1;
    Gauge1.Progress := 0;
    REC             := TCadastro_Receber.Create;
    REC.Open;
    while not qrImport.Eof do
    begin
      Label1.Caption := inttostr(Gauge1.Progress) + '/' + inttostr(Gauge1.MaxValue);
      Gauge1.AddProgress(1);
      COD_FATURA                       := DM.GeraCod('SFATURAS_RECEBER');
      REC.FATURAS_RECEBER.COD_FATURA   := COD_FATURA;
      REC.FATURAS_RECEBER.COD_EMPRESA  := 1;
      CHAVE_OLD                        := qrImport.FieldByName('DOCUMENTO').AsString;
      REC.FATURAS_RECEBER.CHAVE_OLD    := CHAVE_OLD;
      REC.FATURAS_RECEBER.DATA_EMISSAO := qrImport.FieldByName('EMISSAO').AsDateTime;
      REC.FATURAS_RECEBER.COD_CLIENTE  := qrImport.FieldByName('COD_CLI').AsInteger;
      REC.FATURAS_RECEBER.VR_BRUTO     := qrImport.FieldByName('VR_TOTAL').AsFloat;
      REC.AppendFatura;
      qrImportAux.Open('SELECT * FROM IMPORT_RECEBER WHERE DOCUMENTO=''' + qrImport.FieldByName('DOCUMENTO').AsString + '''');
      qrImportAux.First;
      while not qrImportAux.Eof do
      begin
        REC.FATURAS_RECEBER_PARCELAS.IniciarVariaveis;
        REC.FATURAS_RECEBER_PARCELAS_BX.IniciarVariaveis;

        REC.FATURAS_RECEBER_PARCELAS.COD_FATURA      := COD_FATURA;
        REC.FATURAS_RECEBER_PARCELAS.COD_EMPRESA     := 1;
        REC.FATURAS_RECEBER_PARCELAS.CHAVE_OLD       := CHAVE_OLD + '/' + qrImportAux.FieldByName('SERIE').AsString;
        REC.FATURAS_RECEBER_PARCELAS.COD_PARC        := qrImportAux.FieldByName('SERIE').AsString;
        REC.FATURAS_RECEBER_PARCELAS.VR_PARCELA      := qrImportAux.FieldByName('VR_DOCTO').AsFloat;
        REC.FATURAS_RECEBER_PARCELAS.DATA_VENCIMENTO := qrImportAux.FieldByName('VENCIMENTO').AsDateTime;
        REC.FATURAS_RECEBER_PARCELAS.OBS             := IfThen(qrImportAux.FieldByName('NF').AsString <> '', 'NF: ' + qrImportAux.FieldByName('NF').AsString + #13) +
          IfThen(qrImportAux.FieldByName('DUPLICATA').AsString <> '', 'DUPLICATA: ' + qrImportAux.FieldByName('DUPLICATA').AsString + #13) + IfThen(qrImportAux.FieldByName('VENDA').AsString <> '',
          'VENDA: ' + qrImportAux.FieldByName('VENDA').AsString + #13) + IfThen(qrImportAux.FieldByName('NOSSO_NUM').AsString <> '',
          'NOSSO NÚMERO: ' + qrImportAux.FieldByName('NOSSO_NUM').AsString + #13);
        if qrImportAux.FieldByName('VR_RECEBIDO').AsFloat > 0 then
        begin
          REC.FATURAS_RECEBER_PARCELAS_BX.COD_FATURA       := COD_FATURA;
          REC.FATURAS_RECEBER_PARCELAS_BX.COD_EMPRESA      := 1;
          REC.FATURAS_RECEBER_PARCELAS_BX.VR_BAIXA         := qrImportAux.FieldByName('VR_RECEBIDO').AsFloat;
          REC.FATURAS_RECEBER_PARCELAS_BX.DATA_RECEBIMENTO := qrImportAux.FieldByName('EMISSAO').AsDateTime;
        end;
        REC.AppendParcela;
        qrImportAux.Next;
        Application.ProcessMessages;
      end;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    Label1.Caption := 'AGUARDE... APLICANDO ALTERAÇÕES';
    REC.ApplyUpdates;
    Gauge1.Progress := Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress := 0;
    Label1.Caption  := '';
  end;
end;

procedure TfrmSoftLine.butTipoClick(Sender: TObject);
var
  Arq     : String;
  Tipos   : TStringList;
  Erro    : boolean;
  I       : integer;
  Cont    : integer;
  CodTipo : integer;
  DescTipo: String;
begin
  Label1.Caption := 'Localizando arquivo';
  Arq            := ExtractFilePath(Application.ExeName) + 'ArquivoTXT\TIPOS.txt';
  if not FileExists(Arq) then
  begin
    if not OpenDialog1.Execute then
      exit;
    begin
      Label1.Caption := 'Convertendo Arquivo';
      Application.ProcessMessages;

      if UpperCase(ExtractFileExt(OpenDialog1.FileName)) = '.DAT' then
        Arq := Rebuilder(OpenDialog1.FileName)
      else
        raise Exception.Create('O arquivo deve conter a extensão .DAT');
    end;
    if Arq = '' then
    begin
      MessageDlg('Erro desconhecido ao tentar gerar txt.', mtError, [mbok], 0);
      exit;
    end;
    if Arq = 'Error' then
      exit;
  end;
  Label1.Caption := 'Arquivo Convertido. Preparando tabelas.';
  Application.ProcessMessages;
  ConectGiga;
  with DM do
  begin
    Tipos := TStringList.Create;
    Erro  := true;
    while Erro do
    Begin
      try
        Tipos.LoadFromFile(Arq);
        Erro := false;
        if Tipos.Count = 0 then
        begin
          MessageRaul_ATENCAO('Nenhum Tipo cadastrado.');
          exit;
        end;
      Except
        Erro := true;
      end;
      Application.ProcessMessages;
    End;

    ConexaoGigaERP.ExecSQL('UPDATE OR INSERT INTO TABELA_DO_SISTEMA (COD_TABELA, DESCRICAO) VALUES (1, ''TIPO'') MATCHING (COD_TABELA);');
    QR_GigaERP.Close;
    QR_GigaERP.SQL.Text := 'SELECT * FROM TABELA_DO_SISTEMA_ITEM';
    QR_GigaERP.Open;

    I := strtoint(edtLinha.Text);
    if Tipos.Count < I then
      Raise Exception.Create('Quantidade de linhas no arquivo menor que linha passada no Edit.');
    Gauge1.MaxValue := Tipos.Count + 10;
    Gauge1.Progress := I;
  end;
  Cont := 0;
  while (I < Tipos.Count) do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption := 'Importando registros. ' + inttostr(I) + '/' + inttostr(Tipos.Count);
    with DM do
    begin
      CodTipo  := strtoint(Copy(Tipos.Strings[I], 1, 3));
      DescTipo := Copy(Tipos.Strings[I], 4, 40);
      QR_GigaERP.Append;
      QR_GigaERP.FieldByName('COD_TABELA').AsInteger      := 1;
      QR_GigaERP.FieldByName('COD_TABELA_ITEM').AsInteger := CodTipo;
      QR_GigaERP.FieldByName('DESCRICAO').AsString        := DescTipo;
      QR_GigaERP.Post;
    end;
    Inc(I);
    Application.ProcessMessages;
  end;
  DM.QR_GigaERP.ApplyUpdates;
  Gauge1.Progress := Gauge1.MaxValue;
  Label1.Caption  := 'Processo concluido.';
  MessageDlg('Processo concluido.', mtInformation, [mbok], 0);
end;

procedure TfrmSoftLine.butClientesClick(Sender: TObject);
var
  endereco, numero, doc, uf, ibge, cidade, Arq, cep, dia, mes, ano: string;
  I: integer;
  cli    : TStringList;
  cliente: TCadastro_Pessoas;
  Cod_cli: integer;
begin
  gravaParametros;
  ConectGiga;
  cliente := TCadastro_Pessoas.Create;
  try
    cliente.TIPO_CADASTRO := 1;
    Label1.Caption        := 'Localizando arquivo';
    Arq                   := ExtractFilePath(Application.ExeName) + '\ArquivoTXT\CLIENTES.txt';
    if not FileExists(Arq) then
    begin
      if not OpenDialog1.Execute then
        exit;
      begin
        Label1.Caption := 'Convertendo Arquivo';
        Application.ProcessMessages;
        Arq            := Rebuilder(OpenDialog1.FileName);
        Label1.Caption := 'Arquivo Convertido';
      end;
      Application.ProcessMessages;
      Label1.Caption := 'Importação';
      if Arq = '' then
      begin
        MessageDlg('Erro desconhecido ao tentar gerar txt.', mtError, [mbok], 0);
        exit;
      end;
      if Arq = 'Error' then
        exit;
      Application.ProcessMessages;
    end;
    try
      cli := TStringList.Create;
      cli.LoadFromFile(Arq);

      I := 1;

      Gauge1.MaxValue := cli.Count + 10;
      Gauge1.Progress := 0;
      Label1.Caption  := 'Numero de linhas: ' + inttostr(cli.Count);
      ConectaCEP;
      cliente.Open;

      /// LOOP ///
      while (I < cli.Count - 1) do
      begin
        Gauge1.AddProgress(1);
        Label1.Caption := 'Importando Registro: ' + inttostr(I + 3);

        if Copy(cli.Strings[I], 376, 1) = '1' then
        begin
          cliente.PESSOAS.TIPO_CLASSIFICACAO := 1;
          cliente.PESSOAS.CNPJ_CPF           := RetiraNaoNumero(Copy(cli.Strings[I], 377, 14));
        end
        else
        begin
          cliente.PESSOAS.TIPO_CLASSIFICACAO := 0;
          cliente.PESSOAS.CNPJ_CPF           := RetiraNaoNumero(Copy(cli.Strings[I], 380, 11));
        end;

        // ShowMessage(Copy(cli.Strings[I], 1, 7));
        Cod_cli                   := strtoint(Copy(cli.Strings[I], 1, 7));
        cliente.PESSOAS.CHAVE_OLD := inttostr(Cod_cli);
        if not cbNovoCodCliente.Checked then
        begin
          if Cod_cli < 4 then
            Cod_cli                  := Cod_cli + cli.Count;
          cliente.PESSOAS.COD_PESSOA := Cod_cli;
        end;

        cliente.PESSOAS.RAZAO_SOCIAL  := Copy(cli.Strings[I], 8, 65);
        cliente.PESSOAS.NOME_FANTASIA := Copy(cli.Strings[I], 73, 30);

        if Trim(cliente.PESSOAS.NOME_FANTASIA) = '' then
          cliente.PESSOAS.NOME_FANTASIA := cliente.PESSOAS.RAZAO_SOCIAL;

        { if Copy(cli.Strings[i], 6, 1) = 'F' then
          cliente.TIPO_PESSOA := 0
          else
          cliente.TIPO_PESSOA := 1;
        }
        endereco := Copy(cli.Strings[I], 103, 40);
        numero   := '';
        cep      := Copy(cli.Strings[I], 209, 8);

        cidade := 'BIRIGUI';
        uf     := 'SP';

        if endereco <> '' then
        begin
          DM.qrDataCEP.Close;
          DM.qrDataCEP.ParamByName('CEP').AsString := cep;
          DM.qrDataCEP.Open();
          if DM.qrDataCEP.RecordCount > 0 then
          begin
            cidade := DM.qrDataCEP.FieldByName('NOME').AsString;
            ibge   := DM.qrDataCEP.FieldByName('COD_IBGE').AsString;
            uf     := DM.qrDataCEP.FieldByName('UF').AsString;
          END;
          // TratarEndereco(endereco,numero);
        end;

        // cidade   := SQLQuery1.FieldByName('NOME').AsString;
        if Trim(ibge) = '' then
          ibge := '3506508';

        cliente.PESSOAS_ENDERECOS[1].SEQ_PES_END := 1; // Endereco principal
        cliente.PESSOAS_ENDERECOS[1].COD_MUNIC   := ibge;
        // cliente.COD_CIDADE_ENTREGA    := StrToInt(ibge);
        // cliente.COD_CIDADE_COBRANCA   := StrToInt(ibge);
        // cliente.UF                    := uf;
        // cliente.CIDADE                := cidade;

        { if Busca_IBGE(ibge, uf, cidade) then
          begin
          cliente.COD_CIDADE            := StrToInt(ibge);
          cliente.COD_CIDADE_ENTREGA    := StrToInt(ibge);
          cliente.COD_CIDADE_COBRANCA   := StrToInt(ibge);
          cliente.UF                    := uf;
          cliente.CIDADE                := cidade;
          end
          else
          begin
          cliente.CIDADE                := 'BIRIGUI';
          cliente.UF                    := 'SP';
          end;
        }
        cliente.PESSOAS_ENDERECOS[1].endereco := endereco;
        cliente.PESSOAS_ENDERECOS[1].numero   := numero;
        cliente.PESSOAS_ENDERECOS[1].BAIRRO   := Copy(cli.Strings[I], 163, 20);
        cliente.PESSOAS_ENDERECOS[1].cep      := cep;
        cliente.PESSOAS_ENDERECOS[1].TELEFONE := RetiraNaoNumero(Copy(cli.Strings[I], 331, 15));
        cliente.PESSOAS_CONTATOS[1].TELEFONE  := RetiraNaoNumero(Copy(cli.Strings[I], 346, 15));
        // cliente.FAX           := RetiraCaracterNaoNumero  (Copy(cli.Strings[i], 305, 12));
        cliente.PESSOAS_CONTATOS[1].CELULAR := RetiraNaoNumero(Copy(cli.Strings[I], 361, 12));
        cliente.PESSOAS.INSCR_ESTADUAL      := RetiraNaoNumero(Copy(cli.Strings[I], 391, 18));

        // ENDEREÇO DE ENTREGA
        // cliente.ENDERECO_ENTREGA     := cliente.ENDERECO;
        // cliente.END_ENTREGA_NUMERO   := cliente.END_NUMERO;
        // cliente.BAIRRO_ENTREGA       := cliente.BAIRRO;
        // cliente.CIDADE_ENTREGA       := cliente.CIDADE;
        // cliente.UF_ENTREGA           := cliente.UF;
        // cliente.CEP_ENTREGA          := cliente.CEP;

        // ENDEREÇO DE COBRANÇA
        // cliente.ENDERECO_COBRANCA    := cliente.ENDERECO;
        // cliente.END_COBRANCA_NUMERO  := cliente.END_NUMERO;
        // cliente.BAIRRO_COBRANCA      := cliente.BAIRRO;
        // cliente.CIDADE_COBRANCA      := cliente.CIDADE;
        // cliente.UF_COBRANCA          := cliente.UF;
        // cliente.CEP_COBRANCA         := cliente.CEP;

        // cliente.CONTATO := Copy(cli.Strings[i], 355, 45);

        dia := Copy(cli.Strings[I], 667, 2);
        mes := Copy(cli.Strings[I], 665, 2);
        ano := Copy(cli.Strings[I], 661, 4);
        if dia = '00' then
          dia := '01';
        if mes = '00' then
          mes := '01';
        if ano = '0000' then
          ano                         := '1900';
        cliente.PESSOAS.DATA_CADASTRO := StrToDate(dia + '/' + mes + '/' + ano);

        cliente.PESSOAS.DATA_ALTERACAO := date;

        /// /TRATAMENTOS/////
        if Trim(cliente.PESSOAS.RAZAO_SOCIAL) = '' then
        begin
          Inc(I);
          continue;
        end;
        cliente.AppendOrEdit;
        Inc(I);
        Application.ProcessMessages;
      end;
    finally
      cli.Free;
    end;
    cliente.ApplyUpdates;
    Gauge1.Progress := Gauge1.MaxValue;
    MessageDlg('Processo comcluido.', mtInformation, [mbok], 0);
  finally
    cliente.Free;
  end;
end;

procedure TfrmSoftLine.butProdTempClick(Sender: TObject);
Var
  Arq, Erro, ncm: string;
  Prod          : TStringList;
  I             : integer;
begin
  inherited;
  gravaParametros;
  Label1.Caption := 'Localizando arquivo';
  Arq            := ExtractFilePath(Application.ExeName) + '\ArquivoTXT\PRODUTOS.txt';
  if not FileExists(Arq) then
  begin
    if not OpenDialog1.Execute then
      exit;
    begin
      Label1.Caption := 'Convertendo Arquivo';
      Application.ProcessMessages;
      Arq := Rebuilder(OpenDialog1.FileName);
    end;
    if Arq = '' then
    begin
      MessageDlg('Erro desconhecido ao tentar gerar txt.', mtError, [mbok], 0);
      exit;
    end;
    if Arq = 'Error' then
      exit;
  end;
  Label1.Caption := 'Arquivo Convertido. Preparando tabelas.';
  Application.ProcessMessages;
  with DM do
  begin
    Prod := TStringList.Create;
    Prod.LoadFromFile(Arq);
    ConectGiga;
    QR_GigaERP.Close;
    QR_GigaERP.SQL.Clear;
    QR_GigaERP.SQL.Text := 'SELECT RDB$RELATION_NAME FROM RDB$RELATIONS ' + 'WHERE RDB$FLAGS = 1 AND RDB$VIEW_BLR IS NULL ' + 'AND RDB$RELATION_NAME = ''IMPORT_PRODUTOS''';
    QR_GigaERP.Open;
    if QR_GigaERP.RecordCount = 0 then
    begin
      ConexaoGigaERP.ExecSQL
        ('CREATE TABLE IMPORT_PRODUTOS (COD_PRODUTO INTEGER NOT NULL, DESCRICAO VARCHAR(40), COD_CLASS VARCHAR(8), NCM VARCHAR(8), UND VARCHAR(20), COD_GRUPO INT, COD_IMPOSTO INT, TIPO INT);');

      ConexaoGigaERP.ExecSQL('alter table IMPORT_PRODUTOS add constraint PK_IMPORT_PRODUTOS primary key (COD_PRODUTO);');
    end;

    Application.ProcessMessages;
    QR_GigaERP.Close;
    QR_GigaERP.SQL.Text := 'SELECT * FROM IMPORT_PRODUTOS';
    QR_GigaERP.Open;
    QR_GigaERP.First;
    DBGrid1.DataSource  := DataSource1;
    DataSource1.DataSet := QR_GigaERP;

    QR_GigaERP_Aux.Close;
    QR_GigaERP_Aux.SQL.Text := 'SELECT * FROM CLASS_FISCAIS';
    QR_GigaERP_Aux.Open;
    QR_GigaERP_Aux.First;

    Gauge1.MaxValue := Prod.Count + 10;
    Gauge1.Progress := 0;
  end;

  I := 0;
  try
    while (I < Prod.Count) do
    // while (I < 101) do
    begin
      Gauge1.AddProgress(1);
      Label1.Caption := 'Importando registros. ' + inttostr(I) + '/' + inttostr(Prod.Count);
      with DM.QR_GigaERP do
      begin
        Append;
        FieldByName('COD_PRODUTO').AsString := Copy(Prod.Strings[I], 1, 6);
        FieldByName('DESCRICAO').AsString   := Retira_Acento(UpperCase(Copy(Prod.Strings[I], 7, 40)));
        FieldByName('UND').AsString         := Trim(Copy(Prod.Strings[I], 109, 5));
        FieldByName('COD_GRUPO').AsInteger  := strtoint(Copy(Prod.Strings[I], 81, 13)); // GRUPO
        FieldByName('TIPO').AsInteger       := strtoint(Copy(Prod.Strings[I], 67, 3)); // TIPO
        if Copy(Prod.Strings[I], 104, 1) = 'T' then
          FieldByName('COD_IMPOSTO').AsInteger := 1
        else
          FieldByName('COD_IMPOSTO').AsInteger := 2;
        ncm                                    := Copy(Prod.Strings[I], 407, 8);
        if DM.QR_GigaERP_Aux.Locate('COD_CLASS', ncm, []) then
          FieldByName('COD_CLASS').AsString := ncm
        else
          FieldByName('COD_CLASS').AsString   := edtNCMpadrao.Text;
        FieldByName('NCM').AsString := ncm;
        Post;
      end;
      Inc(I);
      Application.ProcessMessages;
    end;

    DM.QR_GigaERP.ApplyUpdates(-1);
    DM.QR_GigaERP.Close;
    DM.QR_GigaERP.Open;

    Gauge1.Progress := Gauge1.MaxValue;
    MessageDlg('Processo concluido.', mtInformation, [mbok], 0);
    butProdutos.Enabled := True;
  Except
    on E: Exception do
      MessageDlg('Erro ao importar. ' + Erro + #13 + 'Erro: ' + E.Message, mtError, [mbok], 0);
  end;
end;

procedure TfrmSoftLine.AtribuiTabCombList;
begin
  if rbPessoas.Checked then
  begin
    ComboBox1.Items.Clear;
    ComboBox1.Items.Insert(0, 'PESSOAS');
    ComboBox1.Items.Insert(1, 'PESSOAS_CONTATOS');
    ComboBox1.Items.Insert(2, 'PESSOAS_ENDERECOS');
    ComboBox1.Items.Insert(3, 'CLIENTES');
    ComboBox1.Items.Insert(4, 'FORNECEDORES');
  end;
  if rbProdutos.Checked then
  begin
    ComboBox1.Items.Clear;
    ComboBox1.Items.Insert(0, 'PRODUTOS');
    ComboBox1.Items.Insert(1, 'PRODUTOS_GRADE');
    ComboBox1.Items.Insert(2, 'PRODUTOS_CUSTO');
    ComboBox1.Items.Insert(3, 'PRODUTOS_GRADE_UND');
    ComboBox1.Items.Insert(4, 'PRODUTOS_APELIDOS_PROD');
    ComboBox1.Items.Insert(5, 'PRODUTOS_TAB_PRECOS_PROD');
    ComboBox1.Items.Insert(6, 'PRODUTOS_TABELA');
  end;
  ComboBox1.ItemIndex := 0;
  AtribuiDataSet;
  ComboBox1.Visible := true;
end;

procedure TfrmSoftLine.AtribuiDataSet;
begin
  if rbPessoas.Checked then
  begin
    case ComboBox1.ItemIndex of
      0:
        DataSource1.DataSet := DM.qrPESSOAS;
      1:
        DataSource1.DataSet := DM.qrPESSOAS_CONTATOS;
      2:
        DataSource1.DataSet := DM.qrPESSOAS_ENDERECOS;
      3:
        DataSource1.DataSet := DM.qrCLIENTES;
      4:
        DataSource1.DataSet := DM.qrFORNECEDORES;
    end;
  end;
  if rbProdutos.Checked then
  begin
    case ComboBox1.ItemIndex of
      0:
        DataSource1.DataSet := DM.qrPRODUTOS;
      1:
        DataSource1.DataSet := DM.qrPRODUTOS_GRADE;
      2:
        DataSource1.DataSet := DM.qrPRODUTOS_CUSTO;
      3:
        DataSource1.DataSet := DM.qrPRODUTOS_GRADE_UND;
      4:
        DataSource1.DataSet := DM.qrPRODUTOS_APELIDOS_PROD;
      5:
        DataSource1.DataSet := DM.qrPRODUTOS_TAB_PRECOS_PROD;
      6:
        DataSource1.DataSet := DM.qrPRODUTOS_TABELA;
    end;
  end;
end;

procedure TfrmSoftLine.butFornecedoresClick(Sender: TObject);
var
  endereco, numero, fantasia, doc, uf, ibge, cidade, cep, Arq, cnpj: string;
  I, tipopessoa: integer;
  cli       : TStringList;
  Fornecedor: TCadastro_Pessoas;
begin
  gravaParametros;
  ConectGiga;
  Fornecedor := TCadastro_Pessoas.Create;
  try
    Fornecedor.TIPO_CADASTRO := 2;
    inherited;
    Label1.Caption := 'Localizando arquivo';
    Arq            := ExtractFilePath(Application.ExeName) + '\ArquivoTXT\FORNECE.txt';
    if not FileExists(Arq) then
    begin
      if not OpenDialog1.Execute then
        exit;
      begin
        Label1.Caption := 'Convertendo Arquivo';
        Application.ProcessMessages;
        Arq            := Rebuilder(OpenDialog1.FileName);
        Label1.Caption := 'Arquivo Convertido';
      end;
      Application.ProcessMessages;
      Label1.Caption := 'Importação';
      if Arq = '' then
      begin
        MessageDlg('Erro desconhecido ao tentar gerar txt.', mtError, [mbok], 0);
        exit;
      end;
      if Arq = 'Error' then
        exit;
    end;
    Application.ProcessMessages;

    try
      cli := TStringList.Create;
      cli.LoadFromFile(Arq);
      Fornecedor.Open;
      ConectaCEP;
      DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
      I := 1;

      Gauge1.MaxValue := cli.Count + 10;
      Gauge1.Progress := 0;
      Label1.Caption  := 'Numero de linhas: ' + inttostr(cli.Count);

      while (I < cli.Count - 1) do
      begin
        if Trim(Retira_Acento(Copy(cli.Strings[I], 7, 40))) = '' then
        begin
          Inc(I);
          continue;
        end;
        Gauge1.AddProgress(1);
        Label1.Caption := 'Importando Registro: ' + inttostr(I + 1);
        if Copy(cli.Strings[I], 205, 1) = '1' then
        begin
          tipopessoa := 1;
          cnpj       := RetiraNaoNumero(Copy(cli.Strings[I], 206, 14));
        end
        else
        begin
          tipopessoa := 0;
          cnpj       := RetiraNaoNumero(Copy(cli.Strings[I], 209, 11));
        end;
        with Fornecedor do
        begin

          PESSOAS.RAZAO_SOCIAL := Retira_Acento(Copy(cli.Strings[I], 7, 40));
          fantasia             := Retira_Acento(Copy(cli.Strings[I], 52, 40));
          if Trim(fantasia) = '' then
            fantasia                 := Retira_Acento(Copy(cli.Strings[I], 7, 40));
          PESSOAS.NOME_FANTASIA      := fantasia;
          PESSOAS.CNPJ_CPF           := RetiraNaoNumero(cnpj);
          PESSOAS.INSCR_ESTADUAL     := RetiraNaoNumero(Copy(cli.Strings[I], 220, 14));
          PESSOAS.TIPO_CLASSIFICACAO := tipopessoa;

          endereco := Retira_Acento(Copy(cli.Strings[I], 104, 35));
          numero   := '';
          // TratarEndereco(endereco,numero);
          PESSOAS_ENDERECOS[1].SEQ_PES_END := 1;
          PESSOAS_ENDERECOS[1].endereco    := endereco;
          PESSOAS_ENDERECOS[1].numero      := numero;
          cep                              := Copy(cli.Strings[I], 163, 8);

          DM.qrDataCEP.Close;
          DM.qrDataCEP.ParamByName('CEP').AsString := cep;
          DM.qrDataCEP.Open();

          // FieldByName('CIDADE'        ).AsString    := 'BIRIGUI';
          // FieldByName('UF'            ).AsString    := 'SP';
          PESSOAS_ENDERECOS[1].COD_MUNIC := '3506508';

          PESSOAS_ENDERECOS[1].cep      := cep;
          PESSOAS_ENDERECOS[1].BAIRRO   := UpperCase(Retira_Acento(Copy(cli.Strings[I], 104, 35)));
          PESSOAS_ENDERECOS[1].TELEFONE := RetiraNaoNumero(Copy(cli.Strings[I], 175, 13));
          PESSOAS_ENDERECOS[1].FAX      := '';
          PESSOAS_CONTATOS[1].CELULAR   := RetiraNaoNumero(Copy(cli.Strings[I], 190, 13));
          PESSOAS.EMAIL                 := '';
          PESSOAS.DATA_CADASTRO         := now;
          Fornecedor.AppendOrEdit;
        end;
        // DMSisco.setar_Fornecedor(Fornecedor);
        Inc(I);
        Application.ProcessMessages;
      end;

    finally
      cli.Free;
    end;
    Fornecedor.ApplyUpdates;
    Gauge1.Progress := Gauge1.MaxValue;
    MessageDlg('Processo comcluido.', mtInformation, [mbok], 0);
  finally
    Fornecedor.Free;
  end;
end;

procedure TfrmSoftLine.butGruposClick(Sender: TObject);
var
  Arq      : String;
  Grupos   : TStringList;
  Erro     : boolean;
  I        : integer;
  Cont     : integer;
  CodGrupo : integer;
  DescGrupo: String;
begin
  try
  Label1.Caption := 'Localizando arquivo';
  Arq            := ExtractFilePath(Application.ExeName) + 'ArquivoTXT\GRUPOS.txt';
  if not FileExists(Arq) then
  begin
    if not OpenDialog1.Execute then
      exit;
    begin
      Label1.Caption := 'Convertendo Arquivo';
      Application.ProcessMessages;

      if UpperCase(ExtractFileExt(OpenDialog1.FileName)) = '.DAT' then
        Arq := Rebuilder(OpenDialog1.FileName)
      else
        raise Exception.Create('O arquivo deve conter a extensão .DAT');
    end;
    if Arq = '' then
    begin
      MessageDlg('Erro desconhecido ao tentar gerar txt.', mtError, [mbok], 0);
      exit;
    end;
    if Arq = 'Error' then
      exit;
  end;
  Label1.Caption := 'Arquivo Convertido. Preparando tabelas.';
  Application.ProcessMessages;
  ConectGiga;
  with DM do
  begin
    Grupos := TStringList.Create;
    Erro   := true;
    while Erro do
    Begin
      try
        Grupos.LoadFromFile(Arq);
        Erro := false;
      Except
        Erro := true;
      end;
      Application.ProcessMessages;
    End;
    QR_GigaERP.Close;
    QR_GigaERP.SQL.Text := 'SELECT * FROM GRUPOS_PRODUTO';
    QR_GigaERP.Open;

    if Trim(edtLinha.Text)='' then
      I := 0
    else
      I := strtoint(edtLinha.Text);

    if Grupos.Count < I then
      Raise Exception.Create('Quantidade de linhas no arquivo menor que linha passada no Edit.');
    Gauge1.MaxValue := Grupos.Count + 10;
    Gauge1.Progress := I;
  end;
  Cont := 0;
  while (I < Grupos.Count) do
  begin
    Gauge1.AddProgress(1);
    Label1.Caption := 'Importando registros. ' + inttostr(I) + '/' + inttostr(Grupos.Count);
    with DM do
    begin
      CodGrupo  := strtoint(Copy(Grupos.Strings[I], 1, 5));
      DescGrupo := Copy(Grupos.Strings[I], 6, 40);
      QR_GigaERP.Append;
      QR_GigaERP.FieldByName('COD_GRUPO').AsInteger   := CodGrupo;
      QR_GigaERP.FieldByName('DESC_GRUPO').AsString   := DescGrupo;
      QR_GigaERP.FieldByName('PERC_MARGEM').AsInteger := 0;
      QR_GigaERP.Post;
    end;
    Inc(I);
    Application.ProcessMessages;
  end;
  DM.QR_GigaERP.ApplyUpdates;
  Gauge1.Progress := Gauge1.MaxValue;
  Label1.Caption  := 'Processo concluido.';
  MessageDlg('Processo concluido.', mtInformation, [mbok], 0);
  except
    on E:Exception do
      raise Exception.Create('COD_GRUPO: '+IntToSTR(CodGrupo)+#13+
                             'DESC_GRUPO:'+DescGrupo+#13+
                             E.Message);

  end;
end;

procedure TfrmSoftLine.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    AtribuiTabCombList;
    DBGrid1.Visible := true;
    Self.Height     := Panel1.Height + Panel2.Height + 200;
  end
  else
  begin
    Self.Height         := Panel1.Height + Panel2.Height;
    DBGrid1.Visible     := false;
    DataSource1.DataSet := nil;
    ComboBox1.Visible   := false;
  end;
end;

procedure TfrmSoftLine.ComboBox1CloseUp(Sender: TObject);
begin
  AtribuiDataSet;
end;

procedure TfrmSoftLine.ConectaCEP;
begin
  DM.ConectaCEP(edtDataCEP.Text, edtPorta.Text, edtServer.Text, edtLogin.Text, edtSenha.Text);
end;

procedure TfrmSoftLine.ConectGiga;
begin
  DM.Base     := edtBancoGigaERP.Text;
  DM.Port     := edtPorta.Text;
  DM.Server   := edtServer.Text;
  DM.User     := edtLogin.Text;
  DM.Password := edtSenha.Text;
  DM.ConnectaGigaERP;
end;

procedure TfrmSoftLine.edtBancoGigaERPRightButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    (Sender as TButtonedEdit).Text := OpenDialog1.FileName;
    gravaParametros;
  end;
end;

procedure TfrmSoftLine.edtNCMpadraoExit(Sender: TObject);
begin
  if Trim(edtNCMpadrao.Text) = '' then
    edtNCMpadrao.Text := '99';
end;

procedure TfrmSoftLine.edtServerExit(Sender: TObject);
begin
  gravaParametros;
end;

procedure TfrmSoftLine.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.ConexaoGigaERP.Close;
end;

procedure TfrmSoftLine.FormCreate(Sender: TObject);
begin
  VerificaFREE;
  lerParametros;
  Self.Caption := 'Importador do SoftLine para o GigaERP (Versão: '+VersaoEXE+')';
  Self.Height         := Panel1.Height + Panel2.Height + 35;
  DBGrid1.Visible     := false;
  DataSource1.DataSet := nil;
  ComboBox1.Visible   := false;
end;

procedure TfrmSoftLine.FormDestroy(Sender: TObject);
begin
  gravaParametros;
end;

procedure TfrmSoftLine.FormShow(Sender: TObject);
begin
  // Self.Height := Panel1.Height+Panel2.Height;
  Label1.Caption := '';
  // DBGrid1.Visible := false;
end;

procedure TfrmSoftLine.gravaParametros;
begin
  iniFile.WriteString('dataCEP', edtDataCEP.Text);
  iniFile.WriteString('GigaERP', edtBancoGigaERP.Text);
  iniFile.WriteString('server', edtServer.Text);
  iniFile.WriteString('port', edtPorta.Text);
  iniFile.WriteString('login', edtLogin.Text);
  iniFile.WriteString('senha', edtSenha.Text);
  iniFile.WriteString('ncm', edtNCMpadrao.Text);
  iniFile.WriteString('linha', edtLinha.Text);
end;

function TfrmSoftLine.Rebuilder(Arq: String): String;
var
  pasta, txtpasta, arqname, newarq, comando: string;
  ArqBat                                   : TStringList;
begin
  try
    Result   := '';
    pasta    := ExtractFilePath(Application.ExeName);
    txtpasta := pasta + 'ArquivoTXT';
    arqname  := '\' + ExtractFileName(Arq);
    newarq   := Copy(arqname, 0, length(arqname) - 3) + 'txt';
    comando  := '"' + pasta + 'rebuild.exe" "' + Arq + '","' + txtpasta + newarq + '" /t:LII';
    ArqBat   := TStringList.Create;
    try
      ArqBat.Text := comando;
      ArqBat.SaveToFile(ExtractFilePath(Application.ExeName) + 'rebuild.bat');
    finally
      ArqBat.Free;
    end;
    if not FileExists(pasta + 'rebuild.exe') then
      Raise Exception.Create('Executavel rebuild.exe não encontrado.');
    if not DirectoryExists(txtpasta) then
      ForceDirectories(txtpasta);
    // ShellExecute(Handle,'runas','cmd.exe',PChar(comando),'', SW_NORMAL);
    ShellExecute(Handle, 'open', PChar(ExtractFilePath(Application.ExeName) + 'rebuild.bat'), '', '', SW_NORMAL);
    // WinExec(PAnsichar(ExtractFilePath(Application.ExeName)+'rebuild.bat'), SW_NORMAL);
    sleep(3000);
    // ShowMessage(txtpasta+newarq);
    if FileExists(txtpasta + newarq) then
      Result := txtpasta + newarq
    else
      raise Exception.Create('Erro desconhecido');
  except
    on E: Exception do
      MessageRaul_ERRO('Erro ao gerar o Arquivo.' + #13 + E.Message);
  end;
end;

function TfrmSoftLine.VerifClassFiscal(COD_CLASS: String): String;
begin
  if not DM.qrCLASS_FISCAIS.Locate('COD_CLASS',COD_CLASS,[]) then
  begin
    DM.qrCLASS_FISCAIS.Append;
    DM.qrCLASS_FISCAIS.FieldByName('COD_CLASS').AsString := COD_CLASS;
    DM.qrCLASS_FISCAIS.FieldByName('DESC_CLASS').AsString := 'CADASTRADO NA IMPORTAÇÃO';
    DM.qrCLASS_FISCAIS.FieldByName('FLAG_ATIVO').AsInteger := 1;
    DM.qrCLASS_FISCAIS.Post;
    DM.qrCLASS_FISCAIS.ApplyUpdates;
  end;
  Result := COD_CLASS;
end;

end.
