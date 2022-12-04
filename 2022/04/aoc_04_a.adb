with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_04_A is

   type Sect_Range is record
      Low : Positive;
      High : Positive;
   end record;

   function Is_Fully_Contained (Left, Right : Sect_Range) return Boolean is
   begin
      if Left.Low >= Right.Low and then Left.High <= Right.High then
         return True;
      elsif Right.Low >= Left.Low and then Right.High <= Left.High then
         return True;
      else
         return False;
      end if;
   end Is_Fully_Contained;

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

         if Is_Fully_Contained (Left, Right) then
            Count := @ + 1;
         end if;

      end;
   end loop;

   Put_Line ("Result: " & Count'Image);

end AoC_04_A;
