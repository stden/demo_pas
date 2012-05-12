Uses CRT,MCGADemo;

 Type
   TSoft = Object(TFlame)
     Constructor Init;
     Procedure Step;
   End;

 Constructor TSoft.Init;
   Var X,Y:Word;
   Begin
     Inherited Init;
     For Y:=0 to 199 do
       For X:=0 to 319 do
         G^[Y,X]:=Random(256);
   End;

  Procedure TSoft.Step;
    Var D:Byte; I,J,X,Y:Word;
    Begin
      For Y:=0 to 199 do
        For X:=0 to 319 do
          Begin
	    D:=(G^[Y,X-1]+G^[Y,X+1]+G^[Y+1,X]+G^[Y-1,X]+
	        G^[Y-1,X-1]+G^[Y-1,X+1]+G^[Y+1,X+1]+G^[Y+1,X-1]) shr 3;
            D:=D+Random(4)-1;
	    G^[Y,X+1]:=D;
	    G^[Y,X-1]:=D;
	    G^[Y+2,X]:=D;
	    G^[Y-2,X]:=D;
	    G^[Y,X]:=D;
          End;
      Inherited Step;
    End;

Var Demo:TSoft;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.
