----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2022 19:59:58
-- Design Name: 
-- Module Name: ID - Behavioral
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

entity ID is
port(
    -- in ports
    clk : in std_logic;
    regWrite : in std_logic;
    instr : in std_logic_vector(15 downto 0);
    regDst : in std_logic;
    extOp : in std_logic;
    wd : in std_logic_vector(15 downto 0);
    --out ports
    rd1 : out std_logic_vector(15 downto 0);
    rd2 : out std_logic_vector(15 downto 0);
    extImm : out std_logic_vector(15 downto 0);
    func : out std_logic_vector(2 downto 0);
    sa : out std_logic
);
end ID;

architecture Behavioral of ID is
--components
component reg_file is
  Port ( clk, we : in std_logic;
        ra1, ra2, wa : in std_logic_vector(7 downto 0);
        wd : in std_logic_vector(15 downto 0);
        rd1, rd2 : out std_logic_vector(15 downto 0)
  );
end component;
--signals
signal writeAdress : std_logic_vector(3 downto 0) :="0000";
begin
-- mapped components
    componentRegFile : reg_file port map(clk =>clk, we =>regWrite, ra1 =>instr(15 downto 12), ra2 =>instr(11 downto 8), wa =>writeAdress, wd =>wd, rd1 =>rd1, rd2 =>rd2);

--processed components
    process(regDst)
    begin
        if regDst = '0' then writeAdress <= instr(11 downto 8);
        else writeAdress <= instr(7 downto 4); end if;
    end process;
    
    process(extOp)
    begin
        if extOp = '1' then extImm <= "00000000" & instr(7 downto 0);
        end if;
    end process;
    
--simple transmission
    func <= instr(2 downto 0);
    sa <= instr(3);
end Behavioral;
