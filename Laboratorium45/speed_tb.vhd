entity Debouncer_tb is
end Debouncer_tb;

architecture behavioral of Debouncer_tb is

    -- Deklaracje sygnałów
    signal C : bit;      -- Główny zegar (10 MHz)
    signal B : bit;      -- Sygnał wejściowy (przycisk z drganiami)
    signal Q : bit;             -- Wyjście debouncera (pojedynczy impuls)

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
        B <= '0';
        wait for 100 ms;

        -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan wysoki
        B <= '1';
        wait for 100 ms;
        
                -- Drgania (oscylacje między 1 a 0, szybsze niż slow_clk)
        for i in 0 to 9999 loop  -- Symulacja 20 drgań
            B <= '1';
            wait for 1000 ns;   -- 50 µs drgania (szybkie przełączenie)
            B <= '0';
            wait for 1000 ns;
        end loop;

        -- Stabilny stan niski
        B <= '0';
        wait for 100 ms;
    end process;

    Debouncer_inst1: entity work.Debouncer(cialo)
        port map (
            C => C,
            B => B, 
            Q => Q
            );
            
end behavioral;

