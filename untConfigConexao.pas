unit untConfigConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.StdCtrls, Vcl.Grids, Vcl.ValEdit;

type
  TfrmConfigConexao = class(TForm)
    ValueListEditor1: TValueListEditor;
    butOK: TButton;
    butCancel: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure LerConfig;
    procedure GravaConfig;
    { Public declarations }
  end;

var
  frmConfigConexao: TfrmConfigConexao;

implementation

{$R *.dfm}

{ TfrmConfigConexao }

procedure TfrmConfigConexao.FormCreate(Sender: TObject);
begin
  LerConfig;
end;

procedure TfrmConfigConexao.GravaConfig;
begin
  ValueListEditor1.Strings.SaveToFile(StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]));
end;

procedure TfrmConfigConexao.LerConfig;
var
  ArqName: string;
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    ValueListEditor1.Strings.LoadFromFile(ArqName);
end;

end.
