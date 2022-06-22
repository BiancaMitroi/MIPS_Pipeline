
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity instrunctionFetch is
  Port (
    jumpAddress : in std_logic_vector(15 downto 0);
    branchAddress : in std_logic_vector(15 downto 0);
    PCSrc, jump, clk : in std_logic;
    PC1 : out std_logic_vector(15 downto 0);
    instruction : out std_logic_vector(15 downto 0)
  );
end instrunctionFetch;

architecture Behavioral of instrunctionFetch is
-- semnale 
signal mux1ToMux2, mux2ToPc, pcToAdder : std_logic_vector(15 downto 0) := x"0000";
signal adderToMux1 : std_logic_vector(3 downto 0);

--memorie ROM 
type ROM is array(0 to 255) of std_logic_vector(15 downto 0);
signal instructionMemory : ROM := (
--instructiuni de tip R
"0000010100110000", --add
"0000100111000001",-- sub
"0000111001011010",-- sll
"0001001011101011", --srl
"0001011101110100", --and
"0001101110000101",-- or
"0001110000010110",-- xor
"0000000010100111",-- xand
--instructiuni de tip I
"0010010110001011",-- addi
"0100101000010100",-- lw
"0110111010011101",-- sw
"1001001100100110",-- beq
"1011011110101111",-- muli
"1101100000110000",-- div
--instructiune de tip J
"1111110010111001",-- j
others => x"0000"
);
begin
    --mux controlat de semnalul jump
    process(mux1ToMux2, jumpAddress, jump)
    begin
        case jump is
        when '0' => mux2ToPc <= mux1ToMux2;
        when '1' => mux2ToPc <= jumpAddress; end case;
    end process;
    
    --mux controlat de semnalul PCSrc
    process(adderToMux1, branchAddress, PCSrc)
    begin
        case PCSrc is
        when '0' => mux1ToMux2 <= adderToMux1;
        when '1' => mux1ToMux2 <= branchAddress; end case;
    end process;

    --extragerea datelor din memoria de instructiuni
    instruction <= instructionMemory(CONV_INTEGER(UNSIGNED(mux2ToPc)));
    
    --trecerea la adresa urmatoare
    PC1 <= pcToAdder + 1;
    
    --program counter ul
    process(clk)
    begin
        if rising_edge(clk) then pcToAdder <= mux2ToPc + 1; end if; 
    end process;
    
end Behavioral;
