unit App.Settings;

interface

uses
  KLib.Generics.Ini, KLib.Generics.Attributes; // always include

type

  [
    SettingStringsAttribute(double_quotted)
    ]
  TSettingsIni = record
  public
    [SectionNameAttribute('app')]
    [DefaultValueAttribute('error_app.txt')]
    errorApp_fileName: string;
    // App.ThreadVersion
    [SectionNameAttribute('job')]
    [DefaultValueAttribute('log.txt')]
    filename: string;
    [DefaultValueAttribute('100')]
    sleep_time: integer;
    // App.HttpServerVersion
    [DefaultValueAttribute('8000')]
    port: integer;
  end;

var
  settings: TSettingsIni;

implementation

uses
  App.ShellParams,
  KLib.Windows, KLib.Constants,
  System.SysUtils;

initialization

settings := TIniGenerics.tryGetFromFile<TSettingsIni>(shellParamsApp.setting_filename);
if shellParamsApp.filename <> EMPTY_STRING then
begin
  settings.filename := shellParamsApp.filename;
end;
if shellParamsApp.sleep_time <> 0 then
begin
  settings.sleep_time := shellParamsApp.sleep_time;
end;
if shellParamsApp.port <> 0 then
begin
  settings.port := shellParamsApp.port;
end;

end.
