Uses CRT,MCGADemo;

 Type
   TFlash1 = Object(TDemo)
     Constructor Init;
     Procedure Step;
   End;

 Constructor TFlash1.Init;
   Begin
     Inherited Init;
     FlashPalette;
   End;

 Procedure TFlash1.Step;
   Var D:Byte; Y,X:Word;
   Begin
    For Y:=0 to 199 do
      For X:=0 to 319 do
        Begin
	  D:=(G^[Y,X-1]+G^[Y,X+1]+G^[Y+1,X]+G^[Y-1,X]+
	      G^[Y-1,X-1]+G^[Y-1,X+1]+G^[Y+1,X-1]+G^[Y+1,X+1]) shr 3;
   	  D:=D+Random(3);
	  G^[Y,X+2]:=D;
	  G^[Y,X-2]:=D;
	  G^[Y+2,X+640]:=D;
	  G^[Y-2,X-640]:=D;
        End;
     Inherited Step;
   End;

 Type
   TFlash2 = Object(TDemo)
     Constructor Init;
     Procedure Step;
   End;

 Constructor TFlash2.Init;
   Begin
     Inherited Init;
     FlashPalette;
     G^[101,0]:=255;
   End;

 Procedure TFlash2.Step;
   Var D:Byte; Y,X:Word;
   Begin
    For Y:=0 to 199 do
      For X:=0 to 319 do
        Begin
          D:=(G^[Y,X-1]+G^[Y,X+1]+G^[Y+1,X]+G^[Y-1,X]+
              G^[Y-1,X-1]+G^[Y-1,X-1]+G^[Y+1,X+1]+G^[Y+1,X-1]) shr 3;
          D:=D+Random(16);
          G^[Y,X+2]:=D-Random(8);
          G^[Y,X-2]:=D-Random(8);
          G^[Y+2,X]:=D-Random(8);
          G^[Y-2,X]:=D-Random(8);
        End;
     Inherited Step;
   End;

Var Demo:TFlash1;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.
