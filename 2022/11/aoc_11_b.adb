with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Long_Integer_Text_IO;     use Ada.Long_Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Containers.Vectors;

procedure AoC_11_B is

   subtype Monkey_Count is Natural range 0 .. 10;

   package Monkey_Count_Text_IO is new Ada.Text_IO.Integer_IO (Monkey_Count);

   subtype Item is Long_Integer;

   package Item_Pkg is new Ada.Containers.Vectors (Positive, Item);

   Div_Test_Mod : Item := 1;


   type Op_Code is new Character
     with Static_Predicate => Op_Code in '+' | '*';

   type Operand_Type is (Const, Old);

   type Operand (Op : Operand_Type := Const) is record
      case Op is
      when Const => Val : Item;
      when Old => null;
      end case;
   end record;


   type Monkey is record
      Items    : Item_Pkg.Vector;
      Op       : Op_Code;
      Opd_L    : Operand;
      Opd_R    : Operand;
      Div_Test : Item;
      Act_T    : Monkey_Count;
      Act_F    : Monkey_Count;
      Count    : Natural := 0;
   end record;

   package Monkey_Pkg is new Ada.Containers.Vectors (Monkey_Count, Monkey);
   use Monkey_Pkg;

   Monkeys : Vector;

   M : Monkey;


   procedure Receive (Monkey_Idx : Monkey_Count; I : Item)
   is
   begin
      Monkeys (Monkey_Idx).Items.Append (I);
   end Receive;


   function Operate (Op : Op_Code; L, R : Operand; It : Item) return Item is
   begin
      case Op is
      when '+' =>
         if R = (Op => Old) then
            return It + It;
         else
            return It + R.Val;
         end if;
      when '*' =>
         if R = (Op => Old) then
            return It * It;
         else
            return It * R.Val;
         end if;
      end case;
   end Operate;


begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
      begin
         if Line'Length = 0 then
            Monkeys.Append (M);
            M.Count := 0;
            M.Items := Item_Pkg.Empty_Vector;
         elsif Line (1 .. 6) = "Monkey" then
            --  Check: declare
            --     Idx : Natural;
            --     L : Natural;
            --  begin
            --     Get (Line (8 .. Line'Length), Idx, L);
            --     if Idx /= Natural(Monkeys.Length) then
            --        raise Data_Error;
            --     end if;
            --  end Check;
            null;
         elsif Line (1 .. 10) = "  Starting" then
            declare
               It : Item;
               L : Natural := 18;
            begin
               loop
                  Get (Line (L .. Line'Last), It, L);
                  M.Items.Append (It);
                  exit when L = Line'Last;
                  L := L + 2;
               end loop;
            end;

         elsif Line (1 .. 11) = "  Operation" then
            declare
               It : Item;
               L  : Natural := 18;
            begin
               if Line (20 .. 22) = "old" then
                  M.Opd_L := (Op => Old);
                  L := 22;
               else
                  Get (Line (20.. Line'Last), It, L);
                  M.Opd_L := (Const, It);
               end if;
               L := L + 2;
               M.Op := Op_Code (Line (L));
               L := L + 2;
               if Line (L) = 'o' then
                  M.Opd_R := (Op => Old);
               else
                  Get (Line (L.. Line'Last), It, L);
                  M.Opd_R := (Const, It);
               end if;
            end;
         elsif Line (1 .. 6) = "  Test" then
            declare
               It : Item;
               L    : Natural;
            begin
               Get (Line (22.. Line'Last), It, L);
               M.Div_Test := It;
               Div_Test_Mod := @ * It;
            end;

         elsif Line (1 .. 8) = "    If t" then
            declare
               It : Monkey_Count;
               L  : Natural;
               use Monkey_Count_Text_Io;
            begin
               Get (Line (29.. Line'Last), It, L);
               M.Act_T := It;
            end;

         elsif Line (1 .. 8) = "    If f" then
            declare
               It : Monkey_Count;
               L  : Natural;
               use Monkey_Count_Text_Io;
            begin
               Get (Line (30.. Line'Last), It, L);
               M.Act_F := It;
            end;

         end if;
      end;
   end loop;
   Monkeys.Append (M);

   Rounds : for Round in 1 .. 10_000 loop
      for M of Monkeys loop
         Items : for It of M.Items loop
            declare
               Worry : Item := Operate (M.Op, M.Opd_L, M.Opd_R, It) mod Div_Test_Mod;
            begin
               --  Worry := Worry / 3;
               if Worry rem M.Div_Test = 0 then
                  Receive (M.Act_T, Worry);
               else
                  Receive (M.Act_F, Worry);
               end if;
            end;
         end loop Items;
         M.Count := @ + Natural (M.Items.Length);
         M.Items := Item_Pkg.Empty_Vector;
      end loop;
   end loop Rounds;

   declare
      function Is_Bigger (L, R : Monkey) return Boolean is
      begin
         return L.Count > R.Count;
      end Is_Bigger;

      package M_Sort_Pkg is new Monkey_Pkg.Generic_Sorting (Is_Bigger);

      Business : Item;
   begin
      M_Sort_Pkg.Sort (Monkeys);
      Business := Item(Monkeys(0).Count) * Item(Monkeys(1).Count);
      Put_Line ("monkey business: " & Business'Image);
   end;


end AoC_11_B;
