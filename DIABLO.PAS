Uses CRT;

{$I MCGA.PAS}

Type Demo = Object
       Constructor Init;
       Procedure Run;
     End;

  Constructor Demo.Init;
    Var I:Word;
    Begin
      For I:=0 to 63999 do SB^[I]:=Random(256);
      Set_Color(0,31,31,31);
      Set_Color(1,0,0,31);
      Set_Color(2,0,0,15);
      For I:=3 to 255 do Set_Color(I,0,15,0);
    End;

  Procedure Demo.Run;
    Var D:Byte; I:Word;
    Begin
      Asm
        LES  DI,SB
        Mov  CX,63999
       @@L:
        Mov  AL,ES:[DI]
        Cmp  AL,0
        JE   @@Z
        Dec  AL
        Mov  ES:[DI-1],AL
        Mov  ES:[DI+1],AL
        Mov  ES:[DI-320],AL
        Mov  ES:[DI+320],AL
        Add  AL,2
        Mov  ES:[DI],AL
       @@Z:
        Inc  DI
        Loop @@L
      End;
      Show;
    End;

Var D:Demo;
Begin
  Init_Demo;
  D.Init;
  Repeat
    D.Run;
  Until KeyPressed;
  Close_Demo;
End.
