library Super_wdx;
uses
SysUtils,ContPlug,inifiles,windows,Classes,Messages,
WdxFieldsProc, StrUtils;

{$R *.res}
{$E wdx}

const
max_path=259;

var
x:pchar;
IniPath:string;
ini:tinifile;
tcdir:string;
basepath:string;

Function GetPluginPath (PluginName:string):string;
Begin
Result:=AnsiReplaceStr(ini.ReadString('Plugins',PluginName,''),'%commander_path%',tcdir);
end;
//------------------------------------------------------------------------------
function GetFormattedString (ConString:string;filename:string):string;
var
res:string;
i:integer;
FieldNum,UnitNum{,UnitType}:byte;
bufmode,fieldmode,dotmode,PlugMode:boolean;//close/open
plugin,field,dot:string;
unformatted_symbols:integer;//counter of symbols not in %bla@bla.wdx%
begin
try
unformatted_symbols:=0;
bufmode:=false;
fieldmode:=false;
plugin:='';
field:='';
for i:=1 to length (ConString) do
 begin
 if ConString[i]='%' then
  begin
  bufmode:=not bufmode;
  if bufmode and not fieldmode then FieldMode:=True;
  end;
 if BufMode and FieldMode and not PlugMode and (ConString[i]='.') then DotMode:=True;
 if BufMode and FieldMode and (ConString[i]='@') then
  Begin
  FieldMode:=False;
  DotMode:=False;
  PlugMode:=True;
  end;
 {-----------------------------------------------------------------------------}
 if fieldmode and not dotmode then field:=field+ConString[i];
 if fieldmode and     dotmode then dot:=dot+ConString[i];
 if plugmode then plugin:=plugin+ConString[i];
 if (not bufmode) and (ConString[i]<>'%') then
  begin
  res:=res+ConString[i];
  inc (unformatted_symbols);
  end;
 {-----------------------------------------------------------------------------}
 if (not BufMode) and (ConString[i]='%') then
  begin
  BufMode:=False; //ALL MODES MUST BE FALSE
  PlugMode:=False;
  delete (plugin,1,1);
  delete (plugin,Length(plugin),1);
  delete (field,1,1);
  if length (dot)>1 then delete (dot,1,1);
  if (lowercase(plugin)='super_wdx.wdx') or (lowercase(field)='super_column') then
   begin
   DebugLog ('Hmmmm... Don`t try use super_wdx in super_wdx, it cause to errors.'+#10+#13+'Ну ёпт, было же сказано - не используйте super_wdx в нём самом, это чревато.');
   res:=''
   end else
   begin
   Plugin:=GetPluginPath(plugin);
   FieldNum:=GetWdxFieldNum(plugin,field, dot, UnitNum);
   res:=res+GetWdxField (plugin, filename, FieldNum ,UnitNum);
   plugin:='';
   field:='';
   dot:='';
   end;
  end;
 end;
if (length (res)<=unformatted_symbols) and EmptyReplace then
 begin
 result:=ExtractFileName (FileName);
 end else
 begin
 result:=res;
 end;
except
on e: exception do
 begin
 DebugLog ('Some malfunction in procedure GetFormattedString.'+#10+#13+
 'Непонятки в GetFormattedString.'+#10+#13+
 'Variable values:'+#10+#13+
 'ConString: '+ConString+#10+#13+
 'res: '+res+#10+#13+
 'plugin: '+plugin+#10+#13+
 'field: '+field);
 result:='ERROR!';
 end;
end;
end;
//------------------------------------------------------------------------------
Function GetColumnValue (Filename:string;ColumnNum,Flags:byte):string;
 Function IsDir (Path:ShortString):boolean;
 begin
 result:=false;
 if DirectoryExists (Path) then result:=true;
 end;
var
ContentString:string;
fileext:string;
CustomIni:TIniFile;
ColumnDelay:Byte;
begin
if IsDir (FileName) then fileext :='.<DIR>' else fileext:=ExtractFileExt (Filename);
if fileext='' then
 begin
 if IsDir (FileName) then
  begin
  Fileext:='.<DIR>'
  end else
  begin
  result:='';
  exit;
 end;
end;
delete (fileext,1,1);
ini:=tinifile.Create(inipath);

ShowError:=ini.ReadBool('Super','ShowError',false);
Debug:=ini.ReadBool('Super','Debug',false);
EmptyReplace:=ini.ReadBool('Super','EmptyReplace',false);
CustomFoldersView:=ini.ReadInteger ('Super','CustomFoldersView',0);
CustomFolderFileName:=ini.ReadString('Super','CustomFolderFileName','folder.ini');
ColumnDelay:=Ini.ReadInteger('Column #'+IntToStr(ColumnNum),'DelayMode',0);

case CustomFoldersView of
 1: begin
    if Fileexists(IncludeTrailingbackSlash(ExtractFilePath (FileName))+CustomFolderFileName) then
     begin
     CustomIni:=TIniFile.Create(IncludeTrailingbackSlash(ExtractFilePath (FileName))+CustomFolderFileName);
     ColumnDelay:=CustomIni.ReadInteger('Column #'+IntToStr(ColumnNum),'DelayMode',0);
     CustomIni.Free;
     end else ColumnDelay:=Ini.ReadInteger('Column #'+IntToStr(ColumnNum),'DelayMode',0);
    end;
 2: begin
    //NO MORE SUPPORTED
    END;
 3: begin
    //NO MORE SUPPORTED
    end;
end;

if (flags=CONTENT_DELAYIFSLOW) and (ColumnDelay<>0) then
 begin
  case ColumnDelay of
  1: Begin
     result:='ft_delayed';
     ini.Free;
     exit;
     end;
  2: Begin
     result:='ft_ondemand';
     ini.Free;
     exit;
     end;
  end;
  end else

case CustomFoldersView of
 1: BEGIN
    if Fileexists(IncludeTrailingbackSlash(ExtractFilePath (FileName))+CustomFolderFileName) then
     begin
     CustomIni:=TIniFile.Create(IncludeTrailingbackSlash(ExtractFilePath (FileName))+CustomFolderFileName);
     ContentString:=CustomIni.ReadString('Column #'+IntToStr(ColumnNum),FileExt,'');
     if (ContentString='') and (ini.ReadBool('Super','Usedef',false)) then
      begin
      ContentString:=CustomIni.ReadString('Column #'+IntToStr(ColumnNum),'<DEF>','');
      end;
      CustomIni.Free;
     end else ContentString:=ini.ReadString('Column #'+IntToStr(ColumnNum),FileExt,'');
    END;
 2: BEGIN
    //NO MORE SUPPORTED
    END;
 3: BEGIN
    //NO MORE SUPPORTED
    END;
 else ContentString:=ini.ReadString('Column #'+IntToStr(ColumnNum),FileExt,'');
end; //case

if ContentString ='' then ContentString:=ini.ReadString('Column #'+IntToStr(ColumnNum),FileExt,'');
if (ContentString ='') then
 begin
 if (ini.ReadBool('Super','Usedef',false)) then
  begin
  ContentString:=ini.ReadString('Column #'+IntToStr(ColumnNum),'<DEF>','');
  if ContentString='' then
   begin
   result:='';
   ini.Free;
   exit;
   end;
  end else
  begin
  result:='';
  ini.Free;
  exit;
  end;
 end;
result:=GetFormattedString (ContentString,FileName);
ini.Free;
end;
//------------------------------------------------------------------------------
function ContentGetSupportedField(FieldIndex:integer;FieldName:pchar;Units:pchar;maxlen:integer):integer; stdcall;
var
ini:tinifile;
NOfCol:byte;
Begin
ini:=tinifile.Create(inipath);
NOfCol:=ini.ReadInteger('SUPER','CustomColumns',3);
if NOfCol>10 then NOfCol:=10;
Units[0]:=#0;
if NOfCol>FieldIndex then
 begin
 Strlcopy (FieldName,Pchar('SUPER_COLUMN #'+IntToStr(FieldIndex+1)),maxlen-1);
 result:=ft_string;
 end else result:=0;
 ini.Free;
End;
{------------------------------------------------------------------------------}
//Начиная с версии 1.5 поддерживается Custom Columns View
function ContentGetValue(FileName:pchar;FieldIndex,UnitIndex:integer;FieldValue:pbyte;maxlen,flags:integer):integer; stdcall;
var
z:pchar;
Begin
  //fillchar (fieldvalue,sizeof(fieldvalue),0);
  //pchar(fieldvalue)[1]:=#0;
try
 z:=pchar(GetColumnValue (Filename,FieldIndex+1,Flags));
 Strlcopy (pchar (Fieldvalue),z,maxlen-1);
 result:=ft_string;
 if pchar(fieldvalue)='ft_delayed' then
  begin
  fillchar (fieldvalue,sizeof(fieldvalue),0);
  result:=ft_delayed;
  exit;
  end;

 if pchar(fieldvalue)='ft_ondemand' then
  begin
  fillchar (fieldvalue,sizeof(fieldvalue),0);
  result:=ft_ondemand;
  exit;
  end;
except
 end;
End;

//начиная с версии 2.1 поддерживается функция GetFormattedValue
function GetFormattedValue (FileName,ContentString:pchar;FieldValue:pchar;MaxLen:Integer):integer; stdcall;
Begin
result:=0;
ini:=TIniFile.Create (inipath);
try
StrlCopy (FieldValue,pchar (GetFormattedString (ContentString,Filename)),maxlen-1);
result:=1;
finally ini.Free;
end;
End;
exports
       ContentGetSupportedField,
       ContentGetValue,
       GetFormattedValue;

begin
GetMem (x,max_path);
GetModuleFilename (hInstance,x,max_path);
PluginPath:=x;
inipath:=(IncludeTrailingBackSlash(extractfilepath (PluginPath))+'super_wdx.ini');
tcdir:=lowercase(GetEnvironmentVariable ('commander_path'));
basepath:=(IncludeTrailingBackSlash(extractfilepath (PluginPath))+'dirdata.zip');
ini:=TIniFile.Create(inipath);
ini.Free;
end.