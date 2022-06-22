----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2022 19:48:24
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
port(
    --in ports
    rd1 : in std_logic_vector(15 downto 0);
    ALUSrc : in std_logic;
    rd2 : in std_logic_vector(15 downto 0);
    extImm : in std_logic_vector(15 downto 0);
    sa : in std_logic;
    func : in std_logic_vector(2 downto 0);
    ALUOp : in std_logic;
    --out ports
    zero : out std_logic;
    ALURes : out std_logic_vector(15 downto 0)
);
end EX;

architecture Behavioral of EX is

begin


end Behavioral;
