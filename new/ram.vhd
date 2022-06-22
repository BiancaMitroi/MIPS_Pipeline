----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2022 16:03:03
-- Design Name: 
-- Module Name: counter16b - Behavioral
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

entity ram_memory is
  Port ( clk, swm : in std_logic;
         --adr : in std_logic_vector(15 downto 0);
         write : in std_logic_vector(15 downto 0);
         data : out std_logic_vector(15 downto 0);
         we : in std_logic
  );
end ram_memory;

architecture Behavioral of ram_memory is

--signal counter16b : std_logic_vector(15 downto 0) := x"0000";
--signal en : std_logic;

 signal wri : std_logic_vector(15 downto 0) := "0000000000000000";
--    signal d : std_logic_vector(3 downto 0);
   signal q, en1, en2 : std_logic := '0' ;
--    signal w : std_logic_vector(1 downto 0) := "00";
    
--signal counter, cif: std_logic_vector(15 downto 0) := "0000000000000000";
signal adr: std_logic_vector(7 downto 0) := "00000000";
--signal cif1: std_logic_vector(3 downto 0);
type RAM is array (0 to 255) of std_logic_vector(15 downto 0);
signal RAM_m: RAM := ("0000001000000001", "1000000000000011", "0000000100001000", others => "0000000000000100");

begin

--memorie ROM
    
    process(swm)
    begin
        if swm = '1' then q <= not q; end if;
        
        if q = '0' then adr <= write(7 downto 0);
        else wri <= write; end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
            RAM_m(CONV_INTEGER(unsigned(adr))) <= wri;
            end if;
        end if;
    end process;
    data <= RAM_m(CONV_INTEGER(unsigned(adr)));

--Memorie RAM

--    component3: ssd port map(sw =>counter, an =>an, cat =>cat, clk =>clk);
--    component1: MPG port map(en =>en1, input =>btn(0), clk =>clk);
--    component2: MPG port map(en =>en2, input =>btn(1), clk =>clk);
    
--    process(en2)
--    begin
--        if q = '1' then counter <= sw; else counter <= ROM_m(CONV_INTEGER(unsigned(sw(7 downto 0)))); end if;
--    end process;
    
--    process(en1)
--    begin
--        if rising_edge(en1) then q <= not q; end if;
--    end process;
    
--    ROM_m(CONV_INTEGER(unsigned(sw(7 downto 0)))) <= counter;
    
end Behavioral;
