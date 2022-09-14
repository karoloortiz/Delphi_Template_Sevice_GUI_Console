unit App.ShellParams;

interface

uses
  App.Env,
  KLib.Constants, KLib.Generic.ShellParams, KLib.Generic.Attributes;

const
  INSTALL_PARAMETER_NAME = '--install';
  UNINSTALL_PARAMETER_NAME = '--uninstall';
  SILENT_PARAMETER_NAME = '--silent';
  DEFAULTS_FILE_PARAMETER_NAME = '--defaults-file';

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
    '--defaults-file path of settings file' + sLineBreak +
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
      ParamNameAttribute(DEFAULTS_FILE_PARAMETER_NAME),
      DefaultValueAttribute('settings.ini'),
      SettingStringDequoteAttribute,
      ValidateFullPathAttribute
      ]
    defaults_file: string;

    [
      ParamNameAttribute(HELP_PARAMETER_NAME),
      ParamNameAttribute(HELP_PARAMETER_SHORT_NAME),
      DefaultValueAttribute('false')
      ]
    help: boolean;
  end;

var
  ApplicationShellParams: TApplicationShellParams;

implementation


initialization

ApplicationShellParams := TShellParamsGeneric.get<TApplicationShellParams>();

end.