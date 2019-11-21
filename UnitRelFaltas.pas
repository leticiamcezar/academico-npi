unit UnitRelFaltas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpCon, RpConDS, RpDefine, RpRave, DB, ADODB, StdCtrls, Buttons;

type
  TFormRelFaltas = class(TForm)
    Label1: TLabel;
    ADOQueryRelFaltas: TADOQuery;
    ADOQueryAux: TADOQuery;
    RelFaltas: TRvProject;
    RvDataSetRelFaltas: TRvDataSetConnection;
    EditTurma: TEdit;
    BotaoFechar: TBitBtn;
    BotaoOK: TBitBtn;
    BotaoTurma: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BotaoTurmaClick(Sender: TObject);
    procedure BotaoOKClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cod_turma : String;
  end;

var
  FormRelFaltas: TFormRelFaltas;

implementation

uses UnitLogon, UnitPesquisaTurmas;

{$R *.dfm}

procedure TFormRelFaltas.FormShow(Sender: TObject);
begin
  cod_turma := '';
  EditTurma.Clear;
end;

procedure TFormRelFaltas.BotaoTurmaClick(Sender: TObject);
begin
  EditTurma.Clear;
  cod_turma := '';
  FormPesquisaTurmas.ShowModal;

  if FormPesquisaTurmas.chave <> '' then
  begin
    cod_turma := FormPesquisaTurmas.chave;
    EditTurma.Text := cod_turma;
  end;
end;

procedure TFormRelFaltas.BotaoOKClick(Sender: TObject);
var sql : String;
begin
  if cod_turma = '' then
    ShowMessage('Selecione uma turma!')
  else
  begin
    sql := '  SELECT TURMAS.COD_TURMA AS TURMA, '+
           '         ALUNOS.COD_ALUNO, '+
           '         ALUNOS.NOME, '+
           '         SUM(CASE WHEN FREQUENCIAS.PRESENTE = ' + QuotedStr('N') +
           '                  THEN 1 ELSE 0 END) AS FALTAS '+
           '  FROM TURMAS '+
           '  INNER JOIN MATRICULA '+
           '    ON TURMAS.COD_TURMA = MATRICULA.COD_TURMA '+
           '  INNER JOIN ALUNOS '+
           '    ON MATRICULA.COD_ALUNO = ALUNOS.COD_ALUNO '+
           '  INNER JOIN FREQUENCIAS '+
           '    ON MATRICULA.COD_TURMA = FREQUENCIAS.COD_TURMA '+
           '    AND MATRICULA.COD_ALUNO = FREQUENCIAS.COD_ALUNO '+
           '  WHERE TURMAS.COD_TURMA = ' + QuotedStr(cod_turma) +
           '  GROUP BY TURMAS.COD_TURMA, ALUNOS.COD_ALUNO, ALUNOS.NOME '+
           '  ORDER BY ALUNOS.NOME ';

    ADOQueryRelFaltas.SQL.Text := sql;
    ADOQueryRelFaltas.Open;
    RelFaltas.ProjectFile := GetCurrentDir + '\Rel_Faltas.rav';
    RelFaltas.Execute;
    ADOQueryRelFaltas.Close;
  end;
end;

procedure TFormRelFaltas.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

end.
