with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_05b
is
   subtype Grid_Range is Integer range 0 .. 1000;

   type Point is record
      X : Grid_Range;
      Y : Grid_Range;
   end record;

   type Segment is record
      Point_1 : Point;
      Point_2 : Point;
   end record;

   type Grid_T is array (Grid_Range, Grid_Range) of Natural
     with Default_Component_Value => 0;

   Grid : Grid_T;

   package Segment_Vectors is new Ada.Containers.Vectors (Element_Type => Segment,
                                                          Index_Type => Positive);
   use Segment_Vectors;

   Segments : Vector;

   procedure Read_Segments is
   begin
      while not End_Of_File (Input) loop
         declare
            Line : constant String := Get_Line (Input);
            Last : Natural := Line'Last;
            Seg  : Segment;
            Pos  : Natural := 1;
         begin
            Get (Line(Pos..Last), Seg.Point_1.X, Pos);
            Pos := @+2;
            Get (Line(Pos..Last), Seg.Point_1.Y, Pos);
            Pos := @+4;
            Get (Line(Pos..Last), Seg.Point_2.X, Pos);
            Pos := @+2;
            Get (Line(Pos..Last), Seg.Point_2.Y, Pos);
            Segments.Append (Seg);
         end;
      end loop;
   end Read_Segments;


begin
   Open_Input;
   Read_Segments;

   Set_Vents:
   declare
   begin
      for S of Segments loop
         -- Find vertical vents (x const)
         if S.Point_1.X = S.Point_2.X then
            for Y in Natural'Min(S.Point_1.Y, S.Point_2.Y) ..  Natural'Max(S.Point_1.Y, S.Point_2.Y) loop
               Grid (S.Point_1.X, Y) := @+1;
            end loop;
         end if;
         -- Find horizontal vents (y const)
         if S.Point_1.Y = S.Point_2.Y then
            for X in Natural'Min(S.Point_1.X, S.Point_2.X) ..  Natural'Max(S.Point_1.X, S.Point_2.X) loop
               Grid (X, S.Point_1.Y) := @+1;
            end loop;
         end if;
         -- find diagonal lines (|dx| = |dy|)
         if abs(S.Point_1.X - S.Point_2.X) = abs(S.Point_1.Y - S.Point_2.Y) then
            declare
               X : Integer := S.Point_1.X;
               Y : Integer := S.Point_1.Y;
               X_Inc : constant Integer := (if S.Point_1.X < S.Point_2.X then 1 else -1);
               Y_Inc : constant Integer := (if S.Point_1.Y < S.Point_2.Y then 1 else -1);
               Steps : constant Natural := abs(S.Point_2.X - S.Point_1.X);
            begin
               for Count in 0 .. Steps loop
                  Put_Line ("x" & X'Image & ", y" & Y'Image & ", step" & Count'Image);
                  Grid(X,Y) := @+1;
                  X := X + X_Inc;
                  Y := Y + Y_Inc;
               end loop;
            end;
         end if;
      end loop;
   end Set_Vents;

   --  count overlaps
   Overlaps:
   declare
      Overlaps : Natural := 0;
   begin
      for P of Grid loop
         if P >= 2 then
            Overlaps := @+1;
         end if;
      end loop;
      Put_Line ("found" & Overlaps'Image & " overlaps");
   end Overlaps;

end Aoc_05b;
