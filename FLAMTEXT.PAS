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
  TDemo=
    Object
      Constructor Init;
      Destructor Done;
      Procedure Step;
    End;

Constructor TDemo.Init;
Begin
End;

Destructor TDemo.Done;
Begin
End;

Procedure TDemo.Step;
  Var
    I,J:Word;
    XC,YC,XS,YS,Incr:Byte;
Begin
   For I:=1 to 2000 do
     Begin
        XC:=Random(19)+1;
        YC:=Random(5)+1;
        If Text[YC,XC]<>' ' then
          Begin
             XS:=Random(PixSize);
             YS:=Random(PixSize);
             J:=(YText+YC*PixSize+YS)*320+(XText+XC*PixSize+XS);
             Case Text[YC,XC] of
               '+':Incr:=IncStep Shl 1;
               '-':Incr:=IncStep Shr 1;
               '/':Incr:=1;
               Else
                 Incr:=IncStep;
             End;
             If SB^[J]<=255-Incr then
               SB^[J]:=SB^[J]+Incr
               Else
               SB^[J]:=255;
          End;
     End;
End;

Var
  Demo:TDemo;

Begin
   Init_Demo;
   Flame_Palette;
   Demo.Init;
   Repeat
     Demo.Step;
     {$IFDEF MoveFlame}
     Flame_Picture;
     {$ELSE}
     Soft_Picture;
     {$ENDIF}
     Show;
   Until KeyPressed;
   Demo.Done;
   ReadKey;
   Close_Demo;
End.