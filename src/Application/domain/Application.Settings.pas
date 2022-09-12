unit Application.Settings;

interface

uses
  KLib.Generic.Ini, KLib.Generic.Attributes; //always include

type

  [
    SettingStringsAttribute(double_quotted)
    ]
  TSettingsIni = record
  public
    [SectionNameAttribute('job')]
    [DefaultValueAttribute('log.txt')]
    filename: string;
    [DefaultValueAttribute('100')]
    sleep_time: integer;
  end;

var
  settings: TSettingsIni;

implementation

uses
  Application.ShellParams,
  System.SysUtils;

initialization

settings := TIniGeneric.tryGetFromFile<TSettingsIni>(ApplicationShellParams.defaults_file);

end.
