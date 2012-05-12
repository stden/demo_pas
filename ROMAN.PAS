Uses CRT,MCGADemo;

Const Roman : Array [1..5,1..33] of Char =
 (' RRRR   OOO  MM   MM  AAAA N   N ',
  ' R   R O   O M M M M A   A NN  N ',
  ' RRRR  O   O M  M  M AAAAA N N N ',
  ' R   R O   O M     M A   A N  NN ',
  ' R   R  OOO  M     M A   A N   N ');

Const Worms_Num = 50;

 Type
   TRoman = Object(TFlame)
     Worms : Array [1..Worms_Num] of Worm;
     XR,YR,XRS,YRS:Integer;
     Constructor Init;
     Procedure Step;
   End;

 Constructor TRoman.Init;
   Var I:Word;
   Begin
     Inherited Init;
     XR:=70; YR:=80; XRS:=1; YRS:=1;
     SetColor(255,0,28,63);
     For I:=1 to Worms_Num do Worms[I].Init(10+Random(310),10+Random(190));
   End;

  Procedure TRoman.Step;
    Var D:Byte; I,J,X,Y:Word;
    Begin
      XR:=XR+XRS; YR:=YR+YRS;
      If XR>180 then XRS:=-XRS;
      If XR<5 then XRS:=-XRS;
      If YR<10 then YRS:=-YRS;
      If YR>170 then YRS:=-YRS;
      For I:=1 to Worms_Num do Worms[I].Run;
      SoftPicture;
      For I:=1 to 5 do
        For J:=1 to 33 do
	  If Roman[I,J]<>' ' then
	    For X:=0 to 3 do
	      For Y:=0 to 3 do
	        G^[((I Shl 2)+YR+Y),(J Shl 2)+X+XR]:=255;
      Inherited Step;
    End;

Var Demo:TRoman;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.
