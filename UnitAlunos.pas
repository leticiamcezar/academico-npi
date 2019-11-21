unit UnitAlunos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Mask, DB, ADODB;

type
  TFormAlunos = class(TForm)
    BotaoNovo: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoFechar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    Label1: TLabel;
    EditCod: TEdit;
    Label2: TLabel;
    EditNome: TEdit;
    Label3: TLabel;
    EditIdade: TEdit;
    Label4: TLabel;
    MaskEditTelefone: TMaskEdit;
    Label5: TLabel;
    ComboBoxSexo: TComboBox;
    ADOQueryAux: TADOQuery;
    BotaoLocalizar: TSpeedButton;
    Label6: TLabel;
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
  FormAlunos: TFormAlunos;

implementation

uses UnitLogon, Math, UnitPesquisa;

{$R *.dfm}

{ TFormAlunos }

procedure TFormAlunos.bloqueia_campos;
var i : integer;
begin
  for i := 1 to FormAlunos.ComponentCount -1 do
  begin
    if FormAlunos.Components[i] is TEdit then
    begin
      (FormAlunos.Components[i] as TEdit).Enabled := False;
      (FormAlunos.Components[i] as TEdit).Color := clInfoBk;
    end;
  end;
end;

procedure TFormAlunos.desabilita_salvar(Sender: TObject);
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

procedure TFormAlunos.habilita_salvar(Sender: TObject);
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
  else if Sender = BotaoExcluir then
    operacao := 'cancelar'
  else if Sender = BotaoExcluir then
    operacao := 'excluir';
end;

procedure TFormAlunos.libera_campos;
var i : integer;
begin
  for i := 1 to FormAlunos.ComponentCount -1 do
  begin
    if FormAlunos.Components[i] is TEdit then
    begin
      if (FormAlunos.Components[i] as TEdit).Name <> 'EditCod' then
      begin
        (FormAlunos.Components[i] as TEdit).Enabled := True;
        (FormAlunos.Components[i] as TEdit).Color := clWindow;
      end;
    end;
  end;
end;

procedure TFormAlunos.limpa_campos;
var i : integer;
begin
  for i := 1 to FormAlunos.ComponentCount -1 do
  begin
    if FormAlunos.Components[i] is TEdit then
    begin
      (FormAlunos.Components[i] as TEdit).Clear;
    end;
      MaskEditTelefone.clear;
  end;
end;

procedure TFormAlunos.FormShow(Sender: TObject);
begin
  pk := '';
  operacao := '';
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);
end;

procedure TFormAlunos.BotaoNovoClick(Sender: TObject);
begin
  libera_campos;
  limpa_campos;
  pk := '';
  habilita_salvar(Sender);
end;

procedure TFormAlunos.BotaoSalvarClick(Sender: TObject);
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
        ADOQueryAux.SQL.Text := 'INSERT INTO ALUNOS  ' +
                                '(NOME, IDADE, TELEFONE, SEXO) VALUES  '+
                                '('+ QuotedStr(EditNome.Text) +
                                ','+ EditIdade.Text +
                                ','+ QuotedStr(MaskEditTelefone.Text) +
                                ','+ QuotedStr(ComboBoxSexo.Text) + ')'

      else if operacao = 'alterar' then
        ADOQueryAux.SQL.Text := 'UPDATE ALUNOS SET  '+
                                '   NOME = '+ QuotedStr(EditNome.Text) +
                                ',   IDADE = '+ EditIdade.Text +
                                ',   TELEFONE = '+ QuotedStr(MaskEditTelefone.Text) +
                                ',   SEXO = '+ QuotedStr(ComboBoxSexo.Text) +
                                '   WHERE COD_ALUNO = '+ pk;
        FormLogon.ConexaoBD.BeginTrans;
        try
          ADOQueryAux.ExecSQL;
          deu_erro := false;
        except
          on E : Exception do
          begin
            deu_erro := true;
            if FormLogon.ErroBD(E.Message,'PK_Alunos') = 'Sim' then
              ShowMessage('Aluno já cadastrado!')
            else if FormLogon.ErroBD(E.Message,'FK_Matricula_Alunos') = 'Sim' then
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
          if operacao = 'novo' then       
          begin
            ADOQueryAux.SQL.Text := ' SELECT COD_ALUNO FROM ALUNOS ' +
                                    '   WHERE NOME = ' + QuotedStr(EditNome.Text) +
                                    '   AND IDADE = ' + EditIdade.Text +
                                    '   AND TELEFONE = ' + QuotedStr(MaskEditTelefone.Text) +
                                    '   AND SEXO = ' + QuotedStr(ComboBoxSexo.Text);
            ADOQueryAux.Open;
            pk := ADOQueryAux.fieldbyname('COD_ALUNO').AsString;
            ADOQueryAux.Close;
          end;
          desabilita_salvar(Sender);
          bloqueia_campos;
          EditCod.Text := pk;
        end;
    end;
end;

procedure TFormAlunos.BotaoAlterarClick(Sender: TObject);
begin
  if pk = '' then
    ShowMessage('Impossível alterar!')
  else
  begin
    libera_campos;
    habilita_salvar(Sender);
  end;
end;

procedure TFormAlunos.BotaoCancelarClick(Sender: TObject);
begin
  if operacao = 'novo' then
    limpa_campos;
    desabilita_salvar(Sender);
    bloqueia_campos;
end;

procedure TFormAlunos.BotaoExcluirClick(Sender: TObject);
var deu_erro : boolean;
begin
  if pk = '' then
    ShowMessage('Impossível excluir!')
  else
    begin
      ADOQueryAux.SQL.Text := '  DELETE FROM ALUNOS  ' +
                              '  WHERE COD_ALUNO = ' + pk;
      FormLogon.ConexaoBD.BeginTrans;

      try
        ADOQueryAux.ExecSQL;
        deu_erro := false;
      except
        on E : Exception do
        begin
          deu_erro := true;
          if FormLogon.ErroBD(E.Message,'FK_Matricula_Alunos') = 'Sim' then
            ShowMessage('Existem matrículas cadastradas para este aluno!')
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
        end;
    end;
end;

procedure TFormAlunos.BotaoFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAlunos.BotaoLocalizarClick(Sender: TObject);
begin
  limpa_campos;
  bloqueia_campos;
  desabilita_salvar(Sender);

  FormPesquisa.sql_pesquisa := 'SELECT * FROM ALUNOS  ';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    pk := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := ' SELECT * FROM ALUNOS  '+
                            '   WHERE COD_ALUNO = '+ pk;
    ADOQueryAux.Open;
    EditCod.Text := ADOQueryAux.fieldbyname('COD_ALUNO').AsString;
    EditNome.Text := ADOQueryAux.fieldbyname('NOME').AsString;
    EditIdade.Text := ADOQueryAux.fieldbyname('IDADE').AsString;
    MaskEditTelefone.Text := ADOQueryAux.fieldbyname('TELEFONE').AsString;
    ComboBoxSexo.Text := ADOQueryAux.fieldbyname('SEXO').AsString;
  end;
end;

end.
