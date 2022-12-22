program RaylibSnow;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Effect in 'Effect.pas',
  raylib in 'raylib\raylib.pas';

begin
  try
    Main();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
