unit Application.ShellParams;

interface

uses
  Application.Env,
  KLib.Constants;

const
  INSTALL_PARAMETER_NAME = '--install';
  UNINSTALL_PARAMETER_NAME = '--uninstall';
  SILENT_PARAMETER_NAME = '--silent';

  HELP_PARAMETER_NAME = '--help';

  HELP_MESSAGE =
    sLineBreak +
    APPLICATION_NAME + sLineBreak +
    'Usage:' + sLineBreak +
    sLineBreak +
    '--install [service name]' + #9 + 'install service' + sLineBreak +
    '--uninstall [service name]' + #9 + 'uninstall service' + sLineBreak +
    '--silent' + #9#9#9 + 'silent mode' + sLineBreak +
    sLineBreak +
    '--help' + #9#9#9#9 + 'print help';

type
  TShellParams = record
  public
    install: boolean;
    uninstall: boolean;
    silent: boolean;

    help: boolean;

    serviceName: string;
    procedure read;
    function getAsString: string;
    procedure setDefault;
  end;

const
  DEFAULT_SHELL_PARAMS: TShellParams = (
    install: false;
    uninstall: false;
    silent: false;

    help: false;

    serviceName: SERVICE_NAME;
  );

function getShellParameters: TShellParams;

var
  ApplicationShellParams: TShellParams;

implementation

uses
  KLib.Utils,
  System.SysUtils;

function _getValueOfParameter(parameterName: string): string; forward;

procedure TShellParams.read;
begin
  Self := getShellParameters;
end;

function TShellParams.getAsString: string;
var
  _result: string;

  _install: string;
  _uninstall: string;
  _silent: string;

  _help: string;
begin
  if install <> false then
  begin
    _install := INSTALL_PARAMETER_NAME + ' ' + serviceName;
  end;

  if uninstall <> false then
  begin
    _uninstall := UNINSTALL_PARAMETER_NAME + ' ' + serviceName;
  end;

  if silent <> false then
  begin
    _silent := SILENT_PARAMETER_NAME;
  end;

  if help <> false then
  begin
    _help := HELP_PARAMETER_NAME;
  end;

  _result := _install + ' ' + _uninstall + ' ' + _silent + ' ' + _help;
  _result := trim(_result);

  Result := _result;
end;

procedure TShellParams.setDefault;
begin
  Self := DEFAULT_SHELL_PARAMS;
end;

function getShellParameters: TShellParams;
var
  shellParameters: TShellParams;
  _parameterName: string;
  _parameterValue: string;
  i: integer;
begin
  shellParameters.setDefault;
  for i := 1 to ParamCount do
  begin
    _parameterName := ParamStr(i);
    if (_parameterName = INSTALL_PARAMETER_NAME) then
    begin
      shellParameters.install := true;

      _parameterValue := _getValueOfParameter(INSTALL_PARAMETER_NAME);
      if _parameterValue <> EMPTY_STRING then
      begin
        shellParameters.serviceName := _parameterValue;
      end;
    end
    else if (_parameterName = UNINSTALL_PARAMETER_NAME) then
    begin
      shellParameters.uninstall := true;

      _parameterValue := _getValueOfParameter(UNINSTALL_PARAMETER_NAME);
      if _parameterValue <> EMPTY_STRING then
      begin
        shellParameters.serviceName := _parameterValue;
      end;
    end
    else if (_parameterName = SILENT_PARAMETER_NAME) then
    begin
      shellParameters.silent := true;
    end
    else if (_parameterName = HELP_PARAMETER_NAME) then
    begin
      shellParameters.help := true;
    end;
  end;

  Result := shellParameters;
end;

function _getValueOfParameter(parameterName: string): string;
var
  _result: string;
  _value: string;
begin
  _result := '';

  _value := getValueOfParameter(parameterName);
  if
    (_value <> INSTALL_PARAMETER_NAME)
    and (_value <> UNINSTALL_PARAMETER_NAME)
    and (_value <> SILENT_PARAMETER_NAME)
    and (_value <> HELP_PARAMETER_NAME)
  then
  begin
    _result := _value;
  end;

  Result := _result;
end;

initialization

ApplicationShellParams.read;

end.
