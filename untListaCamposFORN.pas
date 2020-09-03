unit untListaCamposFORN;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.ValEdit;

type
  TfrmListaCamposFORN = class(TForm)
    pnlFoot: TPanel;
    butFechar: TButton;
    ValueListEditor1: TValueListEditor;
    procedure FormResize(Sender: TObject);
    procedure butFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaCamposFORN: TfrmListaCamposFORN;

implementation

{$R *.dfm}

procedure TfrmListaCamposFORN.butFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListaCamposFORN.FormResize(Sender: TObject);
begin
  butFechar.Left := Round((pnlFoot.Width-butFechar.Width)/2);
end;

end.
