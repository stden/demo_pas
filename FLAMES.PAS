Uses CRT;

{$I MCGA.PAS }

Type Demo = Object
       NNN,TTT,Border:Byte;
       Constructor Init;
       Procedure Step;
       Destructor Done;
     End;

  Constructor Demo.Init;
    Begin
      Flame_Palette;
      FillChar(SB^,64000,0);
      NNN:=10;
      TTT:=255;
      Border:=100;
    End;

   Procedure Demo.Step;
     Var D:Byte; I,J:Word;
         N:Integer;
   Begin
      J:=63680+Border-1;
      SB^[J]:=0;
      J:=63680+320-Border+1;
      SB^[J]:=0;
      For I:=1 to ((160-Border)*NNN) Shr 7 do
        Begin
           J:=63680+Border+Random(320-(Border Shl 1));
           D:=(SB^[J+1]+SB^[J]+SB^[J-1]) Div 3;
           SB^[J]:=Ord(D<(TTT-TTT Div 5))*TTT;
        End;
      Flame_Picture_2;
    End;

  Destructor Demo.Done;
    Begin
      Full_Soft_Picture(50);
    End;

Var _RECYCLED_:Demo;
Begin
  Init_Demo;
  _RECYCLED_.Init;
  Repeat
    _RECYCLED_.Step;
    Show;
    If KeyPressed then
      Case ReadKey of
        #27:Break;
        #0:
          With _RECYCLED_ do
            Case ReadKey of
              #80:If TTT>0 then Dec(TTT);
              #72:If TTT<255 then Inc(TTT);
              #75:If Border>5 then Dec(Border);
              #77:If Border<158 then Inc(Border);
              #81:If NNN>0 then Dec(NNN);
              #73:If NNN<255 then Inc(NNN);
            End;
      End;
  Until False;
  _RECYCLED_.Done;
  Close_Demo;
End.