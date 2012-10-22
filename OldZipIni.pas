unit ZipIni;

interface
uses
SysUtils,ZipForge,IniFiles,Registry,Windows,Classes;

var
GlobZip:TZipForge;
GlobIni:TIniFile;

Procedure ZipIniCreateBase (BaseName:string);

Function ZipIniReadString (BaseName,FileName,Section,Ident,Default:string):string;
Function ZipIniReadInteger (BaseName,FileName,Section,Ident:string;Default:Integer):Integer;
Procedure ZipIniWriteString (BaseName,FileName,Section,Ident,Value:string);
Procedure ZipIniWriteInteger (BaseName,FileName,Section,Ident:string;Value:integer);
Procedure ZipIniReadSection (BaseName,FileName,Section: string;var list:TStringList);

implementation

Procedure ZipIniCreateBase (BaseName:string);
Begin
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
 tmp:=GetTmpDir;
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(tmp);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenRead);
 GlobZip.ExtractFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni:=TIniFile.Create(tmp+FileName);
 Result:=GlobIni.ReadString (Section,ident,default);
 GlobIni.Free;
 DeleteFile (pchar(tmp+FileName));
 except
 on e: exception do result:=Default;
 end;
end;

Function ZipIniReadInteger (BaseName,FileName,Section,Ident:string;Default:Integer):integer;
var
tmp:string;
begin
 try
 tmp:=GetTmpDir;
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(Tmp);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenRead);
 GlobZip.ExtractFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni:=TIniFile.Create(Tmp+FileName);
 Result:=GlobIni.ReadInteger (Section,ident,default);
 GlobIni.Free;
 DeleteFile (pchar(tmp+FileName));
 except
 on e: exception do result:=Default;
 end;
end;

Procedure ZipIniWriteString (BaseName,FileName,Section,Ident,Value:string);
begin
 try
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(GetTmpDir);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenReadWrite);
 GlobZip.ExtractFiles (FileName);
 GlobIni:=TIniFile.Create(GetTmpDir+FileName);
 GlobIni.WriteString (Section,ident,Value);
 GlobZip.MoveFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni.Free;
 except
 end;
End;

Procedure ZipIniWriteInteger (BaseName,FileName,Section,Ident:string;Value:integer);
begin
 try
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(GetTmpDir);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenReadWrite);
 GlobZip.ExtractFiles (FileName);
 GlobIni:=TIniFile.Create(GetTmpDir+FileName);
 GlobIni.WriteInteger(Section,ident,Value);
 GlobZip.MoveFiles (FileName);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni.Free;
 except
 end;
End;

Procedure ZipIniReadSection (BaseName,FileName,Section: string;var list:TStringList);
var
tmp:string;
begin
 try
 tmp:=GetTmpDir;
 GlobZip:=TZIpForge.Create(nil);
 GlobZip.BaseDir :=excludetrailingbackslash(Tmp);
 GlobZip.FileName:=BaseName;
 GlobZip.OpenArchive (fmOpenRead);
 GlobZip.ExtractFiles (FileName);
 GlobIni:=TIniFile.Create(Tmp+FileName);
 GlobIni.ReadSection (Section,list);
 GlobZip.CloseArchive;
 GlobZip.Free;
 GlobIni.Free;
 DeleteFile (pchar(tmp+FileName));
 except
 end;
End;


end.



