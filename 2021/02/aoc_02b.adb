with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;

procedure Aoc_02b
is
   type Dir_T is (Forward, Down, Up);
   package Dir_IO is new Ada.Text_Io.Enumeration_Io(Dir_T);
   use Dir_IO;

   Dir : Dir_T;
   Val : Integer;

   Depth  : Integer := 0;
   Length : Integer := 0;
   Aim    : Integer := 0;
begin
   Open_Input;

   while not End_Of_File (Input) loop

      Get (Input, Dir);
      Get (Input, Val);

      case Dir is
      when Forward => Length := @+Val; Depth := @ + (Aim*Val);
      when Up      => Aim    := @-Val;
      when Down    => Aim    := @+Val;
      end case;
   end loop;

   Put_Line ("pos length" & Length'Image & ", depth" & Depth'Image & ", aim" & Aim'Image & ", product" & Integer'(Length*Depth)'Image);
end Aoc_02b;
