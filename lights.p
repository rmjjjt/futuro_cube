#include <futurocube>

new c
new cursorSide
new square = 0

new icon[]=[ICON_MAGIC1,ICON_MAGIC2,1,4,
	cGREEN,0,cGREEN,cGREEN,cGREEN,cGREEN,cGREEN,0,cGREEN,
	'''','''']

main()
{
  ICON(icon)
  for (new j = 0; j < 1; j++)
  {
    SetColor(0x00FF0000)
    c=GetCursor()
    cursorSide = _side(c)
    for(;;) {
        lightSide(cursorSide, square)
        Delay(50)
        if(square == 0) {
            square = 3
        } else if(square == 1) {
            square = 4
        } else if(square == 2) {
            square = 5
        } else if(square == 3) {
            square = 6
        } else if(square == 4) {
            square = 7
        } else if(square == 5) {
            square = 8
        } else if(square == 6) {
            square = 1
        } else if(square == 7) {
            square = 2
        } else if(square == 8) {
            square = 0
            if (cursorSide == 5) {
                cursorSide = 0
            } else {
                cursorSide++
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
