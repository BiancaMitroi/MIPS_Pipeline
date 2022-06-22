----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2022 19:07:59
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
port(
    rd1, rd2, extImm : in std_logic_vector(15 downto 0);
    ALUOp : in std_logic_vector(2 downto 0);
    ALUSrc : in std_logic;
    zero, lzero : out std_logic;
    ALURes : out std_logic_vector(15 downto 0)
    );
end ALU;

architecture Behavioral of ALU is

signal b, alres : std_logic_vector(15 downto 0) := x"0000";

begin
    --mux
    process(ALUSrc)
    begin
        if ALUSrc = '0' then b <= rd2;
        else b <= extImm; end if;
    end process;
    
    --ALU
    process(ALUOp)
    begin
        if ALUOp = "000" then alres <= rd1 + b; end if;
        if ALUOp = "001" then alres <= rd1 - b; 
         if rd1 = rd2 then zero <= '1'; end if;
         if rd1 < rd2 then lzero <= '1'; end if;
        end if;
        if ALUOp = "010" then alres <= rd1(12 downto 0) & "000"; end if;
        if ALUOp = "011" then alres <= "000" & rd1(15 downto 3); end if;
        if ALUOp = "100" then alres <= rd1 and b; end if;
        if ALUOp = "101" then alres <= rd1 or b; end if;
        if ALUOp = "110" then alres <= rd1 xor b; end if;
        if ALUOp = "111" then alres <= rd1 nand b; end if;
    end process;
    ALURes <= alres;
end Behavioral;
