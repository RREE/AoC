with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_04_A is

   subtype X_Range is Integer range 1 .. 140;
   subtype Y_Range is Integer range 1 .. 140;

   subtype Line is String (X_Range);
   Area : array (Y_Range) of Line;
   Y : Natural := 1;
   Count : Natural := 0;


   procedure Check (Y : Y_Range; X : X_Range)
   is
   begin
      -- east-ward
      if X <= 137 and then Area(Y)(X .. X+3) = "XMAS" then
         Count := Count + 1;
      end if;
      -- west-ward
      if X > 3 and then Area(Y)(X-3 .. X) = "SAMX" then
         Count := Count + 1;
      end if;
      -- north-ward
      if Y > 3
        and then Area (Y-3)(X) = 'S'
        and then Area (Y-2)(X) = 'A'
        and then Area (Y-1)(X) = 'M'
        -- and then Area (Y-0)(X) = 'X'
      then
         Count := Count + 1;
      end if;
      -- south-ward
      if Y <= 137
        and then Area (Y+3)(X) = 'S'
        and then Area (Y+2)(X) = 'A'
        and then Area (Y+1)(X) = 'M'
      then
         Count := Count + 1;
      end if;
      -- north-east-ward
      if X <= 137 and then Y > 3
        and then Area (Y-3)(X+3) = 'S'
        and then Area (Y-2)(X+2) = 'A'
        and then Area (Y-1)(X+1) = 'M'
      then
         Count := Count + 1;
      end if;
      -- north-west-ward
      if X > 3 and then Y > 3
        and then Area (Y-3)(X-3) = 'S'
        and then Area (Y-2)(X-2) = 'A'
        and then Area (Y-1)(X-1) = 'M'
      then
         Count := Count + 1;
      end if;
      -- south-east-ward
      if X <= 137 and then Y <= 137
        and then Area (Y+3)(X+3) = 'S'
        and then Area (Y+2)(X+2) = 'A'
        and then Area (Y+1)(X+1) = 'M'
      then
         Count := Count + 1;
      end if;
      -- south-west-ward
      if X > 3 and then Y <= 137
        and then Area (Y+3)(X-3) = 'S'
        and then Area (Y+2)(X-2) = 'A'
        and then Area (Y+1)(X-1) = 'M'
      then
         Count := Count + 1;
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
         if Area (Y)(X) = 'X' then
            Check (Y, X);
         end if;
      end loop;
   end loop;

      Put_Line ("XMAS count:" & Count'Image);
end AoC_04_A;
