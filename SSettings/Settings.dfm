object SuperSettings: TSuperSettings
  Left = 178
  Top = 124
  Caption = 'Super settings'
  ClientHeight = 402
  ClientWidth = 666
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 520
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TopSplit: TSplitter
    Left = 0
    Top = 129
    Width = 666
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    MinSize = 10
    ExplicitTop = 201
    ExplicitWidth = 729
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 666
    Height = 129
    Align = alTop
    Caption = 'WDX-plugins'
    TabOrder = 0
    DesignSize = (
      666
      129)
    object PLCapt: TLabel
      Left = 8
      Top = 16
      Width = 49
      Height = 13
      Caption = 'Plugins list'
    end
    object PFLCapt: TLabel
      Left = 363
      Top = 16
      Width = 71
      Height = 13
      Caption = 'Plugin fields list'
    end
    object ListBoxesPanel: TPanel
      Left = 1
      Top = 32
      Width = 665
      Height = 96
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object SplitterBeetwenListBoxes: TSplitter
        Left = 360
        Top = 2
        Height = 92
        MinSize = 1
        ResizeStyle = rsUpdate
        OnMoved = SplitterBeetwenListBoxesMoved
        ExplicitHeight = 165
      end
      object PlugList: TListBox
        Left = 2
        Top = 2
        Width = 358
        Height = 92
        Align = alLeft
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = PlugListClick
      end
      object FieldsList: TListBox
        Left = 363
        Top = 2
        Width = 300
        Height = 92
        Align = alClient
        ItemHeight = 13
        PopupMenu = PopupMenu1
        TabOrder = 1
        OnDblClick = FieldsListDblClick
        OnKeyDown = FieldsListKeyDown
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 134
    Width = 666
    Height = 268
    Align = alClient
    Caption = 'Column settings'
    TabOrder = 1
    ExplicitHeight = 274
    DesignSize = (
      666
      268)
    object LabFolder: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Folder:'
    end
    object PageControlContentStrings: TGSPageControl
      Left = 2
      Top = 35
      Width = 662
      Height = 232
      ActivePage = TabSheet1
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      OnChange = PageControlContentStringsChange
      OnMouseDown = PageControlContentStringsMouseDown
      ExplicitHeight = 238
      object TabSheet1: TTabSheet
        Caption = 'Column '#8470'1'
        ExplicitHeight = 210
        object ContCapt: TLabel
          Left = 136
          Top = 0
          Width = 68
          Height = 13
          Caption = 'Content string:'
        end
        object ExtCapt: TLabel
          Left = 0
          Top = 0
          Width = 49
          Height = 13
          Caption = 'Extension:'
        end
      end
      object AddTab: TTabSheet
        Caption = '+'
        ImageIndex = 1
        OnShow = AddTabShow
      end
    end
    object AcceptBtn: TButton
      Left = 585
      Top = 76
      Width = 76
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'Add/Apply'
      TabOrder = 3
      OnClick = AcceptBtnClick
    end
    object DS: TEdit
      Left = 141
      Top = 76
      Width = 418
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      OnChange = DSChange
    end
    object Ext: TEdit
      Left = 3
      Top = 76
      Width = 136
      Height = 21
      PopupMenu = PopupMenu3
      TabOrder = 1
      OnChange = ExtChange
    end
    object ExtAss: TValueListEditor
      Left = 2
      Top = 97
      Width = 660
      Height = 167
      Anchors = [akLeft, akTop, akRight, akBottom]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
      PopupMenu = PopupMenu2
      Strings.Strings = (
        '=')
      TabOrder = 4
      TitleCaptions.Strings = (
        'Ext'
        'Content String')
      OnDblClick = ExtAssDblClick
      OnSelectCell = ExtAssSelectCell
      ExplicitHeight = 173
      ColWidths = (
        136
        518)
    end
    object Button1: TButton
      Left = 562
      Top = 76
      Width = 20
      Height = 20
      Anchors = [akTop, akRight]
      Caption = '+'
      TabOrder = 5
      OnClick = Button1Click
    end
    object SelDirCombobox: TComboBox
      Left = 61
      Top = 13
      Width = 498
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      ItemIndex = 0
      Sorted = True
      TabOrder = 6
      Text = '\'
      OnChange = SelDirComboboxChange
      Items.Strings = (
        '\')
    end
    object NewCustomFolderBtn: TButton
      Left = 562
      Top = 13
      Width = 98
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Add custom folder'
      TabOrder = 7
      OnClick = NewCustomFolderBtnClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 128
    object File1: TMenuItem
      Caption = 'File'
      object Close1: TMenuItem
        Caption = 'Close'
        ShortCut = 32883
        OnClick = Close1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Copy1: TMenuItem
        Caption = 'Copy extension detect string'
        ShortCut = 16451
        OnClick = Copy1Click
      end
      object Pasteextencioncontentstring1: TMenuItem
        Caption = 'Paste extension content string'
        ShortCut = 16470
        OnClick = Pasteextencioncontentstring1Click
      end
      object Deleteextencioncontentstring1: TMenuItem
        Caption = 'Delete extension content string'
        OnClick = Deleteextencioncontentstring1Click
      end
      object Changeextension1: TMenuItem
        Caption = 'Change extension'
        ShortCut = 113
        OnClick = Changeextension1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Acceptcontentstring1: TMenuItem
        Caption = 'Add/Apply content string'
        ShortCut = 32781
        OnClick = Acceptcontentstring1Click
      end
      object Addcolumn1: TMenuItem
        Caption = 'Add column'
        ShortCut = 16429
      end
      object Deletecolumn1: TMenuItem
        Caption = 'Delete column'
        ShortCut = 16430
      end
    end
    object Options1: TMenuItem
      Caption = 'Options'
      object Language1: TMenuItem
        Caption = 'Language/'#1071#1079#1099#1082
        ShortCut = 16460
        OnClick = Language1Click
      end
      object UseDEFvalues1: TMenuItem
        AutoCheck = True
        Caption = 'Can use default values'
        Checked = True
        OnClick = UseDEFvalues1Click
      end
      object Showerrorcode1: TMenuItem
        AutoCheck = True
        Caption = 'Show error code'
        OnClick = Showerrorcode1Click
      end
      object Replaceemptyfieldvaluestofilename1: TMenuItem
        AutoCheck = True
        Caption = 'Replace empty field values to file name'
        OnClick = Replaceemptyfieldvaluestofilename1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object Autosavechanges1: TMenuItem
        AutoCheck = True
        Caption = 'Autosave changes'
        OnClick = Autosavechanges1Click
      end
    end
    object Datarequestmode1: TMenuItem
      Caption = 'Column data request mode'
      object None1: TMenuItem
        AutoCheck = True
        Caption = 'As usual'
        Checked = True
        GroupIndex = 4
        RadioItem = True
        OnClick = None1Click
      end
      object Inseparatethreadftdelayed1: TMenuItem
        AutoCheck = True
        Caption = 'In separate thread (ft_delayed)'
        GroupIndex = 4
        RadioItem = True
        OnClick = Inseparatethreadftdelayed1Click
      end
      object OnSPACEBAR1: TMenuItem
        AutoCheck = True
        Caption = 'On <SPACEBAR> press (ft_ondemand)'
        GroupIndex = 4
        RadioItem = True
        OnClick = OnSPACEBAR1Click
      end
    end
    object Customview1: TMenuItem
      Caption = 'Custom view'
      object EnableCustomView: TMenuItem
        AutoCheck = True
        Caption = 'Local files only'
        GroupIndex = 1
        OnClick = EnableCustomViewClick
      end
      object Localfilename1: TMenuItem
        Caption = 'Local filename pattern'
        GroupIndex = 1
        OnClick = Localfilename1Click
      end
    end
    object Plugins1: TMenuItem
      Caption = 'Plugins'
      object Selectpluginfolder1: TMenuItem
        Caption = 'Select plugin folder'
        ShortCut = 32851
        OnClick = Selectpluginfolder1Click
      end
      object Rescanpluginsfolder1: TMenuItem
        Caption = 'Rescan plugins folder'
        ShortCut = 32850
        OnClick = Rescanpluginsfolder1Click
      end
    end
    object Preview1: TMenuItem
      Caption = 'Preview'
      ShortCut = 32848
      OnClick = Preview1Click
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Helpfile1: TMenuItem
        Caption = 'Help file'
        ShortCut = 112
        OnClick = Helpfile1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = 'About'
        ShortCut = 16463
        OnClick = About1Click
      end
    end
    object Hiddenhotkeys1: TMenuItem
      Caption = 'Hidden hotkeys'
      Visible = False
      object NextTab1: TMenuItem
        Caption = 'Next Tab'
        ShortCut = 16393
        OnClick = NextTab1Click
      end
      object PrevTab1: TMenuItem
        Caption = 'Prev Tab'
        ShortCut = 24585
        OnClick = PrevTab1Click
      end
      object Showdirlist1: TMenuItem
        Caption = 'Show dirlist'
        ShortCut = 115
        OnClick = Showdirlist1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 192
    object AddThisFieldtoContentString1: TMenuItem
      Caption = 'Add field (dblclick)'
      OnClick = FieldsListDblClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 80
    Top = 104
    object Copyextenciondetectstring1: TMenuItem
      Caption = 'Copy extencion detect string'
      ShortCut = 16451
      OnClick = Copyextenciondetectstring1Click
    end
    object Pasteextencioncontentstring2: TMenuItem
      Caption = 'Paste extencion content string'
      ShortCut = 16470
      OnClick = Pasteextencioncontentstring2Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete extension'
      ShortCut = 46
      OnClick = Delete1Click
    end
    object Changeextension2: TMenuItem
      Caption = 'Change extension (dblclick)'
      ShortCut = 113
      OnClick = Changeextension2Click
    end
  end
  object SelLNG: TOpenDialog
    Filter = '*.lng|*.lng'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 160
  end
  object PopupMenu3: TPopupMenu
    Left = 112
    Top = 104
    object Default1: TMenuItem
      Caption = 'Default'
      OnClick = Default1Click
    end
    object Directory1: TMenuItem
      Caption = 'Folder'
      OnClick = Directory1Click
    end
  end
  object XPManifest1: TXPManifest
    Left = 224
  end
  object PM4: TPopupMenu
    Left = 144
    Top = 104
  end
end
