with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_09_A is

   Rope_Width  : constant := 1000;
   Rope_Height : constant := 1000;

   subtype Width  is Integer range 1 .. Rope_Width;
   subtype Height is Integer range 1 .. Rope_Height;

   type Position is record
      X : Width;
      Y : Height;
   end record;

   Start : constant Position := (Rope_Width/2, Rope_Height/2) ;

   Head : Position := Start;
   Tail : Position := Start;

   Visited : array (Width, Height) of Boolean := (others => (others => False));


   procedure Follow (H : Position; T : in out Position) is
      X_Diff : constant Integer := H.X - T.X;
      Y_Diff : constant Integer := H.Y - T.Y;
   begin
      if abs(X_Diff) <= 1 and then abs(Y_Diff) <= 1 then
         return;
      elsif X_Diff = 0 then -- abs(Y_Diff) is 2
         T.Y := @ + (Y_Diff/2);
      elsif abs (X_Diff) = 1 then -- abs(Y_Diff) is 2
         T.Y := @ + (Y_Diff/2);
         --  we also have to follow in the X direction
         T.X := @ + X_Diff;
      else -- abs(X_Diff) == 2
         T.X := @ + (X_Diff/2);
         if Y_Diff /= 0 then
            --  we also have to follow in the Y direction
            T.Y := @ + Y_Diff;
         end if;
      end if;
   end Follow;


   procedure Show_Rope is
   begin
      for Y in Height loop
         for X in Width loop
            if Head = (X, Y) then
               Put ('H');
            elsif Tail = (X, Y) then
               Put ('T');
            elsif Visited (X, Y) then
               Put ('#');
            else
               Put ('.');
            end if;
         end loop;
         New_Line;
      end loop;
      New_Line;
   end Show_Rope;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : constant String    := Get_Line(Input);
         Dir  : constant Character := Line(1);
         Dist : constant Natural   := Integer'Value (Line(3..Line'Last));
      begin
         for Step in 1 .. Dist loop
            case Dir is
            when 'U' => Head.Y := @ - 1;
            when 'D' => Head.Y := @ + 1;
            when 'R' => Head.X := @ + 1;
            when 'L' => Head.X := @ - 1;
            when others => raise Data_Error with "error input: " & Line;
            end case;
            Follow (Head, Tail);
            Visited (Tail.X, Tail.Y) := True;
         end loop;
      end;
      --  Show_Rope;
   end loop;

   declare
      Count : Natural := 0;
   begin
      for X in Width loop
         for Y in Height loop
            if Visited (X, Y) then
               Count := Count + 1;
            end if;
         end loop;
      end loop;
      Put_Line ("nr of positions visited" & Count'Image);
   end;

end AoC_09_A;
