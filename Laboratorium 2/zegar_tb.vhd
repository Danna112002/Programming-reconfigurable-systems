library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

-- Deklaracja testbenchu
entity TB_TOP is
end TB_TOP;

architecture sim of TB_TOP is

    -- Deklaracja sygnałów do testbenchu
    signal CLK  : std_logic := '0';  -- Zegar
    signal RST  : std_logic := '0';  -- Reset
    signal led  : std_logic_vector(2 downto 0); -- Wyjście na diody LED

    -- Stała do symulacji
    constant clk_period : time := 10 ns; -- Okres zegara dla 100 MHz

begin

    -- Instancja testowanego modułu (TOP)
    uut: entity work.TOP
        generic map (
            N => 10 -- Możesz zmienić na dowolną wartość N
        )
        port map (
            CLK => CLK,
            RST => RST,
            led => led
        );

    -- Proces generujący zegar 100 MHz
    clk_process : process
    begin
        CLK <= '0';
        wait for clk_period / 2;
        CLK <= '1';
        wait for clk_period / 2;
    end process;

    -- Proces testujący - generowanie sygnałów wejściowych
    stimulus_process : process
    begin
        -- Reset początkowy
        RST <= '0';  -- Ustawienie resetu na '1'
        wait for 20 ns; -- Czekamy 20 ns
        RST <= '1';  -- Zwalniamy reset
        wait for 100 ns; -- Czekamy 100 ns na stabilizację

        -- Zaczynamy testować - zmiana sygnałów
        wait for 200 ns;
        -- Można dodać inne testy sygnałów, np. kolejne zmiany resetu, zegara, itd.
        
        wait;
    end process;

end sim;
