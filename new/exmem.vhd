----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 18:50:58
-- Design Name: 
-- Module Name: exmem - Behavioral
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

entity exmem is
  Port (
        clk : in std_logic;
        memToRegIn : in std_logic;
        regWriteIn : in std_logic;
        memWriteIn : in std_logic;
        branchIn : in std_logic;
        resultedAddressIn : in std_logic_vector(15 downto 0);
        zeroIn : in std_logic;
        lzeroIn : in std_logic;
        ALUResIn : in std_logic_vector(15 downto 0);
        rd2In : in std_logic_vector(15 downto 0);
        regAddressIn : in std_logic_vector(2 downto 0);
        
        memToRegOut : out std_logic;
        regWriteOut : out std_logic;
        memWriteOut : out std_logic;
        branchOut : out std_logic;
        resultedAddressOut : out std_logic_vector(15 downto 0);
        zeroOut : out std_logic;
        lzeroOut : out std_logic;
        ALUResOut : Out std_logic_vector(15 downto 0);
        rd2Out : Out std_logic_vector(15 downto 0);
        regAddressOut : out std_logic_vector(2 downto 0)
   );
end exmem;

architecture Behavioral of exmem is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            memToRegOut <= memToRegIn;
            regWriteOut <= regWriteIn;
            memWriteOut <= memWriteIn;
            branchOut <= branchIn;
            resultedAddressOut <= resultedAddressIn;
            zeroOut <= zeroIn;
            lzeroOut <= lzeroIn;
            ALUResOut <= ALUResIn;
            rd2Out <= rd2In;
            regAddressOut <= regAddressIn;
        end if;
    end process;

end Behavioral;
