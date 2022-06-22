library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity reg_file is
  Port ( clk, we : in std_logic;
        ra1, ra2, wa : in std_logic_vector(2 downto 0);
        wd : in std_logic_vector(15 downto 0);
        rd1, rd2 : out std_logic_vector(15 downto 0)
  );
end reg_file;

architecture Behavioral of reg_file is
type REG is array (0 to 7) of std_logic_vector(15 downto 0);
signal REG_m: REG := ("0000000000000000", "0000000000000001", "0000000000000001", "0000000000000010", "0000000000000010", "0000000000000001", "0000000000000001", "0000000000000001", others => "0000000000000001");
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then REG_m(CONV_INTEGER(UNSIGNED(wa))) <= wd;
            end if;
        end if;
    end process;
    rd1 <= REG_m(CONV_INTEGER(UNSIGNED(ra1)));
    rd2 <= REG_m(CONV_INTEGER(UNSIGNED(ra2)));
end Behavioral;
