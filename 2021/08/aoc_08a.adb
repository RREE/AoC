with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_08a
is
   type Number_Count_T is array (0 .. 9) of Natural;
   Count : Number_Count_T := (others => 0);

   Seg_Per_Number : constant Number_Count_T :=
     (0 => 6,
      1 => 2,
      2 => 5,
      3 => 5,
      4 => 4,
      5 => 5,
      6 => 6,
      7 => 3,
      8 => 7,
      9 => 6);

   procedure Get_Next_Word (Input : String; Word_Length : out Natural; Pointer : out Natural)
   is
      I : Natural := Input'First;
      Start : Natural;
   begin
      while Input(I) = ' ' loop I:=I+1; end loop;
      Start := I;
      while Input(I) /= ' ' loop
         I := I + 1;
         exit when I > Input'Last;
      end loop;
      Word_Length := I - Start;
      Pointer := I;
   end Get_Next_Word;


begin
   Open_Input;

   while not End_Of_File (Input) loop
      Read_Patterns:
      declare
         Line : constant String   := Get_Line(Input);
         P    : Natural           := Line'First;
         Last : constant Positive := Line'Last;
         Len  : Natural;
      begin
         -- skip first part up the '|'
         while Line(P) /= '|' loop P := P + 1; end loop; P := P + 1;
         loop
            Get_Next_Word (Line (P..Last), Len, P);
            case Len is
            when 1 => null; -- found the |
            when 2 => Count(1) := @ + 1;
            when 3 => Count (7) := @ + 1;
            when 4 => Count (4) := @ + 1;
            when 7 => Count (8) := @ + 1;
            when others => null;
            end case;
            exit when P >= Last;
         end loop;
      exception
      when End_Error => null;
      end Read_Patterns;
   end loop;

   Put_Line ("unique numbers" & Integer'(Count'Reduce ("+", 0))'Image);


end Aoc_08a;
