program Ssettings;

uses
  Forms,
  Settings in 'Settings.pas' {SuperSettings},
  About in 'About.pas' {AboutBox},
  WdxFieldsProc in 'WdxFieldsProc.pas',
  preview in 'preview.pas' {PreviewF};

{$R *.res}


begin
  Application.Initialize;
  Application.Title := 'Super settings';
  Application.CreateForm(TSuperSettings, SuperSettings);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TPreviewF, PreviewF);
  Application.Run;
end.
