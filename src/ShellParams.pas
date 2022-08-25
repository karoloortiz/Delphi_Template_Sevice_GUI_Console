unit ShellParams;

interface

uses
  KLib.Constants;

const
  INSTALL_PARAMETER_NAME = '--install';
  UNINSTALL_PARAMETER_NAME = '--uninstall';
  SILENT_PARAMETER_NAME = '--silent';

  HELP_PARAMETER_NAME = '--help';

  CHECK_PARAMETER_NAME = '--check'; //<---  only an example to pass "value"

  HELP_MESSAGE =
    sLineBreak +
    'MY PROGRAM' + sLineBreak +
    'Usage:' + sLineBreak +
    sLineBreak +
    '--install install service' + sLineBreak +
    '--uninstall uninstall service' + sLineBreak +
    '--silent silent mode' + sLineBreak +
    sLineBreak +
    '--help print help' + sLineBreak +
    '--check value <---  only an example to pass "value"';

type
  TShellParams = record
  public
    install: boolean;
    uninstall: boolean;
    silent: boolean;

    help: boolean;

    check: string; //<---  only an example to pass "value"
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

    check: EMPTY_STRING; //<---  only an example to pass "value"
  );

function getShellParameters: TShellParams;

var
  ApplicationShellParams: TShellParams;

implementation

uses
  System.SysUtils;

function getValueOfParameter(indexParameter: integer): string; forward;

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

  _check_parameter: string;
begin
  if install <> false then
  begin
    _install := INSTALL_PARAMETER_NAME;
  end;

  if uninstall <> false then
  begin
    _uninstall := UNINSTALL_PARAMETER_NAME;
  end;

  if silent <> false then
  begin
    _silent := SILENT_PARAMETER_NAME;
  end;

  if help <> false then
  begin
    _help := HELP_PARAMETER_NAME;
  end;

  if check <> EMPTY_STRING then
  begin
    _check_parameter := CHECK_PARAMETER_NAME + ' ' + check;
  end;

  _result := _install + ' ' + _uninstall + ' ' + _silent + ' ' + _help + ' ' + _check_parameter;
  _result := trim(_result);

  Result := _result;
end;

procedure TShellParams.setDefault;
begin
  self := DEFAULT_SHELL_PARAMS;
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
    end
    else if (_parameterName = UNINSTALL_PARAMETER_NAME) then
    begin
      shellParameters.uninstall := true;
    end
    else if (_parameterName = SILENT_PARAMETER_NAME) then
    begin
      shellParameters.silent := true;
    end
    else if (_parameterName = HELP_PARAMETER_NAME) then
    begin
      shellParameters.help := true;
    end
    else if (_parameterName = CHECK_PARAMETER_NAME) then
    begin
      _parameterValue := getValueOfParameter(i);
      if _parameterValue <> '' then
      begin
        shellParameters.check := _parameterValue;
      end;
    end;
  end;

  Result := shellParameters;
end;

function getValueOfParameter(indexParameter: integer): string;
var
  _result: string;
  _value: string;
  _indexValue: integer;
begin
  _result := '';

  _indexValue := indexParameter + 1;
  if _indexValue <= ParamCount then
  begin
    _value := ParamStr(_indexValue);
    if
      (_value <> INSTALL_PARAMETER_NAME)
      and (_value <> UNINSTALL_PARAMETER_NAME)
      and (_value <> SILENT_PARAMETER_NAME)
      and (_value <> HELP_PARAMETER_NAME)
      and (_value <> CHECK_PARAMETER_NAME)
    then
    begin
      _result := _value;
    end;
  end;
  Result := _result;
end;

end.
