with Ada.Text_IO;             use Ada.Text_IO;
with Strings_Edit;            use Strings_Edit;
with Strings_Edit.Integers;   use Strings_Edit.Integers;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Strings.Maps;        use Ada.Strings.Maps;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Containers.Vectors;
with Ada.Containers.Ordered_Sets;
use all type Ada.Containers.Count_Type;

procedure AoC_03_B is

   type Coordinate is record
      Line : Natural;
      Column : Natural;
   end record;

   type Number is record
      Start_Coord : Coordinate;
      End_Coord   : Coordinate;
      Value : Natural;
      Has_Symbol : Boolean;
   end record;

   function "<" (L, R : Number) return Boolean is
   begin
      if L.Start_Coord.Line < R.Start_Coord.Line then
         return True;
      elsif L.Start_Coord.Line = R.Start_Coord.Line
        and then
        L.Start_Coord.Column < R.Start_Coord.Column then
         return True;
      else
         return False;
      end if;
   end "<";

   package Num_Pkg is new Ada.Containers.Vectors (Positive, Number);
   Numbers : Num_Pkg.Vector;

   package Num_Set_Pkg is new Ada.Containers.Ordered_Sets (Number);
   use all type Num_Set_Pkg.Set;

   type Symbol is record
      Coord : Coordinate;
      Value : Character;
      My_Numbers : Num_Set_Pkg.Set;
      Ratio : Natural;
   end record;

   package Symbol_Pkg is new Ada.Containers.Vectors (Positive, Symbol);
   Symbols : Symbol_Pkg.Vector;

   Dot_Set : constant Character_Set := To_Set (".");

   Line_Nr : Natural  := 0;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      Parse_Line:
      declare
         Line : String := Get_Line(Input);
         Pos : Natural := 1;
         N : Number;
         S : Symbol;
      begin
         Line_Nr := Line_Nr + 1;
         while Pos <= Line'Last loop
            -- skip dots
            Get (Line, Pos, Blanks => Dot_Set);
            --
            if Pos <= Line'Last then
               if Is_Digit (Line(Pos)) then
                  N.Start_Coord := (Line_Nr, Pos);
                  Get (Line, Pos, N.Value);
                  N.End_Coord := (Line_Nr, Pos-1);
                  N.Has_Symbol := False;
                  Numbers.Append (N);
               else
                  S := ((Line_Nr, Pos), Line(Pos), Num_Set_Pkg.Empty_Set, Ratio => 0);
                  Symbols.Append (S);
                  Pos := Pos + 1;
               end if;
            end if;
         end loop;
      end Parse_Line;
   end loop;

   -- see if there is a symbol around the coordinates of a number
   for N of Numbers loop
      Search:
      declare
         L renames N.Start_Coord.Line;
      begin
         Col_Search:
         for C in N.Start_Coord.Column - 1 .. N.End_Coord.Column + 1 loop
            for S of Symbols loop
               if S.Coord = (L-1, C) or else S.Coord = (L+1, C) then
                  S.My_Numbers.Include (N);
               end if;
            end loop;
         end loop Col_Search;
         for S of Symbols loop
            if S.Coord = (N.Start_Coord.Line, N.Start_Coord.Column-1)
              or else
              S.Coord = (N.Start_Coord.Line, N.End_Coord.Column+1)
            then
               S.My_Numbers.Include (N);
            end if;
         end loop;
      end Search;
   end loop;

   Get_Sum:
   declare
      Sum : Natural := 0;
   begin
      for S of Symbols loop
         if S.My_Numbers.Length = 2 then
            S.Ratio := S.My_Numbers.First_Element.Value * S.My_Numbers.Last_Element.Value;
         end if;
         Sum := Sum + S.Ratio;
      end loop;
      Put_Line ("Result:" & Sum'Image);
   end Get_Sum;

end AoC_03_B;
