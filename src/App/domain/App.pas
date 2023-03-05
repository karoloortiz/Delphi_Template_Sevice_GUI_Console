unit App;

interface


uses
  //############################################################################
  // SELECT THREAD OR HTTPSERVER VERSION
  // TEMPLATE OF APPLICATIONS
  //----------------------------------------------------------------------------
  //  App.ThreadVersion,
  App.HttpServerVersion,
  //----------------------------------------------------------------------------
  //############################################################################
  App.Settings,
  KLib.Windows, KLib.Utils, KLib.Constants, KLib.Types,
  System.SysUtils;

function getApp(rejectCallBack: TCallBack = nil; onChangeStatus: TCallBack = nil): TApp;

var
  defaultAppRejectCallback: TCallback;
  serviceRejectCallback: TCallBack;

implementation

function getApp(rejectCallBack: TCallBack = nil; onChangeStatus: TCallBack = nil): TApp;
var
  App: TApp;
  _rejectCallback: TCallBack;
begin
  _rejectCallback := rejectCallBack;
  if not Assigned(rejectCallBack) then
  begin
    _rejectCallback := defaultAppRejectCallback;
  end;
  App := TApp.Create(_rejectCallback, onChangeStatus);

  Result := App;
end;

initialization

defaultAppRejectCallback := procedure(msg: string)
  var
    _fileName: string;
    _logMessage: string;
  begin
    _fileName := getCombinedPathWithCurrentDir(settings.errorApp_fileName);
    _logMessage := getCurrentDateTimeWithFormattingAsString(DATETIME_FORMAT) + ' - ERROR -> ' + getStringWithoutLineBreaks(msg);
    KLib.Utils.appendToFile(_fileName, _logMessage, FORCE_CREATION);
  end;

serviceRejectCallback := procedure(msg: string)
  var
    _fileName: string;
    _logMessage: string;
  begin
    _fileName := getCombinedPathWithCurrentDir('error_service.txt');
    _logMessage := getCurrentDateTimeWithFormattingAsString(DATETIME_FORMAT) + ' - ERROR SERVICE -> ' + getStringWithoutLineBreaks(msg);
    KLib.Utils.appendToFile(_fileName, _logMessage, FORCE_CREATION);
  end;

end.
