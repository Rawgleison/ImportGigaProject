unit untGerenciadorGoverno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Samples.Gauges, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ValEdit, Datasnap.DBClient, Xml.xmldom, Datasnap.Xmlxform,
  Datasnap.Provider, FireDAC.Stan.StorageXML, Vcl.FileCtrl, Vcl.Menus, System.Win.TaskbarCore, Vcl.Taskbar, Vcl.ExtCtrls;

type
  TfrmGerenciadorGoverno = class(TForm)
    Gauge1: TGauge;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    butClientes: TButton;
    butProdutos: TButton;
    Button1: TButton;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    cdsImport: TClientDataSet;
    xml: TXMLTransformProvider;
    FileOpenDialog1: TFileOpenDialog;
    FileOpenDialog2: TFileOpenDialog;
    Panel2: TPanel;
    vleConexao: TValueListEditor;
    Button2: TButton;
    butDatabase: TButton;
    butPathClientes: TButton;
    butPathProdutos: TButton;
    FileListBox1: TFileListBox;
    procedure butClientesClick(Sender: TObject);
    procedure butProdutosClick(Sender: TObject);
    function TrataValorStr(Valor: String): Real;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure butDatabaseClick(Sender: TObject);
    procedure butPathClientesClick(Sender: TObject);
    procedure butPathProdutosClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure ConetcaBanco;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerenciadorGoverno: TfrmGerenciadorGoverno;
  ArqName: String;

implementation

{$R *.dfm}

uses untDM;

{ TfrmImportRaul }

procedure TfrmGerenciadorGoverno.butClientesClick(Sender: TObject);
var
  CLI: TCadastro_Pessoas;
  pathXML: String;
  I: Integer;
  arq: String;
begin

  vleConexao.Strings.SaveToFile(ArqName);
  vleConexao.Strings.LoadFromFile(ArqName);

  ConetcaBanco;
  CLI:=TCadastro_Pessoas.Create;
  CLI.TIPO_CADASTRO:=1;
  CLI.Open;
  With DM do
  begin

    pathXML := vleConexao.Values['path_clientes'];
    FileListBox1.ApplyFilePath(pathXML);
    Gauge1.MaxValue:=FileListBox1.Count;
    Gauge1.Progress:=0;


    if FileExists(ExtractFilePath(Application.ExeName)+'GGclientes.xtr') then
      xml.TransformRead.TransformationFile := ExtractFilePath(Application.ExeName)+'GGclientes.xtr'
    else
      raise Exception.Create('Arquivo GGcliente.xtr não encontrado junto ao exe.');

      for I := 0 to FileListBox1.Count-1 do
      begin
        Gauge1.AddProgress(1);


        cdsImport.Close;
        arq := pathXML+'\'+FileListBox1.Items.Strings[I];
        xml.XMLDataFile := StringReplace(pathXML+'\'+FileListBox1.Items.Strings[I],'\\','\',[rfReplaceAll]);
        cdsImport.Open;

        if Trim(cdsImport.FieldByName('CPF').AsString)='' then
          CLI.PESSOAS.CNPJ_CPF:=cdsImport.FieldByName('CNPJ').AsString
        else
          CLI.PESSOAS.CNPJ_CPF:=cdsImport.FieldByName('CPF').AsString;
        CLI.PESSOAS.RAZAO_SOCIAL:=UTF8ToString(cdsImport.FieldByName('xNOME').AsString);
        CLI.PESSOAS.INSCR_ESTADUAL:=cdsImport.FieldByName('IE').AsString;
        CLI.PESSOAS_ENDERECOS[1].ENDERECO:=UTF8ToString(cdsImport.FieldByName('xLgr').AsString);
        CLI.PESSOAS_ENDERECOS[1].NUMERO:=UTF8ToString(cdsImport.FieldByName('nro').AsString);
        CLI.PESSOAS_ENDERECOS[1].COMPLEMENTO:=UTF8ToString(cdsImport.FieldByName('xCpl').AsString);
        CLI.PESSOAS_ENDERECOS[1].BAIRRO:=UTF8ToString(cdsImport.FieldByName('xBairro').AsString);
        CLI.PESSOAS_ENDERECOS[1].COD_MUNIC:=cdsImport.FieldByName('cMun').AsString;
  //      CLI.PESSOAS.RAZAO_SOCIAL:=cdsImport.FieldByName('CIDADE').AsString;
  //      CLI.PESSOAS.RAZAO_SOCIAL:=cdsImport.FieldByName('UF').AsString;
        CLI.PESSOAS_ENDERECOS[1].CEP:=cdsImport.FieldByName('CEP').AsString;
  //      CLI.PESSOAS.RAZAO_SOCIAL:=cdsImport.FieldByName('IBGE_PAIS').AsString;
  //      CLI.PESSOAS.RAZAO_SOCIAL:=cdsImport.FieldByName('PAIS').AsString;
        CLI.PESSOAS_ENDERECOS[1].TELEFONE:=cdsImport.FieldByName('fone').AsString;
        CLI.PESSOAS.EMAIL:=UTF8ToString(cdsImport.FieldByName('email').AsString);
        CLI.AppendOrEdit;
      end;
    CLI.ApplyUpdates;
    MessageRaul_AVISO('PROCESSO CONCLUIDO.');
  end;
end;

procedure TfrmGerenciadorGoverno.butPathClientesClick(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    vleConexao.Values['path_clientes'] := FileOpenDialog1.FileName;
end;

procedure TfrmGerenciadorGoverno.butPathProdutosClick(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    vleConexao.Values['path_produtos'] := FileOpenDialog1.FileName;
end;

procedure TfrmGerenciadorGoverno.butProdutosClick(Sender: TObject);
var
  PROD: TCadastro_Produtos;
  I: Integer;
  pathXML: String;
begin
  vleConexao.Strings.SaveToFile(ArqName);
  vleConexao.Strings.LoadFromFile(ArqName);

  ConetcaBanco;

  PROD:=TCadastro_Produtos.Create;
  PROD.Open;
  PROD.Cadastra_imposto_padrao;
  PROD.Cadastra_Grupo_Padrão;
  PROD.Reseta_Todas_Sequencias;
  With DM do
  begin
    pathXML := vleConexao.Values['path_produtos'];

    if not DirectoryExists(pathXML) then
      raise Exception.Create('Diretório não encontrado.');
    FileListBox1.ApplyFilePath(pathXML);
    Gauge1.MaxValue:=FileListBox1.Count;
    Gauge1.Progress:=0;

    if FileExists(ExtractFilePath(Application.ExeName)+'GGprodutos.xtr') then
      xml.TransformRead.TransformationFile := ExtractFilePath(Application.ExeName)+'GGprodutos.xtr'
    else
      raise Exception.Create('Arquivo GGprodutos.xtr não encontrado junto ao exe.');

    for I := 0 to FileListBox1.Count-1 do
    begin
      Gauge1.AddProgress(1);

      cdsImport.Close;
      xml.XMLDataFile := StringReplace(pathXML+'\'+FileListBox1.Items.Strings[I],'\\','\',[rfReplaceAll]);
      cdsImport.Open;

      PROD.PRODUTOS.COD_PRODUTO := IntToStr(I+1);
      PROD.PRODUTOS.CHAVE_OLD:= cdsImport.FieldByName('cProd').AsString;
      PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO:=cdsImport.FieldByName('cProd').AsString;
      PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO:=cdsImport.FieldByName('cEAN').AsString;
      PROD.PRODUTOS.DESC_PRODUTO:= UTF8ToString(cdsImport.FieldByName('xProd').AsString);
      PROD.PRODUTOS.COD_CLASS:=cdsImport.FieldByName('NCM').AsString;
      PROD.PRODUTOS_GRADE_UND[1].UNIDADE:=cdsImport.FieldByName('uCom').AsString;
      PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO:=TrataValorStr(cdsImport.FieldByName('vUnCom').AsString);
      PROD.AppendOrEdit;
      Application.ProcessMessages;
    end;
    PROD.ApplyUpdates;
    MessageRaul_AVISO('PROCESSO CONCLUIDO.');
  end;
end;

procedure TfrmGerenciadorGoverno.Button1Click(Sender: TObject);
var
  arq: String;
begin
  DBGrid1.Height := 90;
  DBGrid1.Visible := True;
  DataSource1.DataSet := cdsImport;
  self.Height := 550;
  if FileOpenDialog2.Execute then
  begin
    arq := FileOpenDialog2.FileName;
    xml.TransformRead.TransformationFile := ExtractFilePath(Application.ExeName)+'GGprodutos.xtr';
    ConetcaBanco;
    cdsImport.Close;
    xml.XMLDataFile := arq;
    cdsImport.Open;
  end;
end;

procedure TfrmGerenciadorGoverno.Button2Click(Sender: TObject);
begin
  vleConexao.Strings.SaveToFile(ArqName);
  vleConexao.Strings.LoadFromFile(ArqName);
end;

procedure TfrmGerenciadorGoverno.butDatabaseClick(Sender: TObject);
begin
  if FileOpenDialog2.Execute then
    vleConexao.Values['Database'] := FileOpenDialog2.FileName;
end;

procedure TfrmGerenciadorGoverno.ConetcaBanco;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmGerenciadorGoverno.FormShow(Sender: TObject);
begin
  self.Caption:='Versão: '+VersaoEXE();
  ArqName:=ExtractFilePath(Application.ExeName)+'ImportGerenciadorNFeGov.ini';
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

function TfrmGerenciadorGoverno.TrataValorStr(Valor: String): Real;
begin
  Valor:=Trim(StringReplace(Valor,'.',',',[]));
  if Valor='' then
    Result:=0
  else
    Result:=StrToFloat(Valor);
end;

end.
