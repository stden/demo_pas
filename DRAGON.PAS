{ Roman International 1999 SVGA256.BGI }
Uses CRT,Graph;

{ = = = A R R A Y = = = }
Type TArray = Array [1..65000] of Byte;
     PArray = ^TArray;

Type _Array = Record
       NumRec : Word;
       Data : PArray;
     End;

Procedure InitArray( Var _:_Array; NumRec:Word );
  Begin
    _.NumRec:=NumRec;
    GetMem( _.Data, _.NumRec*SizeOf(Byte) );
  End;

Procedure CloseArray( Var _:_Array );
  Begin
    FreeMem( _.Data, _.NumRec*SizeOf(Byte) );
  End;

{ = = = G E N E R A T E = = = }
Procedure Generate( Var New:_Array; Deg:Word );
  Var Last:_Array; N,I:Word;
  Begin
    If Deg>1 then
      Begin
        Generate( Last, Deg-1 );
        N:=Last.NumRec;
        InitArray( New, N*2+1 );
        For I:=1 to N do New.Data^[I]:=Last.Data^[I];
        New.Data^[N+1]:=1;
        For I:=1 to N do New.Data^[N+1+I]:=Last.Data^[I];
        New.Data^[N+2+(N div 2)]:=0;
        CloseArray( Last );
      End
    Else
      Begin
        InitArray( New, 1 );
        New.Data^[1]:=1;
      End;
  End;

{ = = = W A Y S = = = }
Const
  _Right = 0;
  _Left  = 1;
   Up    = 0;
   Right = 1;
   Down  = 2;
   Left  = 3;

{ = = = R A D I U S = = = }
Const Radius = 6;

{ = = = D R A G O N = = = }
Var Main:_Array;

{ = = = V A R I A B L E S = = = }
Var X,Y:Word; Way:ShortInt;

{ = = = D R A W = = = }
Procedure Draw;
  Var I:Word;
  Begin
    For I:=1 to Main.NumRec do
      Begin
       { Center }
        Case Main.Data^[I] of
          _Right: { Поворот Направо }
            Case Way of
              Up    : X:=X+Radius;
              Down  : X:=X-Radius;
              Right : Y:=Y+Radius;
              Left  : Y:=Y-Radius;
            End;
          _Left : { Поворот Налево }
            Case Way of
              Up    : X:=X-Radius;
              Down  : X:=X+Radius;
              Right : Y:=Y-Radius;
              Left  : Y:=Y+Radius;
            End;
        End;
       { Arc }
        Arc(X,Y,90-90*(Way+Main.Data^[I]),180-90*(Way+Main.Data^[I]),Radius);
       { Move }
        Case Way of
          Up    : Y:=Y-Radius;
          Down  : Y:=Y+Radius;
          Right : X:=X+Radius;
          Left  : X:=X-Radius;
        End;
       { Change Way }
        Case Main.Data^[I] of
          _Right: Inc(Way);
          _Left : Dec(Way);
        End;
        If Way=-1 then Way:=3;
        If Way=4 then Way:=0;
      End;
  End;

{$F+}
Function SVGA_Detect:Integer;
  Begin
    SVGA_Detect:=4;
  End;
{$F-}

{ = = = T O   S T R I N G = = = }
Function To_String( N:LongInt ):String;
  Var Result:String;
  Begin
    Str(N,Result);
    To_String:=Result;
  End;

{ = = = M A I N = = = }
Var GD,GM:Integer; I,J:Byte;
Begin
 { Init }
  GD:=InstallUserDriver('SVGA256',@SVGA_Detect);
  GD:=Detect;
  InitGraph( GD, GM, '' );
  SetTextStyle(DefaultFont,HorizDir,3);
 { Out }
  For J:=1 to 11 do
    Begin
      SetFillStyle(1,0);
      Bar(0,0,GetMaxX,GetMaxY);
      For I:=37 to 43 do
        Begin
          SetColor(I);
          OutTextXY(400-I,10+I,'Dragon '+To_String(J));
        End;
      Generate(Main,J);
      For I:=45 to 47 do
        Begin
          X:=600+I; Y:=565+I;
          SetColor(I);
          Way:=Right;
          Draw;
        End;
      For I:=16 to 23 do
        Begin
          SetColor(I);
          OutTextXY(250-I,720+I,'Press any key to Continue');
        End;
      ReadKey;
    End;
 { Close }
  CloseArray( Main );
  CloseGraph;
End.
