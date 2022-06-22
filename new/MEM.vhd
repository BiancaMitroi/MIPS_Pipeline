library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity MEM is
  Port ( 
  memWrite, clk : in std_logic;
  ALURes, rd2 : in std_logic_vector(15 downto 0);
  memData : out std_logic_vector(15 downto 0)
  );
end MEM;

architecture Behavioral of MEM is
type MEM is array(0 to 255) of std_logic_vector(15 downto 0);
signal memory : MEM := (others => x"0000");
begin
    process(clk)
    begin
        if rising_edge(clk) and memWrite = '1' then memory(CONV_INTEGER(UNSIGNED(ALURes))) <= rd2; end if;
    end process;
    memData <= memory(CONV_INTEGER(UNSIGNED(ALURes)));
end Behavioral;
