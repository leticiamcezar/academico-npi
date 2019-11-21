unit UnitLancaAulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, ComCtrls, StdCtrls;

type
  TFormLancaAulas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditTurma: TEdit;
    dt_aula: TDateTimePicker;
    BotaoLancar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    ADOQueryAux: TADOQuery;
    BotaoTurma: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BotaoTurmaClick(Sender: TObject);
    procedure BotaoLancarClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLancaAulas: TFormLancaAulas;

implementation

uses UnitLogon, UnitPesquisaTurmas;

{$R *.dfm}

procedure TFormLancaAulas.FormShow(Sender: TObject);
begin
  EditTurma.Clear;
  dt_aula.Date := Date;
end;

procedure TFormLancaAulas.BotaoTurmaClick(Sender: TObject);
begin
  EditTurma.Clear;
  FormPesquisaTurmas.ShowModal;

  if FormPesquisaTurmas.chave <> '' then
     EditTurma.Text := FormPesquisaTurmas.chave;
end;

procedure TFormLancaAulas.BotaoLancarClick(Sender: TObject);
var data_aula : String;
    deu_erro : boolean;
begin
  if EditTurma.Text = '' then
    ShowMessage('Informe a turma!')
  else if dt_aula.Date > date then
    ShowMessage('Não é permitido lançar aulas antecipadamente!')
  else
    begin
      data_aula := FormatDateTime('mm/dd/yyyy',dt_aula.Date);

      ADOQueryAux.SQL.Text := 'INSERT INTO AULAS VALUES '+
                              '('+ QuotedStr(EditTurma.Text) +
                              ','+ QuotedStr(data_aula) +
                              ','+ QuotedStr('N') + ')';

      FormLogon.ConexaoBD.BeginTrans;
      try
        ADOQueryAux.ExecSQL;
        deu_erro := false;
      except
        on E : Exception do
        begin
          deu_erro := true;
        if FormLogon.ErroBD(E.Message,'PK_Aulas') = 'Sim' then
          ShowMessage('Aula já lançada!')
        else
          ShowMessage('Ocorreu o seguinte erro: ' + E.Message);
        end;
      end;

      if deu_erro = true then
        FormLogon.ConexaoBD.RollbackTrans
      else
        begin
          FormLogon.ConexaoBD.CommitTrans;
          ShowMessage('Aula lançada com sucesso!');
          EditTurma.Clear;
          dt_aula.Date := Date;
        end;
    end;
end;

procedure TFormLancaAulas.BotaoCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
