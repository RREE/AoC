with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Gnat.Regpat;             use Gnat.Regpat;

procedure AoC_03_B is
   Mul_Matches  : Match_Array (0 .. 2);
   Do_Matches   : Match_Array (0 .. 0);
   Dont_Matches : Match_Array (0 .. 0);
   Mul_Pattern  : constant String := "mul\(([0-9][0-9]?[0-9]?),([0-9][0-9]?[0-9]?)\)"; -- ()";
   Do_Pattern   : constant String := "do\(\)";
   Dont_Pattern : constant String := "don't\(\)";
   Start   : Positive        := 1;
   Sum     : Long_Integer    := 0;
   L, R    : Long_Integer;
   Enabled : Boolean := True;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         Start := 1;
         Disable: while Start < Line'Last loop
            if Enabled then
               Match (Compile (Dont_Pattern), Line (Start .. Line'Last), Dont_Matches);
               if Dont_Matches(0) = No_Match then
                  Start := Line'Last;
               else
                  Start := Dont_Matches(0).Last + 1;
                  Enabled := False;
               end if;
            else
               Match (Compile (Do_Pattern), Line (Start .. Line'Last), Do_Matches);
               if Do_Matches(0) = No_Match then
                  Start := Line'Last;
                  Line (Dont_Matches(0).Last+1 .. Line'Last) := (others => '.');
                  Dont_Matches (0) := No_Match;
               else
                  Start := Do_Matches(0).Last + 1;
                  Line (Dont_Matches(0).Last+1 .. Do_Matches(0).First-1) := (others => '.');
                  Enabled := True;
               end if;
            end if;
         end loop Disable;

         Start := 1;
         Mul: while Start < Line'Last loop
            Match (Compile (Mul_Pattern), Line (Start .. Line'Last), Mul_Matches);
            if Mul_Matches(0) = No_Match then
               Start := Line'Last;
            else
               L := Long_Integer'Value (Line (Mul_Matches(1).First .. Mul_Matches(1).Last));
               R := Long_Integer'Value (Line (Mul_Matches(2).First .. Mul_Matches(2).Last));
               Sum := Sum + L*R;
               Start := Mul_Matches(0).Last + 1;
            end if;
         end loop Mul;
      end;
   end loop;

   Put_Line ("Result: " & Sum'Image);

end AoC_03_B;
