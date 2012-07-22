Uses CRT;

{$I MCGA.PAS }

Var D:Byte; I:Word;
Begin
  Init_Demo;
  Flash_Palette;
  SB^[32320]:=255;
  Repeat
    For I:=0 to 63999 do
      Begin
        D:=(SB^[I-1]+SB^[I+1]+SB^[I+320]+SB^[I-320]+
            SB^[I-321]+SB^[I-319]+SB^[I+321]+SB^[I+319]) shr 3;
        D:=D+Random(16);
        SB^[I+2]:=D-Random(8);
        SB^[I-2]:=D-Random(8);
        SB^[I+640]:=D-Random(8);
        SB^[I-640]:=D-Random(8);
      End;
    Show;
  Until KeyPressed;
  Close_Demo;
End.