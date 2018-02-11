/*
example_5_animated_rubiks.p

This example shows the simple implementation of rubik's cube with animated rotations.
Direction of rotation is determined by the inclination of the tapped side.
SolveDir function reads accelerometer data and compares it with threshold "ACC_THRESHOLD"
for direction. Also each move is stored into a variable, so the progress is never lost.
Example of correct use of ICON() is demonstrated as well. Note that definition of icon[]
must be placed in global namespace!
*/

#include <futurocube>

#define SPEED_STEP 10
#define ACC_THRESHOLD 150

new icon[] = [ICON_MAGIC1, ICON_MAGIC2, 1, 1, GREEN, GREEN, 0, GREEN, GREEN, 0, GREEN, 0, GREEN, ''bongo'',''UFO'']

new colors[] = [cBLUE, cGREEN, cORANGE, cMAGENTA, cRED, cPURPLE]
new cube[54]
new motion
new kick_side
new dirdecide

new rubik_var[] = [VAR_MAGIC1, VAR_MAGIC2, ''animated_rubiks'']


CubeInit()
{
  PaletteFromArray(colors)
  new i
  new face
  new prevface
  new q
  new dir
  if (!LoadVariable(''animated_rubiks'',cube) || IsGameResetRequest())
  {
    for (i=0; i<54; i++) cube[i] = _side(i) + 1
    Draw()
    Play("_g_TAPFORSHUFFLE")
    for (;;)
    {
      Sleep()
      motion = Motion()
      if (motion) break;
    }
    Play("_g_SHUFFLING")
    prevface = -1
    for(i=0; i<30; i++)
    {
      while(face == prevface) face = GetRnd(6)
      prevface = face
      dir = GetRnd(2)
      for(q = GetRnd(2) + 1; q > 0; q--)
      {
        TransformSide(face, dir)
        StoreVariable(''animated_rubiks'', cube)
        Delay(70 - i - i)
      }
    }
    AckMotion()
  }
}

Draw()
{
  ClearCanvas()
  DrawArray(cube)
  PrintCanvas()
}

SolveDir(side)
{
  new acc[3]
  new val
  ReadAcc(acc)
  switch (side)
  {
    case 0: val=acc[2]
    case 1: val=-acc[2]
    case 2: val=-acc[0]
    case 3: val=acc[0]
    case 4: val=acc[1]
    case 5: val=-acc[1]
    default: val=0
  }

  if (val>ACC_THRESHOLD) return 0
  return 1
}


main()
{
  ICON(icon)
  SetIntensity(256)
  RegisterVariable(rubik_var)
  RegAllSideTaps()
  CubeInit()
  Draw()

  for (;;)
  {
    Sleep()
    motion = Motion()

    if (motion)
    {
      kick_side = eTapSide();
      dirdecide = SolveDir(kick_side);
      if (dirdecide != -1)
      {
        if (dirdecide) Play("kap")
        else Play("soko_back")
        TransformSide(kick_side, dirdecide)
        StoreVariable(''animated_rubiks'', cube)
      }
      else Vibrate(100)
      AckMotion()
    }
  }
}

new const _t_side_top[6][12]=[[45,46,47,33,30,27,44,43,42,20,23,26],
                              [53,52,51,24,21,18,36,37,38,29,32,35],
                              [51,48,45,06,03,00,42,39,36,11,14,17],
                              [47,50,53,15,12,09,38,41,44,02,05,08],
                              [18,19,20,00,01,02,27,28,29,09,10,11],
                              [08,07,06,26,25,24,17,16,15,35,34,33]]

new const _t_side_rot[8] = [3, 6, 7, 8, 5, 2, 1, 0]

MakeShift(belt[], length, dir = 1)
{
  new temp
  new i
  if (dir == 1)
  {
    temp = cube[belt[0]]
    for (i = 0; i < (length - 1); i++)
    cube[belt[i]] = cube[belt[i + 1]]
    cube[belt[length - 1]] = temp
  }
  else
  {
    temp = cube[belt[length - 1]]
    for (i = length - 1; i > 0; i--)
    cube[belt[i]] = cube[belt[i - 1]]
    cube[belt[0]] = temp
  }
}

TransformSide(side, dir)
{
  new bbelt[8]
  new i
  for (i = 0; i < 8; i++) bbelt[i] = side * 9 + _t_side_rot[i]

  MakeShift(_t_side_top[side], 12, dir)
  Draw()
  Delay(SPEED_STEP)
  MakeShift(bbelt, 8, dir)
  Draw()
  Delay(SPEED_STEP)
  MakeShift(_t_side_top[side], 12, dir)
  Draw()
  Delay(SPEED_STEP)
  MakeShift(bbelt, 8, dir)
  Draw()
  Delay(SPEED_STEP)
  MakeShift(_t_side_top[side], 12, dir)
  Draw()
}
