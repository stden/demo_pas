Uses CRT,MCGADemo;

 Type
   TWindows = Object(TFlame)
     Constructor Init;
     Procedure Step;
   End;

 Constructor TWindows.Init;
   Var X,Y:Word;
   Begin
     Inherited Init;
     For X:=0 to 319 do
       For Y:=0 to 199 do 
         G^[Y,X]:=Random(256);
   End;

 Procedure TWindows.Step;
   Begin
     Asm
       LES DI,G
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
     Inherited Step;
   End;

Var Demo:TWindows;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.

