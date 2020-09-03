program ImportGiga2Giga;

uses
  Vcl.Forms,
  unDmImagens in '..\public\unDmImagens.pas' {DM_Imagens: TDataModule},
  untDM in 'untDM.pas' {DM: TDataModule},
  RotinasRaul in '..\public\RotinasRaul.pas',
  Vcl.Themes,
  Vcl.Styles,
  untCadastrosBasicos in 'untCadastrosBasicos.pas' {frmCadastrosBasicos},
  untListaCamposFORN in 'untListaCamposFORN.pas' {frmListaCamposFORN},
  untListaCampos in 'untListaCampos.pas' {frmListaCampos},
  untGerenciadorGoverno in 'FormsImportacao\untGerenciadorGoverno.pas' {frmGerenciadorGoverno},
  untGiga2Giga in 'untGiga2Giga.pas' {frmGiga2Giga},
  untExcel in 'FormsImportacao\untExcel.pas' {frmExcel},
  untMsgErro in 'untMsgErro.pas' {ExceptionDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.CreateForm(TDM_Imagens, DM_Imagens);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmExcel, frmExcel);
  Application.CreateForm(TfrmCadastrosBasicos, frmCadastrosBasicos);
  Application.CreateForm(TfrmListaCamposFORN, frmListaCamposFORN);
  Application.CreateForm(TfrmListaCampos, frmListaCampos);
  Application.Run;
end.
