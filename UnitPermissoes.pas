unit UnitPermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, Buttons, StdCtrls;

type
  TFormPermissoes = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxFuncoes: TComboBox;
    BotaoInserir: TSpeedButton;
    BotaoRetirar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    ADOQueryPermissoes: TADOQuery;
    ADOQueryAux: TADOQuery;
    DataSourcePermissoes: TDataSource;
    DBGridPermissoes: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ComboBoxFuncoesEnter(Sender: TObject);
    procedure BotaoInserirClick(Sender: TObject);
    procedure BotaoRetirarClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    usuario : String;
  end;

var
  FormPermissoes: TFormPermissoes;

implementation

uses UnitLogon, UnitMenu, UnitPesquisa, UnitSplash, UnitUsuarios;

{$R *.dfm}

procedure TFormPermissoes.FormShow(Sender: TObject);
begin
  ADOQueryPermissoes.SQL.Text := 'SELECT Funcoes.nome '+
                                 'FROM Funcoes INNER JOIN Permissoes ON '+
                                 'Funcoes.cod_funcao = Permissoes.cod_funcao '+
                                 'WHERE Permissoes.usuario = ' + QuotedStr(usuario) +
                                 'ORDER BY FUNCOES.nome';
  ADOQueryPermissoes.Open;
  end;

procedure TFormPermissoes.ComboBoxFuncoesEnter(Sender: TObject);
begin
  ComboBoxFuncoes.Clear;
  ADOQueryAux.SQL.Text := 'SELECT nome FROM Funcoes '+
                          'WHERE cod_funcao NOT IN '+
                          '(SELECT cod_funcao FROM Permissoes '+
                          ' WHERE usuario = '+ QuotedStr(usuario) + ')' +
                          'ORDER BY nome';
  ADOQueryAux.Open;
  While not ADOQueryAux.Eof do
  begin
    ComboBoxFuncoes.Items.Add(ADOQueryAux.fieldbyname('NOME').AsString);
    ADOQueryAux.Next;
  end;

  ComboBoxFuncoes.ItemIndex := 0;

  ADOQueryAux.Close;
end;

procedure TFormPermissoes.BotaoInserirClick(Sender: TObject);
var
  cod_funcao : String;
begin
  if ComboBoxFuncoes.Items.Count = 0 then
  begin
    ShowMessage('Não há permissões para serem adcionadas!');
    Exit;
  end;

  ADOQueryAux.SQL.Text := 'SELECT cod_funcao FROM Funcoes '+
                          'WHERE nome = ' + QuotedStr(ComboBoxFuncoes.Text);
  ADOQueryAux.Open;
  cod_funcao := ADOQueryAux.fieldbyname('cod_funcao').AsString;
  ADOQueryAux.Close;

  ADOQueryAux.SQL.Text := 'INSERT INTO Permissoes VALUES'+
                          '('+ QuotedStr(cod_funcao) +
                          ','+ QuotedStr(usuario) + ')';

  FormLogon.ConexaoBD.BeginTrans;
  ADOQueryAux.ExecSQL;
  FormLogon.ConexaoBD.CommitTrans;

  ADOQueryPermissoes.Close;
  ADOQueryPermissoes.Open;
  ComboBoxFuncoes.Clear;
  ComboBoxFuncoesEnter(nil);
end;

procedure TFormPermissoes.BotaoRetirarClick(Sender: TObject);
var
  cod_funcao, nome : String;
begin
 nome := ADOQueryPermissoes.fieldbyname('nome').AsString;
 ADOQueryAux.SQL.Text := 'SELECT cod_funcao FROM Funcoes '+
                         'WHERE nome = ' + QuotedStr(nome);
 ADOQueryAux.Open;
 cod_funcao := ADOQueryAux.fieldbyname('cod_funcao').AsString;
 ADOQueryAux.Close;

 ADOQueryAux.SQL.Text := 'DELETE FROM Permissoes '+
                         'WHERE cod_funcao ='+ QuotedStr(cod_funcao) +
                         'AND usuario ='+ QuotedStr(usuario);

 FormLogon.ConexaoBD.BeginTrans;
 ADOQueryAux.ExecSQL;
 FormLogon.ConexaoBD.CommitTrans;

 ADOQueryPermissoes.Close;
 ADOQueryPermissoes.Open;
end;

procedure TFormPermissoes.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

end.
