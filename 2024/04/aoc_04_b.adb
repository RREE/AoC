with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_04_B is

   subtype X_Range is Integer range 1 .. 140;
   subtype Y_Range is Integer range 1 .. 140;

   subtype Line is String (X_Range);
   Area : array (Y_Range) of Line;
   Y : Natural := 1;
   Count : Natural := 0;


   procedure Check (Y : Y_Range; X : X_Range)
   is
   begin
      -- north-east-ward
      if X in 2 .. 139 and then Y in 2 .. 139
      then
         if ((Area(Y-1)(X-1) = 'M' and then Area(Y+1)(X+1) = 'S')
               or else (Area(Y-1)(X-1) = 'S' and then Area(Y+1)(X+1) = 'M'))
           and then
           ((Area(Y-1)(X+1) = 'M' and then Area(Y+1)(X-1) = 'S')
              or else (Area(Y-1)(X+1) = 'S' and then Area(Y+1)(X-1) = 'M'))
         then
            Count := Count + 1;
         end if;
      end if;
   end Check;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      Area (Y) := Get_Line(Input);
      Y := Y + 1;
   end loop;

   for Y in Y_Range loop
      for X in X_Range loop
         if Area (Y)(X) = 'A' then
            Check (Y, X);
         end if;
      end loop;
   end loop;

      Put_Line ("X-MAS count:" & Count'Image);
end AoC_04_B;
