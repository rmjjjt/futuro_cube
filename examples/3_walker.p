/*
example_3_walker.p

This example shows how to walk with walker by tapping the sides. If a tap from the same
side is detected, walker will continue his direction. Orientation of walker can
be optionally displayed by debug function DrawTail. If a tap from the bottom is detected, red color
cube is displayed. AdjustCanvas is used to demonstrate how to fade without using FlashCanvas.
*/

#include <futurocube>

new player
new up_down

main()
{
  RegAllSideTaps()
  player = GetCursor()

  for (;;)
  {
    //dimming of canvas
    AdjCanvas(-1)

    //motion detected
    if (Motion())
    {
      //tap is from same or opposite side
      if (WalkerTap(player, up_down) == 0)
      {
        //same side, move
        if (up_down == 1) WalkerMove(player)
        // opposite side , red cube
        else
        {
          SetColor(RED)
          Vibrate(200)
          DrawCube()
        }
      }
      AckMotion()
    }

    SetColor(WHITE)
    DrawPoint(player)
    PrintCanvas()
    Sleep()
  }
}