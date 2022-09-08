unit Application.Env;

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
  Application, Application.ShellParams,
  KLib.Windows, KLib.Utils;

function getExecutionMode: TExecutionMode;
var
  executionMode: TExecutionMode;

  _serviceModeEnabled: boolean;
  _guiModeEnabled: boolean;
begin
  _serviceModeEnabled := checkIfCurrentProcessIsAServiceProcess;
  _guiModeEnabled := ParamCount = 0;
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
  customParameters := EMPTY_STRING;
end;

runServiceParams.clear;
with runServiceParams do
begin
  executorMethod := myJob;
  eventLogDisabled := false;
  rejectCallback := procedure(msg: string)
    var
      _fileName: string;
      _logMessage: string;
    begin
      _fileName := getCombinedPathWithCurrentDir('log.txt');
      _logMessage := 'ERROR -> ' + msg;
      appendToFile(_fileName, _logMessage, FORCE_CREATION);
    end;
  applicationName := APPLICATION_NAME;
  installParameterName := INSTALL_PARAMETER_NAME;
end;

end.
