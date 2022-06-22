----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 18:35:19
-- Design Name: 
-- Module Name: idex - Behavioral
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

entity idex is
  Port ( 
        clk : in std_logic;
        memToRegIn : in std_logic;
        regWriteIn : in std_logic;
        memWriteIn : in std_logic;
        branchIn : in std_logic;
        ALUOpIn : in std_logic_vector(2 downto 0);
        ALUSrcIn : in std_logic;
        regDstIn : in std_logic;
        nextAddressIn : in std_logic_vector(15 downto 0);
        rd1In : in std_logic_vector(15 downto 0);
        rd2In : in std_logic_vector(15 downto 0);
        extImmIn : in std_logic_vector(15 downto 0);
        extToIn : in std_logic_vector(15 downto 0);
        ra1In : in std_logic_vector(2 downto 0);
        ra2In : in std_logic_vector(2 downto 0);
        
        memToRegOut : out std_logic;
        regWriteOut : out std_logic;
        memWriteOut : out std_logic;
        branchOut : out std_logic;
        ALUOpOut : out std_logic_vector(2 downto 0);
        ALUSrcOut : out std_logic;
        regDstOut : out std_logic;
        nextAddressOut : out std_logic_vector(15 downto 0);
        rd1Out : out std_logic_vector(15 downto 0);
        rd2Out : out std_logic_vector(15 downto 0);
        extImmOut : out std_logic_vector(15 downto 0);
        extToOut : out std_logic_vector(15 downto 0);
        ra1Out : out std_logic_vector(2 downto 0);
        ra2Out : out std_logic_vector(2 downto 0)
  );
end idex;

architecture Behavioral of idex is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            memToRegOut <= memToRegIn;
            regWriteOut <= regWriteIn;
            memWriteOut <= memWriteIn;
            branchOut <= branchIn;
            ALUOpOut <= ALUOpIn;
            ALUSrcOut <= ALUSrcIn;
            regDstOut <= regDstIn;
            nextAddressOut <= nextAddressIn;
            rd1Out <= rd1In;
            rd2Out <= rd2In;
            extImmOut <= extImmIn;
            extToOut <= extToIn;
            ra1Out <= ra1In;
            ra2Out <= ra2In;
        end if;
    end process;

end Behavioral;
