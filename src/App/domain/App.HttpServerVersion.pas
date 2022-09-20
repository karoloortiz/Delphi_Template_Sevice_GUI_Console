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
  KLib.Generics.JSON, KLib.Generics.Attributes,
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

  TMyCustomRecord = record
  public
    timestamp: string;
    sucess: string;
    error: string;
    _int: integer;
    _double: double;
    _boolean: boolean;

    sub: TSubRecord;

    subsub: TSubRecord2;

    myarray: TArrayOfSubRecord2;
  end;
var
  _myOnGetAnonymousMethod: TMyOnCommandGetAnonymousMethod;
  _body: string;
begin
  _myOnGetAnonymousMethod := procedure(var AContext: TIdContext; var ARequestInfo: TIdHTTPRequestInfo; var AResponseInfo: TIdHTTPResponseInfo)
    var
      _route: string;
      _response: TMyCustomRecord;
      _request: TMyCustomRecord;
    begin
      _route := ARequestInfo.Document;
      if ARequestInfo.Command = 'POST' then
      begin
        _body := getStringFromStream(ARequestInfo.PostStream);

        _request := TJSONGenerics.getParsedJSON<TMyCustomRecord, TSubRecord, TSubRecord2, TArrayOfSubRecord2>(_body); //you need to pass every sub custom type of T
        AResponseInfo.ResponseNo := 200;
        AResponseInfo.ContentType := APPLICATION_JSON_CONTENT_TYPE;
        with _response do
        begin
          timestamp := getCurrentTimeStamp;
          sucess := 'POST' + sLineBreak + _body;
        end;
        AResponseInfo.ContentText :=
          TJSONGenerics.getJSONAsString<TMyCustomRecord, TSubRecord, TSubRecord2, TArrayOfSubRecord2>
          (_response, NOT_IGNORE_EMPTY_STRINGS);
      end
      else if ARequestInfo.Command = 'GET' then
      begin
        AResponseInfo.ResponseNo := 200;
        AResponseInfo.ContentType := APPLICATION_JSON_CONTENT_TYPE;
        _response := default (TMyCustomRecord);
        with _response do
        begin
          timestamp := getCurrentTimeStamp;
          sucess := 'GET';
        end;
        AResponseInfo.ContentText := TJSONGenerics.getJSONAsString<TMyCustomRecord, TSubRecord, TSubRecord2, TArrayOfSubRecord2>
          (_response, NOT_IGNORE_EMPTY_STRINGS);
      end;
    end;
  //
  inherited Create(_myOnGetAnonymousMethod, settings.port, rejectCallBack, onChangeStatus);
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
