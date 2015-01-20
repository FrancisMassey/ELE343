-- ======================== full_adder_generic.vhd ============================
-- ELE340 Conception des systèmes ordinés
-- HIVER 2014, École de technologie supérieure
-- ============================================================================
-- Description: additionneur ADDER_SIZE bits (par example ADDER_SIZE := 8)
-- ============================================================================
library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity full_adder_generic is 
    generic (
        ADDER_SIZE : integer := 8 -- la taille par défaut est 8 bits;
    ); 
    port (
        a_i, b_i : in std_logic_vector (ADDER_SIZE-1 downto 0); 

        s_o   : out std_logic_vector (ADDER_SIZE-1 downto 0);
        ret_o : out std_logic
    );
end full_adder_generic;

architecture RTL of full_adder_generic is
    -- Composants
    component full_adder is
        port ( 
            a   : in std_logic;
            b   : in std_logic;
            c_i : in std_logic;

            sum   : out std_logic;
            c_out : out std_logic
        );
    end component;   
    -- Signaux
    signal Ci: std_logic_vector (ADDER_SIZE-1 downto 0);
    
begin
    --Connexion des composants
    Counter0 : full_adder port map (  a => a_i(0),
                                      b => b_i(0),
                                      c_i => '0',
                                      sum => s_o(0),
                                      c_out => Ci(0)
                                    );
                                      
    Counter1 : full_adder port map (  a => a_i(1),
                                      b => b_i(1),
                                      c_i => Ci(0),
                                      sum => s_o(1),
                                      c_out => Ci(1)
                                    );
                                      
    Counter2 : full_adder port map (  a => a_i(2),
                                      b => b_i(2),
                                      c_i => Ci(1),
                                      sum => s_o(2),
                                      c_out => Ci(2)
                                    );
                                      
    Counter3 : full_adder port map (  a => a_i(3),
                                      b => b_i(3),
                                      c_i => Ci(2),
                                      sum => s_o(3),
                                      c_out => Ci(3)
                                    );
                                      
    Counter4 : full_adder port map (  a => a_i(4),
                                      b => b_i(4),
                                      c_i => Ci(3),
                                      sum => s_o(4),
                                      c_out => Ci(4)
                                    );
                                      
    Counter5 : full_adder port map (  a => a_i(5),
                                      b => b_i(5),
                                      c_i => Ci(4),
                                      sum => s_o(5),
                                      c_out => Ci(5)
                                    );
                                      
    Counter6 : full_adder port map (  a => a_i(6),
                                      b => b_i(6),
                                      c_i => Ci(5),
                                      sum => s_o(6),
                                      c_out => Ci(6)
                                    );
                                      
    Counter7 : full_adder port map (  a => a_i(7),
                                      b => b_i(7),
                                      c_i => Ci(6),
                                      sum => s_o(7),
                                      c_out => ret_o
                                    );


end RTL;
