library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity UC is
port(
    instr : in std_logic_vector(5 downto 0);
    zero, lzero : in std_logic;
    regDst, ALUSrc, branch, jump, memWrite, memToReg, regWrite : out std_logic;
    ALUOp : out std_logic_vector(2 downto 0)
);
end entity UC;

architecture Behavioral of UC is

begin
    
    --regDst
    process(instr)
    begin
        if instr(5 downto 3) = "000" or instr(5 downto 3) = "111" then regDst <= '1';
        else regDst <= '0'; end if;
    end process;
    
    --ALUSrc
    process(instr)
    begin
        if instr(5 downto 3) = "000" or instr(5 downto 3) = "111" then ALUSrc <= '0';
        else ALUSrc <= '1'; end if;
    end process;
    
    --branch
    process(instr)
    begin
        if (instr(5 downto 3) = "101" and zero = '1') or (instr(5 downto 3) = "110" and lzero = '1') then branch <= '1';
        else branch <= '0'; end if;
    end process;
    
    --jump
    process(instr)
    begin
        if instr(5 downto 3) = "111" then jump <= '1';
        else jump <= '0'; end if;
    end process;
    
    --ALUOp
    process(instr)
    begin
        if instr(5 downto 3) = "000" then ALUOp <= instr(2 downto 0);
        else 
            if instr(5 downto 3) = "001" then ALUOp <= "000"; 
            else
                if instr(5 downto 3) = "010" or instr(5 downto 3) = "101" or instr(5 downto 3) = "110" then ALUOp <= "001"; 
                else
                    ALUOp <= "000";
                end if;
            end if;
        end if;
    end process;
    
    --memWrite
    process(instr)
    begin
        if instr(5 downto 3) = "100" then memWrite <= '1';
        else memWrite <= '0'; end if;
    end process;
    
    --memToReg
    process(instr)
    begin
        if instr(5 downto 3) = "011" then memToReg <= '1';
        else memToReg <= '0'; end if;
    end process;
    
    --RegWrite
    process(instr)
    begin
        if instr(5 downto 3) = "011" or instr(5 downto 3) = "100" or instr(5 downto 3) = "101" or instr(5 downto 3) = "110" or instr(5 downto 3) = "111" then regWrite <= '0';
        else regWrite <= '1'; end if;
    end process;

end Behavioral;
