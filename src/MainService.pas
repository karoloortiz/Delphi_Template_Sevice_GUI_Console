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
  App, App.Env, App.ShellParams,
  KLib.Utils, KLib.Windows, KLib.Constants;

procedure TMyMainService.ServiceCreate(Sender: TObject);
begin
  inherited;
  Self.serviceApp := getApp;
  eventLogDisabled := false;
  rejectCallback := serviceRejectCallback;
  applicationName := APPLICATION_NAME;
  installParameterName := INSTALL_PARAMETER_NAME;
end;

end.
