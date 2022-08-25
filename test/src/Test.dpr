program Test;

uses
  Vcl.Forms,
  TestUnit in 'TestUnit.pas' {Form1};

{$r *.res}


begin
{$ifdef DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$endif}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
