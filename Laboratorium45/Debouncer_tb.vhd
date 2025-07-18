entity Debouncer_tb is
end Debouncer_tb;

architecture behavioral of Debouncer_tb is

    -- Deklaracje sygnałów
    signal C : bit;      -- Główny zegar (10 MHz)
    signal B1 : bit;      -- Sygnał wejściowy speed (przycisk z drganiami)
    signal B2 : bit;      -- Sygnał wejściowy (przycisk z drganiami)
    signal Q1 : bit;             -- Wyjście debouncera speed (pojedynczy impuls)
    signal Q2 : bit;             -- Wyjście debouncera reset (pojedynczy impuls)
    signal D1 : bit_vector(1 downto 0);      --wyjście prescalera z deboncerem
    signal D2 : bit;                         -- wyyjście resetu z debouncerem

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
        wait for 100 ms;
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
        wait for 100 ms;
    end process;

    Debouncer_inst1: entity work.Debouncer(cialo)
        port map (
            C => C,
            B => B1, 
            Q => Q1
            );
     Prescaler_inst1: entity work.Prescaler(cialo)
        port map (
            C => C,
            S => Q1,
            D => D1
            );
            
    Debouncer_inst2: entity work.Debouncer(cialo)
        port map (
            C => C,
            B => B2, 
            Q => Q2
            );            

    Button_inst1 : entity work.Button(cialo)
        port map (
            C => C,
            S => Q2,
            D => D2
            );      
--     TogglePattern1_inst1 : entity work.TogglePattern(cialo)
--        port map (
--            C
--            R
--            S 
--            D => out
--            );
            
end behavioral;

