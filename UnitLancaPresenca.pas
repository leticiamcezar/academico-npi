unit UnitLancaPresenca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DB, ADODB, CheckLst, ComCtrls;

type
  TFormLancaPresenca = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditTurma: TEdit;
    BotaoListarAluno: TSpeedButton;
    BotaoLancar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    CheckListBoxAlunos: TCheckListBox;
    ADOQueryAux: TADOQuery;
    ComboBoxAula: TComboBox;
    BotaoTurma: TBitBtn;
    procedure BotaoTurmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBoxAulaEnter(Sender: TObject);
    procedure BotaoListarAlunoClick(Sender: TObject);
    procedure BotaoLancarClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cod_turma : String;
  end;

var
  FormLancaPresenca: TFormLancaPresenca;

implementation

uses UnitPesquisaTurmas, UnitLogon, UnitLancaAulas;

{$R *.dfm}


procedure TFormLancaPresenca.BotaoTurmaClick(Sender: TObject);
begin
  EditTurma.Clear;
  FormPesquisaTurmas.ShowModal;

  if FormPesquisaTurmas.chave <> '' then
    EditTurma.Text := FormPesquisaTurmas.chave
end;

procedure TFormLancaPresenca.FormShow(Sender: TObject);
begin
  EditTurma.Clear;
  ComboBoxAula.Clear;
  CheckListBoxAlunos.Clear;
end;

procedure TFormLancaPresenca.ComboBoxAulaEnter(Sender: TObject);
var data : TDateTime;
begin
  ComboBoxAula.Clear;
  if EditTurma.Text = '' then
    ShowMessage('Selecione uma turma!')
  else
    begin
      ADOQueryAux.SQL.Text := 'SELECT DATA FROM AULAS '+
                              '   WHERE COD_TURMA = '  + QuotedStr(EditTurma.Text)+
                              '   AND DATA NOT IN  '   +
                              '  (SELECT DATA FROM FREQUENCIAS ' +
                              '   WHERE COD_TURMA = '  + QuotedStr(EditTurma.Text)+')'+
                              ' ORDER BY DATA DESC';

      ADOQueryAux.Open;
      if ADOQueryAux.IsEmpty then
        ShowMessage('Não existem aulas desta turma para lançamento de frequência!')
      else
        begin
          While not ADOQueryAux.Eof do
          begin
          data := ADOQueryAux.fieldbyname('DATA').AsDateTime;
          ComboBoxAula.Items.Add(FormatDateTime('dd/mm/yyyy',data));
          ADOQueryAux.Next;
        end;
      end;
      ADOQueryAux.Close;
    end;
end;

procedure TFormLancaPresenca.BotaoListarAlunoClick(Sender: TObject);
var aluno : string;
begin
  if (EditTurma.Text = '') or (ComboBoxAula.Text='') then
    ShowMessage('Informações inválidas!')
  else
  begin
    ADOQueryAux.SQL.Text := 'SELECT MATRICULA.COD_ALUNO, ALUNOS.NOME '+
                            '   FROM MATRICULA INNER JOIN ALUNOS '+
                            '   ON MATRICULA.COD_ALUNO = ALUNOS.COD_ALUNO '+
                            '   WHERE COD_TURMA = '+QuotedStr(EditTurma.Text)+
                            ' ORDER BY ALUNOS.NOME';
    ADOQueryAux.Open;
    if ADOQueryAux.IsEmpty then
      ShowMessage('Não existem alunos matriculados nesta turma!')
    else
    begin
      While not ADOQueryAux.Eof do
      begin
        aluno := ADOQueryAux.fieldbyname('COD_ALUNO').AsString;
        aluno := stringofchar('0',3-length(aluno)) + aluno;
        aluno := aluno + ' - ' + ADOQueryAux.fieldbyname('NOME').AsString;
        CheckListBoxAlunos.Items.Add(aluno);
        ADOQueryAux.Next;
      end;
    end;
    ADOQueryAux.Close;
  end;
end;

procedure TFormLancaPresenca.BotaoLancarClick(Sender: TObject);
var i : integer;
    cod_aluno, presente, data : string;
    deu_erro : boolean;
begin
  FormLogon.ConexaoBD.BeginTrans;
  try
    deu_erro := false;
    data := FormatDateTime('mm/dd/yyyy',StrToDate(ComboBoxAula.Text));
    for i := 0 to CheckListBoxAlunos.Items.Count -1 do
    begin
      CheckListBoxAlunos.Selected[i] := true;
      cod_aluno := copy(CheckListBoxAlunos.Items.Strings[i],1,3);

      if CheckListBoxAlunos.Checked[i] then
        presente := 'S'
      else
        presente := 'N';

      ADOQueryAux.SQL.Text := 'INSERT INTO FREQUENCIAS VALUES  '+
                              '('+ QuotedStr(EditTurma.Text) +
                              ','+ cod_aluno +
                              ','+ QuotedStr(data) +
                              ','+ QuotedStr(presente) + ')';

      ADOQueryAux.ExecSQL;
    end;
  except
    on E: Exception do
    begin
     deu_erro := true;
     ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
    end;
  end;

  if deu_erro = true then
    FormLogon.ConexaoBD.RollbackTrans
  else
    begin
      FormLogon.ConexaoBD.CommitTrans;
      ShowMessage('Lançamento efetuado com sucesso!');
      EditTurma.Clear;
      ComboBoxAula.Clear;
      CheckListBoxAlunos.Clear;
    end;
end;

procedure TFormLancaPresenca.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

end.
