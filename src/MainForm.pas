unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  KLib.MyThread, KLib.Types, Vcl.ExtCtrls;

const
  WM_STATUS_CHANGED = WM_USER + 102;

type
  TMyForm = class(TForm)
    status_lbl: TLabel;
    start_stop_btn: TButton;
    resume_pause_btn: TButton;
    install_service_btn: TButton;
    uninstall_service_btn: TButton;
    _service_manager_pnl: TPanel;
    service_status: TLabel;
    _service_name_lbl: TLabel;
    _workThread_manager_pnl: TPanel;
    service_name: TEdit;
    application_service_check: TCheckBox;
    customParams: TEdit;
    _customParams_lbl: TLabel;
    defaults_file: TEdit;
    _defaults_file_lbl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure start_stop_btnClick(Sender: TObject);
    procedure resume_pause_btnClick(Sender: TObject);
    procedure install_service_btnClick(Sender: TObject);
    procedure uninstall_service_btnClick(Sender: TObject);
    procedure application_service_checkClick(Sender: TObject);
    procedure service_nameChange(Sender: TObject);
  private
    workerThread: TMyThread;
    _statusWorkThread: string;
    procedure onStatusChanged(var Msg: TMessage); message WM_STATUS_CHANGED;
    procedure set_serviceStatus(installed: boolean);
  public
    { Public declarations }
  end;

var
  MyForm: TMyForm;

implementation

{$r *.dfm}


uses
  Application, Application.Env,
  KLib.Windows, KLib.Constants, KLib.MyService.Utils, KLib.WindowsService;

procedure TMyForm.FormCreate(Sender: TObject);
var
  _rejectCallback: TCallBack;
  _onChangeStatus: TCallBack;
begin
  _rejectCallback := procedure(msg: string)
    begin
      ShowMessage('Error in workerThread: ' + msg);
    end;
  _onChangeStatus := procedure(value: string)
    begin
      _statusWorkThread := value;
      PostMessage(Self.Handle, WM_STATUS_CHANGED, 0, 0);
    end;
  workerThread := TMyThread.Create(myJob, _rejectCallback, FORCE_SUSPEND, _onChangeStatus);

  with start_stop_btn do
  begin
    Enabled := true;
    Caption := 'start';
  end;
  with resume_pause_btn do
  begin
    Enabled := false;
    Caption := 'resume';
  end;
end;

procedure TMyForm.install_service_btnClick(Sender: TObject);
var
  _installServiceParams: TInstallServiceParams;
begin
  _installServiceParams := installServiceParams;
  with _installServiceParams do
  begin
    silent := false;
    serviceName := service_name.Text;
    defaults_file := Self.defaults_file.Text;
    customParameters := customParams.Text;
  end;

  KLib.MyService.Utils.installService(_installServiceParams);

  set_serviceStatus(true);
end;

procedure TMyForm.uninstall_service_btnClick(Sender: TObject);
var
  _installServiceParams: TInstallServiceParams;
begin
  _installServiceParams := installServiceParams;
  with _installServiceParams do
  begin
    silent := false;
    serviceName := service_name.Text;
  end;

  KLib.MyService.Utils.uninstallService(_installServiceParams);

  set_serviceStatus(false);
end;

procedure TMyForm.start_stop_btnClick(Sender: TObject);
var
  _tempThread: TMyThread;
begin
  case workerThread.status of
    TThreadStatus.created:
      workerThread.myStart;
    TThreadStatus.stopped:
      begin
        _tempThread := workerThread.copy;
        FreeAndNil(workerThread);
        workerThread := _tempThread;
        workerThread.myStart(RAISE_EXCEPTION_DISABLED);
      end;
    TThreadStatus.paused:
      workerThread.stop;
    TThreadStatus.running:
      workerThread.stop;
  else
    begin
      ShowMessage('Incorrect status');
    end;
  end;
end;

procedure TMyForm.resume_pause_btnClick(Sender: TObject);
begin
  case workerThread.status of
    TThreadStatus.paused:
      workerThread.myResume;
    TThreadStatus.running:
      workerThread.pause;
  else
    begin
      ShowMessage('Incorrect status');
    end;
  end;
end;

procedure TMyForm.application_service_checkClick(Sender: TObject);
begin
  service_nameChange(Self);
end;

procedure TMyForm.service_nameChange(Sender: TObject);
var
  _serviceInstalled: boolean;
begin
  _serviceInstalled := TWindowsService.checkIfExists(service_name.Text);
  set_serviceStatus(_serviceInstalled);
end;

procedure TMyForm.set_serviceStatus(installed: boolean);
  function checkIServiceIsASameApplication: boolean;
  var
    serviceIsASameApplicationCheck: boolean;
    _service_regKey: string;
    _applicationName: string;
  begin
    _service_regKey := SERVICES_REGKEY + '\' + service_name.Text;
    try
      _applicationName := readStringFrom_HKEY_LOCAL_MACHINE(_service_regKey, 'ApplicationName');
    except
      on E: Exception do
      begin
        _applicationName := '_*ERROR*_';
      end;
    end;

    if application_service_check.Checked then
    begin
      serviceIsASameApplicationCheck := _applicationName = APPLICATION_NAME;
    end
    else
    begin
      serviceIsASameApplicationCheck := true;
    end;

    Result := serviceIsASameApplicationCheck;
  end;

var
  _serviceIsASameApplicationCheck: boolean;
begin
  _serviceIsASameApplicationCheck := checkIServiceIsASameApplication;

  if installed then
  begin
    install_service_btn.Enabled := false;
    uninstall_service_btn.Enabled := true and _serviceIsASameApplicationCheck;
    service_status.Caption := 'status: installed';
  end
  else
  begin
    install_service_btn.Enabled := true;
    uninstall_service_btn.Enabled := false and _serviceIsASameApplicationCheck;
    service_status.Caption := 'status: not installed';
  end;
end;

procedure TMyForm.onStatusChanged(var Msg: TMessage);
begin
  if _statusWorkThread = '_' then
  begin
    with start_stop_btn do
    begin
      Enabled := false;
      Caption := 'error';
    end;
    with resume_pause_btn do
    begin
      Enabled := false;
      Caption := 'error';
    end;
  end
  else if _statusWorkThread = 'created' then
  begin
    with start_stop_btn do
    begin
      Enabled := true;
      Caption := 'start';
    end;
    with resume_pause_btn do
    begin
      Enabled := false;
      Caption := 'resume';
    end;
  end
  else if _statusWorkThread = 'stopped' then
  begin
    with start_stop_btn do
    begin
      Enabled := true;
      Caption := 'start';
    end;
    with resume_pause_btn do
    begin
      Enabled := false;
      Caption := 'resume';
    end;
  end
  else if _statusWorkThread = 'paused' then
  begin
    with start_stop_btn do
    begin
      Enabled := true;
      Caption := 'stop';
    end;
    with resume_pause_btn do
    begin
      Enabled := true;
      Caption := 'resume';
    end;
  end
  else if _statusWorkThread = 'running' then
  begin
    with start_stop_btn do
    begin
      Enabled := true;
      Caption := 'stop';
    end;
    with resume_pause_btn do
    begin
      Enabled := true;
      Caption := 'pause';
    end;
  end;

  status_lbl.Caption := 'status: ' + _statusWorkThread;
  Vcl.Forms.Application.ProcessMessages;
end;

procedure TMyForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(workerThread);
end;

end.
