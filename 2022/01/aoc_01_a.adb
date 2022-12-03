with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Containers.Vectors;

procedure AoC_01_A is

   type Calories is record
      Sum : Natural := 0;
      Cal : Int_Vec.Vector;
   end record;

   package Elves_Pkg is new Ada.Containers.Vectors (Positive, Calories);
   Elves : Elves_Pkg.Vector;

   Tmp_Elf : Calories;
   Nr_Elves : Natural := 1;
   Biggest : Natural := 0;
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
            Put_Line ("adding" & C'Image & " to elf #" & Nr_Elves'Image);
         else
            Elves.Append (Tmp_Elf);
            Put_Line ("added elf #" & Nr_Elves'Image);
            if Biggest /= 0 then
               if Tmp_Elf.Sum > Elves(Biggest).Sum then
                  Biggest := Nr_Elves;
               end if;
            else
               Biggest := 1;
            end if;
            Nr_Elves := @ + 1;
            Tmp_Elf.Sum := 0;
            Tmp_Elf.Cal := Int_Vec.Empty_Vector;
            Put_Line ("biggest elf is #" & Biggest'Image);
         end if;
      end;
   end loop;
   Elves.Append (Tmp_Elf);

   Put_Line ("calories of biggest:" & Elves(biggest).Sum'Image);

end AoC_01_A;
