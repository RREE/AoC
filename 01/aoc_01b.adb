with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;

procedure Aoc_01b
is
   Window_Length : constant := 3;
   type Window_Index is mod Window_Length;
   Window : array (Window_Index) of Natural :=  (others => 0);

   W_Id : Window_Index := 0;
   Incs : Natural := 0;
   Val  : Integer;
   Old  : Integer;
begin
   Open_Input;

   Get (Input, Val);
   Window (W_Id) := Val;

   W_Id := W_Id + 1;
   Get (Input, Val);
   Window (W_Id) := Val;
   Window (W_Id-1) := @ + Val;

   W_Id := W_Id + 1;
   Get (Input, Val);
   Window (W_Id) := Val;
   Window (W_Id-1) := @ + Val;
   Window (W_Id-2) := @ + Val;

   while not End_Of_File (Input) loop

      Old := Window (W_Id-2);
      Get (Input, Val);
      W_Id := W_Id + 1;
      Window (W_Id) := Val;
      Window (W_Id-1) := @ + Val;
      Window (W_Id-2) := @ + Val;

      if Window (W_Id-2) > Old then
         Incs := @+1;
      end if;
   end loop;

   Put_Line ("found " & Incs'Image & " greater than previous");
end Aoc_01b;
