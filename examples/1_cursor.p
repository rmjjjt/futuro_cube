/*
example_1_cursor.p

Simple example that shows how to get position of cursor and draw it onto the cube.
Color is created each time when the cursor is placed. Function printf can be used
for various debugging purposes. This example also shows typical drawing sequence, which
is usually used in most complex cases:

ClearCanvas() .... draw scene .... PrintCanvas()

Things to try:

1. Replace PrintCanvas() by FlashCanvas(1,1)
1. Remove ClearCanvas()
*/

#include <futurocube>

new i
new c

main()
{
  for (;;)
  {
    i+= 5;
    SetRgbColor(i, i+100, i+200)
    ClearCanvas()
    c=GetCursor()
    DrawPoint(c)
    PrintCanvas()
    //FlashCanvas(1, 1)
    printf("side: %d, square: %d, index: %d\r\n",_side(c), _square(c), _i(c))
    Sleep()
  }
}