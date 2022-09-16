unit App.Settings;

interface

uses
  KLib.Generic.Ini, KLib.Generic.Attributes; //always include

const
  ERRORAPP_FILENAME_DEFAULT_VALUE = 'error_app.txt';

  FILENAME_DEFAULT_VALUE = 'log.txt';
  SLEEP_TIME_DEFAULT_VALUE = '100';
  PORT_DEFAULT_VALUE = '8000';

type

  [
    SettingStringsAttribute(double_quotted)
    ]
  TSettingsIni = record
  public
    [SectionNameAttribute('app')]
    [DefaultValueAttribute(ERRORAPP_FILENAME_DEFAULT_VALUE)]
    errorApp_fileName: string;
    //App.ThreadVersion
    [SectionNameAttribute('job')]
    [DefaultValueAttribute(FILENAME_DEFAULT_VALUE)]
    filename: string;
    [DefaultValueAttribute(SLEEP_TIME_DEFAULT_VALUE)]
    sleep_time: integer;
    //App.HttpServerVersion
    [DefaultValueAttribute(PORT_DEFAULT_VALUE)]
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

settings := TIniGeneric.tryGetFromFile<TSettingsIni>(shellParamsApp.defaults_file);
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
