Uses CRT;

{$I MCGA.PAS}
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
  NumPoints=500;

Type
  TFlamPoint=
    Object
      Coord:Word;
      T:Byte;
      Constructor Init;
      Destructor Done;
      Procedure Reset;
      Procedure Draw;
    End;
  TDemo=
    Object
      Points:Array [1..NumPoints] of TFlamPoint;
      Constructor Init;
      Destructor Done;
      Procedure Step;
    End;

Constructor TFlamPoint.Init;
Begin
   Reset;
End;

Destructor TFlamPoint.Done;
Begin
End;

Procedure TFlamPoint.Draw;
Begin
   If SB^[Coord]<255-T then
     Inc(SB^[Coord],T)
     Else
     SB^[Coord]:=255;
End;

Procedure TFlamPoint.Reset;
  Var
    XC,YC,XS,YS:Byte;
Begin
   Repeat
     XC:=Random(19)+1;
     YC:=Random(5)+1;
   Until Text[YC,XC]<>' ';
   XS:=Random(PixSize);
   YS:=Random(PixSize);
   Coord:=(YText+YC*PixSize+YS)*320+(XText+XC*PixSize+XS);
   Case Text[YC,XC] of
     '+':T:=IncStep Shl 1;
     '-':T:=IncStep Shr 1;
     '/':T:=1;
     ' ':T:=0;
     Else
       T:=IncStep;
   End;
End;

Constructor TDemo.Init;
  Var
    I:Word;
Begin
   For I:=1 to NumPoints do
     Points[I].Init;
End;

Destructor TDemo.Done;
Begin
End;

Procedure TDemo.Step;
  Var
    I:Word;
Begin
   For I:=1 to NumPoints do
     Points[I].Draw;
   For I:=1 to NumPoints Div 100 do Points[Random(NumPoints)+1].Reset;
End;

Var
  Demo:TDemo;

Begin
   Init_Demo;
   Flame_Palette;
   Demo.Init;
   Repeat
     {$IFDEF MoveFlame}
     Flame_Picture_2;
     {$ELSE}
     Soft_Picture;
     {$ENDIF}
     Demo.Step;
     Show;
   Until KeyPressed;
   Demo.Done;
   ReadKey;
   Close_Demo;
End.