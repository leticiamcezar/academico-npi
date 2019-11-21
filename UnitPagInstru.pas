unit UnitPagInstru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, StdCtrls, RpCon, RpConDS, RpDefine, RpRave;

type
  TFormPagIntru = class(TForm)
    Label1: TLabel;
    EditPag: TEdit;
    ComboBoxMesAno: TComboBox;
    Label2: TLabel;
    BotaoGerar: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    ADOQueryAux: TADOQuery;
    ADOQueryDemonstrativo: TADOQuery;
    RvProjectDemonstrativo: TRvProject;
    RvDataSetConnectionDemonstrativo: TRvDataSetConnection;
    ADOQueryDemonstrativoCOD_INSTRUTOR: TAutoIncField;
    ADOQueryDemonstrativoNOME: TStringField;
    ADOQueryDemonstrativoCOD_TURMA: TStringField;
    ADOQueryDemonstrativoDATA: TDateTimeField;
    ADOQueryDemonstrativoVALOR_AULA: TBCDField;
    BotaoInstrutor: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BotaoInstrutorClick(Sender: TObject);
    procedure ComboBoxMesAnoEnter(Sender: TObject);
    procedure BotaoGerarClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cod_instrutor : string;
  end;

var
  FormPagIntru: TFormPagIntru;

implementation

uses UnitLogon, UnitPesquisa;

{$R *.dfm}

procedure TFormPagIntru.FormShow(Sender: TObject);
begin
  EditPag.Clear;
  cod_instrutor := '';
  ComboBoxMesAno.Clear;
  BotaoInstrutor.SetFocus();
end;

procedure TFormPagIntru.BotaoInstrutorClick(Sender: TObject);
begin
  EditPag.Clear;
  ComboBoxMesAno.Clear;
  cod_instrutor := '';
  FormPesquisa.sql_pesquisa := '  SELECT * FROM INSTRUTORES  ';
  FormPesquisa.ShowModal;
  if FormPesquisa.chave <> '' then
  begin
    cod_instrutor := FormPesquisa.chave;
    ADOQueryAux.SQL.Text := '  SELECT NOME FROM INSTRUTORES ' +
                            '  WHERE COD_INSTRUTOR = ' + cod_instrutor;
    ADOQueryAux.Open;
    EditPag.Text := ADOQueryAux.fieldbyname('NOME').AsString;

    //ComboBoxMesAnoEnter(nil);
  end;
end;

procedure TFormPagIntru.ComboBoxMesAnoEnter(Sender: TObject);
var mes, ano : string;
begin
  ComboBoxMesAno.Clear;
  if cod_instrutor = '' then
    ShowMessage('Selecione um instrutor')
  else
    begin
      ADOQueryAux.SQL.Text := 'SELECT DISTINCT ' +
                              '   MONTH(AULAS.DATA) AS MES, ' +
                              '   YEAR(AULAS.DATA) AS ANO   ' +
                              '  FROM AULAS ' +
                              '  INNER JOIN TURMAS ' +
                              '    ON AULAS.COD_TURMA = TURMAS.COD_TURMA ' +
                              '  WHERE TURMAS.COD_INSTRUTOR = ' + cod_instrutor +
                              '  AND AULAS.PAGA = ' + QuotedStr('N') +
                              '  ORDER BY YEAR(AULAS.DATA), MONTH(AULAS.DATA)  ';
      ADOQueryAux.Open;
      if ADOQueryAux.IsEmpty then
        ShowMessage('Não existem aulas a serem pagas para este instrutor!')
      else
      begin
        While not ADOQueryAux.Eof do
        begin
          mes := ADOQueryAux.fieldbyname('MES').AsString;
          mes := stringofchar('0',2-length(mes)) + mes;
          ano := ADOQueryAux.fieldbyname('ANO').AsString;
          ComboBoxMesAno.Items.Add(mes+'/'+ano);
          ADOQueryAux.Next;
        end;
    end;
    ADOQueryAux.Close;
  end;
end;

procedure TFormPagIntru.BotaoGerarClick(Sender: TObject);
var mes, ano, sql : string;
begin
  if (cod_instrutor = '') or (ComboBoxMesAno.Text = '') then
    ShowMessage('Informações inválidas!')
  else
  begin
    mes := copy(ComboBoxMesAno.Text,1,2);
    ano := copy(ComboBoxMesAno.Text,4,4);

    sql := 'SELECT INSTRUTORES.COD_INSTRUTOR, INSTRUTORES.NOME, ' +
           '   AULAS.COD_TURMA, AULAS.DATA, TURMAS.VALOR_AULA  ' +
           '   FROM AULAS '+
           '   INNER JOIN TURMAS ON '+
           '    AULAS.COD_TURMA = TURMAS.COD_TURMA '+
           '   INNER JOIN INSTRUTORES ON '+
           '    TURMAS.COD_INSTRUTOR = INSTRUTORES.COD_INSTRUTOR '+
           '   WHERE TURMAS.COD_INSTRUTOR =' + cod_instrutor +
           '   AND MONTH(DATA) = ' + mes +
           '   AND YEAR(DATA) = ' + ano +
           '   AND AULAS.PAGA = ' + QuotedStr('N') +
           '   ORDER BY TURMAS.COD_TURMA, AULAS.DATA ';

    ADOQueryDemonstrativo.SQL.Text := sql;
    ADOQueryDemonstrativo.Open;

    RvProjectDemonstrativo.ProjectFile := GetCurrentDir + '\Demonstrativo.rav';
    RvProjectDemonstrativo.Execute;

    ADOQueryDemonstrativo.Close;

    if Application.MessageBox('Deseja quitar estas aulas?',
                              'Quitar aulas?',
                              MB_YESNO+MB_ICONQUESTION) = idyes then
    begin
      sql := '  UPDATE AULAS SET AULAS.PAGA =' + QuotedStr('S') +
             '  FROM AULAS ' +
             '  INNER JOIN TURMAS ON ' +
             '    AULAS.COD_TURMA = TURMAS.COD_TURMA ' +
             '  WHERE TURMAS.COD_INSTRUTOR = ' + cod_instrutor;

      FormLogon.ConexaoBD.BeginTrans;
      ADOQueryAux.SQL.Text := sql;
      ADOQueryAux.ExecSQL;
      FormLogon.ConexaoBD.CommitTrans;
      ShowMessage('Aulas quitadas com sucesso!');
      ComboBoxMesAno.Clear;
      EditPag.Clear;
      cod_instrutor := '';
    end;

  end;
end;

procedure TFormPagIntru.BotaoCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
