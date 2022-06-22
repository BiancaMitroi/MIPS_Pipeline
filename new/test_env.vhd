library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

entity test_env is
  Port ( clk : in std_logic;
         sw : in std_logic_vector(15 downto 0);
         led : out std_logic_vector(15 downto 0);
         cat : out std_logic_vector(6 downto 0);
         an : out std_logic_vector(3 downto 0);
         btn : in std_logic_vector(4 downto 0)
  );
end test_env;

architecture Behavioral of test_env is

--semnale de control
signal zero, lzero, regDst, extOp, ALUSrc, branch, jump, memWrite, memToReg, regWrite, PCSrc : std_logic;
signal ALUOp : std_logic_vector(2 downto 0);

--semnal de activare semnale de control
signal instrToUC : std_logic_vector(5 downto 0);

--instructiunea
signal instruction : std_logic_vector(15 downto 0);

--adresa urmatoare, rezultatul ALU, citirea din memorie, etc
signal nextAddress, ALURes, memData, branchAddress, jumpAddress, afis : std_logic_vector(15 downto 0);

--semnale muxuri
signal muxWa : std_logic_vector(2 downto 0);
--semnale butoane
   signal q, en1, en2 : std_logic := '0' ;

--semnale de scriere / iesire din regFile    
signal wd, rd1, rd2: std_logic_vector(15 downto 0) := "0000000000000000";

--semnal de extins
signal extTo : std_logic_vector(15 downto 0);

--semnale pe registrele de pipeline

--component memwb
signal regWriteInMemWb : std_logic;
signal memToRegInMemWb : std_logic;
signal memDataInMemWb : std_logic_vector(15 downto 0);
signal ALUResInMemWb : std_logic_vector(15 downto 0);
signal resultedAddressInMemWb : std_logic_vector(2 downto 0);
        
signal regWriteOutMemWb : std_logic;
signal memToRegOutMemWb : std_logic;
signal memDataOutMemWb : std_logic_vector(15 downto 0);
signal ALUResOutMemWb : std_logic_vector(15 downto 0);
signal resultedAddressOutMemWb : std_logic_vector(2 downto 0);

--component exmem
signal memToRegInExMem : std_logic;
signal regWriteInExMem : std_logic;
signal memWriteInExMem : std_logic;
signal branchInExMem : std_logic;
signal resultedAddressInExMem : std_logic_vector(15 downto 0);
signal zeroInExMem : std_logic;
signal lzeroInExMem : std_logic;
signal ALUResInExMem : std_logic_vector(15 downto 0);
signal rd2InExMem : std_logic_vector(15 downto 0);
signal regAddressInExMem : std_logic_vector(2 downto 0);
        
signal memToRegOutExMem : std_logic;
signal regWriteOutExMem : std_logic;
signal memWriteOutExMem : std_logic;
signal branchOutExMem : std_logic;
signal resultedAddressOutExMem : std_logic_vector(15 downto 0);
signal zeroOutExMem : std_logic;
signal lzeroOutExMem : std_logic;
signal ALUResOutExMem : std_logic_vector(15 downto 0);
signal rd2OutExMem : std_logic_vector(15 downto 0);
signal regAddressOutExMem : std_logic_vector(2 downto 0);

--component ifid
signal nextAddressInIfId : std_logic_vector(15 downto 0);
signal instructionInIfId : std_logic_vector(15 downto 0);
signal nextAddressOutIfId : std_logic_vector(15 downto 0);
signal instructionOutIfId : std_logic_vector(15 downto 0);

--component idex
signal memToRegInIdEx : std_logic;
signal regWriteInIdEx : std_logic;
signal memWriteInIdEx : std_logic;
signal branchInIdEx : std_logic;
signal ALUOpInIdEx : std_logic_vector(2 downto 0);
signal ALUSrcInIdEx : std_logic;
signal regDstInIdEx : std_logic;
signal nextAddressInIdEx : std_logic_vector(15 downto 0);
signal rd1InIdEx : std_logic_vector(15 downto 0);
signal rd2InIdEx : std_logic_vector(15 downto 0);
signal extImmInIdEx : std_logic_vector(15 downto 0);
signal extToInIdEx : std_logic_vector(15 downto 0);
signal ra1InIdEx : std_logic_vector(2 downto 0);
signal ra2InIdEx : std_logic_vector(2 downto 0);
        
signal memToRegOutIdEx : std_logic;
signal regWriteOutIdEx : std_logic;
signal memWriteOutIdEx : std_logic;
signal branchOutIdEx : std_logic;
signal ALUOpOutIdEx : std_logic_vector(2 downto 0);
signal ALUSrcOutIdEx : std_logic;
signal regDstOutIdEx : std_logic;
signal nextAddressOutIdEx : std_logic_vector(15 downto 0);
signal rd1OutIdEx : std_logic_vector(15 downto 0);
signal rd2OutIdEx : std_logic_vector(15 downto 0);
signal extImmOutIdEx : std_logic_vector(15 downto 0);
signal extToOutIdEx : std_logic_vector(15 downto 0);
signal ra1OutIdEx : std_logic_vector(2 downto 0);
signal ra2OutIdEx : std_logic_vector(2 downto 0);


--declarare componente

component memwb is
  Port (
        clk : in std_logic;
        regWriteIn : in std_logic;
        memToRegIn : in std_logic;
        memDataIn : in std_logic_vector(15 downto 0);
        ALUResIn : in std_logic_vector(15 downto 0);
        resultedAddressIn : in std_logic_vector(2 downto 0);
        
        regWriteOut : out std_logic;
        memToRegOut : out std_logic;
        memDataOut : out std_logic_vector(15 downto 0);
        ALUResOut : out std_logic_vector(15 downto 0);
        resultedAddressOut : out std_logic_vector(2 downto 0)
  );
end component;

component exmem is
  Port (
        clk : in std_logic;
        memToRegIn : in std_logic;
        regWriteIn : in std_logic;
        memWriteIn : in std_logic;
        branchIn : in std_logic;
        resultedAddressIn : in std_logic_vector(15 downto 0);
        zeroIn : in std_logic;
        lzeroIn : in std_logic;
        ALUResIn : in std_logic_vector(15 downto 0);
        rd2In : in std_logic_vector(15 downto 0);
        regAddressIn : in std_logic_vector(2 downto 0);
        
        memToRegOut : out std_logic;
        regWriteOut : out std_logic;
        memWriteOut : out std_logic;
        branchOut : out std_logic;
        resultedAddressOut : out std_logic_vector(15 downto 0);
        zeroOut : out std_logic;
        lzeroOut : out std_logic;
        ALUResOut : Out std_logic_vector(15 downto 0);
        rd2Out : Out std_logic_vector(15 downto 0);
        regAddressOut : out std_logic_vector(2 downto 0)
   );
end component;

component ifid is
  Port (
        clk : in std_logic;
        nextAddressIn : in std_logic_vector(15 downto 0);
        instructionIn : in std_logic_vector(15 downto 0);
        nextAddressOut : out std_logic_vector(15 downto 0);
        instructionOut : out std_logic_vector(15 downto 0)
   );
end component;

component idex is
  Port ( 
        clk : in std_logic;
        memToRegIn : in std_logic;
        regWriteIn : in std_logic;
        memWriteIn : in std_logic;
        branchIn : in std_logic;
        ALUOpIn : in std_logic_vector(2 downto 0);
        ALUSrcIn : in std_logic;
        regDstIn : in std_logic;
        nextAddressIn : in std_logic_vector(15 downto 0);
        rd1In : in std_logic_vector(15 downto 0);
        rd2In : in std_logic_vector(15 downto 0);
        extImmIn : in std_logic_vector(15 downto 0);
        extToIn : in std_logic_vector(15 downto 0);
        ra1In : in std_logic_vector(2 downto 0);
        ra2In : in std_logic_vector(2 downto 0);
        
        memToRegOut : out std_logic;
        regWriteOut : out std_logic;
        memWriteOut : out std_logic;
        branchOut : out std_logic;
        ALUOpOut : out std_logic_vector(2 downto 0);
        ALUSrcOut : out std_logic;
        regDstOut : out std_logic;
        nextAddressOut : out std_logic_vector(15 downto 0);
        rd1Out : out std_logic_vector(15 downto 0);
        rd2Out : out std_logic_vector(15 downto 0);
        extImmOut : out std_logic_vector(15 downto 0);
        extToOut : out std_logic_vector(15 downto 0);
        ra1Out : out std_logic_vector(2 downto 0);
        ra2Out : out std_logic_vector(2 downto 0)
  );
end component;

component MPG is
Port ( en : out STD_LOGIC;
       input : in STD_LOGIC;
       clk : in STD_LOGIC);
end component;

component ssd is
port(
    sw : in std_logic_vector(15 downto 0);
    an : out std_logic_vector(3 downto 0);
    cat : out std_logic_vector(6 downto 0);
    clk : in std_logic
    );
end component;

component counter16biti is
port(
    clk : in std_logic;
    sw : in std_logic;
    led : out std_logic_vector(15 downto 0)
    );
end component;

component ALU is
port(
    rd1, rd2, extImm : in std_logic_vector(15 downto 0);
    ALUOp : in std_logic_vector(2 downto 0);
    ALUSrc : in std_logic;
    zero, lzero : out std_logic;
    ALURes : out std_logic_vector(15 downto 0)
    );
end component;

component rom_memory is
  Port (
         sw0 : in std_logic;
         led0 : out std_logic_vector(15 downto 0);
         btn0 : in std_logic
  );
end component;

component MEM is
  Port ( 
  memWrite, clk : in std_logic;
  ALURes, rd2 : in std_logic_vector(15 downto 0);
  memData : out std_logic_vector(15 downto 0)
  );
end component;


component reg_file is
  Port ( clk, we : in std_logic;
        ra1, ra2, wa : in std_logic_vector(2 downto 0);
        wd : in std_logic_vector(15 downto 0);
        rd1, rd2 : out std_logic_vector(15 downto 0)
  );
end component;

component instructionFetch is
Port (
    jumpAddress : in std_logic_vector(15 downto 0);
    branchAddress : in std_logic_vector(15 downto 0);
    PCSrc, jump, clk : in std_logic;
    PC1 : out std_logic_vector(15 downto 0);
    instruction : out std_logic_vector(15 downto 0)
  );
end component;

component UC is
port(
    instr : in std_logic_vector(5 downto 0);
    zero, lzero : in std_logic;
    regDst, ALUSrc, branch, jump, memWrite, memToReg, regWrite : out std_logic;
    ALUOp : out std_logic_vector(2 downto 0)
);
end component;

component afisare is
  Port ( 
  sel: in std_logic_vector(2 downto 0);
  instruction, nextAddress, rd1, rd2, ext, ALURes, memData, wd : in std_logic_vector(15 downto 0);
  afisare : out std_logic_vector(15 downto 0));
end component;

begin

--componente mari

   component1MPG : MPG port map(en => en1, input => btn(0), clk => clk);
   componentSSD : ssd port map(sw => afis, an =>an, cat =>cat, clk =>clk);
   componentUC : UC port map(instr => instrToUC, zero => zeroOutExMem, lzero => lzeroOutExMem, regDst => regDstInIdEx, ALUSrc => ALUSrcInIdEx, branch => branchInIdEx, jump => jump, memWrite => memWriteInIdEx, memToReg => memToRegInIdEx, regWrite => regWriteInIdEx, ALUOp => ALUOpInIdEx);
   componentInstructions : instructionFetch port map(jumpAddress =>jumpAddress, branchAddress => branchAddress, PCSrc => PCSrc, jump => jump, clk =>en1, PC1 => nextAddressInIfId, instruction => instructionInIfId);
   componentREGFILE: reg_file port map(clk =>clk, we => regWriteOutMemWb, ra1 => instructionOutIfId(12 downto 10), ra2 => instructionOutIfId(9 downto 7), wa => resultedAddressOutMemWb, wd =>wd, rd1 => rd1InIdEx, rd2 => rd2InIdEx);
   componentALU: ALU port map(rd1 => rd1OutIdEx, rd2 => rd2OutIdEx, extImm => extToOutIdEx, ALUOp => ALUOpOutIdEx, ALUSrc => ALUSrcOutIdEx, zero => zeroInExMem, lzero => lzeroInExMem, ALURes => ALUResInExMem);
   componentMEM: MEM port map(memWrite => memWriteOutExMem, clk => clk, ALURes => ALUResOutExMem, rd2 => rd2OutExMem, memData => memDataInMemWb);
   componentAfisare: afisare port map(sel => sw(2 downto 0), instruction => instructionInIfId, nextAddress => nextAddressInIfId, rd1 => rd1InIdEx, rd2 => rd2InIdEx, ext => extToInIdEx, ALURes => ALUResInExMem, memData => memDataInMemWb, wd => wd, afisare => afis);
   
   componentIfId : ifid port map(clk => en1, nextAddressIn => nextAddressInIfId, instructionIn => instructionInIfId, nextAddressOut => nextAddressOutIfId, instructionOut => instructionOutIfId);
   componentIdEx : idex port map(clk => en1, memToRegIn => memToRegInIdEx, regWriteIn => regWriteInIdEx, memWriteIn => memWriteInIdEx, branchIn => branchInIdEx, ALUOpIn => ALUOpInIdex, ALUSrcIn => ALUSrcInIdex, regDstIn => regDstInIdex, nextAddressIn => nextAddressInIdex, rd1In => rd1InIdex, rd2In => rd2InIdex, extImmIn => extImmInIdex, extToIn => extToInIdex, ra1In => instructionOutIfId(9 downto 7), ra2In => instructionOutIfId(6 downto 4), memToRegOut => memToRegOutIdex, regWriteOut => regWriteOutIdex, memWriteOut => memWriteOutIdex, branchOut => branchOutIdex, ALUOpOut => ALUOpOutIdex, ALUSrcOut => ALUSrcOutIdex, regDstOut => regDstOutIdex, nextAddressOut => nextAddressOutIdex, rd1Out => rd1OutIdex, rd2Out => rd2OutIdex, extImmOut => extImmOutIdex, extToOut => extToOutIdex, ra1Out => ra1OutIdex, ra2Out => ra2OutIdex);
   componentExMem : exmem port map(clk => en1, memToRegIn => memToRegInExMem, regWriteIn => regWriteInExMem, memWriteIn => memWriteInExMem,  branchIn => branchInExMem, resultedAddressIn => resultedAddressInExMem, zeroIn => zeroInExMem, lzeroIn => lzeroInExMem, ALUResIn => ALUResInExMem, rd2In => rd2InExMem, regAddressIn => regAddressInExMem, memToRegOut => memToRegOutExMem, regWriteOut => regWriteOutExMem, memWriteOut => memWriteOutExMem,  branchOut => branchOutExMem, resultedAddressOut => resultedAddressOutExMem, zeroOut => zeroOutExMem, lzeroOut => lzeroOutExMem, ALUResOut => ALUResOutExMem, rd2Out => rd2OutExMem, regAddressOut => regAddressOutExMem);
   componentMemWb : memwb port map(clk => en1, regWriteIn => regWriteInMemWb, memToRegIn => memToRegInMemWb, memDataIn => memDataInMemWb, ALUResIn => ALUResInMemWb, resultedAddressIn => resultedAddressInMemWb, regWriteOut => regWriteOutMemWb, memToRegOut => memToRegOutMemWb, memDataOut => memDataOutMemWb, ALUResOut => ALUResOutMemWb, resultedAddressOut => resultedAddressOutMemWb);
   
--componente simple - procese

    --mux to write address - ID
    process(regDst)
    begin
        if regDst = '0' then muxWa <= ra1OutIdEx;
        else muxWa <= ra2OutIdEx; end if;
    end process;
    
    --extUnit - ID
    process(extOp)
    begin
        if extOp = '0' then extToInIdEx <= "000000000" & instructionOutIfId(6 downto 0);
            else extToInIdEx <= "111111111" & instructionOutIfId(6 downto 0); end if;
    end process;
    
    --memToreg
    process(memToRegOutMemWb)
    begin
        if memToRegOutMemWb = '1' then wd <= memDataOutMemWb;
        else wd <= ALUResOutMemWb; end if;
    end process;    
    
--atribuiri de semnale
    instrToUC(5 downto 3) <= instructionOutIfId(15 downto 13);
    instrToUC(2 downto 0) <= instructionOutIfId(2 downto 0);
    --led <= instruction;
    extOp <= instructionOutIfId(6);
    resultedAddressInExMem <= nextAddressOutIdEx + extToOutIdEx;
    branchAddress <= resultedAddressOutExMem;
    jumpAddress <= nextAddressOutIfId(15 downto 13) & instructionOutIfId(12 downto 0);
    PCSrc <= branchOutExMem and (zeroOutExMem or lzeroOutExMem);
    
    nextAddressInIdEx <= nextAddressOutIfId;
    regAddressInExMem <= muxWa;
    resultedAddressInMemWb <= regAddressOutExMem;
    
end Behavioral;
