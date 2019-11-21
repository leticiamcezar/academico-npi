unit UnitPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, StdCtrls;

type
  TFormPesquisa = class(TForm)
    Label1: TLabel;
    EditNome: TEdit;
    DBGridPesquisa: TDBGrid;
    ADOQueryPesquisa: TADOQuery;
    DataSourcePesquisa: TDataSource;
    BotaoPesquisar: TBitBtn;
    BotaoLimpar: TBitBtn;
    BotaoSelecionar: TBitBtn;
    BotaoCancelar: TBitBtn;
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
    chave, chave_aux, sql_pesquisa : String;
  end;

var
  FormPesquisa: TFormPesquisa;

implementation

uses UnitLogon, UnitPermissoes, UnitUsuarios, UnitMenu, UnitSplash;

{$R *.dfm}

procedure TFormPesquisa.FormShow(Sender: TObject);
begin
EditNome.Clear;
end;

procedure TFormPesquisa.BotaoPesquisarClick(Sender: TObject);
begin
  if EditNome.Text = '' then
    ShowMessage('Digite o nome ou parte do nome!')
  else if sql_pesquisa = '' then
    ShowMessage('Impossível pesquisar!')
  else
    begin
      ADOQueryPesquisa.Close;
      ADOQueryPesquisa.SQL.Text := sql_pesquisa + ' WHERE NOME LIKE ' +
                                                  QuotedStr('%' + EditNome.Text + '%');

      ADOQueryPesquisa.SQL.SaveToFile('sql.sql');
      ADOQueryPesquisa.Open;
    end;
end;

procedure TFormPesquisa.BotaoLimparClick(Sender: TObject);
begin
  chave := '';
  EditNome.Clear;
  ADOQueryPesquisa.Close;
end;

procedure TFormPesquisa.BotaoSelecionarClick(Sender: TObject);
begin
  if ADOQueryPesquisa.Active = False then
    ShowMessage('Impossível selecionar')
  else
  begin
    chave := ADOQueryPesquisa.Fields.Fields[0].AsString;
    chave_aux := ADOQueryPesquisa.Fields.Fields[1].AsString;
    ADOQueryPesquisa.Close;
    Close;
  end;
end;

procedure TFormPesquisa.BotaoCancelarClick(Sender: TObject);
begin
  chave := '';
  ADOQueryPesquisa.Close;
  Close;
end;

procedure TFormPesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then
    BotaoPesquisar.Click;
end;

end.
