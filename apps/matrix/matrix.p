#include <futurocube>

new c
new j
new cursorSide
new square = 0

// Set a green 'M' as the icon
new icon[] = [ICON_MAGIC1, ICON_MAGIC2, 1, 4,
	cGREEN,0, cGREEN, cGREEN, cGREEN, cGREEN, cGREEN, 0, cGREEN,
	'''', '''']

main()
{
  ICON(icon)
  for (j = 0; j < 1; j++)
  {
    SetColor(0x00FF0000)
    c = GetCursor()
    cursorSide = _side(c)
    for(;;) {
      lightSide(cursorSide, square)
      Delay(50)
      switch (square)
      {
        case 0: square = 3
        case 1: square = 4
        case 2: square = 5
        case 3: square = 6
        case 4: square = 7
        case 5: square = 8
        case 6: square = 1
        case 7: square = 2
        case 8: {
          square = 0
          if (cursorSide == 5) {
            cursorSide = 0
          } else {
            cursorSide++
          }
        }
      }
      printf("cursor side: %d\r\n", cursorSide)
    }
  }
}

lightSide(side, light) {
  ClearCanvas()
  DrawPoint(_w(side, light))
  PrintCanvas()
  printf("side: %d, square: %d\r\n", side, light)
}
