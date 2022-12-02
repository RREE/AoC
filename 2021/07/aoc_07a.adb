with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_07a
is
   subtype Position_Range is Integer range 0 .. 2000;

   type Crab_Population is array (Position_Range) of Long_Long_Integer
     with Default_Component_Value => 0;
   Crabs : Crab_Population;
   Costs : Crab_Population;

   Min_Pos : Position_Range := Position_Range'Last;
   Max_Pos : Position_Range := Position_Range'First;
   Min_Cost : Long_Long_Integer := Long_Long_Integer'Last;
   Best_Pos : Position_Range;
begin
   Open_Input;

   Read_Crab_Pos:
   declare
      Number_Line : constant String := Get_Line(Input);
      P : Natural := Number_Line'First;
      Last : constant Positive := Number_Line'Last;
      Pos : Position_Range;
   begin

      loop
         Get (Number_Line (P..Last), Pos, P);
         Crabs (Pos) := @ + 1;
         Min_Pos := Position_Range'Min (Min_Pos, Pos);
         Max_Pos := Position_Range'Max (Max_Pos, Pos);
         -- skip comma
         P := @+2;
      end loop;
   exception
   when End_Error => null;
   end Read_Crab_Pos;

   Put_Line ("min" & Min_Pos'Image & ", max" & Max_Pos'Image);

   Costs := (others => 0);
   for Pos in Costs'Range loop
      for P in Crabs'Range loop
         Costs(Pos) := Costs(Pos) + Long_Long_Integer(abs(Pos - P))*Crabs(P);
      end loop;
      if Costs(Pos) < Min_Cost then
         Min_Cost := Costs(Pos);
         Best_Pos := Pos;
      end if;
   end loop;

   Put_Line ("minimal costs of" & Min_Cost'Image & " at position" & Best_Pos'Image);
end Aoc_07a;
