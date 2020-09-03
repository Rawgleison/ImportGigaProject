unit untGigaInterno;

interface

uses
  ShellAPI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul,
  Vcl.StdCtrls,
  Vcl.Samples.Gauges, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Datasnap.DBClient, Vcl.Mask, Vcl.DBCtrls, System.Bluetooth,
  System.Bluetooth.Components, Vcl.PlatformDefaultStyleActnCtrls, System.Actions, Vcl.ActnList,
  Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls, Vcl.Ribbon, Vcl.RibbonLunaStyleActnCtrls;

type
  TfrmGigaInterno = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    Button2: TButton;
    butFornecedores: TButton;
    CheckBox1: TCheckBox;
    butProdutos: TButton;
    OpenDialog1: TOpenDialog;
    rbPessoas: TRadioButton;
    rbProdutos: TRadioButton;
    ComboBox1: TComboBox;
    Panel2: TPanel;
    Label1: TLabel;
    Gauge1: TGauge;
    cbGradeAtiva: TCheckBox;
    MainMenu1: TMainMenu;
    Associar1: TMenuItem;
    dsConfig: TDataSource;
    DBGrid1: TDBGrid;
    GravarPerfil1: TMenuItem;
    edtBaseGiga: TLabeledEdit;
    edtServer: TLabeledEdit;
    edtPort: TLabeledEdit;
    edtUser: TLabeledEdit;
    edtPassword: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtBancoGigaERPRightButtonClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure rbPessoasClick(Sender: TObject);
    procedure rbProdutosClick(Sender: TObject);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure Associar1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ConectGiga;
    function IntToAlfa(I: integer): String;
    procedure AtribuiTabCombList;
    procedure AtribuiDataSet;
    function coalesce(str1,str2: String):String;
    procedure AtribuiValor(CampoGiga,CampoImport: String);
    procedure ConectToConfig;
    procedure CarregaConfig;
    procedure GravaConfig;
    { Public declarations }
  end;

var
  frmGigaInterno: TfrmGigaInterno;

implementation

{$R *.dfm}

uses untDM, unDmImagens, untAssociar;

{ TfrmSoftLine }

function TfrmGigaInterno.IntToAlfa(I: integer): String;
begin
  Result := Copy('ABCDEFGHIJKLMNOPQRSTUVXYWZ', I, 1);
end;

procedure TfrmGigaInterno.rbPessoasClick(Sender: TObject);
begin
  AtribuiTabCombList;
end;

procedure TfrmGigaInterno.rbProdutosClick(Sender: TObject);
begin
  AtribuiTabCombList
end;

procedure TfrmGigaInterno.AtribuiTabCombList;
begin
  if rbPessoas.Checked then
  begin
    ComboBox1.Items.Clear;
    ComboBox1.Items.Insert(0,'PESSOAS');
    ComboBox1.Items.Insert(1,'PESSOAS_CONTATOS');
    ComboBox1.Items.Insert(2,'PESSOAS_ENDERECOS');
    ComboBox1.Items.Insert(3,'CLIENTES');
    ComboBox1.Items.Insert(4,'FORNECEDORES');
  end;
  if rbProdutos.Checked then
  begin
    ComboBox1.Items.Clear;
    ComboBox1.Items.Insert(0,'PRODUTOS');
    ComboBox1.Items.Insert(1,'PRODUTOS_GRADE');
    ComboBox1.Items.Insert(2,'PRODUTOS_CUSTO');
    ComboBox1.Items.Insert(3,'PRODUTOS_GRADE_UND');
    ComboBox1.Items.Insert(4,'PRODUTOS_APELIDOS_PROD');
    ComboBox1.Items.Insert(5,'PRODUTOS_TAB_PRECOS_PROD');
    ComboBox1.Items.Insert(6,'PRODUTOS_TABELA');
  end;
  ComboBox1.ItemIndex:=0;
  AtribuiDataSet;
  ComboBox1.Visible:=True;
end;

procedure TfrmGigaInterno.AtribuiValor(CampoGiga, CampoImport: String);
begin
  with DM do
  begin

  end;
end;

procedure TfrmGigaInterno.Button2Click(Sender: TObject);
var
  Clientes: TCadastro_Pessoas;
  campoGiga: String;
  valorImport: Variant;
begin
  Clientes:=TCadastro_Pessoas.Create;
  Clientes.TIPO_CADASTRO:=1;
  ConectGiga;
  Clientes.Open;
  with frmAssociar do
  begin
    DM.qrImport.Open();
    DM.qrImport.First;
    while not DM.qrImport.Eof do
    begin
      DM.qrASSOC.First;
      while not DM.qrASSOC.Eof do
      begin
        campoGiga:= DM.qrASSOCCAMPOGIGA.AsString;
        valorImport:= DM.qrImport.FieldByName(DM.qrASSOCCAMPOIMPORT.AsString).Value;
        Clientes.AtribuiValor(campoGiga,valorImport);
        DM.qrASSOC.Next;
      end;
      Clientes.PESSOAS_CONTATOS[1].COD_CONTATO:=1;
      Clientes.PESSOAS_ENDERECOS[1].SEQ_PES_END:=1;
      Clientes.PESSOAS_ENDERECOS[1].COD_MUNIC:='3506508';
      DM.qrImport.Next;
      Clientes.AppendOrEdit;
    end;
    Clientes.ApplyUpdates;
  end;
end;

procedure TfrmGigaInterno.Associar1Click(Sender: TObject);
begin
  frmAssociar.ShowModal;
end;

procedure TfrmGigaInterno.AtribuiDataSet;
begin
  if rbPessoas.Checked then
  begin
    case ComboBox1.ItemIndex of
      0: DataSource1.DataSet:=DM.qrPESSOAS;
      1: DataSource1.DataSet:=DM.qrPESSOAS_CONTATOS;
      2: DataSource1.DataSet:=DM.qrPESSOAS_ENDERECOS;
      3: DataSource1.DataSet:=DM.qrCLIENTES;
      4: DataSource1.DataSet:=DM.qrFORNECEDORES;
    end;
  end;
  if rbProdutos.Checked then
  begin
    case ComboBox1.ItemIndex of
      0: DataSource1.DataSet:=DM.qrPRODUTOS;
      1: DataSource1.DataSet:=DM.qrPRODUTOS_GRADE;
      2: DataSource1.DataSet:=DM.qrPRODUTOS_CUSTO;
      3: DataSource1.DataSet:=DM.qrPRODUTOS_GRADE_UND;
      4: DataSource1.DataSet:=DM.qrPRODUTOS_APELIDOS_PROD;
      5: DataSource1.DataSet:=DM.qrPRODUTOS_TAB_PRECOS_PROD;
      6: DataSource1.DataSet:=DM.qrPRODUTOS_TABELA;
    end;
  end;
end;

procedure TfrmGigaInterno.CarregaConfig;
begin
  Self.Caption:= '('+DM.qrPERFILNOME_PERFIL.AsString+') '+'Importar dados Para GigaERP  de tabela interna';
  edtBaseGiga.Text:=DM.qrPERFILBASEGIGA.AsString;
  edtUser.Text:=DM.qrPERFILUSER.AsString;
  edtPassword.Text:=DM.qrPERFILPASSWORD.AsString;
  frmAssociar.memoSQL.Text:= DM.qrPERFILSQL_PESSOAS.AsString;
end;

procedure TfrmGigaInterno.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    AtribuiTabCombList;
    DBGrid1.Visible := true;
    Self.Height := Panel1.Height+Panel2.Height+200;
  end
  else
  begin
    Self.Height := Panel1.Height+Panel2.Height;
    DBGrid1.Visible := false;
    DataSource1.DataSet := nil;
    ComboBox1.Visible:=False;
  end;
end;

function TfrmGigaInterno.coalesce(str1, str2: String): String;
begin
  if Trim(str1)='' then
    Result:=Str2
  else
    Result:=Str1;
end;

procedure TfrmGigaInterno.ComboBox1CloseUp(Sender: TObject);
begin
  AtribuiDataSet;
end;

procedure TfrmGigaInterno.ConectGiga;
begin
//  DM.Base:=edtBaseGiga.Text;
//  DM.Server:=Copy(Database,1,pos('/',Database)-1);
//  DM.Port:=Copy(Database,pos('/',Database)+1,4);
//  Database:=Copy(Database,pos(':',Database)+1,length(Database));
//  User:= edtUser.Text;
//  Password:= edtPassword.Text;
  DM.ConnectaGigaERP;
end;

procedure TfrmGigaInterno.ConectToConfig;
begin
  DM.conexaoConfig.Close;
  DM.conexaoConfig.Params.LoadFromFile(ExtractFilePath(Application.ExeName)+'ConexaoConfig.ini');
  DM.conexaoConfig.Open();
  DM.qrPERFIL.Open();
end;

procedure TfrmGigaInterno.edtBancoGigaERPRightButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    (Sender as TButtonedEdit).Text := OpenDialog1.FileName;
end;

procedure TfrmGigaInterno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GravaConfig;
  DM.conexaoConfig.Close;
  DM.ConexaoGigaERP.Close;
end;

procedure TfrmGigaInterno.FormShow(Sender: TObject);
begin
  ConectToConfig;
  CarregaConfig;
  Self.Height := Panel1.Height+Panel2.Height+100;
  Label1.Caption:='';
  DBGrid1.Visible := false;
end;

procedure TfrmGigaInterno.GravaConfig;
begin
  DM.qrPERFIL.Edit;
  DM.qrPERFILBASEGIGA.AsString := edtBaseGiga.Text ;
  DM.qrPERFILUSER.AsString     := edtUser.Text     ;
  DM.qrPERFILPASSWORD.AsString := edtPassword.Text ;
  DM.qrPERFIL.Post;
  DM.qrPERFIL.ApplyUpdates();
end;

end.
