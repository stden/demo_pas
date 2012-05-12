Uses CRT,MCGADemo;

 Type
   TSqr1 = Object(TFlame)
     Procedure Step;
   End;

 Procedure TSqr1.Step;
   Procedure Setting( Y,X:Word; N:Byte );
     Begin If G^[Y,X]<N then G^[Y,X]:=N; End;
   Var D:Byte; X,Y:Word;
   Begin
     Inc(ScrG^[100,160],127);
     For Y:=0 to 199 do
       For X:=0 to 319 do
         Begin
           D:=ScrG^[Y,X];
           If D>0 then
             Begin
               Setting(Y,X-1,D-Random(4)+1);
               Setting(Y,X+1,D-Random(4)+1);
               Setting(Y-1,X,D-Random(4)+1);
               Setting(Y+1,X,D-Random(4)+1);
               G^[Y,X]:=D-1;
             End;
         End;
     Inherited Step;
   End;

 Type
   TSqr2 = Object(TSqr1)
     Constructor Init;
   End;

 Constructor TSqr2.Init;
   Var I:Word; N:Byte;
   Begin
     Inherited Init;
     For I:=0 to 127 do
       Begin
         SetColor(I,0,I shr 1,I shr 1);
         N:=(63-(I Shr 1))*((I Shr 2)And 1);
         SetColor(255-I,N,N,I Shr 1);
       End;
   End;

Var Demo:TSqr1;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.


