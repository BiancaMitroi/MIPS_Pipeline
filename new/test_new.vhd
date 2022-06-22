----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2022 16:53:44
-- Design Name: 
-- Module Name: test_new - Behavioral
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

entity test_new is
  Port ( clk : in std_logic;
         sw : in std_logic_vector(15 downto 0);
         led : out std_logic_vector(15 downto 0);
         cat : out std_logic_vector(6 downto 0);
         an : out std_logic_vector(3 downto 0);
         btn : in std_logic_vector(4 downto 0)
  );
end test_new;

architecture Behavioral of test_new is
signal counter3b : std_logic_vector(2 downto 0) := "000";
signal en : std_logic;
component MPG is
Port ( en : out STD_LOGIC;
       input : in STD_LOGIC;
       clk : in STD_LOGIC);
end component;

begin

    component1 : MPG port map(en => en, input => btn(0), clk => clk);
    process(en)
    begin
    led <= x"0000";
        if rising_edge(en) then 
            if sw(0) = '0' then counter3b <= counter3b + 1;
            else counter3b <= counter3b - 1;
            end if;
        end if;
        case counter3b is
        when "000" => led(0) <= '1';
        when "001" => led(1) <= '1';
        when "010" => led(2) <= '1';
        when "011" => led(3) <= '1';
        when "100" => led(4) <= '1';
        when "101" => led(5) <= '1';
        when "110" => led(6) <= '1';
        when "111" => led(7) <= '1';
        end case;
    end process;
end Behavioral;
