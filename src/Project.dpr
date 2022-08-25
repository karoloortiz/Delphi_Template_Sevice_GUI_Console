program Project;




{$R 'KLib.Windows.EventLog.Messages.res' 'boundaries\KLib\Delphi_Utils_Library\KLib.Windows.EventLog.Messages\KLib.Windows.EventLog.Messages.rc'}

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {MyForm},
  Vcl.SvcMgr,
  MyServiceApplication in 'MyServiceApplication.pas',
  MainService in 'MainService.pas' {MyService: TService},
  ShellParams in 'ShellParams.pas',
  KLib.Constants in 'boundaries\KLib\Delphi_Utils_Library\KLib.Constants.pas',
  KLib.Generic in 'boundaries\KLib\Delphi_Utils_Library\KLib.Generic.pas',
  KLib.Graphics in 'boundaries\KLib\Delphi_Utils_Library\KLib.Graphics.pas',
  KLib.Indy in 'boundaries\KLib\Delphi_Utils_Library\KLib.Indy.pas',
  KLib.IniFiles in 'boundaries\KLib\Delphi_Utils_Library\KLib.IniFiles.pas',
  KLib.Math in 'boundaries\KLib\Delphi_Utils_Library\KLib.Math.pas',
  KLib.MemoryRAM in 'boundaries\KLib\Delphi_Utils_Library\KLib.MemoryRAM.pas',
  KLib.MyIdFTP in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyIdFTP.pas',
  KLib.MyIdHTTP in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyIdHTTP.pas',
  KLib.MyString in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyString.pas',
  KLib.MyStringList in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyStringList.pas',
  KLib.StreamWriterUTF8NoBOMEncoding in 'boundaries\KLib\Delphi_Utils_Library\KLib.StreamWriterUTF8NoBOMEncoding.pas',
  KLib.Types in 'boundaries\KLib\Delphi_Utils_Library\KLib.Types.pas',
  KLib.Utils in 'boundaries\KLib\Delphi_Utils_Library\KLib.Utils.pas',
  KLib.Validate in 'boundaries\KLib\Delphi_Utils_Library\KLib.Validate.pas',
  KLib.VC_Redist in 'boundaries\KLib\Delphi_Utils_Library\KLib.VC_Redist.pas',
  KLib.Windows in 'boundaries\KLib\Delphi_Utils_Library\KLib.Windows.pas',
  KLib.WindowsService in 'boundaries\KLib\Delphi_Utils_Library\KLib.WindowsService.pas',
  KLib.XML in 'boundaries\KLib\Delphi_Utils_Library\KLib.XML.pas',
  Application in 'Application\domain\Application.pas',
  Env in 'Env.pas',
  KLib.Windows.EventLog in 'boundaries\KLib\Delphi_Utils_Library\KLib.Windows.EventLog.pas',
  KLib.MyThread in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyThread.pas';

{$r *.res}


var
  serviceModeEnabled: boolean;

begin
  ApplicationShellParams.read;

  if not ApplicationShellParams.help then
  begin
    serviceModeEnabled := checkIfCurrentProcessIsAServiceProcess;

    if (serviceModeEnabled) or (ApplicationShellParams.install) or (ApplicationShellParams.uninstall) then
    begin
      if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing then
      begin
        Vcl.SvcMgr.Application.Initialize;
      end;
      Vcl.SvcMgr.Application.CreateForm(TMyService, MyService);
  if ApplicationShellParams.install then
      begin
        TMyServiceApplication(Vcl.SvcMgr.Application).myRegisterServices(true, ApplicationShellParams.silent); //used to bypass RegisterServices not virtual method
      end
      else if ApplicationShellParams.uninstall then
      begin
        TMyServiceApplication(Vcl.SvcMgr.Application).myRegisterServices(false, ApplicationShellParams.silent); //used to bypass RegisterServices not virtual method
      end
      else
      begin
        Vcl.SvcMgr.Application.Run;
      end;
    end
    else
    begin
{$ifdef DEBUG}
      ReportMemoryLeaksOnShutdown := true;
{$endif}
      Vcl.Forms.Application.Initialize;
      Vcl.Forms.Application.CreateForm(TMyForm, MyForm);
      Vcl.Forms.Application.MainFormOnTaskbar := True;
      Vcl.Forms.Application.Run;
    end;
  end
  else
  begin
    myAttachConsole;
    Writeln(HELP_MESSAGE);
  end;

end.
