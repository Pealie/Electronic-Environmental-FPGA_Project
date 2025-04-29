-- Sample VHDL template for moisture threshold control
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IrrigationControl is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        moisture : in  STD_LOGIC_VECTOR(11 downto 0); -- 12-bit ADC value
        pump_on  : out STD_LOGIC
    );
end IrrigationControl;

architecture Behavioral of IrrigationControl is
    constant DRY_THRESHOLD  : integer := 1000;
    constant WET_THRESHOLD  : integer := 2500;
    signal moisture_val     : integer := 0;
    signal pump_state       : boolean := false;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            pump_state <= false;
        elsif rising_edge(clk) then
            moisture_val <= to_integer(unsigned(moisture));
            if pump_state = false and moisture_val < DRY_THRESHOLD then
                pump_state <= true;
            elsif pump_state = true and moisture_val > WET_THRESHOLD then
                pump_state <= false;
            end if;
        end if;
    end process;

    pump_on <= '1' when pump_state else '0';
end Behavioral;
