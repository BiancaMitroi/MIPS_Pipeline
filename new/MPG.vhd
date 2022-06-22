----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2022 16:30:52
-- Design Name: 
-- Module Name: MPG - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MPG is
Port ( en : out STD_LOGIC;
           input : in STD_LOGIC;
           clk : in STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal count_int : std_logic_vector(15 downto 0) := "0000000000000000";
signal q1, q2, q3 : std_logic;

begin
    en <= q2 and (not q3);
    
    process(clk)
    begin
        if rising_edge(clk) then
            count_int <= count_int + 1;
            if count_int = "1111111111111111" then
                q1 <= input;
            end if;
            q2 <= q1;
            q3 <= q2;
        end if;
    end process;        

end Behavioral;
