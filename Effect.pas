unit Effect;

interface

uses
  raylib;

procedure Main();

implementation

uses
  Math;

type
  // TSnowflake - структура снежинки
  TSnowflake = record
    X: Single;// координата X
    Y: Single;// координата Y
    Speed: Single;// скорость падения
    Size: Integer;// размер
    Time: Single;// локальное время
    TimeDelta: Single;// дельта изменения времени
  end;

const
  WindowWidth = 800;
  WindowHeight = 600;

const
  SnowflakeCount = 600;

var
  Snow: array [0..SnowflakeCount - 1] of TSnowflake;

function MakeSnowflake: TSnowflake;
const
  MaxSpeed = 5;
  MaxSize = 5;
  Bounds = 30;
  MaxTimeDelta = 0.0015;
begin
  // задаем случайную координату по X
  Result.X := RandomRange(-Bounds, WindowWidth + Bounds);
  // обнуляем Y
  Result.Y := -MaxSize;
  // задаем случайную скорость падения
  Result.Speed := 0.5 + Random * MaxSpeed;
  // задаем случайный размер
  Result.Size := RandomRange(2, MaxSize);
  // задем время
  Result.Time := Random * 2 * Pi;
  // задаем величину приращивания времени
  Result.TimeDelta := Random * MaxTimeDelta;
end;

procedure Update();
var
  I: Integer;
begin
  for I := 0 to High(Snow) do
  begin
    // приращиваем координату по Y
    Snow[I].Y := Snow[I].Y + Snow[I].Speed;
    // увеличиваем время
    Snow[I].Time := Snow[I].Time + Snow[I].TimeDelta;
    // пересоздаем снежинку, если она упала за границы формы
    if Snow[I].Y > WindowHeight then
      Snow[I] := MakeSnowflake;
  end;
end;

procedure Draw();
var
  I: Integer;
  T, DeltaX: Single;
  Size, X, Y: Integer;
begin
  BeginDrawing();

    ClearBackground(BLACK);

    DrawFPS(10, 10);

    for I := 0 to High(Snow) do
    begin
      // получаем размер
      Size := Snow[I].Size;

      T := Snow[I].Time;

      // вычисляем смещение
      DeltaX := Sin(T * 27) + Sin(T * 21.3) + 3 * Sin(T * 18.75) +
        7 * Sin(T * 7.6) + 10 * Sin(T * 5.23);

      DeltaX := DeltaX * 10;

      // получаем X
      X := Trunc(Snow[I].X + DeltaX);
      // получаем Y
      Y := Trunc(Snow[I].Y);

      // рисуем круг по координатам X, Y, с диаметром Size
      DrawCircle(X, Y, Size, WHITE);
    end;

  EndDrawing();
end;

procedure Main();
var
  I: Integer;
begin
  // Initialization
  //---------------------------------------------------------------------------------------------
  SetConfigFlags(FLAG_WINDOW_HIGHDPI or FLAG_MSAA_4X_HINT);
  InitWindow(WindowWidth, WindowHeight, UTF8String('raylib [core] example - basic window'));

  SetTargetFPS(60); // Set our game to run at 60 frames-per-second

  // make snowflakes
  for I := 0 to High(Snow) do
    Snow[I] := MakeSnowflake;
  //---------------------------------------------------------------------------------------------

  // Main game loop
  while not WindowShouldClose() do  // Detect window close button or ESC key
  begin
    // Update
    //-------------------------------------------------------------------------------------------
    Update();
    //-------------------------------------------------------------------------------------------

    // Draw
    //-------------------------------------------------------------------------------------------
    Draw();
    //-------------------------------------------------------------------------------------------
  end;

  // De-Initialization
  //---------------------------------------------------------------------------------------------
  CloseWindow();        // Close window and OpenGL context
  //---------------------------------------------------------------------------------------------
end;

end.
