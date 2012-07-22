Uses CRT;

{$I MCGA.PAS }

Var I:Word;
Begin
  Init_Demo;
  Red_Palette;
  For I:=0 to 63999 do SB^[I]:=Random(256);
  Repeat
    Asm
      LES DI,SB
     @@P:
      Mov AL,ES:[DI]
      Cmp AL,0
      JE  @@L
      Dec AL
      Mov ES:[DI+1],AL
      Mov ES:[DI+320],AL
      Mov ES:[DI-320],AL
      Mov ES:[DI],AL
      Add AL,2
      Mov ES:[DI-1],AL
     @@L:
      Inc DI
      Cmp DI,64000
      JNE @@P
    End;
    Show;
  Until KeyPressed;
  Full_Soft_Picture(50);
  Close_Demo;
End.