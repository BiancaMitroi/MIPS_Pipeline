----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 19:07:06
-- Design Name: 
-- Module Name: memwb - Behavioral
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

entity memwb is
  Port (
        clk : in std_logic;
        regWriteIn : in std_logic;
        memToRegIn : in std_logic;
        memDataIn : in std_logic_vector(15 downto 0);
        ALUResIn : in std_logic_vector(15 downto 0);
        resultedAddressIn : in std_logic_vector(2 downto 0);
        
        regWriteOut : out std_logic;
        memToRegOut : out std_logic;
        memDataOut : out std_logic_vector(15 downto 0);
        ALUResOut : out std_logic_vector(15 downto 0);
        resultedAddressOut : out std_logic_vector(2 downto 0)
  );
end memwb;

architecture Behavioral of memwb is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            regWriteOut <= regWriteIn;
            memToRegOut <= memToRegIn;
            memDataOut <= memDataIn;
            ALUResOut <= ALUResIn;
            resultedAddressOut <= resultedAddressIn;
        end if;
    end process;

end Behavioral;
