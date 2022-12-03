with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Containers.Vectors;

procedure AoC_01_B is

   type Calories is record
      Sum : Natural := 0;
      Cal : Int_Vec.Vector;
   end record;

   function "<" (Left, Right : Calories) return Boolean
   is
   begin
      return Left.Sum > Right.Sum;
   end "<";

   package Elves_Pkg is new Ada.Containers.Vectors (Positive, Calories, "<");
   package Elves_Sorting is new Elves_Pkg.Generic_Sorting;
   use Elves_Sorting;
   Elves : Elves_Pkg.Vector;

   Tmp_Elf : Calories;
   Nr_Elves : Natural := 1;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         L : Positive;
         C : Positive;
      begin
         if Line'Length > 0 then
            Get (Line, C, L);
            Tmp_Elf.Sum := @ + C;
            Tmp_Elf.Cal.Append (C);
         else
            Elves.Append (Tmp_Elf);
            Nr_Elves := @ + 1;
            Tmp_Elf.Sum := 0;
            Tmp_Elf.Cal := Int_Vec.Empty_Vector;
         end if;
      end;
   end loop;
   Elves.Append (Tmp_Elf);

   Sort (Elves);

   declare
      Sum : Natural := 0;
   begin
      for I in 1 .. 3 loop
         Sum := @ + Elves(I).Sum;
      end loop;
      Put_Line ("sum of 3 biggest =" & Sum'Image);
   end;

end AoC_01_B;
