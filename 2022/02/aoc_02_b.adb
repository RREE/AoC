with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_02_B is

   type Hand_Shape is (Rock, Paper, Scissors);

   type Outcome is (Loose, Draw, Win);


   function Play (Adv : Hand_Shape; O : Outcome) return Hand_Shape
   is
   begin
      if O = Draw then return Adv; end if;
      case Adv is
      when Rock =>
         if O = Win then
            return Paper;
         else
            return Scissors;
         end if;
      when Paper =>
         if O = Win then
            return Scissors;
         else
            return Rock;
         end if;
      when Scissors =>
         if O = Win then
            return Rock;
         else
            return Paper;
         end if;
      end case;
   end Play;

   subtype Adv_Char is Character range 'A' .. 'C';
   subtype My_Char is Character range 'X' .. 'Z';

   Adv_Shape : constant array (Adv_Char) of Hand_Shape :=
     ('A' => Rock,
      'B' => Paper,
      'C' => Scissors);
   My_Out : constant array (My_Char) of Outcome :=
     ('X' => loose,
      'Y' => draw,
      'Z' => win);

   subtype Points is Natural;
   Points_For_Shape : constant array (Hand_Shape) of Points :=
     (Rock     => 1,
      Paper    => 2,
      Scissors => 3);
   Points_For_Outcome : constant array (Outcome) of Points :=
     (Loose => 0,
      Draw  => 3,
      Win   => 6);

   Score : Points := 0;

begin
   Open_Input;

   while not End_Of_File (Input) loop
      declare
         Line : String := Get_Line(Input);
         Result : constant Outcome := My_Out (Line(3));
         My_Bet : constant Hand_Shape := Play (Adv => Adv_Shape (Line(1)),
                                               O   => Result);
      begin
         Score := @ + Points_For_Outcome (Result) + Points_For_Shape (My_Bet);
      end;
   end loop;

   Put_Line ("Result: " & Score'Image);

end AoC_02_B;
