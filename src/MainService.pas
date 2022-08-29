unit MainService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, KLib.MyService, Vcl.SvcMgr;

type
  TMyMainService = class(TMyService)
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MyMainService: TMyMainService;

implementation

{$r *.dfm}


uses
  Application,
  KLib.Utils, KLib.Windows, KLib.Constants;

procedure TMyMainService.ServiceCreate(Sender: TObject);
begin
  inherited;
  executorMethod := myjob;
  eventLogDisabled := false;
  rejectCallback := procedure(msg: string)
    var
      _fileName: string;
      _logMessage: string;
    begin
      _fileName := getCombinedPathWithCurrentDir('log.txt');
      _logMessage := 'ERROR -> ' + msg;
      appendToFile(_fileName, _logMessage, FORCE_CREATION);
    end;
end;

end.
