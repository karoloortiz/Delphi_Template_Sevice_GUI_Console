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
  serviceRejectCallback: TCallBack;

implementation

function getApp(rejectCallBack: TCallBack = nil; onChangeStatus: TCallBack = nil): TApp;
var
  App: TApp;

  _defaultAppRejectCallback: TCallBack;
begin
  _defaultAppRejectCallback := rejectCallBack;
  if not Assigned(_defaultAppRejectCallback) then
  begin
    _defaultAppRejectCallback := procedure(msg: string)
      var
        _fileName: string;
        _logMessage: string;
      begin
        _fileName := getCombinedPathWithCurrentDir(settings.filename);
        _logMessage := 'ERROR -> ' + msg;
        appendToFile(_fileName, _logMessage, FORCE_CREATION);
      end;
  end;
  App := TApp.Create(rejectCallback, onChangeStatus);

  Result := App;
end;

initialization

serviceRejectCallback := procedure(msg: string)
  var
    _fileName: string;
    _logMessage: string;
  begin
    _fileName := getCombinedPathWithCurrentDir('error_service.txt');
    _logMessage := 'ERROR SERVICE -> ' + msg;
    appendToFile(_fileName, _logMessage, FORCE_CREATION);
  end;

end.
