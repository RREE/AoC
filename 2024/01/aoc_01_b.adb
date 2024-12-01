with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_01_B is
   Team_Left, Team_Right : Int_Vec.Vector;
   Count_Right : Natural;
   Total : Natural := 0;

   function Count_Appearance (Cmp : Natural; V : Int_Vec.Vector) return Natural
   is
      Count : Natural := 0;
   begin
      for Val of V loop
         if Val = Cmp then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Count_Appearance;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         L : Natural;
         Val : Natural;
      begin
         Get (Line, Val, L);
         Team_Left.Append (Val);
         Get (Line (L+1 .. Line'Last), Val, L);
         Team_Right.Append (Val);
      end;
   end loop;

   for I in Team_Left.First_Index .. Team_Left.Last_Index loop
      Count_Right := Count_Appearance (Team_Left(I), Team_Right);
      Total := @ + Team_Left(I) * Count_Right;
   end loop;

   Put_Line ("Result: " & Total'Image);

end AoC_01_B;
