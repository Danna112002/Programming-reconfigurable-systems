library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;
use     ieee.numeric_std.all;

entity TOP is
    generic(
        constant N          : integer := 10
    );
    port(
        clk: in std_logic;
        sw: in std_logic_vector (15 downto 0);
        LED: out std_logic_vector(15 downto 0)
    );
end TOP;

architecture  behavioural of TOP is
	
begin
--      zadanie 1
   LED(0)<= sw(0)
--      zadanie 2
   LED(0)<= sw(0) AND sw(1);
   LED(2)<= sw(2) OR sw(3);
   LED(4)<= sw(4) XOR sw(5);
   LED(6)<= sw(6) NAND sw(7)
   
end behavioural;




