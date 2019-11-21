unit UnitInstrutores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DB, ADODB, Mask;

type
  TFormInstrutores = class(TForm)
    BotaoNovo: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    EditCod: TEdit;
    EditNome: TEdit;
    EditIdade: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ADOQueryAux: TADOQuery;
    BotaoLocalizar: TSpeedButton;
    Label6: TLabel;
    MaskEditTelefone: TMaskEdit;
    ComboBoxSexo: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BotaoNovoClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
    procedure BotaoFecharClick(Sender: TObject);
    procedure BotaoLocalizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    operacao, pk : String;
    procedure desabilita_salvar(Sender: TObject);
    procedure habilita_salvar(Sender: TObject);
    procedure bloqueia_campos;
    procedure libera_campos;
    procedure limpa_campos;
  end;

var
  FormInstrutores: TFormInstrutores;

implementation

uses UnitLogon, UnitPesquisa, Math, UnitMenu;

{$R *.dfm}

{ TFormInstrutores }

procedure TFormInstrutores.bloqueia_campos;
var i : integer;
begin
  for i := 1 to FormInstrutores.ComponentCount -1 do
  begin
    if FormInstrutores.Components[i] is TEdit then
    begin
      (FormInstrutores.Components[i] as TEdit).Enabled := False;
      (FormInstrutores.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TFormInstrutores.desabilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := True;
  BotaoSalvar.Enabled := False;
  BotaoAlterar.Enabled := True;
  BotaoCancelar.Enabled := False;
  BotaoExcluir.Enabled := True;

  if Sender = BotaoNovo then
    operacao := 'novo'
  else if Sender = BotaoSalvar then
    operacao := 'salvar'
  else if Sender = BotaoAlterar then
    operacao := 'alterar'
  else if Sender = BotaoCancelar then
    operacao := 'cancelar'
  else if Sender = BotaoExcluir then
    operacao := 'excluir';
end;

procedure TFormInstrutores.habilita_salvar(Sender: TObject);
begin
  BotaoNovo.Enabled := False;
  BotaoSalvar.Enabled := True;
  BotaoAlterar.Enabled := False;
  BotaoCancelar.Enabled := True;
  BotaoExcluir.Enabled := False;

  if Sender = BotaoNovo then
    operacao := 'novo'
  else if Sender = BotaoSalvar then
    operacao := 'salvar'
  else if Sender = BotaoAlterar then
    operacao := 'alterar'
  else if Sender = BotaoCancelar then
    operacao := 'cancelar'
  else if Sender = BotaoExcluir then
    operacao := 'excluir';
end;

procedure TFormInstrutores.libera_campos;
var i : integer;
begin
  for i := 1 to FormInstrutores.ComponentCount -1 do
  begin
    if FormInstrutores.Components[i] is TEdit then
    begin
      if (FormInstrutores.Components[i] as  TEdit).Name <> 'EditCod' then
      begin
        (FormInstrutores.Components[i] as TEdit).Enabled := True;
        (FormInstrutores.Components[i] as TEdit).Color := clWindow;
      end;
    end;
  end;
end;

procedure TFormInstrutores.limpa_campos;
var i : integer;
begin
  for i := 1 to FormInstrutores.ComponentCount -1 do
  begin
    if FormInstrutores.Components[i] is TEdit then
    begin
      (FormInstrutores.Components[i] as TEdit).Clear;
    end;
    MaskEditTelefone.clear;
  end;
end;


procedure TFormInstrutores.FormShow(Sender: TObject);
begin
  pk := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);
end;

procedure TFormInstrutores.BotaoNovoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  habilita_salvar(Sender);
end;

procedure TFormInstrutores.BotaoSalvarClick(Sender: TObject);
var deu_erro : boolean;
begin
  if (EditNome.Text='') or (EditIdade.Text='') or
      (MaskEditTelefone.Text='') or (ComboBoxSexo.Text='') then
    begin
      ShowMessage('Preencha todos os campos!');
    end
  else
    begin
      if operacao = 'novo' then
        ADOQueryAux.SQL.Text := 'INSERT INTO Instrutores' +
                                '(NOME, IDADE, TELEFONE, SEXO) VALUES '+
                                '('+ QuotedStr(EditNome.Text) +
                                ','+ EditIdade.Text +
                                ','+ QuotedStr(MaskEditTelefone.Text) +
                                ','+ QuotedStr(ComboBoxSexo.Text) + ')'
      else if operacao = 'alterar' then
        ADOQueryAux.SQL.Text := 'UPDATE Instrutores SET '+
                                '  NOME =' + QuotedStr(EditNome.Text) +
                                ', IDADE =' + EditIdade.Text +
                                ', TELEFONE =' + QuotedStr(MaskEditTelefone.Text) +
                                ', SEXO =' + QuotedStr(ComboBoxSexo.Text) +
                                ' WHERE COD_INSTRUTOR = '+ pk;
      FormLogon.ConexaoBD.BeginTrans;
      try
        ADOQueryAux.ExecSQL;
        deu_erro := False;
      except
        on E : Exception do
        begin
          deu_erro := True;
          if FormLogon.ErroBD(E.Message, 'PK_Instrutores') = 'Sim' then
            ShowMessage('Instrutor já cadastrado!')
          else if FormLogon.ErroBD(E.Message, 'FK_Turmas_Instrutores') = 'Sim' then
            ShowMessage('Existem turmas cadastradas para este Instrutor!')
          else
            ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
        end;
      end;

      if deu_erro = True then
        begin
          FormLogon.ConexaoBD.RollbackTrans;
        end
      else
        begin
          FormLogon.ConexaoBD.CommitTrans;
          if operacao = 'novo' then
          begin
            ADOQueryAux.SQL.Text := 'SELECT cod_instrutor FROM Instrutores ' +
                                    ' WHERE NOME =' + QuotedStr(EditNome.Text) +
                                    '   AND IDADE =' + EditIdade.Text +
                                    '   AND TELEFONE =' + QuotedStr(MaskEditTelefone.Text) +
                                    '   AND SEXO =' + QuotedStr(ComboBoxSexo.Text);
            ADOQueryAux.Open;
            pk := ADOQueryAux.fieldbyname('cod_instrutor').AsString;
            ADOQueryAux.Close;
          end;
          desabilita_salvar(Sender);
          bloqueia_campos;
          EditCod.Text := pk;
        end;
    end;
end;

procedure TFormInstrutores.BotaoAlterarClick(Sender: TObject);
begin
  if pk = '' then
    ShowMessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(Sender);
  end;
end;

procedure TFormInstrutores.BotaoCancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    limpa_campos;
    desabilita_salvar(Sender);
    bloqueia_campos;
end;

procedure TFormInstrutores.BotaoExcluirClick(Sender: TObject);
var deu_erro : boolean;
begin
  if pk = '' then
    ShowMessage('Impossível excluir!')
  else
   begin
      ADOQueryAux.SQL.Text := ' DELETE FROM Instrutores ' +
                              ' WHERE cod_instrutor = ' + pk;
    FormLogon.ConexaoBD.BeginTrans;

    try
      ADOQueryAux.ExecSQL;
      deu_erro := False;
    except
      on E : Exception do
      begin
        deu_erro := True;
        if FormLogon.ErroBD(E.Message,'FK_Turmas_Instrutores') = 'Sim' then
          ShowMessage('Existem turmas cadastradas para este instrutor!')
        else
          ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
      end;
    end;

    if deu_erro = true then
      begin
        FormLogon.ConexaoBD.RollbackTrans;
      end
    else
      begin
        FormLogon.ConexaoBD.CommitTrans;
        pk := '';
        desabilita_salvar(Sender);
        limpa_campos;
        bloqueia_campos;
        MaskEditTelefone.Clear;
      end;
   end;
end;

procedure TFormInstrutores.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormInstrutores.BotaoLocalizarClick(Sender: TObject);
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);

  FormPesquisa.sql_pesquisa := 'SELECT * FROM Instrutores';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    pk := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := ' SELECT * FROM Instrutores '+
                            ' WHERE cod_instrutor = ' + pk;
    ADOQueryAux.Open;
    EditCod.Text := ADOQueryAux.fieldbyname('cod_instrutor').AsString;
    EditNome.Text := ADOQueryAux.fieldbyname('nome').AsString;
    EditIdade.Text := ADOQueryAux.fieldbyname('idade').AsString;
    MaskEditTelefone.Text := ADOQueryAux.fieldbyname('telefone').AsString;
    ComboBoxSexo.Text := ADOQueryAux.fieldbyname('sexo').AsString;
  end;
end;

end.
