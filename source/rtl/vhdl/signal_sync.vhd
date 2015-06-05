-------------------------------------------------------------------------------
-- Title      : signal_sync
-- Project    : 
-------------------------------------------------------------------------------
-- File       : signal_sync.vhd
-- Author     : amr  <amr@amr-laptop>
-- Company    : 
-- Created    : 18-03-2015
-- Last update: 18-03-2015
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: synchronize signals
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

entity signal_sync is
  
  generic (
    -- polarity of reset state of the synchronized signal
    polarity_g : std_logic := '1'
    );

  port (
    rstn     : in  std_logic;
    clk      : in  std_logic;
    async_in : in  std_logic;
    sync_out : out std_logic);

end entity signal_sync;

architecture behav of signal_sync is

  signal sync_ff0_s : std_logic;
  signal sync_ff1_s : std_logic;
  
begin  -- architecture behav

  -- purpose: implement sync flops
  -- type   : sequential
  -- inputs : clk, rstn
  -- outputs: 
  clk_pr : process (clk, rstn) is
  begin  -- process clk_pr
    if rstn = '0' then                  -- asynchronous reset (active low)
      sync_ff0_s <= polarity_g;
      sync_ff1_s <= polarity_g;
    elsif rising_edge(clk) then         -- rising clock edge
      sync_ff0_s <= async_in;
      sync_ff1_s <= sync_ff0_s;
    end if;
  end process clk_pr;

  sync_out <= sync_ff1_s;
  
end architecture behav;
