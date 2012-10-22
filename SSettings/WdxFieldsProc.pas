unit WdxFieldsProc;
//Юнит для плагина Super_WDX

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
Procedure DebugLog (LogMessage:string);//создаёт отчёт об ошибке

var
   PluginPath:String;// - общая переменная - путь к плагину, чтоб не передавать его каждый раз, пущай висит в памяти
   Debug:boolean;

Implementation

Procedure DebugLog (LogMessage:string);//создаёт отчёт об ошибке
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
 result:=GetModuleHandle(PluginName);// Эта функция и заменяет весь динамический массив с хэндлами. 
 if result=0 then //если не загружена
   result:=LoadLibrary(PluginName);
end;

{-------function not used in wdx plugin, only in ssettings---------------------}
//по номеру поля плагина выдаёт название поля.
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
hLib:= LoadPlugin(PChar(fPlugin));//получаем хендл библиотеки
if hLib=0 then Exit; //загрузка не получилась. В идеале надо бы написать if (hLib=0) or (hLib=INVALID_HANDLE_VALUE, ну да ладно. Дальше: тут же можно сделать какое-либо действие при несостоявшейся загрузки, хотя сейчас это обрабатывается вполне корректно (просто результат будет пустым)

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

@Proc1:= GetProcAddress(hLib, 'ContentGetSupportedField');//получаем адрес процедуры ContentGetSupportedField из плагина
if @Proc1=nil then begin FreeLibrary(hLib); Exit end; //да будет так, хотя можно и по другому.
try
 FillChar(buf1, SizeOf(buf1), 0); //заполняем буфера нулями
 FillChar(buf2, SizeOf(buf2), 0);
 res:= Proc1(fieldNum+1, buf1, buf2, SizeOf(buf1));//вызываем ContentGetSupportedField, параметры ясны.
//res - тип поля (см. справку по написанию плагинов), buf1 - название fieldNum+1 поля плагина.
 if res=ft_nomorefields then //если тип ft_nomorefields - такого поля не существует.
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
// FreeLibrary(hLib); - не нужно (библиотеки не выгружаются, чтобы избежать повторной долгой загрузки).
 end;

End;

//Процедура, обратная предыдущей - по имени поля возвращает его номер
//Процедура, обратная предыдущей - по имени поля возвращает его номер
Function GetWdxFieldNum (const fPlugin:string; FieldName:string):integer;
var
hLib: THandle;
Proc1: TContentGetSupportedField;
Proc2: TContentGetValue;
buf1, buf2: array[0..2*1024] of char;
res: integer;
begin
result:=-1;
hlib:=LoadPlugin (pchar (fPlugin));//загрузка плагина
if hLib=0 then Exit;

@Proc1:= GetProcAddress(hLib, 'ContentGetSupportedField');
if @Proc1=nil then begin FreeLibrary(hLib); Exit end;
 fieldsNum:= -1;
 repeat
 FillChar(buf1, SizeOf(buf1), 0);
 FillChar(buf2, SizeOf(buf2), 0);
 res:= Proc1(fieldsNum+1, buf1, buf2, SizeOf(buf1));//проходим по всем полям плагина, пока процедура не вернёт ft_nomorefields (что исключает зацикливание) или не будет найдено нужное поле. Можно бы сделать через while, но несущественно
 if res=ft_nomorefields then Break;//выход из цикла
 Inc(fieldsNum);
 if copy(buf1,1,length(FieldName))=(FieldName) then//проверяем имя очередного найденного поля с именем искомого
  begin
  result:=FieldsNum+1;//если сошлось - возвращаем результат (+1 потому что нумерация в плаге на 1 меньше)
  break;//выходим из цикла
  end;
 until false;
END;

//по имени плагина fPlugin выдаёт значение поля FieldNumber для файла fFile.
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
hlib:=LoadPlugin (pchar (fPlugin));//получаем хендл плагина
if hLib=0 then Exit;
//без вызова ContentSetDefaultParams начинаются глюки
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

@Proc2:= GetProcAddress(hLib, 'ContentGetValue');//получаем адрес процедуры ContentGetValue из плагина.
if @Proc2=nil then begin FreeLibrary(hLib); Exit end;

try
 FieldsNum:=FieldNumber;
 FillChar(buf1, SizeOf(buf1), 0);
 FillChar(buf2, SizeOf(buf2), 0);
 res:= Proc2(PChar(fFile), FieldNumber-1, 0, @buf1, SizeOf(buf1), 0);//вызываем ContentGetValue, передаём имя файла, номер поля, UnitIndex нас не интересует - равен 0, адрес и размер буфера для возвращаемого результата. Res - тип поля
 sval:= '';
 case res of//по типу поля ковертируем полученное значение в String.
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
     sval:= WdxFieldType(res);//если тип поля неучтённый - возвращаем в результате название типа.
 end;
 result:=sval;
Except
 on e:Exception do
 begin
 result:='ERROR!'; //если произошла ошибка в блоке try возвращаем ошибку.
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
hlib:=LoadPlugin (pchar (PluginName));//получаем хендл плагина
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