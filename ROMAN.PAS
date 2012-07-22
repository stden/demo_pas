Uses CRT;

{$I MCGA.PAS}

Const Roman : Array [1..5,1..33] of Char =
 (' RRRR   OOO  MM   MM  AAAA N   N ',
  ' R   R O   O M M M M A   A NN  N ',
  ' RRRR  O   O M  M  M AAAAA N N N ',
  ' R   R O   O M     M A   A N  NN ',
  ' R   R  OOO  M     M A   A N   N ');

Const Worms_Num = 50;

Var Worms : Array [1..Worms_Num] of Worm;
    I,J,XR,YR:Word; D,X,Y:Byte; XRS,YRS:ShortInt;
Begin
  Init_Demo;
  Flame_Palette;
  XR:=70; YR:=80; XRS:=2; YRS:=2;
  Set_Color(255,0,63,63);
  For I:=0 to 63999 do SB^[I]:=0;
  For I:=1 to Worms_Num do Worms[I].Init(10+Random(310),10+Random(190));
  Repeat
    XR:=XR+XRS; YR:=YR+YRS;
    If XR>180 then XRS:=-XRS;
    If XR<5 then XRS:=-XRS;
    If YR<10 then YRS:=-YRS;
    If YR>170 then YRS:=-YRS;
    For I:=1 to Worms_Num do Worms[I].Run;
    Soft_Picture;
    For I:=1 to 5 do
      For J:=1 to 33 do
	If Roman[I,J]<>' ' then
	  For X:=0 to 3 do
	    For Y:=0 to 3 do
	      SB^[((I Shl 2)+YR+Y)*320+(J Shl 2)+X+XR]:=255;
    Show;
  Until KeyPressed;
  Full_Soft_Picture(100);
  Close_Demo;
End.