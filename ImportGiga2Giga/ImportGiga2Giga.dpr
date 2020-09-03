program ImportGiga2Giga;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  untGiga2Giga in '..\untGiga2Giga.pas' {frmGiga2Giga},
  untMsgErro in '..\untMsgErro.pas' {ExceptionDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.CreateForm(TfrmGiga2Giga, frmGiga2Giga);
  Application.Run;
end.
