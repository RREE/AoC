with Ada.Text_IO;             use Ada.Text_IO;
with Strings_Edit;            use Strings_Edit;
with Strings_Edit.Integers;   use Strings_Edit.Integers;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Containers.Vectors;
with Ada.Strings.Maps;        use Ada.Strings.Maps;
with Ada.Strings.Maps.Constants; use Ada.Strings.Maps.Constants;

procedure AoC_02_A is

   type Cube_Color is (Red, Blue, Green);

   type Take is array (Cube_Color) of Natural;

   Take_Limits : constant Take := (Red => 12, Blue => 14, Green => 13);

   package Take_Pkg is new Ada.Containers.Vectors (Positive, Take);

   type Game is record
      Id    : Natural;
      Takes : Take_Pkg.Vector;
      Valid : Boolean;
   end record;

   package Game_Pkg is new Ada.Containers.Vectors (Positive, Game);

   Games : Game_Pkg.Vector;

   Current_Take : Take := (others => 0);
   Empty_Game : constant Game := [Id => 0, Takes => Take_Pkg.Empty_Vector, Valid => True];
   Current_Game : Game := Empty_Game;
   Result : Natural := 0;
begin
   Open_Input;

   Read_File:
   while not End_Of_File (Input) loop
      declare
         Line : constant String := Get_Line(Input);
         Id  renames Current_Game.Id;
         Pos : Natural := 6;
         Old_Pos : Natural := Pos;
         Cnt : Natural := 0;
         Color : Cube_Color;
      begin
         Get (Line, Pos, Id);
         Pos := Pos + 2; -- skip colon and blank
         while Pos < Line'Last loop
            Get (Line, Pos, Cnt);
            Pos := Pos + 1;
            Old_Pos := Pos;
            Get (Source => Line, Pointer => Pos, Blanks => Letter_Set);
            case Pos - Old_Pos is
            when 3 =>
               Color := Red;
            when 4 =>
               Color := Blue;
            when 5 =>
               Color := Green;
            when others => raise Data_Error;
            end case;
            Current_Take(Color) := Cnt;
            if Take_Limits(Color) < Cnt then
               Current_Game.Valid := False;
               -- Put_Line ("game id:" & Current_Game.Id'Image & " invalidated as color " & Color'Image & " exceeds limit" & Cnt'Image & " >" & Take_Limits(Color)'Image);
            end if;

            if Pos > Line'Last or else Line (Pos) = ';' then
               Current_Game.Takes.Append (Current_Take);
               Current_Take := (others => 0);
               if Pos > Line'Last then
                  Games.Append (Current_Game);
                  Current_Game := Empty_Game;
               end if;
            end if;
            Pos := Pos + 2;
         end loop;
      end;
   end loop Read_File;

   for G of Games loop
      if G.Valid then Result := @ + G.Id; end if;
   end loop;


   Put_Line ("Result:" & Result'Image);

end AoC_02_A;
