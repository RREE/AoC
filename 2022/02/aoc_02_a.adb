with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Aoc_Helper;              use Aoc_Helper;

procedure AoC_02_A is

   type Hand_Shape is (Rock, Paper, Scissors);

   type Outcome is (Loose, Draw, Win);

   function Play (Adv : Hand_Shape; Me : Hand_Shape) return Outcome
   is
   begin
      if Adv = Me then return Draw; end if;
      case Adv is
      when Rock =>
         if Me = Paper then
            return Win;
         else
            return Loose;
         end if;
      when Paper =>
         if Me = Scissors then
            return Win;
         else
            return Loose;
         end if;
      when Scissors =>
         if Me = Rock then
            return Win;
         else
            return Loose;
         end if;
      end case;
   end Play;

   subtype Adv_Char is Character range 'A' .. 'C';
   subtype My_Char is Character range 'X' .. 'Z';

   Adv_Shape : constant array (Adv_Char) of Hand_Shape :=
     ('A' => Rock,
      'B' => Paper,
      'C' => Scissors);
   My_Shape : constant array (My_Char) of Hand_Shape :=
     ('X' => Rock,
      'Y' => Paper,
      'Z' => Scissors);

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
         My_Bet : constant Hand_Shape := My_Shape (Line(3));
         Result : constant Points :=
           Points_For_Outcome (Play (Adv => Adv_Shape (Line(1)),
                                     Me  => My_Bet));
      begin
         Score := @ + Result + Points_For_Shape (My_Bet);
      end;
   end loop;

   Put_Line ("Result: " & Score'Image);

end AoC_02_A;
