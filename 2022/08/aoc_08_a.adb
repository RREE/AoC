with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_08_A is

begin
   Open_Input;

   declare
      First_Line : constant String := Get_Line (Input);
      Length : constant Positive := First_Line'Length;
      Total  : constant Positive := Length * Length;
      Count_Invisible : Natural := 0;
      Count_Visible   : Natural := 0;

      subtype Size is Integer range 1 .. Length;

      subtype Line is String (Size);

      Forest : array (Size) of Line;

      Is_Visible : array (Size, Size) of Boolean;

      function Is_Visible_From_Left (X, Y : Size) return Boolean
      is
        (for all I in 1 .. X-1 => Forest (Y)(I) < Forest (Y)(X));

      function Is_Visible_From_Right (X, Y : Size) return Boolean
      is
        (for all I in X+1 .. Length => Forest (Y)(I) < Forest (Y)(X));

      function Is_Visible_From_Top (X, Y : Size) return Boolean
      is
        (for all I in 1 .. Y-1 => Forest (I)(X) < Forest (Y)(X));

      function Is_Visible_From_Bottom (X, Y : Size) return Boolean
      is
        (for all I in Y+1 .. Length => Forest (I)(X) < Forest (Y)(X));

   begin
      Forest (1) := First_Line;
      for I in 2 .. Size'Last loop
         Forest (I) := Get_Line(Input);
      end loop;

      --  all trees on the edges are visible
      for P in Size loop
         Is_Visible (1, P)      := True;
         Is_Visible (Length, P) := True;
         Is_Visible (P, 1)      := True;
         Is_Visible (P, length) := True;
      end loop;

      for Col in 2 .. Length-1 loop
         for Row in 2 .. Length-1 loop
            if Is_Visible_From_Left (Col, Row)
              or else
              Is_Visible_From_Top (Col, Row)
              or else
              Is_Visible_From_Right (Col, Row)
              or else
              Is_Visible_From_Bottom (Col, Row)
            then
               Is_Visible (Col,Row) := True;
            else
               Is_Visible (Col, Row) := False;
               Count_Invisible := Count_Invisible + 1;
            end if;
         end loop;
      end loop;

      --  for X in Size loop
      --     for Y in Size loop
      --        Put ((if Is_Visible (X, Y) then 'X' else 'O'));
      --     end loop;
      --     New_Line;
      --  end loop;

      Count_Visible := Total - Count_Invisible;
      Put_Line ("total:" & Total'Image & ", visible:" & Count_Visible'Image);
   end;
end AoC_08_A;
