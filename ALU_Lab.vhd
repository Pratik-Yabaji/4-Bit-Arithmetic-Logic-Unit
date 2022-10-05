library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_Lab is
generic(
operand_width : integer:=4);
port (
A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0);
op: out std_logic_vector((operand_width*2)-1 downto 0)) ;
end ALU_Lab;

architecture a1 of ALU_Lab is

function sub(A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0))
return std_logic_vector is
-- declaring and initializing variables using aggregates
variable diff : std_logic_vector(operand_width*2-1 downto 0):= (others=>'0');
variable carry : std_logic_vector(operand_width*2-1 downto 0):= (others=>'0');
begin

-- Hint: Use for loop to calculate value of "diff" and "carry" variable
-- Use aggregates to assign values to multiple bits
	 L1: for i in 0 to 3 loop
			if i = 0 then
				diff(i) := A(i) xor B(i) xor '0';
				carry(i) := (not B(i)) and A(i);
			else
				diff(i) := ((not B(i) and (A(i) xor carry(i-1)))) or (B(i) and ( A(i) xnor carry(i-1)));
				carry(i) := ((not B(i)) and carry(i-1)) or (A(i) and carry(i-1)) or ((not B(i)) and A(i));
			end if;
		 end loop L1;
return diff;
end sub;

function rolf(A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0))
return std_logic_vector is
variable shift : std_logic_vector((operand_width*2)-1 downto 0):= (others=>'0');
variable shift_msb : std_logic;
begin
shift(operand_width-1 downto 0):= A;

-- Hint: use for loop to calculate value of shift variable
-- shift(____ downto _____) & shift(____ downto ______)
-- to calculate exponent, you can use double asterisk. ex: 2**i



if B(2) = '1' then
	L3:for i in 0 to 3 loop
			shift_msb := shift(7);
			shift(7) := shift(6);
			shift(6) := shift(5);
			shift(5) := shift(4);
			shift(4) := shift(3);
			shift(3) := shift(2);
			shift(2) := shift(1);
			shift(1) := shift(0);
			shift(0) := shift_msb;
		end loop L3;
end if;
if B(1) = '1' then

	L4:for i in 0 to 1 loop
			shift_msb := shift(7);
			shift(7) := shift(6);
			shift(6) := shift(5);
			shift(5) := shift(4);
			shift(4) := shift(3);
			shift(3) := shift(2);
			shift(2) := shift(1);
			shift(1) := shift(0);
			shift(0) := shift_msb;
		end loop L4;
end if;
if B(0) = '1' then
	L5:for i in 0 to 0 loop
			shift_msb := shift(7);
			shift(7) := shift(6);
			shift(6) := shift(5);
			shift(5) := shift(4);
			shift(4) := shift(3);
			shift(3) := shift(2);
			shift(2) := shift(1);
			shift(1) := shift(0);
			shift(0) := shift_msb;
		end loop L5;
end if;

return shift;
end rolf;

function multi_5(A: in std_logic_vector(operand_width-1 downto 0))
return std_logic_vector is
variable mult_result : std_logic_vector((operand_width*2)-1 downto 0):= (others=>'0');
variable carry : std_logic_vector((operand_width*2)-5 downto 0):= (others=>'0');
begin

mult_result(0)  := A(0);
mult_result(1)  := A(1);
mult_result(2)  := A(2) xor A(0);
carry(0) := A(2) and A(0);
mult_result(3)  := A(3) xor A(1) xor carry(0);
carry(1) := (A(3) and A(1)) or (carry(0) and (A(3) xor A(1))) ;
mult_result(4)  := A(2) xor carry(1);
carry(2) := A(2) and carry(1);
mult_result(5)  := A(3) xor carry(2);
carry(3) := A(3) and carry(2);
mult_result(6)  := carry(3);
		
return mult_result;
end multi_5;

function xor_fun(A: in std_logic_vector(operand_width-1 downto 0);
B: in std_logic_vector(operand_width-1 downto 0))
return std_logic_vector is
variable xor_result : std_logic_vector((operand_width*2)-1 downto 0):= (others=>'0');

begin
L5: for i in 0 to 3 loop
		xor_result(i) := A(i) xor B(i);
	end loop L5;
return xor_result;
end xor_fun;
begin

alu : process( A, B)
variable out_put : std_logic_vector((operand_width*2)-1 downto 0);

begin
if(A(3) = '0' and B(3) = '0') then 
	out_put := rolf(A,B);
	op <= out_put;
elsif (A(3) = '0' and B(3) = '1') then 
	out_put := sub(A,B);
	op <= out_put;
elsif (A(3) = '1' and B(3) = '0') then 
	out_put := multi_5(A);
	op <= out_put;
elsif (A(3) = '1' and B(3) = '1') then 
	out_put := xor_fun(A,B);
	op <= out_put;
end if ;
end process ; --alu
end a1 ; -- a1










