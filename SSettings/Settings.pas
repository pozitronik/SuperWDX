unit settings;

interface

uses
  Windows, Messages, SysUtils, Controls, Forms, Classes,
  WdxFieldsProc, StdCtrls, IniFiles,dialogs, Shellapi,GSPageControl, 
  Menus,FileCtrl, Grids, Buttons, ComCtrls, StrUtils, ExtCtrls, XPMan, ValEdit;

type
  TSuperSettings = class(TForm)
    GroupBox1: TGroupBox;
    PFLCapt: TLabel;
    PlugList: TListBox;
    PLCapt: TLabel;
    FieldsList: TListBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Close1: TMenuItem;
    Selectpluginfolder1: TMenuItem;
    Rescanpluginsfolder1: TMenuItem;
    About1: TMenuItem;
    Acceptcontentstring1: TMenuItem;
    PopupMenu1: TPopupMenu;
    AddThisFieldtoContentString1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Delete1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Pasteextencioncontentstring1: TMenuItem;
    Deleteextencioncontentstring1: TMenuItem;
    Save1: TMenuItem;
    Plugins1: TMenuItem;
    Language1: TMenuItem;
    Copyextenciondetectstring1: TMenuItem;
    N2: TMenuItem;
    Pasteextencioncontentstring2: TMenuItem;
    SelLNG: TOpenDialog;
    PopupMenu3: TPopupMenu;
    Default1: TMenuItem;
    Directory1: TMenuItem;
    Options1: TMenuItem;
    UseDEFvalues1: TMenuItem;
    Changeextension1: TMenuItem;
    Changeextension2: TMenuItem;
    Showerrorcode1: TMenuItem;
    Replaceemptyfieldvaluestofilename1: TMenuItem;
    ListBoxesPanel: TPanel;
    SplitterBeetwenListBoxes: TSplitter;
    Addcolumn1: TMenuItem;
    Deletecolumn1: TMenuItem;
    XPManifest1: TXPManifest;
    Customview1: TMenuItem;
    EnableCustomView: TMenuItem;
    Localfilename1: TMenuItem;
    Datarequestmode1: TMenuItem;
    None1: TMenuItem;
    Inseparatethreadftdelayed1: TMenuItem;
    OnSPACEBAR1: TMenuItem;
    Help1: TMenuItem;
    Helpfile1: TMenuItem;
    N1: TMenuItem;
    GroupBox2: TGroupBox;
    PageControlContentStrings: TGSPageControl;
    TabSheet1: TTabSheet;
    ContCapt: TLabel;
    ExtCapt: TLabel;
    AcceptBtn: TButton;
    DS: TEdit;
    Ext: TEdit;
    ExtAss: TValueListEditor;
    TopSplit: TSplitter;
    Preview1: TMenuItem;
    Hiddenhotkeys1: TMenuItem;
    NextTab1: TMenuItem;
    PrevTab1: TMenuItem;
    Button1: TButton;
    PM4: TPopupMenu;
    Autosavechanges1: TMenuItem;
    SelDirCombobox: TComboBox;
    AddTab: TTabSheet;
    NewCustomFolderBtn: TButton;
    LabFolder: TLabel;
    Showdirlist1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure AcceptBtnClick(Sender: TObject);
    procedure ExtAssSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PlugListClick(Sender: TObject);
    procedure Rescanpluginsfolder1Click(Sender: TObject);
    procedure FieldsListDblClick(Sender: TObject);
    procedure Selectpluginfolder1Click(Sender: TObject);
    procedure AcceptContentString1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ExtChange(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Deleteextencioncontentstring1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Pasteextencioncontentstring1Click(Sender: TObject);
    procedure Copyextenciondetectstring1Click(Sender: TObject);
    procedure Pasteextencioncontentstring2Click(Sender: TObject);
    procedure Language1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Default1Click(Sender: TObject);
    procedure Directory1Click(Sender: TObject);
    procedure UseDEFvalues1Click(Sender: TObject);
    procedure ExtAssDblClick(Sender: TObject);
    procedure FieldsListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Changeextension1Click(Sender: TObject);
    procedure Changeextension2Click(Sender: TObject);
    procedure Showerrorcode1Click(Sender: TObject);
    procedure Replaceemptyfieldvaluestofilename1Click(Sender: TObject);
    procedure PageControlContentStringsChange(Sender: TObject);
    procedure SplitterBeetwenListBoxesMoved(Sender: TObject);
    procedure Localfilename1Click(Sender: TObject);
    procedure Allowcustomviewfolder1Click(Sender: TObject);
    procedure EnableCustomViewClick(Sender: TObject);
    procedure None1Click(Sender: TObject);
    procedure Inseparatethreadftdelayed1Click(Sender: TObject);
    procedure OnSPACEBAR1Click(Sender: TObject);
    procedure Helpfile1Click(Sender: TObject);
    procedure Preview1Click(Sender: TObject);
    procedure DSChange(Sender: TObject);
    procedure NextTab1Click(Sender: TObject);
    procedure PrevTab1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    Procedure DynamicMenuOnClick (Sender: TObject);
    Procedure GetWdxFieldsToMenu (PlugName:string; var Menu: TPopupMenu);
    Procedure WDXToMenu (var Menu: TPopupmenu);
    procedure NewTabClick(Sender: TObject);
    procedure Autosavechanges1Click(Sender: TObject);
    procedure AddColumnTab;
    Procedure DelColumnTab (TabIndex:Integer=-1;DelPrompt:Boolean=True);
    procedure PageControlContentStringsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AddTabShow(Sender: TObject);
    procedure NewCustomFolderBtnClick(Sender: TObject);
    procedure SelDirComboboxChange(Sender: TObject);
    procedure Showdirlist1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Procedure RecurceScan (dir:String);
    procedure LoadLanguage (LangFile: shortstring);
    Procedure ReadContentStrings(ini:TiniFile);
    procedure AddExtensions(Exts,Content:String);
    procedure RenameIniSection(ini:TIniFile;OldName,NewName:string);
    procedure SaveSettings(ini:TIniFile;index:integer);
    procedure DeleteColumns(ini:TIniFile;index:integer);
  end;

TPluginLanguage=record
  {Controls}
  PLPluginsList:shortstring;
  {dialogs}
  PLDirSelect:shortstring;
  CFDirSelect:string;
  PLCFolder:string;
  PLDeleteContentFor:shortstring;
  PLDeleteConfirm:string;
  PLNewExtReq:string;
  PLNewExtReqCapt:string;
  PLLangSelDialog:string;
  PLChangeExt:string;
  PLChangeExtCapt:string;
  PLColumnCapt:string;
  PLDelColumnConfirm:shortstring;
  PLRenameLocalFileName:shortstring;
  PLRenameLocalFileNamePromt:shortstring;
  end;

var
  SuperSettings: TSuperSettings;
  IniPath:string;
  ini:tinifile;
  WdxDir:string;
  Buf:string;
  LNG:TPluginLanguage;
  PageIndex:integer=1;
  tcdir:string;
  CustomIni:TIniFile;
  CustomViewEnabled:boolean;
  CustomFolderSettingsFileName:string='folder.ini';
  PrevSCF,SCF:String;//selected custom folder
  DRM:byte;//data request mode

implementation

uses About, preview;


{$R *.dfm}
Function GetPluginPath (PluginName:string):string;
Begin
Result:=AnsiReplaceStr(ini.ReadString('Plugins',PluginName,''),'%commander_path%',tcdir);
end;


procedure TSuperSettings.DeleteColumns(ini:TIniFile;index:integer);
var
i:integer;
begin
if (PageControlContentStrings.PageCount=1) then exit;
ini.EraseSection('Column #'+inttostr(index+1));
PageControlContentStrings.Pages[index].Free;
ExtAss.Strings.Clear;
for i:=index to PageControlContentStrings.PageCount-1 do
 begin
 RenameIniSection(ini,'['+PageControlContentStrings.Pages[i].Caption+']','[Column #'+inttostr(i+1)+']');
 PageControlContentStrings.Pages[i].Caption:=LNG.PLColumnCapt+inttostr(i+1);
 end;
end;

procedure TSuperSettings.SaveSettings(ini:TIniFile;index:integer);
var
i:integer;
begin
ini.WriteInteger('Super','CustomColumns',PageControlContentStrings.ComponentCount+1);
for i:=1 to ExtAss.RowCount-1 do
 Begin
 if (ExtAss.Keys [i]<>'') and (ExtAss.Keys[i]<>'DelayMode') then
  begin
  ini.WriteString('Column #'+inttostr(index+1),ExtAss.Keys [i],ExtAss.Values [ExtAss.Keys [i]]);
  end;
 End;
end;

procedure TSuperSettings.RenameIniSection(ini:TIniFile;OldName,NewName:string);
var
strList:TStringList;
k:integer;
begin
strList:=TStringList.Create;
StrList.LoadFromFile(ini.FileName);
k:=StrList.IndexOf(OldName);
if k=-1 then
 begin
 StrList.Free;
 exit;
 end;
StrList[k]:=NewName;
StrList.SaveToFile(ini.FileName);
StrList.Free;
end;


procedure TSuperSettings.AddExtensions(Exts,Content:String);
Function ParseExtension (var extension:string):string;
 Begin
 if pos (';',extension)<> 0 then
  begin
  result:=copy (extension,1,pos(';',extension)-1);
  delete (extension,1,pos(';',extension));
  end else
  begin
  result:=extension;
  extension:='';
  end;
 end;
var
r:integer;
t:string;
begin
if content ='' then exit;
repeat
t:=ParseExtension (exts);
if t='' then
 begin
 exit;// Не надо добавлять поля в которых пустое Ext.
 end;
if ExtAss.FindRow(t,r)
 then ExtAss.Values [t]:=content else ExtAss.InsertRow(t,content,true);
until t='';
end;

procedure TSuperSettings.AddTabShow(Sender: TObject);
begin
PageControlContentStrings.ActivePageIndex:=0;
end;

Procedure TSuperSettings.ReadContentStrings(ini:TiniFile);
var
StrList:TStringList;
i:integer;
ts:string;
begin
PageIndex:=PageControlContentStrings.ActivePageIndex;
StrList:=TStringList.Create;
try
ini.ReadSection('Column #'+inttostr(PageIndex+1),StrList);
drm:=ini.ReadInteger ('Column #'+inttostr(PageIndex+1),'DelayMode',0);
case drm of
 0:None1.Checked :=true;
 1:Inseparatethreadftdelayed1.Checked:=true;
 2:OnSPACEBAR1.checked:=true;
end;
if (StrList.Count<>0) then
 begin
 for i:=0 to strList.Count-1 do
  begin
  ts:='';
  if StrList[i]<>'DelayMode' then ts:=ini.ReadString('Column #'+inttostr(PageIndex+1),StrList[i],'');
  if ts<>'' then ExtAss.InsertRow(StrList.Strings[i],ts,true);
  end;
 end;
finally
 StrList.Free;
end;
end;

procedure TSuperSettings.LoadLanguage (LangFile: shortstring);
 procedure ReadlnEx (var f:textfile;var s:string);
 Begin
 if EOF (f) then
  begin
  s:='-1=Missed string';
  exit;
  end;
 readln (f,s);
 if s[1]=';' then readlnEx (f,s);
 end;
var
f:textfile;
s:string;
z:string;
i:integer;
Begin
  {menus}
  File1.Caption :='File';
  Save1.Caption:='Save';
  Autosavechanges1.Caption:='Autosave changes';
  Language1.Caption:='Language/Язык';
  Close1.Caption:='Exit';
  Edit1.Caption:='Edit';
  Copy1.Caption:='Copy extension content string';

  Pasteextencioncontentstring1.Caption:='Paste extension content string';
  Deleteextencioncontentstring1.Caption:='Delete extension content string';
  Acceptcontentstring1.Caption:='Add/Apply content string';
  Plugins1.Caption:='Plugins';
  Selectpluginfolder1.Caption:='Select plugin folder';
  Rescanpluginsfolder1.Caption:='Rescan plugins folder';
  About1.Caption:='About...';
  AddThisFieldtoContentString1.Caption:='Add field (dblclick)';
  Copyextenciondetectstring1.Caption:='Copy extension content string';
  Pasteextencioncontentstring2.Caption:='Paste extension content string';
  Delete1.Caption:='Delete extension content string';
  Default1.Caption :='Default';
  Directory1.Caption :='Folder';
  Options1.Caption:='Options';
  UseDEFvalues1.Caption :='Can use default values (if <DEF> setted)';
  Changeextension1.Caption :='Change extension';
  Changeextension2.Caption :='Change extension (dblclick)';
  Showerrorcode1.Caption :='Show error code';
  Replaceemptyfieldvaluestofilename1.Caption :='Replace empty field values to file name';
  Addcolumn1.Caption:='Add column';
  Deletecolumn1.Caption :='Delete column';
 // AddColBtn.Caption :='Add column';
 // DeleteColBtn.Caption :='Delete column';
  GroupBox2.Caption :='Column settings';

  Customview1.Caption:='Custom view';
//  Customviewfrom1.Caption:='Custom view from';
//  Allowcustomviewfolder1.Caption := 'None (disabled)';
  EnableCustomView.Caption:='Enable custom view';
//  Localdatabaseonly1.Caption:='Database only';
//  Localdatabaseandlocalfiles1.Caption:='Database and local files';
  Localfilename1.Caption:='Local filename pattern';
//  Compactdatabase1.Caption:='Compact database';

  Datarequestmode1.Caption :='Column data request mode';
  none1.Caption :='As usual';
  Inseparatethreadftdelayed1.Caption :='In separate thread (ft_delayed)';
  OnSPACEBAR1.Caption :='On <SPACEBAR> press (ft_ondemand)';
  Help1.Caption :='Help';
  Helpfile1.Caption :='Help file';
  Preview1.Caption :='Preview';
  PreviewF.Caption:='Preview';

  {Controls}
  GroupBox1.Caption:='WDX-plugins';
  LNG.PLPluginsList:='Plugins list';
  PLCapt.Caption:=LNG.PLPluginsList;
  PFLCapt.Caption:='Plugin fields list';
  ExtCapt.Caption:='Extension:';
  ContCapt.Caption:='Content string:';
  AcceptBtn.Caption:='Add/Apply';
  ExtAss.TitleCaptions [0]:='Ext';
  ExtAss.TitleCaptions [1]:='Content string';
  LNG.PLColumnCapt:='Column #';
  LabFolder.Caption :='Folder:';
  NewCustomFolderBtn.Caption :='Add custom folder';
  {dialogs}
  LNG.PLDirSelect:='Select folder with WDX plugins:';
  LNG.PLDeleteContentFor:='Delete content string for ';
  LNG.PLDeleteConfirm:='Delete confirmation';
  LNG.PLNewExtReq:='Enter new file extension:';
  LNG.PLNewExtReqCapt:='New file extension';
  LNG.PLLangSelDialog:='Select language file';
  LNG.PLChangeExt:='New extension:';
  LNG.PLChangeExtCapt:='Change extension';
  LNG.PLDelColumnConfirm:='Are you really sure that you want to delete column number %x%?';
  LNG.PLCFolder:='Custom folder: ';
  LNG.PLRenameLocalFileName :='Rename custom settings filename pattern';
  LNG.PLRenameLocalFileNamePromt :='Enter new filename pattern';
if not FileExists (LangFile) then exit;
AssignFile (f,LangFile);
reset (f);
while (not eof(f)) do
 begin
 readlnex(f,s);
 try
 i:=strtoint (copy(s,1,pos ('=',s)-1));
 z:=copy (s,pos ('=',s)+1,length (s));
 case i of
  {menus}
  1: File1.Caption :=z;
  2: Save1.Caption:=z;
  3: Language1.Caption:=z;
  4: Close1.Caption:=z;
  5: Edit1.Caption:=z;
  6: begin
     Copy1.Caption:=z;
     Copyextenciondetectstring1.Caption:=z;
     end;
  7: begin
     Pasteextencioncontentstring1.Caption:=z;
     Pasteextencioncontentstring2.Caption:=z;
     end;
  8: begin
     Deleteextencioncontentstring1.Caption:=z;
     Delete1.Caption:=z;
     end;
  9: Acceptcontentstring1.Caption:=z;
  10: Plugins1.Caption:=z;
  11: Selectpluginfolder1.Caption:=z;
  12: Rescanpluginsfolder1.Caption:=z;
  13: About1.Caption:=z;
  14: AddThisFieldtoContentString1.Caption:=z;
  {Controls}
  15: GroupBox1.Caption:=z;
  16: begin
      LNG.PLPluginsList:=z;
      PLCapt.Caption:=LNG.PLPluginsList;
      end;
  17: PFLCapt.Caption:=z;
  18: ExtCapt.Caption:=z;
  19: ContCapt.Caption:=z;
  20: AcceptBtn.Caption:=z;
  21: ExtAss.TitleCaptions [0]:=z;
  22: ExtAss.TitleCaptions [1]:=z;
  {dialogs}
  23: LNG.PLDirSelect:=z;
  24: LNG.PLDeleteContentFor:=z;
  25: LNG.PLDeleteConfirm:=z;
  26: LNG.PLNewExtReq:=z;
  27: LNG.PLNewExtReqCapt:=z;
  28: LNG.PLLangSelDialog:=z;
  29: Default1.Caption :=z;
  30: Directory1.Caption :=z;
  31: Options1.Caption :=z;
  32: UseDEFvalues1.Caption:=z;
  33: LNG.PLChangeExt:=z;
  34: begin
      LNG.PLChangeExtCapt:=z;
      Changeextension1.Caption :=z;
      end;
  35: Changeextension2.Caption :=z;
  36: Showerrorcode1.Caption :=z;
  37: Replaceemptyfieldvaluestofilename1.Caption :=z;
  38: LNG.PLColumnCapt :=z;
  39: begin
      Addcolumn1.Caption:=z;
     // AddColBtn.Caption :=z;
      end;
  40: begin
      Deletecolumn1.Caption :=z;
     // DeleteColBtn.Caption :=z;
      end;
//  41: Allowcustomviewfolder1.Caption := z;
  42: LNG.PLDelColumnConfirm:=z;
  43: LNG.PLCFolder:=Z;
  44: GroupBox2.Caption :=z;
  45: Customview1.Caption:=z;
//  46: Customviewfrom1.Caption:=z;
  47: EnableCustomView.Caption:=z;
//  48: Localdatabaseonly1.Caption:=z;
//  49: Localdatabaseandlocalfiles1.Caption:=z;
  50: Localfilename1.Caption:=z;
//  51: Compactdatabase1.Caption:=z;
  52: LNG.PLRenameLocalFileName:=z;
  53: LNG.PLRenameLocalFileNamePromt:=z;
  54: Datarequestmode1.Caption :=z;
  55: none1.Caption :=z;
  56: Inseparatethreadftdelayed1.Caption :=z;
  57: OnSPACEBAR1.Caption :=z;
  58: Help1.Caption :=z;
  59: Helpfile1.Caption :=z;
  60: Begin
      Preview1.Caption :=z;
      PreviewF.Caption :=z;
      End;
  61: Autosavechanges1.Caption:=z;
  62: LabFolder.Caption :=z;
  63: NewCustomFolderBtn.Caption :=z;
  end;
 except
 end;
 end;
 closefile (f);
 ExtAss.Repaint;
 TabSheet1.Caption :=LNG.PLColumnCapt +'1';
// CheckBoxCusFolder.Caption :=LNG.PLCFolder;
 PLCapt.Caption :=LNG.PLPluginsList +' ('+AnsiReplaceStr(lowercase(WdxDir),tcdir,'%commander_path%')+')';
end;

function SetCustomFolder (FromDir:String=''):string;
var
TempStr:string;
begin
TempStr:=FromDir;
if SelectDirectory(Lng.CFDirSelect,'',tempstr) then
 begin
 result:=IncludeTrailingBackSlash(tempstr);
 end else
 begin
 result:='No_Folder';
 end;
end;

Function GetWdxFolder (caption:string;var res:string):boolean;
var
 TempStr:string;
begin
result:=SelectDirectory(caption,'',TempStr);
if result then res:=TempStr else res:=ini.ReadString('Super','WdxDir','?');
end;

function GetMenuLevel (Item:TMenuItem):Integer;
var
t:TMenuItem;
begin
result:=0;
t:=Item;
while t.Parent.Name <>'' do
 begin
 inc (result);
 t:=t.Parent;
 end;
end;

procedure TSuperSettings.DynamicMenuOnClick(Sender: TObject);
var
PluginName:String;
ItemName, SubItemName:String;
Res:String;
begin
//Получаем от плагина инфу о колонке: какой формат данных она возвращает.
if GetMenuLevel ((Sender as TMenuItem))=1 then
 begin
 PluginName:=(StringReplace ((Sender as TMenuItem).Parent.Caption,'&','',[rfReplaceAll,rfIgnoreCase]));
 ItemName:= (StringReplace ((Sender as TMenuItem).Caption,'&','',[rfReplaceAll,rfIgnoreCase]));
 end else
 if GetMenuLevel ((Sender as TMenuItem))=2 then
 begin
 PluginName:=(StringReplace ((Sender as TMenuItem).Parent.Parent.Caption,'&','',[rfReplaceAll,rfIgnoreCase]));
 ItemName:= (StringReplace ((Sender as TMenuItem).Parent.Caption,'&','',[rfReplaceAll,rfIgnoreCase]));
 SubItemName:='.'+(StringReplace ((Sender as TMenuItem).Caption,'&','',[rfReplaceAll,rfIgnoreCase]));
 end;
// %FieldName.SubFieldName@PluginName%
Res :='%'+ItemName+SubItemName+'@'+PluginName+'.wdx%';
DS.Text:=DS.Text +Res;
end;



Procedure TSuperSettings.GetWdxFieldsToMenu (PlugName:string; var Menu: TPopupMenu);
var
Fields:integer;
FName:string;
UnitVal,TmpFname:string;
FieldType:Integer;
m,n,z:TMenuItem;
i:Integer;
Begin
fields:=-1;
m:=NewItem(ChangeFileExt(ExtractFileName(PlugName),''),0,false,true,nil,0,'plugin_'+IntToStr(i));
FieldType:=-1;
FName:=' ';
while FName<>'' do
begin
 FName:=GetWdxFieldName (PlugName,fields);//получили имя, если в нём есть символ ">", тогда исследуем на наличие юнитов.
 if FName='' then break;

 if pos ('>',Fname)=0 then
  begin
  n:=NewItem(FName,0,false,true,DynamicMenuOnClick,0,'field_'+intToStr(Fields+1));
  n.Tag :=FieldType;
  m.Add (n);
  end else
  begin
  FName:=FName+'|';
  TmpFName:=copy (Fname,1,pos ('>',FName)-1);
  n:=NewItem(copy(FName,1,pos ('>',FName)-1),0,false,true,nil,0,'field_sub_'+intToStr(Fields+1));
  n.Tag :=FieldType;
  Delete (FName,1,pos ('>',FName));
  while length (FName)>0 do
   begin
   UnitVal:=Copy (FName,1,pos ('|',Fname)-1);
   Delete (FName,1,pos ('|',Fname));
   z:= NewItem(UnitVal,0,false,true,DynamicMenuOnCLick,0,'subitem_'+IntToStr(n.Count));
   z.Tag:=FieldType;
   n.Add(z);
   end;
  m.Add(n);
  end;
 inc (Fields);
 FName:='Anti was here'; //Чтобы не выходил раньше срока
end;
Menu.Items.Add (m);
end;

Procedure GetWdxFieldsToList (PlugName:string; StringList:TStrings);
var
Fields:integer;
FName:string;
UnitVal,TmpFname:string;
Begin
fields:=-1;
Repeat
FName:=GetWdxFieldName (PlugName,fields);//получили имя, если в нём есть символ ">", тогда исследуем на наличие юнитов.
if pos ('>',Fname)<>0 then
 begin
 FName:=FName+'|';
 TmpFName:=copy (Fname,1,pos ('>',FName)-1);
 Delete (FName,1,pos ('>',FName));
 while length (FName)>0 do
  begin
  UnitVal:=Copy (FName,1,pos ('|',Fname)-1);
  Delete (FName,1,pos ('|',Fname));
  StringList.Add(TMPFName+'.'+UnitVal);
  end;
 inc (fields);
 FName:='Anti was here'; //Чтобы не выходил раньше срока
 end else
 begin
 inc (fields);
 Application.ProcessMessages;
 if fname<>'' then StringList.Add(FName);
 end;
until fname='';
end;

Procedure TSuperSettings.RecurceScan (dir:String);
var
SRec: TSearchRec;
index:integer;
begin

Dir:=IncludeTrailingBackslash (Dir);
if FindFirst(Dir+'*.wdx', FAAnyFile and not FADirectory, SRec)=0 then
 begin
 index:=PlugList.Items.IndexOf(srec.Name); //Нужно для исключения повторяющихся плагинов и самого плагина
 if (index=-1)and(Srec.Name<>'SUPER_WDX.wdx') then
  begin
  ini.WriteString('Plugins',srec.Name,AnsiReplaceStr(lowercase(dir+srec.Name),tcdir,'%commander_path%'));
  PlugList.Items.Add(srec.Name);
  end;
 Application.ProcessMessages;
 end;
 while FindNext(SRec)=0 do
  begin
  ini.WriteString('Plugins',srec.Name,AnsiReplaceStr(lowercase(dir+srec.Name),tcdir,'%commander_path%'));
  index:=PlugList.Items.IndexOf(srec.Name);
  if (index=-1)and(Srec.Name<>'SUPER_WDX.wdx') then PlugList.Items.Add(srec.Name);
  Application.ProcessMessages;
  end;
 FindFirst(Dir+'*.*', FADirectory, SRec);
 While FindNext(SRec)=0 do
  Begin
  if (SRec.Attr and FADirectory <> 0 ) and (SRec.Name[1]<>'.') then RecurceScan (Dir+SRec.Name);
  End;
 FindClose (Srec);

end;

procedure TSuperSettings.FormCreate(Sender: TObject);
var
Wnd:hWnd;
buff : ARRAY[0.. 127] OF Char;
i:integer;
x:pchar;
tmp:TStringList;
begin
if FindWindow ('TTOTAL_CMD', nil)=0 then
 begin
 MessageBox (Application.Handle,'TC not runned!','TC not runned',MB_ICONINFORMATION);
 Application.Terminate;
 end;      
Wnd := GetWindow(Handle, gw_HWndFirst);
WHILE Wnd <> 0 DO
 BEGIN
 IF (Wnd <> Application.Handle) AND (GetWindow(Wnd, gw_Owner) = 0) THEN
  BEGIN
  GetWindowText (Wnd, buff, sizeof (buff ));
  IF StrPas (buff) = Application.Title THEN Halt;
  END;
 Wnd := GetWindow (Wnd, gw_hWndNext);
END;
GetEnvironmentVariable ('%commander_path%',x,256);
tcdir:=lowercase (x);
PluginPath:=IncludeTrailingBackSlash(extractfilepath (Paramstr(0)));
inipath:=Pluginpath+'super_wdx.ini';
ini:=TIniFile.create (inipath);
WdxDir:=Ini.ReadString('Super','WdxDir','');
WdxDir:=AnsiReplaceStr (WdxDir,'%commander_path%',tcdir);
//добавить проверку на существование папки
LoadLanguage (AnsiReplaceStr (ini.ReadString('Super','Language',''),'%commander_path%',tcdir));
UseDEFvalues1.Checked :=ini.ReadBool('Super','Usedef',false);
Showerrorcode1.Checked :=ini.ReadBool('Super','ShowError',false);
CustomViewEnabled:=ini.Readbool('Super','CustomFoldersView',true);
Debug:=ini.ReadBool('Super','Debug',false);
CustomFolderSettingsFileName:=ini.ReadString('Super','CustomFolderFileName','folder.ini'); 
if CustomViewEnabled then
 begin
 EnableCustomView.Checked:=true;
 end else
 begin
 EnableCustomView.Checked :=false;
// CheckBoxCusFolder.Enabled :=false;
 end;
Replaceemptyfieldvaluestofilename1.Checked:=ini.ReadBool('Super','EmptyReplace',false);
Autosavechanges1.Checked:=ini.ReadBool('Super','AutosaveChanges',true);
for i:=0 to ini.ReadInteger ('Super','CustomColumns',1)-2 do
 begin
 AddColumnTab;
 end;
 ReadContentStrings(ini);
if (WdxDir='') or (WdxDir='?') then
 begin
 if not GetWdxFolder(LNG.PLDirSelect,WdxDir) then Application.Terminate; //Обязательно надо выбрать папку
 end;
RecurceScan (WdxDir);
WDXToMenu (PM4);
if FileExists (Pluginpath+'dirlist.lst') then
 begin
 tmp:=TStringList.Create;
 Tmp.LoadFromFile(Pluginpath+'dirlist.lst');
 for i := 0 to Tmp.Count - 1 do
  begin
  if (Tmp[i]<>'\') and (DirectoryExists (Tmp[i])) then
   begin
   if SelDirComboBox.Items.IndexOf (Tmp[i])=-1 then SelDirComboBox.Items.Add (Tmp[i]);
   end;
  end;
 Tmp.Free;
 SelDirComboBox.Items.SaveToFile (Pluginpath+'dirlist.lst');
 end;
SelDirComboBox.ItemIndex:=0;
SCF:=SelDirCombobox.Text;
//CheckBoxCusFolder.Caption :=LNG.PLCFolder;
end;


procedure TSuperSettings.AcceptBtnClick(Sender: TObject);
begin
Acceptcontentstring1.Click;
if AutosaveChanges1.Checked then Save1.Click;
end;

procedure TSuperSettings.ExtAssSelectCell(Sender: TObject; ACol, ARow: Integer;
var CanSelect: Boolean);
begin
Ext.Text :=ExtAss.Keys [arow];
Ds.Text :=ExtAss.Values [ExtAss.Keys [arow]];
end;

procedure TSuperSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Save1.Click;
ini.Free;
CustomIni.Free;
end;

procedure TSuperSettings.PlugListClick(Sender: TObject);
begin
if PlugList.ItemIndex <0 then exit;

PlugList.Hint :=GetPluginPath(PlugList.Items.Strings[pluglist.ItemIndex]);
FieldsList.Clear;
GetWdxFieldsToList(PlugList.Hint,FieldsList.Items);
end;

procedure TSuperSettings.Rescanpluginsfolder1Click(Sender: TObject);
begin
PlugList.Clear;
RecurceScan (WdxDir);
WDXToMenu (PM4);
end;

procedure TSuperSettings.FieldsListDblClick(Sender: TObject);
begin
if (FieldsList.ItemIndex>-1) and (FieldsList.ItemIndex<FieldsList.Items.Count) then
 begin
 Ds.Text :=Ds.Text +'%'+FieldsList.Items.Strings[FieldsList.ItemIndex]+'@'+PlugList.Items.Strings [pluglist.ItemIndex]+'%';
 if (PreviewF.FileListBox1.FileName<>'') and (PreviewF.Visible) then PreviewF.Prevout.Text :=GetFormattedvalue ('super_wdx.wdx',PreviewF.FileListBox1.FileName,SuperSettings.DS.text);
 end;
end;

procedure TSuperSettings.SelDirComboboxChange(Sender: TObject);
 procedure OptimTabs(ini:TIniFile);
 var
 Am:integer;
 begin
 for Am:=1 to PageControlContentStrings.PageCount-2 do PageControlContentStrings.Pages[PageControlContentStrings.PageCount-2].Free;
 Am:=ini.ReadInteger('Super','CustomColumns',1);
 while PageControlContentStrings.PageCount <Am+1 do AddColumnTab;
 PageControlContentStrings.ActivePageIndex:=0;
 end;
begin
if SCF<>'' then PrevSCF:=SCF;
SCF:=SelDirCombobox.Text;
ExtCapt.Parent :=PageControlContentStrings.pages [0];
ContCapt.Parent :=PageControlContentStrings.Pages [0];
if SCF='\' then //это глобальные настройки
 begin
 if CustomIni<>nil then
  begin
  SaveSettings(CustomIni,PageControlContentStrings.ActivePageIndex);
  CustomIni.Free;
  CustomIni:=nil;
  end;
 ExtAss.Strings.Clear;
 Ext.Clear;
 Ds.Clear;
 OptimTabs(ini);
 ReadContentStrings(Ini);
 end else
 begin //это локальные настройки каталога
 if PrevSCF='\' then SaveSettings(Ini,PageControlContentStrings.ActivePageIndex);
 ExtAss.Strings.Clear;
 Ext.Clear;
 Ds.Clear;
 CustomIni:=TIniFile.Create(scf+CustomFolderSettingsFileName);
 OptimTabs(CustomIni);
 ReadContentStrings(CustomIni);
 end;
PageControlContentStrings.ActivePageIndex:=0;

exit;
if CustomIni=nil then
 begin

 if scf<>'\' then
  begin
  ExtAss.Strings.Clear;
  Ext.Clear;
  Ds.Clear;
  CustomIni:=TIniFile.Create(scf+CustomFolderSettingsFileName);
  OptimTabs(CustomIni);
  ReadContentStrings(CustomIni);
  end else
  begin
  Exit;
  end;
 end else
 begin
 SaveSettings(CustomIni,PageControlContentStrings.ActivePageIndex);
 CustomIni.Free;
 CustomIni:=nil;
 ExtAss.Strings.Clear;
 Ext.Clear;
 Ds.Clear;
 OptimTabs(ini);
 ReadContentStrings(Ini);
 end;
end;

procedure TSuperSettings.Selectpluginfolder1Click(Sender: TObject);
begin
if not GetWdxFolder (LNG.PLDirSelect,WdxDir) then exit;
PLcapt.Caption :=LNG.PLPluginsList +' ('+WdxDir+')';
PlugList.Clear;
SuperSettings.RecurceScan (WdxDir);
WDXToMenu (PM4);
if AutosaveChanges1.Checked then Save1.Click;
end;

procedure TSuperSettings.Acceptcontentstring1Click(Sender: TObject);
begin
AddExtensions(Ext.Text,DS.Text);
end;

procedure TSuperSettings.About1Click(Sender: TObject);
begin
AboutBox.ShowModal;
end;



procedure TSuperSettings.Delete1Click(Sender: TObject);
begin
Deleteextencioncontentstring1.Click;
end;

procedure TSuperSettings.ExtChange(Sender: TObject);
begin
DS.Clear;
end;

procedure TSuperSettings.Close1Click(Sender: TObject);
begin
Close;
end;

procedure TSuperSettings.Deleteextencioncontentstring1Click(
Sender: TObject);
var
ini:TIniFile;
PageIndex:integer;
begin
PageIndex:=PageControlContentStrings.ActivePageIndex;
if ExtAss.Focused and (ExtAss.Keys [ExtAss.row]<>'') then
case MessageBox (application.handle,pchar(LNG.PLDeleteContentFor+' '+ExtAss.Keys [ExtAss.row]+'?'),PAnsiChar(LNG.PLDeleteConfirm),mb_yesno+mb_iconquestion) of
 ID_Yes: Begin
         if CustomIni<>nil then ini:=CustomIni else ini:=Settings.ini;
         ini.DeleteKey('Column #'+inttostr(PageIndex+1),ExtAss.Keys[ExtAss.row]);
         ExtAss.DeleteRow(ExtAss.Row);
         end;
 end
end;

procedure TSuperSettings.Copy1Click(Sender: TObject);
begin
buf:=ExtAss.Values [ExtAss.Keys [ExtAss.row]];
end;

procedure TSuperSettings.Pasteextencioncontentstring1Click(
  Sender: TObject);
begin
AddExtensions(InputBox (Pchar(LNG.PLNewExtReq),Pchar (LNG.PLNewExtReqCapt),''),buf);
end;

procedure TSuperSettings.Copyextenciondetectstring1Click(Sender: TObject);
begin
Copy1.Click;
end;

procedure TSuperSettings.Pasteextencioncontentstring2Click(Sender: TObject);
begin
Pasteextencioncontentstring1.Click;
end;

procedure TSuperSettings.Language1Click(Sender: TObject);
begin
SelLng.Title :=LNG.PLLangSelDialog;
if SelLng.Execute and (SelLng.FileName<>'') then
 begin
 LoadLanguage (SelLng.FileName );
 ini.WriteString('Super','Language',AnsiReplaceStr(LowerCase(SelLng.FileName),tcdir,'%commander_path%'));
 end;
end;

procedure TSuperSettings.Save1Click(Sender: TObject);
begin
ini.WriteString('Super','WdxDir',AnsiReplaceStr (lowercase(WdxDir),tcdir,'%commander_path%'));
ini.WriteBool('Super','CustomFoldersView', CustomViewEnabled);
if CustomIni<>nil then
 begin
 SaveSettings(CustomIni,PageControlContentStrings.ActivePageIndex);
 end else
 begin
 SaveSettings(Ini,PageControlContentStrings.ActivePageIndex);
 end;
end;

procedure TSuperSettings.Default1Click(Sender: TObject);
begin
Ext.Text :='<DEF>';
end;

procedure TSuperSettings.Directory1Click(Sender: TObject);
begin
Ext.Text :='<DIR>';
end;

procedure TSuperSettings.UseDEFvalues1Click(Sender: TObject);
begin
if UseDEFvalues1.Checked then ini.WriteBool('Super','Usedef',True) else ini.WriteBool('Super','Usedef',False)
end;

procedure TSuperSettings.WDXToMenu(var Menu: TPopupmenu);
var
Index:Integer;
begin
Menu.Items.Clear;
for index := 0 to PlugList.Items.Count - 1 do GetWdxFieldsToMenu (GetPluginPath(PlugList.Items[index]),Menu);
end;

procedure TSuperSettings.ExtAssDblClick(Sender: TObject);
var
s,c:string;
r:integer;
begin
r:=0;
if ExtAss.Keys [ExtAss.Row]='' then exit;
s:=InputBox(Pchar(LNG.PLChangeExtCapt),Pchar (LNG.PLChangeExt),'');
if s<>'' then
 begin
 if ExtAss.FindRow (s,r) then //если введённое расширение уже есть, то r - номер строки этого расширения.
  begin
  c:=ExtAss.Values [ExtAss.Keys [ExtAss.Row]];//c - конт.строка для ИЗМЕНЯЕМОГО расширения
  ExtAss.DeleteRow(ExtAss.Row);//удаляем текущую строку
  ExtAss.Values [ExtAss.Keys[r]]:=c;//заменяем контентстроку для имеющегося расширения
  end else
  begin
  ExtAss.Keys [ExtAss.Row]:=s;
  end;
 end;
end;

procedure TSuperSettings.FieldsListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
 VK_RETURN : AddThisFieldtoContentString1.Click;
end;
end;

procedure TSuperSettings.Changeextension1Click(Sender: TObject);
begin
ExtAss.OnDblClick (self);
end;

procedure TSuperSettings.Changeextension2Click(Sender: TObject);
begin
ExtAss.OnDblClick (self);
end;

procedure TSuperSettings.Showdirlist1Click(Sender: TObject);
begin
SelDirComboBox.DroppedDown := not SelDirComboBox.DroppedDown;
SelDirComboBox.SetFocus;
end;

procedure TSuperSettings.Showerrorcode1Click(Sender: TObject);
begin
if Showerrorcode1.Checked then ini.WriteBool('Super','ShowError',True) else ini.WriteBool('Super','ShowError',False)
end;

procedure TSuperSettings.Replaceemptyfieldvaluestofilename1Click(Sender: TObject);
begin
if Replaceemptyfieldvaluestofilename1.Checked then ini.WriteBool('Super','EmptyReplace',True) else ini.WriteBool('Super','EmptyReplace',False)
end;

procedure TSuperSettings.PageControlContentStringsChange(Sender: TObject);
var
ini:TIniFile;
begin
//if PageControlContentStrings.ActivePageIndex =PageControlContentStrings.PageCount -1 then PageControlContentStrings.ActivePageIndex :=0;
ExtCapt.Parent :=PageControlContentStrings.ActivePage;
ContCapt.Parent :=PageControlContentStrings.ActivePage;
Ext.Clear;
Ds.Clear;
if CustomIni<>nil then ini:=CustomIni else ini:=Settings.ini;
SaveSettings(ini,PageIndex);
ExtAss.Strings.Clear;
ReadContentStrings(ini);
end;

procedure TSuperSettings.PageControlContentStringsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
case Button of
 mbLeft:  begin
          if PageControlContentStrings.GetTabFromCursor <> PageControlContentStrings.PageCount-1 then exit;
          AddColumnTab;
          PageControlContentStrings.ActivePageIndex :=PageControlContentStrings.PageCount-2;
          ExtCapt.Parent :=PageControlContentStrings.ActivePage;
          ContCapt.Parent :=PageControlContentStrings.ActivePage;
          end;
 mbMiddle:begin
          DelColumnTab (PageControlContentStrings.GetTabFromCursor,Shift=[ssShift,ssMiddle]);
          end;
end;

end;

procedure TSuperSettings.AddColumnTab;
var
Page:TTabSheet;
begin
Page:=TTabSheet.Create(PageControlContentStrings);
Page.PageControl:=PageControlContentStrings;
Page.Caption:=LNG.PLColumnCapt +inttostr(PageControlContentStrings.PageCount-1);
Page.PageIndex :=PageControlContentStrings.PageCount-2;
end;

procedure TSuperSettings.DelColumnTab(TabIndex: Integer=-1;DelPrompt:Boolean=True);
var
ini:TIniFile;
 procedure ReparseCol (ini:TIniFile;F,T:integer);
  var
  i:integer;
  begin
  for i:=F+2 to T+2 do
   begin
   RenameIniSection (ini,'[Column #'+IntToStr(i)+']','[Column #'+IntToStr(i-1)+']');
   end;
  end;
begin
if TabIndex<>-1 then PageIndex:=TabIndex;

if (PageControlContentStrings.PageCount < 3) or (PageIndex=0) or (PageIndex=PageControlContentStrings.PageCount-1) then exit;
if CustomIni<>nil then ini:=CustomIni else ini:=Settings.ini;
if Not(DelPrompt) then if MessageBox(application.handle,PAnsiChar(AnsiReplaceStr (LNG.PLDelColumnConfirm,'%x%',IntToStr(PageIndex+1))),PAnsiChar(LNG.PLDeleteConfirm),mb_yesno+mb_iconquestion)<>ID_Yes then exit;
 ExtCapt.Parent :=PageControlContentStrings.pages [0];
 ContCapt.Parent :=PageControlContentStrings.Pages [0];
 if (PageIndex<>PageControlContentStrings.ControlCount-1) then
    ReparseCol (ini,PageIndex,PageControlContentStrings.ControlCount-2);
 DeleteColumns(ini,PageIndex);
if PageIndex= PageControlContentStrings.PageCount -1 then PageControlContentStrings.ActivePageIndex :=0;
 Ext.Clear;
 Ds.Clear;
 ReadContentStrings(ini);
 ExtCapt.Parent :=PageControlContentStrings.ActivePage;
 ContCapt.Parent :=PageControlContentStrings.ActivePage;
 PageControlContentStrings.Pages [PageControlContentStrings.PageCount-1].Caption :='+';
end;

procedure TSuperSettings.SplitterBeetwenListBoxesMoved(Sender: TObject);
begin
PFLCapt.Left:=FieldsList.Left;
end;


procedure TSuperSettings.Localfilename1Click(Sender: TObject);
begin
ini.WriteString('Super','CustomFolderFileName',InputBox (LNG.PLRenameLocalFileName,LNG.PLRenameLocalFileNamePromt,ini.ReadString('Super','CustomFolderFileName','folder.ini')));
end;

procedure TSuperSettings.Allowcustomviewfolder1Click(Sender: TObject);
begin
CustomViewEnabled:=false;
end;

procedure TSuperSettings.Autosavechanges1Click(Sender: TObject);
begin
if Autosavechanges1.Checked then ini.WriteBool('Super','AutosaveChanges',True) else ini.WriteBool('Super','AutosaveChanges',False)
end;

procedure TSuperSettings.Button1Click(Sender: TObject);
begin
PM4.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure TSuperSettings.EnableCustomViewClick(Sender: TObject);
begin
CustomViewEnabled:=EnableCustomView.Checked;
if AutosaveChanges1.Checked then Save1.Click;
//CheckBoxCusFolder.Enabled :=EnableCustomView.Checked;
end;

Procedure SaveColumnDataRequestMode (column,reqMode:byte);
var
ini:TIniFile;
Begin
if CustomIni<>nil then ini:=CustomIni else ini:=Settings.ini;
ini.WriteInteger('Column #'+inttostr (column),'DelayMode',ReqMode);
End;

procedure TSuperSettings.None1Click(Sender: TObject);
begin
drm:=0;
SaveColumnDataRequestMode (PageControlContentStrings.ActivePageIndex+1,drm);
if AutosaveChanges1.Checked then Save1.Click;
end;

procedure TSuperSettings.Inseparatethreadftdelayed1Click(Sender: TObject);
begin
drm:=1;
SaveColumnDataRequestMode (PageControlContentStrings.ActivePageIndex+1,drm);
if AutosaveChanges1.Checked then Save1.Click;
end;

{function TSuperSettings.ItemAtPos(TabControlHandle: HWND; X,
  Y: Integer): Integer;
var
HitTestInfo : TTCHitTestInfo;
HitIndex : Integer;
begin
HitTestInfo.pt.x := X;
HitTestInfo.pt.y := Y;
HitTestInfo.flags := 0;
HitIndex := SendMessage(TabControlHandle, TCM_HITTEST, 0, Longint(@HitTestInfo));
Result := HitIndex;
end;              }

procedure TSuperSettings.OnSPACEBAR1Click(Sender: TObject);
begin
drm:=2;
SaveColumnDataRequestMode (PageControlContentStrings.ActivePageIndex+1,drm);
if AutosaveChanges1.Checked then Save1.Click;
end;

procedure TSuperSettings.Helpfile1Click(Sender: TObject);
begin

if fileexists (ExtractFilepath(Application.ExeName)+'super_help.chm') then
 begin
 ShellExecute (application.Handle,'open',pchar(ExtractFilepath(Application.ExeName)+'super_help.chm'),nil,nil,SW_SHOW);
 end else
 begin
 Messagebox (application.handle,'Help file not found','Help',0+mb_iconinformation);
 end;
end;

procedure TSuperSettings.Preview1Click(Sender: TObject);
begin
If PreviewF.Visible then PreviewF.Hide else PreviewF.Show;
end;

procedure TSuperSettings.DSChange(Sender: TObject);
begin
if SuperSettings.Visible=false then exit;
if (PreviewF.Visible) and (PreviewF.FileListBox1.FileName<>'') then PreviewF.Prevout.Text :=GetFormattedvalue ('super_wdx.wdx',PreviewF.FileListBox1.FileName,SuperSettings.DS.text);
end;

procedure TSuperSettings.NewCustomFolderBtnClick(Sender: TObject);
var
SCF:STRING;
begin
scf:=SetCustomFolder (SelDirComboBox.Text);
if scf<>'No_Folder' then
 begin
 if SelDirComboBox.Items.IndexOf (scf)=-1 then SelDirComboBox.Items.Add(scf);
 SelDirComboBox.ItemIndex :=SelDirComboBox.Items.IndexOf (scf);
 SelDirComboBox.Items.SaveToFile(Pluginpath+'dirlist.lst');
 SelDirComboBox.OnChange (self);
 end;
end;

procedure TSuperSettings.NewTabClick(Sender: TObject);
begin
AddColumnTab;
end;

procedure TSuperSettings.NextTab1Click(Sender: TObject);
begin
if PageControlContentStrings.ActivePageIndex+1 =PageControlContentStrings.PageCount -1  then
 begin
 PageControlContentStrings.ActivePageIndex :=0;
 ExtCapt.Parent :=PageControlContentStrings.ActivePage;
 ContCapt.Parent :=PageControlContentStrings.ActivePage;
 exit;
 end;
if (PageControlContentStrings.ControlCount>PageControlContentStrings.TabIndex+1) then PageControlContentStrings.TabIndex :=PageControlContentStrings.TabIndex+1 else
 begin
 PageControlContentStrings.TabIndex:=0;
 end;
 ExtCapt.Parent :=PageControlContentStrings.ActivePage;
ContCapt.Parent :=PageControlContentStrings.ActivePage;
end;

procedure TSuperSettings.PrevTab1Click(Sender: TObject);
begin
if PageControlContentStrings.ActivePageIndex=0 then
 begin
 PageControlContentStrings.ActivePageIndex :=PageControlContentStrings.PageCount-2;
 ExtCapt.Parent :=PageControlContentStrings.ActivePage;
 ContCapt.Parent :=PageControlContentStrings.ActivePage;
 exit;
 end;

if (PageControlContentStrings.TabIndex<>0) then PageControlContentStrings.TabIndex :=PageControlContentStrings.TabIndex-1 else
 begin
 PageControlContentStrings.TabIndex:=PageControlContentStrings.ControlCount-1;
 end;
ExtCapt.Parent :=PageControlContentStrings.ActivePage;
ContCapt.Parent :=PageControlContentStrings.ActivePage;
end;

end.

