with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_03a
is
   Nr_Of_Bits : constant := 12;

   subtype Bit_Count is Natural range 1 .. Nr_Of_Bits;
   subtype Line_T is String (Bit_Count);
   Line : Line_T;
   Gamma_Line : Line_T;
   Eps_Line   : Line_T;

   Counts : array (Bit_Count) of Natural := (others => 0);

   package Line_Vecs is new Ada.Containers.Vectors (Element_Type => Line_T,
                                                    Index_Type => Natural);
   use Line_Vecs;

   Lines : Vector;

   Eps   : Integer := 0;
   Gamma : Integer := 0;
   Power : Integer;
   Count : Integer;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      Get (Input, Line);
      Lines.Append(Line);
      for Bit in Bit_Count loop
         if Line(Bit) = '1' then
            Counts(Bit) := @+1;
         end if;
      end loop;
   end loop;
   Count := Integer(Lines.Length);
   Put_Line ("len" & Lines.Length'Image);
   for Bit in Bit_Count loop
      Put (Counts(Bit)'Image & ' ');
      Gamma_Line(Bit) := (if Counts(Bit) > Count/2 then '1' else '0');
      Eps_Line(Bit) := (if Gamma_Line(Bit) = '1' then '0' else '1');
   end loop;
   New_Line;
   Put_Line (Gamma_Line);
   Put_Line (Eps_Line);
   Gamma := Integer'Value ("2#" & Gamma_Line & "#");
   Eps   := Integer'Value ("2#" & Eps_Line & "#");
   Power := Gamma * Eps;
   Put_Line ("gamma" & Gamma'Image & ", eps" & Eps'Image & ", pow" & Power'Image);
end Aoc_03a;
