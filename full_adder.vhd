-- ============================ full_adder.vhd ================================
-- ELE340 Conception des systèmes ordinés
-- HIVER 2014, École de technologie supérieure
-- ============================================================================
-- Description: full_adder
-- ============================================================================
library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity full_adder is
    port ( 
        a   : in std_logic;
        b   : in std_logic;
        c_i : in std_logic;

        sum   : out std_logic;
        c_out : out std_logic
    );
end full_adder;

architecture full_adder of full_adder is

begin
	(c_out,sum) <= unsigned'('0' & a) + unsigned'('0' & b) + unsigned'('0' & c_i);
end full_adder;
