library ieee;
use ieee.std_logic_1164.all;

entity machine7 is
  port (
    clk          : in  std_logic;
    data_in      : in  std_logic;
    reset        : in  std_logic;
    student_id   : out std_logic_vector(3 downto 0);
    current_state: out std_logic_vector(3 downto 0)
  );
end entity;

architecture fsm of machine7 is
  type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
  signal yfsm : state_type;
  signal current_state_reg : std_logic_vector(3 downto 0) := "0000";
begin
  process (clk, reset)
  begin
    if reset = '1' then
      current_state_reg <= "0000";
    elsif (clk'EVENT AND clk = '1') then
      case current_state_reg is
        when "0000" => current_state_reg <= "0001";
        when "0001" => current_state_reg <= "0010";
        when "0010" => current_state_reg <= "0011";
        when "0011" => current_state_reg <= "0100";
        when "0100" => current_state_reg <= "0101";
        when "0101" => current_state_reg <= "0110";
        when "0110" => current_state_reg <= "0111";
        when "0111" => current_state_reg <= "1000";
        when others => current_state_reg <= "0000";
      end case;
    end if;
  end process;

  current_state <= current_state_reg;

  process (yfsm, data_in, reset, clk)
  begin
  if (clk'EVENT and clk='1') then
    if reset = '1' then
      yfsm <= s0;
		student_id <= "0101";
    else
      case yfsm is
		
        when s0 => 
          yfsm       <= s1;
          student_id <= "0101";

        when s1 =>
          yfsm       <= s2;
          student_id <= "0000";

        when s2 =>
          yfsm       <= s3;
          student_id <= "0001";

        when s3 =>
          yfsm       <= s4;
          student_id <= "0011";

        when s4 =>
          yfsm       <= s5;
          student_id <= "0000";

        when s5 =>
          yfsm       <= s6;
          student_id <= "0101";

        when s6 =>
          yfsm       <= s7;
          student_id <= "1001";

        when s7 =>
          yfsm       <= s8;
          student_id <= "0111";

        when s8 =>
          yfsm       <= s0;
          student_id <= "1001";

        when others =>
          yfsm       <= s0;
          student_id <= "1110";
			 
      end case;
    end if; end if;
  end process;
end architecture;
