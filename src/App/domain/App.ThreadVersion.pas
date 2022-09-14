unit App.ThreadVersion;

interface


uses
  App.Settings,
  KLib.Windows, KLib.Utils, KLib.Constants, KLib.Types,
  KLib.ServiceApp.ThreadAdapter,
  System.SysUtils;

type
  TApp = class(TThreadAdapter)
  private
    _fileName: string;
  public
    constructor Create(rejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
    procedure Run; override;
    destructor Destroy; override;
  end;

implementation

constructor TApp.Create(rejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
begin
  inherited Create(rejectCallBack, onChangeStatus);
  _fileName := getCombinedPathWithCurrentDir(settings.filename);
end;

procedure TApp.Run;
var
  _logMessage: string;
begin
  _logMessage := 'Message from thread: ' + TimeToStr(now);
  appendToFile(_fileName, _logMessage, FORCE_CREATION);
  sleep(settings.sleep_time);
end;

destructor TApp.Destroy;
begin
  inherited;
end;

end.
