with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_09a
is
   subtype Height is Integer range 0 .. 9;


   subtype X_Exp is Integer range 1 .. 100;
   subtype X_Slope is Integer range 0 .. X_Exp'Last+1;
   subtype Y_Exp is Integer range 1 .. 100;
   subtype Y_Slope is Integer range 0 .. Y_Exp'Last+1;

   type Map is array (X_Exp, Y_Exp) of Height;
   Height_Map : Map;

   function Is_Low (X : X_Exp; Y : Y_Exp) return Boolean is
      Low : Boolean := True;
   begin
      if X > 1 then
         if Height_Map(X-1,Y) <= Height_Map (X, Y) then return False; end if;
      end if;
      if X < X_Exp'Last then
         if Height_Map(X+1,Y) <= Height_Map (X, Y) then return False; end if;
      end if;
      if Y > 1 then
         if Height_Map(X,Y-1) <= Height_Map (X, Y) then return False; end if;
      end if;
      if Y < Y_Exp'Last then
         if Height_Map(X,Y+1) <= Height_Map (X, Y) then return False; end if;
      end if;

      return True;
   end Is_Low;


begin
   Open_Input;

   for Y in Y_Exp loop
      declare
         Line : String := Get_Line(Input);
      begin
         for X in X_Exp loop
            Height_Map (X, Y) := Character'Pos (Line(X))-48;
         end loop;
      end;
   end loop;

   declare
      Risk : Natural := 0;
   begin
      for Y in Y_Exp loop
         for X in X_Exp loop
            if Is_Low (X, Y) then
               -- Low_Points.Append (Height_Map(X, Y));
               Put_Line("low at x" & X'Image & ", y" & Y'Image & ", h" & Height_Map(X,Y)'Image);
               Risk := @ + Height_Map(X, Y) + 1;
            end if;
         end loop;
      end loop;
      Put_Line ("risk:" & Risk'Image);
   end;

end Aoc_09a;
