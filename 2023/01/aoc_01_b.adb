with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure AoC_01_B is
   Sum : Natural := 0;

   type Number is (One, Two, Three, Four, Five, Six, Seven, Eight, Nine);

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         First, Last : Integer := 0;
      begin
         Search_First:
         for Pos in Line'Range loop
            if Is_Digit(Line(Pos)) then
               First := Character'Pos (Line(Pos)) - 48;
               exit Search_First;
            else
               for N in Number loop
                  declare
                     Num : constant String := To_Lower (N'Image);
                     Len : constant Natural := Num'Length - 1;
                  begin
                     if Pos + Len <= Line'Last then
                        if Line (Pos .. Pos + Len) = Num then
                           First := Number'Pos (N) + 1;
                           exit Search_First;
                        end if;
                     end if;
                  end;
               end loop;
            end if;
         end loop Search_First;

         Search_Last:
         for Pos in reverse Line'Range loop
            if Is_Digit(Line(Pos)) then
               Last := Character'Pos (Line(Pos)) - 48;
               exit Search_Last;
            else
               for N in Number loop
                  declare
                     Num : constant String := To_Lower (N'Image);
                     Len : constant Natural := Num'Length - 1;
                  begin
                     if Pos + Len <= Line'Last then
                        if Line (Pos .. Pos + Len) = Num then
                           Last := Number'Pos (N) + 1;
                           exit Search_Last;
                        end if;
                     end if;
                  end;
               end loop;
            end if;
         end loop Search_Last;

         Sum := Sum + 10 * First + Last;
      end;
   end loop;

   Put_Line ("Result: " & Sum'Image);

end AoC_01_B;
