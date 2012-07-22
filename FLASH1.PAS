Uses CRT;

{$I MCGA.PAS }

Var D:Byte; I:Word;
Begin
  Init_Demo;
  Flash_Palette;
  Repeat
    For I:=0 to 63999 do
      Begin
	D:=(SB^[I-1]+SB^[I+1]+SB^[I+320]+SB^[I-320]+
	    SB^[I-321]+SB^[I-319]+SB^[I+321]+SB^[I+319]) shr 3;
	D:=D+Random(3);
	SB^[I+2]:=D;
	SB^[I-2]:=D;
	SB^[I+640]:=D;
	SB^[I-640]:=D;
      End;
    Show;
  Until KeyPressed;
  Close_Demo;
End.