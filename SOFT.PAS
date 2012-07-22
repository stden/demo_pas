Uses CRT;

{$I MCGA.PAS }

Var D:Byte; I:Word;
Begin
  Init_Demo;
  Flame_Palette;
  For I:=0 to 63999 do SB^[I]:=Random(256);
  Repeat
    For I:=0 to 63999 do
      Begin
	D:=(SB^[I-1]+SB^[I+1]+SB^[I+320]+SB^[I-320]+
	    SB^[I-321]+SB^[I-319]+SB^[I+321]+SB^[I+319]) shr 3;
	D:=D+Random(4)-1;
	SB^[I+1]:=D;
	SB^[I-1]:=D;
	SB^[I+640]:=D;
	SB^[I-640]:=D;
	SB^[I]:=D;
      End;
    Show;
  Until KeyPressed;
  Full_Soft_Picture(50);
  Close_Demo;
End.