/*
example_6_disco_cube.p

This example shows an easy way to determine the time of a tap and how to (not completely accurately) extrapolate it to future time.
It does not use mean deviation, so after while it is little bit off beat. If you give 8 taps in a row, cube continues in
given rhythm. Double tap resets the rhythm and a new one can be entered by another 8 taps.
*/

#include <futurocube>

#define SIZE 8

new delays[SIZE]
new index = 0
new st = 0
new motion

new next_ms
new add

draw()
{
  ClearCanvas()
  new i
  for (i = 0;i < 40; i++)
  {
    DrawPoint(GetRnd(54))
    SetRgbColor(GetRnd(256), GetRnd(256), GetRnd(256))
  }
  FlashCanvas(1, 4, 1)
}

ComputeDiff()
{
  new diff[SIZE - 1]
  new i
  add = 0
  for (i= 0; i < (SIZE - 1); i++)
  {
    diff[i] = delays[i + 1] - delays[i];
    add += diff[i];
    printf("%d\r\n", diff[i])
  }

  add /= SIZE - 1
  printf("mean: %d\r\n", add)
  next_ms += add
}

main()
{
 SetIntensity(256)
 Play("UFO")
 RegMotion(TAP_GENERIC)
 RegMotion(TAP_DOUBLE)
 SetDoubleTapLength(200)

  for (;;)
  {
    Sleep()

    motion = Motion()

    if (_is(motion, TAP_DOUBLE))
    {
      st = 0
      index = 0
      SetColor(WHITE)
      ClearCube()
      ClearCanvas()
      DrawCube()
      FlashCanvas(1, 4, 1)
      AckMotion
      motion = 0;
    }

    if (motion)
    {
      if (st == 0)
      {
        delays[index++] = GetAppMsecs()
        if (index != sizeof(delays)) draw()
        if (index >= sizeof(delays))
        {
          next_ms = delays[SIZE - 1]
          ComputeDiff()
          st = 1
          SetColor(cPURPLE)
          ClearCube()
          ClearCanvas()
          DrawCube()
          FlashCanvas(1, 4, 1)
        }
      }
      AckMotion()
    }

    if (st == 1)
    {
      if (GetAppMsecs()>=next_ms)
      {
        draw()
        next_ms+=add
      }
    }
  }
}