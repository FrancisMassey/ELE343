-- ================================ addtb.vhd =================================
-- ELE340 Conception des systèmes ordinés
-- HIVER 2014, École de technologie supérieure
-- ============================================================================
-- Description: testbench pour full_adder_generic
-- ============================================================================

--les données sont lues de data_in.txt
library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
    use IEEE.std_logic_textio.all;
library std;
    use std.textio.all;
use work.txt_util.all;


entity addtb is -- l'entité du testbench est vide
end addtb;

architecture addtb_arch of addtb is
    -- Constantes
    constant ADDER_SIZE : integer := 8;
    constant PERIODE    : time := 20 ns;

    -- Composants
    component full_adder_generic is 
        generic (
            ADDER_SIZE : integer := 8 -- la taille par défaut est 8 bits;
        ); 
        port (
            a_i, b_i : in std_logic_vector (ADDER_SIZE-1 downto 0); 

            s_o   : out std_logic_vector (ADDER_SIZE-1 downto 0);
            ret_o : out std_logic
        );
    end component;

    -- Déclaration des signaux du module à tester.
    signal data1, data2, sum_adder: std_logic_vector (ADDER_SIZE-1 downto 0);
    signal clk, retenue           : std_logic;
begin
    -- Instanciation de l'UUT (Unit Under Test)
    U0: full_adder_generic generic map (
                               adder_size => 8
                           ) 
                           port map (
                               a_i   => data1,
                               b_i   => data2,
                               s_o   => sum_adder,
                               ret_o => retenue
                           );

    -- Process de l'horloge
    process
    begin
        clk <= '1';
        wait for PERIODE/2;
        clk <= '0';
        wait for PERIODE/2;
    end process;

    -- Process principal de test
    process 
        -- Fichiers d'entrées/sortie.
        file data_txt: text open READ_MODE  is "data_in.txt";
        file data_out: text open WRITE_MODE is "data_out.txt";
   
        -- Variables pour stimuli.
        variable input1_stimuli, input2_stimuli, sum_theorique : std_logic_vector (ADDER_SIZE-1 downto 0);
        variable ret_theorique : std_logic;
        variable Une_Erreur : std_logic:='0';

        -- Variables pour lecture.
        variable ligne_texte, ligne_texte2 : line;
        variable operation_ok : boolean;
        variable char_pour_espace : character;
    begin
        -- Initialiser les entrées à zéro.
        data1 <= (others=>'0');
        data2 <= (others=>'0');
      
        wait for PERIODE;

        -- Boucle pour la lecture du fichier de stimuli en entier
        w1: while not endfile(data_txt) loop
            -- Lire une ligne d'entrée du fichier
            readline(data_txt, ligne_texte);

            -- Lire data1 de data_in.txt en ignorant les commentaires.
            hread(ligne_texte, input1_stimuli, operation_ok);         
            next when not operation_ok;
            -- Lire espace
            read(ligne_texte, char_pour_espace);

            -- Lire data2 de data_in.txt
            hread(ligne_texte, input2_stimuli);
            -- Lire espace
            read(ligne_texte, char_pour_espace);
 
            -- Lire résultat de data_in.txt
            hread(ligne_texte, sum_theorique);
            --lire espace
            read(ligne_texte, char_pour_espace);
            
            -- Lire retenue de data_in.txt
            read(ligne_texte, ret_theorique);

            -- Assigner les entrées.
            data1<=input1_stimuli;
            data2<=input2_stimuli;
            wait for PERIODE; -- Résultat prêt seulement après un certain délai
         
            write(ligne_texte2, "Résultat par full_adder_generic de " & hstr(input1_stimuli) & 
                                " + " & hstr(input2_stimuli) & 
                                " = " & hstr(sum_adder));
            write(ligne_texte2,". Retenu = " & str(retenue));
            write(ligne_texte2,". Résultat théorique = " & hstr(sum_theorique));
            write(ligne_texte2,". Retenu théorique = " & str(ret_theorique));

            assert (sum_adder/=sum_theorique AND retenue/=ret_theorique)
                report "Opération réussie. Résultat = " & hstr(sum_adder)
                severity note;
            assert (sum_adder=sum_theorique OR retenue=ret_theorique)
                report "Opération echouée Résultat = " & hstr(sum_adder)
                severity note;
               
            if (sum_adder=sum_theorique AND retenue=ret_theorique) THEN
                write(data_out, "SUCCÈS: ");          
            else
                write(data_out, "ÉCHEC : ");
                Une_Erreur := '1';           
            end if;               
            writeline(data_out, ligne_texte2);
        end loop w1;

        assert (Une_Erreur='1') 
            report "testbench pour full_adder_generic.vhd terminé avec succès" severity note;
        assert (Une_Erreur='0') 
            report "testbench pour full_adder_generic.vhd terminé avec échec" severity note;

        file_close(data_txt);
        file_close(data_out);
        wait; -- À l'infini.
    end process; -- Fin du process de test
end addtb_arch;
