with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_02_A is
   Current_Level  : Natural;
   Previous_Level : Natural;
   Current_Diff   : Integer;
   Previous_Diff  : Integer;
   Save_Records   : Natural := 0;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      -- reset
      Previous_Level := 0;
      Current_Diff   := 0;
      Previous_Diff  := 0;
      -- read
      while not End_Of_Line (Input) loop
         Get (Input, Current_Level);
         if Previous_Level /= 0 then
            Current_Diff := Current_Level - Previous_Level;
            -- check slope
            if abs (Current_Diff) < 1 or else abs (Current_Diff) > 3 then
               goto Next;
            end if;
            -- check change of direction
            if Current_Diff * Previous_Diff < 0 then
               goto Next;
            end if;
         end if;
         Previous_Level := Current_Level;
         Previous_Diff := Current_Diff;
      end loop;
      Save_Records := Save_Records + 1;

      <<Next>>

      Skip_Line (Input);
   end loop;

   Put_Line ("Result: " & Save_Records'Image);

end AoC_02_A;
