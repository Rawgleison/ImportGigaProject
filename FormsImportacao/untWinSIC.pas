unit untWinSIC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JclDebug, RotinasRaul, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit
  ,StrUtils, FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.Stan.Error,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, Vcl.WinXCtrls, FireDAC.VCLUI.Wait;
type
  TfrmWinSIC = class(TForm)
    Panel1: TPanel;
    Gauge1: TGauge;
    Label1: TLabel;
    butProdutos: TButton;
    vleConexao: TValueListEditor;
    butGravar: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    butClientes: TButton;
    butFornecedores: TButton;
    Memo1: TMemo;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butGravarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure butProdutosClick(Sender: TObject);
    procedure butClientesClick(Sender: TObject);
    procedure butFornecedoresClick(Sender: TObject);
  private
    procedure ConectaGiga;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWinSIC: TfrmWinSIC;
  ArqName: string;


implementation

{$R *.dfm}

uses untDM;


procedure TfrmWinSIC.butClientesClick(Sender: TObject);
var
  CLI: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_CLIENTES');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;
    Gauge1.Progress:=0;
    CLI:=TCadastro_Pessoas.Create;
    CLI.TIPO_CADASTRO:=1;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      CLI.PESSOAS.CHAVE_OLD                := qrImport.FieldByName('CONTROLE'   ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('CODIGO'     ).AsString;
      CLI.PESSOAS.RAZAO_SOCIAL             := qrImport.FieldByName('NOME'       ).AsString;
      CLI.PESSOAS_ENDERECOS[1].ENDERECO    := qrImport.FieldByName('ENDERECO'   ).AsString;
      CLI.PESSOAS_ENDERECOS[1].BAIRRO      := qrImport.FieldByName('BAIRRO'     ).AsString;
      CLI.PESSOAS_ENDERECOS[1].NOME_MUNIC  := qrImport.FieldByName('CIDADE'     ).AsString;
      CLI.PESSOAS_ENDERECOS[1].UF          := qrImport.FieldByName('ESTADO'     ).AsString;
      CLI.PESSOAS_ENDERECOS[1].CEP         := qrImport.FieldByName('CEP'        ).AsString;
      CLI.PESSOAS_ENDERECOS[1].TELEFONE    := qrImport.FieldByName('TELEFONE'   ).AsString;
      CLI.CLIENTES.REFERENCIA_COMERCIAL1   := qrImport.FieldByName('REFBAN'     ).AsString;
      DATA_CAD                             := qrImport.FieldByName('DATA'       ).AsString;
      if Trim(DATA_CAD) <> '' then
        CLI.PESSOAS.DATA_CADASTRO          := StrToDate(DATA_CAD);
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('LKTIPO'     ).AsInteger;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('LKVENDEDOR' ).AsInteger;
      CLI.PESSOAS.OBS_PESSOA               := qrImport.FieldByName('OBS'        ).AsString;
      CLI.PESSOAS.EMAIL                    := qrImport.FieldByName('EMAIL'      ).AsString;
      CLI.PESSOAS.SITE                     := qrImport.FieldByName('WEB'        ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('NUMCARTAO'  ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('VALIDADE'   ).AsString;
      CLI.CLIENTES.TRAB_LOCAL              := qrImport.FieldByName('NOMEIMP'    ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('LKCARTAO'   ).AsInteger;
      CLI.PESSOAS.CNPJ_CPF                 := qrImport.FieldByName('CGC'        ).AsString;
      CLI.CLIENTES.LIMITE_CREDITO          := qrImport.FieldByName('LIMITECRED' ).AsFloat;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('ATENDBLOQ'  ).AsInteger;
      CLI.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO'    ).AsString;
      CLI.PESSOAS.INSCR_ESTADUAL           := qrImport.FieldByName('INSC'       ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('ATIVIDADE'  ).AsString;
      CLI.PESSOAS_ENDERECOS[1].FAX         := qrImport.FieldByName('FAX'        ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('TAGFISICA'  ).AsInteger;
      CLI.CLIENTES.REFERENCIA_COMERCIAL2   := qrImport.FieldByName('REFCOM'     ).AsString;
      CLI.PESSOAS.RG                       := qrImport.FieldByName('IDENTIDADE' ).AsString;
      DATA_NASC                            := qrImport.FieldByName('NASCIMENTO' ).AsString;
      if Trim(DATA_NASC) <> '' then
        CLI.CLIENTES.DATA_NASCIMENTO       := StrToDate(DATA_NASC);
      CLI.CLIENTES.REFERENCIA_COMERCIAL3   := qrImport.FieldByName('FILIACAO'   ).AsString;
      CLI.CLIENTES.TRAB_PROFISSAO          := qrImport.FieldByName('PROFISSAO'  ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('FOTO'       ).AsString;
//      CLI.PESSOAS.COD_PESSOA             := qrImport.FieldByName('SENHA'      ).AsString;
      CLI.AppendOrEdit;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    CLI.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmWinSIC.butFornecedoresClick(Sender: TObject);
var
  FORN: TCadastro_Pessoas;
  DATA_CAD: String;
  DATA_NASC: String;
begin
  with DM do
  begin
    ConectaGiga;
    qrImport.Open('SELECT * FROM IMPORT_FORNECEDORES');
    qrImport.Last;
    qrImport.First;
    Gauge1.MaxValue:=qrImport.RecordCount+1;
    Gauge1.Progress:=0;
    FORN:=TCadastro_Pessoas.Create;
    FORN.TIPO_CADASTRO:=2;
    while not qrImport.Eof do
    begin
      Gauge1.AddProgress(1);
      FORN.PESSOAS.CHAVE_OLD                := qrImport.FieldByName('CONTROLE'   ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('CODIGO'     ).AsString;
      FORN.PESSOAS.RAZAO_SOCIAL             := qrImport.FieldByName('EMPRESA'    ).AsString;
      FORN.PESSOAS_ENDERECOS[1].ENDERECO    := qrImport.FieldByName('ENDERECO'   ).AsString;
      FORN.PESSOAS_ENDERECOS[1].BAIRRO      := qrImport.FieldByName('BAIRRO'     ).AsString;
      FORN.PESSOAS_ENDERECOS[1].NOME_MUNIC  := qrImport.FieldByName('CIDADE'     ).AsString;
      FORN.PESSOAS_ENDERECOS[1].UF          := qrImport.FieldByName('ESTADO'     ).AsString;
      FORN.PESSOAS_ENDERECOS[1].CEP         := qrImport.FieldByName('CEP'        ).AsString;
      FORN.PESSOAS_ENDERECOS[1].TELEFONE    := qrImport.FieldByName('TELEFONE'   ).AsString;
//      FORN.CLIENTES.REFERENCIA_COMERCIAL1   := qrImport.FieldByName('REFBAN'     ).AsString;
      DATA_CAD                             := qrImport.FieldByName('DATA'       ).AsString;
      if Trim(DATA_CAD) <> '' then
        FORN.PESSOAS.DATA_CADASTRO          := StrToDate(DATA_CAD);
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('LKTIPO'     ).AsInteger;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('LKVENDEDOR' ).AsInteger;
      FORN.PESSOAS.OBS_PESSOA               := qrImport.FieldByName('OBS'        ).AsString;
      FORN.PESSOAS.EMAIL                    := qrImport.FieldByName('EMAIL'      ).AsString;
//      FORN.PESSOAS.SITE                     := qrImport.FieldByName('WEB'        ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('NUMCARTAO'  ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('VALIDADE'   ).AsString;
//      FORN.CLIENTES.TRAB_LOCAL              := qrImport.FieldByName('NOMEIMP'    ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('LKCARTAO'   ).AsInteger;
      FORN.PESSOAS.CNPJ_CPF                 := qrImport.FieldByName('CGC'        ).AsString;
//      FORN.CLIENTES.LIMITE_CREDITO          := qrImport.FieldByName('LIMITECRED' ).AsFloat;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('ATENDBLOQ'  ).AsInteger;
      FORN.PESSOAS_CONTATOS[1].DESC_CONTATO := qrImport.FieldByName('CONTATO'    ).AsString;
      FORN.PESSOAS.INSCR_ESTADUAL           := qrImport.FieldByName('INSC'       ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('ATIVIDADE'  ).AsString;
      FORN.PESSOAS_ENDERECOS[1].FAX         := qrImport.FieldByName('FAX'        ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('TAGFISICA'  ).AsInteger;
//      FORN.CLIENTES.REFERENCIA_COMERCIAL2   := qrImport.FieldByName('REFCOM'     ).AsString;
//      FORN.PESSOAS.RG                       := qrImport.FieldByName('IDENTIDADE' ).AsString;
//      DATA_NASC                            := qrImport.FieldByName('NASCIMENTO' ).AsString;
//      if Trim(DATA_NASC) <> '' then
//        FORN.CLIENTES.DATA_NASCIMENTO       := StrToDate(DATA_NASC);
//      FORN.CLIENTES.REFERENCIA_COMERCIAL3   := qrImport.FieldByName('FILIACAO'   ).AsString;
//      FORN.CLIENTES.TRAB_PROFISSAO          := qrImport.FieldByName('PROFISSAO'  ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('FOTO'       ).AsString;
//      FORN.PESSOAS.COD_PESSOA             := qrImport.FieldByName('SENHA'      ).AsString;
      FORN.AppendOrEdit;
      qrImport.Next;
      Application.ProcessMessages;
    end;
    FORN.ApplyUpdates;
    Gauge1.Progress:=Gauge1.MaxValue;
    MessageRaul_AVISO('PROCESSO CONCLUIDO...');
    Gauge1.Progress:=0;
  end;
end;

procedure TfrmWinSIC.butGravarClick(Sender: TObject);
begin
    vleConexao.Strings.SaveToFile(ArqName);
end;

procedure TfrmWinSIC.butProdutosClick(Sender: TObject);
var
  PROD: TCadastro_Produtos;
  QTD: Double;
begin
  ConectaGiga;
  DM.qrImport.Open('SELECT * FROM IMPORT_PRODUTOS');
  dm.qrImport.Last;
  dm.qrImport.First;
  Gauge1.MaxValue:=dm.qrImport.RecordCount+1;
  Gauge1.Progress:=0;
  PROD:=TCadastro_Produtos.Create;
  PROD.Open;
  PROD.Cadastra_imposto_padrao;
  PROD.Cadastra_Grupo_Padrão;
  PROD.CadastraRelacionamento(1,'FABRICANTE');
  PROD.Cadastra_NCM_99;
  while not dm.qrImport.Eof do
  begin
    Gauge1.AddProgress(1);
    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CONTROLE'     ).AsString;
    PROD.PRODUTOS_APELIDOS_PROD[2].APELIDO := dm.qrImport.FieldByName('CODIGO'       ).AsString;
    PROD.PRODUTOS_APELIDOS_PROD[3].APELIDO := dm.qrImport.FieldByName('CODINTERNO'   ).AsString;
    PROD.PRODUTOS.DESC_PRODUTO := dm.qrImport.FieldByName('PRODUTO'      ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LKSETOR'      ).AsInteger;
    PROD.PRODUTOS_TABELA[1].TABELA_ITEM_DESC := dm.qrImport.FieldByName('FABRICANTE'   ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LKFORNEC'     ).AsInteger;
    PROD.PRODUTOS_CUSTO[1].PRECO_CUSTO := dm.qrImport.FieldByName('PRECOCUSTO'   ).AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CUSTOMEDIO'   ).AsFloat;
    PROD.PRODUTOS_TAB_PRECOS_PROD[1].PRECO := dm.qrImport.FieldByName('PRECOVENDA'   ).AsFloat;
    PROD.PRODUTOS_GRADE.QTD_ESTOQUE := dm.qrImport.FieldByName('QUANTIDADE'   ).AsFloat;
    PROD.PRODUTOS_GRADE.ESTOQUE_MIN := dm.qrImport.FieldByName('ESTMINIMO'    ).AsFloat;
    PROD.PRODUTOS_GRADE_UND[1].UNIDADE := dm.qrImport.FieldByName('UNIDADE'      ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LUCRO'        ).AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('MOEDA'        ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ULTREAJ'      ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('FOTO'         ).AsString;
    PROD.PRODUTOS.OBS := dm.qrImport.FieldByName('OBS'          ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('NAOSAITABELA' ).AsInteger;
    PROD.PRODUTOS.FLAG_ATIVO := StrToInt(IfThen(dm.qrImport.FieldByName('INATIVO'      ).AsString='FALSE','0','1'));
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CODIPI'       ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('IPI'          ).AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('CST'          ).AsString;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('ICMS'         ).AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('BASECALCULO'  ).AsFloat;
    PROD.PRODUTOS.PESO_BRUTO := dm.qrImport.FieldByName('PESOBRUTO'    ).AsFloat;
    PROD.PRODUTOS.PESO_LIQUIDO := dm.qrImport.FieldByName('PESOLIQ'      ).AsFloat;
//    PROD.PRODUTOS.COD_PRODUTO := dm.qrImport.FieldByName('LKMODULO'     ).AsInteger;
    PROD.AppendOrEdit;
    dm.qrImport.Next;
  end;
  PROD.ApplyUpdates;
end;

procedure TfrmWinSIC.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    vleConexao.Values['Database']:=OpenDialog1.FileName;
end;

procedure TfrmWinSIC.ConectaGiga;
begin
  if FileExists(ArqName) then
  begin
    DM.ConexaoGigaERP.Params.LoadFromFile(ArqName);
    DM.ConexaoGigaERP.Open();
    MessageRaul_AVISO('Conectado...');
  end
  else
    raise Exception.Create('Arquivo de configuração Não encontrado.');
end;

procedure TfrmWinSIC.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
//  ActivityIndicator1.Brush.Color := clWhite;
//  ActivityIndicator1.Visible:=False;
end;

procedure TfrmWinSIC.FormShow(Sender: TObject);
begin
  ArqName:=StringReplace(Application.ExeName,'.exe','.ini',[rfReplaceAll,rfIgnoreCase]);
  if FileExists(ArqName) then
    vleConexao.Strings.LoadFromFile(ArqName);
end;

end.
