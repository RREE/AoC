with Ada.Containers.Vectors;
with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Strings.Fixed;           use Ada.Strings.Fixed;
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;
with Ada.Directories;
with Ada.Calendar;
with Ada.Command_Line;

package body Aoc_Helper is

   Input_Name : constant String := "input.txt";

   procedure Open_Input
   is
      use Ada.Directories;
      use Ada.Command_Line;
      use Ada.Calendar;
      Year : Year_Number;
      Mon  : Month_Number;
      Day  : Day_Number;
      Secs : Day_Duration;
      Day_Img : String := "03";
   begin
      if Argument_Count > 0 then
         Open (Input, In_File, Argument(1));
         return;
      end if;

      Split (Clock, Year, Mon, Day, Secs);

      Put_Line ("Day:" & Day'Image & "'");
      if Exists (Input_Name) then
         Open (Input, In_File, Input_Name);
         return;
      elsif Exists (Day_Img & '/' & Input_Name) then
         Open (Input, In_File, Input_Name);
         return;
      end if;
      Ada.Text_IO.Put_Line ("file not found: '" & Input_Name & "'");
      Ada.Text_IO.Put_Line ("file not found: '" & Day_Img & '/' & Input_Name & "'");
      raise Ada.Text_IO.Name_Error;
   end Open_Input;

   procedure Close_Input
   is begin
      Close (Input);
   end Close_Input;


end Aoc_Helper;
