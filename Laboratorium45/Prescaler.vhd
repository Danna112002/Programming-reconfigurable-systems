entity Prescaler is
    Port (
        C : in bit;  -- sygnał zegarowy
        S : in bit;  -- sygnał guzika, który będzie zliczany
        D : out bit_vector (1 downto 0) -- wyjście indykujące szybkość mrugania
    );
end Prescaler;


architecture cialo of Prescaler is

    -- wewnętrzne sygnały
    signal counter : bit_vector (1 downto 0) := "00"; -- licznik impulsów
    signal prev_s  : bit := '0'; -- poprzedni stan sygnału S (do wykrycia zbocza)

begin

    process(C)
    begin
        if (C'event and C = '1') then
                     -- Wykrycie zbocza narastającego na sygnale S
            if S = '1' and prev_s = '0' then
                if counter = "11" then
                    counter <= "00"; -- reset licznika po osiągnięciu maksimum
                else
                     -- Dodawanie 1 do licznika za pomocą operacji logicznych:
                    counter(0) <= counter(0) xor '1';  -- XOR z 1 dla bitu 0 (suma)
                    counter(1) <= counter(1) xor (counter(0) and '1'); -- XOR z carry dla bitu 1 (suma)
                end if;
            end if;

            -- Aktualizacja poprzedniego stanu S
            prev_s <= S;
        end if;
    end process;

    -- Wyjście D wskazuje aktualny stan licznika
    D <= counter;


end architecture cialo;
