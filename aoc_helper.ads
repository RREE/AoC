with Ada.Containers.Vectors;
with Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;     
with Ada.Strings.Fixed;           use Ada.Strings.Fixed;       
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;    
     
package Aoc_Helper is
        
   Input_Name : constant String := "input.txt"; 
   Input      : ada.text_io.File_Type;      
      
   package Int_Vec is new Ada.Containers.Vectors (Element_Type => Integer,      
                                                  Index_Type => Natural);       
                                                             
   function "+" (Source : in Unbounded_String) return String renames To_String;              
   function "+" (Source : in String) return Unbounded_String renames To_Unbounded_String;    
    
end Aoc_Helper;
