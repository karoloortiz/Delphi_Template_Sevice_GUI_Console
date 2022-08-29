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
    _uninstall_service_btn: TButton;
    _service_manager_pnl: TPanel;
    service_status: TLabel;
    _service_name_lbl: TLabel;
    _workThread_manager_pnl: TPanel;
    service_name: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure start_stop_btnClick(Sender: TObject);
    procedure resume_pause_btnClick(Sender: TObject);
    procedure install_service_btnClick(Sender: TObject);
    procedure _uninstall_service_btnClick(Sender: TObject);
  private
    workerThread: TMyThread;
    _status: string;
    procedure onStatusChanged(var Msg: TMessage); message WM_STATUS_CHANGED;
  public
    { Public declarations }
  end;

var
  MyForm: TMyForm;

implementation

{$r *.dfm}


uses
  Application,
  KLib.Windows, KLib.Constants, KLib.MyService.Utils;

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
      _status := value;
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
begin
  KLib.MyService.Utils.installService(false, service_name.Text);
end;

procedure TMyForm._uninstall_service_btnClick(Sender: TObject);
begin
  KLib.MyService.Utils.uninstallService(false, service_name.Text);
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

procedure TMyForm.onStatusChanged(var Msg: TMessage);
begin
  if _status = '_' then
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
  else if _status = 'created' then
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
  else if _status = 'stopped' then
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
  else if _status = 'paused' then
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
  else if _status = 'running' then
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

  status_lbl.Caption := 'status: ' + _status;
  Vcl.Forms.Application.ProcessMessages;
end;

procedure TMyForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(workerThread);
end;

end.
