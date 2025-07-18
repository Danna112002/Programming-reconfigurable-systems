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
        CLK : in std_logic;              -- Wejście zegara
        RST : in std_logic;              -- Wejście resetu
        led : out std_logic_vector(2 downto 0) -- Wyjście na diody LED
    );
end TOP;

architecture  behavioural of TOP is


    -- Deklaracja sygnałów
    signal R   : bit;                    -- Wejście resetu dla licznika
    signal C   : bit;                    -- Wejście zegara dla licznika
    signal S_L1 : bit_vector(1 downto 0); -- Tryb pracy dla licznika
    signal S_L2 : bit_vector(1 downto 0); -- Tryb pracy dla licznika
    signal S_L3 : bit_vector(1 downto 0); -- Tryb pracy dla licznika
    signal D1   : bit;                    -- Wyjście licznika
	signal D2   : bit;                    -- Wyjście licznika
	signal D3   : bit;                    -- Wyjście licznika
	
begin

-- Mapowanie sygnałów do wejść modułu LICZNIK
    R <= to_bit(RST);                   -- Konwersja std_logic na bit
    C <= to_bit(CLK);                   -- Konwersja std_logic na bit
    S_L1 <= "01";
    S_L2 <= "10";
    S_L3 <= "11";
    
     -- Instancja modułu LICZNIK
    LICZNIK_inst1 : entity work.LICZNIK
        port map (
            R => R,
            C => C,
            S => S_L1,
            D => D1
            );
                 -- Instancja modułu LICZNIK
    LICZNIK_inst2 : entity work.LICZNIK
        port map (
            R => R,
            C => C,
            S => S_L2,
            D => D2
            );
                 -- Instancja modułu LICZNIK
    LICZNIK_inst3 : entity work.LICZNIK
        port map (
            R => R,
            C => C,
            S => S_L3,
            D => D3
            );
            
            -- Mapowanie wyjścia licznika na LED
    -- Zakładamy, że LED(0) zapala się, gdy D='1'
    
    R <= (R);                               -- Wejście resetu 
    led(0) <= to_stdulogic(D1);             -- Wyjście licznika na LED(0)
    led(1) <= to_stdulogic(D2);             -- Wyjście licznika na LED(0)
    led(2) <= to_stdulogic(D3);             -- Wyjście licznika na LED(0)
    
    
end behavioural;




