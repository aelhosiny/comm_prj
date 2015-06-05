-------------------------------------------------------------------------------
-- Title      : clk_gen
-- Project    : 
-------------------------------------------------------------------------------
-- File       : clk_gen.vhd
-- Author     : amr  <amr@amr-laptop>
-- Company    : 
-- Created    : 18-03-2015
-- Last update: 18-04-2015
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: generate any necessary clocks within the system
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

entity clk_rst_gen is
  
  port (
    -- power on reset for the chip. Hard reset pin
    por_rstn      : in  std_logic;
    -- soft reset to digcore from register file
    digrf_rstn    : in  std_logic;
    -- enable/gate clock to digital from register file
    enable_digclk : in  std_logic;
    -- input system clock, 625MHz clock input
    sys_clk       : in  std_logic;
    -- decimator output valid signal, used to implement
    -- programable divider clock
    dec_vldout    : in  std_logic;
    -- decimation ratio, control freq of divided clock
    dec_ratio     : in  std_logic_vector(1 downto 0);
    -- reset out to digital blocks, combines soft and hard resets
    dig_rstn      : out std_logic;
    -- gated 625MHz clock to digital
    clk_625mhz    : out std_logic;
    -- programable clock to LPF, freq is controlled by the
    -- decimation ratio of the downsampler
    clk_lf        : out std_logic
    );

end entity clk_rst_gen;

architecture behav of clk_rst_gen is

  signal reset_in_s         : std_logic;
  signal sys_clk_gated_s    : std_logic;
  signal rstn_s             : std_logic;
  signal enable_digclk_s    : std_logic;
  signal enable_digclk_ne_s : std_logic;
  signal clk_625mhz_s       : std_logic;
  signal clkdiv_cnt_s       : unsigned(3 downto 0);
  signal clkinv_index_s     : unsigned(3 downto 0);
  signal inc_cnt_s          : std_logic;
  signal count_max_s        : std_logic;
  signal clk_lf_s           : std_logic;
  
begin  -- architecture behav

  reset_in_s <= por_rstn and digrf_rstn;
  dig_rstn   <= rstn_s;
  clk_625mhz <= clk_625mhz_s;
  clk_lf     <= clk_lf_s;

  -- Synchronize the reset to sys_clk
  reset_sync_1 : entity work.reset_sync
    port map (
      reset_in  => reset_in_s,          -- [in  std_logic]
      clk       => sys_clk,             -- [in  std_logic]
      reset_out => rstn_s);             -- [out std_logic]

  -- synchronize the clock enable control to sys_clk
  signal_sync_1 : entity work.signal_sync
    generic map (
      polarity_g => '0')                -- [std_logic]
    port map (
      rstn     => rstn_s,               -- [in  std_logic]
      clk      => sys_clk,              -- [in  std_logic]
      async_in => enable_digclk,        -- [in  std_logic]
      sync_out => enable_digclk_s);     -- [out std_logic]

  -- retime the clock enable to negative edge
  clk_pr1 : process (sys_clk, rstn_s) is
  begin  -- process clk_pr1
    if rstn_s = '0' then                -- asynchronous reset (active low)
      enable_digclk_ne_s <= '0';
    elsif falling_edge(sys_clk) then    -- rising clock edge
      enable_digclk_ne_s <= enable_digclk_s;
    end if;
  end process clk_pr1;

  -- clock gating statement
  sys_clk_gated_s <= sys_clk and enable_digclk_ne_s;


  -- divide clock by 2 to get 625MHz clock
  reset_sync_2 : entity work.clk_divider
    port map (
      rstn    => rstn_s,
      clk_in  => sys_clk_gated_s,
      clk_out => clk_625mhz_s);



  with dec_ratio select
    clkinv_index_s <=
    to_unsigned(2, 4) when "00",
    to_unsigned(4, 4) when "01",
    to_unsigned(8, 4) when "10",
    (others => 'X')   when others;
  
  inc_cnt_s <= '1' when clkdiv_cnt_s /= 0 or dec_vldout = '1' else
               '0';
  count_max_s <= '1' when clkdiv_cnt_s = clkinv_index_s else
                 '0';

  -- purpose: generate divided programable clock
  -- type   : sequential
  -- inputs : clk_625mhz_s, rstn_s
  -- outputs: 
  clkdiv_gen : process (clk_625mhz_s, rstn_s) is
  begin  -- process clkdiv_gen
    if rstn_s = '0' then                  -- asynchronous reset (active low)
      clkdiv_cnt_s <= (others => '0');
      clk_lf_s     <= '0';
    elsif rising_edge(clk_625mhz_s) then  -- rising clock edge
      if (count_max_s = '1') then
        clkdiv_cnt_s <= (others => '0');
      elsif (inc_cnt_s = '1') then
        clkdiv_cnt_s <= clkdiv_cnt_s + to_unsigned(1, clkdiv_cnt_s'length);
      end if;

      if (dec_vldout = '1') then
        clk_lf_s <= '1';
      elsif (count_max_s = '1') then
        clk_lf_s <= '0';
      end if;
      
    end if;
  end process clkdiv_gen;
  
end architecture behav;
