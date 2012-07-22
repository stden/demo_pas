Uses CRT;

{$I MCGA.PAS}

Type Demo = Object
       Constructor Init;
       Procedure Run;
     End;

  Constructor Demo.Init;
    Begin
      Flame_Palette;
    End;

  Procedure Demo.Run;
    Procedure Setting(L:Word; N:Byte);
    Begin
       If SB^[L]<N then SB^[L]:=N;
    End;
    Var D:Byte; I:Word;
    Begin
      Inc(Scr[32160],127);
      For I:=0 to 63999 do
        Begin
          D:=Scr[I];
          If D>0 then
            Begin
              Setting(I-1  ,D-Random(4)+1);
              Setting(I+1  ,D-Random(4)+1);
              Setting(I-320,D-Random(4)+1);
              Setting(I+320,D-Random(4)+1);
              SB^[I]:=D-1;
            End;
        End;
    End;

Var D:Demo;
Begin
  Init_Demo;
  D.Init;
  Repeat
    D.Run;
    Show;
  Until KeyPressed;
  Close_Demo;
End.
