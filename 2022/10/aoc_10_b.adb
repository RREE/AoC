with Ada.Text_IO;             use Ada.Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_10_B is

   Num_Pixels : constant := 240;
   subtype Start_Pixel_Range is Integer range -1 .. Num_Pixels + 2;
   subtype Pixel_Range is Integer range 1 .. Num_Pixels;

   Crt    : array (Pixel_Range) of Boolean := (others => False);
   Sprite : array (Start_Pixel_Range) of Start_Pixel_Range := (others => 1);

   Register : Start_Pixel_Range := 1;

   Beam_Pos   : Start_Pixel_Range := 2;

   procedure Show_Crt is
      Right : Pixel_Range;
   begin
      for Line in 1 .. 6 loop
         Right := Line * 40;
         for Pos in Right-39 .. Right loop
            Put ((if Crt(Pos) then '#' else '.'));
         end loop;
         New_Line;
      end loop;
   end Show_Crt;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         if Line (1..4) = "noop" then
            Sprite (Beam_Pos) := Sprite (Beam_Pos - 1);
            Beam_Pos := Beam_Pos + 1;
         elsif Line (1 .. 4) = "addx" then
            Register := @ + Integer'Value (Line (6 .. Line'Last));
            Sprite (Beam_Pos) := Sprite (Beam_Pos - 1);
            Beam_Pos := Beam_Pos + 1;
            Sprite (Beam_Pos) := Register;
            Beam_Pos := Beam_Pos + 1;
         else
            raise Data_Error with "ERROR: " & Line;
         end if;
      end;
   end loop;

   for Pos in Pixel_Range loop
      Crt (Pos) := (Pos mod 40) in Sprite(Pos) .. Sprite(Pos) + 2;
   end loop;

   New_Line;
   Show_Crt;

end AoC_10_B;
