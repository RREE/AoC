with Aoc_Helper; use Aoc_Helper;
with ada.text_IO; use ada.text_io;      
     
procedure Aoc_01a 
is
begin   
   Open (Input, In_File, Input_Name);
   
exception       
when Name_Error =>
   Ada.Text_IO.Put_Line ("file not found: '" & Input_Name & "'");
end aoc_01a;
