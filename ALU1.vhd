LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY ALU1 IS
    PORT (
        clk    : IN  std_logic;
        A, B   : IN  unsigned(7 downto 0);      -- 8-bit inputs
        opcode : IN  unsigned(15 downto 0);     -- 16-bit opcode from decoder
        Neg    : OUT std_logic;                 -- negative flag
        R1, R2 : OUT unsigned(3 downto 0)       -- 4-bit outputs for 7-seg
    );
END ALU1;

ARCHITECTURE calculation OF ALU1 IS
    SIGNAL Reg1, Reg2, Result : unsigned(7 downto 0) := (others => '0');
BEGIN
    Reg1 <= A;
    Reg2 <= B;

    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            CASE opcode IS

                ----------------------------------------------------------------
                -- 1. ADDITION
                ----------------------------------------------------------------
                WHEN "0000000000000001" =>
                    Neg    <= '0';
                    Result <= Reg1 + Reg2;

                ----------------------------------------------------------------
                -- 2. SUBTRACTION  (Reg1 - Reg2, Neg=1 if result would be < 0)
                ----------------------------------------------------------------
                WHEN "0000000000000010" =>
                    Result <= Reg1 - Reg2;
                    IF Reg1 < Reg2 THEN
                        Neg <= '1';
                    ELSE
                        Neg <= '0';
                    END IF;

                ----------------------------------------------------------------
                -- 3. INVERSE (NOT Reg1)
                ----------------------------------------------------------------
                WHEN "0000000000000100" =>
                    Neg    <= '0';
                    Result <= NOT Reg1;

                ----------------------------------------------------------------
                -- 4. BOOLEAN NAND
                ----------------------------------------------------------------
                WHEN "0000000000001000" =>
                    Neg    <= '0';
                    Result <= NOT (Reg1 AND Reg2);

                ----------------------------------------------------------------
                -- 5. BOOLEAN NOR
                ----------------------------------------------------------------
                WHEN "0000000000010000" =>
                    Neg    <= '0';
                    Result <= NOT (Reg1 OR Reg2);

                ----------------------------------------------------------------
                -- 6. BOOLEAN AND
                ----------------------------------------------------------------
                WHEN "0000000000100000" =>
                    Neg    <= '0';
                    Result <= Reg1 AND Reg2;

                ----------------------------------------------------------------
                -- 7. BOOLEAN OR
                ----------------------------------------------------------------
                WHEN "0000000001000000" =>
                    Neg    <= '0';
                    Result <= Reg1 OR Reg2;

                ----------------------------------------------------------------
                -- 8. BOOLEAN XOR
                ----------------------------------------------------------------
                WHEN "0000000010000000" =>
                    Neg    <= '0';
                    Result <= Reg1 XOR Reg2;

                ----------------------------------------------------------------
                -- 9. BOOLEAN XNOR
                ----------------------------------------------------------------
                WHEN "0000000100000000" =>
                    Neg    <= '0';
                    Result <= Reg1 XNOR Reg2;

                ----------------------------------------------------------------
                -- DEFAULT: do nothing (hold previous result)
                ----------------------------------------------------------------
                WHEN OTHERS =>
                    Result <= Result;
                    -- Neg unchanged

            END CASE;
        END IF;
    END PROCESS;

    -- Split 8-bit result into two 4-bit nibbles for 7-segment display
    R1 <= Result(3 downto 0);  -- lower nibble
    R2 <= Result(7 downto 4);  -- upper nibble

END calculation;
