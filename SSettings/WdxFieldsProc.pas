unit WdxFieldsProc;
//���� ��� ������� Super_WDX

interface
uses
StdCtrls,Windows,SysUtils,ContPlug,Classes;

type
  TContentGetSupportedField = function(FieldIndex: integer; FieldName: pchar;
    Units: pchar; maxlen: integer): integer; stdcall;
  TContentGetValue = function(FileName: pchar; FieldIndex, UnitIndex: integer;
    FieldValue: pbyte; maxlen, flags: integer): integer; stdcall;
  TContentSetDefaultParams = procedure(dps: pContentDefaultParamStruct); stdcall;
  TContentGetFormattedValue = function (FileName,ContentString : pchar;FieldValue:pchar;MaxLen:Integer):integer; stdcall;

Function GetWdxFieldName (const fPlugin:string; FieldNum:integer):string;
function GetWdxField(const fPlugin, fFile: string; FieldNumber:integer): string;
Function GetWdxFieldNum (const fPlugin:string; FieldName:string):integer;
Function GetFormattedValue (PluginName,FileName,ContentString:string):string;
Procedure DebugLog (LogMessage:string);//������ ����� �� ������

var
   PluginPath:String;// - ����� ���������� - ���� � �������, ���� �� ���������� ��� ������ ���, ����� ����� � ������
   Debug:boolean;

Implementation

Procedure DebugLog (LogMessage:string);//������ ����� �� ������
var
f:textfile;
Begin
if not debug then exit;
if not fileexists (IncludeTrailingBackSlash(extractfilepath (PluginPath))+'DebugLog.txt') then
 begin
 AssignFile (f,IncludeTrailingBackSlash(extractfilepath (PluginPath))+'DebugLog.txt');
 rewrite (f);
 closefile (f);
 end;
AssignFile (f,IncludeTrailingBackSlash(extractfilepath (PluginPath))+'DebugLog.txt');
Append (f);
Writeln (f,datetostr (now)+'-'+timetostr(now)+': '+LogMessage);
closefile (f);
end;

function WdxFieldType(n: integer): string;
begin
  case n of
    FT_NUMERIC_32:              Result:= 'FT_NUMERIC_32';
    FT_NUMERIC_64:              Result:= 'FT_NUMERIC_64';
    FT_NUMERIC_FLOATING:        Result:= 'FT_NUMERIC_FLOATING';
    FT_DATE:                    Result:= 'FT_DATE';
    FT_TIME:                    Result:= 'FT_TIME';
    FT_DATETIME:                Result:= 'FT_DATETIME';
    FT_BOOLEAN:                 Result:= 'FT_BOOLEAN';
    FT_MULTIPLECHOICE:          Result:= 'FT_MULTIPLECHOICE';
    FT_STRING:                  Result:= 'FT_STRING';
    FT_FULLTEXT:                Result:= 'FT_FULLTEXT';
    FT_NOSUCHFIELD:             Result:= 'FT_NOSUCHFIELD';
    FT_FILEERROR:               Result:= 'FT_FILEERROR';
    FT_FIELDEMPTY:              Result:= 'FT_FIELDEMPTY';
    FT_DELAYED:                 Result:= 'FT_DELAYED';
    else Result:= '?';
  end;
end;


//-----------------------------------------------
var

  fieldsNum: integer;


Function LoadPlugin (PluginName:pchar):hWnd;
Begin
 result:=GetModuleHandle(PluginName);// ��� ������� � �������� ���� ������������ ������ � ��������. 
 if result=0 then //���� �� ���������
   result:=LoadLibrary(PluginName);
end;

{-------function not used in wdx plugin, only in ssettings---------------------}
//�� ������ ���� ������� ����� �������� ����.
Function GetWdxFieldName (const fPlugin:string; FieldNum:integer):string;
var
hLib: THandle;
Proc1: TContentGetSupportedField;
Proc2: TContentGetValue;
Proc3: TContentSetDefaultParams;
dps: TContentDefaultParamStruct;
buf1, buf2: array[0..2*1024] of char;
res: integer;
Begin
result:='';
hLib:= LoadPlugin(PChar(fPlugin));//�������� ����� ����������
if hLib=0 then Exit; //�������� �� ����������. � ������ ���� �� �������� if (hLib=0) or (hLib=INVALID_HANDLE_VALUE, �� �� �����. ������: ��� �� ����� ������� �����-���� �������� ��� �������������� ��������, ���� ������ ��� �������������� ������ ��������� (������ ��������� ����� ������)

  @Proc3:= GetProcAddress(hLib, 'ContentSetDefaultParams');
  if @Proc3<>nil then
    begin
    FillChar(dps, SizeOf(dps), 0);
    dps.Size:= SizeOf(dps);
    dps.PluginInterfaceVersionLow:= 30;
    dps.PluginInterfaceVersionHi:= 1;
    lstrcpy(dps.DefaultIniName, Pchar(IncludeTrailingBackSlash(extractfilepath (PluginPath))+'Plugins.ini'));
    Proc3(@dps);
    end;

@Proc1:= GetProcAddress(hLib, 'ContentGetSupportedField');//�������� ����� ��������� ContentGetSupportedField �� �������
if @Proc1=nil then begin FreeLibrary(hLib); Exit end; //�� ����� ���, ���� ����� � �� �������.
try
 FillChar(buf1, SizeOf(buf1), 0); //��������� ������ ������
 FillChar(buf2, SizeOf(buf2), 0);
 res:= Proc1(fieldNum+1, buf1, buf2, SizeOf(buf1));//�������� ContentGetSupportedField, ��������� ����.
//res - ��� ���� (��. ������� �� ��������� ��������), buf1 - �������� fieldNum+1 ���� �������.
 if res=ft_nomorefields then //���� ��� ft_nomorefields - ������ ���� �� ����������.
  begin
  result:='';
  end;
 result:=buf1;
 if buf2[0]<>#0 then
  begin
  result:=result+'>';
  result:=result+buf2;
  end;
finally
// FreeLibrary(hLib); - �� ����� (���������� �� �����������, ����� �������� ��������� ������ ��������).
 end;

End;

//���������, �������� ���������� - �� ����� ���� ���������� ��� �����
//���������, �������� ���������� - �� ����� ���� ���������� ��� �����
Function GetWdxFieldNum (const fPlugin:string; FieldName:string):integer;
var
hLib: THandle;
Proc1: TContentGetSupportedField;
Proc2: TContentGetValue;
buf1, buf2: array[0..2*1024] of char;
res: integer;
begin
result:=-1;
hlib:=LoadPlugin (pchar (fPlugin));//�������� �������
if hLib=0 then Exit;

@Proc1:= GetProcAddress(hLib, 'ContentGetSupportedField');
if @Proc1=nil then begin FreeLibrary(hLib); Exit end;
 fieldsNum:= -1;
 repeat
 FillChar(buf1, SizeOf(buf1), 0);
 FillChar(buf2, SizeOf(buf2), 0);
 res:= Proc1(fieldsNum+1, buf1, buf2, SizeOf(buf1));//�������� �� ���� ����� �������, ���� ��������� �� ����� ft_nomorefields (��� ��������� ������������) ��� �� ����� ������� ������ ����. ����� �� ������� ����� while, �� �������������
 if res=ft_nomorefields then Break;//����� �� �����
 Inc(fieldsNum);
 if copy(buf1,1,length(FieldName))=(FieldName) then//��������� ��� ���������� ���������� ���� � ������ ��������
  begin
  result:=FieldsNum+1;//���� ������� - ���������� ��������� (+1 ������ ��� ��������� � ����� �� 1 ������)
  break;//������� �� �����
  end;
 until false;
END;

//�� ����� ������� fPlugin ����� �������� ���� FieldNumber ��� ����� fFile.
function GetWdxField(const fPlugin, fFile: string; FieldNumber:integer): string;
var
  hLib: THandle;
  Proc1: TContentGetSupportedField;
  Proc2: TContentGetValue;
  Proc3: TContentSetDefaultParams;
  dps: TContentDefaultParamStruct;
  buf1, buf2: array[0..2*1024] of char;
  fnval: integer absolute buf1;
  fnval64: Int64 absolute buf1;
  ffval: Double absolute buf1;
  fdate: TDateFormat absolute buf1;
  ftime: TTimeFormat absolute buf1;
  xtime: TFileTime absolute buf1;
  stime: TSystemTime;
  sval: string;
  res: integer;
begin
Result:= '';
hlib:=LoadPlugin (pchar (fPlugin));//�������� ����� �������
if hLib=0 then Exit;
//��� ������ ContentSetDefaultParams ���������� �����
  @Proc3:= GetProcAddress(hLib, 'ContentSetDefaultParams');
  if @Proc3<>nil then
    begin
    FillChar(dps, SizeOf(dps), 0);
    dps.Size:= SizeOf(dps);
    dps.PluginInterfaceVersionLow:= 30;
    dps.PluginInterfaceVersionHi:= 1;
    lstrcpy(dps.DefaultIniName, Pchar(IncludeTrailingBackSlash(extractfilepath (PluginPath))+'Plugins.ini'));
    Proc3(@dps);
    end;

@Proc2:= GetProcAddress(hLib, 'ContentGetValue');//�������� ����� ��������� ContentGetValue �� �������.
if @Proc2=nil then begin FreeLibrary(hLib); Exit end;

try
 FieldsNum:=FieldNumber;
 FillChar(buf1, SizeOf(buf1), 0);
 FillChar(buf2, SizeOf(buf2), 0);
 res:= Proc2(PChar(fFile), FieldNumber-1, 0, @buf1, SizeOf(buf1), 0);//�������� ContentGetValue, ������� ��� �����, ����� ����, UnitIndex ��� �� ���������� - ����� 0, ����� � ������ ������ ��� ������������� ����������. Res - ��� ����
 sval:= '';
 case res of//�� ���� ���� ����������� ���������� �������� � String.
   ft_fieldempty:          sval:= '';
   ft_numeric_32:          sval:= IntToStr(fnval);
   ft_numeric_64:          sval:= IntToStr(fnval64);
   ft_numeric_floating:    sval:= FloatToStr(ffval);
   ft_date:                sval:= Format('%2.2d.%2.2d.%4.4d', [fdate.wDay, fdate.wMonth, fdate.wYear]);
   ft_time:                sval:= Format('%2.2d:%2.2d:%2.2d', [ftime.wHour, ftime.wMinute, ftime.wSecond]);

   ft_datetime:            begin
                           FileTimeToSystemTime(xtime, stime);
                           sval:= Format('%2.2d.%2.2d.%4.4d %2.2d:%2.2d:%2.2d',
                                   [stime.wDay, stime.wMonth, stime.wYear,
                                    stime.wHour, stime.wMinute, stime.wSecond]);
                           end;

   ft_boolean:             if fnval=0 then sval:= 'FALSE' else sval:= 'TRUE';
   ft_string,
   ft_multiplechoice,
   ft_fulltext:            sval:= buf1;
   else
     sval:= WdxFieldType(res);//���� ��� ���� ��������� - ���������� � ���������� �������� ����.
 end;
 result:=sval;
Except
 on e:Exception do
 begin
 result:='ERROR!'; //���� ��������� ������ � ����� try ���������� ������.
 end;
end;
END;

Function GetFormattedValue (PluginName,FileName,ContentString:string):string;
var
  hLib: THandle;
  GFV: TContentGetFormattedValue;
  res:array [0..2*1024] of char;
begin
Result:= '';
hlib:=LoadPlugin (pchar (PluginName));//�������� ����� �������
if hLib=0 then Exit;
@GFV:= GetProcAddress(hLib, 'GetFormattedValue');
if @GFV<>nil then
 begin
 FillChar(res, SizeOf(res), 0);
 if GFV (Pchar(FileName),PChar(ContentString),@res,sizeof (res))=1 then result:=res else result:='Can''t get value';
 end;
End;


end.



//That`s all.