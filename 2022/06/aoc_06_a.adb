with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_06_A is

   function Has_Duplicate (Str : String) return Boolean
   is
   begin
      if Str'Length = 2 then
         if Str(Str'First) = Str(Str'Last) then
            return True;
         else
            return False;
         end if;
      else
         for I in Str'First .. Str'Last-1 loop
            if Str (Str'Last) = Str(I) then
               return True;
            end if;
         end loop;
         return Has_Duplicate (Str (Str'First .. Str'Last-1));
      end if;
   end Has_Duplicate;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : constant String := Get_Line(Input);
      begin
         for I in 4 .. Line'Last loop
            if not Has_Duplicate (Line (I-3 .. I)) then
               Put_Line ("#" & I'Image);
               exit;
            end if;
         end loop;
      end;
   end loop;


end AoC_06_A;
