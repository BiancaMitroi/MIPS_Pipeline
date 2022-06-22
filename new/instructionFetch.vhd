
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity instructionFetch is
  Port (
    jumpAddress : in std_logic_vector(15 downto 0);
    branchAddress : in std_logic_vector(15 downto 0);
    PCSrc, jump, clk : in std_logic;
    PC1 : out std_logic_vector(15 downto 0);
    instruction : out std_logic_vector(15 downto 0)
  );
end instructionFetch;

architecture Behavioral of instructionFetch is
-- semnale 
signal mux1ToMux2, mux2ToPc, pcToAdder : std_logic_vector(15 downto 0) := x"0000";
signal adderToMux1 : std_logic_vector(15 downto 0);

--memorie ROM 
type ROM is array(0 to 255) of std_logic_vector(15 downto 0);
signal instructionMemory : ROM := (
--instructiuni de tip R
"0000010010010000", --add $1, $1, $1 (RF[$1] <- RF[$1] + RF[$1])
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000010100010001",-- sub $1, $1, $2 (RF[$1] <- RF[$1] - RF[$2])
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000010010011010",-- sll $1, 3 (RF[$1] <- RF[$1] << 3 / RF[$1] <- RF[$1] * 8)
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000010010011011", --srl $1, 3 (RF[$1] <- RF[$1] >> 3 / RF[$1] <- RF[$1] / 8)
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000010110110100", --and $3, $1, $3 (RF[$3] <- RF[$1] & RF[$3])
"0000011000100101",-- or $1, $1, $2 (RF[$1] <- RF[$1] | RF[$2])
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000010101010110",-- xor $1, $1, $2 (RF[$1] <- RF[$1] ^ RF[$2])
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000010100010111",-- nand $1, $1, $2 (RF[$1] <- !(RF[$1] & RF[$2]))
--instructiuni de tip I
"0011101100000001",-- addi $6, 1 (RF[$6] <- RF[$6] + 1)
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
"1001101010011000",-- beq $6, $5 (if RF[$6] = RF[$5] then nextAddress <- $32)
"0000000000000000", --noOp
"0000000000000000", --noOp
"0101101100000001",-- subi $6, 1 (RF[$6] <- RF[$6] - 1)
"0110100100000000",-- lw $2, $2 (MEM[RF[$2] - 0] <- RF[$2])
"0000000000000000", --noOp
"0000000000000000", --noOp
"1101111100011101",-- bltz $7, $6 (if RF[$7] < RF[$6] then nextAddress <- $39)
"1010010100000001",-- sw $1, $2 (RF[$1] <- MEM[RF[$2] - 1])
"0000000000000000", --noOp
"0000000000000000", --noOp
"0000000000000000", --noOp
--instructiune de tip J
"1110000000000000",-- j $0 (nextAddress <- $0)
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
    process(pcToAdder, branchAddress, PCSrc)
    begin
        case PCSrc is
        when '0' => mux1ToMux2 <= pcToAdder + 1;
        when '1' => mux1ToMux2 <= branchAddress; end case;
    end process;

    --extragerea datelor din memoria de instructiuni
    instruction <= instructionMemory(CONV_INTEGER(UNSIGNED(pcToAdder)));
    
    --trecerea la adresa urmatoare
    PC1 <= pcToAdder + 1;
    
    --program counter ul
    process(clk)
    begin
        if rising_edge(clk) then pcToAdder <= mux2ToPc; end if; 
    end process;
    
end Behavioral;
