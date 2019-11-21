unit UnitCursos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DB, ADODB;

type
  TFormCursos = class(TForm)
    BotaoNovo: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    EditCod: TEdit;
    EditNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ADOQueryAux: TADOQuery;
    BotaoLocalizar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure BotaoNovoClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
    procedure BotaoLocalizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    operacao, pk : String;
    procedure desabilita_salvar(Sender: TObject);
    procedure habilita_salvar(Sender: TObject);
    procedure bloqueia_campos;
    procedure libera_campos;
    procedure limpa_campos;
  end;

var
  FormCursos: TFormCursos;

implementation

uses UnitLogon, UnitPesquisa;

{$R *.dfm}

{ TFormCursos }

procedure TFormCursos.bloqueia_campos;
 var
i : integer;
begin
  for i := 1 to FormCursos.ComponentCount -1 do
  begin
    if FormCursos.Components[i] is TEdit then
    begin
      (FormCursos.Components[i] as TEdit).Enabled := False;
      (FormCursos.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TFormCursos.desabilita_salvar(Sender: TObject);
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
  else if Sender =BotaoSalvar then
    operacao := 'alterar'
  else if Sender = BotaoCancelar then
    operacao := 'cancelar'
  else if Sender = BotaoExcluir then
    operacao := 'excluir';
end;

procedure TFormCursos.habilita_salvar(Sender: TObject);
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
  else if Sender =BotaoSalvar then
    operacao := 'alterar'
  else if Sender = BotaoCancelar then
    operacao := 'cancelar'
  else if Sender = BotaoExcluir then
    operacao := 'excluir';

end;

procedure TFormCursos.libera_campos;
  var
i : integer;
begin
  for i := 1 to FormCursos.ComponentCount -1 do
  begin
    if FormCursos.Components[i] is TEdit then
    begin
      (FormCursos.Components[i] as TEdit).Enabled := True;
      (FormCursos.Components[i] as TEdit).Color := clWindow;
    end;
  end;
end;

procedure TFormCursos.limpa_campos;
  var
i : integer;
begin
  for i := 1 to FormCursos.ComponentCount -1 do
  begin
    if FormCursos.Components[i] is TEdit then
    begin
      (FormCursos.Components[i] as TEdit).Clear;
    end;
  end;
end;

procedure TFormCursos.FormShow(Sender: TObject);
begin
  pk := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);
end;

procedure TFormCursos.BotaoNovoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  habilita_salvar(Sender);
end;

procedure TFormCursos.BotaoSalvarClick(Sender: TObject);
  var
deu_erro : boolean;
begin
  if(EditCod.Text='') or (EditNome.Text='') then
    begin
      ShowMessage('Preencha todos os campos!');
    end
  else
    begin
      if operacao = 'novo' then
        ADOQueryAux.SQL.Text := 'INSERT INTO CURSOS VALUES' +
                                '('+ QuotedStr(EditCod.Text) +
                                ','+ QuotedStr(EditNome.Text) + ')'
      else if operacao = 'alterar' then
        ADOQueryAux.SQL.Text := 'UPDATE CURSOS SET'+
                                '  COD_CURSO ='+ QuotedStr(EditCod.Text) +
                                ', NOME =' + QuotedStr(EditNome.Text) +
                                ' WHERE COD_CURSO = '+ QuotedStr(pk);
      FormLogon.ConexaoBD.BeginTrans;
      try
        ADOQueryAux.ExecSQL;
        deu_erro := False;
      except
        on E : Exception do
        begin
          deu_erro := True;
          if FormLogon.ErroBD(E.Message,'PK_Cursos') = 'Sim' then
            ShowMessage('Curso já cadastrado!')
          else if FormLogon.ErroBD(E.Message,'FK_Turmas_Cursos') = 'Sim' then
            ShowMessage('Existem turmas cadastradas para este curso!')
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
      pk := EditCod.Text;
      desabilita_salvar(Sender);
      bloqueia_campos;
      end;
  end;
end;


procedure TFormCursos.BotaoAlterarClick(Sender: TObject);
begin
  if pk = '' then
    ShowMessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(Sender);
  end;
end;

procedure TFormCursos.BotaoCancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    limpa_campos;
    desabilita_salvar(Sender);
    bloqueia_campos;
end;

procedure TFormCursos.BotaoExcluirClick(Sender: TObject);
  var
deu_erro : boolean;
begin
  if pk = '' then
    ShowMessage('Impossível excluir!')
  else
    begin
      ADOQueryAux.SQL.Text := ' DELETE FROM CURSOS ' +
                              ' WHERE COD_CURSO = ' + QuotedStr(pk);
      FormLogon.ConexaoBD.BeginTrans;

      try
        ADOQueryAux.ExecSQL;
        deu_erro := False;
      except
        on E : Exception do
        begin
          deu_erro := True;
          if FormLogon.ErroBD(E.Message,'FK_Turmas_Cursos') = 'Sim' then
            ShowMessage('Existem turmas cadastradas para este curso!')
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
          limpa_campos;
          bloqueia_campos;
        end;
    end;
end;

procedure TFormCursos.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCursos.BotaoLocalizarClick(Sender: TObject);
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);

  FormPesquisa.sql_pesquisa := 'SELECT COD_CURSO, NOME FROM CURSOS';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    pk := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := ' SELECT * FROM CURSOS '+
                            ' WHERE COD_CURSO = ' + QuotedStr(pk);
    ADOQueryAux.Open;
    EditCod.Text := ADOQueryAux.fieldbyname('COD_CURSO').AsString;
    EditCod.Text := ADOQueryAux.fieldbyname('NOME').AsString;
  end;
end;

end.
