unit App.ShellParams;

interface

uses
  App.Env, App.Settings,
  KLib.Constants, KLib.Generics.ShellParams, KLib.Generics.Attributes;

const
  INSTALL_PARAMETER_NAME = '--install';
  UNINSTALL_PARAMETER_NAME = '--uninstall';
  SILENT_PARAMETER_NAME = '--silent';
  RUN_PARAMENTER_NAME = '--run';
  // -----------------------------
  // SETTING PARAMS
  // App.ThreadVersion
  FILENAME_PARAMETER_NAME = '--filename';
  SLEEP_TIME_PARAMETER_NAME = '--sleep_time';
  // App.HttpServerVersion
  PORT_PARAMETER_NAME = '--port';
  // ----------------------------
  SETTINGS_FILENAME_PARAMETER_NAME = '--settings-filename';

  HELP_PARAMETER_NAME = '--help';
  HELP_PARAMETER_SHORT_NAME = '-h';

  HELP_MESSAGE =
    sLineBreak +
    APPLICATION_NAME + sLineBreak +
    'Usage:' + sLineBreak +
    sLineBreak +
    '--install [service name]' + #9 + 'install service' + sLineBreak +
    '--uninstall [service name]' + #9 + 'uninstall service' + sLineBreak +
    '--silent' + #9#9#9 + 'silent mode' + sLineBreak +
    '--run' + #9#9#9 + 'run App' + sLineBreak +
    '--settings-filename path of settings file' + sLineBreak +
    sLineBreak +
    '--help or -h' + #9#9#9#9 + 'print help';

type
  TApplicationShellParams = record
  public
    [
      ParamNameAttribute(INSTALL_PARAMETER_NAME),
      DefaultValueAttribute('false')
      ]
    install: boolean;

    [
      ParamNameAttribute(UNINSTALL_PARAMETER_NAME),
      DefaultValueAttribute('false')
      ]
    uninstall: boolean;

    [
      ParamNameAttribute(INSTALL_PARAMETER_NAME),
      ParamNameAttribute(UNINSTALL_PARAMETER_NAME),
      DefaultValueAttribute(SERVICE_NAME)
      ]
    serviceName: string;

    [
      ParamNameAttribute(SILENT_PARAMETER_NAME),
      DefaultValueAttribute('false')
      ]
    silent: boolean;

    [
      ParamNameAttribute(RUN_PARAMENTER_NAME),
      DefaultValueAttribute('false')
      ]
    run: boolean;
    [
      ParamNameAttribute(HELP_PARAMETER_NAME),
      ParamNameAttribute(HELP_PARAMETER_SHORT_NAME),
      DefaultValueAttribute('false')
      ]
    help: boolean;
    // -------------------------------
    // SETTING PARAMS
    // App.ThreadVersion
    [
      ParamNameAttribute(FILENAME_PARAMETER_NAME)
      ]
    filename: string;

    [
      ParamNameAttribute(SLEEP_TIME_PARAMETER_NAME)
      ]
    sleep_time: integer;
    // App.HttpServerVersion
    [
      ParamNameAttribute(PORT_PARAMETER_NAME)
      ]
    port: integer;
    // -------------------------------
    [
      ParamNameAttribute(SETTINGS_FILENAME_PARAMETER_NAME),
      DefaultValueAttribute('settings.ini'),
      SettingStringDequoteAttribute,
      ValidateFullPathAttribute
      ]
    setting_filename: string;
  end;

var
  shellParamsApp: TApplicationShellParams;

implementation


initialization

shellParamsApp := TShellParamsGenerics.get<TApplicationShellParams>();

end.
