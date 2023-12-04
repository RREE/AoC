with Ada.Text_IO;             use Ada.Text_IO;
with Strings_Edit;            use Strings_Edit;
with Strings_Edit.Integers;   use Strings_Edit.Integers;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Strings.Maps;        use Ada.Strings.Maps;
with Ada.Containers.Vectors;
with Ada.Containers.Ordered_Sets;

procedure AoC_04_A is

   package Integer_Sets is new Ada.Containers.Ordered_Sets (Natural);
   use Integer_Sets;

   type Card is record
      Id    : Natural := 0;
      Win   : Set     := Empty_Set;
      My    : Set     := Empty_Set;
      Worth : Natural := 0;
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
      Sum : Natural := 0;
   begin
      for Card of Card_Pile loop
         declare
            Count : Natural := 0;
         begin
            for M of Card.My loop
               if Card.Win.Contains (M) then
                  Count := Count + 1;
               end if;
            end loop;
            if Count > 0 then
               Card.Worth := 2 ** (Count-1);
            else
               Card.Worth := 0;
            end if;
            Sum := Sum + Card.Worth;
         end;
      end loop;
      Put_Line ("Pile worth:" & Sum'Image);
   end;

end AoC_04_A;
