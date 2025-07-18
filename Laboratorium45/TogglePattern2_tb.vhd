
entity TogglePattern2_tb is			-- pusty sprzeg projektu symulacji
end TogglePattern2_tb;

architecture behavioural of TogglePattern2_tb is -- cialo architektoniczne projektu

  signal R	:bit;			-- symulowane wejscie R
  signal C	:bit;			-- symulowane wejscie C
  signal S  :bit_vector(1 downto 0);-- deklaracja portu wejsciowego 'S'
  signal D	:bit_vector(7 downto 0);			-- obserwowane wyjscie D
  
 

begin

  process is				-- proces bezwarunkowy
  begin					-- czesc wykonawcza procesu
    R <= '1';				-- przypisanie sygna�owi 'R' wartosci '0'
    wait for 1000 us;			-- odczekanie 10 ns
    R <= '0';				-- przypisanie sygna�owi 'R' wartosci '1'
    wait; --for 100 ns;        -- nakazanie resetu asynchronicznego, ciągnięcie procesu do końca symulacji
  end process;				-- zakonczenie procesu

  process is				-- proces bezwarunkowy
  begin					-- czesc wykonawcza procesu
    C <= '0';				-- przypisanie sygna�owi 'C' wartosci '0'
    wait for 10 us;			-- odczekanie 10 ns
    C <= '1';				-- przypisanie sygna�owi 'C' wartosci '1'
    wait for 10 us;			-- odczekanie 10 ns
  end process;				-- zakonczenie procesu
  
    -- Proces generujący zmiany na sygnale S
  process is
  begin
    S <= "01";                  -- ustawienie wartości S na "01"
    wait;                       -- zatrzymanie procesu (bez końca)
  end process;

  TogglePattern_inst1: entity work.TogglePattern2(cialo) -- instancja projektu 'LICZNIK'
    port map (				-- mapowanie portow
      R => R,				-- przypisanie sygnalu 'R' do portu 'R'
      C => C,				-- przypisanie sygnalu 'C' do portu 'C'
      D => D,				-- przypisanie sygnalu 'D' do portu 'D'
      S => S                -- przypisanie 
    );
end behavioural;			-- zakonczenie ciala architektonicznego