entity TogglePattern2 is
    Port (
        C : in bit;  -- sygnał zegarowy
        R : in bit;  -- sygnał resetu
        S : in  bit_vector (1 downto 0); -- 2-bitowy sygnał prędkości
        D : out bit_vector (7 downto 0) -- wyjście 8-bitowe
    );
end TogglePattern2;

architecture cialo of TogglePattern2 is

    constant T : integer := 200000; -- stała zakresu zliczania przez 'L' 
    signal L : integer;          -- deklaracja sygnału licznika 'L'
    signal Z : integer;          -- deklaracja sygnału zakresu 'Z' 
    signal D_internal : bit_vector(7 downto 0) := (others => '0'); -- pomocniczy sygnał wyjścia
    signal direction : bit := '1'; -- kierunek zmiany ('1' = zapalanie, '0' = gaszenie)
begin                            -- początek części wykonawczej
    process (R, C) is            -- lista czułości procesu
    begin                        -- część wykonawcza procesu
        if (R = '1') then        -- warunek dla sygnału 'R'
            L <= 0;              -- przypisanie stałej 0 do licznika
            Z <= 0;              -- przypisanie stałej 0 do zakresu
            D_internal <= (others => '0');
            direction <= '1';    -- reset kierunku na zapalanie
        elsif (C'event and C = '1') then -- warunek zbocza narastającego 'C'
            case S is            -- warunek wyboru sygnałem 'S'
                when "01" => Z <= 2*T;       -- ustawienie zakresu 'Z'
                when "10" => Z <= 3*T;   -- ustawienie zakresu 'Z'
                when "11" => Z <= 4*T;   -- ustawienie zakresu 'Z'
                when "00" => Z <= T;  -- ustawienie zakresu 'Z'
                when others => null;       -- pusta instrukcja
            end case;            -- zakończenie instrukcji wyboru

            L <= L + 1;          -- przypisanie nowej wartości licznika

            if (L >= Z) then     -- badanie warunku granicy zliczania
               L <= 0;         -- ustawienie licznika 'L' na wartość 0
                if direction = '1' then
                    -- Zapalanie kolejnych bitów
                    if D_internal = "11111111" then
                        direction <= '0'; -- Zmiana kierunku na gaszenie
                    else
                        -- Znajdź pierwszy bit '0' i zapal go
                        for i in 0 to 7 loop
                            if D_internal(i) = '0' then
                                D_internal(i) <= '1';
                                exit; -- zakończ pętlę
                            end if;
                        end loop;
                    end if;
                else
                    -- Gaszenie kolejnych bitów
                    if D_internal = "00000000" then
                        direction <= '1'; -- Zmiana kierunku na zapalanie
                    else
                        -- Znajdź ostatni bit '1' i zgaś go
                        for i in 7 downto 0 loop
                            if D_internal(i) = '1' then
                                D_internal(i) <= '0';
                                exit; -- zakończ pętlę
                            end if;
                        end loop;
                    end if;
                end if;
            end if;
        end if;
    end process;

    D <= "00000000" when R = '1' else D_internal;

end architecture cialo;
