-------------------------------------------------------------------------------
-- Title      : decimator test bench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : decimator_tb.vhd
-- Author     : amr  <amr@amr-laptop>
-- Created    : 17-03-2015
-- Last update: 17-03-2015
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: decimator test bench
-------------------------------------------------------------------------------
-- Copyright (c) 2015 Ensphere Solutions & Silicon Vision
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 17-03-2015  1.0      amr     Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity decimator_tb is

end entity decimator_tb;

architecture behav of decimator_tb is

  constant tclk_c : time := 1600 ps;


  -- inputs
  signal clk        : std_logic                    := '0';              -- [in]
  signal enable     : std_logic                    := '0';              -- [in]
  signal rstn       : std_logic                    := '0';              -- [in]
  signal dec_ratio  : std_logic_vector(1 downto 0) := "00";             -- [in]
  signal filter_in  : std_logic_vector(5 downto 0) := (others => '0');  -- [in]
  -- outputs
  signal filter_out : std_logic_vector(9 downto 0);  -- [out]
  signal ce_out     : std_logic;        -- [out]

  signal sys_clk    : std_logic := '0';
  signal gate_clk_s : std_logic := '1';
  signal sim_end_s  : std_logic := '0';
  
begin  -- architecture behav

  
  sys_clk_gen : process
  begin
    while (sim_end_s = '0') loop
      sys_clk <= not(sys_clk);
      wait for tclk_c/2;
    end loop;
    wait;
  end process sys_clk_gen;

  clk <= not(gate_clk_s) and sys_clk;

  cntrl_pr : process
    file stimin          : text is "$INPATH/tdc_out.txt";
    variable line_v      : line;
    variable sample_in_v : integer;
    variable smpl_no     : integer := 0;
  begin
    wait for 5*tclk_c;
    wait until(rising_edge(sys_clk));
    rstn       <= '1';
    wait for 5*tclk_c;
    wait until(falling_edge(sys_clk));
    gate_clk_s <= '0';
    wait for 5*tclk_c;
    wait until(falling_edge(sys_clk));
    enable     <= '1';
    readline(stimin, line_v);
    read(line_v, sample_in_v);
    filter_in  <= std_logic_vector(to_signed(sample_in_v, 6));
    while(not endfile(stimin)) loop
      wait until(falling_edge(sys_clk));
      smpl_no   := smpl_no + 1;
      report "reading sample no " & integer'image(smpl_no);
      readline(stimin, line_v);
      read(line_v, sample_in_v);
      filter_in <= std_logic_vector(to_signed(sample_in_v, 6));
    end loop;
    wait until(falling_edge(clk));
    wait for 5*tclk_c;
    sim_end_s <= '1';
    wait;
  end process cntrl_pr;

  wr_pr : process(ce_out)
    variable line_o_v    : line;
    variable data_out_v  : integer;
    file stimout         : text open write_mode is "$OUTPATH/cic_out.txt";
    variable outsmp_no_v : integer := 0;
  begin
    if (falling_edge(ce_out)) then
      outsmp_no_v := outsmp_no_v + 1;
      data_out_v  := to_integer(signed(filter_out));
      write(line_o_v, data_out_v);
      writeline(stimout, line_o_v);
    end if;
  end process wr_pr;

  decimation_1 : entity work.decimation
    port map (
      clk        => clk,                -- [in  std_logic]
      enable     => enable,             -- [in  std_logic]
      rstn       => rstn,               -- [in  std_logic]
      dec_ratio  => dec_ratio,          -- [in  std_logic_vector(1 downto 0)]
      filter_in  => filter_in,          -- [in  std_logic_vector(5 downto 0)]
      filter_out => filter_out,         -- [out std_logic_vector(9 downto 0)]
      ce_out     => ce_out);            -- [out std_logic]

end architecture behav;
