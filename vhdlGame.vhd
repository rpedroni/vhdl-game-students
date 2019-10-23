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

  signal whack: std_logic;

  -- Game state
  type GameState is (Waiting, Playing, Defeat, Victory);
  signal gameState: GameState;

  -- Controla a pontuação
  signal score: natural range 0 to MAX_POINTS;
  -- Define a velcidade..
  signal speedClock: std_logic;

  signal position: natural range 0 to GAME_TABLE_SIZE - 1;

  signal hit: std_logic;
  signal miss: std_logic;

begin


  -- whackButton
  -- 1. Debounceado
  -- 2. Criado um pulso
  -- Vira o "whack"
  -- Processe o whack

  hitDetection: process(all)
    variable prevPosition: natural range 0 to GAME_TABLE_SIZE - 1;
  begin
    if rising_edge(clk) then

      hit <= '0';
      miss <= '0';
      
      -- Acertar/errar apertando o botão
      if whack = '1' then
        if target = position  then
          hit <= '1';
        else
          miss <= '1';
        end if;
      end if;

      -- Errar com o limite do tempo
      if prevPosition = target and position /= target then
        miss <= '1';
      end if;
      prevPosition := position;

    end if;

  end process;

  controlScore: process(all)
  begin
    if rising_edge(clk) then
      -- Esperando jogo começar
      if gameState = Waiting then
        score <= 0;
      -- Jogando
      elsif gameState = Playing and hit = '1' then
        score <= score + 1;
      end if;
    end if;
  end process;

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