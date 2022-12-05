with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Containers.Vectors;

procedure AoC_05_B is

   function Get_Nr_Of_Stacks return Natural
   is
   begin
      Open_Input;

      while not End_Of_File (Input) loop
         declare
            Line : constant String := Get_Line(Input);
            Ll   : constant Positive := Line'Last;
            L : Natural;
            Stack_Nr : Natural := 1;
         begin
            if Line(2) = '1' then -- index line found
               L := 2;
               loop
                  Get (Line (L+1 .. Ll), Stack_Nr, L);
                  exit when L+4 > Ll;
               end loop;
               Close_Input;
               return Stack_Nr;
            end if;
         end;
      end loop;
      return 0;
   end Get_Nr_Of_Stacks;

   ---------------------------------------

   subtype All_Crates is Character range '@' .. 'Z';
   subtype Crate is All_Crates range 'A' .. 'Z';

   package Stack_Pkg is new Ada.Containers.Vectors (Positive, All_Crates);

   Nr_Stacks : constant Positive := Get_Nr_Of_Stacks;
   subtype Stack_Range is Positive range 1 .. Nr_Stacks;
   type Stack_Array is array (Stack_Range) of Stack_Pkg.Vector;
   Stacks : Stack_Array;

   type Input_Area_T is (Init_Stack, Middle, Moves);
   Input_Area : Input_Area_T := Init_Stack;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         if Line'Length > 1 and then Line (2) = '1' then
            Input_Area := Middle;
         elsif Line'Length > 4 and then Line (1..4) = "move" then
            Input_Area := Moves;
         end if;

         case Input_Area is
         when Init_Stack =>
            declare
               Pos : Positive;
               C : Character;
            begin
               for I in Stack_Range loop
                  Pos := I*4-2;
                  exit when Pos > Line'Last;
                  C := Line(Pos);
                  if C /= ' ' then
                     Stacks(I).Prepend (C);
                  end if;
               end loop;
            end;
         when Middle => null;
         when Moves =>
            declare
               Count : Positive;
               Source_Stack : Stack_Range;
               Target_Stack : Stack_Range;
               L : Positive;
               C : Crate;
               Stack_Index : Positive;
            begin
               Get (Line (5..Line'Last), Count, L);
               Get (Line (13..Line'Last), Source_Stack, L);
               Get (Line (18..Line'Last), Target_Stack, L);

               --  bad style, reuse of variable L as last
               L := Stacks(Source_Stack).Last_Index;
               Stack_Index := L - Count + 1;
               for Idx in Stack_Index .. L loop
                  C := Stacks(Source_Stack)(Idx);
                  Stacks(Target_Stack).Append (C);
               end loop;
               for Idx in Stack_Index .. L loop
                  Stacks(Source_Stack).Delete_Last;
               end loop;
            end;
         end case;
      end;
   end loop;

   Put ("Result: ");
   for S of Stacks loop
      Put (S.Last_Element);
   end loop;
   New_Line;


end AoC_05_B;
