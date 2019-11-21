unit UnitMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, DB, ADODB;

type
  TFormMenu = class(TForm)
    BotaoCadCursos: TSpeedButton;
    BotaoCadInstrutores: TSpeedButton;
    BotaoCadTurmas: TSpeedButton;
    BotaoCadAlunos: TSpeedButton;
    BotaoMatriculas: TSpeedButton;
    BotaoAulas: TSpeedButton;
    BotaoFreq: TSpeedButton;
    BotaoPag: TSpeedButton;
    BotaoRelat: TSpeedButton;
    BotaoControle: TSpeedButton;
    BotaoFechar: TSpeedButton;
    ADOQueryAux: TADOQuery;
    procedure BotaoFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BotaoControleClick(Sender: TObject);
    procedure BotaoCadCursosClick(Sender: TObject);
    procedure BotaoCadInstrutoresClick(Sender: TObject);
    procedure BotaoCadTurmasClick(Sender: TObject);
    procedure BotaoCadAlunosClick(Sender: TObject);
    procedure BotaoMatriculasClick(Sender: TObject);
    procedure BotaoAulasClick(Sender: TObject);
    procedure BotaoFreqClick(Sender: TObject);
    procedure BotaoPagClick(Sender: TObject);
    procedure BotaoRelatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure permissoes;
  end;

var
  FormMenu: TFormMenu;

implementation

uses UnitLogon, UnitSplash, UnitUsuarios, UnitPermissoes, UnitPesquisa,
  UnitCursos, UnitInstrutores, UnitTurmas, UnitAlunos, UnitMatriculas,
  UnitLancaAulas, UnitLancaPresenca, UnitPagInstru, UnitPesquisaTurmas,
  UnitRelatorios;

{$R *.dfm}

procedure TFormMenu.BotaoFecharClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TFormMenu.permissoes;
begin
  ADOQueryAux.SQL.Text := ' SELECT cod_funcao FROM PERMISSOES ' +
                          ' WHERE USUARIO = ' + QuotedStr(FormLogon.usuario_logado);
  ADOQueryAux.Open;

  if ADOQueryAux.Locate('cod_funcao','CADCUR',[loCaseInsensitive]) then
    BotaoCadCursos.Enabled := True
  else
    BotaoCadCursos.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','CADINS',[loCaseInsensitive]) then
    BotaoCadInstrutores.Enabled := True
  else
    BotaoCadInstrutores.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','CADTUR',[loCaseInsensitive]) then
    BotaoCadTurmas.Enabled := True
  else
    BotaoCadTurmas.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','CADALU',[loCaseInsensitive]) then
    BotaoCadAlunos.Enabled := True
  else
    BotaoCadAlunos.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','CADMAT',[loCaseInsensitive]) then
    BotaoMatriculas.Enabled := True
  else
    BotaoMatriculas.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','CADAUL',[loCaseInsensitive]) then
    BotaoAulas.Enabled := True
  else
    BotaoAulas.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','LANAUL',[loCaseInsensitive]) then
    BotaoAulas.Enabled := True
  else
    BotaoAulas.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','LANFRE',[loCaseInsensitive]) then
    BotaoFreq.Enabled := True
  else
    BotaoFreq.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','PAGINS',[loCaseInsensitive]) then
    BotaoPag.Enabled := True
  else
    BotaoPag.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','RELATO',[loCaseInsensitive]) then
    BotaoRelat.Enabled := True
  else
    BotaoRelat.Enabled := False;

  if ADOQueryAux.Locate('cod_funcao','CONTRO',[loCaseInsensitive]) then
    BotaoControle.Enabled := True
  else
    BotaoControle.Enabled := False;

  ADOQueryAux.Close;
end;

procedure TFormMenu.FormShow(Sender: TObject);
begin
  permissoes;
end;

procedure TFormMenu.BotaoControleClick(Sender: TObject);
begin
  FormUsuarios.ShowModal;
end;

procedure TFormMenu.BotaoCadCursosClick(Sender: TObject);
begin
  FormCursos.ShowModal;
end;

procedure TFormMenu.BotaoCadInstrutoresClick(Sender: TObject);
begin
  FormInstrutores.ShowModal;
end;

procedure TFormMenu.BotaoCadTurmasClick(Sender: TObject);
begin
  FormTurmas.ShowModal;
end;

procedure TFormMenu.BotaoCadAlunosClick(Sender: TObject);
begin
  FormAlunos.ShowModal;
end;

procedure TFormMenu.BotaoMatriculasClick(Sender: TObject);
begin
  FormMatriculas.ShowModal;
end;

procedure TFormMenu.BotaoAulasClick(Sender: TObject);
begin
  FormLancaAulas.ShowModal;
end;

procedure TFormMenu.BotaoFreqClick(Sender: TObject);
begin
  FormLancaPresenca.ShowModal;
end;

procedure TFormMenu.BotaoPagClick(Sender: TObject);
begin
  FormPagIntru.ShowModal;
end;

procedure TFormMenu.BotaoRelatClick(Sender: TObject);
begin
  FormRelatorios.ShowModal;
end;

end.
