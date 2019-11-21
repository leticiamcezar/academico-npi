unit UnitUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DB, ADODB;

type
  TFormUsuarios = class(TForm)
    BotaoNovo: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    Label1: TLabel;
    EditUsuario: TEdit;
    Label2: TLabel;
    EditNome: TEdit;
    Label3: TLabel;
    EditSenha: TEdit;
    ADOQueryAux: TADOQuery;
    BotaoLocalizar: TSpeedButton;
    BotaoPermissoes: TSpeedButton;
    procedure BotaoNovoClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BotaoLocalizarClick(Sender: TObject);
    procedure BotaoPermissoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    operacao, pk: String;
    procedure desabilita_salvar(Sender: TObject);
    procedure habilita_salvar(Sender: TObject);
    procedure bloqueia_campos;
    procedure libera_campos;
    procedure limpa_campos;
  end;

var
  FormUsuarios: TFormUsuarios;

implementation

uses UnitLogon, UnitPesquisa, UnitPermissoes, UnitMenu, UnitSplash;

{$R *.dfm}

{ TFormUsuarios }

procedure TFormUsuarios.bloqueia_campos;
var i : integer;
begin
  for i := 1 to FormUsuarios.ComponentCount -1 do
  begin
    if FormUsuarios.Components[i] is TEdit then
    begin
      (FormUsuarios.Components[i] as TEdit).Enabled := False;
      (FormUsuarios.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TFormUsuarios.desabilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := True;
  BotaoSalvar.Enabled := False;
  BotaoAlterar.Enabled := True;
  BotaoCancelar.Enabled := False;
  BotaoExcluir.Enabled := True;

  if Sender = BotaoNovo then
    operacao := 'novo'
  else if Sender = BotaoSalvar then
    operacao := 'salvar'
  else if Sender = BotaoAlterar then
    operacao := 'alterar'
  else if Sender = BotaoCancelar then
    operacao := 'cancelar'
  else if Sender = BotaoExcluir then
    operacao := 'excluir';
end;

procedure TFormUsuarios.habilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := False;
  BotaoSalvar.Enabled := True;
  BotaoAlterar.Enabled := False;
  BotaoCancelar.Enabled := True;
  BotaoExcluir.Enabled := False;

  if Sender = BotaoNovo then
    operacao := 'novo'
  else if Sender = BotaoSalvar then
    operacao := 'salvar'
  else if Sender = BotaoAlterar then
    operacao := 'alterar'
  else if Sender = BotaoCancelar then
    operacao := 'cancelar'
  else if Sender = BotaoExcluir then
    operacao := 'excluir';
end;

procedure TFormUsuarios.libera_campos;
var i : integer;
begin
  for i := 1 to FormUsuarios.ComponentCount -1 do
  begin
    if FormUsuarios.Components[i] is TEdit then
    begin
      (FormUsuarios.Components[i] as TEdit).Enabled := True;
      (FormUsuarios.Components[i] as TEdit).Color := clWindow;
    end;
  end;
end;

procedure TFormUsuarios.limpa_campos;
var i : integer;
begin
  for i := 1 to FormUsuarios.ComponentCount -1 do
  begin
    if FormUsuarios.Components[i] is TEdit then
    begin
      (FormUsuarios.Components[i] as TEdit).Clear;
    end;
  end;
end;

procedure TFormUsuarios.BotaoNovoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  habilita_salvar(Sender);
end;

procedure TFormUsuarios.BotaoSalvarClick(Sender: TObject);
var
  deu_erro : boolean;
  senha : String;
begin
  if (EditUsuario.Text = '') or (EditNome.Text = '') or (EditSenha.Text = '') then
   begin
    ShowMessage('Preencha todos os campos!');
   end
  else
   begin
    senha := FormLogon.criptografa(EditSenha.Text);

    if operacao = 'novo' then
      ADOQueryAux.SQL.Text := 'INSERT INTO USUARIOS VALUES '+
                              '('+ QuotedStr(EditUsuario.Text) +
                              ','+ QuotedStr(EditNome.Text) +
                              ','+ QuotedStr(senha) + ')'
    else if operacao = 'alterar' then
      ADOQueryAux.SQL.Text := 'UPDATE USUARIOS SET '+
                              '  USUARIO = ' + QuotedStr(EditUsuario.Text) +
                              ', NOME = ' + QuotedStr(EditNome.Text) +
                              ', SENHA' + QuotedStr(senha) +
                              ' WHERE USUARIO = '+ QuotedStr(pk);

    FormLogon.ConexaoBD.BeginTrans;
    try
      ADOQueryAux.ExecSQL;
      deu_erro := False;
    except
      on E : Exception do
      begin
        deu_erro := True;
        if FormLogon.ErroBD(E.Message,'PK_Usuario') = 'Sim' then
          ShowMessage('Usuário não cadastrado!')
        else if FormLogon.ErroBD(E.Message,'FK_Permissoes_Usuario') = 'Sim' then
          ShowMessage('Existem permissões cadastradas para este usuário!')
        else
          ShowMessage('Ocorreu um erros:' + E.Message);
      end;
    end;

    if deu_erro = true then
      begin
        FormLogon.ConexaoBD.RollbackTrans;
      end
    else
      begin
        FormLogon.ConexaoBD.CommitTrans;
        pk := EditUsuario.Text;
        desabilita_salvar(Sender);
        bloqueia_campos;
      end;
    end; 
end;

procedure TFormUsuarios.BotaoAlterarClick(Sender: TObject);
begin
  if pk = '' then
    ShowMessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(Sender);
  end;
end;

procedure TFormUsuarios.BotaoCancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    libera_campos;

  desabilita_salvar(Sender);
  bloqueia_campos;
end;

procedure TFormUsuarios.BotaoExcluirClick(Sender: TObject);
var deu_erro : boolean;
begin
  if pk = '' then
    ShowMessage('Impossível excluir!')
  else
    begin
      ADOQueryAux.SQL.Text := ' DELETE FROM USUARIOS ' +
                              ' WHERE USUARIO = ' + QuotedStr(pk);
      FormLogon.ConexaoBD.BeginTrans;

      try
        ADOQueryAux.ExecSQL;
        deu_erro := false;
      except
        on E : Exception do
        begin
          deu_erro := True;
          if FormLogon.ErroBD(E.Message,'FK_Permissoes_Usuario') = 'Sim' then
            ShowMessage('Existem permissões cadastradas para este usuário!')
          else
            ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
        end;
      end;

      if deu_erro = True then
        begin
          FormLogon.ConexaoBD.RollbackTrans;
        end
        else
          begin
            FormLogon.ConexaoBD.CommitTrans;
            pk := '';
            desabilita_salvar(Sender);
            libera_campos;
            bloqueia_campos;
          end;
        end;
end;

procedure TFormUsuarios.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormUsuarios.FormShow(Sender: TObject);
begin
  pk := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);
end;

procedure TFormUsuarios.BotaoLocalizarClick(Sender: TObject);
var
  senha : String;
begin
 libera_campos;
 bloqueia_campos;
 desabilita_salvar(Sender);

 FormPesquisa.sql_pesquisa := 'SELECT USUARIO, NOME FROM USUARIOS ';
 FormPesquisa.ShowModal;
 if FormPesquisa.chave <> '' then
 begin
  pk := FormPesquisa.chave;
  ADOQueryAux.SQL.Text := ' SELECT * FROM USUARIOS '+
                          ' WHERE USUARIO = ' + QuotedStr(pk);
  ADOQueryAux.Open;
  EditUsuario.Text := ADOQueryAux.fieldbyname('USUARIO').AsString;
  EditNome.Text := ADOQueryAux.fieldbyname('NOME').AsString;
  senha := ADOQueryAux.fieldbyname('SENHA').AsString;
  EditSenha.Text := FormLogon.descriptografa(senha);
 end;
end;

procedure TFormUsuarios.BotaoPermissoesClick(Sender: TObject);
begin
  if pk = '' then
    ShowMessage('Usuário inválido!')
  else
  begin
    bloqueia_campos;
    desabilita_salvar(Sender);
    FormPermissoes.usuario := pk;
    FormPermissoes.ShowModal;
  end;
end;

end.
