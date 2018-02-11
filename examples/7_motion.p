/*
  example_7_motion.p

  Motion detector - by Josip Miskovic
  This example shows a bit of advanced working with raw accelerometer data.
  It detects motion and colors of the whole cube depending on motion direction. Mildly amusing.
*/

#include <futurocube>


const MAXACC = 2040
const HEAT_DIV = 10
const COOLDOWN = 3

main()
{
  new acc1[3] = [0]
  new acc2[3] = [0]
  new dacc[3] = [0]
  new flip = false
  new red = 0
  new green = 0
  new blue = 0
  for(;;)
  {
    Sleep()
    // substruct current from previous values, the easiest way to eliminate gravity bias
    if (flip)
    {
      ReadAcc(acc1, 1)
      dacc[0] = abs(acc1[0] - acc2[0])
      dacc[1] = abs(acc1[1] - acc2[1])
      dacc[2] = abs(acc1[2] - acc2[2])
    } else {
      ReadAcc(acc2, 0)
      dacc[0] = abs(acc2[0] - acc1[0])
      dacc[1] = abs(acc2[1] - acc1[1])
      dacc[2] = abs(acc2[2] - acc1[2])
    }
    flip = !flip
    // sum of all three directions, play sound if it's strong enough
    new sum = abs(dacc[0]) + abs(dacc[1]) + abs(dacc[2])
    if(sum > 100)
      Play("bubble")

    // set color depending on direction, but increase and decrease gradually
    red = dacc[0] > 30 ? red + dacc[0] / HEAT_DIV : red - COOLDOWN
    if (red < 0)
      red = 0
    if (red > 255)
      red = 255

    green = dacc[1] > 30 ? green + dacc[1] / HEAT_DIV : green - COOLDOWN
    if (green < 0)
      green = 0
    if (green > 255)
      green = 255

    blue = dacc[2] > 30 ? blue + dacc[2] / HEAT_DIV : blue - COOLDOWN
    if (blue < 0)
      blue = 0
    if (blue > 255)
      blue = 255

    SetRgbColor(red, green, blue)
    ClearCanvas
    for (new i = 0; i < 54; i++)
    {
      DrawPoint(i)
    }
    PrintCanvas
  }
}