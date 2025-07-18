library IEEE;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;
use     ieee.numeric_std.all;

entity TOP is
    Port (
        CLK      : in  std_logic;  -- sygnał zegarowy
        RST      : in  std_logic;  -- sygnał resetu (przycisk)
        btnU     : in  std_logic;  -- globalny sygnał zmiany prędkości (przycisk)
        btnL     : in  std_logic;  -- globalny sygnał włącz/wyłącz (przycisk)
        led      : out std_logic_vector (7 downto 0) -- globalne wyjście (diody led)
    );
end TOP;

architecture behavioural of TOP is
    --Deklaracje sygnałów
        signal C                        : bit;                    -- Wejście zegara 
        signal Speed_button_in          : bit;                    -- Wejście przycisku zmiany szybkości
        signal Speed_button_out         : bit;                    -- Wyjście przycisku zmiany szybkości
        signal Reset_button_in          : bit;                    -- Wejście przycisku zmiany togglowania
        signal Reset_button_out_db      : bit;                    -- Wyjśćie przycisku zmiany togglowania po debouncerze
        signal Reset_button_out         : bit;                    -- Wyjśćie przycisku zmiany togglowania 
        signal Power_button_in          : bit;                    -- Wejście przycisku włącz/wyłącz
        signal Power_button_out_db      : bit;                    -- Wyjśćie przycisku włącz/wyłącz po debouncerze
        signal Power_button_out         : bit;                    -- Wyjśćie przycisku włącz/wyłącz
        signal Blinking_speed           : bit_vector(1 downto 0); -- Wyjście prescalera, mówiące o szybkości mrugania
        signal Diodes_out_Toggle1       : bit_vector(7 downto 0); -- wyjście wektora z diodami dla togglowania1'
        signal Diodes_out_Toggle2       : bit_vector(7 downto 0); -- wyjście wektora z diodami dla togglowania2
        signal Diodes_out               : bit_vector(7 downto 0); -- wyjście diod ostateczne do konwersji na realne kable
           
begin

        --Mapowanie sygnałów do wejść modułu Debouncera
        C <= to_bit(CLK);
        Speed_button_in <= to_bit(btnU);
        Reset_button_in <= to_bit(RST);
        Power_button_in <= to_bit(btnL);
        
        
        --Instancja zmiany szynkości guzikiem
    Debouncer_inst1 : entity work.Debouncer
        port map (
            C => C,
            B => Speed_button_in, 
            Q => Speed_button_out
            );
            
     Prescaler_inst1 : entity work.Prescaler
        port map (
            C => C,
            S => Speed_button_out,
            D => Blinking_speed
            );
            
            --instancja wyboru trybu guzikiem
    Debouncer_inst2 : entity work.Debouncer
        port map (
            C => C,
            B => Reset_button_in, 
            Q => Reset_button_out_db
            );
            
    Button_inst1 : entity work.Button
        port map (
            C => C,
            S => Reset_button_out_db,
            D => Reset_button_out
            );
            
            --instancja włączania/wyłączania guzikiem
  Debouncer_inst3 : entity work.Debouncer
        port map (
            C => C,
            B => Power_button_in, 
            Q => Power_button_out_db
            );
            
    Button_inst2 : entity work.Button
        port map (
            C => C,
            S => Power_button_out_db,
            D => Power_button_out
            );
        --Mapowanie sygnałów do togglowania1
    TogglePattern1_inst1 : entity work.TogglePattern1
        port map (
            C => C,
            R => Reset_button_out,
            S => Blinking_speed,
            D => Diodes_out_Toggle1
        );
        
        --Mapowanie sygnałów do togglowania2
    TogglePattern2_inst1 : entity work.TogglePattern2
        port map (
            C => C,
            R => Reset_button_out, 
            S => Blinking_speed,
            D => Diodes_out_Toggle2
        );
        
        --MApowanie sygnałów do modułu kontroli
     Control_inst1 : entity work.Control
        port map (
            T1 => Diodes_out_Toggle1,
            T2 => Diodes_out_Toggle2,
            P => Power_button_out,
            D => Diodes_out
            );
            
            --Mapowanie Diodes_out na fizyczne ledy
       
       led(0) <= to_stdulogic(Diodes_out(0));
       led(1) <= to_stdulogic(Diodes_out(1));
       led(2) <= to_stdulogic(Diodes_out(2));
       led(3) <= to_stdulogic(Diodes_out(3));
       led(4) <= to_stdulogic(Diodes_out(4));
       led(5) <= to_stdulogic(Diodes_out(5));
       led(6) <= to_stdulogic(Diodes_out(6));
       led(7) <= to_stdulogic(Diodes_out(7));
       
            -- Mapowanie wirtualnych prycisków na prawdziwe
            
       
         
end behavioural;
