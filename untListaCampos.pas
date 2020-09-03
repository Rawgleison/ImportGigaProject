unit untListaCampos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.ValEdit;

type
  TfrmListaCampos = class(TForm)
    pnlFoot: TPanel;
    butFechar: TButton;
    ValueListEditor1: TValueListEditor;
    procedure FormResize(Sender: TObject);
    procedure butFecharClick(Sender: TObject);
    procedure ValueListEditor1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaCampos: TfrmListaCampos;

implementation

{$R *.dfm}

procedure TfrmListaCampos.butFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListaCampos.FormResize(Sender: TObject);
begin
  butFechar.Left := Round((pnlFoot.Width-butFechar.Width)/2);
end;

procedure TfrmListaCampos.ValueListEditor1Click(Sender: TObject);
begin

end;

end.
