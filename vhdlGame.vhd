--
library ieee;
use ieee.std_logic_164.all;
use work.vhdlGamePackage.all;
--
entity whackAMole is
  generic (
    MAX_POINTS: positive := 15;
    FCLK: natural := 50_000_000
  );
  port (
    -- Inputs
    clk, rst: in std_logic;
    startGameButton, whackButton: in std_logic;
    -- Outputs
    positionView: std_logic_vector(7 downto 0);
    targetView: SSD;
    scoreView: SSDArray(1 downto 0)
  );
end;
--
architecture arch of whackAMole is
  
  -- TODO: Atualmente estamos considerando 1 segundo
  constant COUNT_LIMIT: integer := FCLK;
  constant GAME_TABLE_SIZE: natural := 8;

  -- Game state
  type GameState is (Waiting, Playing, Defeat, Victory);
  signal gameState: GameState;

  -- Controla a pontuação
  signal score: natural range 0 to MAX_POINTS;
  -- Define a velcidade..
  signal speedClock: std_logic;

  signal position: natural range 0 to GAME_TABLE_SIZE - 1;

begin

  -- TODO: Do something for real 👍🏼
  generatePosition: process(all)
  begin
    if rising_edge(speedClock) then
      -- TODO: user gameState
      position <= 3;
    end if;
  end process;

  -- Block SPEED CONTROL
  -- Controla a velocidade de geração das posições aleatórias
  -- API
  --  in: clk, score
  --  out: speedClock
  speedControl: process(all)
    variable counter: integer range 0 to COUNT_LIMIT;
  begin
    if rising_edge(clk) then
      counter := counter + 1;
      if (counter = COUNT_LIMIT / (score + 1)) then
        speedClock <= '1';
        counter := 0;
      else
        speedClock <= '0';
      end if;
    end if;
  end process;
  
end architecture;