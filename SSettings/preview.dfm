object PreviewF: TPreviewF
  Left = 238
  Top = 382
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Preview'
  ClientHeight = 187
  ClientWidth = 496
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poOwnerFormCenter
  PrintScale = poNone
  Scaled = False
  DesignSize = (
    496
    187)
  PixelsPerInch = 96
  TextHeight = 13
  object DirectoryListBox1: TDirectoryListBox
    Left = 0
    Top = 18
    Width = 250
    Height = 83
    Align = alCustom
    Anchors = [akLeft, akTop, akBottom]
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 0
    ExplicitHeight = 90
  end
  object DriveComboBox1: TDriveComboBox
    Left = 0
    Top = 0
    Width = 250
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 248
    Top = 0
    Width = 248
    Height = 101
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    BevelOuter = bvSpace
    ItemHeight = 16
    TabOrder = 2
    OnChange = FileListBox1Change
    ExplicitHeight = 108
  end
  object PrevOut: TMemo
    Left = 0
    Top = 101
    Width = 497
    Height = 87
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
