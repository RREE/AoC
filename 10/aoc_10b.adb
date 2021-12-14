with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Aoc_Helper;           use Aoc_Helper;
with Ada.Containers.Vectors;
with Ada.Containers.Ordered_Sets;

procedure Aoc_10b
is
   subtype Natural is Long_Integer range 0 .. Long_Integer'Last;

   type Char_Array is array (Character) of Natural;
   Opens  : constant Char_Array := ('(' => 1, '[' => 2, '{' => 3, '<' => 4, others => 0);
   Closes : constant Char_Array := (')' => 1, ']' => 2, '}' => 3, '>' => 4, others => 0);

   use type Ada.Containers.Count_Type;

   package Chunk_Vectors is new Ada.Containers.Vectors (Element_Type => Natural,
                                                        Index_Type => Positive);
   use Chunk_Vectors;
   Chunks : Vector;

   package Sorter is new Chunk_Vectors.Generic_Sorting;
   Scores : Vector;
begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         Score : Natural := 0;
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
                     -- ignore corrupted lines
                     Chunks.Clear;
                     exit Analyze_Line;
                  end if;
               end if;
            end;
         end loop Analyze_Line;
         if Chunks.Length > 0 then
            Chunks.Reverse_Elements;
            Put_Line (Line);
            for C of Chunks loop
               Put(C'Image);
               Score := 5 * @ + C;
            end loop;
            Chunks.Clear;
            Scores.Append (Score);
            New_Line;
            Put_Line ("Score:" & Score'Image);
         end if;
      end;
   end loop;
   Sorter.Sort (Scores);
   Put_Line ("completed lines" & Scores.Length'Image);
   declare
      Mid_Index : constant Integer := (Integer(Scores.Length) + 1) / 2;
      Mid_Score : Natural renames Scores(Mid_Index);
   begin
      Put_Line ("middle element" & Mid_Index'Image);
      Put_Line ("middle score" & Mid_Score'Image);
   end;
end Aoc_10b;
