with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;

procedure Aoc_10a
is
   type Char_Array is array (Character) of Natural;
   Opens  : constant Char_Array := ('(' => 3, '[' => 57, '{' => 1197, '<' => 25137, others => 0);
   Closes : constant Char_Array := (')' => 3, ']' => 57, '}' => 1197, '>' => 25137, others => 0);

   package Chunk_Vectors is new Ada.Containers.Vectors (Element_Type => Natural,
                                                        Index_Type => Positive);
   use Chunk_Vectors;
   Chunks : Vector;

   Score : Natural := 0;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         Analyze_Line:
         for I in Line'Range loop
            declare
               Op : Natural renames Opens(Line(I));
               Cl : Natural renames Closes(Line(I));
            begin
               if Op > 0 then
                  Chunks.Append (Op);
               else
                  if Cl = Chunks.Last_Element then
                     Chunks.Delete_Last;
                  else
                     Put_Line ("curruption at I" & I'Image & ", chunk '" & Line(I) & ''');
                     Score := @ + Cl;
                     exit Analyze_Line;
                  end if;
               end if;
            end;
         end loop Analyze_Line;
      end;
   end loop;
   Put_Line ("Score:" & Score'Image);

end Aoc_10a;
