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

  TJSONExtraDescription = record
    description: string;
    hint: string;
    //    function getEmptyRecord: TJSONExtraDescription;
  end;

  TJSONSlide = record
    title: string;
    subTitle: string;
    imgAsResource: boolean;
    imgName: string;
    extraDescription: TJSONExtraDescription;
    //    function setEmpty: TJSONSlide;
  end;

  TJSONPresentationSchema = record
    mainColorRGB: string;
    textEndButton: string;
    slides: Array of TJSONSlide;
  end;

implementation

uses
  KLib.Generic, KLib.Generic.Attributes,
  System.Classes,
  System.JSON, System.SysUtils;

procedure loadJSONResource;
var
  JSONPresentationSchema: TJSONPresentationSchema;
  resourceSchemaAsString: String;
  JSONFile: TBytes;
  JSONMain: TJSONValue;
  _slides: TJSONArray;
  slide: TJSONSlide;
  _slide: TJSONObject;
  _extraDescription: TJSONObject;
  i: integer;
begin
  resourceSchemaAsString := '';
  JSONFile := TEncoding.ASCII.GetBytes(resourceSchemaAsString);
  JSONMain := TJSONObject.ParseJSONValue(JSONFile, 0);
  if JSONMain <> nil then
  begin
    if not JSONMain.TryGetValue('mainColorRGB', JSONPresentationSchema.mainColorRGB) then
    begin
      raise Exception.Create('mainColorRGB not present in JSON');
    end;
    if not JSONMain.TryGetValue('textEndButton', JSONPresentationSchema.textEndButton) then
    begin
      raise Exception.Create('textEndButton not present in JSON');
    end;
    _slides := JSONMain.GetValue<TJSONArray>('slides');
    SetLength(JSONPresentationSchema.slides, _slides.Count);
    for i := 0 to _slides.Count - 1 do
    begin
      slide := default (TJSONSlide);
      _slide := _slides.Items[i] as TJSONObject;
      with slide do
      begin
        if not _slide.TryGetValue('title', title) then
        begin
          raise Exception.Create('title not present in slide ' + IntToStr(i + 1) + ' of JSON');
        end;
        if not _slide.TryGetValue('imgAsResource', imgAsResource) then
        begin
          raise Exception.Create('imgAsResource not present in slide ' + IntToStr(i + 1) + ' of JSON');
        end;
        if not _slide.TryGetValue('imgName', imgName) then
        begin
          raise Exception.Create('imgName not present in slide ' + IntToStr(i + 1) + ' of JSON');
        end;
        _slide.TryGetValue('subTitle', subTitle);
      end;

      if _slide.TryGetValue('extraDescription', _extraDescription) then
      begin
        with slide.extraDescription do
        begin
          _extraDescription.TryGetValue('description', description);
          _extraDescription.TryGetValue('hint', hint);
        end;
      end;
      JSONPresentationSchema.slides[i] := slide;
    end;
  end
  else
  begin
    //    raise Exception.Create(resourceJSONName + ' is a not valid JSON.');
  end;
end;

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
    myarray: TArrayOfSubRecord2;  //todo

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
      _response: TResponse;
      _route: string;

      _request: TRequest;
    begin
      _route := ARequestInfo.Document;
      _response := default (TResponse);
      with _response do
      begin
        timestamp := getCurrentTimeStamp;
      end;
      AResponseInfo.ResponseNo := 200;
      AResponseInfo.ContentType := 'application/json';
      if ARequestInfo.Command = 'POST' then
      begin
        body := getStringFromStream(ARequestInfo.PostStream);

        _request := TGeneric.getParsedJSON<TRequest, TSubRecord, TSubRecord2, TArrayOfSubRecord2>(body);

        _response.sucess := 'POST' + sLineBreak + body;
      end
      else if ARequestInfo.Command = 'GET' then
      begin
        _response.sucess := 'GET';
      end;

      AResponseInfo.ContentText := TGeneric.getJSONAsString<TResponse, TResponse>(_response, NOT_IGNORE_EMPTY_STRINGS);
    end;
  inherited Create(_myOnGetAnonymousMethod, settings.port, onChangeStatus);
end;

destructor TApp.Destroy;
begin
  inherited;
end;

end.
