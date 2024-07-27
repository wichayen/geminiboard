	library		ieee;
	use			ieee.std_logic_1164.all	;
	use			ieee.std_logic_unsigned.all;
	use			ieee.std_logic_arith.all;
	use			ieee.std_logic_misc.all;
	package	General_PKG	is

-- =======================================================================--
--	constant
-- =======================================================================--

-- =======================================================================--


-- =======================================================================--
--	Fcuntion
-- =======================================================================--
	function	fRisEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return boolean;
	function	fRisEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return std_logic;
	function	fFallEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return boolean;
	function	fFallEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return std_logic;

	end	General_PKG;



--------------------------------------------------------
	package	body General_PKG	is
--------------------------------------------------------

	function	fRisEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return boolean is
	begin
		if(INSIG = '1' and INSIG_DLY1 = '0')then
			return( true );
		else
			return( false );
		end if;
	end fRisEdge;
	
	function	fRisEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return std_logic is
	begin
		if(INSIG = '1' and INSIG_DLY1 = '0')then
			return( '1' );
		else
			return( '0' );
		end if;
	end fRisEdge;
	
	function	fFallEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return boolean is
	begin
		if(INSIG = '0' and INSIG_DLY1 = '1')then
			return( true );
		else
			return( false );
		end if;
	end fFallEdge;
	
	function	fFallEdge ( INSIG : std_logic; INSIG_DLY1 : std_logic ) return std_logic is
	begin
		if(INSIG = '0' and INSIG_DLY1 = '1')then
			return( '1' );
		else
			return( '0' );
		end if;
	end fFallEdge;
	


	end	General_PKG;
