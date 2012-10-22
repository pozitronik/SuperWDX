unit preview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, WdxFieldsProc;

type
  TPreviewF = class(TForm)
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    FileListBox1: TFileListBox;
    PrevOut: TMemo;
    procedure FileListBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PreviewF: TPreviewF;

implementation

uses Settings;

{$R *.dfm}

procedure TPreviewF.FileListBox1Change(Sender: TObject);
begin
Caption:=SuperSettings.DS.text;
if FileListBox1.FileName<>'' then Prevout.Text :=GetFormattedvalue ('super_wdx.wdx',FileListBox1.FileName,SuperSettings.DS.text);
end;

end.
