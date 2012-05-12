Uses CRT,MCGADemo;

 Const Pic : Array [1..7] of String[40] = (
  '                         ',
  '### ### ### #           ',
  '  # # # # # #           ',
  '### # # # # #           ',
  '#   # # # # #           ',
  '### ### ### #           ',
  '                        ');

 Const MaxWormsNum = 1200;

 Type
   T2001 = Object(TFlame)
     Worms : Array [1..MaxWormsNum] of Worm;
     WormsNum : Word;
     Constructor Init;
     Procedure Step;
   End;

 Constructor T2001.Init;
   Var I,J:Word;
   Begin
     Inherited Init;
     WormsNum:=0;
     For I:=1 to 7 do
       For J:=1 to 40 do
         If Pic[I,J]='#' then
           Begin
             Inc(WormsNum);
             Worms[WormsNum].Init(J*20,I*20,10);
             Inc(WormsNum);
             Worms[WormsNum].Init(J*20,I*20,10);
             Inc(WormsNum);
             Worms[WormsNum].Init(J*20,I*20,10);
             Inc(WormsNum);
             Worms[WormsNum].Init(J*20,I*20,10);
           End;
   End;

 Procedure T2001.Step;
   Var I:Word;
   Begin
     For I:=1 to WormsNum do Worms[I].Run;
     SoftPicture;
     Inherited Step;
   End;

Var Demo:T2001;
Begin
  Demo.Init;
  Repeat Demo.Step; Until KeyPressed;
  Demo.Done;
End.

