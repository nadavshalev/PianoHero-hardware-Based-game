--------------------------------------
-- SinTable.vhd
-- Written by Gadi and Eran Tuchman.
-- All rights reserved, Copyright 2009
--------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all ;

entity errtable is
port(
  CLK     					: in std_logic;
  resetN 					: in std_logic;
  ADDR    					: in std_logic_vector(14 downto 0);
  Q       					: out std_logic_vector(15 downto 0)
);
end errtable;

architecture arch of errtable is
constant array_size 			: integer := 3 ;

type table_type is array(0 to array_size - 1) of std_logic_vector(15 downto 0);
signal err_table				: table_type;
signal Q_tmp       			:  std_logic_vector(15 downto 0) ;



begin
 
   
process(resetN, CLK)
	constant err_table : table_type := (X"1117",X"0C35",X"08CA");
	--X"2BF2",X"23A5",X"1D4C",X"15F9",X"1117",X"0C35",X"08CA",X"055F",X"01F4",X"FFFF",X"FD8F",X"FB9B",X"FA25",X"F7B3",X"F6B9",X"F4C5",X"F3CB",X"F254",X"F15A",X"F05F",X"EEEA",X"EE6C",X"ED71",X"EC76",X"EBFB",X"EB00",X"EA83",X"EA07",X"E90E",X"E890",X"E812",X"E796",X"E718",X"E69D",X"E69C",X"E61F",X"E5A2",X"E525",X"E4A8",X"E4A8",X"E42D",X"E3AE",X"E330",X"E331",X"E2B4",X"E2B4",X"E237",X"E236",X"E1B9",X"E1B9",X"E13C",X"E13B",X"E0BF",X"E0C0",X"E043",X"E042",X"E042",X"DFC5",X"DFC5",X"DFC5",X"DF48",X"DF49",X"DF49",X"DECB",X"DECB",X"DECA",X"DE4F",X"DE4F",X"DE4F",X"DE4D",X"DDD1",X"DDD2",X"DDD2",X"DDD0",X"DD54",X"DD55",X"DD54",X"DD54",X"DCD6",X"DCD9",X"DCD7",X"DCD9",X"DCD6",X"DC5B",X"DC5B",X"DC5B",X"DC5A",X"DC5B",X"DC5B",X"DBDC",X"DBDE",X"DBDF",X"DBDE",X"DBDE",X"DBDE",X"DB61",X"DB61",X"DB62",X"DB61",X"DB60",X"DB60",X"DB61",X"DAE4",X"DAE5",X"DAE5",X"DAE3",X"2903",X"21B2",X"1964",X"1402",X"0EA6",X"0ABD",X"0754",X"03E9",X"0177",X"FF05",X"FD11",X"FB1E",X"F8AD",X"F736",X"F5BE",X"F448",X"F34E",X"F1D6",X"F0DD",X"EFE3",X"EEE9",X"EDEE",X"ECF5",X"EC79",X"EB7E",X"EB00",X"EA07",X"E98A",X"E90D",X"E88F",X"E812",X"E796",X"E719",X"E69C",X"E61E",X"E5A3",X"E524",X"E525",X"E4A8",X"E42B",X"E42B",X"E3AE",X"E32F",X"E331",X"E2B3",X"E2B5",X"E237",X"E237",X"E1BA",X"E13B",X"E13D",X"E13D",X"E0BF",X"E0BE",X"E042",X"E041",X"E042",X"DFC6",X"DFC4",X"DF47",X"DF49",X"DF49",X"DF48",X"DECA",X"DECC",X"DECB",X"DE4F",X"DE4F",X"DE4F",X"DDD1",X"DDD2",X"DDD2",X"DDD3",X"DD56",X"DD54",X"DD55",X"DD55",X"DD56",X"DCD6",X"DCD8",X"DCD7",X"DCD8",X"DCD8",X"DC5B",X"DC5B",X"DC5D",X"DC58",X"DC5A",X"DBDE",X"DBDD",X"DBDD",X"DBDE",X"DBDF",X"DBDC",X"DBDD",X"DB61",X"DB61",X"DB62",X"DB60",X"DB60",X"DB61",X"DB61",X"DAE2",X"DAE3",X"DAE4",X"DAE4",X"2693",X"1D4D",X"1770",X"1116",X"0D2E",X"09C5",X"055F",X"02EE",X"0000",X"FE0A",X"FC18",X"FA24",X"F82F",X"F6B7",X"F542",X"F3CC",X"F255",X"F15B",X"F060",X"EF66",X"EE6C",X"ED72",X"ECF5",X"EBF9",X"EB7D",X"EA82",X"EA07",X"E98A",X"E890",X"E890",X"E796",X"E718",X"E719",X"E69B",X"E61F",X"E5A2",X"E524",X"E4A7",X"E4A7",X"E42A",X"E3AF",X"E3AD",X"E330",X"E2B4",X"E2B4",X"E234",X"E237",X"E1BA",X"E1BA",X"E13C",X"E13D",X"E0C0",X"E0C0",X"E0C0",X"E043",X"E043",X"DFC6",X"DFC5",X"DFC7",X"DF4A",X"DF49",X"DF4B",X"DECC",X"DECC",X"DECB",X"DE4F",X"DE4F",X"DE4E",X"DE4E",X"DDD2",X"DDD2",X"DDD3",X"DDD0",X"DD55",X"DD55",X"DD55",X"DD53",X"DCD9",X"DCD7",X"DCD8",X"DCD8",X"DCD8",X"DC5B",X"DC5A",X"DC5B",X"DC5C",X"DC5A",X"DC5B",X"DBDE",X"DBDF",X"DBDD",X"DBDE",X"DBDE",X"DBDF",X"DB61",X"DB61",X"DB60",X"DB61",X"DB61",X"DB60",X"DB60",X"DAE4",X"DAE3",X"DAE3",X"DAE3",X"2BF2",X"21B1",X"1B57",X"1405",X"0F9F",X"0C35",X"0752",X"04E1",X"0176",X"FF84",X"FD8F",X"FB1E",X"F92A",X"F736",X"F63B",X"F4C4",X"F34F",X"F253",X"F0DD",X"EFE2",X"EEEA",X"EDF1",X"ED72",X"EC78",X"EBFB",X"EB01",X"EA83",X"EA07",X"E90B",X"E890",X"E813",X"E793",X"E719",X"E69B",X"E61F",X"E5A2",X"E5A1",X"E524",X"E4A8",X"E42A",X"E42B",X"E3AD",X"E331",X"E330",X"E2B5",X"E2B4",X"E236",X"E237",X"E1B9",X"E1BB",X"E13C",X"E13D",X"E0C0",X"E0C1",X"E042",X"E044",X"E041",X"DFC5",X"DFC7",X"DF49",X"DF49",X"DF49",X"DF49",X"DECC",X"DECC",X"DECC",X"DE4F",X"DE4F",X"DE4E",X"DDD2",X"DDD2",X"DDCF",X"DDD2",X"DDD1",X"DD54",X"DD54",X"DD55",X"DD54",X"DCD8",X"DCD8",X"DCD9",X"DCD5",X"DCD7",X"DC5C",X"DC5C",X"DC5A",X"DC58",X"DC5A",X"DC59",X"DBDC",X"DBDD",X"DBDE",X"DBDC",X"DBDD",X"DBDD",X"DB60",X"DB61",X"DB60",X"DB60",X"DB61",X"DB60",X"DB61",X"DAE4",X"DAE3",X"DAE3",X"DAE4",X"2693",X"1F40",X"176F",X"128E",X"0EA5",X"09C4",X"0659",X"02EC",X"007D",X"FF05",X"FC16",X"FAA1",X"F830",X"F6BA",X"F5BF",X"F3C9",X"F2CF",X"F15A",X"F060",X"EF66",X"EE6D",X"EDEF",X"ECF4",X"EBFA",X"EB7D",X"EA84",X"EA08",X"E98B",X"E90C",X"E890",X"E813",X"E797",X"E719",X"E69B",X"E61E",X"E5A0",X"E526",X"E4A7",X"E4A8",X"E42C",X"E3AE",X"E3AD",X"E331",X"E332",X"E2B5",X"E236",X"E236",X"E1B8",X"E1BA",X"E13D",X"E13A",X"E0BF",X"E0BF",X"E0C0",X"E042",X"E042",X"DFC4",X"DFC6",X"DFC5",X"DF48",X"DF48",X"DF49",X"DECB",X"DECC",X"DECC",X"DECC",X"DE50",X"DE4E",X"DE4E",X"DDD1",X"DDD0",X"DDD2",X"DDD1",X"DD54",X"DD54",X"DD54",X"DD56",X"DD54",X"DCD7",X"DCD7",X"DCD7",X"DCD8",X"DCD8",X"DC5B",X"DC5A",X"DC5B",X"DC5A",X"DC5C",X"DBDF",X"DBDD",X"DBDE",X"DBDC",X"DBDE",X"DBDE",X"DBDE",X"DB60",X"DB60",X"DB5F",X"DB5F",X"DB61",X"DB60",X"DB61",X"DAE4",X"DAE4",X"DAE3",X"2BF2",X"23A6",X"1B57",X"15FA",X"1117",X"0C35",X"08CA",X"04E1",X"01F3",X"FFFE",X"FD90",X"FB9B",X"F92A",X"F7B3",X"F63B",X"F4C5",X"F3CB",X"F253",X"F15A",X"EFE2",X"EEE6",X"EE6C",X"ED71",X"EC77",X"EBFA",X"EB01",X"EA84",X"EA06",X"E90D",X"E890",X"E812",X"E796",X"E719",X"E69C",X"E61D",X"E61D",X"E5A2",X"E525",X"E4A8",X"E42B",X"E429",X"E3AF",X"E331",X"E32E",X"E2B4",X"E2B3",X"E238",X"E236",X"E1BB",X"E1B9",X"E13E",X"E13D",X"E0BE",X"E0C0",X"E042",X"E042",X"E043",X"DFC5",X"DFC5",X"DFC6",X"DF49",X"DF4B",X"DF49",X"DECC",X"DECD",X"DECC",X"DE50",X"DE4D",X"DE4F",X"DE4E",X"DDCF",X"DDD1",X"DDD0",X"DDD2",X"DD54",X"DD53",X"DD55",X"DD54",X"DCD6",X"DCD8",X"DCD8",X"DCD7",X"DCD7",X"DC5B",X"DC5A",X"DC5B",X"DC5B",X"DC5A",X"DC5B",X"DBDE",X"DBDD",X"DBDE",X"DBDD",X"DBDE",X"DBDF",X"DB61",X"DB61",X"DB60",X"DB61",X"DB60",X"DB61",X"DB61",X"DAE3",X"DAE3",X"DAE4",X"DAE4",X"2903",X"1F3D",X"1964",X"1403",X"0EA6",X"0ABD",X"0659",X"03E6",X"0177",X"FF06",X"FD12",X"FAA2",X"F8AB",X"F6BB",X"F5BF",X"F448",X"F2D1",X"F1D4",X"F061",X"EFE4",X"EEE6",X"EDEF",X"ECF4",X"EBFB",X"EB7E",X"EB01",X"EA07",X"E989",X"E90B",X"E890",X"E812",X"E796",X"E717",X"E69D",X"E61E",X"E5A0",X"E525",X"E524",X"E4A6",X"E42C",X"E3AD",X"E3AC",X"E331",X"E32F",X"E2B6",X"E236",X"E236",X"E237",X"E1BB",X"E13C",X"E13D",X"E13D",X"E0C0",X"E0BF",X"E043",X"E040",X"E043",X"DFC5",X"DFC7",X"DF49",X"DF49",X"DF49",X"DECC",X"DECB",X"DECA",X"DECC",X"DE4F",X"DE4E",X"DE4E",X"DDD2",X"DDD2",X"DDD2",X"DDD2",X"DD55",X"DD56",X"DD53",X"DD55",X"DD54",X"DCD6",X"DCD7",X"DCD9",X"DCD7",X"DCD6",X"DC5B",X"DC5A",X"DC5B",X"DC5B",X"DC5B",X"DBDD",X"DBDE",X"DBDD",X"DBDD",X"DBDE",X"DBDD",X"DBDE",X"DB5F",X"DB61",X"DB61",X"DB61",X"DB60",X"DB5F",X"DB62",X"DAE4",X"DAE3",X"DAE4",X"DAE4",X"23A5",X"1D4C",X"176F",X"1117",X"0D2F",X"08CB",X"055F",X"02EE",X"FFFF",X"FE0C",X"FB9A",X"FA23",X"F7B0",X"F6B9",X"F541",X"F3CA",X"F253",X"F15A",X"F060",X"EF66",X"EE6B",X"ED73",X"EC78",X"EBFB",X"EB7F",X"EA84",X"EA07",X"E90E",X"E890",X"E890",X"E795",X"E71A",X"E69C",X"E69C",X"E61E",X"E5A1",X"E525",X"E4A8",X"E4A8",X"E42B",X"E3AD",X"E3AF",X"E331",X"E2B3",X"E2B4",X"E236",X"E237",X"E1BA",X"E1B8",X"E13E",X"E13C",X"E0BF",X"E0C0",X"E0C0",X"E042",X"E042",X"DFC6",X"DFC6",X"DFC4",X"DF49",X"DF47",X"DF49",X"DECC",X"DECB",X"DECC",X"DE4E",X"DE4F",X"DE4D",X"DE4E",X"DDD0",X"DDD2",X"DDD1",X"DDD2",X"DD55",X"DD55",X"DD54",X"DD54",X"DCD8",X"DCD8",X"DCD8",X"DCD8",X"DCD7",X"DC5C",X"DC5A",X"DC5B",X"DC5B",X"DC5B",X"DC5C",X"DBDE",X"DBDD",X"DBDE",X"DBDC",X"DBDE",X"DBDE",X"DB60",X"DB61",X"DB61",X"DB5F",X"DB61",X"DB60",X"DB61",X"DAE4",X"DAE4",X"DAE4",X"DAE2",X"2903",X"21B1",X"1B57",X"1405",X"0FA0",X"0ABC",X"0754",X"04E2",X"0176",X"FF83",X"FD12",X"FB1D",X"F8AC",X"F734",X"F63C",X"F446",X"F34E",X"F1D6",X"F0DD",X"EFE3",X"EEE9",X"EDEF",X"ECF4",X"EC77",X"EBFB",X"EB01",X"EA85",X"E98A",X"E90B",X"E891",X"E814",X"E795",X"E718",X"E69C",X"E61E",X"E5A2",X"E5A2",X"E525",X"E4A9",X"E42A",X"E42A",X"E3AC",X"E331",X"E331",X"E2B5",X"E2B5",X"E237",X"E237",X"E1BA",X"E13B",X"E13D",X"E13D",X"E0C0",X"E0BF",X"E043",X"E043",X"E043",X"DFC6",X"DFC5",X"DF49",X"DF48",X"DF48",X"DF49",X"DECD",X"DECB",X"DECA",X"DE50",X"DE4D",X"DE4E",X"DDD1",X"DDD2",X"DDD2",X"DDD3",X"DD55",X"DD56",X"DD54",X"DD54",X"DD55",X"DCD8",X"DCD9",X"DCD7",X"DCD6",X"DCD8",X"DC5B",X"DC5B",X"DC5B",X"DC5B",X"DC5A",X"DBDE",X"DBDB",X"DBDE",X"DBDD",X"DBDE",X"DBDC",X"DBDE",X"DB61",X"DB61",X"DB60",X"DB60",X"DB62",X"DB61",X"DB5F",X"DAE3",X"DAE3",X"DAE4",X"DAE4",X"2693",X"1F41",X"1771",X"128D",X"0D2D",X"09C4",X"0657",X"02EF",X"007D",X"FE0B",X"FC18",X"FA24",X"F830",X"F6B9",X"F543",X"F3CA",X"F254",X"F15A",X"F060",X"EF66",X"EE6C",X"ED71",X"ECF5",X"EBFB",X"EB7C",X"EA84",X"EA07",X"E989",X"E88E",X"E890",X"E813",X"E718",X"E717",X"E69C",X"E61E",X"E5A2",X"E526",X"E4A7",X"E4A7",X"E42C",X"E3AE",X"E3AD",X"E331",X"E2B3",X"E2B5",X"E236",X"E239",X"E1B9",X"E1BA",X"E13C",X"E13D",X"E0C0",X"E0C0",X"E0C0",X"E041",X"E041",X"DFC5",X"DFC6",X"DFC4",X"DF49",X"DF4A",X"DF49",X"DECB",X"DECB",X"DECA",X"DE4F",X"DE4E",X"DE4C",X"DE4F",X"DDD0",X"DDD2",X"DDD1",X"DDD1",X"DD55",X"DD55",X"DD55",X"DD55",X"DCD7",X"DCD7",X"DCD6",X"DCD7",X"DCD7",X"DC5D",X"DC5B",X"DC5B",X"DC5B",X"DC5B",X"DC5B",X"DBDE",X"DBDE",X"DBDE",X"DBDC",X"DBDE",X"DBDF",X"DB60",X"DB60",X"DB60",X"DB61",X"DB61",X"DB61",X"DB61",X"DB60",X"DAE3",X"DAE4",X"DAE4",X"2BF1",X"23A5",X"1B58",X"15F7",X"0FA2",X"0C35",X"08C8",X"04E2",X"01F2",X"FF82",X"FD8F",X"FB1C",X"F927",X"F7B3",X"F63C",X"F4C5",X"F34C",X"F253",X"F15A",X"EFE2",X"EEE7",X"EDEF",X"ED71",X"EC77",X"EBFB",X"EB00",X"EA84",X"EA07",X"E90D",X"E88F",X"E813",X"E796",X"E719",X"E69B",X"E61C",X"E61F",X"E5A2",X"E525",X"E4A9",X"E42A",X"E42C",X"E3AE",X"E331",X"E331",X"E2B4",X"E2B4",X"E236",X"E237",X"E1B6",X"E1BB",X"E13D",X"E13D",X"E0BF",X"E0BF",X"E042",X"E042",X"E043",X"DFC6",X"DFC7",X"DFC6",X"DF47",X"DF49",X"DF48",X"DECB",X"DECC",X"DECC",X"DE4E",X"DE4F",X"DE4F",X"DE4F",X"DDD0",X"DDD2",X"DDD1",X"DDD2",X"DD55",X"DD55",X"DD54",X"DD54",X"DCD7",X"DCDA",X"DCD7",X"DCD6",X"DCD7",X"DC5A",X"DC5A",X"DC5A",X"DC5B",X"DC5B",X"DC5C",X"DBDF",X"DBDF",X"DBDD",X"DBDC",X"DBDD",X"DBDE",X"DB62",X"DB61",X"DB60",X"DB5F",X"DB60",X"DB61",X"DB61",X"DAE4",X"DAE3",X"DAE4",X"DAE3",X"2902",X"1F3F",X"1964",X"128E",X"0EA6",X"09C4",X"0658",X"03E8",X"007B",X"FF05",X"FC18",X"FAA0",X"F8AD",X"F6B9",X"F5BF",X"F3C9",X"F2CF",X"F1D7",X"F060",X"EFE3",X"EE6C",X"EDEF",X"ECF6",X"EBFA",X"EB7F",X"EA83",X"EA06",X"E989",X"E90D",X"E88E",X"E811",X"E796",X"E719",X"E69C",X"E61F",X"E5A2",X"E524",X"E4A8",X"E4A8",X"E42B",X"E3AE",X"E3AE",X"E331",X"E331",X"E2B5",X"E237",X"E237",X"E1BA",X"E1B9",X"E13C",X"E13D",X"E13D",X"E0C0",X"E0BF",X"E043",X"E042",X"E043",X"DFC6",X"DFC5",X"DF47",X"DF49",X"DF48",X"DF48",X"DECC",X"DECB",X"DECB",X"DE4E",X"DE4F",X"DE4F",X"DE4F",X"DDD2",X"DDD1",X"DDD2",X"DDD2",X"DD56",X"DD55",X"DD55",X"DD54",X"DCDA",X"DCD7",X"DCD7",X"DCD8",X"DCD5",X"DCD8",X"DC5A",X"DC5B",X"DC5B",X"DC5B",X"DC5A",X"DBDE",X"DBDE",X"DBDC",X"DBDF",X"DBDF",X"DBDD",X"DBDE",X"DB61",X"DB61",X"DB60",X"DB61",X"DB61",X"DB5F",X"DB60",X"DAE4",X"DAE4",X"DAE4",X"23A5",X"1D4C",X"15F8",X"1114",X"0BBA",X"08CA",X"055F",X"01F5",X"FFFF",X"FD8F",X"FB9C",X"FA23",X"F7B3",X"F6BA",X"F4C3",X"F3CB",X"F2D1",X"F15A",X"F062",X"EF65",X"EE6A",X"ED71",X"EC77",X"EBFB",X"EB01",X"EA84",X"EA07",X"E989",X"E90C",X"E813",X"E796",X"E718",X"E69B",X"E69C",X"E620",X"E5A2",X"E525",X"E4A7",X"E4A7",X"E42A",X"E3AD",X"E3AE",X"E330",X"E331",X"E2B4",X"E237",X"E238",X"E1B9",X"E1B9",X"E13D",X"E13C",X"E13D",X"E0C0",X"E0C1",X"E043",X"E042",X"E044",X"DFC6",X"DFC7",X"DFC6",X"DF47",X"DF49",X"DF47",X"DECC",X"DECC",X"DECD",X"DE4F",X"DE4E",X"DE4F",X"DE4F",X"DDD1",X"DDD2",X"DDD2",X"DDD2",X"DD55",X"DD54",X"DD55",X"DD54",X"DD57",X"DCD8",X"DCD7",X"DCD8",X"DCD8",X"DCDA",X"DC5B",X"DC5B",X"DC5B",X"DC5B",X"DC59",X"DC5B",X"DBDC",X"DBDD",X"DBDC",X"DBDE",X"DBDE",X"DBDE",X"DBDD",X"DB61",X"DB61",X"DB60",X"DB60",X"DB61",X"DB62",X"DB60",X"DAE4",X"2904",X"2134",X"1963",X"1404",X"0E28",X"0ABF",X"0752",X"03E8",X"0177",X"FF06",X"FD11",X"FB1E",X"F928",X"F7B3",X"F5BF",X"F447",X"F34D",X"F1D8",X"F0DC",X"EFE3",X"EEE9",X"EDEE",X"ECF4",X"EC79",X"EB7D",X"EB01",X"EA84",X"E98A",X"E90C",X"E88F",X"E812",X"E794",X"E718",X"E69B",X"E61E",X"E61F",X"E5A1",X"E526",X"E4A8",X"E4A7",X"E429",X"E3AD",X"E3AE",X"E331",X"E2B3",X"E2B4",X"E236",X"E235",X"E1B9",X"E1BA",X"E13E",X"E13D",X"E13D",X"E0C0",X"E0C0",X"E044",X"E043",X"E043",X"DFC5",X"DFC4",X"DFC4",X"DF48",X"DF49",X"DF49",X"DECD",X"DECC",X"DECC",X"DE4F",X"DE4F",X"DE4F",X"DE4E",X"DDD2",X"DDD1",X"DDD1",X"DDD1",X"DD54",X"DD55",X"DD55",X"DD55",X"DD54",X"DCD8",X"DCD9",X"DCD7",X"DCD8",X"DCD9",X"DCD9",X"DC5B",X"DC5B",X"DC5C",X"DC5A",X"DC5C",X"DC5B",X"DBDE",X"DBDE",X"DBDF",X"DBDE",X"DBDD",X"DBDE",X"DBDD",X"DB60",X"DB61",X"DB62",X"DB61",X"DB60",X"DB60",X"DB61",X"2614",X"1CCD",X"176E",X"1116",X"0D30",X"09C4",X"055F",X"02EC",X"0000",X"FE0B",X"FC17",X"FA23",X"F8AD",X"F6B9",X"F543",X"F448",X"F2D1",X"F1D7",X"F05F",X"EF66",X"EEE9",X"EDED",X"ECF4",X"EBFA",X"EB7C",X"EA84",X"EA07",X"E98A",X"E90D",X"E88F",X"E811",X"E796",X"E717",X"E69B",X"E61F",X"E5A2",X"E5A0",X"E524",X"E4A9",X"E42B",X"E42D",X"E3AD",X"E332",X"E330",X"E2B4",X"E2B4",X"E235",X"E236",X"E1BA",X"E1BA",X"E13D",X"E13D",X"E0C2",X"E0C0",X"E0C0",X"E043",X"E043",X"E042",X"DFC6",X"DFC7",X"DFC5",X"DF48",X"DF4A",X"DF46",X"DECC",X"DECC",X"DECC",X"DECB",X"DE4E",X"DE4F",X"DE4F",X"DE4E",X"DDD1",X"DDD2",X"DDD0",X"DDD2",X"DD56",X"DD54",X"DD55",X"DD53",X"DD55",X"DCD6",X"DCD8",X"DCD7",X"DCD9",X"DCD8",X"DC59",X"DC5B",X"DC5B",X"DC5B",X"DC5B",X"DC59",X"DBDD",X"DBDF",X"DBDF",X"DBDE",X"DBDE",X"DBDF",X"DBDE",X"DBDD",X"DB60",X"DB61",X"DB5F",X"DB61",X"DB61",X"2B74",X"2133",X"1ADB",X"1405",X"0FA0",X"0BB9",X"0754",X"0465",X"0176",X"FF84",X"FD8E",X"FB1D",X"F9A7",X"F7B3",X"F63C",X"F4C5",X"F34E",X"F253",X"F0DC",X"F05E",X"EEE8",X"EE6B",X"ED72",X"EC78",X"EBFA",X"EB01",X"EA83",X"EA07",X"E989",X"E90E",X"E813",X"E811",X"E797",X"E718",X"E69D",X"E61F",X"E5A1",X"E524",X"E523",X"E4A9",X"E429",X"E42B",X"E3AF",X"E330",X"E331",X"E2B3",X"E2B2",X"E235",X"E237",X"E1B8",X"E1BA",X"E13C",X"E13E",X"E13E",X"E0C0",X"E0C0",X"E042",X"E044",X"E044",X"DFC6",X"DFC7",X"DFC8",X"DF4A",X"DF49",X"DF48",X"DECC",X"DECC",X"DECB",X"DECC",X"DE4D",X"DE4E",X"DE4F",X"DE4F",X"DDD3",X"DDD0",X"DDD1",X"DDD2",X"DD52",X"DD53",X"DD53",X"DD54",X"DD57",X"DCD8",X"DCD8",X"DCD8",X"DCD8",X"DCD8",X"DCD8",X"DC5B",X"DC5A",X"DC5B",X"DC5B",X"DC5B",X"DC5B",X"DBDD",X"DBDE",X"DBDD",X"DBDE",X"DBDE",X"DBDD",X"DBDE",X"DBDD",X"DB61",X"DB61",X"DB61",X"DB61",X"2616",X"1EC3",X"176E",X"128E",X"0E29",X"09C2",X"0659",X"02EE",X"007B",X"FF05",X"FC18",X"FAA0",X"F8AB",X"F736",X"F5BF",X"F448",X"F34D",X"F1D7",X"F0DD",X"EF66",X"EEEB",X"EDEF",X"ECF5",X"EC76",X"EB7E",X"EB01",X"EA83",X"E98A",X"E90C",X"E890",X"E814",X"E796",X"E719",X"E69C",X"E61F",X"E620",X"E5A1",X"E525",X"E524",X"E4A7",X"E42B",X"E3AF",X"E3AD",X"E330",X"E331",X"E2B3",X"E2B4",X"E236",X"E237",X"E1B9",X"E1BA",X"E13D",X"E13D",X"E13D",X"E0C0",X"E0C2",X"E042",X"E044",X"E045",X"DFC4",X"DFC6",X"DFC6",X"DF49",X"DF4B",X"DF47",X"DF4A",X"DECB",X"DECC",X"DECB",X"DE50",X"DE4F",X"DE4F",X"DE4E",X"DDD0",X"DDD1",X"DDD2",X"DDD1",X"DDD2",X"DD55",X"DD55",X"DD55",X"DD55",X"DD53",X"DCD7",X"DCD7",X"DCD8",X"DCD8",X"DCD8",X"DCDA",X"DC5A",X"DC5B",X"DC5A",X"DC5B",X"DC5C",X"DC5B",X"DBDF",X"DBDE",X"DBDE",X"DBDE",X"DBDE",X"DBDD",X"DBDF",X"DBDD",X"DB61",X"DB60",X"2B75",X"2328",X"1ADB",X"157C",X"1115",X"0BB7",X"084A",X"0464",X"01F4",X"FFFF",X"FD8E",X"FB9B",X"F9A7",X"F830",X"F6B7",X"F4C5",X"F3CA",X"F254",X"F159",X"F05F",X"EF65",X"EE6C",X"ED72",X"ECF5",X"EBFC",X"EB7D",X"EB01",X"EA07",X"E98A",X"E90D",X"E88F",X"E813",X"E795",X"E719",X"E69B",X"E61E",X"E61F",X"E5A3",X"E525",X"E4A9",X"E4A6",X"E42B",X"E3AD",X"E3AE",X"E330",X"E332",X"E2B3",X"E2B2",X"E237",X"E236",X"E1B8",X"E1BA",X"E13C",X"E13D",X"E13D",X"E0C0",X"E0C0",X"E042",X"E043",X"E042",X"DFC4",X"DFC6",X"DFC5",X"DF49",X"DF47",X"DF48",X"DF48",X"DECC",X"DECC",X"DECC",X"DECC",X"DE4F",X"DE4F",X"DE4F",X"DE4E",X"DDD1",X"DDD2",X"DDD2",X"DDD1",X"DD53",X"DD55",X"DD54",X"DD54",X"DD55",X"DD55",X"DCD8",X"DCD7",X"DCD8",X"DCD7",X"DCD8",X"DC5A",X"DC5B",X"DC5A",X"DC5B",X"DC5A",X"DC5A",X"DC5B",X"DBDE",X"DBDB",X"DBDD",X"DBDC",X"DBDE",X"DBDE",X"DBDE",X"DBDC",X"DB60",X"2887",X"1EC3",X"18E6",X"1406",X"0E29",X"0ABC",X"0657",X"03E7",X"0177",X"FF05",X"FD11",X"FAA0",X"F92B",X"F7B4",X"F5C0",X"F4C6",X"F34E",X"F253",X"F0DD",X"EFE3",X"EF66",X"EDF0",X"ED73",X"EC78",X"EBFA",X"EB7D",X"EA84",X"EA07",X"E988",X"E98B",X"EA85",X"EAFF",X"EBFA",X"ECF5",X"EE6C",X"EF64",X"F0DD",X"F1D8",X"F34F",X"F4C5",X"F63C",X"F735",X"F92A",X"FAA2",X"FC17",X"FD8F",X"FF05"
	begin
	if (resetN='0') then
		Q_tmp <= ( others => '0');
	elsif(rising_edge(CLK)) then
	--      if (ENA='1') then
		Q_tmp <= err_table(conv_integer(ADDR));
	--      end if;
	end if;
end process;

Q <= Q_tmp; 

		   
end arch;