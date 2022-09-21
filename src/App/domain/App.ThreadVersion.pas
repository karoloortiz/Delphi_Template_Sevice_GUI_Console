unit App.ThreadVersion;

interface


uses
  App.Settings,
  KLib.ServiceApp.ThreadAdapter,
  KLib.Windows, KLib.Utils, KLib.Constants, KLib.Types,
  System.SysUtils;

type
  TApp = class(TThreadAdapter)
  private
    _fileName: string;
  public
    constructor Create(myRejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
    procedure start; override;
    procedure Run; override;
    destructor Destroy; override;
  end;

implementation

constructor TApp.Create(myRejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
begin
  inherited Create(myRejectCallBack, onChangeStatus);
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

procedure TApp.start;
begin
  //
  inherited;
end;

destructor TApp.Destroy;
begin
  //
  inherited;
end;

end.
