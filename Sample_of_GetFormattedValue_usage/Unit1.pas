unit Unit1;

interface

uses
  Windows, SysUtils, Forms, StdCtrls, FileCtrl, Controls, Classes;

type
  TForm1 = class(TForm)
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    PrevOut: TMemo;
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TContentGetFormattedValue = function (FileName,ContentString : pchar;FieldValue:pchar;MaxLen:Integer):integer; stdcall;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Function GetFormattedValue (PluginName,FileName,ContentString:string):string;
var
  hLib: THandle;
  GFV: TContentGetFormattedValue;
  res:array [0..2*1024] of char;
begin
Result:= '';
hlib:=LoadLibrary (pchar (PluginName));//получаем хендл плагина
if hLib=0 then Exit;
@GFV:= GetProcAddress(hLib, 'GetFormattedValue');
if @GFV<>nil then
 begin
 FillChar(res, SizeOf(res), 0);
 if GFV (Pchar(FileName),PChar(ContentString),@res,sizeof (res))=1 then result:=res else result:='Can''t get value';
 end;
End;



procedure TForm1.Button1Click(Sender: TObject);
begin
PrevOut.Text :=GetFormattedValue(ExtractFilePath (application.ExeName)+'super_wdx.wdx',FileListBox1.FileName,Edit1.Text);
end;

end.


