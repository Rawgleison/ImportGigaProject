unit untExcel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  StrUtils, Data.DB, Vcl.DBGrids, Vcl.CheckLst, Datasnap.DBClient, Vcl.ComCtrls, untListaCampos,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.Stan.Error, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TfrmExcel = class(TForm)
    Panel1: TPanel;
    Gauge1: TGauge;
    lbProgress: TLabel;
    OpenDialog1: TOpenDialog;
    ClientDataSet1: TClientDataSet;
    Button1: TButton;
    StringGrid1: TStringGrid;
    lbStatus: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    edtImposto: TEdit;
    Label3: TLabel;
    Button3: TButton;
    Label4: TLabel;
    Button4: TButton;
    butCampos: TButton;
    tsClientes: TTabSheet;
    butClientes: TButton;
    butCamposClientes: TButton;
    edtGrupo: TEdit;
    pnlList: TPanel;
    butGravar: TButton;
    vleConexao: TValueListEditor;
    butBancoGiga: TButton;
    chkVerStringGrid: TCheckBox;
    tsForn: TTabSheet;
    butFORNECEDORES: TButton;
    butCAMPOSFORN: TButton;
    lbNCM: TLabel;
    edtNCM: TEdit;
    checkDataInvalida: TCheckBox;
    stat1: TStatusBar;
    checkMesmoCodigo: TCheckBox;
    edtUFpadrao: TLabeledEdit;
    edtEmpresa: TLabeledEdit;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butGravarClick(Sender: TObject);
    procedure butBancoGigaClick(Sender: TObject);
    procedure butImportClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure buttesteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure butCamposClick(Sender: TObject);
    procedure butCamposClientesClick(Sender: TObject);
    procedure butClientesClick(Sender: TObject);
    procedure chkVerStringGridClick(Sender: TObject);
    procedure butFORNECEDORESClick(Sender: TObject);
    procedure butCAMPOSFORNClick(Sender: TObject);
    procedure checkMesmoCodigoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmpresaExit(Sender: TObject);
  private
    procedure ConectaGiga;
    procedure CLIENTES;
    procedure FORNECEDORES;
    procedure TRANSPORTADORAS;
    procedure PRODUTOS;
    // QUANDO O MESMO CADASTRO PODE SER CLIENTE, FORNECEDOR E/OU TRANSPORTADORA
    function GRUPO_EXISTE(COD_GRUPO, DESC: String): Integer;
    function IMPOSTO_EXISTE(COD_IMPOSTO, DESC: String): Integer;
    function IDXcampos(campo: String): Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExcel: TfrmExcel;
  ArqName : string;

implementation

{$R *.dfm}

uses untDM, untCadastrosBasicos, untListaCamposFORN;

procedure TfrmExcel.CLIENTES;
var
  CLI       : TCadastro_Pessoas;
  DATA_CAD  : String;
  DATA_NASC : String;
  CPF       : String;
  CNPJ      : String;
  DATATMP   : String;
  COD_PESSOA: Integer;

  // PESSOAS
  idxCOD_CLIENTE  : Integer;
  idxRAZAO_SOCIAL : Integer;
  idxNOME_FANTASIA: Integer;
  idxCNPJ_CPF     : Integer;
  idxHISTORICO    : Integer;
  idxIE           : Integer;
  idxIM           : Integer;
  idxRG           : Integer;
  idxDATA_CADASTRO: Integer;
  idxOBS          : Integer;
  idxEMAIL        : Integer;

  // PESSOAS_CONTATOS
  idxCONTATO_DESC_CONTATO: Integer;
  idxCONTATO_OCUPACAO    : Integer;
  idxCONTATO_DATA_NASC   : Integer;
  idxCONTATO_EMAIL       : Integer;
  idxCONTATO_TELEFONE    : Integer;
  idxCONTATO_RAMAL       : Integer;
  idxCELULAR             : Integer;
  idxCONTATO_FAX         : Integer;

  // PESSOAS_ENDERECOS
  idxENDERECO        : Integer;
  idxNUMERO          : Integer;
  idxCOMPLEMENTO     : Integer;
  idxBAIRRO          : Integer;
  idxCEP             : Integer;
  idxPONTO_REFERENCIA: Integer;
  idxCOD_MUNIC       : Integer;
  idxNOME_MUNIC      : Integer;
  idxUF              : Integer;
  idxTELEFONE        : Integer;
  idxFAX             : Integer;

  // PESSOAS_ENDERECOS 2
  idxENDERECO2        : Integer;
  idxNUMERO2          : Integer;
  idxCOMPLEMENTO2     : Integer;
  idxBAIRRO2          : Integer;
  idxCEP2             : Integer;
  idxPONTO_REFERENCIA2: Integer;
  idxCOD_MUNIC2       : Integer;
  idxNOME_MUNIC2      : Integer;
  idxUF2              : Integer;
  idxTELEFONE2        : Integer;
  idxFAX2             : Integer;

  // CLIENTES
  idxDATA_NASCIMENTO  : Integer;
  idxSEXO             : Integer;
  idxNACIONALIDADE    : Integer;
  idxTRAB_PROFISSAO   : Integer;
  idxTRAB_LOCAL       : Integer;
  idxTRAB_COD_FUNC    : Integer;
  idxTRAB_CARGO       : Integer;
  idxTRAB_RENDA       : Integer;
  idxCONJ_ESTADO_CIVIL: Integer;
  idxCONJ_NOME        : Integer;
  idxCONJ_RENDA       : Integer;
  idxCONJ_CPF         : Integer;
  idxCONJ_PROFISSAO   : Integer;
  idxCONJ_REGIME      : Integer;
  idxCONJ_TRABALHO    : Integer;
  idxCONJ_RG          : Integer;
  idxFLAG_ATIVO       : Integer;

  I: Integer;
begin

  with DM do
  begin
    lbStatus.Caption := 'Preparando importação.';
    ConectaGiga;

    // PESSOAS
    idxCOD_CLIENTE   := IDXcampos('COD_CLIENTE');
    idxRAZAO_SOCIAL  := IDXcampos('RAZAO_SOCIAL');
    idxNOME_FANTASIA := IDXcampos('NOME_FANTASIA');
    idxCNPJ_CPF      := IDXcampos('CNPJ_CPF');
    idxHISTORICO     := IDXcampos('HISTORICO');
    idxIE            := IDXcampos('IE');
    idxIM            := IDXcampos('IM');
    idxRG            := IDXcampos('RG');
    idxDATA_CADASTRO := IDXcampos('DATA_CADASTRO');
    idxOBS           := IDXcampos('OBS');
    idxEMAIL         := IDXcampos('EMAIL');

    // PESSOAS_CONTATOS
    idxCONTATO_DESC_CONTATO := IDXcampos('CONTATO_DESC_CONTATO');
    idxCONTATO_OCUPACAO     := IDXcampos('CONTATO_OCUPACAO');
    idxCONTATO_DATA_NASC    := IDXcampos('CONTATO_DATA_NASC');
    idxCONTATO_EMAIL        := IDXcampos('CONTATO_EMAIL');
    idxCONTATO_TELEFONE     := IDXcampos('CONTATO_TELEFONE');
    idxCONTATO_RAMAL        := IDXcampos('CONTATO_RAMAL');
    idxCELULAR              := IDXcampos('CELULAR');
    idxCONTATO_FAX          := IDXcampos('CONTATO_FAX');

    // PESSOAS_ENDERECOS
    idxENDERECO         := IDXcampos('ENDERECO');
    idxNUMERO           := IDXcampos('NUMERO');
    idxCOMPLEMENTO      := IDXcampos('COMPLEMENTO');
    idxBAIRRO           := IDXcampos('BAIRRO');
    idxCEP              := IDXcampos('CEP');
    idxPONTO_REFERENCIA := IDXcampos('PONTO_REFERENCIA');
    idxCOD_MUNIC        := IDXcampos('COD_MUNIC');
    idxNOME_MUNIC       := IDXcampos('NOME_MUNIC');
    idxUF               := IDXcampos('UF');
    idxTELEFONE         := IDXcampos('TELEFONE');
    idxFAX              := IDXcampos('FAX');

    // PESSOAS_ENDERECOS2
    idxENDERECO2         := IDXcampos('ENDERECO2');
    idxNUMERO2           := IDXcampos('NUMERO2');
    idxCOMPLEMENTO2      := IDXcampos('COMPLEMENTO2');
    idxBAIRRO2           := IDXcampos('BAIRRO2');
    idxCEP2              := IDXcampos('CEP2');
    idxPONTO_REFERENCIA2 := IDXcampos('PONTO_REFERENCIA2');
    idxCOD_MUNIC2        := IDXcampos('COD_MUNIC2');
    idxNOME_MUNIC2       := IDXcampos('NOME_MUNIC2');
    idxUF2               := IDXcampos('UF2');
    idxTELEFONE2         := IDXcampos('TELEFONE2');
    idxFAX2              := IDXcampos('FAX2');

    // CLIENTES
    idxDATA_NASCIMENTO   := IDXcampos('DATA_NASCIMENTO');
    idxSEXO              := IDXcampos('SEXO');
    idxNACIONALIDADE     := IDXcampos('NACIONALIDADE');
    idxTRAB_PROFISSAO    := IDXcampos('TRAB_PROFISSAO');
    idxTRAB_LOCAL        := IDXcampos('TRAB_LOCAL');
    idxTRAB_COD_FUNC     := IDXcampos('TRAB_COD_FUNC');
    idxTRAB_CARGO        := IDXcampos('TRAB_CARGO');
    idxTRAB_RENDA        := IDXcampos('TRAB_RENDA');
    idxCONJ_ESTADO_CIVIL := IDXcampos('CONJ_ESTADO_CIVIL');
    idxCONJ_NOME         := IDXcampos('CONJ_NOME');
    idxCONJ_RENDA        := IDXcampos('CONJ_RENDA');
    idxCONJ_CPF          := IDXcampos('CONJ_CPF');
    idxCONJ_PROFISSAO    := IDXcampos('CONJ_PROFISSAO');
    idxCONJ_REGIME       := IDXcampos('CONJ_REGIME');
    idxCONJ_TRABALHO     := IDXcampos('CONJ_TRABALHO');
    idxCONJ_RG           := IDXcampos('CONJ_RG');
    idxFLAG_ATIVO        := IDXcampos('FLAG_ATIVO');

    if idxCOD_CLIENTE = 0 then
      raise Exception.Create('A coluna COD_CLIENTE deve existir e conter valores.');

    if idxRAZAO_SOCIAL = 0 then
      raise Exception.Create('A coluna RAZAO_SOCIAL deve existir e conter valores.');

    Gauge1.MaxValue := StringGrid1.RowCount;

    Gauge1.Progress   := 0;
    CLI               := TCadastro_Pessoas.Create;
    CLI.TIPO_CADASTRO := 1;

    lbStatus.Caption := 'Importando Dados';
    for I             := 1 to StringGrid1.RowCount - 1 do
    begin
      CLI.Refresh;
      Gauge1.AddProgress(1);
      lbProgress.Caption := IntToStr(Gauge1.Progress+1) + '/' + IntToStr(Gauge1.MaxValue);
      Application.ProcessMessages;

      if (Trim(StringGrid1.Cells[idxCOD_CLIENTE, I]) = '') then
        Continue;

      { *****PESSOAS***** }
      if checkMesmoCodigo.Checked then
        COD_PESSOA             := StrToInt(Trim(StringGrid1.Cells[idxCOD_CLIENTE, I]))
      else
        COD_PESSOA             := GeraCod('SPESSOAS');
      CLI.PESSOAS.COD_PESSOA := COD_PESSOA;
      CLI.PESSOAS.CHAVE_OLD  := Trim(StringGrid1.Cells[idxCOD_CLIENTE, I]);

      if (Trim(StringGrid1.Cells[idxRAZAO_SOCIAL, I]) = '') then // 1
        raise Exception.Create('O Nome não pode estar vazio - Linha: ' + IntToStr(I) + ' Coluna: ' + IntToStr(idxRAZAO_SOCIAL));

      CLI.PESSOAS.RAZAO_SOCIAL := Retira_Acento(UpperCase(Trim(StringGrid1.Cells[idxRAZAO_SOCIAL, I])));

      if (Trim(StringGrid1.Cells[idxNOME_FANTASIA, I]) = '') then // 1
        CLI.PESSOAS.NOME_FANTASIA := CLI.PESSOAS.RAZAO_SOCIAL
      else
        CLI.PESSOAS.NOME_FANTASIA := UpperCase(Trim(StringGrid1.Cells[idxNOME_FANTASIA, I]));

      // if (Trim(StringGrid1.Cells[idxCNPJ_CPF, I]) <> '') then // 1
      CLI.PESSOAS.CNPJ_CPF := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCNPJ_CPF, I]));

      // if (Trim(StringGrid1.Cells[idxIE, I]) <> '') then // 1
      CLI.PESSOAS.INSCR_ESTADUAL := RetiraNaoNumero(Trim(StringGrid1.Cells[idxIE, I]));

      // if (Trim(StringGrid1.Cells[idxIM, I]) <> '') then // 1
      CLI.PESSOAS.INSCR_MUNICIPAL := RetiraNaoNumero(Trim(StringGrid1.Cells[idxIM, I]));

      // if (Trim(StringGrid1.Cells[idxRG, I]) <> '') then // 1
      CLI.PESSOAS.RG := RetiraNaoNumero(Trim(StringGrid1.Cells[idxRG, I]));

      if (Trim(StringGrid1.Cells[idxDATA_CADASTRO, I]) <> '') then // 1
      begin
        try
          CLI.PESSOAS.DATA_CADASTRO := StrToDate(Trim(StringGrid1.Cells[idxDATA_CADASTRO, I]));
        except
          on E:Exception do
          begin
            if not checkDataInvalida.Checked then
            begin
               raise Exception.Create('REGISTRO:'+CLI.PESSOAS.CHAVE_OLD+#13+E.Message);
            end else
              CLI.PESSOAS.DATA_CADASTRO := NOW;
          end;
        end;
      end else
        CLI.PESSOAS.DATA_CADASTRO := NOW;

      if (Trim(StringGrid1.Cells[idxHISTORICO, I]) <> '') then // 1
        CLI.PESSOAS.HISTORICO := Trim(StringGrid1.Cells[idxHISTORICO, I]);

      if (Trim(StringGrid1.Cells[idxOBS, I]) <> '') then // 1
        CLI.PESSOAS.OBS_PESSOA := Trim(StringGrid1.Cells[idxOBS, I]);

      if (Trim(StringGrid1.Cells[idxEMAIL, I]) <> '') then // 1
        CLI.PESSOAS.EMAIL := Trim(StringGrid1.Cells[idxEMAIL, I]);

      { *****PESSOAS_CONTATOS***** }
      if (Trim(StringGrid1.Cells[idxCONTATO_DESC_CONTATO, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].DESC_CONTATO := UpperCase(Trim(StringGrid1.Cells[idxCONTATO_DESC_CONTATO, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_OCUPACAO, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].OCUPACAO := Trim(StringGrid1.Cells[idxCONTATO_OCUPACAO, I]);

      if (Trim(StringGrid1.Cells[idxCONTATO_DATA_NASC, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].DATA_NASCIMENTO := StrToDate(Trim(StringGrid1.Cells[idxCONTATO_DATA_NASC, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_EMAIL, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].EMAIL := Trim(StringGrid1.Cells[idxCONTATO_EMAIL, I]);

      if (Trim(StringGrid1.Cells[idxCONTATO_TELEFONE, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].TELEFONE := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCONTATO_TELEFONE, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_RAMAL, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].RAMAL := StrToInt(RetiraNaoNumero(Trim(StringGrid1.Cells[idxCONTATO_RAMAL, I])));

      if (Trim(StringGrid1.Cells[idxCELULAR, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].CELULAR := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCELULAR, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_FAX, I]) <> '') then // 1
        CLI.PESSOAS_CONTATOS[1].FAX := Trim(StringGrid1.Cells[idxCONTATO_FAX, I]);

      { *****PESSOAS_ENDERECOS***** }
//      if (Trim(StringGrid1.Cells[idxENDERECO, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].ENDERECO := UpperCase(Trim(StringGrid1.Cells[idxENDERECO, I]));

      if (Trim(StringGrid1.Cells[idxNUMERO, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].NUMERO := Trim(StringGrid1.Cells[idxNUMERO, I]);

      if (Trim(StringGrid1.Cells[idxCOMPLEMENTO, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].COMPLEMENTO := UpperCase(Trim(StringGrid1.Cells[idxCOMPLEMENTO, I]));

      if (Trim(StringGrid1.Cells[idxBAIRRO, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].BAIRRO := Trim(StringGrid1.Cells[idxBAIRRO, I]);

      if (Trim(StringGrid1.Cells[idxCEP, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].CEP := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCEP, I]));

      if (Trim(StringGrid1.Cells[idxPONTO_REFERENCIA, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].PONTO_REFERENCIA := Trim(StringGrid1.Cells[idxPONTO_REFERENCIA, I]);

      if (Trim(StringGrid1.Cells[idxCOD_MUNIC, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].COD_MUNIC := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCOD_MUNIC, I]));

      if (Trim(StringGrid1.Cells[idxNOME_MUNIC, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC := Trim(StringGrid1.Cells[idxNOME_MUNIC, I]);

      if (Trim(StringGrid1.Cells[idxUF, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].UF := Trim(StringGrid1.Cells[idxUF, I])
      else
        CLI.PESSOAS_ENDERECOS[1].UF := Trim(edtUFpadrao.Text);

      if (Trim(StringGrid1.Cells[idxTELEFONE, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].TELEFONE := RetiraNaoNumero(Trim(StringGrid1.Cells[idxTELEFONE, I]));

      if (Trim(StringGrid1.Cells[idxFAX, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[1].FAX := RetiraNaoNumero(Trim(StringGrid1.Cells[idxFAX, I]));

      { *****PESSOAS_ENDERECOS 2***** }
//      if (Trim(StringGrid1.Cells[idxENDERECO2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].ENDERECO := UpperCase(Trim(StringGrid1.Cells[idxENDERECO2, I]));

      if (Trim(StringGrid1.Cells[idxNUMERO2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].NUMERO := Trim(StringGrid1.Cells[idxNUMERO2, I]);

      if (Trim(StringGrid1.Cells[idxCOMPLEMENTO2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].COMPLEMENTO := UpperCase(Trim(StringGrid1.Cells[idxCOMPLEMENTO2, I]));

      if (Trim(StringGrid1.Cells[idxBAIRRO2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].BAIRRO := Trim(StringGrid1.Cells[idxBAIRRO2, I]);

      if (Trim(StringGrid1.Cells[idxCEP2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].CEP := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCEP2, I]));

      if (Trim(StringGrid1.Cells[idxPONTO_REFERENCIA2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].PONTO_REFERENCIA := Trim(StringGrid1.Cells[idxPONTO_REFERENCIA2, I]);

      if (Trim(StringGrid1.Cells[idxCOD_MUNIC2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].COD_MUNIC := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCOD_MUNIC2, I]));

      if (Trim(StringGrid1.Cells[idxUF2, I]) <> '') then // 1
        CLI.PESSOAS_ENDERECOS[2].UF := Trim(StringGrid1.Cells[idxUF2, I])
      else
        CLI.PESSOAS_ENDERECOS[2].UF := Trim(edtUFpadrao.Text);

      if (Trim(StringGrid1.Cells[idxNOME_MUNIC2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].NOME_MUNIC := Trim(StringGrid1.Cells[idxNOME_MUNIC2, I]);

      if (Trim(StringGrid1.Cells[idxTELEFONE2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].TELEFONE := RetiraNaoNumero(Trim(StringGrid1.Cells[idxTELEFONE2, I]));

      if (Trim(StringGrid1.Cells[idxFAX2, I]) <> '') then // 2
        CLI.PESSOAS_ENDERECOS[2].FAX := RetiraNaoNumero(Trim(StringGrid1.Cells[idxFAX2, I]));

      { *****CLIENTES***** }
      if (Trim(StringGrid1.Cells[idxDATA_NASCIMENTO, I]) <> '') then // 1
      begin
        try
          CLI.CLIENTES.DATA_NASCIMENTO := StrToDate(Trim(StringGrid1.Cells[idxDATA_NASCIMENTO, I]));
        except
          on E:Exception do
          begin
            if not checkDataInvalida.Checked then
            begin
               raise Exception.Create('REGISTRO:'+CLI.PESSOAS.CHAVE_OLD+#13+E.Message);
            end else
              CLI.CLIENTES.DATA_NASCIMENTO := StrToDate('01/01/1899');
          end;
        end;
      end else
        CLI.CLIENTES.DATA_NASCIMENTO := StrToDate('01/01/1899');

      if (Trim(StringGrid1.Cells[idxSEXO, I]) <> '') then // 1
        CLI.CLIENTES.SEXO := StrToInt(Trim(StringGrid1.Cells[idxSEXO, I]));

      if (Trim(StringGrid1.Cells[idxNACIONALIDADE, I]) <> '') then // 1
        CLI.CLIENTES.NACIONALIDADE := Trim(StringGrid1.Cells[idxNACIONALIDADE, I]);

      if (Trim(StringGrid1.Cells[idxTRAB_PROFISSAO, I]) <> '') then // 1
        CLI.CLIENTES.TRAB_PROFISSAO := Trim(StringGrid1.Cells[idxTRAB_PROFISSAO, I]);

      if (Trim(StringGrid1.Cells[idxTRAB_LOCAL, I]) <> '') then // 1
        CLI.CLIENTES.TRAB_LOCAL := Trim(StringGrid1.Cells[idxTRAB_LOCAL, I]);

      if (Trim(StringGrid1.Cells[idxTRAB_COD_FUNC, I]) <> '') then // 1
        CLI.CLIENTES.TRAB_COD_FUNC := Trim(StringGrid1.Cells[idxTRAB_COD_FUNC, I]);

      if (Trim(StringGrid1.Cells[idxTRAB_CARGO, I]) <> '') then // 1
        CLI.CLIENTES.TRAB_CARGO := Trim(StringGrid1.Cells[idxTRAB_CARGO, I]);

      if (Trim(StringGrid1.Cells[idxTRAB_RENDA, I]) <> '') then // 1
        CLI.CLIENTES.TRAB_RENDA := StrToFloat(Trim(StringGrid1.Cells[idxTRAB_RENDA, I]));

      if (Trim(StringGrid1.Cells[idxCONJ_ESTADO_CIVIL, I]) <> '') then // 1
        case StrToInt(Trim(StringGrid1.Cells[idxCONJ_ESTADO_CIVIL, I])) of
          1:
            CLI.CLIENTES.CONJ_ESTADO_CIVIL := 'Casado(a)';
          2:
            CLI.CLIENTES.CONJ_ESTADO_CIVIL := 'Viúvo(a)';
          3:
            CLI.CLIENTES.CONJ_ESTADO_CIVIL := 'Amaziado(a)';
          4:
            CLI.CLIENTES.CONJ_ESTADO_CIVIL := 'Divorciado(a)';
        end
      else
        CLI.CLIENTES.CONJ_ESTADO_CIVIL := 'Solteiro(a)';

      if (Trim(StringGrid1.Cells[idxCONJ_NOME, I]) <> '') then // 1
        CLI.CLIENTES.CONJ_NOME := Trim(StringGrid1.Cells[idxCONJ_NOME, I]);

      if (Trim(StringGrid1.Cells[idxCONJ_RENDA, I]) <> '') then // 1
        CLI.CLIENTES.CONJ_RENDA := StrToFloat(Trim(StringGrid1.Cells[idxCONJ_RENDA, I]));

      if (Trim(StringGrid1.Cells[idxCONJ_CPF, I]) <> '') then // 1
        CLI.CLIENTES.CONJ_CPF := Trim(StringGrid1.Cells[idxCONJ_CPF, I]);

      if (Trim(StringGrid1.Cells[idxCONJ_PROFISSAO, I]) <> '') then // 1
        CLI.CLIENTES.CONJ_PROFISSAO := Trim(StringGrid1.Cells[idxCONJ_PROFISSAO, I]);

      if (Trim(StringGrid1.Cells[idxCONJ_REGIME, I]) <> '') then // 1
        CLI.CLIENTES.CONJ_REGIME := Trim(StringGrid1.Cells[idxCONJ_REGIME, I]);

      if (Trim(StringGrid1.Cells[idxCONJ_TRABALHO, I]) <> '') then // 1
        CLI.CLIENTES.CONJ_TRABALHO := Trim(StringGrid1.Cells[idxCONJ_TRABALHO, I]);

      if (Trim(StringGrid1.Cells[idxCONJ_RG, I]) <> '') then // 1
        CLI.CLIENTES.CONJ_RG := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCONJ_RG, I]));

      if (Trim(StringGrid1.Cells[idxFLAG_ATIVO, I]) <> '') then // 1
        CLI.CLIENTES.FLAG_ATIVO := StrToInt(Trim(StringGrid1.Cells[idxFLAG_ATIVO, I]));

      CLI.AppendOrEdit;
    end;
    lbStatus.Caption := 'Gravando Registros';
    CLI.ApplyUpdates;
    DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
    Gauge1.Progress := Gauge1.MaxValue;
    FechaConexoes;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress := 0;
  end;
end;

procedure TfrmExcel.FORNECEDORES;
var
  FORN      : TCadastro_Pessoas;
  DATA_CAD  : String;
  DATA_NASC : String;
  CPF       : String;
  CNPJ      : String;
  DATATMP   : String;
  COD_PESSOA: Integer;

  // PESSOAS
  idxCOD_FORNECEDOR: Integer;
  idxRAZAO_SOCIAL  : Integer;
  idxNOME_FANTASIA : Integer;
  idxCNPJ_CPF      : Integer;
  idxIE            : Integer;
  idxIM            : Integer;
  idxRG            : Integer;
  idxDATA_CADASTRO : Integer;
  idxOBS           : Integer;
  idxEMAIL         : Integer;

  // PESSOAS_CONTATOS
  idxCONTATO_DESC_CONTATO: Integer;
  idxCONTATO_OCUPACAO    : Integer;
  idxCONTATO_DATA_NASC   : Integer;
  idxCONTATO_EMAIL       : Integer;
  idxCONTATO_TELEFONE    : Integer;
  idxCONTATO_RAMAL       : Integer;
  idxCELULAR             : Integer;
  idxCONTATO_FAX         : Integer;

  // PESSOAS_ENDERECOS
  idxENDERECO        : Integer;
  idxNUMERO          : Integer;
  idxCOMPLEMENTO     : Integer;
  idxBAIRRO          : Integer;
  idxCEP             : Integer;
  idxPONTO_REFERENCIA: Integer;
  idxCOD_MUNIC       : Integer;
  idxNOME_MUNIC      : Integer;
  idxTELEFONE        : Integer;
  idxFAX             : Integer;

  // PESSOAS_ENDERECOS 2
  idxENDERECO2        : Integer;
  idxNUMERO2          : Integer;
  idxCOMPLEMENTO2     : Integer;
  idxBAIRRO2          : Integer;
  idxCEP2             : Integer;
  idxPONTO_REFERENCIA2: Integer;
  idxCOD_MUNIC2       : Integer;
  idxNOME_MUNIC2      : Integer;
  idxTELEFONE2        : Integer;
  idxFAX2             : Integer;

  //FORNECEDORES
  idxFLAG_ATIVO      : Integer;

  I: Integer;
begin

  with DM do
  begin
    ConectaGiga;

    // PESSOAS
    idxCOD_FORNECEDOR := IDXcampos('COD_FORNECEDOR');
    idxRAZAO_SOCIAL   := IDXcampos('RAZAO_SOCIAL');
    idxNOME_FANTASIA  := IDXcampos('NOME_FANTASIA');
    idxCNPJ_CPF       := IDXcampos('CNPJ_CPF');
    idxIE             := IDXcampos('IE');
    idxIM             := IDXcampos('IM');
    idxRG             := IDXcampos('RG');
    idxDATA_CADASTRO  := IDXcampos('DATA_CADASTRO');
    idxOBS            := IDXcampos('OBS');
    idxEMAIL          := IDXcampos('EMAIL');

    // PESSOAS_CONTATOS
    idxCONTATO_DESC_CONTATO := IDXcampos('CONTATO_DESC_CONTATO');
    idxCONTATO_OCUPACAO     := IDXcampos('CONTATO_OCUPACAO');
    idxCONTATO_DATA_NASC    := IDXcampos('CONTATO_DATA_NASC');
    idxCONTATO_EMAIL        := IDXcampos('CONTATO_EMAIL');
    idxCONTATO_TELEFONE     := IDXcampos('CONTATO_TELEFONE');
    idxCONTATO_RAMAL        := IDXcampos('CONTATO_RAMAL');
    idxCELULAR              := IDXcampos('CELULAR');
    idxCONTATO_FAX          := IDXcampos('CONTATO_FAX');

    // PESSOAS_ENDERECOS
    idxENDERECO         := IDXcampos('ENDERECO');
    idxNUMERO           := IDXcampos('NUMERO');
    idxCOMPLEMENTO      := IDXcampos('COMPLEMENTO');
    idxBAIRRO           := IDXcampos('BAIRRO');
    idxCEP              := IDXcampos('CEP');
    idxPONTO_REFERENCIA := IDXcampos('PONTO_REFERENCIA');
    idxCOD_MUNIC        := IDXcampos('COD_MUNIC');
    idxNOME_MUNIC       := IDXcampos('NOME_MUNIC');
    idxTELEFONE         := IDXcampos('TELEFONE');
    idxFAX              := IDXcampos('FAX');

    // PESSOAS_ENDERECOS 2
    idxENDERECO2        := IDXcampos('ENDERECO2');
    idxNUMERO2          := IDXcampos('NUMERO2');
    idxCOMPLEMENTO2     := IDXcampos('COMPLEMENTO2');
    idxBAIRRO2          := IDXcampos('BAIRRO2');
    idxCEP2             := IDXcampos('CEP2');
    idxPONTO_REFERENCIA2:= IDXcampos('PONTO_REFERENCIA2');
    idxCOD_MUNIC2       := IDXcampos('COD_MUNIC2');
    idxNOME_MUNIC2      := IDXcampos('NOME_MUNIC2');
    idxTELEFONE2        := IDXcampos('TELEFONE2');
    idxFAX2             := IDXcampos('FAX2');

    //FORNECEDORES
    idxFLAG_ATIVO     := IDXcampos('FLAG_ATIVO');


    if idxCOD_FORNECEDOR = 0 then
      raise Exception.Create('A coluna COD_FORNECEDOR deve existir e conter valores.');

    if idxRAZAO_SOCIAL = 0 then
      raise Exception.Create('A coluna RAZAO_SOCIAL deve existir e conter valores.');

    Gauge1.MaxValue := StringGrid1.RowCount;

    Gauge1.Progress    := 0;
    FORN               := TCadastro_Pessoas.Create;
    FORN.TIPO_CADASTRO := 2;

    lbStatus.Caption := 'Importando registros.';
    for I          := 1 to StringGrid1.RowCount - 1 do
    begin
      FORN.Refresh;
      Gauge1.AddProgress(1);
      lbProgress.Caption := IntToStr(Gauge1.Progress) + '/' + IntToStr(Gauge1.MaxValue);
      if (Trim(StringGrid1.Cells[idxCOD_FORNECEDOR, I]) = '') then
        Continue;

      { *****PESSOAS***** }
      COD_PESSOA              := GeraCod('SPESSOAS');
      FORN.PESSOAS.COD_PESSOA := COD_PESSOA;
      FORN.PESSOAS.CHAVE_OLD  := Trim(StringGrid1.Cells[idxCOD_FORNECEDOR, I]);

      if (Trim(StringGrid1.Cells[idxRAZAO_SOCIAL, I]) = '') then // 1
        raise Exception.Create('O Nome não pode estar vazio - Linha: ' + IntToStr(I) + ' Coluna: ' + IntToStr(idxRAZAO_SOCIAL));

      FORN.PESSOAS.RAZAO_SOCIAL := Retira_Acento(UpperCase(Trim(StringGrid1.Cells[idxRAZAO_SOCIAL, I])));

      if (Trim(StringGrid1.Cells[idxNOME_FANTASIA, I]) = '') then // 1
        FORN.PESSOAS.NOME_FANTASIA := FORN.PESSOAS.RAZAO_SOCIAL
      else
        FORN.PESSOAS.NOME_FANTASIA := UpperCase(Trim(StringGrid1.Cells[idxNOME_FANTASIA, I]));

      // if (Trim(StringGrid1.Cells[idxCNPJ_CPF, I]) <> '') then // 1
      FORN.PESSOAS.CNPJ_CPF := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCNPJ_CPF, I]));

      // if (Trim(StringGrid1.Cells[idxIE, I]) <> '') then // 1
      FORN.PESSOAS.INSCR_ESTADUAL := RetiraNaoNumero(Trim(StringGrid1.Cells[idxIE, I]));

      // if (Trim(StringGrid1.Cells[idxIM, I]) <> '') then // 1
      FORN.PESSOAS.INSCR_MUNICIPAL := RetiraNaoNumero(Trim(StringGrid1.Cells[idxIM, I]));

      // if (Trim(StringGrid1.Cells[idxRG, I]) <> '') then // 1
      FORN.PESSOAS.RG := RetiraNaoNumero(Trim(StringGrid1.Cells[idxRG, I]));

      if (Trim(StringGrid1.Cells[idxDATA_CADASTRO, I]) <> '') then // 1
        FORN.PESSOAS.DATA_CADASTRO := StrToDate(Trim(StringGrid1.Cells[idxDATA_CADASTRO, I]));

      if (Trim(StringGrid1.Cells[idxOBS, I]) <> '') then // 1
        FORN.PESSOAS.OBS_PESSOA := Trim(StringGrid1.Cells[idxOBS, I]);

      if (Trim(StringGrid1.Cells[idxEMAIL, I]) <> '') then // 1
        FORN.PESSOAS.EMAIL := Trim(StringGrid1.Cells[idxEMAIL, I]);

      { *****PESSOAS_CONTATOS***** }
      if (Trim(StringGrid1.Cells[idxCONTATO_DESC_CONTATO, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].DESC_CONTATO := UpperCase(Trim(StringGrid1.Cells[idxCONTATO_DESC_CONTATO, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_OCUPACAO, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].OCUPACAO := Trim(StringGrid1.Cells[idxCONTATO_OCUPACAO, I]);

      if (Trim(StringGrid1.Cells[idxCONTATO_DATA_NASC, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].DATA_NASCIMENTO := StrToDate(Trim(StringGrid1.Cells[idxCONTATO_DATA_NASC, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_EMAIL, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].EMAIL := Trim(StringGrid1.Cells[idxCONTATO_EMAIL, I]);

      if (Trim(StringGrid1.Cells[idxCONTATO_TELEFONE, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].TELEFONE := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCONTATO_TELEFONE, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_RAMAL, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].RAMAL := StrToInt(RetiraNaoNumero(Trim(StringGrid1.Cells[idxCONTATO_RAMAL, I])));

      if (Trim(StringGrid1.Cells[idxCELULAR, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].CELULAR := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCELULAR, I]));

      if (Trim(StringGrid1.Cells[idxCONTATO_FAX, I]) <> '') then // 1
        FORN.PESSOAS_CONTATOS[1].FAX := Trim(StringGrid1.Cells[idxCONTATO_FAX, I]);

      { *****PESSOAS_ENDERECOS***** }
//      if (Trim(StringGrid1.Cells[idxENDERECO, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].ENDERECO := UpperCase(Trim(StringGrid1.Cells[idxENDERECO, I]));

      if (Trim(StringGrid1.Cells[idxNUMERO, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].NUMERO := Trim(StringGrid1.Cells[idxNUMERO, I]);

      if (Trim(StringGrid1.Cells[idxCOMPLEMENTO, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].COMPLEMENTO := UpperCase(Trim(StringGrid1.Cells[idxCOMPLEMENTO, I]));

      if (Trim(StringGrid1.Cells[idxBAIRRO, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].BAIRRO := Trim(StringGrid1.Cells[idxBAIRRO, I]);

      if (Trim(StringGrid1.Cells[idxCEP, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].CEP := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCEP, I]));

      if (Trim(StringGrid1.Cells[idxPONTO_REFERENCIA, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].PONTO_REFERENCIA := Trim(StringGrid1.Cells[idxPONTO_REFERENCIA, I]);

      if (Trim(StringGrid1.Cells[idxCOD_MUNIC, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].COD_MUNIC := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCOD_MUNIC, I]));

      if (Trim(StringGrid1.Cells[idxNOME_MUNIC, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].NOME_MUNIC := Trim(StringGrid1.Cells[idxNOME_MUNIC, I]);

      if (Trim(StringGrid1.Cells[idxTELEFONE, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].TELEFONE := RetiraNaoNumero(Trim(StringGrid1.Cells[idxTELEFONE, I]));

      if (Trim(StringGrid1.Cells[idxFAX, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[1].FAX := RetiraNaoNumero(Trim(StringGrid1.Cells[idxFAX, I]));

      if (Trim(StringGrid1.Cells[idxFLAG_ATIVO, I]) <> '') then // 1
        FORN.FORNECEDORES.FLAG_ATIVO := StrToInt(Trim(StringGrid1.Cells[idxFLAG_ATIVO, I]));

      { *****PESSOAS_ENDERECOS 2***** }
//      if (Trim(StringGrid1.Cells[idxENDERECO2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].ENDERECO := UpperCase(Trim(StringGrid1.Cells[idxENDERECO2, I]));

      if (Trim(StringGrid1.Cells[idxNUMERO2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].NUMERO := Trim(StringGrid1.Cells[idxNUMERO2, I]);

      if (Trim(StringGrid1.Cells[idxCOMPLEMENTO2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].COMPLEMENTO := UpperCase(Trim(StringGrid1.Cells[idxCOMPLEMENTO2, I]));

      if (Trim(StringGrid1.Cells[idxBAIRRO2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].BAIRRO := Trim(StringGrid1.Cells[idxBAIRRO2, I]);

      if (Trim(StringGrid1.Cells[idxCEP2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].CEP := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCEP2, I]));

      if (Trim(StringGrid1.Cells[idxPONTO_REFERENCIA2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].PONTO_REFERENCIA := Trim(StringGrid1.Cells[idxPONTO_REFERENCIA2, I]);

      if (Trim(StringGrid1.Cells[idxCOD_MUNIC2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].COD_MUNIC := RetiraNaoNumero(Trim(StringGrid1.Cells[idxCOD_MUNIC2, I]));

      if (Trim(StringGrid1.Cells[idxNOME_MUNIC2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].NOME_MUNIC := Trim(StringGrid1.Cells[idxNOME_MUNIC2, I]);

      if (Trim(StringGrid1.Cells[idxTELEFONE2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].TELEFONE := RetiraNaoNumero(Trim(StringGrid1.Cells[idxTELEFONE2, I]));

      if (Trim(StringGrid1.Cells[idxFAX2, I]) <> '') then // 1
        FORN.PESSOAS_ENDERECOS[2].FAX := RetiraNaoNumero(Trim(StringGrid1.Cells[idxFAX2, I]));

      if (Trim(StringGrid1.Cells[idxFLAG_ATIVO, I]) <> '') then // 1
        FORN.FORNECEDORES.FLAG_ATIVO := StrToInt(Trim(StringGrid1.Cells[idxFLAG_ATIVO, I]));

      FORN.AppendOrEdit;
      Application.ProcessMessages;
    end;
    FORN.ApplyUpdates;
    DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
    Gauge1.Progress := Gauge1.MaxValue;
    FechaConexoes;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress := 0;
  end;
end;

procedure TfrmExcel.butCamposClick(Sender: TObject);
begin
  MessageRaul_AVISO('COD_PRODUTO ' + #13 + 'COD_GRADE   ' + #13 + 'DESC_PRODUTO' + #13 + 'COD_GRUPO   ' + #13 + 'DESC_GRUPO  ' + #13 + 'COD_IMPOSTO ' + #13 + 'DESC_IMPOSTO' + #13 + 'REFERENCIA  ' +
    #13 + 'COD_BARRA   ' + #13 + 'UNIDADE     ' + #13 + 'VR_PRAZO    ' + #13 + 'VR_VISTA    ' + #13 + 'VR_CUSTO    ' + #13 + 'QTD_ESTOQUE ' + #13 + 'OBS         ' + #13 + 'NCM         ' + #13 +
    'FLAG_ATIVO  ');
end;

procedure TfrmExcel.butCamposClientesClick(Sender: TObject);
begin
  frmListaCampos.ShowModal;
end;

procedure TfrmExcel.butCAMPOSFORNClick(Sender: TObject);
begin
  frmListaCamposFORN.ShowModal;
end;

procedure TfrmExcel.butClientesClick(Sender: TObject);
var
  Inic, Fim: TDateTime;
begin
  vleConexao.Strings.SaveToFile(ArqName);
  OpenDialog1.Filter:='Excel(*.xls;*.xlsx)|*.xls;*.xlsx';
  if OpenDialog1.Execute then
  begin
    Inic            := now;
    Gauge1.Progress := 0;
    if XlsToStringGrid(StringGrid1, OpenDialog1.FileName, Gauge1, lbStatus, True) then
    begin
      CLIENTES;
      Fim            := now;
      lbStatus.Caption := 'Iniciado as ' + FormatDateTime('hh:mm:ss', Inic) + ' e Finalizado as ' + FormatDateTime('hh:mm:ss', Fim);
    end;
  end;
end;

procedure TfrmExcel.butFORNECEDORESClick(Sender: TObject);
var
  Inic, Fim: TDateTime;
begin
  vleConexao.Strings.SaveToFile(ArqName);
  OpenDialog1.Filter:='Excel(*.xls;*.xlsx)|*.xls;*.xlsx';
  if OpenDialog1.Execute then
  begin
    Inic            := now;
    Gauge1.Progress := 0;
    if XlsToStringGrid(StringGrid1, OpenDialog1.FileName, Gauge1, lbStatus, True) then
    begin
      FORNECEDORES;
      Fim            := now;
      lbStatus.Caption := 'Iniciado as ' + FormatDateTime('hh:mm:ss', Inic) + ' e Finalizado as ' + FormatDateTime('hh:mm:ss', Fim);
    end;
  end;

end;

procedure TfrmExcel.butGravarClick(Sender: TObject);
begin
  vleConexao.Strings.SaveToFile(ArqName);
end;

function TfrmExcel.GRUPO_EXISTE(COD_GRUPO, DESC: String): Integer;
begin
  with DM do
  begin
    { Se a coluna COD_GRUPO do arquivo estiver preenchida, o app usa somente ela para verificar a existencia,
      caso não exista cadastra um grupo com a descrição passada, se não houver descrição monta uma com o codigo.
      Se não tiver coluna COD_GRUPO, usa a descrição para localizar, se não existir cadastra uma nova com um novo codigo
    }
    COD_GRUPO := Trim(COD_GRUPO);
    DESC := UpperCase(Trim(DESC));


    // Se os dois campos forem vazios, não perde tempo, coloca o padrão e continua..
    if (COD_GRUPO = '') and (DESC = '') then
    begin
      Result := StrToInt(edtGrupo.Text);
      Exit;
    end;

    // Se tem codigo do grupo
    if Trim(COD_GRUPO) <> '' then
    begin
      // Se não localizou grupo com o codigo passado, cadastra um
      if not qrGRUPOS_PRODUTO.Locate('COD_GRUPO', Trim(COD_GRUPO), []) then
      begin
        if DESC = '' then
          DESC := 'GRUPO ' + COD_GRUPO;
        qrGRUPOS_PRODUTO.Insert;
        qrGRUPOS_PRODUTO.FieldByName('COD_GRUPO').AsString    := Trim(COD_GRUPO);
        qrGRUPOS_PRODUTO.FieldByName('DESC_GRUPO').AsString   := DESC;
        qrGRUPOS_PRODUTO.FieldByName('PERC_MARGEM').AsInteger := 0;
        qrGRUPOS_PRODUTO.Post;
        qrGRUPOS_PRODUTO.ApplyUpdates;
//        qrGRUPOS_PRODUTO.Close;
//        qrGRUPOS_PRODUTO.Open;
      end;
      Result := StrToInt(COD_GRUPO);
      // Se tem codigo, ou já existe ou cadastrou, então é ele
      Exit;
    end
    else
    begin
      // Se não tem codigo mas tem descrição
      if DESC <> '' then
      begin
        // Se não localizou o grupo pela descrição, cadastra um com um novo codigo
        if not qrGRUPOS_PRODUTO.Locate('DESC_GRUPO', DESC, []) then
        begin
          if Trim(COD_GRUPO) = '' then
            COD_GRUPO := IntToStr(GeraCod('SGRUPOS_PRODUTO'));
          qrGRUPOS_PRODUTO.Insert;
          qrGRUPOS_PRODUTO.FieldByName('COD_GRUPO').AsString    := COD_GRUPO;
          qrGRUPOS_PRODUTO.FieldByName('DESC_GRUPO').AsString   := DESC;
          qrGRUPOS_PRODUTO.FieldByName('PERC_MARGEM').AsInteger := 0;
          qrGRUPOS_PRODUTO.Post;
          qrGRUPOS_PRODUTO.ApplyUpdates;
//          qrGRUPOS_PRODUTO.Close;
//          qrGRUPOS_PRODUTO.Open('SELECT * FROM GRUPOS_PRODUTO');
          Result := StrToInt(COD_GRUPO);
          Exit;
        end
        else
          COD_GRUPO := qrGRUPOS_PRODUTO.FieldByName('COD_GRUPO').AsString;
        // Se localizou com a descrição é esse

        Result := StrToInt(COD_GRUPO);
        // Se não tinha codigo, agora ou cadastrou um novo, ou localizou pela descrição.
      end
      else
        Result := StrToInt(edtGrupo.Text);
    end;
  end;
end;

function TfrmExcel.IMPOSTO_EXISTE(COD_IMPOSTO, DESC: String): Integer;
begin
  with DM do
  begin
    { Se a coluna COD_IMPOSTO do arquivo estiver preenchida, o app usa somente ela para verificar a existencia,
      caso não exista cadastra um imposto com a descrição passada, se não houver descrição monta uma com o codigo.
      Se não tiver coluna COD_IMPOSTO, usa a descrição para localizar, se não existir cadastra uma nova com um novo codigo
      Se não existir nenhum dos dois usa o padrão.
    }

    if (Trim(COD_IMPOSTO) = '') and (Trim(DESC) = '') then
    begin
      Result := StrToInt(edtImposto.Text);
      Exit;
    end;

    QR_GigaERP_Aux.Close;
    QR_GigaERP_Aux.Open('SELECT * FROM IMPOSTOS');

    if Trim(COD_IMPOSTO) <> '' then
    begin
      if not QR_GigaERP_Aux.Locate('COD_IMPOSTO', COD_IMPOSTO, []) then
      begin
        if Trim(DESC) = '' then
          DESC := 'IMPOSTO ' + COD_IMPOSTO;
        QR_GigaERP_Aux.Append;
        QR_GigaERP_Aux.FieldByName('COD_IMPOSTO').AsString := COD_IMPOSTO;
        QR_GigaERP_Aux.FieldByName('DESC_IMPOSTO').AsString := DESC;
        QR_GigaERP_Aux.FieldByName('FLAG_SERVICO').AsInteger := 0;
        QR_GigaERP_Aux.Post;
        QR_GigaERP_Aux.ApplyUpdates;
      end;
      Result := StrToInt(COD_IMPOSTO);
      Exit;
    end
    else
    begin
      if Trim(DESC) <> '' then
      begin
        if not QR_GigaERP_Aux.Locate('DESC_IMPOSTO', DESC, []) then
        begin
          if Trim(COD_IMPOSTO) = '' then
            COD_IMPOSTO := IntToStr(GeraCod('SIMPOSTOS'));
          QR_GigaERP_Aux.Append;
          QR_GigaERP_Aux.FieldByName('COD_IMPOSTO').AsString := COD_IMPOSTO;
          QR_GigaERP_Aux.FieldByName('DESC_IMPOSTO').AsString := DESC;
          QR_GigaERP_Aux.FieldByName('FLAG_SERVICO').AsInteger := 0;
          QR_GigaERP_Aux.Post;
          QR_GigaERP_Aux.ApplyUpdates;
          Exit;
        end
        else
          COD_IMPOSTO := QR_GigaERP_Aux.FieldByName('COD_IMPOSTO').AsString;
        Result        := StrToInt(COD_IMPOSTO);
      end
      else
        Result := StrToInt(edtImposto.Text);
    end;
  end;
end;

function TfrmExcel.IDXcampos(campo: String): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I  := 1 to StringGrid1.ColCount - 1 do
  begin
    if UpperCase(StringGrid1.Cells[I, 0]) = UpperCase(campo) then
    begin
      Result := I;
      Exit;
    end;
    // if I = StringGrid1.ColCount - 1 then
    // raise Exception.Create('Campo '+campo+' não encontrado.');
  end;

  // if campo = 'COD_PRODUTO' then
  // Result := 0
  // else if campo = 'COD_GRADE' then
  // Result := 1
  // else if campo = 'DESC_PRODUTO' then
  // Result := 2
  // else if campo = 'COD_GRUPO' then
  // Result := 3
  // else if campo = 'DESC_GRUPO' then
  // Result := 4
  // else if campo = 'COD_IMPOSTO' then
  // Result := 5
  // else if campo = 'DESC_IMPOSTO' then
  // Result := 6
  // else if campo = 'REFERENCIA' then
  // Result := 7
  // else if campo = 'COD_BARRA' then
  // Result := 8
  // else if campo = 'UNIDADE' then
  // Result := 9
  // else if campo = 'VR_PRAZO' then
  // Result := 10
  // else if campo = 'VR_VISTA' then
  // Result := 11
  // else if campo = 'VR_CUSTO' then
  // Result := 12
  // else if campo = 'QTD_ESTOQUE' then
  // Result := 13
  // else if campo = 'OBS' then
  // Result := 14
  // else if campo = 'NCM' then
  // Result := 15
end;

procedure TfrmExcel.PRODUTOS;
var
  PROD       : TCadastro_Produtos;
  QTD        : Double;
  COD        : Integer;
  COD_GRADE  : string;
  SQL        : string;
  I, II      : Integer;
  MARCA      : String;
  COD_PRODUTO: string;
  COD_IMPOSTO: String;

  idxCOD_PRODUTO, idxCOD_GRADE, idxDESC_PRODUTO, idxCOD_GRUPO, idxDESC_GRUPO, idxCOD_IMPOSTO, idxDESC_IMPOSTO, idxREFERENCIA, idxCOD_BARRA, idxUNIDADE, idxVR_PRAZO, idxVR_VISTA, idxVR_CUSTO,
    idxQTD_ESTOQUE, idxOBS, idxNCM: Integer;
  idxFLAG_ATIVO                   : Integer;
begin
  ConectaGiga;

  DM.qrGRUPOS_PRODUTO.Close;
  DM.qrGRUPOS_PRODUTO.Open;

  DM.QR_GigaERP_Aux.Close;
  DM.QR_GigaERP_Aux.Open('SELECT * FROM IMPOSTOS');

  DM.qrCLASS_FISCAIS.Close;
  DM.qrCLASS_FISCAIS.Open('SELECT * FROM CLASS_FISCAIS');

  if not DM.qrCLASS_FISCAIS.Locate('COD_CLASS', edtNCM.Text, []) then
  begin
    // MessageRaul_ATENCAO('NCM '+edtNCM.Text+' não existe no banco.'+#13+'Importação abortada.');
    // Exit;
    DM.qrCLASS_FISCAIS.Append;
    DM.qrCLASS_FISCAIS.FieldByName('COD_CLASS').AsString   := edtNCM.Text;
    DM.qrCLASS_FISCAIS.FieldByName('DESC_CLASS').AsString  := 'OUTROS';
    DM.qrCLASS_FISCAIS.FieldByName('FLAG_ATIVO').AsInteger := 1;
    DM.qrCLASS_FISCAIS.Post;
    DM.qrCLASS_FISCAIS.ApplyUpdates();
  end;

  idxCOD_PRODUTO  := IDXcampos('COD_PRODUTO');
  idxCOD_GRADE    := IDXcampos('COD_GRADE');
  idxDESC_PRODUTO := IDXcampos('DESC_PRODUTO');
  idxCOD_GRUPO    := IDXcampos('COD_GRUPO');
  idxDESC_GRUPO   := IDXcampos('DESC_GRUPO');
  idxCOD_IMPOSTO  := IDXcampos('COD_IMPOSTO');
  idxDESC_IMPOSTO := IDXcampos('DESC_IMPOSTO');
  idxREFERENCIA   := IDXcampos('REFERENCIA');
  idxCOD_BARRA    := IDXcampos('COD_BARRA');
  idxUNIDADE      := IDXcampos('UNIDADE');
  idxVR_PRAZO     := IDXcampos('VR_PRAZO');
  idxVR_VISTA     := IDXcampos('VR_VISTA');
  idxVR_CUSTO     := IDXcampos('VR_CUSTO');
  idxQTD_ESTOQUE  := IDXcampos('QTD_ESTOQUE');
  idxOBS          := IDXcampos('OBS');
  idxNCM          := IDXcampos('NCM');
  idxFLAG_ATIVO   := IDXcampos('FLAG_ATIVO');

  if idxCOD_PRODUTO = 0 then
    raise Exception.Create('A coluna COD_PRODUTO deve existir e conter valores.');

  Gauge1.MaxValue := StringGrid1.RowCount;
  Gauge1.Progress := 0;
  PROD            := TCadastro_Produtos.Create;
  try
    PROD.Open;

    PROD.COD_EMPRESA := StrToInt(edtEmpresa.Text);

    lbStatus.Caption := 'Importando Registros';
    for I          := 1 to StringGrid1.RowCount - 1 do
    begin
      Gauge1.AddProgress(1);
      lbProgress.Caption := IntToStr(Gauge1.Progress) + '/' + IntToStr(Gauge1.MaxValue);

      if Trim(StringGrid1.Cells[idxCOD_PRODUTO, I]) = '' then // 0
        Continue;
      PROD.PRODUTOS.COD_PRODUTO := StrZeros(StringGrid1.Cells[idxCOD_PRODUTO, I], 13);
      COD_PRODUTO := PROD.PRODUTOS.COD_PRODUTO;
      if (Trim(StringGrid1.Cells[idxCOD_GRADE, I]) = '') then // 1
        PROD.PRODUTOS_GRADE.COD_GRADE := '*'
      else
        PROD.PRODUTOS_GRADE.COD_GRADE := StringGrid1.Cells[idxCOD_GRADE, I];

      if Trim(StringGrid1.Cells[idxDESC_PRODUTO, I]) = '' then // \ 2
        raise Exception.Create('A coluna DESC_PRODUTO  deve estar preenchida.');
      PROD.PRODUTOS.DESC_PRODUTO := UpperCase(Trim(StringGrid1.Cells[idxDESC_PRODUTO, I]));

      // Se não existir cod_grupo e nem desc_grupo usa o padrão.
      if (Trim(StringGrid1.Cells[idxCOD_GRUPO, I]) = '') and (Trim(StringGrid1.Cells[idxDESC_GRUPO, I]) = '') then
        PROD.PRODUTOS.COD_GRUPO := StrToInt(edtGrupo.Text)

      else // Se existir um dos dois, verifica se o registro existe, se não cadastra novo
        PROD.PRODUTOS.COD_GRUPO := GRUPO_EXISTE(StringGrid1.Cells[idxCOD_GRUPO, I], StringGrid1.Cells[idxDESC_GRUPO, I]);

      if (Trim(StringGrid1.Cells[idxCOD_IMPOSTO, I]) = '') and (Trim(StringGrid1.Cells[idxDESC_IMPOSTO, I]) = '') then
        PROD.PRODUTOS.COD_IMPOSTO := StrToInt(edtImposto.Text)
      else // Se existir um dos dois, verifica se o registro existe, se não cadastra novo
        PROD.PRODUTOS.COD_IMPOSTO := IMPOSTO_EXISTE(StringGrid1.Cells[idxCOD_IMPOSTO, I], StringGrid1.Cells[idxDESC_IMPOSTO, I]);

      if Trim(StringGrid1.Cells[idxREFERENCIA, I]) <> '' then
        PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO := StringGrid1.Cells[idxREFERENCIA, I];

      if Trim(StringGrid1.Cells[idxCOD_BARRA, I]) <> '' then
        PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO := StringGrid1.Cells[idxCOD_BARRA, I];

      if Trim(StringGrid1.Cells[idxUNIDADE, I]) = '' then
        PROD.PRODUTOS_GRADE_UND[1].UNIDADE := 'un'
      else
        PROD.PRODUTOS_GRADE_UND[1].UNIDADE := StringGrid1.Cells[idxUNIDADE, I];

      if Trim(StringGrid1.Cells[idxFLAG_ATIVO, I]) = '' then
        PROD.PRODUTOS.FLAG_ATIVO := 1
      else
        PROD.PRODUTOS.FLAG_ATIVO := StrToInt(StringGrid1.Cells[idxFLAG_ATIVO, I]);

      if Trim(StringGrid1.Cells[idxVR_PRAZO, I]) = '' then
        PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := 0.00
      else
        PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := StrToFloat(StringGrid1.Cells[idxVR_PRAZO, I]);

      if Trim(StringGrid1.Cells[idxVR_VISTA, I]) = '' then
        PROD.PRODUTOS_TAB_PRECOS_PROD[2].PRECO := PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO
      else
        PROD.PRODUTOS_TAB_PRECOS_PROD[2].PRECO := StrToFloat(StringGrid1.Cells[idxVR_VISTA, I]);

      if Trim(StringGrid1.Cells[idxVR_CUSTO, I]) = '' then
        PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := 0.00
      else
        PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := StrToFloat(StringGrid1.Cells[idxVR_CUSTO, I]);

      if Trim(StringGrid1.Cells[idxQTD_ESTOQUE, I]) <> '' then
        PROD.PRODUTOS_GRADE.QTD_ESTOQUE := StrToFloat(StringGrid1.Cells[idxQTD_ESTOQUE, I]);

      if Trim(StringGrid1.Cells[idxCOD_PRODUTO, I]) <> '' then
        PROD.PRODUTOS.OBS := StringGrid1.Cells[idxOBS, I];

      if (Trim(StringGrid1.Cells[idxNCM, I]) = '') OR (not DM.qrCLASS_FISCAIS.Locate('COD_CLASS', Trim(StringGrid1.Cells[idxNCM, I]), [])) then
        PROD.PRODUTOS.COD_CLASS := edtNCM.Text
      else
        PROD.PRODUTOS.COD_CLASS := StringGrid1.Cells[idxNCM, I];

      PROD.AppendOrEdit;
      Application.ProcessMessages;
    end;
    GRUPO_EXISTE(edtGrupo.Text, 'GERAL');
    IMPOSTO_EXISTE(edtImposto.Text, '');
    lbStatus.Caption := 'Comitando Trabalho...';
    PROD.ApplyUpdates;
    Gauge1.Progress := Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress := 0;
  finally
    DM.FechaConexoes;
    PROD.Free;
  end;
end;

procedure TfrmExcel.butImportClick(Sender: TObject);
begin
  // if ComboBox1.Text='CLIENTES'        then CLIENTES        else
  // if ComboBox1.Text='FORNECEDORES'    then FORNECEDORES    else
  // if ComboBox1.Text='TRANSPORTADORAS' then TRANSPORTADORAS else
  // if ComboBox1.Text='GRUPOS_PRODUTOS' then GRUPOS_PRODUTOS else
  // if ComboBox1.Text='PRODUTOS'        then PRODUTOS        else
  // if ComboBox1.Text='MARCAS'          then MARCAS          else
  // if ComboBox1.Text='RELACIONAMENTO'  then RELAC_DESC      else
  // MessageRaul_ATENCAO('Uma ação deve ser selecionada antes.');
end;

procedure TfrmExcel.buttesteClick(Sender: TObject);
var
  s: TArray<string>;
  I: string;
begin
  SetLength(s, 3);
  if InputQuery('Dados', ['Nome:', 'End.:', 'OBS.:'], s) then
    for I in s do
      MessageRaul_AVISO(I);
end;

procedure TfrmExcel.Button1Click(Sender: TObject);
var
  Inic, Fim: TDateTime;
begin
  vleConexao.Strings.SaveToFile(ArqName);
  OpenDialog1.Filter:='Excel(*.xls;*.xlsx)|*.xls;*.xlsx';
  if OpenDialog1.Execute then
  begin
    Inic            := now;
    Gauge1.Progress := 0;
    if XlsToStringGrid(StringGrid1, OpenDialog1.FileName, Gauge1, lbStatus, True) then
    begin
      PRODUTOS;
      Fim            := now;
      lbStatus.Caption := 'Iniciado as ' + FormatDateTime('hh:mm:ss', Inic) + ' e Finalizado as ' + FormatDateTime('hh:mm:ss', Fim);
    end;
  end;
end;

procedure TfrmExcel.butBancoGigaClick(Sender: TObject);
begin
  OpenDialog1.Filter:='Banco Firebird (*.FDB)|*.FDB';
  if OpenDialog1.Execute then
    vleConexao.Values['Database'] := OpenDialog1.FileName;
end;

procedure TfrmExcel.Button3Click(Sender: TObject);
begin
  ConectaGiga;
  frmCadastrosBasicos.Tag := 1;
  frmCadastrosBasicos.ShowModal;
end;

procedure TfrmExcel.Button4Click(Sender: TObject);
begin
  ConectaGiga;
  frmCadastrosBasicos.Tag := 0;
  frmCadastrosBasicos.ShowModal;
end;

procedure TfrmExcel.checkMesmoCodigoClick(Sender: TObject);
begin
  if checkMesmoCodigo.Checked then
    MessageRaul_ATENCAO('Para atribuir código aos clientes pelo arquivo,'+#13+
                        'Não pode haver cadastros de pessoas no banco, exceto os padrões, que são:'+#13+
                        'VENDEDOR PADRÃO   : Cod 1'+#13+
                        'VENDA A CONSUMIDOR: Cod 2'+#13+
                        'GIGACHEF PADRÃO   : Cod 3'+#13+
                        'Por tanto deve-se reparar que os códigos 1,2 e 3 não pode ser usados,'+#13+
                        'se no arquivo possuir esses códigos, será necessário envia-los para as ultimas posições.'+#13+
                        'Os códigos devem ser númericos inteiros.');
end;

procedure TfrmExcel.chkVerStringGridClick(Sender: TObject);
begin
  StringGrid1.Visible := chkVerStringGrid.Checked;
end;

procedure TfrmExcel.TRANSPORTADORAS;
var
  TRANS    : TCadastro_Pessoas;
  DATA_CAD : String;
  DATA_NASC: String;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_TRANSPORTADORAS');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue     := qrImport.RecordCount + 1;
    Gauge1.Progress     := 0;
    TRANS               := TCadastro_Pessoas.Create;
    TRANS.TIPO_CADASTRO := 3;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      TRANS.PESSOAS.CHAVE_OLD                := qrImport.FieldByName('CODIGO').AsString;
      TRANS.PESSOAS.RAZAO_SOCIAL             := qrImport.FieldByName('RAZAOSOCIAL').AsString;
      TRANS.PESSOAS_ENDERECOS[1].ENDERECO    := qrImport.FieldByName('ENDERECO').AsString;
      TRANS.PESSOAS_ENDERECOS[1].BAIRRO      := qrImport.FieldByName('BAIRRO').AsString;
      TRANS.PESSOAS_ENDERECOS[1].NOME_MUNIC  := qrImport.FieldByName('MUNICIPIO').AsString;
      TRANS.PESSOAS_ENDERECOS[1].CEP         := qrImport.FieldByName('CEP').AsString;
      TRANS.PESSOAS_ENDERECOS[1].UF          := qrImport.FieldByName('ESTADO').AsString;
      TRANS.PESSOAS.INSCR_ESTADUAL           := qrImport.FieldByName('INSCRICAOESTADUAL').AsString;
      TRANS.PESSOAS.CNPJ_CPF                 := qrImport.FieldByName('CGC').AsString;
      TRANS.PESSOAS_ENDERECOS[1].TELEFONE    := qrImport.FieldByName('NUMEROTELEFONE').AsString;
      TRANS.PESSOAS_ENDERECOS[1].FAX         := qrImport.FieldByName('NUMEROFAX').AsString;
      TRANS.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('NOMEDOCONTATO').AsString;
      TRANS.PESSOAS.EMAIL                    := qrImport.FieldByName('EMAIL').AsString;
      // TRANS.PESSOAS.CHAVE_OLD              := qrImport.FieldByName('FLAG'             ).AsString;
      TRANS.PESSOAS.NOME_FANTASIA := qrImport.FieldByName('NOMEFANTASIA').AsString;
      // TRANS.PESSOAS.CHAVE_OLD              := qrImport.FieldByName('VINCULADO'        ).AsString;
      TRANS.AppendOrEdit;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    TRANS.ApplyUpdates;
    DM.ConexaoGigaERP.ExecSQL('EXECUTE PROCEDURE PR_RESETAR_TODAS_SEQUENCIAS;');
    Gauge1.Progress := Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress := 0;
  end;
end;

procedure TfrmExcel.ComboBox1Change(Sender: TObject);
begin
  // ComboBox1.Items.Add('CLIENTES');
  // ComboBox1.Items.Add('FORNECEDORES');
  // ComboBox1.Items.Add('TRANSPORTADORAS');
  // ComboBox1.Items.Add('GRUPOS_PRODUTOS');
  // ComboBox1.Items.Add('PRODUTOS');
end;

procedure TfrmExcel.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    vleConexao.Strings.SaveToFile(ArqName);
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmExcel.edtEmpresaExit(Sender: TObject);
begin
  if Trim(edtEmpresa.Text)='' then
    edtEmpresa.Text := '1';
end;

procedure TfrmExcel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmExcel.FormCreate(Sender: TObject);
var
  dll: string;
begin
  VerificaFREE;

  dll := ExtractFilePath(Application.ExeName) + '\fbclient.dll';
  if not FileExists(dll) then
  begin
    MessageRaul_ERRO('Esta aplicação deve estar rodando na pasta app do GigaERP.');
    Application.Terminate;
  end;
  lbProgress.Caption := '';
  lbStatus.Caption:='';
  Self.Caption   := 'Versão: ' + VersaoEXE() + ' - Importador de arquivos Excel para GigaERP';
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmExcel.FormDestroy(Sender: TObject);
begin
  vleConexao.Strings.SaveToFile(ArqName);
  ChecaVersaoSimple
end;

procedure TfrmExcel.FormShow(Sender: TObject);
begin
  ArqName := StringReplace(Application.ExeName, '.exe', '.ini', [rfReplaceAll, rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
