program kredensial;

uses
  Forms,
  ServerModule in '..\ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in '..\MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in '..\Main.pas' {MainForm: TUniForm},
  UnitLogin in 'forms\UnitLogin.pas' {frmLogin: TUniLoginForm},
  UnitRegister in 'forms\UnitRegister.pas' {frmRegisters: TUniForm},
  UnitUserProfile in 'units\UnitUserProfile.pas' {frUserProfile: TUniFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
