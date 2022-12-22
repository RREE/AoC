with Ada.Containers.Vectors;
with Ada.Text_IO;
with Ada.Strings.Fixed;           use Ada.Strings.Fixed;
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;

package Aoc_Helper is

   Input : Ada.Text_IO.File_Type;

   procedure Open_Input;
   procedure Close_Input;

   package Int_Vec is new Ada.Containers.Vectors (Element_Type => Integer,
                                                  Index_Type => Natural);
   package Int_Vec_Sorting is new Int_Vec.Generic_Sorting;

   function "+" (Source : in Unbounded_String) return String renames To_String;
   function "+" (Source : in String) return Unbounded_String renames To_Unbounded_String;

end Aoc_Helper;
