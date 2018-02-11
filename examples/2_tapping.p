/*
example_2_tapping.p

This example shows how to easily setup taps to sides to be recognized. Also, double tap signal is
used for lighting up the entire cube.
It also shows how to use palette colors and how to set up them from arrays. Palette colors are those
represented by a number lower than 256. (lower 8-bits at color value)
*/

#include <futurocube>

new motion
new i
new palette[] = [cBLUE, cRED, cORANGE, cMAGENTA, cPURPLE]
//note that palette is filled from index 1, index zero has color 0x00000000

main()
{
  RegAllSideTaps()
  RegMotion(TAP_DOUBLE)
  SetIntensity(256)
  SetDoubleTapLength(500)
  PaletteFromArray(palette)
  i = 1
  SetColor(i)

  for (;;)
  {
    motion = Motion()
    if (motion)
    {
      Play("drip")
      if (++i > sizeof(palette)) i = 1
      SetColor(i)
      if (_is(motion, TAP_DOUBLE))
      {
       DrawCube()
       Vibrate(150)
      }
      DrawSide(eTapSide())
      AckMotion()
     }
    PrintCanvas()
    Sleep()
  }
}