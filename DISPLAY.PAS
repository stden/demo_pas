Uses CRT,Gr_MCGA;

Procedure FillScreen; Assembler;
  Asm
    Mov AX,SegA000
    Mov ES,AX
    Mov DL,100
    Xor DI,DI
  @@RULES:
    Mov CX,160
    Mov AX,000Fh
    Rep Stosw
    Mov CX,160
    Mov AX,0F00h
    Rep Stosw
    Dec DL
    JNZ @@RULES;
  End;

Begin
  InitMCGA;
  DisableRefrech;
  FillScreen;
  ReadKey;
  EnableRefrech;
  ReadKey;
  DoneMCGA;
End.