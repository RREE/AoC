with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_03b
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
   Oxy   : Integer;
   Co2   : Integer;
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
   for Bit in Bit_Count loop
      Gamma_Line(Bit) := (if Counts(Bit) >= Count/2 then '1' else '0');
      Eps_Line(Bit) := (if Gamma_Line(Bit) = '1' then '0' else '1');
   end loop;
   Put_Line ("gamma: " & Gamma_Line);
   Put_Line ("epsilon: " & Eps_Line);
   Gamma := Integer'Value ("2#" & Gamma_Line & "#");
   Eps   := Integer'Value ("2#" & Eps_Line & "#");
   Power := Gamma * Eps;
   Put_Line ("gamma" & Gamma'Image & ", eps" & Eps'Image & ", pow" & Power'Image);

   --
   -- part 2
   --
   Counts := (others => 0);
   declare
      Oxy_Lines1 : Vector := Lines;
      Oxy_Lines2 : Vector := Empty_Vector;
      use Ada.Containers;
   begin
      Oxy_Position:
      for Bit in Bit_Count loop
         for L of Oxy_Lines1 loop
            if L(Bit) = '1' then
               Counts(Bit) := @+1;
            end if;
         end loop;

         for L of Oxy_Lines1 loop
            if Counts(Bit) >= Natural(Oxy_Lines1.Length) - Counts(Bit) then
               -- keep only lines with a '1' at the bit position, discard all others
               if L(Bit) = '1' then
                  Oxy_Lines2.Append(L);
               end if;
            else
               if L(Bit) = '0' then
                  Oxy_Lines2.Append(L);
               end if;
            end if;
         end loop;
         exit Oxy_Position when Oxy_Lines2.Length = 1;

         Oxy_Lines1 := Oxy_Lines2;
         Oxy_Lines2 := Empty_Vector;
      end loop Oxy_Position;

      Oxy := Integer'Value ("2#" & Oxy_Lines2.Last_Element & "#");
   end;

   Counts := (others => 0);
   declare
      CO2_Lines : Vector;
      use Ada.Containers;
   begin
      Co2_Position:
      for Bit in Bit_Count loop
         for L of Lines loop
            if L(Bit) = '1' then
               Counts(Bit) := @+1;
            end if;
         end loop;

         for L of Lines loop
            if Counts(Bit) < Natural(Lines.Length) - Counts(Bit) then
               -- keep only lines with a '1' at the bit position, discard all others
               if L(Bit) = '1' then
                  Co2_Lines.Append(L);
               end if;
            else
               if L(Bit) = '0' then
                  Co2_Lines.Append(L);
               end if;
            end if;
         end loop;
         exit Co2_Position when Co2_Lines.Length = 1;

         Lines := Co2_Lines;
         Co2_Lines := Empty_Vector;
      end loop Co2_Position;
      Co2 := Integer'Value ("2#" & Co2_Lines.Last_Element & "#");
   end;

   Put_Line ("oxy" & Oxy'Image & ", CO2" & Co2'Image & ", life" & Integer'(Oxy*Co2)'Image);
end Aoc_03b;
