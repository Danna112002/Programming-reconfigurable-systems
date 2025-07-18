library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity TB_TOP_WHOLE is
end TB_TOP_WHOLE;

architecture sim of TB_TOP_WHOLE is

    -- Deklaracje sygnałów
    signal C        : std_logic := '0';      -- Główny zegar (10 MHz)
    signal B1       : std_logic := '0';      -- Sygnał wejściowy speed (przycisk z drganiami) prescaler
    signal B2       : std_logic := '0';      -- Sygnał wejściowy (przycisk z drganiami) reset
    signal B3       : std_logic := '0';      -- Sygnał wejściowy (przycisk z drganiami)power
    signal Diodes   : std_logic_vector(7 downto 0);      -- wyjście logoko sterującej

begin

        --Sygnał zegarowy
  process is				-- proces bezwarunkowy
  begin					-- czesc wykonawcza procesu
    C <= '0';				-- przypisanie sygna�owi 'C' wartosci '0'
    wait for 10 ns;			-- odczekanie 10 ns
    C <= '1';				-- przypisanie sygna�owi 'C' wartosci '1'
    wait for 10 ns;			-- odczekanie 10 ns
  end process;				-- zakonczenie procesu
  
        --Symulowany sygnał z przycisku
        
 -- Proces generujący sygnał wejściowy z drganiami (przycisk)
   process is
   begin
        -- Stabilny stan niski
        B1 <= '0';
        wait for 100 ms;

        -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B1 <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B1 <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan wysoki
        B1 <= '1';
        wait for 100 ms;
        
                -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B1 <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B1 <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan niski
        B1 <= '0';
        wait for 150 ms;
    end process;
    
 -- Proces generujący sygnał wejściowy z drganiami (przycisk)
   process is
   begin
        -- Stabilny stan niski
        B2 <= '0';
        wait for 100 ms;

        -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B2 <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B2 <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan wysoki
        B2 <= '1';
        wait for 100 ms;
        
                -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B2 <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B2 <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan niski
        B2 <= '0';
        wait for 3000 ms;
    end process;
 -- Proces generujący sygnał wejściowy z drganiami (przycisk)
   process is
   begin
        -- Stabilny stan niski
        B3 <= '0';
        wait for 100 ms;

        -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B3 <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B3 <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan wysoki
        B3 <= '1';
        wait for 100 ms;
        
                -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B3 <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B3 <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan niski
        B3 <= '0';
        wait for 6000 ms;
    end process;
    
    TOP_MODULE_inst1 : entity work.TOP
        port map (
            CLK => C,
            RST => B2,
            btnU => B1,
            btnL => B3,
            led => Diodes
            );
    
end sim;

