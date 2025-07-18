entity Button is
    Port (
        C : in bit;  -- sygnał zegarowy
        S : in bit;  -- sygnał guzika, który będzie zliczany
        D : out bit -- wyjście indykujące wciśnięcie 
    );
end Button;


architecture cialo of Button is

    -- wewnętrzne sygnały
    signal toggle : bit := '0'; -- sygnał przełączający (naprzemienne 0 i 1)
    signal prev_s : bit := '0'; -- poprzedni stan sygnału S (do wykrycia zbocza)

begin

    process(C)
    begin
        if (C'event and C = '1') then
            -- Wykrycie zbocza narastającego na sygnale S
            if S = '1' and prev_s = '0' then
                -- Naprzemienne zmienianie wartości sygnału `toggle`
                toggle <= not toggle; 
            end if;

            -- Aktualizacja poprzedniego stanu sygnału S
            prev_s <= S;
        end if;
    end process;

    -- Przypisanie wartości sygnału `toggle` do wyjścia D
    D <= toggle;

end architecture cialo;
