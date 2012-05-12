{ * DiabloDemo * }
Uses CRT,MCGADemo;

Type DiabloDemo = Object(TDemo)
       Constructor Init;
       Procedure Step;
     End;

  Constructor DiabloDemo.Init;
    Var I,J:Word;
    Begin
      Inherited Init;
      For I:=0 to 199 do
        For J:=0 to 319 do G^[I,J]:=Random(256);
      SetColor(0,31,31,31);
      SetColor(1,0,0,31);
      SetColor(2,0,0,15);
      For I:=3 to 255 do SetColor(I,0,15,0);
    End;

  Procedure DiabloDemo.Step;
    Var D:Byte; I:Word;
    Begin
      Asm
        LES  DI,G
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
      Inherited Step;
    End;

Var Demo:DiabloDemo;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.
