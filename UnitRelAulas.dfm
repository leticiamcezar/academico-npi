object FormRelAulas: TFormRelAulas
  Left = 192
  Top = 117
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Aulas por Instrutor'
  ClientHeight = 140
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 38
    Top = 27
    Width = 68
    Height = 13
    Caption = 'INSTRUTOR'
  end
  object EditInstrutor: TEdit
    Left = 38
    Top = 43
    Width = 203
    Height = 21
    Color = clInfoBk
    Enabled = False
    TabOrder = 0
  end
  object BotaoInstrutor: TBitBtn
    Left = 246
    Top = 37
    Width = 27
    Height = 27
    TabOrder = 1
    OnClick = BotaoInstrutorClick
    Glyph.Data = {
      260D0000424D260D000000000000360000002800000030000000170000000100
      180000000000F00C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFD6D1C7C0B8A9C0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9
      AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B8A9E3E0D9FF
      FFFFFFFFFFFFFFFFFFFFFFD6D1C7C0B8A9C0B9AAC0B9AAC0B9AAC0B9AAC0B9AA
      C0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9
      AAC0B8A9E3E0D9FFFFFFFFFFFFFFFFFFFDFCFCB9B1A0DDD9D1E7E4DFE6E3DDE6
      E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE7E4DEE7E4DE
      E7E4DEE7E4DEE8E5E0D8D3C9C0B8A9FFFFFFFFFFFFFFFFFFFDFCFCB9B1A0DDD9
      D1E7E4DFE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6
      E3DDE7E4DEE7E4DEE7E4DEE7E4DEE8E5E0D8D3C9C0B8A9FFFFFFFFFFFFFFFFFF
      FDFDFCB9B1A0F1F0ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFFFFFFFFFFE8E6DFC0B9AAFF
      FFFFFFFFFFFFFFFFFDFDFCB9B1A0F1F0ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFFFFFFFF
      FFE8E6DFC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FAF792DAB895DBBA
      95DBBB91DAB8FEFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEE
      E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3
      FAF792DAB895DBBA95DBBB91DAB8FEFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFF
      FDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFF5FBF896DCBBDDF4E9D7F2E595DBBBFFFFFFE8E4DEC0B9AAFF
      FFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FBF896DCBBDDF4E9D7F2E595DBBBFFFF
      FFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFF
      FFFFDAF2E7FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FBF893DBB9F4FCF8
      ECF9F393DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEE
      E9FFFFFFFFFFFFFFFFFFDAF2E7FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5
      FBF893DBB9F4FCF8ECF9F393DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFF
      FCFCFBB3AA98EDECE7FFFFFFD4F1E32DB97825B67323B6729CDEC0FFFFFFFFFF
      FFFFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFF
      FFFFFFFFFFFFFFFFFCFCFBB3AA98EDECE7FFFFFFD4F1E32DB97825B67323B672
      9CDEC0FFFFFFFFFFFFFFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFF
      FFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FFFFFFFFFFFF2DB9786E
      CFA2F5FBF8A1DFC21EB46F93DBBAFFFFFFFFFFFFFFFFFFF5FBF893DBB9F2FBF7
      EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FFFF
      FFFFFFFF2DB9786ECFA2F5FBF8A1DFC21EB46F93DBBAFFFFFFFFFFFFFFFFFFF5
      FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFF
      C4EBD9C1EBD8C4EBD9A9E2C82CB977F5FBF9FFFFFFFFFFFFACE3CA1EB46F93DB
      BAFFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFF
      FFFFFFFFFFFFFFFFC4EBD9C1EBD8C4EBD9A9E2C82CB977F5FBF9FFFFFFFFFFFF
      ACE3CA1EB46F93DBBAFFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFF
      FFE8E4DEC0B9AAFFFFFFF0FAF531BB7B26B77326B77426B77429B8762AB8768C
      D8B5FFFFFFFFFFFFFFFFFFACE3CA1EB46F98DCBDFFFFFFF5FBF893DBB9F2FBF7
      EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFFF0FAF531BB7B26B77326B77426B7
      7429B8762AB8768CD8B5FFFFFFFFFFFFFFFFFFACE3CA1EB46F98DCBDFFFFFFF5
      FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFF65CB9C55C692
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFCFFFFFFFFFFFFFFFFFFFFFFFFA5E1
      C522B571EEF9F4F9FCFB93DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFF
      FFFF65CB9C55C692FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFCFFFFFFFFFFFF
      FFFFFFFFFFFFA5E1C522B571EEF9F4F9FCFB93DBB9F2FBF7EAF8F193DBB9FFFF
      FFE8E4DEC0B9AAFFFFFF38BD7FBBE8D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF26B774BEE9D5FDFDFD93DBB9F2FBF7
      EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFF38BD7FBBE8D3FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF26B774BEE9D5FD
      FDFD93DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFF65CB9C55C692
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFCFFFFFFFFFFFFFFFFFFFFFFFFA5E1
      C522B571EEF9F4F9FCFB93DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFF
      FFFF65CB9C55C692FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFCFFFFFFFFFFFF
      FFFFFFFFFFFFA5E1C522B571EEF9F4F9FCFB93DBB9F2FBF7EAF8F193DBB9FFFF
      FFE8E4DEC0B9AAFFFFFFF0FAF531BB7B26B77326B77426B77429B8762AB8768B
      D8B5FFFFFFFFFFFFFFFFFFACE3CA1EB46F98DCBDFFFFFFF5FBF893DBB9F2FBF7
      EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFFF0FAF531BB7B26B77326B77426B7
      7429B8762AB8768BD8B5FFFFFFFFFFFFFFFFFFACE3CA1EB46F98DCBDFFFFFFF5
      FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFF
      C4EBD9C1EBD8C4EBD9A9E2C82CB977F5FBF8FFFFFFFFFFFFACE3CA1EB46F93DB
      B9FFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFF
      FFFFFFFFFFFFFFFFC4EBD9C1EBD8C4EBD9A9E2C82CB977F5FBF8FFFFFFFFFFFF
      ACE3CA1EB46F93DBB9FFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFF
      FFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FFFFFFFFFFFF2DB9786F
      CFA2F5FBF9A1DFC21EB46F93DBB9FFFFFFFFFFFFFFFFFFF5FBF893DBB9F2FBF7
      EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FFFF
      FFFFFFFF2DB9786FCFA2F5FBF9A1DFC21EB46F93DBB9FFFFFFFFFFFFFFFFFFF5
      FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFF
      FCFCFBB3AA98EDECE7FFFFFFD4F1E32DB97825B67323B6729CDEBFFFFFFFFFFF
      FFFFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFFFFE8E4DEC0B9AAFF
      FFFFFFFFFFFFFFFFFCFCFBB3AA98EDECE7FFFFFFD4F1E32DB97825B67323B672
      9CDEBFFFFFFFFFFFFFFFFFFFFFFFFFF5FBF893DBB9F2FBF7EAF8F193DBB9FFFF
      FFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFF
      FFFFDAF2E7FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FBF893DBB9F4FCF8
      ECF9F393DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEE
      E9FFFFFFFFFFFFFFFFFFDAF2E7FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5
      FBF893DBB9F4FCF8ECF9F393DBB9FFFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFF
      FDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFF5FBF896DCBBDDF4E9D7F2E595DBBBFFFFFFE8E4DEC0B9AAFF
      FFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FBF896DCBBDDF4E9D7F2E595DBBBFFFF
      FFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEEE9FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FAF792DAB895DBBA
      95DBBB91DAB8FEFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0EFEE
      E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3
      FAF792DAB895DBBA95DBBB91DAB8FEFFFFE8E4DEC0B9AAFFFFFFFFFFFFFFFFFF
      FDFDFCB9B1A0F1F0ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFFFFFFFFFFE8E6DFC0B9AAFF
      FFFFFFFFFFFFFFFFFDFDFCB9B1A0F1F0ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFFFFFFFF
      FFE8E6DFC0B9AAFFFFFFFFFFFFFFFFFFFDFDFCB9B1A0DDD9D1E7E4DFE6E3DDE6
      E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE7E4DEE7E4DE
      E7E4DEE7E4DEE8E5E0D8D3C9C0B8A9FFFFFFFFFFFFFFFFFFFDFDFCB9B1A0DDD9
      D1E7E4DFE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6E3DDE6
      E3DDE7E4DEE7E4DEE7E4DEE7E4DEE8E5E0D8D3C9C0B8A9FFFFFFFFFFFFFFFFFF
      FFFFFFD6D1C7C0B8A9C0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9
      AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B8A9E3E0D9FF
      FFFFFFFFFFFFFFFFFFFFFFD6D1C7C0B8A9C0B9AAC0B9AAC0B9AAC0B9AAC0B9AA
      C0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9AAC0B9
      AAC0B8A9E3E0D9FFFFFF}
    NumGlyphs = 2
  end
  object BotaoOK: TBitBtn
    Left = 49
    Top = 74
    Width = 100
    Height = 38
    Caption = 'OK'
    ModalResult = 4
    TabOrder = 2
    OnClick = BotaoOKClick
    Glyph.Data = {
      A2070000424DA207000000000000360000002800000019000000190000000100
      1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2EAC9BDCF83A4BC5495B23990AE
      2F95B239A4BC54BDCF83E2EAC9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDDAA289A92386A7
      1D8BAB278EAD2C90AE2F90AE3090AE2F8EAD2C8BAB2786A71D89A923CDDAA2FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFCFD
      FB94B13887A71E8FAE2E91AF3191AF3191AF3191AF3191AF3191AF3191AF3191
      AF3191AF318FAE2E87A71E94B138FCFDFBFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFFF3F6E985A61A8DAC2A91AF3191AF3191AF3191AF3191AF3191
      AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF318DAC2A85A61AF3F6E9
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFCFDFA85A61A8FAD2D91AF3191AF3191
      AF3191AF3191AF3190AE3091AF3191AF3191AF3191AF3191AF3191AF3191AF31
      91AF3191AF318FAD2D85A61AFCFDFBFFFFFFFFFFFF00FFFFFFFFFFFF94B1388D
      AC2A91AF3191AF3191AF3191AF3191AF318FAE2E87A71E8BAB2791AF3191AF31
      91AF3191AF3191AF3191AF3191AF3191AF3191AF318DAC2A95B138FFFFFFFFFF
      FF00FFFFFFCDDAA187A71E91AF3191AF3191AF3191AF3191AF318FAD2D86A71E
      FFFFFFB5C97686A71D91AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF
      3191AF3187A71ECDDAA2FFFFFF00FFFFFF89A9228FAE2E91AF3191AF3191AF31
      91AF318FAD2D86A71DF8FAF3FFFFFFFFFFFFB3C77186A71D91AF3191AF3191AF
      3191AF3191AF3191AF3191AF3191AF318FAE2E89A923FFFFFF00E2EAC986A71E
      91AF3191AF3191AF3191AF318FAD2D86A71DF8FAF3FFFFFFFFFFFFFFFFFFFFFF
      FFB3C77186A71D91AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3186
      A71DE2EAC900BDCE838BAB2791AF3191AF3191AF318FAD2D86A71DF8FAF3FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB3C77186A71D91AF3191AF3191AF3191
      AF3191AF3191AF3191AF318BAB27BDCF8300A4BC548EAD2C91AF3191AF318FAD
      2D86A71DF8FAF3FFFFFFFFFFFFFFFFFF85A61AC7D696FFFFFFFFFFFFFFFFFFB3
      C77186A71D91AF3191AF3191AF3191AF3191AF3191AF318EAD2CA4BC540095B2
      3990AE2F91AF3190AE2F8FAD2DFDFDFBFFFFFFFFFFFFFFFFFF8CAB298DAC2A83
      A417C8D799FFFFFFFFFFFFFFFFFFB3C77186A71D91AF3191AF3191AF3191AF31
      91AF3190AE2F95B2390090AE2F90AE3091AF3190AE308AAA24E8EED5FFFFFFFF
      FFFF8CAC298DAC2A91AF3190AE3083A417C8D799FFFFFFFFFFFFFFFFFFB3C771
      86A71D91AF3191AF3191AF3191AF3190AE3090AE2F0095B23890AE2F91AF3191
      AF3190AE2F83A517DFE7C391AE318DAC2A91AF3191AF3191AF3190AE3083A417
      C8D799FFFFFFFFFFFFFFFFFFB3C77186A71D91AF3191AF3191AF3190AE2F95B2
      3900A4BC548EAD2C91AF3191AF3191AF3190AE3089A9228FAD2D91AF3191AF31
      91AF3191AF3191AF3190AE3083A417C8D799FFFFFFFFFFFFFFFFFFB3C8728AAA
      2591AF3191AF318EAD2CA4BC5400BDCE838BAB2791AF3191AF3191AF3191AF31
      91AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3190AE3083A417C8D7
      99FFFFFFFFFFFFFFFFFF8FAD2D90AE2F91AF318BAB27BDCF8300E2EAC986A71E
      91AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF
      3191AF3191AF3190AE3083A417C9D89AFFFFFF9DB8488CAB2991AF3191AF3186
      A71DE2EAC900FFFFFF89A9228FAE2E91AF3191AF3191AF3191AF3191AF3191AF
      3191AF3191AF3191AF3191AF3191AF3191AF3191AF3190AE3088A82196B23A8C
      AB2891AF3191AF318FAE2E89A923FFFFFF00FFFFFFCDDAA187A71E91AF3191AF
      3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191
      AF3191AF3190AF308FAD2E91AF3191AF3191AF3187A71ECDDAA1FFFFFF00FFFF
      FFFFFFFF94B1378DAC2A91AF3191AF3191AF3191AF3191AF3191AF3191AF3191
      AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF318DAC2A
      94B138FFFFFFFFFFFF00FFFFFFFFFFFFFCFDFA85A61A8FAD2D91AF3191AF3191
      AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF31
      91AF3191AF318FAD2D85A61AFCFDFAFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFF3
      F6E985A61A8DAC2A91AF3191AF3191AF3191AF3191AF3191AF3191AF3191AF31
      91AF3191AF3191AF3191AF3191AF318DAC2A85A61AF3F6E9FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFFCFDFA94B13887A71E8FAE2E91AF3191AF31
      91AF3191AF3191AF3191AF3191AF3191AF3191AF318FAE2E87A71E94B138FCFD
      FBFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      CDDAA189A92286A71E8BAB278EAD2C90AE2F90AE3090AE2F8EAD2C8BAB2786A7
      1E89A922CDDAA2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E9C8BCCF83A3BC5495B23890AE
      2F95B238A3BC54BCCF83E2E9C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00}
  end
  object BotaoFechar: TBitBtn
    Left = 158
    Top = 74
    Width = 100
    Height = 38
    Caption = 'FECHAR'
    TabOrder = 3
    OnClick = BotaoFecharClick
    Glyph.Data = {
      A2070000424DA207000000000000360000002800000019000000190000000100
      1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACAF08686DE5858D23D3DCB3434
      C83D3DCB5858D28686DECACAF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4E62828C52323
      C42C2CC63131C73434C83535C83434C83131C72C2CC62323C42828C5A4A4E6FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFBFB
      FD3D3DCA2424C43333C83636C93636C93636C93636C93636C93636C93636C936
      36C93636C93333C82424C43D3DCBFBFBFEFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFFE9E9F92020C33030C73636C93636C93636C93636C93636C936
      36C93636C93636C93636C93636C93636C93636C93636C93030C72020C3E9E9F9
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFBFBFD2020C33232C83636C93232C82C
      2CC63636C93636C93636C93636C93636C93636C93636C93636C93636C92C2CC6
      3232C83636C93232C82020C3FBFBFEFFFFFFFFFFFF00FFFFFFFFFFFF3D3DCA30
      30C73636C92F2FC73C3CCA8888DF2222C33636C93636C93636C93636C93636C9
      3636C93636C92121C38C8CE03E3ECB2F2FC73636C93030C73D3DCAFFFFFFFFFF
      FF00FFFFFFA4A4E62424C43636C93232C83B3BCAFFFFFFFFFFFF8282DD2020C3
      3636C93636C93636C93636C93636C92020C38787DEFFFFFFFFFFFF3E3ECB3232
      C83636C92424C4A4A4E6FFFFFF00FFFFFF2828C53434C83636C92C2CC69090E1
      FFFFFFFFFFFFFFFFFF8484DD2020C33636C93636C93636C92020C38787DEFFFF
      FFFFFFFFFFFFFF8D8DE02C2CC63636C93333C82828C5FFFFFF00CACAF02323C4
      3636C93636C93636C92020C38D8DE0FFFFFFFFFFFFFFFFFF8585DE2020C33636
      C92020C38787DEFFFFFFFFFFFFFFFFFF8787DE2121C33636C93636C93636C923
      23C4CACAF0008686DE2C2CC63636C93636C93636C93636C91F1FC28C8CE0FFFF
      FFFFFFFFFFFFFF8686DE0F0FBE8787DEFFFFFFFFFFFFFFFFFF8787DE2020C336
      36C93636C93636C93636C92C2CC68686DE005858D23131C73636C93636C93636
      C93636C93636C91F1FC28D8DE0FFFFFFFFFFFFFFFFFFB8B8ECFFFFFFFFFFFFFF
      FFFF8787DE2020C33636C93636C93636C93636C93636C93131C75858D2003D3D
      CB3434C83636C93636C93636C93636C93636C93636C91F1FC28C8CE0FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF8787DE2020C33636C93636C93636C93636C93636C9
      3636C93434C83D3DCB003434C83535C83636C93636C93636C93636C93636C936
      36C93636C90D0DBEBEBEEDFFFFFFFFFFFFFFFFFFB8B8EC0F0FBE3636C93636C9
      3636C93636C93636C93636C93636C93535C83434C8003D3DCB3434C83636C936
      36C93636C93636C93636C93636C91F1FC28B8BE0FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF8686DE2020C33636C93636C93636C93636C93636C93636C93434C83D3D
      CB005858D23131C73636C93636C93636C93636C93636C91F1FC28A8ADFFFFFFF
      FFFFFFFFFFFFB9B9ECFFFFFFFFFFFFFFFFFF8585DE2020C33636C93636C93636
      C93636C93636C93131C75858D2008686DE2C2CC63636C93636C93636C93636C9
      1F1FC38989DFFFFFFFFFFFFFFFFFFF8787DE0E0EBE8888DFFFFFFFFFFFFFFFFF
      FF8484DD2020C33636C93636C93636C93636C92C2CC68686DE00CACAF02323C4
      3636C93636C93636C92121C38888DFFFFFFFFFFFFFFFFFFF8787DE2020C33636
      C91F1FC38989DFFFFFFFFFFFFFFFFFFF8383DD2222C33636C93636C93636C923
      23C4CACAF000FFFFFF2828C53434C83636C92C2CC68B8BDFFFFFFFFFFFFFFFFF
      FF8787DE2020C33636C93636C93636C91F1FC28A8ADFFFFFFFFFFFFFFFFFFF88
      88DF2C2CC63636C93333C82828C5FFFFFF00FFFFFFA4A4E62424C43636C93333
      C83939CAFFFFFFFFFFFF8787DE2020C33636C93636C93636C93636C93636C91F
      1FC28B8BE0FFFFFFFFFFFF3C3CCA3232C83636C92424C4A4A4E6FFFFFF00FFFF
      FFFFFFFF3C3CCA3030C73636C93030C73939C98B8BE02121C33636C93636C936
      36C93636C93636C93636C93636C92020C39090E13B3BCA2F2FC73636C93030C7
      3D3DCAFFFFFFFFFFFF00FFFFFFFFFFFFFAFAFD2020C33232C83636C93333C82C
      2CC63636C93636C93636C93636C93636C93636C93636C93636C93636C92C2CC6
      3232C83636C93232C82020C3FAFAFDFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFE9
      E9F92020C33030C73636C93636C93636C93636C93636C93636C93636C93636C9
      3636C93636C93636C93636C93636C93030C72020C3E9E9F9FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFFAFAFD3C3CCA2424C43434C83636C93636C9
      3636C93636C93636C93636C93636C93636C93636C93333C82424C43C3CCAFBFB
      FDFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      A4A4E62828C52323C42C2CC63131C73434C83535C83434C83131C72C2CC62323
      C42828C5A4A4E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACAF08686DE5858D23D3DCB3434
      C83D3DCB5858D28686DECACAF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00}
  end
  object ADOQueryRelAulas: TADOQuery
    Connection = FormLogon.ConexaoBD
    CursorType = ctStatic
    Parameters = <>
    Left = 138
    Top = 8
  end
  object ADOQueryAux: TADOQuery
    Connection = FormLogon.ConexaoBD
    Parameters = <>
    Left = 170
    Top = 8
  end
  object RelAulas: TRvProject
    Left = 12
    Top = 80
  end
  object RvDataSetAulas: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = ADOQueryRelAulas
    Left = 267
    Top = 80
  end
end
