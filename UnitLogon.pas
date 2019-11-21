unit UnitLogon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB;

type
  TFormLogon = class(TForm)
    BotaoOk: TSpeedButton;
    Label2: TLabel;
    EditUsuario: TEdit;
    Label1: TLabel;
    EditSenha: TEdit;
    BotaoFechar: TSpeedButton;
    ConexaoBD: TADOConnection;
    ADOQueryAux: TADOQuery;
    procedure BotaoOkClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    usuario_logado, senha_usuario : String;

    function autenticacao : boolean;
    function validacao(usuario, senha : string) : boolean;
    function criptografa (texto : String) : String;
    function descriptografa (texto : String) : String;
    function ErroBD(msg: String; texto: String): String;
  end;

var
  FormLogon: TFormLogon;

implementation

uses Math, UnitMenu, UnitSplash, UnitPermissoes, UnitPesquisa,
  UnitUsuarios;

{$R *.dfm}

{ TFormLogon }

function TFormLogon.autenticacao: boolean;
begin
  ConexaoBD.ConnectionString := ' Provider = SQLOLEDB.1; '+
                                ' Initial Catalog = Academico; '+
                                ' Data Source = PROGRAMADOR-01 ';
  try
    ConexaoBD.Open('admin_academico','masterkey');
    result := True;
  except
    ShowMessage('Não foi possível se conectar ao servidor!');
    result := False;
  end;
end;

function TFormLogon.criptografa(texto: String): String;
var
  i : Integer;
  cripto : String;
  cod_ascii : String;
begin
 cripto := '';

 for i := length(texto) downto 1 do
 begin
  cod_ascii := IntToStr(Ord(texto[i]));
  cod_ascii := StringOfChar('0',3-Length(cod_ascii)) + cod_ascii;
  cripto := cripto + cod_ascii;
 end;

 Result := cripto;
end;

function TFormLogon.descriptografa(texto: String): String;
var
  i : Integer;
  descripto : String;
  cod_ascii : Integer;
begin
 i := length(texto)+1;
 while i > 1 do
 begin
  i := i - 3;
  cod_ascii := StrToInt(Copy(texto,i,3));
  descripto := descripto + Chr(cod_ascii);
 end;

 Result := descripto;

end;

function TFormLogon.validacao(usuario, senha: string): boolean;
begin
  ADOQueryAux.SQL.Text := ' SELECT SENHA FROM USUARIOS '+
                          ' WHERE USUARIO = ' + QuotedStr(usuario);
  ADOQueryAux.Open;

  if ADOQueryAux.IsEmpty then
    begin
      ShowMessage('Usuário não cadastrado :(');
      Result := False;
    end
  else
    begin
      senha_usuario := ADOQueryAux.fieldbyname('SENHA').AsString;
      senha_usuario := descriptografa(senha_usuario);
      if senha_usuario <> senha then
        begin
          ShowMessage('Senha não confere!');
          Result := False;
        end
      else
        begin
          usuario_logado := usuario;
          Result := True;
        end;
      end;

      ADOQueryAux.Close;
end;

procedure TFormLogon.BotaoOkClick(Sender: TObject);
begin
  if validacao(EditUsuario.Text,EditSenha.Text) = true then
  begin
    hide;
    FormMenu.ShowModal;
    end; 
end;

procedure TFormLogon.BotaoFecharClick(Sender: TObject);
begin
  close;
end;

function TFormLogon.ErroBD(msg, texto: String): String;
var
  i, tam_msg, tam_texto : integer;
  pedaco : string;
begin
  tam_msg := length(msg);
  tam_texto := length(texto);
  for i := 1 to tam_msg do
  begin
    pedaco := copy(msg,i,tam_texto);
    if pedaco = texto then
      begin
        result := 'Sim';
        break;
      end
    else
      result := 'Não';
  end;
end;

procedure TFormLogon.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    BotaoOk.Click;
end;

end.
