unit untCadastrosBasicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmCadastrosBasicos = class(TForm)
    DBGrid1: TDBGrid;
    edtDesc: TEdit;
    Label1: TLabel;
    Button1: TButton;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastrosBasicos: TfrmCadastrosBasicos;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmCadastrosBasicos.Button1Click(Sender: TObject);
var
  Cod: Integer;
begin
  if tag = 1 then
  begin
    DM.QR_GigaERP_Aux.Close;
    DM.QR_GigaERP_Aux.Open('SELECT GEN_ID(SIMPOSTOS,1) COD FROM RDB$DATABASE');
    Cod := DM.QR_GigaERP_Aux.FieldByName('COD').AsInteger;
    DM.QR_GigaERP.Append;
    DM.QR_GigaERP.FieldByName('COD_IMPOSTO').AsInteger:=COD;
    DM.QR_GigaERP.FieldByName('DESC_IMPOSTO').AsString:=Trim(edtDesc.Text);
    DM.QR_GigaERP.FieldByName('FLAG_SERVICO').AsInteger:=0;
    DM.QR_GigaERP.Post;
    DM.QR_GigaERP.ApplyUpdates;
  end else
  begin
    DM.QR_GigaERP_Aux.Close;
    DM.QR_GigaERP_Aux.Open('SELECT GEN_ID(SGRUPOS_PRODUTO,1) COD FROM RDB$DATABASE');
    Cod := DM.QR_GigaERP_Aux.FieldByName('COD').AsInteger;
    DM.QR_GigaERP.Append;
    DM.QR_GigaERP.FieldByName('COD_GRUPO').AsInteger:=COD;
    DM.QR_GigaERP.FieldByName('DESC_GRUPO').AsString:=Trim(edtDesc.Text);
    DM.QR_GigaERP.Post;
    DM.QR_GigaERP.ApplyUpdates;
  end;
end;

procedure TfrmCadastrosBasicos.FormShow(Sender: TObject);
begin
  DM.QR_GigaERP.Close;
  if tag = 1 then
    DM.QR_GigaERP.Open('SELECT * FROM IMPOSTOS')
  else
    DM.QR_GigaERP.Open('SELECT * FROM GRUPOS_PRODUTO');
end;

end.
