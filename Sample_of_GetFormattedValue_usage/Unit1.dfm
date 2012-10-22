object Form1: TForm1
  Left = 192
  Top = 106
  AutoSize = True
  BorderStyle = bsToolWindow
  Caption = 'Sample of GetFormattedValue usage'
  ClientHeight = 231
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FileListBox1: TFileListBox
    Left = 145
    Top = 0
    Width = 145
    Height = 121
    ItemHeight = 13
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 0
    Top = 20
    Width = 145
    Height = 100
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 1
  end
  object DriveComboBox1: TDriveComboBox
    Left = 0
    Top = 0
    Width = 145
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 2
  end
  object PrevOut: TMemo
    Left = 0
    Top = 140
    Width = 289
    Height = 91
    Lines.Strings = (
      'Results here')
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 0
    Top = 120
    Width = 237
    Height = 21
    TabOrder = 4
    Text = 'Type here content string'
  end
  object Button1: TButton
    Left = 238
    Top = 119
    Width = 51
    Height = 22
    Caption = 'Show'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 290
    Top = 0
    Width = 221
    Height = 231
    Lines.Strings = (
      'It is just sample of GetFormattedValue '
      'function execution.'
      ''
      'Type content string (in Super Setting format '
      'style, %name@filesys.wdx% as sample) in '
      'editbox, select file in filelist, and press '
      '"Show" button.'
      ''
      'SampleApp.exe must be in same folder, '
      'where Super_wdx.wdx plugin.'
      ''
      'And see source code for understanding')
    ReadOnly = True
    TabOrder = 6
  end
end
