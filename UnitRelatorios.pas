unit UnitRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RpCon, RpConDS, RpDefine, RpRave, DB, ADODB;

type
  TFormRelatorios = class(TForm)
    BotaoCursos: TBitBtn;
    BotaoTurmas: TBitBtn;
    BotaoAlunos: TBitBtn;
    BotaoFaltas: TBitBtn;
    BotaoAulas: TBitBtn;
    BotaoFechar: TBitBtn;
    RelCursos: TRvProject;
    RvDataSetRelCursos: TRvDataSetConnection;
    ADOQueryRelCursos: TADOQuery;
    procedure BotaoCursosClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
    procedure BotaoTurmasClick(Sender: TObject);
    procedure BotaoAlunosClick(Sender: TObject);
    procedure BotaoFaltasClick(Sender: TObject);
    procedure BotaoAulasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelatorios: TFormRelatorios;

implementation

uses UnitLogon, UnitRelTurmas, UnitRelAlunos, UnitRelFaltas, UnitRelAulas;

{$R *.dfm}

procedure TFormRelatorios.BotaoCursosClick(Sender: TObject);
begin
  ADOQueryRelCursos.Open;
  RelCursos.ProjectFile := GetCurrentDir + '\Rel_Cursos.rav';
  RelCursos.Execute;
  ADOQueryRelCursos.Close;
end;

procedure TFormRelatorios.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelatorios.BotaoTurmasClick(Sender: TObject);
begin
  FormRelTurmas.ShowModal;
end;

procedure TFormRelatorios.BotaoAlunosClick(Sender: TObject);
begin
  FormRelAlunos.ShowModal;
end;

procedure TFormRelatorios.BotaoFaltasClick(Sender: TObject);
begin
  FormRelFaltas.ShowModal;
end;

procedure TFormRelatorios.BotaoAulasClick(Sender: TObject);
begin
  FormRelAulas.ShowModal;
end;

end.
