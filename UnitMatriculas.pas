unit UnitMatriculas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DB, ADODB;

type
  TFormMatriculas = class(TForm)
    BotaoNovo: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    Label1: TLabel;
    EditAluno: TEdit;
    Label2: TLabel;
    EditTurma: TEdit;
    ADOQueryAux: TADOQuery;
    BotaoLocalizar: TSpeedButton;
    Label3: TLabel;
    BotaoTurma: TBitBtn;
    BotaoAluno: TBitBtn;
    procedure BotaoAlunoClick(Sender: TObject);
    procedure BotaoTurmaClick(Sender: TObject);
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
    pk_aluno, pk_turma, operacao, cod_aluno, cod_turma : String;
    procedure desabilita_salvar(Sender: TObject);
    procedure habilita_salvar(Sender: TObject);
    procedure bloqueia_campos;
    procedure libera_campos;
    procedure limpa_campos;
  end;

var
  FormMatriculas: TFormMatriculas;

implementation

uses UnitLogon, UnitPesquisa, UnitPesquisaTurmas;

{$R *.dfm}

{ TFormMatriculas }

procedure TFormMatriculas.bloqueia_campos;
var i : integer;
begin
  for i := 1 to FormMatriculas.ComponentCount -1 do
  begin
    if FormMatriculas.Components[i] is TEdit then
    begin
      (FormMatriculas.Components[i] as TEdit).Enabled := False;
      (FormMatriculas.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TFormMatriculas.desabilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := True;
  BotaoSalvar.Enabled := False;
  BotaoAlterar.Enabled := True;
  BotaoCancelar.Enabled := False;
  BotaoFechar.Enabled := True;

  BotaoAluno.Enabled := False;
  BotaoTurma.Enabled := False;

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

procedure TFormMatriculas.habilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := False;
  BotaoSalvar.Enabled := True;
  BotaoAlterar.Enabled := False;
  BotaoCancelar.Enabled := True;
  BotaoFechar.Enabled := False;

  BotaoAluno.Enabled := True;
  BotaoTurma.Enabled := True;

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

procedure TFormMatriculas.libera_campos;
var i : integer;
    nome_obj : String;
begin
  for i := 1 to FormMatriculas.ComponentCount -1 do
  begin
    if FormMatriculas.Components[i] is TEdit then
    begin
      nome_obj := (FormMatriculas.Components[i] as TEdit).Name;
      if (nome_obj <> 'EditAluno') and (nome_obj <> 'EditTurma') then
      begin
        (FormMatriculas.Components[i] as TEdit).Enabled := True;
        (FormMatriculas.Components[i] as TEdit).Color := clWindow;
      end;
    end;
  end;
end;

procedure TFormMatriculas.limpa_campos;
var i : integer;
begin
  for i := 1 to FormMatriculas.ComponentCount -1 do
  begin
    if FormMatriculas.Components[i] is TEdit then
        (FormMatriculas.Components[i] as TEdit).Clear;
  end;
end;

procedure TFormMatriculas.BotaoAlunoClick(Sender: TObject);
begin
  EditAluno.Clear;
  FormPesquisa.sql_pesquisa := 'SELECT * FROM ALUNOS  ';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    cod_aluno := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := '  SELECT NOME FROM ALUNOS  ' +
                            '  WHERE COD_ALUNO = ' + cod_aluno;
    ADOQueryAux.Open;
    EditAluno.Text := ADOQueryAux.fieldbyname('NOME').AsString;
  end;
end;

procedure TFormMatriculas.BotaoTurmaClick(Sender: TObject);
begin
  EditTurma.Clear;
  FormPesquisaTurmas.ShowModal;

  if FormPesquisaTurmas.chave <> '' then
  begin
    cod_turma := FormPesquisaTurmas.chave;
    EditTurma.Text := cod_turma;
  end;
end;

procedure TFormMatriculas.FormShow(Sender: TObject);
begin
  pk_aluno := '';
  pk_turma := '';
  cod_aluno := '';
  cod_turma := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);
end;

procedure TFormMatriculas.BotaoNovoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk_aluno := '';
  pk_turma := '';
  cod_aluno := '';
  cod_turma := '';
  habilita_salvar(Sender);
end;

procedure TFormMatriculas.BotaoSalvarClick(Sender: TObject);
var deu_erro : boolean;
begin
  if (cod_aluno='') or (EditTurma.Text='') then
    begin
      ShowMessage('Informe todos os campos!');
    end
  else
    begin
      if operacao = 'novo' then
        ADOQueryAux.SQL.Text := ' INSERT INTO Matricula VALUES ' +
                                '('+ QuotedStr(cod_turma) +
                                ','+ cod_aluno + ')'

      else if operacao = 'alterar' then
        ADOQueryAux.SQL.Text := 'UPDATE Matricula SET  '+
                                '   COD_TURMA = '+ QuotedStr(cod_turma) +
                                '  ,COD_ALUNO = '+ cod_aluno +
                                '  WHERE COD_TURMA = '+ QuotedStr(pk_turma) +
                                '  AND COD_ALUNO = ' + pk_aluno;
      FormLogon.ConexaoBD.BeginTrans;
      try
        ADOQueryAux.ExecSQL;
        deu_erro := false;
      except
        on E : Exception do
        begin
          deu_erro := true;
          if FormLogon.ErroBD(E.Message,'PK_Matricula') = 'Sim' then
            ShowMessage('Matrícula já cadastrada!')
          else if FormLogon.ErroBD(E.Message,'FK_Frequencias_Matriculas') = 'Sim' then
            ShowMessage('Existem frequências lançadas para esta matrícula!')
          else
            ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
        end;
      end;

      if deu_erro = true then
        begin
          FormLogon.ConexaoBD.RollbackTrans;
        end
      else
        begin
          FormLogon.ConexaoBD.CommitTrans;
          pk_turma := cod_turma;
          pk_aluno := cod_aluno;
          desabilita_salvar(Sender);
          bloqueia_campos;
        end;
    end;
end;

procedure TFormMatriculas.BotaoAlterarClick(Sender: TObject);
begin
  if (pk_turma = '') or (pk_aluno = '') then
    ShowMessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(Sender);
  end;
end;

procedure TFormMatriculas.BotaoCancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    limpa_campos;
    desabilita_salvar(Sender);
    bloqueia_campos;
end;

procedure TFormMatriculas.BotaoExcluirClick(Sender: TObject);
var deu_erro : boolean;
begin
  if (pk_turma = '') or (pk_aluno = '') then
    ShowMessage('Impossível excluir!')
  else
    begin
      ADOQueryAux.SQL.Text := '  DELETE FROM Matricula ' +
                              '  WHERE COD_TURMA =  '+ QuotedStr(pk_turma) +
                              '  AND COD_ALUNO = ' + cod_aluno;
      FormLogon.ConexaoBD.BeginTrans;

      try
          ADOQueryAux.ExecSQL;
          deu_erro := false;
      except
          on E : Exception do
          begin
            deu_erro := true;
            if FormLogon.ErroBD(E.Message,'FK_Frequencias_Matriculas') = 'Sim' then
               ShowMessage('Existem frequências lançadas para esta matrícula!')
            else
               ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
          end;
      end;

      if  deu_erro = true then
        begin
          FormLogon.ConexaoBD.RollbackTrans;
        end
      else
        begin
          FormLogon.ConexaoBD.CommitTrans;
          pk_turma := '';
          pk_aluno := '';
          cod_turma := '';
          cod_aluno := '';
          desabilita_salvar(Sender);
          limpa_campos;
          bloqueia_campos;
        end;
    end;
end;

procedure TFormMatriculas.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMatriculas.BotaoLocalizarClick(Sender: TObject);
var sql : String;
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);

  sql := '  SELECT MATRICULA.COD_TURMA,  ' +
         '         MATRICULA.COD_ALUNO,  ' +
         '         ALUNOS.NOME  ' +
         '  FROM MATRICULA     ' +
         '  INNER JOIN ALUNOS   ' +
         '  ON MATRICULA.COD_ALUNO = ALUNOS.COD_ALUNO  ';

  FormPesquisa.sql_pesquisa := sql;
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    pk_turma := FormPesquisa.chave;
    pk_aluno := FormPesquisa.chave_aux;
    ADOQueryAux.SQL.Text := sql +
                            '  WHERE COD_TURMA = ' + QuotedStr(pk_turma) +
                            '  AND MATRICULA.COD_ALUNO = ' + pk_aluno;
    ADOQueryAux.Open;
    EditAluno.Text := ADOQueryAux.fieldbyname('NOME').AsString;
    EditTurma.Text := pk_turma;
    cod_turma := pk_turma;
    cod_aluno := pk_aluno;
  end;
end;

end.
