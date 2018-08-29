library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_signed.all;
use ieee.numeric_std.all;
-- Alex Grinshpun July 24 2017 
-- Dudy Nov 13 2017


entity back_gr_black is
GENERIC ( ObjectStartX		: INTEGER := 200);
port 	(
	   CLK      : in std_logic;
		RESETn	: in std_logic;
		oCoord_X : in integer;
		oCoord_Y : in integer;
		drawing_request	: out std_logic ;
		mVGA_RGB	: out std_logic_vector(7 downto 0)
	);
end back_gr_black;

architecture arc_back_gr_black of back_gr_black is 

-- Constants for frame drawing
constant	x_frame	: integer :=	639;
constant	y_frame	: integer :=	479;
constant	pianoHight : integer := 100;

signal mVGA_R	: std_logic_vector(2 downto 0); --	,	 			//	VGA Red[2:0]
signal mVGA_G	: std_logic_vector(2 downto 0); --	,	 			//	VGA Green[2:0]
signal mVGA_B	: std_logic_vector(1 downto 0); --	,  			//	VGA Blue[1:0]

	
begin

mVGA_RGB <=  mVGA_R & mVGA_G &  mVGA_B ;
-- defining three rectangles 

process ( oCoord_X,oCoord_y )
begin 
	
	if (oCoord_Y > y_frame - pianoHight) then
			mVGA_R <= "111";
			mVGA_G <= "111";
			mVGA_B <= "11";
		drawing_request <= '1';
	else
		drawing_request <= '0';
	end if;
end process ; 
		
end architecture;		