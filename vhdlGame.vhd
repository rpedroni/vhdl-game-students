--
library ieee;
use ieee.std_logic_164.all;
use work.vhdlGamePackage.all;
--
entity whackAMole is
  generic (
    MAX_POINTS: positive := 15
  );
  port (
    -- Inputs
    clk, rst: in std_logic;
    -- startGameButton, whackButton: in std_logic;
    -- Outputs
    -- positionView: std_logic_vector(7 downto 0);
    -- targetView: SSD;
    -- scoreView: SSDArray(1 downto 0)
    score: in natural range 0 to MAX_POINTS;
    speedClock: out std_logic;
  );
end;
--
architecture arch of whackAMole is
begin

  speedControl: process(all)
  begin
    if rising_edge(clk) then

    end if;

  end process;
  
end architecture;