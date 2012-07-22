Uses CRT;

{$I MCGA.PAS}

Const Worms_Num = 80;

Var Worms : Array [1..Worms_Num] of Worm;

Type Demo = Object
       Constructor Init;
       Procedure Step;
       Destructor Done;
     End;

  Constructor Demo.Init;
    Var I:Word;
    Begin
      Flame_Palette;
      For I:=1 to Worms_Num do Worms[I].Init(10+Random(310),10+Random(190));
    End;

   Procedure Demo.Step;
     Var I:Word;
     Begin
       For I:=1 to Worms_Num do Worms[I].Run;
       Flame_Picture;
     End;

  Destructor Demo.Done;
    Begin
      Full_Soft_Picture(50);
    End;

{ = = = Основная Программа = = = }
Var _RECYCLED_:Demo;
Begin
  Init_Demo;
  _RECYCLED_.Init;
  Repeat
    _RECYCLED_.Step;
    Show;
  Until KeyPressed;
  _RECYCLED_.Done;
  Close_Demo;
End.