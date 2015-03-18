-------------------------------------------------------------------------------
-- Title      : reset_sync
-- Project    : 
-------------------------------------------------------------------------------
-- File       : reset_sync.vhd
-- Author     : amr  <amr@amr-laptop>
-- Company    : 
-- Created    : 18-03-2015
-- Last update: 18-03-2015
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: synchronize reset
-------------------------------------------------------------------------------
-- Copyright (c) 2015 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 18-03-2015  1.0      amr     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset_sync is
  
  port (
    reset_in  : in  std_logic;
    clk       : in  std_logic;
    reset_out : out std_logic);

end entity reset_sync;

architecture behav of reset_sync is

  signal sync_ff0_s : std_logic;
  signal sync_ff1_s : std_logic;
  
  
begin  -- architecture behav


  -- purpose: implement sync flops
  -- type   : sequential
  -- inputs : clk, reset_in
  -- outputs: 
  clk_pr : process (clk, reset_in) is
  begin  -- process clk_pr
    if reset_in = '0' then              -- asynchronous reset (active low)
      sync_ff0_s <= '0';
      sync_ff1_s <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      sync_ff0_s <= reset_in;
      sync_ff1_s <= sync_ff0_s;
    end if;
  end process clk_pr;

  with reset_in select
    reset_out <=
    sync_ff1_s when '1',
    '0'        when others;
  
end architecture behav;
