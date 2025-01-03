with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_01_A is
   Team_Left, Team_Right : Int_Vec.Vector;
   Total : Natural := 0;
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

   Int_Vec_Sorting.Sort (Team_Left);
   Int_Vec_Sorting.Sort (Team_Right);

   for I in Team_Left.First_Index .. Team_Left.Last_Index loop
      Total := @ + abs (Team_Left(I) - Team_Right(I));
   end loop;

   Put_Line ("Result: " & Total'Image);

end AoC_01_A;
