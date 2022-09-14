unit App.Env;

interface

uses
  KLib.Constants, KLib.MyService.Utils, KLib.Types;

const
  VERSION = '1.0';
  APPLICATION_NAME = 'KProject';
  SERVICE_NAME_DESCRIPTION = APPLICATION_NAME + ' ' + VERSION;

  SERVICE_NAME = 'KService';

var
  executionMode: TExecutionMode;
  installServiceParams: TInstallServiceParams;
  runServiceParams: TRunServiceParams;

implementation

uses
  App, App.ShellParams,
  KLib.Windows, KLib.Utils;

function getExecutionMode: TExecutionMode;
var
  executionMode: TExecutionMode;

  _serviceModeEnabled: boolean;
  _guiModeEnabled: boolean;
begin
  _serviceModeEnabled := checkIfCurrentProcessIsAServiceProcess;
  _guiModeEnabled := myParamCount = 0;
  if _serviceModeEnabled then
  begin
    executionMode := TExecutionMode.service;
  end
  else if _guiModeEnabled then
  begin
    executionMode := TExecutionMode.gui;
  end
  else
  begin
    executionMode := TExecutionMode.console;
  end;

  Result := executionMode;
end;

initialization

executionMode := getExecutionMode;

installServiceParams.clear;
with installServiceParams do
begin
  silent := ApplicationShellParams.silent;
  serviceName := ApplicationShellParams.serviceName;
  regkeyDescription := SERVICE_NAME_DESCRIPTION;
  applicationName := APPLICATION_NAME;
  installParameterName := INSTALL_PARAMETER_NAME;
  defaults_file := EMPTY_STRING;
  customParameters := EMPTY_STRING;
end;

runServiceParams.clear;
with runServiceParams do
begin
  eventLogDisabled := false;
  rejectCallback := serviceRejectCallback;
  applicationName := APPLICATION_NAME;
  installParameterName := INSTALL_PARAMETER_NAME;
end;

end.
