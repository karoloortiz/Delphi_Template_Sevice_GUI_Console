unit App.HttpServerVersion;

interface

uses
  App.Settings,
  KLib.ServiceApp.HttpServerAdapter,
  KLib.Windows, KLib.Utils, KLib.Constants, KLib.Types;

type

  TApp = class(THttpServerAdapter)
  public
    constructor Create(rejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
    procedure start; override;
    destructor Destroy; override;
  end;

implementation

uses
  KLib.Generic, KLib.Generic.Attributes,
  System.Classes,
  System.JSON, System.SysUtils;

constructor TApp.Create(rejectCallBack: TCallBack; onChangeStatus: TCallBack = nil);
type
  TSubRecord2 = record
    subsub1: integer;
    subsub2: string;
  end;

  TArrayOfSubRecord2 = array of TSubRecord2;

  TSubRecord = record
    _sub1: string;

    subsub: TSubRecord2;
  end;

  TRequest = record
  public
    myarray: TArrayOfSubRecord2; //todo

    timestamp: string;
    sucess: string;
    error: string;
    _int: integer;
    _double: double;
    _boolean: boolean;

    sub: TSubRecord;

    subsub: TSubRecord2;
  end;

  TResponse = record
  public
    myarray: TArrayOfSubRecord2;

    timestamp: string;
    sucess: string;
    error: string;
    _int: integer;
    _double: double;
    _boolean: boolean;

    sub: TSubRecord;

    subsub: TSubRecord2;
  end;
var
  _myOnGetAnonymousMethod: TMyOnCommandGetAnonymousMethod;
  body: string;
begin
  _myOnGetAnonymousMethod := procedure(var AContext: TIdContext; var ARequestInfo: TIdHTTPRequestInfo; var AResponseInfo: TIdHTTPResponseInfo)
    var
      _route: string;
      _response: TResponse;
      _request: TRequest;
    begin
      _route := ARequestInfo.Document;

      if ARequestInfo.Command = 'POST' then
      begin
        _request := TGeneric.getParsedJSON<TRequest, TSubRecord, TSubRecord2, TArrayOfSubRecord2>(body);

        body := getStringFromStream(ARequestInfo.PostStream);
        AResponseInfo.ResponseNo := 200;
        AResponseInfo.ContentType := 'application/json';
        with _response do
        begin
          timestamp := getCurrentTimeStamp;
          sucess := 'POST' + sLineBreak + body;
        end;
        //todo create version of only one param
        AResponseInfo.ContentText := TGeneric.getJSONAsString<TResponse, TResponse, TResponse, TResponse>(_response, NOT_IGNORE_EMPTY_STRINGS);
      end
      else if ARequestInfo.Command = 'GET' then
      begin
        AResponseInfo.ResponseNo := 200;
        AResponseInfo.ContentType := 'application/json';
        _response := default (TResponse);
        with _response do
        begin
          timestamp := getCurrentTimeStamp;
          sucess := 'GET';
        end;
        AResponseInfo.ContentText := TGeneric.getJSONAsString<TResponse, TResponse, TResponse, TResponse>(_response, NOT_IGNORE_EMPTY_STRINGS);
      end;
    end;
  //
  inherited Create(_myOnGetAnonymousMethod, settings.port, onChangeStatus);
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
