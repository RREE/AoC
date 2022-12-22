with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Long_Integer_Text_IO;  use Ada.Long_Integer_Text_IO;
with Aoc_Helper;                use Aoc_Helper;
with Ada.Containers;
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Hash;

procedure AoC_21_B is

   type Kind is (Add, Sub, Mul, Div, Const);
   subtype Op is Kind range Add .. Div;

   subtype Str4 is String (1 .. 4);

   function Equal (L, R : Str4) return Boolean is (L = R);

   type Monkey (T : Kind := Const) is record
      Name : Str4;
      case T is
      when Const =>
         V : Long_Integer := 0;
      when Op =>
         L, R : Str4;
      end case;
   end record;

   package Monkey_Pkg is new Ada.Containers.Hashed_Maps (Key_Type        => Str4,
                                                         Element_Type    => Monkey,
                                                         Hash            => Ada.Strings.Hash,
                                                         Equivalent_Keys => Equal);

   Monkeys : Monkey_Pkg.Map;


   function Yell (Name : Str4) return Long_Integer is
      M : constant Monkey := Monkeys (Name);
   begin
      case M.T is
      when Const => return Long_Integer(M.V);
      when Add   => return Yell (M.L) + Yell (M.R);
      when Sub   => return Yell (M.L) - Yell (M.R);
      when Mul   => return Yell (M.L) * Yell (M.R);
      when Div   => return Yell (M.L) / Yell (M.R);
      end case;
   end Yell;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         M    : Monkey;
         P    : Natural := 0;
         Name : constant Str4 := Line(1..4);
         Val  : Long_Integer := 0;
         Oper : Op;
      begin
         if Line(7) in '0' .. '9' then
            Get (Line (7 .. Line'Last), Val, P);
            M := (Const, Name, Val);
         else
            case Line (12) is
            when '+' => Oper := Add;
            when '-' => Oper := Sub;
            when '*' => Oper := Mul;
            when '/' => Oper := Div;
            when others => raise Data_Error with "wrong operator in " & Line;
            end case;
            M := (Oper, Name, L => Line(7..10), R => Line(14..17));
         end if;
         Monkeys.Include (Name, M);
      end;
   end loop;

   Search_Zero:
   declare
      Root : constant Monkey := Monkeys ("root");
      Human : Monkey renames Monkeys ("humn");

      Last_Yell, Mid_Yell, Curr_Yell : Long_Integer;
      Last_Val, Mid_Val, Curr_Val : Long_Integer;
      Step : Long_Integer;

      function Next (Val_Diff, Yell_Diff, Yell : Long_Integer) return Long_Integer
      is
         Lf : constant Long_Float := Long_Float (Val_Diff);
         Rf : constant Long_Float := Long_Float (Yell_Diff);
         Yf : constant Long_Float := Long_Float (Yell);
         Df : constant Long_Float := Lf / Rf * Yf;
      begin
         return Long_Integer (Df);
      end Next;

   begin
      Last_Val := 0;
      Curr_Val := 100000;
      Human.V := Last_Val;
      Last_Yell := Yell(Root.L) - Yell(Root.R);
      Human.V := Curr_Val;
      Curr_Yell := Yell(Root.L) - Yell(Root.R);

      --  using the secant method does not converge, neither on the
      --  small example nor on the real input.  Use the secant method
      --  only as long as the Yell values have the same sign.

      while Float(Curr_Yell) * Float(Last_Yell) > 0.0 loop
         Step := Next (Val_Diff  => (Curr_Val - Last_Val),
                       Yell_Diff => (Curr_Yell - Last_Yell),
                       Yell      => Last_Yell);
         Last_Val  := Curr_Val;
         Curr_Val  := @ - Step;
         Human.V   := Curr_Val;
         Last_Yell := Curr_Yell;
         Curr_Yell := Yell(Root.L) - Yell(Root.R);
      end loop;

      --  Once they have opposite signs use the bisection method.

      while Curr_Yell /= 0 loop
         Mid_Val := (Last_Val + Curr_Val) / 2;
         Human.V := Mid_Val;
         Mid_Yell := Yell(Root.L) - Yell(Root.R);
         if Float(Mid_Yell) * Float(Curr_Yell) < 0.0 then
            Last_Val := Mid_Val;
            Last_Yell := Mid_Yell;
         else
            Curr_Val := Mid_Val;
            Curr_Yell := Mid_Yell;
         end if;
      end loop;

      --  slowly search the first or last input that yields 0
      while Curr_Yell = 0 loop
         Curr_Val  := Curr_Val - 1;
         Human.V   := Curr_Val;
         Curr_Yell := Yell(Root.L) - Yell(Root.R);
      end loop;
      Curr_Val := Curr_Val + 1;
      Human.V   := Curr_Val;
      Curr_Yell := Yell(Root.L) - Yell(Root.R);

      Put_Line ("Human Val:" & Curr_Val'Image & ", yell:" & Curr_Yell'Image);

   end Search_Zero;

end AoC_21_B;
