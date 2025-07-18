    entity Debouncer is
        Port (
            C        : in  bit;  -- sygnał zegarowy (10 MHz)
            B        : in  bit;  -- sygnał przycisku
            Q        : out bit -- wyjście 
            );
    end Debouncer;
    
    architecture cialo of Debouncer is
    
        -- zegar
        signal counter  : integer := 0;
        -- wewnętrzne sygnały orzerzytników
        signal Q1, Q2 : bit := '0';
    
    begin


    process(C) is
        begin
        if (C'event and C='1') then
            if counter = 1250000-1 then
                counter <= 0;
                Q1 <= B;
                Q2 <= Q1;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;


    -- wyjście
    Q <= Q1 and not Q2;

end cialo;

