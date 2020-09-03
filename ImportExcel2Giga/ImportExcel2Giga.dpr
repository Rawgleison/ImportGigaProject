program ImportExcel2Giga;

uses
  Vcl.Forms,
  unDmImagens in '..\..\public\unDmImagens.pas' {DM_Imagens: TDataModule},
  untDM in '..\untDM.pas' {DM: TDataModule},
  RotinasRaul in '..\..\public\RotinasRaul.pas',
  Vcl.Themes,
  Vcl.Styles,
  untListaCamposFORN in '..\untListaCamposFORN.pas' {frmListaCamposFORN},
  untListaCampos in '..\untListaCampos.pas' {frmListaCampos},
  untExcel in '..\FormsImportacao\untExcel.pas' {frmExcel},
  untCadastrosBasicos in '..\untCadastrosBasicos.pas' {frmCadastrosBasicos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Metropolis UI Green');
  Application.CreateForm(TDM_Imagens, DM_Imagens);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmExcel, frmExcel);
  Application.CreateForm(TfrmListaCamposFORN, frmListaCamposFORN);
  Application.CreateForm(TfrmListaCampos, frmListaCampos);
  Application.CreateForm(TfrmCadastrosBasicos, frmCadastrosBasicos);
  Application.Run;
end.
