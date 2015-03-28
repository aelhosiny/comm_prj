-------------------------------------------------------------------------------
-- Title      : digcore
-- Project    : 
-------------------------------------------------------------------------------
-- File       : digcore.vhd
-- Author     : amr  <amr@amr-laptop>
-- Company    : 
-- Created    : 18-03-2015
-- Last update: 28-03-2015
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: core digital operations such as DSP, clock generation
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

entity digcore is
  
  port (
    -- power on reset for the chip. Hard reset pin
    por_rstn      : in std_logic;
    -- soft reset to digcore from register file
    digrf_rstn    : in std_logic;
    -- enable/gate clock to digital from register file
    enable_digclk : in std_logic;
    -- input system clock, 625MHz clock input
    sys_clk       : in std_logic;
    -- decimation ratio, control freq of divided clock
    --dec_ratio     : in std_logic_vector(1 downto 0);
    -- tdc output, input to digtop
    tdc_out       : in std_logic_vector(4 downto 0);
    -- enable decimator
    enable_dec    : in std_logic
    );

end entity digcore;

architecture behav of digcore is

  signal dig_rstn_s   : std_logic;      -- [out]
  signal clk_625mhz_s : std_logic;      -- [out]
  signal clk_lf_s     : std_logic;      -- [out]
  signal cic_in_s     : std_logic_vector(5 downto 0);
  signal cic_out_s    : std_logic_vector(15 downto 0);
  signal dec_vldout_s : std_logic;
  
begin  -- architecture behav

  cic_in_s <= '0' & tdc_out;


  clk_rst_gen_1 : entity work.clk_rst_gen
    port map (
      por_rstn      => por_rstn,        -- [in  std_logic]
      digrf_rstn    => digrf_rstn,      -- [in  std_logic]
      enable_digclk => enable_digclk,   -- [in  std_logic]
      sys_clk       => sys_clk,         -- [in  std_logic]
      dec_vldout    => dec_vldout_s,    -- [in  std_logic]
      dec_ratio     => "10",            -- [in  std_logic_vector(1 downto 0)]
      dig_rstn      => dig_rstn_s,      -- [out std_logic]
      clk_625mhz    => clk_625mhz_s,    -- [out std_logic]
      clk_lf        => clk_lf_s);       -- [out std_logic]

  decimator_1 : entity work.decimator
    port map (
      clk        => clk_625mhz_s,       -- [in  std_logic]
      clk_enable => enable_dec,         -- [in  std_logic]
      rstn       => dig_rstn_s,         -- [in  std_logic]
      filter_in  => cic_in_s,           -- [in  std_logic_vector(5 downto 0)]
      filter_out => cic_out_s,          -- [out std_logic_vector(15 downto 0)]
      ce_out     => dec_vldout_s);      -- [out std_logic]


end architecture behav;
