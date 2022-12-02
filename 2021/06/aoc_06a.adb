with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_06a
is
   subtype Timer_Range is Integer range 0 .. 8;
   subtype Long_Natural is Long_Integer range 0 .. Long_Integer'Last;

   type Aged_Fish is array (Timer_Range) of Long_Natural;
   Fish : Aged_Fish;

   function Fish_Sum return Long_Natural
   is
      Sum : Long_Natural := 0;
   begin
      for Age in Timer_Range loop
         Sum := @ + Fish(Age);
      end loop;
      return Sum;
   end Fish_Sum;


   procedure Add_Day is
      Next_Fish : Aged_Fish ;
   begin
      Next_Fish (0..7) := Fish (1..8);
      Next_Fish (8) := Fish(0);
      Next_Fish (6) := @ + Fish (0);
      Fish := Next_Fish;
   end Add_Day;


begin
   Open_Input;

   Read_Init_Fish:
   declare
      Number_Line : constant String := Get_Line(Input);
      Pos : Natural := Number_Line'First;
      Last : constant Positive := Number_Line'Last;
      Timer : Timer_Range;
   begin
      Fish := (others => 0);
      loop
         Get (Number_Line (Pos..Last), Timer, Pos);
         Fish (Timer) := @ + 1;
         -- skip comma
         Pos := @+2;
      end loop;
   exception
   when End_Error => null;
   end Read_Init_Fish;

   for Days in 1 .. 18 loop
      Add_Day;
   end loop;
   Put_Line ("we have" & Fish_Sum'Image & " fish");
   for Days in 19 .. 80 loop
      Add_Day;
   end loop;
   Put_Line ("we have" & Fish_Sum'Image & " fish");
   for Days in 81 .. 256 loop
      Add_Day;
   end loop;
   Put_Line ("we have" & Fish_Sum'Image & " fish");


end Aoc_06a;
