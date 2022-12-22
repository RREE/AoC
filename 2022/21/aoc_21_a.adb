with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;
with Ada.Containers;
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Hash;

procedure AoC_21_A is

   type Kind is (Add, Sub, Mul, Div, Const);
   subtype Op is Kind range Add .. Div;

   subtype Str4 is String (1 .. 4);

   function Equal (L, R : Str4) return Boolean is (L = R);

   type Monkey (T : Kind := Const) is record
      Name : Str4;
      case T is
      when Const =>
         V : Integer := 0;
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

   Root_Yell : Long_Integer := 0;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         M    : Monkey;
         P    : Natural := 0;
         Name : constant Str4 := Line(1..4);
         Val  : Integer := 0;
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

   Root_Yell := Yell("root");
   Put_Line ("Result: " & Root_Yell'Image);


end AoC_21_A;
