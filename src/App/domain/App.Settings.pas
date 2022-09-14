unit App.Settings;

interface

uses
  KLib.Generic.Ini, KLib.Generic.Attributes; //always include

type

  [
    SettingStringsAttribute(double_quotted)
    ]
  TSettingsIni = record
  public
    //App.ThreadVersion
    [SectionNameAttribute('job')]
    [DefaultValueAttribute('log.txt')]
    filename: string;
    [DefaultValueAttribute('100')]
    sleep_time: integer;
    //App.HttpServerVersion
    [DefaultValueAttribute('8000')]
    port: integer;
  end;

var
  settings: TSettingsIni;

implementation

uses
  App.ShellParams,
  KLib.Windows,
  System.SysUtils;

initialization

settings := TIniGeneric.tryGetFromFile<TSettingsIni>(ApplicationShellParams.defaults_file);

end.
