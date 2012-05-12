Uses CRT,MCGADemo;

{ $DEFINE MoveFlame}

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
    '-FF +   A-A M M -E+',
    'F   L   - - M-M -  ',
    '--+ L   A A - - -EE',
    'F   L   --- M M -  ',
    '+   LL+ + + M M -E+');
{$ENDIF}
  PixSize=12;
  XText=30;
  YText=100;
  IncStep=20;
  NumPoints=1000;

 Type
   TFlamPoint = Object
     X,Y:Word;
     T:Byte;
     Constructor Init;
     Procedure Reset;
     Procedure Draw;
   End;
   TFlamTxt2 = Object(TFlame)
     Points:Array [1..NumPoints] of TFlamPoint;
     Constructor Init;
     Procedure Step;
   End;

 Constructor TFlamPoint.Init;
   Begin
     Reset;
   End;

 Procedure TFlamPoint.Draw;
   Begin
     If G^[Y,X]<255-T then Inc(G^[Y,X],T) Else G^[Y,X]:=255;
   End;

 Procedure TFlamPoint.Reset;
   Var XC,YC,XS,YS:Byte;
   Begin
     Repeat XC:=Random(19)+1; YC:=Random(5)+1; Until Text[YC,XC]<>' ';
     XS:=Random(PixSize); YS:=Random(PixSize);
     Y:=YText+YC*PixSize+YS;
     X:=XText+XC*PixSize+XS;
     Case Text[YC,XC] of
       '+':T:=IncStep Shl 1;
       '-':T:=IncStep Shr 1;
       '/':T:=1;
       ' ':T:=0;
     Else
       T:=IncStep;
     End;
   End;

 Constructor TFlamTxt2.Init;
   Var I:Word;
   Begin
     Inherited Init;
     For I:=1 to NumPoints do Points[I].Init;
   End;

 Procedure TFlamTxt2.Step;
   Var I:Word;
   Begin
     For I:=1 to NumPoints do Points[I].Draw;
     For I:=1 to NumPoints Div 100 do Points[Random(NumPoints)+1].Reset;
    {$IFDEF MoveFlame}
     FlamePicture2;
    {$ELSE}
     SoftPicture;
    {$ENDIF}
     Inherited Step;
   End;

Var Demo:TFlamTxt2;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.