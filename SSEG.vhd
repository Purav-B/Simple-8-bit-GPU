library ieee;
use ieee.std_logic_1164.all;

entity sseg is
  port(
    nibble : in  std_logic_vector(3 downto 0);
    neg    : in  std_logic;  -- show minus
    seg    : out std_logic_vector(0 to 6); -- {a,b,c,d,e,f,g}, active low
	 g 	  : out std_logic_vector(0 to 6)
  );
end entity;

architecture rtl of sseg is
  signal code : std_logic_vector(0 to 6);
begin
  process(nibble, neg)
  begin
	 
    if neg = '0' then
      -- Minus: only segment g ON (active low -> '0')
      g <= not "0000000";
    else g <= not "0000001";
      
      
    end if;
	 case nibble is                          -- 0..F hex
        when "0000" => code <= "1111110";     -- 0
        when "0001" => code <= "0110000";     -- 1
        when "0010" => code <= "1101101";     -- 2
        when "0011" => code <= "1111001";     -- 3
        when "0100" => code <= "0110011";     -- 4
        when "0101" => code <= "1011011";     -- 5
        when "0110" => code <= "1011111";     -- 6		
        when "0111" => code <= "1110000";     -- 7
        when "1000" => code <= "1111111";     -- 8
        when "1001" => code <= "1111011";     -- 9
        when "1010" => code <= "1110111";     -- A
        when "1011" => code <= "0011111";     -- b
        when "1100" => code <= "1001110";     -- C
        when "1101" => code <= "0111101";     -- d
        when "1110" => code <= "1001111";     -- E
		  when "1111" => code <= "1000111";		 -- F
        when others => code <= "0000000";     -- blank
		  end case;
  end process;

  seg <= not code; -- invert here if your hardware is active high
end architecture;


