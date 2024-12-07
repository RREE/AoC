with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Gnat.Regpat;             use Gnat.Regpat;

procedure AoC_03_A is
   Matches : Match_Array (0 .. 2);
   Pattern : constant String := "mul\(([0-9][0-9]?[0-9]?),([0-9][0-9]?[0-9]?)\)"; -- ()";
   Start   : Positive        := 1;
   Sum     : Long_Integer    := 0;
   L, R    : Long_Integer;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         Start := 1;
         while Start < Line'Last loop
            Match (Compile (Pattern), Line (Start .. Line'Last), Matches);
            if Matches(0) = No_Match then
               Start := Line'Last;
            else
               L := Long_Integer'Value (Line (Matches(1).First .. Matches(1).Last));
               R := Long_Integer'Value (Line (Matches(2).First .. Matches(2).Last));
               Sum := Sum + L*R;
               Start := Matches(0).Last + 1;
            end if;
         end loop;
      end;
   end loop;

   Put_Line ("Result: " & Sum'Image);

end AoC_03_A;
