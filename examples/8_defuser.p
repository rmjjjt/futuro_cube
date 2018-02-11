/*
example_8_defuser.p

This example is simple game. Bombs are placed randomly on the cube surface and they must be defused by
placing cursor on them followed by a generic tap. Time is limited and every bomb counts for the
final score.
If the defusing goes well, frequency and speed of bombs goes up, so more points can be achieved. This example also
shows how to create a customized icon in the script.
*/

#include <futurocube>

new len = 5
new time_step = 500
new bomb
new cursor
new defuse

new icon[]=[ICON_MAGIC1, ICON_MAGIC2, 0, 0, RED, BLUE, RED, BLUE, RED, BLUE, GREEN, GREEN, GREEN,
''INSTRM2'', ''UFO'']

new missed_flag = 0

draw()
{
  ClearCanvas()

  if (missed_flag)
  {
    SetColor(RED)
    DrawCube()
    missed_flag--
  }

  SetColor(cORANGE)
  DrawCross(bomb, len)
  SetRgbColor(0xFF, 0xFF, 0xFF)
  DrawPoint(bomb)
  if (_i(bomb) == _i(cursor)) SetColor(cRED)
  else SetColor(cMAGENTA)
  DrawPoint(cursor)

  if (GetTimer(1))
  {
    SetColor(cPURPLE)
    DrawSquare(defuse)
  }

  PrintCanvas()
}

new score=0

over()
{
  new i
  SetRgbColor(255, 255, 255)
  Play("snd1")
  for (i=0; i<25; i++)
  {
    Delay(41)
    ClearCanvas()
    DrawCube()
    PrintCanvas()
    Delay(41)
    ClearCanvas()
    PrintCanvas()
  }
  Quiet()
  Score(score)
}

main()
{
  new good = 0
  new missed = 0

  ICON(icon)
  RegMotion(TAP_GENERIC)
  bomb = GetRnd(54)
  SetTimer(0, time_step)

  new warn=0

  for(;;)
  {
    Sleep()
    if (GetAppMsecs() > 40000) warn = 1
    if (GetAppMsecs() > 50000) over()

    cursor = GetCursor()
    if (!GetTimer(0))
    {
      if (len > 0) len--
      else
      {
        Play("kap")
        missed_flag = 10
        PrintCanvas()
        bomb = GetRnd(54)
        len = 5
        if (time_step < 500) time_step += 20
        good = 0
        missed++
      }
      SetTimer(0, time_step)
    }

    if (warn && GetTimer(2) == 0)
    {
      Play("bell1");
      SetTimer(2,1000);
    }

    if (Motion())
    {
      if (_i(cursor) == _i(bomb))
      {
        Play("vzum")
        SetTimer(1, 500)
        defuse = bomb
        bomb = GetRnd(54)
        len = 5
        good++
        score++
        if (missed == 0 || good >= 3)
        {
          if (time_step > 150) time_step -= 20
          good = 0
        }
        SetTimer(0, time_step)
      }
    }
    AckMotion
    draw()
  }
}