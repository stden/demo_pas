{ ษัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออัป }
{ บณ			    Super Screen Saver			     ณบ }
{ ศฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฯผ }
{ egavga.bgi bold.chr }
{ BPC sssaver.pas /B /uC:\SYSTEM\BP\UNITS }

Uses Crt,Graph;

{ = = = ฎญแโ ญโ๋ = = = }
Const
  Messages = 4;
  Text : Array [0..(Messages-1)] of String =
    ('ROMAN is true genius',
     'ROMAN is MONSTER VOODOO II 3DFX',
     'Roman International',
     'ROMAN !!!');
      ST=2;
      Ramka=7;

{ = = = เ ไจ็ฅแชจฅ ฅเฅฌฅญญ๋ฅ = = = }
Var
  Font_Pointer : Pointer;
  Font_Size : Word;

{ = = = ญจๆจ ซจง ๆจ๏ เ ไจชจ = = = }
 Procedure Init_Graphic;
   Var F:File; GD,GM,Font_Index:Integer;
   Begin
     Assign(F,'BOLD.CHR');
     Reset(F,1);
     Font_Size:=FileSize(F);
     GetMem(Font_Pointer,Font_Size);
     BlockRead(F,Font_Pointer^,Font_Size);
     Close(F);
     Font_Index:=RegisterBGIFont(Font_Pointer);
     GD:=VGA; GM:=VGAHI;
     InitGraph(GD,GM,'');
     SetTextStyle(Font_Index,HorizDir,4);
   End;

{ = = =  ชเ๋โจฅ เ ไจชจ = = = }
 Procedure Close_Graphic;
   Begin
     FreeMem(Font_Pointer,Font_Size);
     CloseGraph;
   End;

{ = = = แญฎขญ ๏ เฎฃเ ฌฌ  = = = }
Var GD,GM:Integer;
    X,Y,XS,YS,H,W:Integer;
    P:Pointer;
    SI,I:Word;
    Message,Color:Byte;
Begin
  Randomize;
  Init_Graphic;
  Message:=Random(Messages);
  Color:=Random(7)+1;
  X:=0; Y:=0; XS:=2; YS:=2;
  H:=TextHeight(Text[Message])+Ramka*2;
  W:=TextWidth(Text[Message])+Ramka*2;
  SetColor(Color);
  For I:=1 to ST do
    OutTextXY( X+4+I, Y+4+I, Text[Message] );
  SetColor(Color+8);
  OutTextXY( X+5+ST, Y+5+ST, Text[Message] );
  SI:=ImageSize(X,Y,X+W,Y+H);
  GetMem(P,SI);
  GetImage(X,Y,X+W,Y+H,P^);
  Repeat
    Inc(X,XS);
    Inc(Y,YS);
    PutImage(X,Y,P^,0);
    If (X<=1) then XS:=(Random(2)+1);
    If (Y<=1) then YS:=(Random(2)+1);
    If (X>=GetMaxX-W-1) then XS:=-(Random(2)+1);
    If (Y>=GetMaxY-H-1) then YS:=-(Random(2)+1);
    Delay(10);
  Until KeyPressed;
  While KeyPressed do ReadKey;
  FreeMem(P,SI);
  Close_Graphic;
End.










