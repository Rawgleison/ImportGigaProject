unit untAssociar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.StdCtrls, Vcl.Grids, Vcl.ValEdit, Vcl.ComCtrls, Data.DB, Vcl.DBGrids, Datasnap.DBClient, Vcl.ExtCtrls;

type
  TfrmAssociar = class(TForm)
    TabControl1: TTabControl;
    dbgridASSOCIA: TDBGrid;
    DS_Associa: TDataSource;
    Panel1: TPanel;
    memoSQL: TMemo;
    Button1: TButton;
    Button2: TButton;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dbgridASSOCIAKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListaComboBox;
  end;

var
  frmAssociar: TfrmAssociar;

implementation

{$R *.dfm}

uses untGigaInterno, untDM;

procedure TfrmAssociar.Button1Click(Sender: TObject);
begin
  frmGigaInterno.ConectGiga;
  DM.qrImport.Open(memoSQL.Text);
  DM.qrASSOC.Open();
  ListaComboBox;
end;

procedure TfrmAssociar.Button2Click(Sender: TObject);
begin
  DM.qrASSOC.ApplyUpdates();
  DM.qrASSOC.Close;
  DM.qrASSOC.Open();
end;

procedure TfrmAssociar.dbgridASSOCIAKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if KEY=VK_DELETE then
   DM.qrASSOC.Delete;
end;

procedure TfrmAssociar.FormResize(Sender: TObject);
begin
  dbgridASSOCIA.Columns.Items[0].Width:=Trunc(dbgridASSOCIA.Width/2)-8;
  dbgridASSOCIA.Columns.Items[1].Width:=Trunc(dbgridASSOCIA.Width/2)-8;
end;

procedure TfrmAssociar.FormShow(Sender: TObject);
begin
  dbgridASSOCIA.Columns.Items[0].Width:=Trunc(dbgridASSOCIA.Width/2)-8;
  dbgridASSOCIA.Columns.Items[1].Width:=Trunc(dbgridASSOCIA.Width/2)-8;
end;

procedure TfrmAssociar.ListaComboBox;
var
  I: Integer;
begin
  for I := 0 to DM.qrImport.FieldList.Count - 1 do
  begin
    dbgridASSOCIA.Columns.Items[1].PickList.Add(DM.qrImport.Fields.Fields[I].FieldName);
  end;
end;

end.
