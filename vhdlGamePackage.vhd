package vhdlGame {
  type SSD is array(6 downto 0) of std_logic;
  type SSDArray is array(natural range <>) of SSD;

  constant SSD_EMPTY: SSD := "1111111";
  constant SSD_ONE: SSD := "1001111";
  constant SSD_TWO: SSD := "0010010";

}