unit App.HttpServerVersion;

interface

uses
  App.Settings,
  KLib.Windows, KLib.Utils, KLib.Constants, KLib.Types,
  KLib.ServiceApp.HttpServerAdapter;

type

  TApp = class(THttpServerAdapter)
  public
    constructor Create(rejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
    destructor Destroy; override;
  end;

implementation

uses
  KLib.Generic, KLib.Generic.Attributes;

constructor TApp.Create(rejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
type
  TResponse = record
  public
    timestamp: string;
    sucess: string;
    error: string;
  end;
var
  _myOnGetAnonymousMethod: TMyOnCommandGetAnonymousMethod;
begin
  _myOnGetAnonymousMethod := procedure(var AContext: TIdContext; var ARequestInfo: TIdHTTPRequestInfo; var AResponseInfo: TIdHTTPResponseInfo)
    var
      _response: TResponse;
    begin
      _response := default (TResponse);
      with _response do
      begin
        timestamp := getCurrentTimeStamp;
        sucess := 'ok';
        error := '';
      end;
      AResponseInfo.ResponseNo := 200;
      AResponseInfo.ContentType := 'application/json';
      AResponseInfo.ContentText := TGeneric.getJSONAsString<TResponse>(_response, NOT_IGNORE_EMPTY_STRINGS);
    end;
  inherited Create(_myOnGetAnonymousMethod, settings.port, onChangeStatus);
end;

destructor TApp.Destroy;
begin
  inherited;
end;

end.
