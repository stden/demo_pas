Uses CRT;

{$I MCGA.PAS }

Type Demo = Object
       Constructor Init;
       Procedure Step;
       Destructor Done;
     End;

  Constructor Demo.Init;
    Begin
      Flame_Palette;
    End;

   Procedure Demo.Step;
     Const
       Border=10;
     Var D:Byte; I,J:Word;
         N:Integer;
   Begin
      For I:=1 to 50 do
        Begin
           J:=63680+Border+Random(320-(Border Shl 1));
           D:=(SB^[J]+SB^[J-1]) Shr 1;
           SB^[J]:=Ord(D<128)*255;
        End;
      Asm
        LES  DI,SB
        Add  DI,320
        Mov  CX,63360
       @@L:
        Xor  BX,BX
        Xor  AH,AH
        Mov  AL,ES:[DI]
        Add  BX,AX
        Add  BX,AX
        Mov  AL,ES:[DI+1]
        Add  BX,AX
        Mov  AL,ES:[DI-1]
        Add  BX,AX
        Mov  AL,ES:[DI+320]
        Add  BX,AX
        Add  BX,AX
        Mov  AL,ES:[DI-320]
        Add  BX,AX
        Add  BX,AX
        Add  BX,25
        Shr  BX,3
        Mov  ES:[DI-320],BL
        Inc  DI
        Loop @@L
      End;
    End;

  Destructor Demo.Done;
    Begin
      Full_Soft_Picture(100);
    End;

Var _RECYCLED_:Demo;
Begin
  Init_Demo;
  _RECYCLED_.Init;
  Repeat
    _RECYCLED_.Step;
    Show;
  Until KeyPressed;
  _RECYCLED_.Done;
  Close_Demo;
End.