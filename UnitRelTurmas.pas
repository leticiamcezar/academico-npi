unit UnitRelTurmas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpCon, RpConDS, RpDefine, RpRave, DB, ADODB, StdCtrls, Buttons;

type
  TFormRelTurmas = class(TForm)
    BotaoFechar: TBitBtn;
    Label1: TLabel;
    EditCurso: TEdit;
    BotaoOK: TBitBtn;
    BotaoCurso: TBitBtn;
    ADOQueryRelTurmas: TADOQuery;
    ADOQueryAux: TADOQuery;
    RelTurmas: TRvProject;
    RvDataSetTurmas: TRvDataSetConnection;
    procedure FormShow(Sender: TObject);
    procedure BotaoCursoClick(Sender: TObject);
    procedure BotaoOKClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cod_curso : string;
  end;

var
  FormRelTurmas: TFormRelTurmas;

implementation

uses UnitLogon, UnitPesquisa;

{$R *.dfm}

procedure TFormRelTurmas.FormShow(Sender: TObject);
begin
  cod_curso := '';
  EditCurso.Clear;
end;

procedure TFormRelTurmas.BotaoCursoClick(Sender: TObject);
begin
  EditCurso.Clear;
  cod_curso := '';
  FormPesquisa.sql_pesquisa := 'SELECT * FROM CURSOS  ';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    cod_curso := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := ' SELECT NOME FROM CURSOS '+
                            ' WHERE COD_CURSO = ' +QuotedStr(cod_curso);
    ADOQueryAux.Open;
    EditCurso.Text := ADOQueryAux.fieldbyname('NOME').AsString;
  end;
end;

procedure TFormRelTurmas.BotaoOKClick(Sender: TObject);
var sql : String;
begin
  if cod_curso = '' then
    ShowMessage('Selecione um curso!')
  else
  begin
    sql := '  SELECT CURSOS.NOME AS CURSO, '+
           '         TURMAS.COD_TURMA AS TURMA, '+
           '         INSTRUTORES.NOME AS INSTRUTOR '+
           '  FROM TURMAS '+
           '  INNER JOIN CURSOS '+
           '    ON TURMAS.COD_CURSO = CURSOS.COD_CURSO  '+
           '  INNER JOIN INSTRUTORES '+
           '    ON TURMAS.COD_INSTRUTOR = INSTRUTORES.COD_INSTRUTOR '+
           '  WHERE TURMAS.COD_CURSO = ' + QuotedStr(cod_curso) +
           '  ORDER BY TURMAS.COD_TURMA ';

    ADOQueryRelTurmas.SQL.Text := sql;
    ADOQueryRelTurmas.Open;
    RelTurmas.ProjectFile := GetCurrentDir + '\Rel_Turmas.rav';
    RelTurmas.Execute;
    ADOQueryRelTurmas.Close;
  end;
end;

procedure TFormRelTurmas.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

end.
