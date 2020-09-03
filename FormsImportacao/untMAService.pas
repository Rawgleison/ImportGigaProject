unit untMAService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils;
type
  TfrmMAService = class(TForm)
    Panel1: TPanel;
    Gauge1: TGauge;
    Label1: TLabel;
    butProdutos: TButton;
    vleConexao: TValueListEditor;
    butGravar: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butGravarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure butProdutosClick(Sender: TObject);
  private
    procedure ConectaGiga;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMAService: TfrmMAService;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmMAService.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmMAService.butProdutosClick(Sender: TObject);
var
  PROD: TCadastro_Produtos;
  QTD: Double;
begin
  ConectaGiga;
  DM.qrImport.Open(
                     ' SELECT'
                    +'   IM.CODIGO,'
                    +'   IM.DESCRICAO,'
                    +'   IM.UNIDADE,'
                    +'   IM.GRUPO,'
                    +'   IM.FAM,'
                    +'   IM.NCM,'
                    +'   IE.COD_TIPO,'
                    +'   COALESCE(IE.QTD_ESTOQUE,0) QTD_ESTOQUE,'
                    +'   COALESCE(IE.CUSTO_MEDIO,0) CUSTO_MEDIO,'
                    +'   COALESCE(IE.VR_TOTAL,0) VR_TOTAL'
                    +' FROM IMPORT_ESTOQUE IE'
                    +' FULL JOIN IMPORT_MATERIAIS IM ON'
                    +' (IM.CODIGO = IE.CODIGO)'
                    +' WHERE IM.CODIGO IS NOT NULL');
  dm.qrImport.Last;
  dm.qrImport.First;
  Gauge1.MaxValue:=dm.qrImport.RecordCount+1;
  Gauge1.Progress:=0;
  PROD:=TCadastro_Produtos.Create;
  PROD.Open;
  PROD.Cadastra_imposto_padrao;
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    PROD.PRODUTOS.COD_PRODUTO               :=dm.qrImport.FieldByName('CODIGO'     ).AsString;
    PROD.PRODUTOS.DESC_PRODUTO              :=dm.qrImport.FieldByName('DESCRICAO'  ).AsString;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE      :=dm.qrImport.FieldByName('UNIDADE'    ).AsString;
    PROD.PRODUTOS.COD_GRUPO                 :=dm.qrImport.FieldByName('GRUPO'      ).AsInteger;
    PROD.PRODUTOS_TABELA[1].COD_TABELA_ITEM :=dm.qrImport.FieldByName('FAM'        ).AsInteger;
    PROD.PRODUTOS.COD_CLASS                 :=dm.qrImport.FieldByName('NCM'        ).AsString;
    PROD.PRODUTOS.COD_TIPO_ITEM             :=dm.qrImport.FieldByName('COD_TIPO'   ).AsInteger;
    PROD.PRODUTOS_GRADE[1].QTD_ESTOQUE      := dm.qrImport.FieldByName('QTD_ESTOQUE').AsFloat;
    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO      :=dm.qrImport.FieldByName('CUSTO_MEDIO').AsFloat;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO  :=dm.qrImport.FieldByName('VR_TOTAL'   ).AsFloat;
    PROD.AppendOrEdit;
    dm.qrImport.Next;
  end;
  PROD.ApplyUpdates;
end;

procedure TfrmMAService.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmMAService.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
    MessageRaul_AVISO('Conectado...');
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmMAService.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
end;

procedure TfrmMAService.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
