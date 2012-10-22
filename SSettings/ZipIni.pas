unit ZipIni;

interface
uses
SysUtils,ZipForge,IniFiles,Registry,Windows,Classes,StrUtils,WdxFieldsProc;

var
GlobZip:TZipForge;
GlobIni:TIniFile;

Procedure ZipIniCreateBase (BaseName:string);

Function ZipIniReadString (BaseName,FileName,Section,Ident,Default:string):string;
Function ZipIniReadInteger (BaseName,FileName,Section,Ident:string;Default:Integer):Integer;
Procedure ZipIniWriteString (BaseName,FileName,Section,Ident,Value:string);
Procedure ZipIniWriteInteger (BaseName,FileName,Section,Ident:string;Value:integer);
Procedure ZipIniReadSection (BaseName,FileName,Section: string;var list:TStringList);
procedure ZipiniCompactDataBase (BaseName:string);

implementation

Procedure ZipIniCreateBase (BaseName:string);
Begin
DebugLog ('Try to create zipped database: '+basename);
GlobZip:=TZIpForge.Create(nil);
GlobZip.FileName :=basename;
GlobZip.OpenArchive (fmCreate);
GlobZip.CloseArchive;
GlobZip.Free;
End;

Function ZipIniReadString (BaseName,FileName,Section,Ident,Default:string):string;
var
tmp:string;
begin
 try
 DebugLog ('Try to read string value from zipped database '
 +'BaseName: '+basename+#10
 +'FileName: '+Filename+#10
 +'Section: ' +Section+#10
 +'Ident: '+ Ident);
 tmp:=PluginPath;
 GlobZip:=TZIpForge.Create(nil);
// GlobZip.InMemory :=true;
 GlobZip.BaseDir :=excludetrailingbackslash(tmp);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenRead);
 GlobZip.ExtractFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni:=TIniFile.Create(tmp+FileName);
 DebugLog ('Tmp: '+ tmp+FileName);
 Result:=GlobIni.ReadString (Section,ident,default);
 GlobIni.Free;
 DeleteFile (pchar(tmp+FileName));
 DebugLog ('Gotcha: '+ result);
 except
 on e: exception do
  begin
  DebugLog ('Failed string value reading, default returned: '+Default);
  result:=Default;
  end;
 end;
end;

Function ZipIniReadInteger (BaseName,FileName,Section,Ident:string;Default:Integer):integer;
var
tmp:string;
begin
 try
  DebugLog ('Try to read integer value from zipped database '
 +'BaseName: '+basename+#10
 +'FileName: '+Filename+#10
 +'Section: ' +Section+#10
 +'Ident: '+ Ident);
 tmp:=PluginPath;
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(Tmp);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenRead);
 GlobZip.ExtractFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni:=TIniFile.Create(Tmp+FileName);
 DebugLog ('Tmp: '+ tmp+FileName);
 Result:=GlobIni.ReadInteger (Section,ident,default);
 GlobIni.Free;
 DeleteFile (pchar(tmp+FileName));
 DebugLog ('Gotcha: '+ IntToStr(result));
 except
 on e: exception do
  begin
  DebugLog ('Failed string value reading, default returned: '+inttostr(Default));
  result:=Default;
  end;
 end;
end;

Procedure ZipIniWriteString (BaseName,FileName,Section,Ident,Value:string);
begin
 try
  DebugLog ('Try to write string value to zipped database '
 +'BaseName: '+basename+#10
 +'FileName: '+Filename+#10
 +'Section: ' +Section+#10
 +'Ident: '+ Ident+#10
 +'Value: '+Value);
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(PluginPath);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenReadWrite);
 GlobZip.ExtractFiles (FileName);
 GlobIni:=TIniFile.Create(pluginPath+FileName);
 DebugLog ('Tmp: '+ PluginPath+FileName);
 GlobIni.WriteString (Section,ident,Value);
 GlobZip.MoveFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni.Free;
 DebugLog ('Okay');
 except
 on E: exception do
  begin
  DebugLog ('Write failed. May be you have not access rights to write in '+PluginPath);
  end;
 end;
End;

Procedure ZipIniWriteInteger (BaseName,FileName,Section,Ident:string;Value:integer);
begin
 try
 DebugLog ('Try to write string value to zipped database '
 +'BaseName: '+basename+#10
 +'FileName: '+Filename+#10
 +'Section: ' +Section+#10
 +'Ident: '+ Ident+#10
 +'Value: '+IntToStr(Value));
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(PluginPath);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenReadWrite);
 GlobZip.ExtractFiles (FileName);
 GlobIni:=TIniFile.Create(PluginPath+FileName);
 DebugLog ('Tmp: '+ Pluginpath+FileName);
 GlobIni.WriteInteger(Section,ident,Value);
 GlobZip.MoveFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni.Free;
 DebugLog ('Okay');
 except
 on E: exception do
  begin
  DebugLog ('Write failed. May be you have not access rights to write in '+PluginPath);
  end;
 end;
End;

Procedure ZipIniReadSection (BaseName,FileName,Section: string;var list:TStringList);
begin
 try
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(pluginpath);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenRead);
 GlobZip.ExtractFiles (FileName);
 GlobIni:=TIniFile.Create(Pluginpath+FileName);
 GlobIni.ReadSection (Section,list);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni.Free;
 DeleteFile (pchar(Pluginpath+FileName));
 except
 end;
End;

procedure ZipiniCompactDataBase (BaseName:string);
var

ArchiveItem:TZFArchiveItem;
TName:String;
begin
 try
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.FileName :=basename;
 GlobZip.BaseDir :=excludetrailingbackslash(Pluginpath);
 GlobZip.OpenArchive (fmOpenReadWrite);
 if GlobZip.FindFirst('*.*',ArchiveItem,faAnyFile) then
  begin
  repeat
  TName:=AnsiReplaceStr (ArchiveItem.FileName,'¦','\');
  TName [2]:=':';
  TName:=ExtractFilepath (tname);
  If not DirectoryExists (tname) then
   begin
   GlobZip.DeleteFiles(ArchiveItem.FileName);
   end;
  until (not GlobZip.FindNext (ArchiveItem));
  end;
 except
 end;
End;

end.



