Uses CRT;

{$I MCGA.PAS }

Begin
  Init_MCGA;
  Disable_Refrech;
  Fill_Screen;
  ReadKey;
  Enable_Refrech;
  ReadKey;
  Close_MCGA;
End.