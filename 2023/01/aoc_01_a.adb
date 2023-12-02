with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Strings.Maps;        use Ada.Strings.Maps;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure AoC_01_A is
   Sum : Natural := 0;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         First, Last : Integer := 0;
         Pos : Natural;
      begin
         for C of Line loop
            if Is_Digit(C) then
               First := Character'Pos (C) - 48;
               exit;
            end if;
         end loop;
         for C of reverse Line loop
            if Is_Digit(C) then
               Last := Character'Pos (C) - 48;
               exit;
            end if;
         end loop;

         Sum := Sum + 10 * First + Last;
      end;
   end loop;

   Put_Line ("Result: " & Sum'Image);

end AoC_01_A;
