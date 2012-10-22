object AboutBox: TAboutBox
  Left = 368
  Top = 298
  ActiveControl = OKButton
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 242
  ClientWidth = 346
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 346
    Height = 242
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 249
    object ProductName: TLabel
      Left = 6
      Top = 4
      Width = 221
      Height = 13
      Caption = 'Settings utility for SUPER_WDX content plugin'
      IsControl = True
    end
    object Version: TLabel
      Left = 3
      Top = 56
      Width = 340
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Version/'#1042#1077#1088#1089#1080#1103': 2.3b (26.12.08)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Copyright: TLabel
      Left = 8
      Top = 80
      Width = 136
      Height = 13
      Caption = 'Deverlopers/'#1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1080':'
      IsControl = True
    end
    object Label1: TLabel
      Left = 6
      Top = 25
      Width = 318
      Height = 13
      Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1076#1083#1103' '#1082#1086#1085#1090#1077#1085#1090#1085#1086#1075#1086' '#1087#1083#1072#1075#1080#1085#1072' SUPER_WDX'
      IsControl = True
    end
    object Label2: TLabel
      Left = 144
      Top = 96
      Width = 126
      Height = 13
      Caption = 'Pavel Dubrovsky aka D1P'
      IsControl = True
    end
    object Label3: TLabel
      Left = 144
      Top = 116
      Width = 126
      Height = 13
      Caption = 'Vorotilin Dmitry aka Genius'
      IsControl = True
    end
    object Label4: TLabel
      Left = 8
      Top = 136
      Width = 133
      Height = 13
      Caption = 'Thanks to/'#1041#1083#1072#1075#1086#1076#1072#1088#1085#1086#1089#1090#1080':'
      IsControl = True
    end
    object Label5: TLabel
      Left = 144
      Top = 150
      Width = 75
      Height = 13
      Caption = 'Christian Ghisler'
    end
    object Label6: TLabel
      Left = 144
      Top = 165
      Width = 130
      Height = 13
      Caption = 'Andrey Pyasetsky aka Ergo'
    end
    object Label7: TLabel
      Left = 144
      Top = 180
      Width = 29
      Height = 13
      Caption = 'Alextp'
    end
    object Label8: TLabel
      Left = 144
      Top = 195
      Width = 31
      Height = 13
      Caption = 'Zhang'
    end
    object Label9: TLabel
      Left = 144
      Top = 210
      Width = 38
      Height = 13
      Caption = 'Xcaliber'
    end
    object Label10: TLabel
      Left = 144
      Top = 224
      Width = 45
      Height = 13
      Caption = 'Raymond'
    end
  end
  object OKButton: TButton
    Left = 273
    Top = 212
    Width = 65
    Height = 26
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKButtonClick
    IsControl = True
  end
end
