program Project;

{$R 'KLib.Windows.EventLog.Messages.res' 'boundaries\KLib\Delphi_Utils_Library\KLib.Windows.EventLog.Messages\KLib.Windows.EventLog.Messages.rc'}


uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {MyForm} ,
  Vcl.SvcMgr,
  MainService in 'MainService.pas' {MyMainService: TService} ,
  App.ShellParams in 'App\domain\App.ShellParams.pas',
  App.Settings in 'App\domain\App.Settings.pas',
  App.Env in 'App\domain\App.Env.pas',
  App.ThreadVersion in 'App\domain\App.ThreadVersion.pas',
  App.HttpServerVersion in 'App\domain\App.HttpServerVersion.pas',
  App in 'App\domain\App.pas',
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
  KLib.Windows.EventLog in 'boundaries\KLib\Delphi_Utils_Library\KLib.Windows.EventLog.pas',
  KLib.MyThread in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyThread.pas',
  KLib.MyService in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyService.pas' {MyService: TService} ,
  KLib.MyServiceApplication in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyServiceApplication.pas',
  KLib.MyService.Utils in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyService.Utils.pas',
  KLib.Generic.Ini in 'boundaries\KLib\Delphi_Utils_Library\KLib.Generic.Ini.pas',
  KLib.Generic.ShellParams in 'boundaries\KLib\Delphi_Utils_Library\KLib.Generic.ShellParams.pas',
  KLib.Generic.Attributes in 'boundaries\KLib\Delphi_Utils_Library\KLib.Generic.Attributes.pas',
  KLib.MyIdHTTPServer in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyIdHTTPServer.pas',
  KLib.MyEvent in 'boundaries\KLib\Delphi_Utils_Library\KLib.MyEvent.pas',
  KLib.ServiceAppPort in 'boundaries\KLib\Delphi_Utils_Library\KLib.ServiceAppPort.pas',
  KLib.ServiceApp.ThreadAdapter in 'boundaries\KLib\Delphi_Utils_Library\KLib.ServiceApp.ThreadAdapter.pas',
  KLib.ServiceApp.HttpServerAdapter in 'boundaries\KLib\Delphi_Utils_Library\KLib.ServiceApp.HttpServerAdapter.pas',
  Winapi.Windows,
  System.SysUtils;

{$r *.res}


var
  //############################################################################
  // SELECT THREAD OR HTTPSERVER VERSION
  // TEMPLATE OF APPLICATIONS
  //----------------------------------------------------------------------------
  //  _App: App.ThreadVersion.TApp;
  _App: App.HttpServerVersion.TApp;
  //----------------------------------------------------------------------------
  //############################################################################

begin
  case executionMode of
    TExecutionMode.gui:
      begin
{$ifdef DEBUG}
        ReportMemoryLeaksOnShutdown := true;
{$endif}
        Vcl.Forms.Application.Initialize;
        Vcl.Forms.Application.CreateForm(TMyForm, MyForm);
        Vcl.Forms.Application.MainFormOnTaskbar := True;
        Vcl.Forms.Application.Run;
      end;
    TExecutionMode.service:
      begin
        //with runParams
        _App := getApp;
        runService(_App, runServiceParams);
        //or inherited MODE
        //        if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing then
        //        begin
        //          Vcl.SvcMgr.Application.Initialize;
        //        end;
        //        Vcl.SvcMgr.Application.CreateForm(TMyMainService, MyService);
        //        Vcl.SvcMgr.Application.Run;
      end;
    TExecutionMode.console:
      begin
        myAttachConsole(not shellParamsApp.run);
        if shellParamsApp.serviceName <> EMPTY_STRING then
        begin
          installServiceParams.serviceName := shellParamsApp.serviceName;
        end;
        if shellParamsApp.install then
        begin
          KLib.MyService.Utils.installService(installServiceParams);

          Writeln('Service installed.');
        end
        else if shellParamsApp.uninstall then
        begin
          KLib.MyService.Utils.uninstallService(installServiceParams);

          Writeln('Service uninstalled.');
        end
        else if shellParamsApp.run then
        begin
          _App := getApp();
          try
            _App.start;
            Writeln('App running...');
            _App.waitUntilIsRunning;
          except
            on E: Exception do
            begin
              Writeln(E.Message);
            end;
          end;
        end
        else if shellParamsApp.help then
        begin
          Writeln(HELP_MESSAGE);
        end
        else
        begin
          Writeln('Invalid option.');
          Writeln(HELP_MESSAGE);
        end;
      end;
  end;

end.
