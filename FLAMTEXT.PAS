Uses CRT,MCGADemo;

{$DEFINE MoveFlame}

Const
{$IFDEF MoveFlame}
  Text:Array [1..5,1..19] Of Char=(
    '/FF -   /A/ / / /--',
    '-   -   / / M+M -  ',
    'F++ -   - - - - ---',
    '-   -   -+- - - -  ',
    '+   +++ + + + + +++');
{$ELSE}
  Text:Array [1..5,1..19] Of Char=(
    'FFF +   -A- M M -E+',
    'F   L   - - M-M E  ',
    '--F L   A A - - --E',
    'F   L   --- M M E  ',
    '+   LL+ + + M M -E+');
{$ENDIF}
  PixSize=12;
  XText=30;
  YText=100;
  IncStep=18;

 Type
   TFlamText = Object(TFlame)
     Procedure Step;
   End;

 Procedure TFlamText.Step;
  Var I,X,Y:Word; XC,YC,XS,YS,Incr:Byte;
  Begin
    For I:=1 to 2000 do
      Begin
        XC:=Random(19)+1;
        YC:=Random(5)+1;
        If Text[YC,XC]<>' ' then
          Begin
            XS:=Random(PixSize);
            YS:=Random(PixSize);
            Y := YText+YC*PixSize+YS;
            X := XText+XC*PixSize+XS;
            Case Text[YC,XC] of
              '+':Incr:=IncStep Shl 1;
              '-':Incr:=IncStep Shr 1;
              '/':Incr:=1;
            Else
              Incr:=IncStep;
            End;
            If G^[Y,X]<=255-Incr then G^[Y,X]:=G^[Y,X]+Incr Else G^[Y,X]:=255;
          End;
      End;
   {$IFDEF MoveFlame}
    FlamePicture;
   {$ELSE}
    SoftPicture;
   {$ENDIF}
    Inherited Step;
  End;

Var Demo:TFlamText;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.