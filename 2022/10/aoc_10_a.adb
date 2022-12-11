with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_10_A is

   Prev_Reg : Integer := 1;
   Register : Integer := 1;
   Step : Natural := 0;

   Signal_Dist : constant := 40;
   Signal_Step : Natural := 20;
   Signal      : Natural;
   Signal_Sum  : Natural := 0;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         if Line (1..4) = "noop" then
            Step := Step + 1;
            Prev_Reg := Register;
         elsif Line (1 .. 4) = "addx" then
            Prev_Reg := Register;
            Register := @ + Integer'Value (Line (6 .. Line'Last));
            Step := @ + 2;
         else
            raise Data_Error with "ERROR: " & Line;
         end if;
         if Step >= Signal_Step then
            Signal := Signal_Step * Prev_Reg;
            Signal_Sum := @ + Signal;
            Put_Line ("S x X:" & Signal'Image & ", sum:" & Signal_Sum'Image);
            Signal_Step := @ + Signal_Dist;
         end if;
      end;
   end loop;

   Put_Line ("Result: " & Signal_Sum'Image);

end AoC_10_A;
