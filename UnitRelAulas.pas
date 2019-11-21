unit UnitRelAulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpCon, RpConDS, RpDefine, RpRave, DB, ADODB, StdCtrls, Buttons;

type
  TFormRelAulas = class(TForm)
    Label1: TLabel;
    EditInstrutor: TEdit;
    BotaoInstrutor: TBitBtn;
    BotaoOK: TBitBtn;
    BotaoFechar: TBitBtn;
    ADOQueryRelAulas: TADOQuery;
    ADOQueryAux: TADOQuery;
    RelAulas: TRvProject;
    RvDataSetAulas: TRvDataSetConnection;
    procedure FormShow(Sender: TObject);
    procedure BotaoInstrutorClick(Sender: TObject);
    procedure BotaoOKClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cod_instrutor : String;
  end;

var
  FormRelAulas: TFormRelAulas;

implementation

uses UnitLogon, UnitPesquisa;

{$R *.dfm}

procedure TFormRelAulas.FormShow(Sender: TObject);
begin
  cod_instrutor := '';
  EditInstrutor.Clear;
end;

procedure TFormRelAulas.BotaoInstrutorClick(Sender: TObject);
begin
  EditInstrutor.Clear;
  cod_instrutor := '';
  FormPesquisa.sql_pesquisa := ' SELECT * FROM INSTRUTORES ';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    cod_instrutor := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := ' SELECT NOME FROM INSTRUTORES  '+
                            ' WHERE COD_INSTRUTOR = ' + cod_instrutor;
    ADOQueryAux.Open;
    EditInstrutor.Text := ADOQueryAux.fieldbyname('NOME').AsString;
  end;
end;

procedure TFormRelAulas.BotaoOKClick(Sender: TObject);
var sql : String;
begin
  if cod_instrutor = '' then
    ShowMessage('Selecione um instrutor!')
  else
  begin
    sql := '  SELECT INSTRUTORES.COD_INSTRUTOR,  '+
           '         INSTRUTORES.NOME,  '+
           '         TURMAS.COD_TURMA,  '+
           '         COUNT(AULAS.DATA) AS AULAS '+
           '  FROM INSTRUTORES '+
           '  INNER JOIN TURMAS '+
           '    ON INSTRUTORES.COD_INSTRUTOR = TURMAS.COD_INSTRUTOR '+
           '  INNER JOIN AULAS  '+
           '    ON TURMAS.COD_TURMA = AULAS.COD_TURMA '+
           '  WHERE INSTRUTORES.COD_INSTRUTOR = ' + cod_instrutor +
           '  GROUP BY INSTRUTORES.COD_INSTRUTOR, '+
           '           INSTRUTORES.NOME, TURMAS.COD_TURMA '+
           '  ORDER BY TURMAS.COD_TURMA ';

    ADOQueryRelAulas.SQL.Text := sql;
    ADOQueryRelAulas.Open;
    RelAulas.ProjectFile := GetCurrentDir + '\Rel_Aulas.rav';
    RelAulas.Execute;
    ADOQueryRelAulas.Close;
  end;
end;

procedure TFormRelAulas.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

end.
