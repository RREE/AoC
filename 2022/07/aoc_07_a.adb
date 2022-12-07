with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Ada.Containers.Multiway_Trees;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_07_A is

   subtype Ustr is Unbounded_String;
   function "+" (S : String) return Unbounded_String
     renames To_Unbounded_String;
   function "+" (S : Unbounded_String) return String
     renames To_String;


   type Entry_Type is (File, Dir);

   type Entry_Info is record
      Kind : Entry_Type;
      Name : Unbounded_String;
      Size : Natural;
   end record;

   package Fs_Pkg is new Ada.Containers.Multiway_Trees (Entry_Info);
   use Fs_Pkg;

   Target : Unbounded_String;

   Fs : Tree;
   C  : Cursor := Root(Fs);
begin
   Open_Input;

   Fs.Insert_Child (Parent   => C,
                    Before   => No_Element,
                    New_Item => (Dir, +"/", 0),
                    Position => C);

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         if Line(1) = '$' then -- command
            if Line (3..4) = "cd" then
               declare
                  Target : constant String := Line (6..Line'Last);
                  Child : Cursor;
               begin
                  if Target = "/" then
                     C := First_Child (Root (Fs));
                  elsif Target = ".." then
                     Fs (Parent(C)).Size := @ + Fs(C).Size;
                     C := Parent(C);
                  else
                     Child := C.First_Child;
                     loop
                        if Element(Child).Name = +Target then
                           C := Child;
                           exit;
                        end if;
                        if Child = Last_Child (C) then
                           raise Data_Error with Target & " NOT FOUND";
                        else
                           Child := Next_Sibling (Child);
                        end if;
                     end loop;
                  end if;
               end;
            elsif Line (3..4) = "ls" then
               null;
            end if;
         else  -- listing of current dir
            declare
               L : Positive;
               Size : Natural;
               New_Entry : Entry_Info;
            begin
               if Line (1..3) = "dir" then
                  New_Entry := (Dir, +Line(5..Line'Last), 0);
               else
                  Get (Line, Size, L);
                  New_Entry := (File, +Line(L+2..Line'Last), Size);
                  Fs(C).Size := @ + Size;
               end if;
               Fs.Insert_Child (C, No_Element, New_Entry);
            end;
         end if;
      end;
   end loop;

   --  for C in Fs.Iterate loop
   --     for I in 1 .. Depth (C) loop
   --        Put ("  ");
   --     end loop;
   --     Put_Line ((if Fs(C).Kind = Dir then "D " else "F ") & (+Fs(C).Name) & Fs(C).Size'Image);
   --  end loop;

   declare
      Sum : Natural := 0;
   begin
      for E of Fs loop
         if E.Kind = Dir and then E.Size <= 100000 then
            Sum := @ + E.Size;
         end if;
      end loop;
      Put_Line ("sum:" & Sum'Image);
   end;

   declare
      Total      : constant := 70000000;
      Min_Unused : constant := 30000000;
      C : Cursor := First_Child (Root (Fs));
      Free : constant Positive := Total - Fs(C).Size;
      To_Be_Freed : constant Positive := Min_Unused - Free;
   begin
      for R in Fs.Iterate loop
         if Fs(R).Kind = Dir and then Fs(R).Size >= To_Be_Freed then
            if Fs(C).Size > Fs(R).Size then
               C := R;
            end if;
         end if;
      end loop;
      Put_Line ((+Fs(C).Name) & ", size:" & Fs(C).Size'Image);
   end;

end AoC_07_A;
