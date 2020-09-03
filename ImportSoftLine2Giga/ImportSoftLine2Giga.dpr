program ImportSoftLine2Giga;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  untSoftLine in '..\FormsImportacao\untSoftLine.pas' {frmSoftLine},
  untDM in '..\untDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSoftLine, frmSoftLine);
  Application.CreateForm(TDM, DM);
  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.Run;
end.
