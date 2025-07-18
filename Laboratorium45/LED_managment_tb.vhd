entity TB_TOP is
end TB_TOP;

architecture sim of TB_TOP is

    -- Deklaracje sygnałów
    signal C : bit;      -- Główny zegar (10 MHz)
    signal B1 : bit;      -- Sygnał wejściowy speed (przycisk z drganiami) prescaler
    signal B2 : bit;      -- Sygnał wejściowy (przycisk z drganiami) reset
    signal B3 : bit;      -- Sygnał wejściowy (przycisk z drganiami)power
    signal Q1 : bit;             -- Wyjście debouncera speed (pojedynczy impuls)
    signal Q2 : bit;             -- Wyjście debouncera reset (pojedynczy impuls)
    signal Q3 : bit;             -- Wyjście debouncera power(pojedynczy impuls)
    signal D1 : bit_vector(1 downto 0);      --wyjście prescalera z deboncerem
    signal D2 : bit;                         -- wyyjście resetu z debouncerem
    signal D3 : bit;                         -- wyyjście powera z debouncerem
    signal Diodes1  : bit_vector(7 downto 0);      -- wyjście ledów mruganie 1
    signal Diodes2  : bit_vector(7 downto 0);      -- wyjście ledów mruganie 2
    signal Diodes   : bit_vector(7 downto 0);      -- wyjście logoki sterującej

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
        wait for 500 ms;
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
            
    Debouncer_inst3: entity work.Debouncer(cialo)
        port map (
            C => C,
            B => B3, 
            Q => Q3
            );            

    Button_inst2 : entity work.Button(cialo)
        port map (
            C => C,
            S => Q3,
            D => D3
            );
     TogglePattern1_inst1 : entity work.TogglePattern1(cialo)
        port map (
            C => C,
            R => D2,
            S => D1,
            D => Diodes1
            );
     TogglePattern2_inst1 : entity work.TogglePattern2(cialo)
        port map (
            C => C,
            R => D2,
            S => D1,
            D => Diodes2
            );
            
     Control_inst1 : entity work.Control(cialo)
        port map (
            T1 => Diodes1,
            T2 => Diodes2,
            P => D3,
            D => Diodes
            );
end sim;

