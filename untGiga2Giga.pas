unit untGiga2Giga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Samples.Gauges,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FireDAC.Stan.StorageXML, Vcl.Bind.Grid, Data.Bind.Grid, Vcl.Grids,
  Vcl.WinXCtrls, Vcl.Menus, Vcl.DBCtrls, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList, FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.Comp.UI;

type
  TfrmGiga2Giga = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtOrigem: TButtonedEdit;
    edtDestino: TButtonedEdit;
    edtServer: TEdit;
    edtPorta: TEdit;
    edtLogin: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    butImporta: TButton;
    OpenDialog1: TOpenDialog;
    gaugTabela: TGauge;
    gaugTotal: TGauge;
    edtSenha: TEdit;
    Label7: TLabel;
    fdmtParametros: TFDMemTable;
    fdmtParametrosORIGEM: TStringField;
    fdmtParametrosDESTINO: TStringField;
    fdmtParametrosSERVER: TStringField;
    fdmtParametrosPORTA: TIntegerField;
    fdmtParametrosLOGIN: TStringField;
    fdmtParametrosSENHA: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    memoLog: TMemo;
    labVersaoOrigem: TLabel;
    labVersaoDestino: TLabel;
    Panel1: TPanel;
    labContagem: TLabel;
    cbEditar: TCheckBox;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    cboxImporta: TComboBox;
    cboxTabela: TComboBox;
    Label6: TLabel;
    DataSource1: TDataSource;
    Label8: TLabel;
    imgl1: TImageList;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    procedure edtOrigemRightButtonClick(Sender: TObject);
    procedure edtDestinoRightButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure butImportaClick(Sender: TObject);
    procedure cboxImportaChange(Sender: TObject);
  private
    procedure ListaTabela;
    procedure ConectarOrigem;
    procedure ConectarDestino;
    procedure GravaDados;
    procedure LerDados;
    procedure VerificaVersao;
    procedure GeraLog(Msg: String;Erro: Boolean=False);
    procedure LimpaTela;
    procedure RecuperaPK(TABELA: String; var qtdPK:Integer; var CAMPOS:String);
    procedure FechaConexoes;
    procedure ValoresPadroes;
    { Private declarations }
    procedure IMPORTA_DADOS(TABELA: String; CONDICAO: String='');
    procedure IMPORTA_PRODUTOS;
    procedure IMPORTA_CLIENTES;
    procedure IMPORTA_FORNECEDORES;
    procedure IMPORTA_VENDEDORES;
  public
    { Public declarations }
  end;

var
  frmGiga2Giga: TfrmGiga2Giga;

implementation

{$R *.dfm}

uses untDM, RotinasRaul, untMsgErro;

procedure TfrmGiga2Giga.butImportaClick(Sender: TObject);
var
  campos: String;
  qtdPK: Integer;
begin
  try
    try
    if (cboxImporta.Text='OUTRA TABELA') and (Trim(cboxTabela.Text)<>'') then
      IMPORTA_DADOS(cboxTabela.Text)
    else if cboxImporta.Text='PRODUTOS' then
      IMPORTA_PRODUTOS
    else if cboxImporta.Text='CLIENTES' then
      IMPORTA_CLIENTES
    else if cboxImporta.Text='VENDEDORES\GARÇONS' then
      IMPORTA_VENDEDORES
    else if cboxImporta.Text='FORNECEDORES' then
      IMPORTA_FORNECEDORES
    else MessageRaul_ATENCAO('Um cadastro\Tabela deve ser selecionado para a importação');

    DM.conexaoDestino.ExecSQL('execute procedure pr_resetar_todas_sequencias');
    MessageRaul_AVISO('Processo concluido');
    finally
      FechaConexoes;
      LimpaTela;
    end;
  except
    on E:Exception do
    begin
      GeraLog('[butImportaClick]'+#13+E.Message);
      MessageRaul_ERRO('[butImportaClick]'+#13+E.Message);
    end;
  end;
end;

procedure TfrmGiga2Giga.cboxImportaChange(Sender: TObject);
begin
  cboxTabela.Enabled:=(cboxImporta.Text='OUTRA TABELA');

end;

procedure TfrmGiga2Giga.ConectarDestino;
begin
  try
    with DM do
    begin
      conexaoDestino.Close;
      conexaoDestino.Params.Database:=edtDestino.Text;
      conexaoDestino.Params.UserName:=edtLogin.Text;
      conexaoDestino.Params.Password:=edtSenha.Text;
      conexaoDestino.Params.Values['Server']:=edtServer.Text;
      conexaoDestino.Params.Values['Port']:=edtPorta.Text;
      conexaoDestino.Open();

      conexaoDestino.ExecSQL('execute procedure pr_logar(''ADMIN'');');
    end;
  except
    on E:Exception do
      raise Exception.Create('[ConectarBancos]'+#13+E.Message);
  end;

end;

procedure TfrmGiga2Giga.ConectarOrigem;
begin
  try
    with DM do
    begin
      conexaoOrigem.Close;
      conexaoOrigem.Params.Database:=edtOrigem.Text;
      conexaoOrigem.Params.UserName:=edtLogin.Text;
      conexaoOrigem.Params.Password:=edtSenha.Text;
      conexaoOrigem.Params.Values['Server']:=edtServer.Text;
      conexaoOrigem.Params.Values['Port']:=edtPorta.Text;
      conexaoOrigem.Open();
    end;
  except
    on E:Exception do
      raise Exception.Create('[ConectarOrigem]'+#13+E.Message);
  end;
end;

procedure TfrmGiga2Giga.edtDestinoRightButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtDestino.Text := OpenDialog1.FileName;
    fdmtParametros.Edit;
    fdmtParametrosDESTINO.AsString:=OpenDialog1.FileName;
    fdmtParametros.Post;
    ConectarDestino;
    VerificaVersao;
  end;
end;

procedure TfrmGiga2Giga.edtOrigemRightButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtOrigem.Text := OpenDialog1.FileName;
    fdmtParametros.Edit;
    fdmtParametrosORIGEM.AsString:=OpenDialog1.FileName;
    fdmtParametros.Post;
    ConectarOrigem;
    ListaTabela;
  end;
end;

procedure TfrmGiga2Giga.FechaConexoes;
begin
  DM.conexaoOrigem.Close;
  DM.conexaoDestino.Close;
end;

procedure TfrmGiga2Giga.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaConexoes;
  GravaDados;
end;

procedure TfrmGiga2Giga.FormCreate(Sender: TObject);
begin
  VerificaFREE;
  fdmtParametros.Active := True;
  cbEditar.Hint:='Se marcado a aplicação irá editar' +#13+
                 'os registros encontrados no destino.' +#13+
                 'Caso não estiver marcado, os registros ' +#13+
                 'encontrados serão pulados.';
  cboxTabela.Hint:='Selecione o nome da tabela a ser importada.';
  Caption := 'Importa GigaERP para GigaERP Versão: '+VersaoEXE();
end;

procedure TfrmGiga2Giga.FormShow(Sender: TObject);
begin
  LerDados;
  LimpaTela;
end;

procedure TfrmGiga2Giga.GeraLog(Msg: String; Erro: Boolean);
begin
  try
    Msg:=FormatDateTime('hh:mm:ss| ',now)+Msg;
    if Erro then
    Msg:='**************** ERRO INICIO **************' +#13+
          Msg +#13+
         '**************** ERRO FIM *****************';
    memoLog.Lines.Add(Msg);
    Application.ProcessMessages;
  except

  end;
end;

procedure TfrmGiga2Giga.GravaDados;
begin
  fdmtParametros.SaveToFile(ExtractFilePath(Application.ExeName)+'Config.XML');
end;

procedure TfrmGiga2Giga.IMPORTA_CLIENTES;
var
  CONDICAO: String;
begin
  try

    GeraLog('Iniciando a importação dos Clientes');
    gaugTotal.Progress:=0;
    gaugTotal.MaxValue:=14;
    CONDICAO:='TAB WHERE EXISTS(SELECT 1 FROM PESSOAS P ' +
              'WHERE P.COD_PESSOA = TAB.COD_PESSOA ' +
              'AND P.FLAG_CLIENTE = 1)';
    {TABELAS QUE COMPÔEM OS CLIENTES}
    IMPORTA_DADOS('PESSOAS','WHERE FLAG_CLIENTE = 1');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_CNAE',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_CONTATOS',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_ENDERECOS',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('CLIENTES');
    gaugTotal.AddProgress(1);
  except
    on E:Exception do
      raise Exception.Create('[IMPORTA_CLIENTES]'+#13+E.Message);
  end;

end;

procedure TfrmGiga2Giga.IMPORTA_DADOS(TABELA: String; CONDICAO: String='');
var
  I, II: Integer;
  Locate: Boolean;
  Qtd, qtdPK: Integer;
  CAMPOS: String;
begin
  try
    with DM do
    begin
      GeraLog('');
      GeraLog('Iniciando importação de '+TABELA);
      RecuperaPK(TABELA,qtdPK,CAMPOS);
      QR_Origem.Close;
      QR_Destino.Close;
      QR_Origem.Open('SELECT * FROM '+TABELA+' '+CONDICAO);
      QR_Destino.Open('SELECT * FROM '+TABELA);
      QR_Origem.Last;
      gaugTabela.Progress:=0;
      gaugTabela.MaxValue:=QR_Origem.RecordCount+10;
      Qtd:=QR_Origem.RecordCount;
      II:=0;
      GeraLog('Importando '+TABELA);
      QR_Origem.First;
      Application.ProcessMessages;

      if QR_Origem.FieldList.Count <> QR_Destino.FieldList.Count then
        raise Exception.Create('A quantidade e colunas da tabela '+TABELA+#13+
                               'nos dois bancos são diferentes.'+#13+
                               'Verifique isso e tente novamente.');

      while not QR_Origem.Eof do
      begin
        gaugTabela.AddProgress(1);
        Inc(II);
        Application.ProcessMessages;
        labContagem.Caption:=IntToStr(II)+'/'+IntToStr(Qtd);
        case QtdPK of
            1:
            begin
              Locate:= QR_Destino.Locate(CAMPOS,QR_Origem.Fields.Fields[0].AsString,[]);
             end;
            2:
            begin
              Locate:= QR_Destino.Locate(CAMPOS,vararrayof([QR_Origem.Fields.Fields[0].AsString,QR_Origem.Fields.Fields[1].AsString]),[]);
            end;
            3:
            begin
              Locate:= QR_Destino.Locate(CAMPOS,vararrayof([QR_Origem.Fields.Fields[0].AsString,QR_Origem.Fields.Fields[1].AsString,QR_Origem.Fields.Fields[2].AsString]),[]);
            end;
            4: begin
              Locate:= QR_Destino.Locate(CAMPOS,vararrayof([QR_Origem.Fields.Fields[0].AsString,QR_Origem.Fields.Fields[1].AsString,QR_Origem.Fields.Fields[2].AsString,QR_Origem.Fields.Fields[3].AsString]),[]);
              if not Locate then
              GeraLog(TABELA+': '+CAMPOS+' vALORES: '+QR_Origem.Fields.Fields[0].AsString+','+QR_Origem.Fields.Fields[1].AsString+','+QR_Origem.Fields.Fields[2].AsString+','+QR_Origem.Fields.Fields[3].AsString);
            end;
          end;

          if Locate and not cbEditar.Checked then
          begin
            QR_Origem.Next;
            Continue;
          end;

          if Locate then
            QR_Destino.Edit
          else
            QR_Destino.Append;

        for I := 0 to QR_Origem.FieldList.Count-1 do
          QR_Destino.Fields.Fields[I].Value:=QR_Origem.Fields.Fields[I].Value;

        QR_Destino.Post;
        QR_Origem.Next;
      end;
      GeraLog('Concluindo '+TABELA);
      QR_Destino.ApplyUpdates();

      gaugTabela.Progress:=gaugTabela.MaxValue;
      GeraLog(TABELA+' Concluido');
    end;
  except
    on E:Exception do
      raise Exception.Create('[IMPORTA_DADOS]['+TABELA+']'+#13+E.Message);
  end;
end;

procedure TfrmGiga2Giga.IMPORTA_FORNECEDORES;
var
  CONDICAO: String;
begin
  try
    GeraLog('Iniciando a importação dos Fornecedores');
    gaugTotal.Progress:=0;
    gaugTotal.MaxValue:=14;
    CONDICAO:='TAB WHERE EXISTS(SELECT 1 FROM PESSOAS P ' +
              'WHERE P.COD_PESSOA = TAB.COD_PESSOA ' +
              'AND P.FLAG_FORNECEDOR = 1)';
    {TABELAS QUE COMPÔEM OS CLIENTES}
    IMPORTA_DADOS('PESSOAS','WHERE FLAG_FORNECEDOR = 1');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_CNAE',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_CONTATOS',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_ENDERECOS',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('FORNECEDORES');
    gaugTotal.AddProgress(1);
  except
    on E:Exception do
      raise Exception.Create('[IMPORTA_FORNECEDORES]'+#13+E.Message);
  end;
end;

procedure TfrmGiga2Giga.LerDados;
var
  arq: string;
begin
  arq:=ExtractFilePath(Application.ExeName)+'Config.XML';
  if FileExists(arq) then
    fdmtParametros.LoadFromFile(arq)
  else
    ValoresPadroes;
  if edtOrigem.Text<>'' then
  begin
    ConectarOrigem;
    ListaTabela;
  end;
  if edtDestino.Text<>'' then
  begin
    ConectarDestino;
    VerificaVersao;
  end;
end;

procedure TfrmGiga2Giga.LimpaTela;
begin
  labContagem.Caption:='';
  gaugTabela.Progress:=0;
  gaugTotal.Progress:=0;
end;

procedure TfrmGiga2Giga.ListaTabela;
begin
  with DM do
  begin
    QR_Tabelas.Close;
    QR_Tabelas.Open();
    QR_Tabelas.First;
    while not QR_Tabelas.Eof do
    begin
      cboxTabela.Items.Add(QR_TabelasTABELA.AsString);
      QR_Tabelas.Next;
    end;
  end;
end;

procedure TfrmGiga2Giga.RecuperaPK(TABELA: String; var qtdPK: Integer;
  var CAMPOS: String);
begin
  try
    with DM do
    begin
      QR_PK.Close;
      QR_PK.ParamByName('TABELA').AsString:=TABELA;
      QR_PK.Open();
      QR_PK.Last;
      qtdPK:=QR_PK.RecordCount;
      QR_PK.First;
      CAMPOS:='';
      while not QR_PK.Eof do
      begin
        CAMPOS:=CAMPOS+';'+QR_PK.FieldByName('CAMPO').AsString;
        QR_PK.Next;
      end;
      CAMPOS:=Copy(CAMPOS, 2, Length(CAMPOS));
    end;
  except
    on E:Exception do
      raise Exception.Create('[RecuperaPK]'+#13+E.Message);
  end;
end;

procedure TfrmGiga2Giga.IMPORTA_PRODUTOS;
begin
  try
    GeraLog('Iniciando a importação dos produtos');
    gaugTotal.Progress:=0;
    gaugTotal.MaxValue:=14;

    {TABELAS QUE PRODUTOS DEPENDE}
    IMPORTA_DADOS('GRUPOS_PRODUTO');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('IMPOSTOS','COD_IMPOSTO');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_APELIDOS');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_TAB_PRECOS');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('UNIDADES_MEDIDA');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('COMANDAS_SETORES');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('DESCRICOES_ADICIONAIS');

    {TABELAS QUE COMPÕEM OS PRODUTOS}
    IMPORTA_DADOS('PRODUTOS');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_GRADE');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_APELIDOS_PROD');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_CUSTO');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_GRADE_UND');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_TAB_PRECOS_PROD');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PRODUTOS_DESC_ADICIONAIS');
    gaugTotal.AddProgress(1);

  except
    on E:Exception do
      raise Exception.Create('[IMPORTA_PRODUTOS]'+#13+E.Message);
  end;
end;

procedure TfrmGiga2Giga.IMPORTA_VENDEDORES;
var
  CONDICAO: String;
begin
  try
    GeraLog('Iniciando a importação dos Vendedores\Garçons');
    gaugTotal.Progress:=0;
    gaugTotal.MaxValue:=14;
    CONDICAO:='TAB WHERE EXISTS(SELECT 1 FROM PESSOAS P ' +
              'WHERE P.COD_PESSOA = TAB.COD_PESSOA ' +
              'AND P.FLAG_VENDEDOR = 1)';
    {TABELAS QUE COMPÔEM OS CLIENTES}
    IMPORTA_DADOS('PESSOAS','WHERE FLAG_VENDEDOR = 1');
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_CNAE',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_CONTATOS',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('PESSOAS_ENDERECOS',CONDICAO);
    gaugTotal.AddProgress(1);
    IMPORTA_DADOS('VENDEDORES');
    gaugTotal.AddProgress(1);
  except
    on E:Exception do
      raise Exception.Create('[IMPORTA_FORNECEDORES]'+#13+E.Message);
  end;
end;

procedure TfrmGiga2Giga.ValoresPadroes;
begin
    fdmtParametros.Edit;
    fdmtParametrosSERVER.AsString:='LocalHost';
    fdmtParametrosPORTA.AsString:='3060';
    fdmtParametrosLOGIN.AsString:='SYSDBA';
    fdmtParametrosSENHA.AsString:='lib1503';
    fdmtParametros.Post;
end;

procedure TfrmGiga2Giga.VerificaVersao;
var
  VersaoOrigem, VersaoDestino: String;
begin
  try
    with DM do
    begin
      QR_Origem.Open('SELECT VERSAO_BASE FROM PARAMETROS_GERAL');
      QR_Destino.Open('SELECT VERSAO_BASE FROM PARAMETROS_GERAL');
      VersaoOrigem:=QR_Origem.FieldByName('VERSAO_BASE').AsString;
      VersaoDestino:=QR_Destino.FieldByName('VERSAO_BASE').AsString;
      labVersaoOrigem.Caption:=VersaoOrigem;
      labVersaoDestino.Caption:=VersaoDestino;
      butImporta.Enabled:=(VersaoOrigem=VersaoDestino);
      if VersaoOrigem<>VersaoDestino then
        raise Exception.Create('Versões dos bancos de dados incompativeis'+#13+
                               'Base Origem: '+VersaoOrigem+#13+
                               'Base Destino: '+VersaoDestino)
    end;
  except
    on E:Exception do
    begin
      raise Exception.Create('[Error Message]'+#13+E.Message);
      butImporta.Enabled:=False;
    end;
  end;
end;

end.
