{$G+}
Uses CRT,MCGADemo;

 Type
   Flames2Demo = Object(TFlame)
     Procedure Step;
   End;

 Procedure Flames2Demo.Step;
   Const Border=10;
   Var D:Byte; I,J:Word; N:Integer;
   Begin
      For I:=1 to 50 do
        Begin
           J:=Border+Random(320-(Border Shl 1));
           D:=(G^[199,J]+G^[199,J-1]) Shr 1;
           G^[199,J]:=Ord(D<128)*255;
        End;
      Asm
        LES  DI,G
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
      Inherited Step;
    End;

Var Demo:Flames2Demo;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.