----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2022 17:08:34
-- Design Name: 
-- Module Name: afisare - Behavioral
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
use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity afisare is
  Port ( 
  sel: in std_logic_vector(2 downto 0);
  instruction, nextAddress, rd1, rd2, ext, ALURes, memData, wd : in std_logic_vector(15 downto 0);
  afisare : out std_logic_vector(15 downto 0));
end afisare;

architecture Behavioral of afisare is

begin
    process(sel)
    begin
        case(sel) is
            when "000" => afisare <= instruction;
            when "001" => afisare <= nextAddress;
            when "010" => afisare <= rd1;
            when "011" => afisare <= rd2;
            when "100" => afisare <= ext;
            when "101" => afisare <= ALURes;
            when "110" => afisare <= memData;
            when "111" => afisare <= wd;
        end case;
    end process;


end Behavioral;
