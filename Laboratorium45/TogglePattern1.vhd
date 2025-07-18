entity TogglePattern1 is
    Port (
        C : in bit;  -- sygnał zegarowy
        R : in bit;  -- sygnał resetu
        S : in  bit_vector (1 downto 0); -- 2-bitowy sygnał prędkości
        D : out bit_vector (7 downto 0) -- wyjście 8-bitowe
    );
end TogglePattern1;

architecture cialo of TogglePattern1 is
  constant T : integer := 200000; -- stala zakresu zlicznia przez 'L' 
  signal L : integer;       -- deklaracja sygnalu licznika 'L'
  signal Z : integer;       -- deklaracja sygnalu zakresu 'Z' 

begin               -- poczatek czesci wykonawczej

process (R, C) is       -- lista czulosci procesu
  begin             -- czesc wykonawcza procesu
    if (R='0') then     -- warunek dla sygnalu 'R'
      L  <= 0;          -- przypisanie stalej 0 do licznika
      Z  <= 0;          -- przypisanie stalej 0 do zakresu
    elsif  (C'event and C='1') then -- warunek zbocza narastajacego 'C'
      case S is         -- warunk wyboru sygnalem 'S'
        when "01" => Z <= 2*T;    -- ustawienie zakresu 'Z'
        when "10" => Z <= 3*T;  -- ustawienie zakresu 'Z'
        when "11" => Z <= 4*T;  -- ustawienie zakresu 'Z'
        when "00" => Z <= T;  -- ustawienie zakresu 'Z'
        when others => null;    -- pusta instrukcja
      end case;         -- zakonczenie instrukcji wyboru
      L  <= L+1;        -- przypisanie nowej wartosci licznika
      if (L>=Z) then       -- badanie warunku granicy zliczania
        L <= 0;         -- ustawienie licznika 'L' na wartosc 0
      end if;           -- zakonczenie instrukcji wyboru
    end if;         -- zakonczenie instrukcji wyboru
  end process;          -- zakonczenie procesu

    -- Warunkowe przypisanie do sygnału 'D', z dodatkowym warunkiem dla resetu 'R'
  D <= "00000000" when R = '0' else 
       "10101010" when L < Z/2 else 
       "01010101";
end architecture cialo;
