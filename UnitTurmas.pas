unit UnitTurmas;

interface
                                                                     
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, StdCtrls;

type
  TFormTurmas = class(TForm)
    BotaoNovo: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    ADOQueryAux: TADOQuery;
    EditCod: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditValor: TEdit;
    EditCurso: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditInstrutor: TEdit;
    BotaoLocalizar: TSpeedButton;
    BotaoCurso: TBitBtn;
    BotaoInstrutor: TBitBtn;
    procedure BotaoCursoClick(Sender: TObject);
    procedure BotaoInstrutorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BotaoNovoClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
    procedure EditValorEnter(Sender: TObject);
    procedure EditValorExit(Sender: TObject);
    procedure BotaoLocalizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    operacao, pk, cod_curso, cod_instrutor : String;
    procedure desabilita_salvar(Sender: TObject);
    procedure habilita_salvar(Sender: TObject);
    procedure bloqueia_campos;
    procedure libera_campos;
    procedure limpa_campos;
    function  formata_valor(valor, destino : String) : String;
  end;

var
  FormTurmas: TFormTurmas;

implementation

uses UnitLogon, UnitPesquisa, UnitPesquisaTurmas, UnitMenu;

{$R *.dfm}

{ TFormTurmas }

procedure TFormTurmas.bloqueia_campos;
var i : integer;
begin
  for i := 1 to FormTurmas.ComponentCount -1 do
  begin
    if FormTurmas.Components[i] is TEdit then
    begin
      (FormTurmas.Components[i] as TEdit).Enabled := False;
      (FormTurmas.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TFormTurmas.desabilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := True;
  BotaoSalvar.Enabled := False;
  BotaoAlterar.Enabled := True;
  BotaoCancelar.Enabled := False;
  BotaoExcluir.Enabled := True;

  BotaoCurso.Enabled := False;
  BotaoInstrutor.Enabled := False;

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

procedure TFormTurmas.habilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := False;
  BotaoSalvar.Enabled := True;
  BotaoAlterar.Enabled := False;
  BotaoCancelar.Enabled := True;
  BotaoExcluir.Enabled := False;

  BotaoCurso.Enabled := True;
  BotaoInstrutor.Enabled := True;

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

procedure TFormTurmas.libera_campos;
var i : integer;
    nome_obj : String;
begin
  for i := 1 to FormTurmas.ComponentCount -1 do
  begin
    if FormTurmas.Components[i] is TEdit then
    begin
      nome_obj := (FormTurmas.Components[i] as TEdit).Name;
      if (nome_obj <> 'EditCurso') and (nome_obj <> 'EditInstrutor') then
      begin
        (FormTurmas.Components[i] as TEdit).Enabled := True;
        (FormTurmas.Components[i] as TEdit).Color := clWindow;
      end;
    end;
  end;
end;

procedure TFormTurmas.limpa_campos;
var i : integer;
begin
  for i := 1 to FormTurmas.ComponentCount -1 do
  begin
    if FormTurmas.Components[i] is TEdit then
    begin
      (FormTurmas.Components[i] as TEdit).Clear;
    end;
  end;
end;

procedure TFormTurmas.BotaoCursoClick(Sender: TObject);
begin
  EditCurso.Clear;
  FormPesquisa.sql_pesquisa := 'SELECT * FROM CURSOS ';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    cod_curso := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := ' SELECT NOME FROM CURSOS  '+
                            '   WHERE COD_CURSO = ' + QuotedStr(cod_curso);
    ADOQueryAux.Open;
    EditCurso.Text := ADOQueryAux.fieldbyname('NOME').AsString;
  end;
end;

procedure TFormTurmas.BotaoInstrutorClick(Sender: TObject);
begin
  EditInstrutor.Clear;
  FormPesquisa.sql_pesquisa := ' SELECT * FROM INSTRUTORES  ';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    cod_instrutor := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := '  SELECT NOME FROM INSTRUTORES '+
                            '  WHERE COD_INSTRUTOR = ' + cod_instrutor;
    ADOQueryAux.Open;
    EditInstrutor.Text := ADOQueryAux.fieldbyname('NOME').AsString;
  end;
end;

procedure TFormTurmas.FormShow(Sender: TObject);
begin
  pk := '';
  cod_curso := '';
  cod_instrutor := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);
end;

procedure TFormTurmas.BotaoNovoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  cod_curso := '';
  cod_instrutor := '';
  habilita_salvar(Sender);
end;

procedure TFormTurmas.BotaoSalvarClick(Sender: TObject);
var deu_erro : boolean;
begin
  if (EditCod.Text='') or (EditValor.Text='') or
      (cod_curso='') or (cod_instrutor='') then
    begin
      ShowMessage('Preencha todos os campos!');
    end
  else
    begin
      if operacao = 'novo' then
        ADOQueryAux.SQL.Text := ' INSERT INTO TURMAS VALUES  ' +
                                '(' + QuotedStr(EditCod.Text)  +
                                ',' + QuotedStr(cod_curso) +
                                ',' + cod_instrutor +
                                ',' + formata_valor(EditValor.Text,'B') + ')'
      else if operacao = 'alterar' then
        ADOQueryAux.SQL.Text := 'UPDATE TURMAS SET  '+
                                '    COD_TURMA ='+ QuotedStr(EditCod.Text) +
                                ',   COD_CURSO ='+ QuotedStr(cod_curso) +
                                ',   COD_INSTRUTOR ='+ cod_instrutor +
                                ',   VALOR_AULA ='+ formata_valor(EditValor.Text,'B') +
                                '   WHERE COD_TURMA =' + QuotedStr(pk);
      FormLogon.ConexaoBD.BeginTrans;
      try
        ADOQueryAux.ExecSQL;
        deu_erro := False;
      except
        on E : Exception do
        begin
          deu_erro := True;
          if FormLogon.ErroBD(E.Message,'PK_Turmas') = 'Sim' then
            ShowMessage('Turma já cadastrada!')
          else if FormLogon.ErroBD(E.Message, 'FK_Turmas_Cursos') = 'Sim' then
            ShowMessage('Curso inválido!')
          else if FormLogon.ErroBD(E.Message, 'FK_Turmas_Instrutores') = 'Sim' then
            ShowMessage('Instrutor inválido!')
          else if FormLogon.ErroBD(E.Message, 'FK_Matricula_Turmas') = 'Sim' then
            ShowMessage('Existem alunos matriculados nesta turma!')
          else if FormLogon.ErroBD(E.Message, 'FK_Aulas_Turmas') = 'Sim' then
            ShowMessage('Existem alunos cadastrados para esta turma!')
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
          pk := EditCod.Text;
          desabilita_salvar(Sender);
          bloqueia_campos;
        end;
    end;
end;

procedure TFormTurmas.BotaoAlterarClick(Sender: TObject);
begin
  if pk = '' then
    ShowMessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(Sender);
  end;
end;

procedure TFormTurmas.BotaoCancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    limpa_campos;
    desabilita_salvar(Sender);
    bloqueia_campos;
end;

procedure TFormTurmas.BotaoExcluirClick(Sender: TObject);
var deu_erro : boolean;
begin
  if pk = '' then
    ShowMessage('Impossível excluir!')
  else
   begin
     ADOQueryAux.SQL.Text := ' DELETE FROM TURMAS  ' +
                             '   WHERE COD_TURMA = ' + QuotedStr(pk);
     FormLogon.ConexaoBD.BeginTrans;

     try
       ADOQueryAux.ExecSQL;
       deu_erro := False;
     except
       on E : Exception do
       begin
         deu_erro := True;
         if FormLogon.ErroBD(E.Message,'FK_Matricula_Turmas') = 'Sim' then
           ShowMessage('Existem alunos matriculados nesta turma!')
         else if FormLogon.ErroBD(E.Message,'FK_Aulas_Turmas') = 'Sim' then
           ShowMessage('Existem aulas cadastradas para esta turma1')
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
         pk := '';
         cod_curso := '';
         cod_instrutor := '';
         desabilita_salvar(Sender);
         limpa_campos;
         bloqueia_campos;
       end;
   end;
end;

procedure TFormTurmas.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

function TFormTurmas.formata_valor(valor, destino : String): String;
var
  valor_formatado : String;
  i : integer;
begin
  if (valor='') or (destino='') then
  begin
    result := '';
    exit;
  end;
  valor_formatado := valor;
  Delete(valor_formatado,pos('R',valor_formatado),1);
  Delete(valor_formatado,pos('$',valor_formatado),1);
  Delete(valor_formatado,pos('.',valor_formatado),1);

  valor_formatado := trim(valor_formatado);

  if destino = 'T' then
      Result := FormatCurr('R$ #, ##0.00',StrToInt(valor_formatado))
  else if destino = 'E' then
      Result := valor_formatado
  else if destino = 'B' then
    begin
      for i := 1 to Length(valor_formatado) do
      begin
        if valor_formatado[i] = ',' then
          valor_formatado[i] := ',';
      end;
      Result := valor_formatado;
    end;
end;

procedure TFormTurmas.EditValorEnter(Sender: TObject);
begin
  EditValor.Text := formata_valor(EditValor.Text,'E');
end;

procedure TFormTurmas.EditValorExit(Sender: TObject);
begin
  EditValor.Text := formata_valor(EditValor.Text,'T');
end;

procedure TFormTurmas.BotaoLocalizarClick(Sender: TObject);
var sql : String;
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);

  FormPesquisaTurmas.ShowModal;
  if FormPesquisaTurmas.chave <> '' then
  begin
    pk := FormPesquisaTurmas.chave;

    sql := 'SELECT TURMAS.COD_TURMA, TURMAS.VALOR_AULA,  ' +
           '    CURSOS.NOME AS CURSO, CURSOS.COD_CURSO,  ' +
           '    INSTRUTORES.NOME AS INSTRUTOR, INSTRUTORES.COD_INSTRUTOR  ' +
           'FROM TURMAS   ' +
           'INNER JOIN CURSOS  ' +
           ' ON TURMAS.COD_CURSO = CURSOS.COD_CURSO ' +
           'INNER JOIN INSTRUTORES '+
           '  ON TURMAS.COD_INSTRUTOR = INSTRUTORES.COD_INSTRUTOR ' +
           '  WHERE TURMAS.COD_TURMA = ' + QuotedStr(pk);

    ADOQueryAux.SQL.Text := sql;
    ADOQueryAux.Open;

    EditCod.Text := ADOQueryAux.fieldbyname('COD_TURMA').AsString;
    EditValor.Text := ADOQueryAux.fieldbyname('VALOR_AULA').AsString;
    EditValor.Text := formata_valor(EditValor.Text,'T');
    EditCurso.Text := ADOQueryAux.fieldbyname('CURSO').AsString;
    EditInstrutor.Text := ADOQueryAux.fieldbyname('INSTRUTOR').AsString;
    cod_curso := ADOQueryAux.fieldbyname('COD_CURSO').AsString;
    cod_instrutor := ADOQueryAux.fieldbyname('COD_INSTRUTOR').AsString;
  end;
end;


end.
