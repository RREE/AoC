with Ada.Text_IO;             use Ada.Text_IO;
with Strings_Edit;            use Strings_Edit;
with Strings_Edit.Integers;   use Strings_Edit.Integers;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Strings.Maps;        use Ada.Strings.Maps;
with Ada.Containers.Vectors;
with Ada.Containers.Ordered_Sets;

procedure AoC_04_B is

   package Integer_Sets is new Ada.Containers.Ordered_Sets (Natural);
   use Integer_Sets;

   type Card is record
      Id        : Natural := 0;
      Win       : Set     := Empty_Set;
      My        : Set     := Empty_Set;
      Worth     : Natural := 0;
      Instances : Natural := 1;
   end record;

   package Card_Vector_Pkg is new Ada.Containers.Vectors (Positive, Card);
   Card_Pile : Card_Vector_Pkg.Vector;

   Blank_Set : constant Character_Set := To_Set (" ");
begin
   Open_Input;

   while not End_Of_File (Input) loop
      Parse:
      declare
         Line : String := Get_Line(Input);
         Current_Card : Card;
         Pos : Natural := 5;
         Num : Natural;
      begin
         -- skip blanks
         Get (Line, Pos, Blank_Set);
         Get (Line, Pos, Current_Card.Id);
         Pos := Pos + 1; -- skip colon
         Get (Line, Pos, Blank_Set);
         while Line(Pos) /= '|' loop
            Get (Line, Pos, Num);
            Current_Card.Win.Include (Num);
            Get (Line, Pos, Blank_Set);
         end loop;
         Pos := Pos + 1; -- skip vertical bar
         while Pos < Line'Last loop
            Get (Line, Pos, Blank_Set);
            Get (Line, Pos, Num);
            Current_Card.My.Include (Num);
         end loop;
         Card_Pile.Append (Current_Card);
      end Parse;
   end loop;

   --  calculate worth
   declare
     Cards_Count : Natural := 0;
   begin
      for Card_Index in Card_Pile.First_Index .. Card_Pile.Last_Index loop
         declare
            Count : Natural := 0;
            C     : Card    := Card_Pile (Card_Index);
         begin
            for M of C.My loop
               if C.Win.Contains (M) then
                  Count := Count + 1;
               end if;
            end loop;
            for I in 1 .. Count loop
               Card_Pile (Card_Index + I).Instances := @ + C.Instances;
            end loop;
            Cards_Count := Cards_Count + C.Instances;
         end;
      end loop;
      Put_Line ("cards count:" & Cards_Count'Image);
   end;

end AoC_04_B;
