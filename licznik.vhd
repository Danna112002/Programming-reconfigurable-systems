entity LICZNIK is           -- deklaracja sprzegu 'LICZNIK'
 port ( R : in   bit;           -- deklaracja portu wejsciowego 'R'
        C : in   bit;           -- deklaracja portu wejsciowego 'C'
        S : in   bit_vector(1 downto 0);-- deklaracja portu wejsciowego 'S'
        D : out bit         -- deklaracja portu wyjsciowego 'DL'
      );                -- zakonczenie deklaracji listy portow
end LICZNIK;                -- zakonczenie deklaracji sprzegu

architecture cialo of LICZNIK is -- deklaracja ciala 'cialo' architektury

  constant T : integer := 200; -- stala zakresu zlicznia przez 'L' 
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
        when "01" => Z <= T;    -- ustawienie zakresu 'Z'
        when "10" => Z <= 60*T;  -- ustawienie zakresu 'Z'
        when "11" => Z <= 3600*T;  -- ustawienie zakresu 'Z'
        when others => null;    -- pusta instrukcja
      end case;         -- zakonczenie instrukcji wyboru
      L  <= L+1;        -- przypisanie nowej wartosci licznika
      if (L>=Z) then       -- badanie warunku granicy zliczania
        L <= 0;         -- ustawienie licznika 'L' na wartosc 0
      end if;           -- zakonczenie instrukcji wyboru
    end if;         -- zakonczenie instrukcji wyboru
  end process;          -- zakonczenie procesu

  D <= '0' when L<Z/2 else '1'; -- warunkowe przypisanie do sygnalu 'D'
 
end architecture cialo;     -- zakonczenie deklaracji ciala 'cialo'