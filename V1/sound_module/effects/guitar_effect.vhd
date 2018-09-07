library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all ;
use ieee.std_logic_arith.all;
library work;
use work.pkg2.all;

entity guitar_effect is
port(
  CLK     					: in std_logic;
  resetN 					: in std_logic;
  addrArr    				: in Arr_type;
  Q       					: out std_logic_vector(15 downto 0)
);
end guitar_effect;

architecture arch of guitar_effect is
	constant array_size 			: integer := 4000 ;
	
	signal Q_tmp       			:  std_logic_vector(15 downto 0) ;
	
	type table_type is array(0 to array_size - 1) of std_logic_vector(15 downto 0);
	constant sound0 : table_type := (X"0C3B",X"F5FE",X"EDAA",X"FFB8",X"EF0B",X"E1C9",X"0ACC",X"0323",X"F98B",X"F940",X"0202",X"021E",X"024D",X"FA31",X"0162",X"FB1A",X"FD20",X"FB53",X"07F9",X"01E6",X"0359",X"01F2",X"088E",X"0599",X"0055",X"FCC4",X"08B1",X"0562",X"0782",X"FFC1",X"F4E4",X"FB61",X"FD47",X"050F",X"0035",X"FF21",X"FEBB",X"F004",X"DBE4",X"F901",X"09F7",X"0030",X"04F8",X"0618",X"0AE1",X"E8B0",X"E014",X"E06B",X"0A62",X"1C65",X"F400",X"EF3D",X"EBF7",X"0103",X"F9F4",X"F73C",X"0625",X"02A2",X"0A63",X"EDE0",X"F509",X"00CD",X"0873",X"0D5D",X"000A",X"0129",X"FECE",X"FA4E",X"03F1",X"1710",X"0D2C",X"0E22",X"0394",X"FEA6",X"EFE1",X"05EA",X"0335",X"0C54",X"FEFF",X"F4D7",X"FDBF",X"03EC",X"F533",X"F0DC",X"1367",X"FF74",X"FBD5",X"FC65",X"EDB5",X"0BC2",X"F8E5",X"F3BA",X"10F0",X"10A4",X"0BE2",X"FE81",X"ECB8",X"0A8B",X"1D2D",X"236A",X"1B3F",X"04CA",X"0053",X"EFB8",X"FEBC",X"FEDB",X"00A4",X"0189",X"F57E",X"0507",X"0DDF",X"00B3",X"088A",X"0BC2",X"F399",X"0B4D",X"F08A",X"E786",X"0476",X"FCAD",X"EEB6",X"FAFB",X"229C",X"0FEB",X"E2FA",X"103D",X"07CE",X"FD91",X"EF65",X"DAE0",X"FD10",X"F9C5",X"F7B1",X"008F",X"FEFB",X"EDD2",X"0D9F",X"027C",X"F549",X"09AC",X"0C99",X"F277",X"0FB1",X"054B",X"FFAF",X"0B3C",X"1886",X"0D34",X"FC60",X"FDAD",X"0716",X"FB99",X"FBEA",X"1418",X"1753",X"1099",X"02EC",X"EFD1",X"1E84",X"EBBD",X"EB3A",X"2E00",X"FB0C",X"E524",X"1FD0",X"F58A",X"1DF6",X"1E5D",X"E91C",X"EE02",X"F09A",X"DF03",X"EA4A",X"EE9B",X"0947",X"026F",X"0901",X"DC97",X"032F",X"08C7",X"0E29",X"3116",X"29A5",X"0E97",X"015C",X"E8A0",X"0C0A",X"099B",X"0918",X"20C1",X"F4E7",X"DE8E",X"F54A",X"F7A5",X"2725",X"0638",X"E86C",X"FC8D",X"EBA3",X"E3C4",X"F482",X"02D9",X"214D",X"F042",X"D6E8",X"D94B",X"E94C",X"E9B0",X"0404",X"234F",X"1C7A",X"1654",X"0E74",X"05AB",X"F603",X"1E73",X"00CB",X"19A5",X"0FFB",X"0E51",X"F464",X"05E9",X"10B0",X"2745",X"06E8",X"1494",X"F3BD",X"FD29",X"EE3C",X"ECFB",X"1EFC",X"D07F",X"E8BA",X"0313",X"D302",X"ED7D",X"EDB2",X"FF41",X"E1C9",X"F043",X"D8C5",X"0007",X"0A5A",X"16AF",X"F408",X"17E3",X"F95E",X"074B",X"FA28",X"2704",X"1977",X"234B",X"EB6E",X"0CD6",X"FC1F",X"2465",X"1F94",X"0F6F",X"0C6B",X"E506",X"EF39",X"076F",X"EBA2",X"0515",X"F7D9",X"FB8C",X"F416",X"F978",X"ECC6",X"150A",X"FA3B",X"F17A",X"D632",X"0298",X"D792",X"F8C4",X"EFEB",X"1A1E",X"057B",X"FEF6",X"EE02",X"06F6",X"011A",X"F89F",X"FBB0",X"1C12",X"0E20",X"FD91",X"EAF8",X"16EF",X"0564",X"107A",X"1BE2",X"2089",X"1B3B",X"0C29",X"EFCA",X"0BA9",X"F6EC",X"21C5",X"FCFD",X"0876",X"ECA4",X"E10C",X"CFD8",X"E763",X"F371",X"DBFC",X"ED9D",X"E1D2",X"E10D",X"F8AA",X"EF09",X"2A9E",X"1992",X"EA23",X"ECC2",X"EE33",X"F08D",X"F252",X"FEED",X"1AFD",X"2A4E",X"10FE",X"FF3E",X"04D8",X"117F",X"1A81",X"FD55",X"1026",X"0D24",X"F4A5",X"059F",X"FE03",X"10E1",X"0BE2",X"01DE",X"EF73",X"FA3B",X"E0CC",X"ECAD",X"07E4",X"017C",X"F618",X"116B",X"F154",X"FC0E",X"EC4A",X"FEF1",X"F96C",X"0515",X"00B2",X"EF50",X"ED95",X"FE8C",X"0693",X"21C0",X"1FBB",X"0CFD",X"FA45",X"0554",X"0A95",X"0092",X"F58A",X"ED8D",X"F598",X"01B4",X"C202",X"1224",X"0BE0",X"F630",X"D68C",X"E7FB",X"D699",X"0DB2",X"F3FB",X"1295",X"051E",X"0FD7",X"F656",X"FC8F",X"1327",X"0BD7",X"FE45",X"092F",X"FA64",X"ED10",X"038F",X"22C5",X"0C7F",X"19DA",X"F905",X"F7C4",X"F5E3",X"EF26",X"E4BA",X"0C8C",X"0440",X"0EA4",X"DF65",X"FD00",X"057E",X"13F1",X"FD14",X"0C62",X"0AE8",X"FC3F",X"EAB9",X"EE1A",X"0E4A",X"0E20",X"020B",X"18B5",X"045F",X"0106",X"E711",X"FDC5",X"17EE",X"1214",X"0A10",X"EFDC",X"F548",X"FC2C",X"01FB",X"FAF6",X"156E",X"14DC",X"FCA4",X"0114",X"F218",X"F501",X"11D6",X"174A",X"0ABA",X"0FA1",X"ECF3",X"EBC3",X"E1B1",X"EFD5",X"EE24",X"FB2B",X"0835",X"F033",X"F67B",X"F3D5",X"1E58",X"126E",X"093C",X"EFB4",X"F35C",X"EFA6",X"CCD6",X"E704",X"16F1",X"009E",X"0450",X"F2EF",X"ED0E",X"F220",X"0AAE",X"09DE",X"1B86",X"0DC2",X"0D85",X"F367",X"0AE3",X"F502",X"1E9B",X"161B",X"25A2",X"FA84",X"0DEE",X"156A",X"0984",X"18AB",X"1E01",X"132F",X"13D4",X"FFB4",X"FC50",X"F305",X"1B7A",X"EDEC",X"FC4C",X"D7E3",X"01CA",X"DCC2",X"F944",X"14B8",X"2D18",X"15A1",X"0438",X"EDD6",X"1A64",X"0269",X"E8B2",X"F079",X"011D",X"F1F0",X"E318",X"F809",X"1B40",X"01E3",X"0389",X"E1D2",X"F04C",X"DFAB",X"0409",X"08E9",X"1CB1",X"F7C7",X"0C3A",X"0185",X"0866",X"022B",X"1EFA",X"1F95",X"00C8",X"00CF",X"F94C",X"0092",X"21CE",X"FB42",X"0C19",X"EE9E",X"FE63",X"EDDC",X"E1B0",X"E3A9",X"1179",X"F052",X"F48A",X"E0C4",X"F896",X"066A",X"F2EB",X"FA17",X"184E",X"0085",X"EC12",X"E82A",X"0171",X"FE49",X"12BC",X"23FF",X"2F8E",X"1D7A",X"1C79",X"15F6",X"057B",X"1D3A",X"15E3",X"201B",X"00D6",X"046F",X"165D",X"1772",X"0D85",X"114D",X"1B52",X"0915",X"FA81",X"D6EB",X"E1AC",X"0097",X"0FCC",X"ED4A",X"F614",X"D0F7",X"DDB5",X"D793",X"D2F0",X"FF95",X"F493",X"1092",X"E8F6",X"F18E",X"095E",X"2E2D",X"F85A",X"1DFF",X"1221",X"FCCC",X"F0D9",X"F828",X"03B8",X"0282",X"05F3",X"02EB",X"0796",X"E653",X"FBFA",X"03E2",X"FD11",X"F80C",X"EF39",X"EFD9",X"F3E4",X"EF1C",X"EF1A",X"17A2",X"09D5",X"091A",X"05B0",X"07AA",X"FC14",X"05F1",X"FC5C",X"1F34",X"077B",X"1D91",X"FCF4",X"05BC",X"0E88",X"0C9D",X"F6C0",X"F3FE",X"EFAE",X"EF70",X"E816",X"0B99",X"2B97",X"2004",X"FEE7",X"ECAD",X"0B41",X"0087",X"0C68",X"FDD7",X"03B3",X"FBC7",X"EA27",X"012F",X"FC00",X"023D",X"0163",X"F48A",X"D29F",X"E252",X"E979",X"264D",X"0A30",X"0103",X"F3AB",X"FCC1",X"F859",X"F9A7",X"190D",X"0BA0",X"1191",X"EC73",X"EF86",X"F0DE",X"FC69",X"151A",X"0D6B",X"FFDF",X"F97B",X"F872",X"EE8F",X"DB77",X"F005",X"FB94",X"F3C1",X"FC95",X"F04B",X"FECD",X"F736",X"0D19",X"02E5",X"0265",X"FD88",X"EE88",X"ECDE",X"CF59",X"F9F4",X"11EE",X"164B",X"0F29",X"FB1E",X"FE4E",X"F638",X"F605",X"1EA1",X"1F09",X"1EC0",X"0173",X"1004",X"0DE9",X"0AF4",X"1044",X"20FF",X"234B",X"0BFD",X"F0AD",X"F667",X"FFF9",X"135B",X"0705",X"EFB8",X"E850",X"D4D4",X"D175",X"DABF",X"D92B",X"F468",X"E9B4",X"E547",X"E3A3",X"F7A0",X"0314",X"1851",X"0E65",X"263C",X"0A50",X"F0A5",X"071A",X"F64F",X"F247",X"036F",X"11E6",X"097C",X"0047",X"F597",X"0A71",X"10A5",X"F4A5",X"FE4C",X"05AE",X"EBD7",X"E545",X"E81D",X"F67C",X"0B2E",X"FC6B",X"0276",X"ED12",X"0410",X"F8BA",X"002F",X"10E4",X"1483",X"1587",X"01CE",X"FA22",X"FB90",X"0D95",X"1B8D",X"ED06",X"F733",X"ECEE",X"F814",X"06E3",X"2071",X"20AA",X"0E70",X"F74C",X"F48E",X"019B",X"040C",X"1711",X"F7EE",X"E4EA",X"E3DC",X"E43E",X"F798",X"FC0B",X"1431",X"0CAC",X"F20C",X"E5E3",X"F6F4",X"F778",X"10B4",X"0189",X"07BE",X"0160",X"0430",X"FA24",X"1F2E",X"143A",X"0CF5",X"0C0F",X"F946",X"02F6",X"DDB6",X"F723",X"094B",X"074A",X"E7B7",X"FB47",X"ECE7",X"D9FB",X"D93A",X"ECA8",X"FE0C",X"08DF",X"139B",X"FCDF",X"08B0",X"FECF",X"09A0",X"07EC",X"1A50",X"0954",X"F45B",X"DE59",X"FA0D",X"05DE",X"2CE2",X"105B",X"093C",X"13A4",X"EBEE",X"F187",X"F7EE",X"18B6",X"0C2F",X"FB72",X"F37B",X"FDE6",X"F428",X"13EB",X"0F68",X"2612",X"2859",X"08DA",X"0A85",X"F53E",X"FBBF",X"065B",X"1E25",X"F7C3",X"FA3C",X"E8FE",X"EDB0",X"E7DF",X"E656",X"EBAB",X"02B5",X"F6BB",X"F529",X"FC90",X"FFB2",X"1E2B",X"129A",X"0C3A",X"F32F",X"FB05",X"E839",X"F06C",X"EB38",X"0CA9",X"27BB",X"0019",X"FF93",X"F3AD",X"FE04",X"0351",X"FA8F",X"05E0",X"FA6B",X"E547",X"FDAF",X"F6F0",X"0222",X"105C",X"0DFE",X"FF81",X"F7FF",X"F770",X"09E3",X"0E21",X"0248",X"125B",X"111B",X"EF87",X"F9C3",X"0AC4",X"163F",X"147B",X"EC3D",X"FCA3",X"FF96",X"FCD9",X"0DA9",X"1880",X"193C",X"10CA",X"F28E",X"FFED",X"0DFC",X"0937",X"0DDF",X"E6BA",X"DF1E",X"EA99",X"EBB7",X"E315",X"0A04",X"FD92",X"E906",X"E7DB",X"D4C6",X"E83C",X"FAF8",X"09EB",X"11B3",X"0CE1",X"08A5",X"1C29",X"19D3",X"1847",X"1466",X"0FA8",X"2F79",X"04BB",X"F035",X"FFDF",X"0DBE",X"0A35",X"F783",X"EFD4",X"FA77",X"E77D",X"C4DD",X"D880",X"F12E",X"F4EA",X"F9A1",X"F313",X"E800",X"F98A",X"EE49",X"FCD4",X"06F0",X"08D3",X"1238",X"EC32",X"EF06",X"FD93",X"0A47",X"0FAA",X"140D",X"0F4D",X"0153",X"08C9",X"F944",X"10E3",X"0FA0",X"012F",X"0B0E",X"F10A",X"F13C",X"0195",X"0438",X"0F34",X"129A",X"098B",X"04E4",X"EE32",X"E747",X"F9E7",X"0B96",X"076B",X"F415",X"F57A",X"E971",X"E5F9",X"DDDB",X"E672",X"FF32",X"FD59",X"F878",X"FEEF",X"0898",X"0FED",X"1AAF",X"0933",X"0C36",X"FE87",X"F2D9",X"EC21",X"ED87",X"FB97",X"F384",X"071E",X"F286",X"EE35",X"F668",X"FC3C",X"FDFC",X"07BB",X"0243",X"FAE7",X"FB82",X"F69B",X"F185",X"00DF",X"1EAD",X"00CC",X"FD8E",X"1104",X"09A2",X"0F8B",X"FD3B",X"08DD",X"09DD",X"01D7",X"DEBD",X"F5E5",X"0E24",X"0FE7",X"F36E",X"E650",X"EA99",X"E8F0",X"FDFC",X"0970",X"14B8",X"14D8",X"0B71",X"F86E",X"0550",X"0C34",X"04AC",X"06CB",X"EA30",X"E446",X"ECDD",X"F938",X"F8FD",X"11FC",X"F548",X"F75C",X"ECDA",X"DD08",X"EA11",X"FF9D",X"09B0",X"0451",X"F98A",X"FEA7",X"173C",X"0399",X"1113",X"1FFA",X"1803",X"1CC8",X"060B",X"00EC",X"0808",X"0468",X"FC1A",X"0909",X"0267",X"F717",X"E5B6",X"E167",X"F0D2",X"F811",X"F9D3",X"0D12",X"F3CF",X"F157",X"ED73",X"EDB5",X"0587",X"10E8",X"01BE",X"FBEF",X"E241",X"DD13",X"031F",X"115B",X"19F1",X"232A",X"1998",X"11CC",X"0C92",X"0110",X"0732",X"17CD",X"1B5C",X"025B",X"F0C7",X"0F03",X"166A",X"0C59",X"1355",X"1EA4",X"0C9B",X"0567",X"E236",X"E8BD",X"137E",X"F72E",X"F2F2",X"EE06",X"ED9C",X"D9F9",X"DB8C",X"E12B",X"EF94",X"037E",X"08AD",X"0278",X"0309",X"0D34",X"0A29",X"15DD",X"1A83",X"0E61",X"020A",X"0119",X"F872",X"F494",X"0599",X"00E4",X"16CA",X"F553",X"EB3B",X"E92E",X"0ACB",X"0334",X"FCAE",X"F922",X"F6A9",X"EAD5",X"EA84",X"035C",X"1A51",X"14F6",X"0FD7",X"14BD",X"1398",X"0E42",X"011D",X"194A",X"1A7A",X"FC1C",X"FE64",X"F3A3",X"1773",X"0AD5",X"0440",X"F495",X"E42D",X"E38F",X"F8B4",X"FA9F",X"0C03",X"0C4B",X"FF22",X"EE1C",X"F1E9",X"F563",X"0DCB",X"0338",X"0080",X"EEDC",X"FBCF",X"F624",X"F8BD",X"FF6F",X"FE69",X"F7F5",X"FB6B",X"F238",X"E544",X"FEE9",X"0BE9",X"F463",X"00F8",X"1102",X"0BDA",X"FE5D",X"FB17",X"0730",X"25DC",X"0097",X"10EC",X"FDFE",X"EF2B",X"DA25",X"F4D7",X"FE7D",X"0392",X"F0F5",X"FB57",X"E8E4",X"D7FA",X"EB85",X"F69E",X"0C77",X"0B5E",X"F52C",X"E3E4",X"035C",X"00A0",X"0809",X"217F",X"FCC4",X"FC1E",X"E6D9",X"E2C4",X"0461",X"153E",X"1248",X"0D8A",X"06B2",X"0B81",X"FD06",X"F643",X"0E32",X"1F83",X"0C37",X"012B",X"0671",X"132D",X"FEE8",X"F89C",X"229B",X"2667",X"0BF5",X"FF60",X"FA83",X"F3E7",X"F52D",X"E648",X"FFB1",X"F273",X"DAF6",X"CCFD",X"DB87",X"D6B5",X"F25A",X"F814",X"F883",X"FDB2",X"FB76",X"FE14",X"0F66",X"19EC",X"20C7",X"226B",X"01AB",X"024B",X"F385",X"EFF8",X"0C6D",X"FD51",X"13F5",X"E856",X"F74A",X"0A9E",X"0177",X"F8F9",X"04E2",X"EC21",X"E978",X"DE81",X"F188",X"06E2",X"042C",X"FCB1",X"0F25",X"0A5C",X"00A4",X"0386",X"1D03",X"0F93",X"1111",X"02B1",X"0FF0",X"05E9",X"0D8B",X"0EBB",X"0F56",X"F0FA",X"F12E",X"FA16",X"171B",X"08D8",X"075C",X"11BE",X"06F6",X"F02E",X"FDAC",X"FB68",X"0D19",X"FF6C",X"EFE5",X"E660",X"F24E",X"DFC2",X"FA48",X"F23C",X"0E1E",X"FBC3",X"FCFD",X"FE0D",X"F6FD",X"FDF9",X"0064",X"F914",X"19BD",X"19F3",X"00EF",X"041C",X"21F6",X"1CBB",X"15A3",X"15A5",X"17B2",X"FBDA",X"E0DB",X"D98A",X"01D4",X"FBBD",X"F3EB",X"EF24",X"E1C3",X"D7F2",X"D3CE",X"E991",X"0D84",X"050B",X"0F69",X"003D",X"FBF3",X"02A7",X"FB72",X"1264",X"1C2D",X"0334",X"FA10",X"FF7B",X"FD3B",X"1431",X"0FF0",X"15C6",X"1A53",X"105D",X"F83E",X"FC63",X"FB49",X"0EEA",X"094B",X"F5CC",X"FC74",X"03F0",X"F677",X"F2C7",X"1A3E",X"1EED",X"22AF",X"0E6B",X"10B0",X"0089",X"E560",X"02C8",X"F98D",X"067B",X"E5D5",X"E094",X"E065",X"EE75",X"DA57",X"0060",X"0442",X"FEE4",X"F92C",X"FE2C",X"0229",X"1309",X"0A4A",X"0EB2",X"0DC7",X"F1A2",X"F3E0",X"FB55",X"FEED",X"04E4",X"0227",X"1297",X"F5B2",X"FA64",X"F6C4",X"03A5",X"FC41",X"0597",X"DAB6",X"F2A9",X"FCC6",X"06C8",X"F4BB",X"0E4E",X"0664",X"0B47",X"F92F",X"0064",X"1A43",X"1F03",X"FCBE",X"059B",X"F55F",X"FDCD",X"F0CF",X"10CE",X"15EF",X"0496",X"F859",X"036E",X"0907",X"0CC0",X"063B",X"113F",X"1354",X"0484",X"EA7E",X"0C30",X"0B7E",X"0CAC",X"FB78",X"0061",X"EF84",X"EF59",X"D61B",X"F3A3",X"F1B9",X"FA11",X"F2BB",X"F4C5",X"EE72",X"E946",X"E597",X"FA0B",X"0B0A",X"17BE",X"1945",X"0D98",X"1C37",X"1596",X"10BE",X"26F7",X"2319",X"173E",X"EFB1",X"E759",X"EE39",X"0347",X"F022",X"0217",X"F5FC",X"D75B",X"D1A1",X"DE0F",X"F0BC",X"0734",X"048F",X"F9A1",X"F0FB",X"E7D6",X"EF8E",X"0AE4",X"1578",X"17F9",X"0BC5",X"0AF6",X"0934",X"F705",X"04EA",X"1376",X"1987",X"178D",X"0CCE",X"06FD",X"1613",X"FBC8",X"03F8",X"0A0E",X"05FD",X"F79C",X"F7C7",X"F1E0",X"0AC6",X"0FDB",X"0BE5",X"1928",X"123B",X"FCA4",X"E4BE",X"EEB9",X"036F",X"F857",X"FD3C",X"FE50",X"F026",X"DA05",X"EEAB",X"E806",X"1475",X"039C",X"F954",X"FEA7",X"13FF",X"0437",X"0F32",X"130C",X"1888",X"F6F3",X"E4EE",X"ECBB",X"FD54",X"EE71",X"F79C",X"EF4B",X"F726",X"E1E3",X"E90A",X"F68C",X"0C2C",X"FAE7",X"F5F5",X"F24B",X"FDE0",X"F659",X"FC94",X"01E7",X"2204",X"0003",X"049A",X"0EE9",X"1D8B",X"177A",X"1300",X"0192",X"0D34",X"E759",X"FB44",X"0003",X"0F67",X"FBE3",X"F934",X"ECA4",X"FE89",X"F1DB",X"0060",X"FE3C",X"06E1",X"14BB",X"01E9",X"05F9",X"0AD7",X"F442",X"00D5",X"0303",X"01FC",X"EE84",X"F50A",X"E889",X"FF02",X"F02E",X"FB0F",X"02F5",X"01CF",X"E164",X"E21E",X"E33A",X"FC45",X"0739",X"120F",X"10EB",X"0EFF",X"F96F",X"065E",X"145E",X"2584",X"1F5C",X"09B7",X"0661",X"F247",X"DF08",X"FFE1",X"F801",X"FCD8",X"E876",X"D2C0",X"EAA3",X"F10F",X"EC4A",X"06C2",X"FE4E",X"F2F1",X"EC0D",X"E937",X"F5CA",X"0379",X"FB58",X"065B",X"00B8",X"03AA",X"F43B",X"F2A0",X"0555",X"1590",X"11C6",X"154C",X"264E",X"06D8",X"037D",X"F539",X"0907",X"1389",X"0103",X"EE64",X"1339",X"0745",X"00CA",X"0BBA",X"131E",X"2C80",X"0304",X"E2F8",X"FC68",X"F7C1",X"F0C0",X"EF31",X"F0A4",X"E90E",X"DC13",X"D435",X"F731",X"FB2D",X"09CF",X"021B",X"11A5",X"033D",X"10BA",X"02BC",X"19BF",X"1438",X"FFA3",X"00BC",X"022D",X"0368",X"0555",X"F2CD",X"F829",X"F312",X"E2A0",X"E24C",X"FD28",X"F524",X"FF92",X"E9BA",X"F1F1",X"EF55",X"EB5F",X"EC20",X"06B4",X"0F9E",X"1972",X"07BF",X"1BB7",X"235F",X"163A",X"0DAE",X"2526",X"077F",X"FECE",X"F0F4",X"0921",X"03DF",X"0510",X"FAC0",X"068E",X"F6EC",X"F63B",X"F4F0",X"FC4F",X"EF94",X"0852",X"0150",X"FF6F",X"F22D",X"F18D",X"FF56",X"0A7F",X"0133",X"0594",X"019E",X"06EC",X"E54C",X"F1D2",X"FB1E",X"0FC3",X"03D0",X"FC0B",X"EE8C",X"FBCE",X"FD64",X"02DF",X"0DBB",X"1A34",X"1D38",X"033E",X"F913",X"1BA1",X"1D01",X"1A80",X"0BDD",X"0B3E",X"F259",X"DC54",X"DCED",X"FC78",X"FB34",X"F511",X"F1C6",X"F073",X"F542",X"EEE1",X"F874",X"08B2",X"005A",X"EEB9",X"0255",X"0568",X"FDB3",X"035F",X"0A2C",X"101E",X"08C7",X"F93B",X"F44B",X"021C",X"FE3D",X"0793",X"0893",X"161B",X"0ADC",X"F647",X"002F",X"0348",X"0E58",X"0985",X"0287",X"048E",X"1CC7",X"FCD4",X"04A4",X"21A6",X"1FAF",X"0DAD",X"FD23",X"FC0B",X"0939",X"F1B0",X"EE8E",X"F798",X"ED80",X"D615",X"DEFC",X"E3C5",X"FB50",X"F390",X"FD52",X"0185",X"F3D6",X"F533",X"153D",X"0E7E",X"1499",X"0E9E",X"0C60",X"0D6A",X"03B1",X"F3F3",X"0DE3",X"FECA",X"F772",X"E8B3",X"F3E6",X"FC55",X"078E",X"F0F4",X"065D",X"F96A",X"F00D",X"E358",X"EFEC",X"F50A",X"14E4",X"07AE",X"0463",X"08BC",X"0B1C",X"0A27",X"0958",X"17B0",X"1ECF",X"008A",X"0B89",X"01B2",X"020C",X"F721",X"08B2",X"02D9",X"074E",X"F443",X"026B",X"038D",X"F36A",X"F580",X"153E",X"02B0",X"FBC6",X"E797",X"EED8",X"FF00",X"FADB",X"F1B7",X"0F6D",X"F89D",X"EB57",X"DB66",X"EB25",X"0109",X"0AB3",X"0813",X"0515",X"FB1B",X"FA31",X"F186",X"0450",X"1992",X"2069",X"0B53",X"036A",X"0A1C",X"17C7",X"16C5",X"164D",X"0C8F",X"05B4",X"DEE0",X"DE1A",X"E4CC",X"F3A2",X"E6E0",X"ECD8",X"E5D7",X"E002",X"E96D",X"F254",X"04BE",X"FBFC",X"0306",X"0981",X"09F3",X"FE2E",X"F264",X"0B01",X"158D",X"0A1B",X"0779",X"0D0D",X"0AE3",X"05D3",X"F970",X"0DCB",X"15BE",X"0903",X"0232",X"F318",X"0141",X"FFF0",X"FCF9",X"FCFD",X"FC50",X"FB6D",X"FD6B",X"F2FC",X"0CCD",X"1E07",X"1666",X"15CC",X"0D48",X"FD5E",X"FA9A",X"FB7A",X"FCE6",X"E8A0",X"E279",X"E56C",X"F190",X"EBF8",X"FF41",X"01E2",X"0A5D",X"EBC1",X"F295",X"FEAA",X"1540",X"01FF",X"FF70",X"0EAD",X"FD30",X"F8E0",X"F575",X"FC55",X"1021",X"F629",X"F1C0",X"FBDC",X"FCE1",X"F824",X"FC7B",X"F389",X"0ED1",X"F325",X"EC22",X"F4A7",X"FF9F",X"FBEA",X"112E",X"02AB",X"104F",X"0E7C",X"0623",X"08F9",X"143C",X"0A28",X"0AEC",X"01FF",X"FEF1",X"F3EE",X"ED1D",X"F7EE",X"065A",X"0214",X"124D",X"1034",X"0982",X"F5F6",X"F0FB",X"0744",X"1887",X"FB6C",X"FF8C",X"FCEC",X"FA71",X"01AF",X"04B2",X"004B",X"1271",X"F072",X"E737",X"DB8F",X"F31D",X"FF59",X"046D",X"FF8B",X"F7FF",X"EDA9",X"E89A",X"F9FB",X"032B",X"1D70",X"22CD",X"13E7",X"16CB",X"1289",X"0F84",X"1E27",X"15F1",X"0048",X"0414",X"EADB",X"F2AA",X"E8FA",X"EA93",X"F16F",X"F480",X"E1A3",X"EDE9",X"F658",X"F4AA",X"F07F",X"F62C",X"096C",X"023B",X"FBEA",X"F54F",X"FF64",X"08D9",X"133C",X"12B1",X"1A61",X"12B0",X"FF67",X"027E",X"0AF6",X"149D",X"0CC3",X"0816",X"0AEA",X"019F",X"02E9",X"0120",X"0402",X"FE3D",X"FB86",X"F378",X"FCCF",X"0C85",X"08EA",X"0E50",X"132B",X"0457",X"F452",X"F485",X"05D1",X"0054",X"F15B",X"EC71",X"F824",X"F42A",X"FA6D",X"F3B0",X"0D9E",X"0A7E",X"F31A",X"F29C",X"1583",X"0FD3",X"1098",X"0B10",X"0538",X"057C",X"F808",X"F87C",X"FD8C",X"0024",X"F90D",X"F177",X"ED73",X"F1A3",X"EED8",X"EE7C",X"FC81",X"F6DE",X"0808",X"FD2B",X"FBCC",X"FF3E",X"01D3",X"00FD",X"16DA",X"0FCE",X"0C24",X"0F7D",X"0E6D",X"1441",X"141F",X"0B1F",X"1828",X"06DC",X"F6CE",X"ECC3",X"EFCF",X"F8BB",X"03FE",X"02E9",X"0DF6",X"02A4",X"EDAF",X"F174",X"FFAB",X"018B",X"0F60",X"0903",X"00FB",X"001A",X"F62A",X"0456",X"0F6D",X"0080",X"0941",X"F763",X"EDA1",X"EC9E",X"F919",X"02BC",X"0982",X"F62F",X"F591",X"EBFE",X"EE38",X"FB82",X"0515",X"13C7",X"13B2",X"0A77",X"FFFA",X"0739",X"0B2B",X"1A64",X"11E5",X"0B14",X"0D95",X"F29D",X"EA39",X"E92D",X"F1B6",X"F57B",X"ECEC",X"EF77",X"01E6",X"FC85",X"EDEE",X"FDDB",X"086F",X"0106",X"F9B9",X"F1D7",X"F94E",X"FAC1",X"009B",X"100A",X"101B",X"05A3",X"FD99",X"FBC6",X"076C",X"074A",X"0B63",X"1185",X"120B",X"0866",X"00B1",X"0502",X"0691",X"0760",X"F088",X"FAE1",X"03E5",X"07BE",X"0C84",X"0EB6",X"1346",X"0C00",X"FF13",X"F2B6",X"032C",X"FD07",X"F769",X"E42A",X"E88B",X"EB6E",X"E38F",X"F7AF",X"FEA1",X"063C",X"00C9",X"00C7",X"060F",X"0E0A",X"009C",X"1265",X"0D32",X"FD30",X"FF4F",X"0401",X"0269",X"000D",X"FCC0",X"F9CA",X"F95C",X"E8E9",X"E757",X"EB82",X"F39C",X"F44C",X"FAD1",X"FB69",X"F320",X"F096",X"EED0",X"FDE4",X"037E",X"1299",X"175A",X"1514",X"1D34",X"151E",X"0E8B",X"1738",X"14C6",X"0E1E",X"05C1",X"F780",X"F437",X"F554",X"FBD4",X"1022",X"0BD5",X"0707",X"FB92",X"EB30",X"F185",X"F4D5",X"FD7D",X"0939",X"0529",X"F17C",X"EF81",X"F52A",X"073A",X"0644",X"085B",X"163F",X"FF0B",X"EC65",X"ED96",X"FD2F",X"0815",X"09D9",X"F965",X"F6AD",X"FA10",X"F5E3",X"FDA0",X"1002",X"1532",X"14B9",X"071B",X"FED0",X"0AC5",X"08D6",X"0F71",X"0899",X"FF27",X"F877",X"E643",X"E334",X"E4D2",X"ED7A",X"F3A5",X"0034",X"0181",X"FC3F",X"F3FF",X"F763",X"0646",X"001F",X"00F2",X"03BF",X"FFD7",X"F753",X"FF1C",X"0A19",X"134A",X"0A59",X"FBAF",X"0525",X"FBDC",X"00FE",X"FFCF",X"05CB",X"0AC8",X"FFAB",X"F7D8",X"FF09",X"0238",X"0598",X"04CF",X"0342",X"0CB7",X"063A",X"0AAE",X"157B",X"11B8",X"08CB",X"0A56",X"046D",X"038F",X"095F",X"00E0",X"F9B4",X"E739",X"E498",X"E4CA",X"F637",X"FAF7",X"FC26",X"FA19",X"FD88",X"FD8E",X"F6B3",X"020B",X"0ABE",X"082D",X"02A8",X"FDEF",X"0CA0",X"0CFF",X"FDA4",X"FE5D",X"063A",X"FBA8",X"F49D",X"EDA0",X"F140",X"F870",X"F11F",X"FC15",X"FE3F",X"FADC",X"F982",X"F0D9",X"F789",X"FE80",X"0452",X"0AEF",X"137A",X"0980",X"0C30",X"0467",X"094E",X"0FEA",X"11C5",X"10C0",X"11C0",X"F720",X"EEF3",X"F834",X"01C2",X"120A",X"09A5",X"01C6",X"FEC8",X"FA8A",X"F080",X"FDD5",X"05D1",X"05C1",X"FA68",X"E803",X"F764",X"F7C1",X"0318",X"0510",X"08DF",X"0404",X"F21A",X"E76B",X"F0F9",X"FA92",X"0692",X"0CDB",X"03DC",X"0022",X"0061",X"FCE1",X"04DE",X"1275",X"1033",X"14E1",X"108E",X"03D0",X"0C4D",X"0D48",X"09E0",X"0BF4",X"FB7E",X"F5CE",X"EAD5",X"DE0B",X"DE4D",X"E74F",X"F410",X"FCE8",X"F226",X"F25A",X"F87E",X"F4BD",X"01D9",X"0786",X"0C72",X"07C2",X"F5B1",X"F9E3",X"100E",X"0D11",X"09FA",X"09FA",X"07B3",X"096C",X"FEBB",X"09F6",X"05AE",X"0372",X"F79F",X"FFBB",X"FB66",X"FB28",X"04C2",X"FEE1",X"F856",X"F6D8",X"F727",X"016A",X"0DFE",X"0C68",X"0993",X"0D49",X"1265",X"0A6C",X"00B9",X"0F44",X"00C0",X"F118",X"E1F3",X"E5C1",X"F837",X"026E",X"FA28",X"FFBB",X"0061",X"FE92",X"F287",X"F8CA",X"0651",X"070A",X"F94B",X"FE44",X"01C1",X"01BE",X"F842",X"F99B",X"FBA3",X"01B8",X"F6D3",X"0204",X"F9DB",X"F324",X"F32A",X"FA72",X"00B4",X"FF63",X"FD2A",X"F8F1",X"F8F1",X"FB84",X"0604",X"0FE8",X"1105",X"12F0",X"05B8",X"0914",X"FECE",X"068E",X"0C22",X"0F15",X"04FC",X"FD15",X"E6ED",X"E9A6",X"F547",X"0391",X"0C11",X"0D18",X"0963",X"0344",X"F2E3",X"F508",X"05A4",X"049B",X"FD95",X"0009",X"F711",X"FA5C",X"FDAA",X"046B",X"0C6E",X"05B1",X"F9EA",X"F7E4",X"E955",X"ECC3",X"F936",X"FFAE",X"02C7",X"F618",X"F027",X"FB66",X"F483",X"0080",X"1447",X"1CEE",X"19FF",X"1011",X"FF34",X"1021",X"0997",X"053F",X"086B",X"FB2C",X"F783",X"E8FE",X"E2C2",X"E64B",X"F6FA",X"F29E",X"F710",X"F2FA",X"F1F2",X"F633",X"F68E",X"0067",X"0817",X"FF76",X"F26C",X"F851",X"0048",X"0BD5",X"03F8",X"0FB4",X"1AAA",X"0438",X"0346",X"10DA",X"0B7A",X"FD87",X"FF60",X"FB34",X"0617",X"FAC1",X"0340",X"09A7",X"0171",X"F304",X"F8A4",X"FC3E",X"08D8",X"06EC",X"022D",X"08E8",X"0492",X"FECC",X"027C",X"FCD8",X"04FB",X"F7CA",X"F0EF",X"F24A",X"F86C",X"F9D7",X"001D",X"0059",X"03ED",X"03EE",X"FCA1",X"FB88",X"0768",X"02D8",X"03E7",X"01A2",X"075A",X"FD63",X"FBD2",X"F3E8",X"FE6F",X"F5E5",X"F9E4",X"FBFF",X"FB84",X"E7CA",X"EA55",X"F002",X"F6BF",X"F977",X"0499",X"0AB2",X"0313",X"FD46",X"03DF",X"0C09",X"1312",X"0AD2",X"12BD",X"0D50",X"067C",X"03CD",X"1089",X"0D46",X"1197",X"FD8F",X"FA65",X"EA9C",X"ECE1",X"F614",X"0211",X"0B3A",X"0886",X"0160",X"FA21",X"ED72",X"F5ED",X"FEEA",X"047B",X"09D7",X"0CF3",X"F656",X"FDEE",X"058B",X"0D39",X"0760",X"05EA",X"0502",X"FC97",X"EF18",X"F3D2",X"01CA",X"01B6",X"FD25",X"F9BD",X"F882",X"FA7A",X"F641",X"FFB2",X"132E",X"10B8",X"0737",X"08AD",X"FF71",X"07AC",X"00BD",X"09A9",X"11C1",X"0396",X"F299",X"EF19",X"EB63",X"EFA0",X"F716",X"F48F",X"0212",X"FC9C",X"F9BD",X"FD3F",X"02C9",X"03B9",X"0279",X"F62F",X"F667",X"0128",X"FC8C",X"03A0",X"0AB7",X"0812",X"063C",X"FC27",X"05E3",X"0985",X"0014",X"025F",X"0B91",X"FF05",X"0263",X"0555",X"0A99",X"0A44",X"F8D8",X"F5D2",X"0372",X"01E4",X"0B41",X"0D4F",X"0DB6",X"055F",X"00E7",X"00E4",X"080C",X"FB64",X"FF9B",X"F22D",X"F44A",X"ED73",X"F123",X"F46F",X"0311",X"FBD8",X"FC66",X"0717",X"0A91",X"042E",X"04DA",X"0233",X"08EF",X"0924",X"FF6F",X"01A8",X"01A6",X"F8AC",X"0203",X"F561",X"06D1",X"FC37",X"F387",X"ECFA",X"F140",X"E852",X"F406",X"FBB3",X"055E",X"FCD4",X"F9FA",X"FA65",X"00A7",X"04C9",X"1094",X"12A8",X"1CF1",X"0F78",X"053B",X"08E0",X"1488",X"0D15",X"06F6",X"FEDD",X"FD80",X"F1E3",X"F59B",X"FC43",X"09E9",X"066C",X"0252",X"FCDE",X"F928",X"F1D4",X"F383",X"F7AA",X"04C2",X"FEAE",X"FB7F",X"F17E",X"FED9",X"FFCB",X"0511",X"0834",X"133A",X"03B9",X"FB41",X"F94F",X"F8B6",X"FE1B",X"FB12",X"FF20",X"FE42",X"FC5F",X"FBB4",X"01FF",X"08BE",X"0D1C",X"0E8A",X"07D2",X"06DF",X"FBD0",X"FEC5",X"0109",X"082A",X"01CC",X"F3DE",X"E9E7",X"ED80",X"EAC3",X"EE77",X"FED1",X"0159",X"01D8",X"FB84",X"FFF5",X"0992",X"07C1",X"FCB1",X"01CF",X"FBBE",X"FC5B",X"0107",X"067A",X"0D0D",X"0488",X"FD4E",X"0516",X"0276",X"0327",X"0211",X"031B",X"FD5A",X"F815",X"EF4B",X"00CB",X"0396",X"0242",X"0300",X"05CD",X"0333",X"0527",X"059D",X"0F17",X"115B",X"03DF",X"027F",X"0A90",X"04E4",X"09A6",X"FA4A",X"0006",X"FA63",X"F554",X"EBD2",X"F620",X"F5A1",X"FB4B",X"F4E3",X"0043",X"06FC",X"01EF",X"F476",X"FC70",X"FA6F",X"01BD",X"FFDA",X"071B",X"0C8E",X"FD0E",X"F612",X"05D1",X"0083",X"037A",X"F840",X"F8A3",X"F2D1",X"EE80",X"EB07",X"025F",X"032C",X"00FF",X"FE95",X"FECB",X"FCA1",X"028D",X"0254",X"1078",X"0CF7",X"0DA1",X"02F5",X"0333",X"0303",X"0EFC",X"0545",X"0CCD",X"080A",X"FF3D",X"F8E4",X"FC6F",X"FFAD",X"0724",X"06B9",X"03E7",X"077D",X"FBA9",X"F302",X"F96D",X"FBE2",X"0351",X"FA72",X"FB80",X"F93D",X"FAED",X"FB09",X"092C",X"045C",X"081A",X"F7A6",X"FA32",X"F6CE",X"F14D",X"FB08",X"091E",X"079A",X"FD15",X"FE46",X"0657",X"0934",X"03E3",X"0F55",X"0F8D",X"0845",X"031E",X"0172",X"0587",X"04F1",X"0488",X"F88D",X"F1B0",X"ED23",X"EA31",X"ED6B",X"F53B",X"F9B4",X"F586",X"F57F",X"FBA9",X"FFC6",X"FF06",X"0467",X"0449",X"0613",X"0030",X"FC68",X"0A68",X"0ECD",X"01AB",X"031D",X"04BF",X"0D1A",X"014E",X"04DD",X"0AEB",X"073E",X"F616",X"F65C",X"F879",X"0364",X"FAC3",X"0033",X"0569",X"013A",X"F8FA",X"FF8F",X"0679",X"0815",X"04C4",X"05B7",X"1274",X"1207",X"038A",X"06D5",X"00DE",X"01B8",X"FB04",X"FC3E",X"F3CC",X"FF70",X"F438",X"FBCA",X"FFAB",X"04D0",X"0371",X"FEC7",X"F49A",X"FD06",X"F753",X"FD98",X"031A",X"03CB",X"FBEE",X"F418",X"F562",X"0219",X"F759",X"00C4",X"0327",X"014F",X"F3A8",X"F2CA",X"F60C",X"01D3",X"FFAF",X"0154",X"0431",X"06E6",X"FCCE",X"0902",X"0B5D",X"0E3B",X"0990",X"08C2",X"04C5",X"0276",X"FBED",X"09FA",X"0059",X"0370",X"FCA7",X"F89A",X"F5FE",X"F777",X"F5D5",X"0714",X"0C39",X"0A4A",X"051D",X"FA46",X"FBA8",X"FC67",X"FB73",X"0218",X"FEEF",X"FF8F",X"FBAF",X"0000",X"0298",X"0AFD",X"02AA",X"0236",X"FE0D",X"FBF3",X"F12B",X"F269",X"FBE3",X"FF04",X"F8E0",X"F782",X"01B2",X"01F8",X"FEB0",X"0BD7",X"1538",X"117A",X"0642",X"0511",X"09B5",X"0319",X"FFC4",X"0105",X"FB01",X"F4F9",X"EC1A",X"F307",X"FC6F",X"F4BA",X"F36C",X"F2F7",X"FC44",X"FB74",X"FC5D",X"FFE0",X"046C",X"FD0A",X"F983",X"F8CA",X"FBB0",X"066D",X"01AC",X"03A7",X"0C72",X"0A45",X"0663",X"0701",X"0B97",X"07CB",X"01FD",X"F32D",X"FBE0",X"FC86",X"FE84",X"0041",X"0982",X"01F3",X"FEC5",X"F9EB",X"04A4",X"01D1",X"FE51",X"02FC",X"07BF",X"0651",X"02CC",X"FCF1",X"007C",X"F83A",X"F808",X"FFEE",X"0533",X"FB32",X"FABE",X"F968",X"0210",X"015F",X"0337",X"023C",X"02F0",X"F502",X"FAC2",X"FD88",X"0381",X"03E3",X"FF7F",X"F668",X"F8FD",X"F38F",X"FDCE",X"F8C1",X"FEA6",X"FCD0",X"F5CE",X"EB87",X"F304",X"F0E9",X"FB3E",X"07DC",X"0A77",X"09E9",X"04FB",X"04C0",X"0E2F",X"0A78",X"07B9",X"0A1C",X"0D4A",X"03C2",X"0262",X"00B9",X"0B00",X"FE94",X"FD3F",X"FB0E",X"FE32",X"F3F4",X"F55E",X"F8F2",X"039E",X"0506",X"FF49",X"FBC0",X"F9C6",X"F3C3",X"F598",X"FFF4",X"0891",X"04A6",X"FE32",X"02AE",X"0639",X"02A1",X"08B1",X"02C2",X"054C",X"FF1F",X"FA6D",X"F698",X"FB48",X"FBCB",X"F916",X"F9B8",X"FBC4",X"FD10",X"FC26",X"02C7",X"0A46",X"088C",X"035D",X"FECD",X"02EA",X"FF66",X"FC9E",X"032F",X"07D0",X"F7F9",X"F37E",X"F881",X"FB8C",X"FDEF",X"F46B",X"F5F7",X"FA75",X"FEEB",X"FECD",X"042C",X"050C",X"0211",X"F75D",X"FB6D",X"FCD2",X"FD26",X"01CE",X"03A3",X"0282",X"013E",X"0108",X"03C8",X"04B3",X"011A",X"01FB",X"044C",X"FF13",X"FF53",X"FC0A",X"0464",X"06E3",X"061F",X"FEDB",X"07A4",X"02CB",X"0010",X"024E",X"03B7",X"08BB",X"09D0",X"0251",X"0564",X"FB67",X"F8A0",X"F746",X"FD56",X"0251",X"00BD",X"F090",X"F712",X"F6BB",X"F8E5",X"00E4",X"07F6",X"0923",X"0157",X"F7D6",X"001D",X"0368",X"03BB",X"01B0",X"0006",X"F9D1",X"F956",X"F823",X"021D",X"FF95",X"FEBA",X"F5B0",X"F8BF",X"EE62",X"F06C",X"EFC2",X"FDA6",X"058A",X"0287",X"FFDB",X"0647",X"02E6",X"0451",X"054F",X"0A79",X"1510",X"0B0C",X"03D6",X"076B",X"0196",X"052D",X"FF6C",X"0236",X"0281",X"FEEC",X"F586",X"FA97",X"FDCA",X"0465",X"0300",X"FF8D",X"FC3B",X"F929",X"F1BD",X"F943",X"0000",X"FFF8",X"FBE8",X"FD3F",X"FDD6",X"009C",X"00AB",X"0CF4",X"0B90",X"0482",X"02B6",X"FEF5",X"FBFB",X"FB59",X"F89C",X"FBAB",X"0048",X"FB82",X"00D7",X"0782",X"08D1",X"0514",X"02E9",X"044F",X"FFFE",X"FE88",X"FC7E",X"FF46",X"FC74",X"FA12",X"F104",X"F71D",X"F4CF",X"F647",X"FB7C",X"FB1A",X"FD02",X"FD52",X"0672",X"03B1",X"081B",X"01C5",X"FEF9",X"FEA3",X"FE8B",X"FC37",X"0063",X"0472",X"05DA",X"FF48",X"FE19",X"0481",X"018B",X"FF16",X"FF31",X"FFB3",X"FFC6",X"F69A",X"F593",X"FCDA",X"FF33",X"FE2E",X"03AD",X"0B1C",X"0E22",X"FFBC",X"027D",X"0718",X"0805",X"0644",X"08D7",X"0865",X"02F5",X"F884",X"FCDF",X"0000",X"043C",X"0008",X"FDFD",X"F561",X"F6B5",X"F5BB",X"FBD9",X"01D5",X"0425",X"FEE1",X"F9E0",X"F680",X"FA0A",X"FEBF",X"FE64",X"071C",X"05E7",X"FB1D",X"FE35",X"FDE6",X"0393",X"FEC8",X"FC75",X"FAFE",X"FE0E",X"F025",X"F2DA",X"F87C",X"0378",X"0465",X"01EF",X"042A",X"07F7",X"FF89",X"016E",X"057F",X"07D5",X"07F9",X"04E7",X"01CD",X"FE17",X"F89B",X"03C6",X"086A",X"058C",X"03EE",X"0384",X"FA42",X"FFA0",X"FFA1",X"02A1",X"0574",X"003E",X"FBFC",X"FBA4",X"F8FF",X"FC41",X"FD5E",X"FD7A",X"FDCD",X"FD01",X"FD98",X"016F",X"FF27",X"08B1",X"0161",X"FEE4",X"0008",X"FC8F",X"F487",X"F9C3",X"0130",X"FF8D",X"021B",X"00D6",X"084F",X"0AAF",X"03AD",X"057A",X"0806",X"02B5",X"01D6",X"01E5",X"0313",X"002E",X"F52C",X"F9E3",X"F863",X"F609",X"F748",X"FD9C",X"FAD0",X"F7C1",X"F590",X"FCB9",X"0288",X"FEA6",X"00C1",X"02F2",X"06F1",X"0303",X"0012",X"00EB",X"0695",X"06AD",X"0322",X"0169",X"02E0",X"0452",X"0269",X"01C0",X"0547",X"024E",X"FCC8",X"F7C3",X"F9F5",X"FA75",X"FBC3",X"FEA3",X"0727",X"08FF",X"0212",X"FE45",X"FF61",X"0167",X"0037",X"087C",X"10D6",X"08DB",X"FF47",X"FE22",X"02D4",X"019A",X"05F6",X"0358",X"0035",X"F67D",X"F769",X"F8E5",X"0121",X"0212",X"00BB",X"FBC7",X"FA2F",X"F71B",X"F9F2",X"FD62",X"FED9",X"023F",X"FB52",X"F843",X"F9FC",X"FA1E",X"FC2D",X"0172",X"02C8",X"FFEE",X"FFA9",X"F4C1",X"F9F7",X"FCB9",X"0290",X"0600",X"083D",X"084B",X"0731",X"02E9",X"075D",X"0632",X"0485",X"08F7",X"0668",X"FD24",X"FB1A",X"F9F5",X"03BD",X"02F5",X"0003",X"0196",X"FF25",X"F74A",X"FA39",X"02EB",X"067B",X"07E1",X"0332",X"FEF8",X"0228",X"FB73",X"FC47",X"016F",X"FF13",X"FFBA",X"001F",X"0169",X"07FB",X"01DA",X"0431",X"012B",X"001F",X"FDE6",X"FB48",X"F6B4",X"FC6D",X"F9AC",X"F8A5",X"FFC0",X"FF7E",X"0387",X"03BE",X"06FA",X"0A5B",X"0709",X"031E",X"06A9",X"06E2",X"0018",X"FBD4",X"F86F",X"FD35",X"F927",X"F863",X"FE59",X"0128",X"F9B2",X"F7AC",X"F8DD",X"FCE7",X"0204",X"FE32",X"FE44",X"030F",X"FF67",X"FDAA",X"FCA3",X"FCE6",X"FF8D",X"FFEE",X"05C7",X"087A",X"03F0",X"0664",X"057C",X"0356",X"0467",X"020C",X"FF71",X"FD0F",X"FB3F",X"F958",X"014F",X"0666",X"084F",X"06A4",X"0341",X"FDEB",X"FBE2",X"FFAD",X"0368",X"0947",X"06F7",X"0131",X"FAAD",X"FC5D",X"FB20",X"FF78",X"0A82",X"06A5",X"0171",X"FB74",X"FC94",X"FDBB",X"0089",X"00C3",X"FFFC",X"FDF3",X"FC9F",X"F961",X"FC05",X"0077",X"FF49",X"FDF1",X"FCD7",X"FA65",X"F9D9",X"F8B7",X"FBE5",X"FECA",X"FC65",X"FB7E",X"FBA2",X"F4CE",X"F323",X"F9C1",X"05BF",X"0B39",X"0B54",X"0875",X"0917",X"0824",X"032B",X"0529",X"078A",X"0949",X"0361",X"FA7C",X"FD8B",X"FEE3",X"0234",X"0119",X"0160",X"FE40",X"FE3D",X"F7D6",X"FD5C",X"FFAC",X"FE8C",X"0152",X"FCDC",X"FC5B",X"FB84",X"F9B8",X"FE84",X"0494",X"012E",X"02B9",X"04F4",X"06B5",X"06B0",X"011C",X"042E",X"0355",X"0086",X"FEA7",X"00B2",X"FB28",X"FA5F",X"F872",X"FA42",X"FEE2",X"0105",X"00AE",X"0524",X"038F",X"011E",X"017F",X"0076",X"0304",X"FC17",X"FAD6",X"FFD4",X"FCD7",X"FD5D",X"FED1",X"FEC3",X"002F",X"00B1",X"FD1B",X"FB4D",X"FC23",X"FD7C",X"00E1",X"0060",X"01C4",X"0263",X"FFC7",X"FEFE",X"FA24",X"FBE9",X"FE8E",X"01A9",X"0169",X"0329",X"FE7D",X"0229",X"00CD",X"FA50",X"0195",X"04C5",X"0363",X"FEFA",X"FCD7",X"FE98",X"04E0",X"0593",X"0893",X"0891",X"0376",X"FDAE",X"FE1C",X"0439",X"067A",X"0588",X"02B4",X"015C",X"FA53",X"FBB6",X"FC50",X"02A3",X"04FC",X"0041",X"FCBE",X"FA4B",X"F88C",X"F6E0",X"FF3D",X"01A5",X"0334",X"0163",X"FF0B",X"FF6F",X"FE8F",X"FF4E",X"0026",X"002A",X"FFB1",X"FCB9",X"FA17",X"FDEC",X"FFA2",X"FCCC",X"FD46",X"FC4E",X"FBF4",X"F529",X"F4CA",X"FD4E",X"0368",X"0711",X"0622",X"05EB",X"05D8",X"007A",X"00A9",X"0897",X"0A4C",X"0759",X"02A5",X"FFD3",X"003B",X"0065",X"02A2",X"024E",X"028A",X"FEC3",X"FFD4",X"FEDB",X"FFE7",X"FE52",X"FED0",X"FE8B",X"FDB6",X"FC5D",X"FD28",X"FC20",X"FAF3",X"FF77",X"FCD6",X"FF8B",X"0131",X"0150",X"0480",X"04E8",X"05E5",X"0326",X"0395",X"028F",X"0038",X"FBCA",X"FBF0",X"FBB1",X"FC25",X"0026",X"01B9",X"0466",X"0673",X"0142",X"009E",X"0080",X"0004",X"FE62",X"FC5F",X"FA9D",X"FB81",X"F883",X"FB51",X"FE16",X"F999",X"FAEC",X"0136",X"0082",X"FFAF",X"FF06",X"00F5",X"04D7",X"0178",X"01A2",X"044C",X"026F",X"FE56",X"FB6A",X"FDAF",X"018D",X"0297",X"00BA",X"0323",X"FE38",X"00AC",X"FC28",X"FCB0",X"0164",X"0172",X"FEAA",X"FC0C",X"FBBC",X"F8FB",X"FFD5",X"061C",X"0A7D",X"0A97",X"03AD",X"009D",X"0333",X"04B7",X"04C7",X"0459",X"03CB",X"01E6",X"FA79",X"FD94",X"0244",X"030C",X"036D",X"FFDE",X"FD12",X"FB29",X"F6F4",X"F912",X"FC07",X"FC72",X"FD96",X"FD0D",X"FCD7",X"FA2E",X"F7EF",X"FE47",X"01E6",X"0219",X"001B",X"FF94",X"FD9B",X"FE78",X"FE77",X"FD3D",X"FF45",X"FDF4",X"FBCC",X"F6C8",X"FA15",X"FE99",X"0369",X"052F",X"04A4",X"041A",X"0144",X"01FC",X"004A",X"04A4",X"032A",X"00EE",X"FD26",X"FA12",X"FAD4",X"00A5",X"052C",X"0416",X"038C",X"0240",X"0485",X"00D2",X"FF7A",X"FF9F",X"FEF3",X"FE02",X"FE89",X"FE4B",X"00C8",X"FCC3",X"FBC8",X"FEC8",X"FCD6",X"FF21",X"0109",X"02AD",X"028D",X"0103",X"FEDE",X"0135",X"00FA",X"FBB9",X"FC7C",X"FC24",X"FD8A",X"FE63",X"FEBA",X"030B",X"0513",X"03D4",X"0449",X"0324",X"024C",X"0121",X"FF35",X"FE38",X"FDEC",X"FA1A",X"FC77",X"FA22",X"FC71",X"FC09",X"F9A5",X"FD79",X"003F",X"FDE7",X"FB07",X"FE52",X"FCB3",X"FBA0",X"FD7F",X"0194",X"065B",X"0356",X"FFB5",X"FF63",X"FFD4",X"010B",X"0278",X"0178",X"0453",X"FEDD",X"FDFA",X"FE63",X"FFAD",X"00AB",X"012D",X"FD92",X"FC31");
begin
 
   
 process(resetN, CLK)
	 type noteArrd is array (0 to 12) of integer;
	 variable dataTmp : noteArrd;
 begin
	if (resetN='0') then
		dataTmp := (others  => 0);
	elsif(rising_edge(CLK)) then
		dataTmp := (others  => 0);
		for i in 0 to 12 loop
			if addrArr(i) < array_size then
				if conv_integer(addrArr(i)) > 0 then
					dataTmp(i) := conv_integer(sound0(conv_integer(addrArr(i))));
				end if;
			else
				dataTmp(i) := 0;
			end if;
		end loop;
	end if;
	Q <= conv_std_logic_vector(dataTmp(0) + dataTmp(1) + dataTmp(2) + dataTmp(3) + dataTmp(4) + dataTmp(5) + dataTmp(6) + dataTmp(7) + dataTmp(8) + dataTmp(9) + dataTmp(10) + dataTmp(11) + dataTmp(12), 16);
end process;
	 

		   
end arch;