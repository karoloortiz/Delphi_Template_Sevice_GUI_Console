//TMyServiceApplication used to bypass RegisterServices not virtual method

unit MyServiceApplication;

interface

uses
  Vcl.SvcMgr;

type
  TMyServiceApplication = class(TServiceApplication)
  public
    procedure myRegisterServices(Install, Silent: Boolean);
  end;

implementation

uses
  Vcl.Forms,
{$if NOT DEFINED(CLR)}
  Winapi.Windows,
{$endif}
  System.SysUtils;

procedure DoneServiceApplication;
begin
  with Vcl.Forms.Application do
  begin
    if Handle <> 0 then
      ShowOwnedPopups(Handle, False);
    ShowHint := False;
    Destroying;
    DestroyComponents;
  end;
  with Application do
  begin
    Destroying;
    DestroyComponents;
  end;
end;

procedure TMyServiceApplication.myRegisterServices(Install, Silent: Boolean);
begin
{$if NOT DEFINED(CLR)}
  AddExitProc(DoneServiceApplication);
{$endif}
  RegisterServices(Install, Silent);
end;

end.
