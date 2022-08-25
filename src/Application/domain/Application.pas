unit Application;

interface

procedure myJob;

implementation

uses
  KLib.Windows, KLib.Utils, KLib.Constants,
  System.SysUtils;

procedure myJob;
var
  _fileName: string;
  _logMessage: string;
begin
  _fileName := getCombinedPathWithCurrentDir('log.txt');
  _logMessage := 'Message from thread: ' + TimeToStr(now);
  appendToFile(_fileName, _logMessage, FORCE_CREATION);
end;

end.
