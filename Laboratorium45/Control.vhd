entity Control is
    Port (
        T1 : in bit_vector(7 downto 0);  -- sygnał toggla na 2 sposób
        T2 : in bit_vector(7 downto 0);  -- sygnał toggla na 1 sposób
        P  : in bit; 			 -- sygnał informijący o włączeniu lub wyłączeniu
        D  : out bit_vector(7 downto 0) -- sygnał wyjściowy
    );
end Control;


architecture cialo of Control is
begin
    process (T1, T2, P)
    begin
        if P = '1' then
            D <= T1 or T2;  -- Suma T1 i T2, gdy P ma stan wysoki
        else
            D <= (others => '0');  -- Wyjście to same zera, gdy P ma stan niski
        end if;
    end process;
end architecture cialo;
