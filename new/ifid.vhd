----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 18:30:40
-- Design Name: 
-- Module Name: ifid - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ifid is
  Port (
        clk : in std_logic;
        nextAddressIn : in std_logic_vector(15 downto 0);
        instructionIn : in std_logic_vector(15 downto 0);
        nextAddressOut : out std_logic_vector(15 downto 0);
        instructionOut : out std_logic_vector(15 downto 0)
   );
end ifid;

architecture Behavioral of ifid is

begin
    process(clk)
    begin
        if rising_edge(clk) then 
            nextAddressOut <= nextAddressIn;
            instructionOut <= instructionIn;
        end if;
    end process;

end Behavioral;
