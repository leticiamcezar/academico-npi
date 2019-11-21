unit UnitPesquisaTurmas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, StdCtrls;

type
  TFormPesquisaTurmas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxCampo: TComboBox;
    EditTexto: TEdit;
    DBGridPesquisaTurmas: TDBGrid;
    ADOQueryPesquisaTurma: TADOQuery;
    DataSourcePesquisaTurma: TDataSource;
    BotaoCancelar: TBitBtn;
    BotaoSelecionar: TBitBtn;
    BotaoPesquisar: TBitBtn;
    BotaoLimpar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BotaoPesquisarClick(Sender: TObject);
    procedure BotaoLimparClick(Sender: TObject);
    procedure BotaoSelecionarClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    chave : String;
  end;

var
  FormPesquisaTurmas: TFormPesquisaTurmas;

implementation

uses UnitLogon, UnitCursos, UnitInstrutores, UnitMenu, UnitPermissoes,
  UnitPesquisa, UnitSplash, UnitTurmas, UnitUsuarios;

{$R *.dfm}

procedure TFormPesquisaTurmas.FormShow(Sender: TObject);
begin
  chave := '';
  ComboBoxCampo.ItemIndex := -1;
  EditTexto.Clear;
  ADOQueryPesquisaTurma.Close;
end;

procedure TFormPesquisaTurmas.BotaoPesquisarClick(Sender: TObject);
var condicao : string;
    sql : string;
begin
  condicao := '';
  if ComboBoxCampo.ItemIndex = 0 then
    condicao := ' WHERE TURMAS.COD_TURMA LIKE ' +
                QuotedStr(EditTexto.Text)
  else if ComboBoxCampo.ItemIndex = 1 then
    condicao := ' WHERE CURSOS.NOME LIKE ' +
                QuotedStr(EditTexto.Text)
  else if ComboBoxCampo.ItemIndex = 2 then
    condicao := ' WHERE INSTRUTORES.NOME LIKE ' +
                QuotedStr(EditTexto.Text);

  if (condicao='') or (EditTexto.Text='') then
    ShowMessage('Pesquisa inválida!')
  else
    begin
    sql  :=  ' SELECT TURMAS.COD_TURMA, ' +
             '        CURSOS.NOME AS CURSO, ' +
             '        INSTRUTORES.NOME AS INSTRUTOR ' +
             'FROM TURMAS   ' +
             'INNER JOIN CURSOS  ' +
             ' ON TURMAS.COD_CURSO = CURSOS.COD_CURSO  ' +
             'INNER JOIN INSTRUTORES ' +
             ' ON TURMAS.COD_INSTRUTOR = INSTRUTORES.COD_INSTRUTOR ';

    ADOQueryPesquisaTurma.Close;
    ADOQueryPesquisaTurma.SQL.Text := sql + condicao;
    ADOQueryPesquisaTurma.Open;
  end;
end;

procedure TFormPesquisaTurmas.BotaoLimparClick(Sender: TObject);
begin
  chave := '';
  ComboBoxCampo.ItemIndex := -1;
  EditTexto.clear;
  ADOQueryPesquisaTurma.Close;
end;

procedure TFormPesquisaTurmas.BotaoSelecionarClick(Sender: TObject);
begin
  if ADOQueryPesquisaTurma.Active = false then
    ShowMessage('Impossível selecionar!')
  else
  begin
    chave := ADOQueryPesquisaTurma.fieldbyname('cod_turma').AsString;
    ADOQueryPesquisaTurma.Close;
    Close;
  end;
end;

procedure TFormPesquisaTurmas.BotaoCancelarClick(Sender: TObject);
begin
  chave := '';
  ADOQueryPesquisaTurma.Close;
  Close;
end;

procedure TFormPesquisaTurmas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  BotaoPesquisar.Click;
end;

end.
