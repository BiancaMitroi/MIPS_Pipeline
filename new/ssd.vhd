----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2022 17:34:20
-- Design Name: 
-- Module Name: ssd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd is
port(
    sw : in std_logic_vector(15 downto 0);
    an : out std_logic_vector(3 downto 0);
    cat : out std_logic_vector(6 downto 0);
    clk : in std_logic
    );
end ssd;

architecture Behavioral of ssd is

    signal count : std_logic_vector(15 downto 0) := "0000000000000000";
    signal d : std_logic_vector(3 downto 0);
   
begin
    process(clk)
    begin
        if rising_edge(clk) then count <= count + 1; end if;
        case count(15 downto 14) is
        when "00" => d <= sw(3 downto 0); an <= "1110";
        when "01" => d <= sw(7 downto 4); an <= "1101";
        when "10" => d <= sw(11 downto 8); an <= "1011";
        when "11" => d <= sw(15 downto 12); an <= "0111";
        end case;
        
        case d is
            when "0000" => cat <= "1000000";
            when "0001" => cat <= "1111001";
            when "0010" => cat <= "0100100";
            when "0011" => cat <= "0110000";
            when "0100" => cat <= "0011001";
            when "0101" => cat <= "0010010";
            when "0110" => cat <= "0000010";
            when "0111" => cat <= "1111000";
            when "1000" => cat <= "0000000";
            when "1001" => cat <= "0010000";
            when "1010" => cat <= "0001000";
            when "1011" => cat <= "0000011";
            when "1100" => cat <= "1000110";
            when "1101" => cat <= "0100001";
            when "1110" => cat <= "0000110";
            when others => cat <= "0001110";
        end case;
    end process;


end Behavioral;
