unit Application;

interface

procedure myJob;

implementation

uses
  Application.Settings,
  KLib.Windows, KLib.Utils, KLib.Constants,
  System.SysUtils;

procedure myJob;
var
  _fileName: string;
  _logMessage: string;
begin
  _fileName := getCombinedPathWithCurrentDir(settings.filename);
  _logMessage := 'Message from thread: ' + TimeToStr(now);
  appendToFile(_fileName, _logMessage, FORCE_CREATION);
  sleep(settings.sleep_time);
end;

end.
