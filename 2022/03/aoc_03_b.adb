with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;

procedure AoC_03_B is
   Prio : Natural := 0;

   function Index (Source : String; Pattern : Character) return Natural
   is
   begin
      for I in Source'Range loop
         if Source(I) = Pattern then
            return I;
         end if;
      end loop;
      return 0;
   end Index;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line1 : constant String := Get_Line(Input);
         Line2 : constant String := Get_Line(Input);
         Line3 : constant String := Get_Line(Input);

         Common_1_2 : Unbounded_String;

         Pos : Natural := 0;
         Local_Prio : Natural;
         subtype Lower is Character range 'a' .. 'z';
      begin
         for C of Line1 loop
            Pos := Index (Line2, C);
            if Pos /= 0 then
               Pos := Index (Line3, C);
               if Pos /= 0 then
                  if C in Lower then
                     Local_Prio := Character'Pos (C) - Character'Pos ('a');
                  else
                     Local_Prio := Character'Pos (C) - Character'Pos ('A') + 26;
                  end if;
                  Local_Prio := @ + 1;
                  exit;
               end if;
            end if;
         end loop;
         Prio := @ + Local_Prio;
      end;

   end loop;

   Put_Line ("Prio:" & Prio'Image);

end AoC_03_B;
