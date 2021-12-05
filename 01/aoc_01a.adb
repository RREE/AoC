with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;

procedure Aoc_01a
is
   Count : Natural := 1;
   Incs  : Natural := 0;
   Val   : Integer;
   Old   : Integer;
begin
   Open_Input;

   Get (Input, Val);
   while not End_Of_File (Input) loop
      Count := Count + 1;
      Old := Val;
      Get (Input, Val);

      if Val > Old then
         Incs := Incs + 1;
      end if;
   end loop;

   Put_Line ("found " & Incs'Image & " greater than previous");
end Aoc_01a;
