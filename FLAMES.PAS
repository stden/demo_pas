Uses CRT,MCGADemo;

 Type
   FlamesDemo = Object(TFlame)
     N,T,Border:Byte;
     Constructor Init;
     Procedure Step;
   End;

 Constructor FlamesDemo.Init;
   Begin
     Inherited Init;
     N:=10;
     T:=255;
     Border:=100;
   End;

  Procedure FlamesDemo.Step;
    Var D:Byte; I,J:Word;
    Begin
      G^[199,Border-1]:=0;
      G^[199,320-Border+1]:=0;
      For I:=1 to ((160-Border)*N) Shr 7 do
        Begin
           J:=Border+Random(320-(Border Shl 1));
           D:= (G^[199,J+1] + G^[199,J] + G^[199,J-1]) Div 3;
           G^[199,J]:=Ord(D<(T-T Div 5))*T;
        End;
      FlamePicture2;
      Inherited Step;
    End;

Var Demo:FlamesDemo;
Begin
  Demo.Init;
  Repeat
    Demo.Step;
    With Demo do
      If KeyPressed then
        Case ReadKey of
          #27:Break;
          #0:
            Case ReadKey of
              #80:If T>0 then Dec(T);
              #72:If T<255 then Inc(T);
              #75:If Border>5 then Dec(Border);
              #77:If Border<158 then Inc(Border);
              #81:If N>0 then Dec(N);
              #73:If N<255 then Inc(N);
            End;
        End;
  Until False;
  Demo.Done;
End.