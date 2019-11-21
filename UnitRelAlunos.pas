unit UnitRelAlunos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpCon, RpConDS, RpDefine, RpRave, DB, ADODB, StdCtrls, Buttons;

type
  TFormRelAlunos = class(TForm)
    Label1: TLabel;
    EditTurma: TEdit;
    BotaoFechar: TBitBtn;
    BotaoOK: TBitBtn;
    BotaoTurma: TBitBtn;
    ADOQueryRelAlunos: TADOQuery;
    ADOQueryAux: TADOQuery;
    RelAlunos: TRvProject;
    RvDataSetRelAlunos: TRvDataSetConnection;
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
  FormRelAlunos: TFormRelAlunos;

implementation

uses UnitLogon, UnitPesquisa, UnitPesquisaTurmas;

{$R *.dfm}

procedure TFormRelAlunos.FormShow(Sender: TObject);
begin
  cod_turma := '';
  EditTurma.Clear;
end;

procedure TFormRelAlunos.BotaoTurmaClick(Sender: TObject);
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

procedure TFormRelAlunos.BotaoOKClick(Sender: TObject);
var sql : string;
begin
  if cod_turma = '' then
    ShowMessage('Selecione uma turma1')
  else
  begin
    sql := ' SELECT TURMAS.COD_TURMA AS TURMA, '+
           '        ALUNOS.COD_ALUNO, ALUNOS.NOME, '+
           '        ALUNOS.IDADE, ALUNOS.TELEFONE, ALUNOS.SEXO  '+
           ' FROM TURMAS '+
           '  INNER JOIN MATRICULA '+
           '    ON TURMAS.COD_TURMA = MATRICULA.COD_TURMA '+
           '  INNER JOIN ALUNOS '+
           '    ON MATRICULA.COD_ALUNO = ALUNOS.COD_ALUNO  '+
           '  WHERE TURMAS.COD_TURMA = ' + QuotedStr(cod_turma) +
           '  ORDER BY ALUNOS.NOME  ';

    ADOQueryRelAlunos.SQL.Text := sql;
    ADOQueryRelAlunos.Open;
    RelAlunos.ProjectFile := GetCurrentDir + '\Rel_Alunos.rav';
    RelAlunos.Execute;
    ADOQueryRelAlunos.Close;
  end;
end;

procedure TFormRelAlunos.BotaoFecharClick(Sender: TObject);
begin
  close;
end;

end.
