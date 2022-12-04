with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_04_B is

   type Sect_Range is record
      Low : Positive;
      High : Positive;
   end record;

   function Overlap (Left, Right : Sect_Range) return Boolean is
      subtype Left_Range is Natural range Left.Low .. Left.High;
      subtype Right_Range is Natural range Right.Low .. Right.High;
   begin
      if Left.Low in Right_Range or else Left.High in Right_Range then
         return True;
      elsif Right.Low in Left_Range or else Right.High in Left_Range then
         return True;
      else
         return False;
      end if;
   end Overlap;

   Count : Natural := 0;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : constant String := Get_Line(Input);
         Ll   : constant Positive := Line'Last;
         L : Natural;
         Left, Right : Sect_Range;
      begin
         Get (Line, Left.Low, L);
         Get (Line(L+2 .. Ll), Left.High, L);
         Get (Line(L+2 .. Ll), Right.Low, L);
         Get (Line(L+2 .. Ll), Right.High, L);

         if Overlap (Left, Right) then
            Count := @ + 1;
         end if;

      end;
   end loop;

   Put_Line ("Result: " & Count'Image);

end AoC_04_B;
