module TMS5220
  (input  I_OSC,
   input  I_ENA,
   input  I_WSn,
   input  I_RSn,
   input  I_DATA,
   input  I_TEST,
   input  [7:0] I_DBUS,
   output [7:0] O_DBUS,
   output O_RDYn,
   output O_INTn,
   output O_M0,
   output O_M1,
   output O_ADD8,
   output O_ADD4,
   output O_ADD2,
   output O_ADD1,
   output O_ROMCLK,
   output O_T11,
   output O_IO,
   output O_PRMOUT,
   output [13:0] O_SPKR);
  reg [2:0] m_ic;
  reg [3:0] m_pc;
  reg [4:0] m_t;
  reg [7:0] m_fifo_ptr;
  reg [8:0] m_pitch_count;
  reg [3:0] m_new_frame_energy_idx;
  reg [6:0] m_new_frame_pitch_idx;
  reg [49:0] m_new_frame_k_idx;
  reg [3:0] tmp_new_frame_energy_idx;
  reg [6:0] tmp_new_frame_pitch_idx;
  reg [49:0] tmp_new_frame_k_idx;
  reg [142:0] m_u;
  reg [129:0] m_x;
  reg [4:0] m_wr_busy;
  reg m_wr_srv;
  reg m_wr_data;
  reg [2:0] m_cmd_reg;
  reg m_cyca;
  reg m_rst;
  reg m_clk;
  reg m_ddis;
  reg m_ena;
  reg m_olde;
  reg m_oldp;
  reg m_rdb_clr;
  reg m_rdb_cmd;
  reg m_rdb_flag;
  reg m_rst_cmd;
  reg m_sxt_cmd;
  reg m_rsn;
  reg m_rsn_last;
  reg m_spen;
  reg m_t11;
  reg m_talk;
  reg m_talk_last;
  reg m_talkd;
  reg m_talkd_last;
  reg m_uf;
  reg m_wsn;
  reg m_wsn_last;
  reg m_wr_pending;
  reg m_buffer_empty;
  reg m_buffer_empty_last;
  reg m_buffer_low;
  reg m_buffer_low_last;
  reg m_cycb;
  reg m_inhibit;
  reg m_io_ready;
  reg m_irq_pin;
  reg m_irq_pin_clr;
  reg m_new_frame_voiced;
  reg m_new_frame_unvoiced;
  reg m_new_frame_repeat;
  reg m_new_frame_zero;
  reg m_new_frame_stop;
  reg m_pitch_zero;
  reg m_zpar;
  reg m_uv_zpar;
  reg [1:0] phictr;
  reg [3:0] m_phi;
  reg [7:0] m_wr_reg;
  reg [7:0] m_dbo;
  reg [7:0] m_dbi;
  reg [13:0] m_speech;
  reg [13:0] m_shift;
  reg [12:0] m_rng;
  reg [13:0] m_excitation_data;
  reg [13:0] m_previous_energy;
  reg [13:0] m_current_energy;
  reg [13:0] m_current_pitch;
  reg [13:0] this_sample;
  reg [99:0] m_current_k;
  reg [127:0] m_fifo;
  wire n87;
  wire n88;
  localparam n90 = 1'b1;
  localparam n91 = 1'b1;
  localparam n92 = 1'b1;
  localparam n93 = 1'b1;
  localparam n94 = 1'b1;
  localparam n95 = 1'b1;
  wire n96;
  wire n97;
  localparam n98 = 1'b1;
  wire [31:0] n100;
  wire n102;
  wire n103;
  wire [31:0] n106;
  wire n108;
  wire n109;
  wire [1:0] n114;
  wire n116;
  wire [31:0] n117;
  wire n119;
  wire [31:0] n120;
  wire [31:0] n122;
  wire [4:0] n123;
  wire [4:0] n125;
  wire [31:0] n126;
  wire n128;
  wire [31:0] n129;
  wire n131;
  wire n132;
  wire n133;
  wire [31:0] n136;
  wire n138;
  wire n139;
  wire [31:0] n140;
  wire n142;
  wire n143;
  wire [31:0] n144;
  wire n146;
  wire [31:0] n147;
  wire [31:0] n149;
  wire [2:0] n150;
  wire [2:0] n152;
  wire [31:0] n153;
  wire n155;
  wire n156;
  wire [31:0] n157;
  wire [31:0] n159;
  wire [3:0] n160;
  wire [3:0] n161;
  wire [3:0] n164;
  wire n165;
  wire n168;
  wire n169;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire n174;
  wire n183;
  wire n184;
  wire n185;
  wire n186;
  wire n187;
  wire n188;
  wire n189;
  wire n190;
  wire n191;
  wire n192;
  wire n196;
  wire n197;
  wire [31:0] n198;
  wire n200;
  wire [12:0] n201;
  wire [13:0] n203;
  wire n206;
  wire [13:0] n207;
  wire n213;
  wire n214;
  wire n215;
  wire n216;
  wire n219;
  wire n220;
  wire n221;
  wire [31:0] n222;
  wire n224;
  wire [31:0] n225;
  wire [31:0] n227;
  wire [4:0] n228;
  wire [31:0] n229;
  wire n231;
  wire [31:0] n232;
  wire n234;
  wire n235;
  wire [4:0] n238;
  wire n241;
  wire n243;
  wire [4:0] n244;
  wire n246;
  wire n247;
  wire [4:0] n248;
  wire n250;
  wire n251;
  wire [4:0] n253;
  wire n255;
  wire n256;
  wire n258;
  wire [4:0] n260;
  wire n262;
  wire n264;
  wire n266;
  wire n278;
  wire n280;
  wire n282;
  wire n288;
  wire n289;
  wire n290;
  wire n291;
  wire n292;
  wire n293;
  wire n294;
  wire n295;
  wire n296;
  wire n298;
  wire n300;
  wire n313;
  wire n314;
  wire [11:0] n315;
  wire n316;
  wire n317;
  wire n318;
  wire n319;
  wire n320;
  wire n321;
  wire n322;
  wire [12:0] n323;
  wire [12:0] n324;
  wire [12:0] n326;
  wire [31:0] n332;
  wire n334;
  wire n335;
  wire [31:0] n336;
  wire n338;
  wire n339;
  wire [31:0] n340;
  wire n342;
  wire n343;
  wire n344;
  wire n345;
  wire n346;
  wire n347;
  wire [31:0] n348;
  wire n350;
  wire n351;
  wire [31:0] n352;
  wire n354;
  wire n355;
  wire [31:0] n356;
  wire n358;
  wire n359;
  wire n360;
  wire n361;
  wire n362;
  wire n364;
  wire n366;
  wire n368;
  wire [31:0] n369;
  wire n371;
  wire n372;
  wire [31:0] n373;
  wire [31:0] n375;
  wire [31:0] n376;
  wire n377;
  wire n378;
  wire n379;
  wire [31:0] n380;
  wire [31:0] n382;
  wire [8:0] n383;
  wire [8:0] n385;
  wire n387;
  wire n389;
  wire n390;
  wire n396;
  wire n397;
  wire n398;
  wire n399;
  wire [1:0] n400;
  wire [2:0] n401;
  wire [7:0] n403;
  wire n406;
  wire n409;
  wire [7:0] n411;
  wire n414;
  wire n417;
  wire n420;
  wire [31:0] n428;
  wire n430;
  wire n431;
  wire n432;
  wire n433;
  wire n434;
  wire [13:0] n437;
  wire [31:0] n438;
  wire n440;
  wire [5:0] n441;
  wire [13:0] n447;
  wire [13:0] n449;
  wire [13:0] n450;
  wire n452;
  wire n457;
  wire n458;
  wire [31:0] n459;
  wire n461;
  wire n462;
  wire [31:0] n463;
  wire n465;
  wire n466;
  wire [31:0] n467;
  wire n469;
  wire n470;
  wire n471;
  wire n472;
  wire n473;
  wire n474;
  wire n475;
  wire n476;
  wire n477;
  wire n479;
  wire n481;
  wire n483;
  wire n489;
  wire n490;
  wire n491;
  wire n492;
  wire n493;
  wire n494;
  wire n495;
  wire n496;
  wire n497;
  wire [31:0] n498;
  wire n500;
  wire n501;
  wire [31:0] n502;
  wire n504;
  wire n505;
  wire [31:0] n506;
  wire n508;
  wire n509;
  wire n510;
  wire n511;
  wire n512;
  wire [31:0] n513;
  wire n515;
  wire n518;
  wire [31:0] n519;
  wire n521;
  wire n524;
  wire n525;
  wire n526;
  wire n528;
  wire n530;
  wire [31:0] n538;
  wire n540;
  wire n541;
  wire [31:0] n542;
  wire n544;
  wire n545;
  wire [31:0] n546;
  wire n548;
  wire n549;
  wire n550;
  wire n551;
  wire n552;
  wire n553;
  wire n554;
  wire n556;
  wire [31:0] n557;
  wire n559;
  wire [31:0] n560;
  wire n562;
  wire n563;
  wire n564;
  wire n565;
  wire n567;
  wire n568;
  wire n569;
  wire n571;
  wire n573;
  wire n574;
  wire n575;
  wire n576;
  wire n577;
  wire n578;
  wire n579;
  wire n581;
  wire [31:0] n589;
  wire n591;
  wire n592;
  wire n593;
  wire n594;
  wire n595;
  wire n596;
  wire n597;
  wire [31:0] n598;
  wire n600;
  wire n601;
  wire [31:0] n602;
  wire [31:0] n608;
  wire [31:0] n609;
  wire [31:0] n610;
  wire [11:0] n611;
  wire [30:0] n617;
  wire [11:0] n618;
  wire [31:0] n619;
  wire [31:0] n620;
  wire [13:0] n621;
  wire [13:0] n622;
  wire [13:0] n624;
  wire n626;
  wire n627;
  wire [31:0] n628;
  wire n630;
  wire n631;
  wire [31:0] n632;
  wire [5:0] n633;
  wire [31:0] n639;
  wire [31:0] n640;
  wire [31:0] n641;
  wire [11:0] n642;
  wire [30:0] n647;
  wire [11:0] n648;
  wire [31:0] n649;
  wire [31:0] n650;
  wire [13:0] n651;
  wire [13:0] n652;
  wire [13:0] n654;
  wire n656;
  wire n657;
  wire [31:0] n658;
  wire n660;
  wire n661;
  wire [31:0] n662;
  wire [31:0] n664;
  wire [3:0] n665;
  wire [3:0] n667;
  wire [31:0] n669;
  wire [31:0] n671;
  wire [3:0] n672;
  wire [3:0] n674;
  wire [31:0] n677;
  wire [31:0] n678;
  wire [31:0] n680;
  wire [3:0] n681;
  wire [3:0] n683;
  wire [31:0] n685;
  wire [31:0] n687;
  wire [3:0] n688;
  wire [3:0] n690;
  wire [4:0] n694;
  wire [31:0] n699;
  wire [31:0] n700;
  wire [31:0] n702;
  wire [3:0] n703;
  wire [3:0] n705;
  wire [31:0] n708;
  wire [31:0] n709;
  wire [11:0] n710;
  wire [30:0] n715;
  wire [11:0] n716;
  wire [31:0] n717;
  wire [31:0] n718;
  wire [9:0] n719;
  wire [99:0] n721;
  wire n724;
  wire n725;
  wire n726;
  wire [31:0] n727;
  wire [31:0] n729;
  wire [3:0] n730;
  wire [3:0] n732;
  wire n736;
  wire [31:0] n737;
  wire n739;
  wire n740;
  wire [31:0] n741;
  wire [31:0] n743;
  wire [3:0] n744;
  wire [3:0] n746;
  wire [31:0] n748;
  wire [31:0] n750;
  wire [3:0] n751;
  wire [3:0] n753;
  wire [31:0] n756;
  wire [31:0] n757;
  wire [31:0] n759;
  wire [3:0] n760;
  wire [3:0] n762;
  wire [31:0] n764;
  wire [31:0] n766;
  wire [3:0] n767;
  wire [3:0] n769;
  wire [4:0] n773;
  wire [31:0] n777;
  wire [31:0] n778;
  wire [31:0] n780;
  wire [3:0] n781;
  wire [3:0] n783;
  wire [31:0] n786;
  wire [31:0] n787;
  wire [11:0] n788;
  wire [30:0] n793;
  wire [11:0] n794;
  wire [31:0] n795;
  wire [31:0] n796;
  wire [9:0] n797;
  wire [99:0] n799;
  wire [99:0] n800;
  wire n803;
  wire n804;
  wire n805;
  wire [3:0] n806;
  reg [13:0] n807;
  reg [13:0] n808;
  reg [99:0] n809;
  wire [13:0] n810;
  wire [13:0] n811;
  wire [99:0] n812;
  wire [13:0] n814;
  wire [13:0] n816;
  wire [99:0] n817;
  wire n827;
  wire n828;
  wire n829;
  wire [31:0] n830;
  wire [31:0] n831;
  wire [31:0] n832;
  wire [21:0] n833;
  wire [21:0] n835;
  wire [12:0] n837;
  wire n839;
  wire [12:0] n840;
  wire [31:0] n841;
  wire [9:0] n842;
  wire [31:0] n843;
  wire [12:0] n844;
  wire [31:0] n845;
  wire [31:0] n846;
  wire [21:0] n847;
  wire [21:0] n849;
  wire [31:0] n850;
  wire [31:0] n851;
  wire [12:0] n852;
  wire n854;
  wire [12:0] n855;
  wire [31:0] n856;
  wire [9:0] n857;
  wire [31:0] n858;
  wire [12:0] n859;
  wire [31:0] n860;
  wire [31:0] n861;
  wire [21:0] n862;
  wire [21:0] n864;
  wire [31:0] n865;
  wire [31:0] n866;
  wire [12:0] n867;
  wire n869;
  wire [12:0] n870;
  wire [31:0] n871;
  wire [9:0] n872;
  wire [31:0] n873;
  wire [12:0] n874;
  wire [31:0] n875;
  wire [31:0] n876;
  wire [21:0] n877;
  wire [21:0] n879;
  wire [31:0] n880;
  wire [31:0] n881;
  wire [12:0] n882;
  wire [12:0] n883;
  wire [31:0] n884;
  wire [9:0] n885;
  wire [31:0] n886;
  wire [12:0] n887;
  wire [31:0] n888;
  wire [31:0] n889;
  wire [21:0] n890;
  wire [21:0] n892;
  wire [31:0] n893;
  wire [31:0] n894;
  wire [12:0] n895;
  wire n897;
  wire [12:0] n898;
  wire [31:0] n899;
  wire [9:0] n900;
  wire [31:0] n901;
  wire [12:0] n902;
  wire [31:0] n903;
  wire [31:0] n904;
  wire [21:0] n905;
  wire [21:0] n907;
  wire [31:0] n908;
  wire [31:0] n909;
  wire [12:0] n910;
  wire [12:0] n911;
  wire [31:0] n912;
  wire [9:0] n913;
  wire [31:0] n914;
  wire [12:0] n915;
  wire [31:0] n916;
  wire [31:0] n917;
  wire [21:0] n918;
  wire [21:0] n920;
  wire [31:0] n921;
  wire [31:0] n922;
  wire [12:0] n923;
  wire n925;
  wire [12:0] n926;
  wire [31:0] n927;
  wire [9:0] n928;
  wire [31:0] n929;
  wire [12:0] n930;
  wire [31:0] n931;
  wire [31:0] n932;
  wire [21:0] n933;
  wire [21:0] n935;
  wire [31:0] n936;
  wire [31:0] n937;
  wire [12:0] n938;
  wire [12:0] n939;
  wire [31:0] n940;
  wire [9:0] n941;
  wire [31:0] n942;
  wire [12:0] n943;
  wire [31:0] n944;
  wire [31:0] n945;
  wire [21:0] n946;
  wire [21:0] n948;
  wire [31:0] n949;
  wire [31:0] n950;
  wire [12:0] n951;
  wire n953;
  wire [12:0] n954;
  wire [31:0] n955;
  wire [9:0] n956;
  wire [31:0] n957;
  wire [12:0] n958;
  wire [31:0] n959;
  wire [31:0] n960;
  wire [21:0] n961;
  wire [21:0] n963;
  wire [31:0] n964;
  wire [31:0] n965;
  wire [12:0] n966;
  wire [12:0] n967;
  wire [31:0] n968;
  wire [9:0] n969;
  wire [31:0] n970;
  wire [12:0] n971;
  wire [31:0] n972;
  wire [31:0] n973;
  wire [21:0] n974;
  wire [21:0] n976;
  wire [31:0] n977;
  wire [31:0] n978;
  wire [12:0] n979;
  wire n981;
  wire [12:0] n982;
  wire [31:0] n983;
  wire [9:0] n984;
  wire [31:0] n985;
  wire [12:0] n986;
  wire [31:0] n987;
  wire [31:0] n988;
  wire [21:0] n989;
  wire [21:0] n991;
  wire [31:0] n992;
  wire [31:0] n993;
  wire [12:0] n994;
  wire [12:0] n995;
  wire [31:0] n996;
  wire [9:0] n997;
  wire [31:0] n998;
  wire [12:0] n999;
  wire [31:0] n1000;
  wire [31:0] n1001;
  wire [21:0] n1002;
  wire [21:0] n1004;
  wire [31:0] n1005;
  wire [31:0] n1006;
  wire [12:0] n1007;
  wire n1009;
  wire [12:0] n1010;
  wire [31:0] n1011;
  wire [9:0] n1012;
  wire [31:0] n1013;
  wire [12:0] n1014;
  wire [31:0] n1015;
  wire [31:0] n1016;
  wire [21:0] n1017;
  wire [21:0] n1019;
  wire [31:0] n1020;
  wire [31:0] n1021;
  wire [12:0] n1022;
  wire [12:0] n1023;
  wire [31:0] n1024;
  wire [9:0] n1025;
  wire [31:0] n1026;
  wire [12:0] n1027;
  wire [31:0] n1028;
  wire [31:0] n1029;
  wire [21:0] n1030;
  wire [21:0] n1032;
  wire [31:0] n1033;
  wire [31:0] n1034;
  wire [12:0] n1035;
  wire n1037;
  wire [12:0] n1038;
  wire [31:0] n1039;
  wire [9:0] n1040;
  wire [31:0] n1041;
  wire [12:0] n1042;
  wire [31:0] n1043;
  wire [31:0] n1044;
  wire [21:0] n1045;
  wire [21:0] n1047;
  wire [31:0] n1048;
  wire [31:0] n1049;
  wire [12:0] n1050;
  wire [12:0] n1051;
  wire [31:0] n1052;
  wire [9:0] n1053;
  wire [31:0] n1054;
  wire [12:0] n1055;
  wire [31:0] n1056;
  wire [31:0] n1057;
  wire [21:0] n1058;
  wire [21:0] n1060;
  wire [31:0] n1061;
  wire [31:0] n1062;
  wire [12:0] n1063;
  wire n1065;
  wire [12:0] n1066;
  wire [31:0] n1067;
  wire [9:0] n1068;
  wire [31:0] n1069;
  wire [12:0] n1070;
  wire [31:0] n1071;
  wire [31:0] n1072;
  wire [21:0] n1073;
  wire [21:0] n1075;
  wire [31:0] n1076;
  wire [31:0] n1077;
  wire [12:0] n1078;
  wire [12:0] n1079;
  wire [31:0] n1080;
  wire [9:0] n1081;
  wire [31:0] n1082;
  wire [12:0] n1083;
  wire [31:0] n1084;
  wire [31:0] n1085;
  wire [21:0] n1086;
  wire [21:0] n1088;
  wire [31:0] n1089;
  wire [31:0] n1090;
  wire [12:0] n1091;
  wire n1093;
  wire [12:0] n1094;
  wire [31:0] n1095;
  wire [9:0] n1096;
  wire [31:0] n1097;
  wire [12:0] n1098;
  wire [31:0] n1099;
  wire [31:0] n1100;
  wire [21:0] n1101;
  wire [21:0] n1103;
  wire [31:0] n1104;
  wire [31:0] n1105;
  wire [12:0] n1106;
  wire [12:0] n1107;
  wire [12:0] n1108;
  wire [13:0] n1109;
  wire n1111;
  wire [11:0] n1112;
  wire [12:0] n1113;
  reg [12:0] n1114;
  wire [12:0] n1115;
  reg [12:0] n1116;
  wire [12:0] n1117;
  reg [12:0] n1118;
  wire [12:0] n1119;
  reg [12:0] n1120;
  wire [12:0] n1121;
  reg [12:0] n1122;
  wire [12:0] n1123;
  reg [12:0] n1124;
  wire [12:0] n1125;
  reg [12:0] n1126;
  wire [12:0] n1127;
  reg [12:0] n1128;
  wire [12:0] n1129;
  reg [12:0] n1130;
  wire [12:0] n1131;
  reg [12:0] n1132;
  wire [12:0] n1133;
  reg [12:0] n1134;
  wire [12:0] n1135;
  reg [12:0] n1136;
  wire [12:0] n1137;
  reg [12:0] n1138;
  wire [12:0] n1139;
  reg [12:0] n1140;
  wire [12:0] n1141;
  reg [12:0] n1142;
  wire [12:0] n1143;
  reg [12:0] n1144;
  wire [12:0] n1145;
  reg [12:0] n1146;
  wire [12:0] n1147;
  reg [12:0] n1148;
  wire [12:0] n1149;
  reg [12:0] n1150;
  wire [12:0] n1151;
  reg [12:0] n1152;
  wire [12:0] n1153;
  reg [12:0] n1154;
  reg [13:0] n1155;
  reg [13:0] n1156;
  wire [142:0] n1157;
  wire [142:0] n1158;
  wire [129:0] n1159;
  wire [129:0] n1160;
  wire [13:0] n1161;
  wire [13:0] n1162;
  wire [142:0] n1164;
  wire [129:0] n1166;
  wire [13:0] n1168;
  wire [13:0] n1169;
  wire n1181;
  wire n1182;
  wire n1183;
  wire n1184;
  wire n1185;
  wire [2:0] n1186;
  wire n1188;
  wire n1189;
  wire n1191;
  wire n1193;
  wire n1195;
  wire n1197;
  wire n1199;
  wire n1201;
  wire n1203;
  wire n1205;
  wire [7:0] n1206;
  reg n1209;
  reg n1212;
  reg n1215;
  wire n1217;
  wire n1220;
  wire n1223;
  wire n1225;
  wire n1236;
  wire n1237;
  wire n1238;
  wire n1240;
  wire n1242;
  wire [31:0] n1250;
  wire n1252;
  wire n1253;
  wire [31:0] n1254;
  wire n1256;
  wire n1257;
  wire [31:0] n1258;
  wire n1260;
  wire n1261;
  wire n1262;
  wire n1263;
  wire n1264;
  wire n1265;
  wire n1266;
  wire [31:0] n1267;
  wire n1269;
  wire n1270;
  wire [31:0] n1271;
  wire n1273;
  wire n1274;
  wire n1275;
  wire [31:0] n1276;
  wire n1278;
  wire n1279;
  wire n1280;
  wire [31:0] n1281;
  wire n1283;
  wire n1284;
  wire n1285;
  wire n1288;
  wire n1289;
  wire n1291;
  wire n1297;
  wire n1299;
  wire n1300;
  wire n1301;
  wire n1302;
  wire n1303;
  wire n1304;
  wire [31:0] n1305;
  wire n1307;
  wire n1308;
  wire [31:0] n1309;
  wire n1311;
  wire n1312;
  wire n1313;
  wire n1315;
  wire n1317;
  wire [31:0] n1318;
  wire n1320;
  wire n1321;
  wire [31:0] n1322;
  wire n1324;
  wire n1325;
  wire [31:0] n1326;
  wire n1328;
  wire n1329;
  wire n1330;
  wire n1331;
  wire n1332;
  wire n1333;
  wire [31:0] n1334;
  wire n1336;
  wire [31:0] n1337;
  wire n1339;
  wire n1340;
  wire [31:0] n1341;
  wire n1343;
  wire n1344;
  wire n1347;
  wire n1349;
  wire n1350;
  wire n1358;
  wire n1360;
  wire n1361;
  wire n1362;
  wire n1363;
  wire n1364;
  wire n1365;
  wire n1366;
  wire n1367;
  wire n1368;
  wire [1:0] n1369;
  wire n1370;
  wire [2:0] n1371;
  wire n1372;
  wire [3:0] n1373;
  wire n1374;
  wire [4:0] n1375;
  wire n1376;
  wire [5:0] n1377;
  wire n1378;
  wire [6:0] n1379;
  wire n1380;
  wire [7:0] n1381;
  wire [7:0] n1382;
  wire n1383;
  wire n1385;
  wire [7:0] n1387;
  wire n1388;
  wire [7:0] n1389;
  wire [127:0] n1391;
  wire n1392;
  wire n1394;
  wire n1395;
  wire n1396;
  wire n1397;
  wire n1398;
  wire n1399;
  wire [31:0] n1400;
  wire n1402;
  wire n1403;
  wire [31:0] n1404;
  wire n1406;
  wire n1407;
  wire n1408;
  wire [31:0] n1409;
  wire n1411;
  wire n1412;
  wire [31:0] n1413;
  wire n1415;
  wire n1416;
  wire n1417;
  wire n1418;
  wire n1419;
  wire n1420;
  wire [31:0] n1421;
  wire n1423;
  wire [31:0] n1424;
  wire [31:0] n1426;
  wire [7:0] n1427;
  wire [123:0] n1428;
  wire [127:0] n1430;
  wire [3:0] n1431;
  wire [3:0] n1433;
  wire n1435;
  wire [3:0] n1436;
  wire n1438;
  wire n1440;
  wire n1442;
  wire n1445;
  wire n1446;
  wire n1448;
  wire n1449;
  wire [7:0] n1450;
  wire [3:0] n1451;
  wire n1454;
  wire n1455;
  wire n1456;
  wire n1457;
  wire [127:0] n1458;
  wire n1460;
  wire n1461;
  wire n1462;
  wire n1463;
  wire [31:0] n1464;
  wire n1466;
  wire [31:0] n1467;
  wire [31:0] n1469;
  wire [31:0] n1471;
  wire [7:0] n1472;
  wire [120:0] n1473;
  wire [127:0] n1475;
  wire n1476;
  wire [5:0] n1477;
  wire [6:0] n1479;
  wire [5:0] n1480;
  wire n1482;
  wire n1484;
  wire n1486;
  wire [7:0] n1487;
  wire [6:0] n1488;
  wire n1491;
  wire n1492;
  wire n1493;
  wire n1494;
  wire [127:0] n1495;
  wire n1496;
  wire n1497;
  wire n1499;
  wire n1500;
  wire n1501;
  wire n1502;
  wire n1503;
  wire n1505;
  wire n1506;
  wire n1507;
  wire n1508;
  wire [31:0] n1509;
  wire [31:0] n1510;
  wire [31:0] n1512;
  wire [3:0] n1513;
  wire [31:0] n1519;
  wire [31:0] n1521;
  wire n1522;
  wire [31:0] n1523;
  wire [31:0] n1524;
  wire [31:0] n1526;
  wire [3:0] n1527;
  wire [31:0] n1532;
  wire [31:0] n1533;
  wire [7:0] n1534;
  wire [31:0] n1535;
  wire [31:0] n1537;
  wire [3:0] n1538;
  wire [122:0] n1543;
  wire [127:0] n1545;
  wire [31:0] n1546;
  wire [31:0] n1548;
  wire [3:0] n1549;
  wire [3:0] n1551;
  wire [4:0] n1553;
  wire n1557;
  wire [123:0] n1558;
  wire [127:0] n1560;
  wire [31:0] n1561;
  wire [31:0] n1563;
  wire [3:0] n1564;
  wire [3:0] n1566;
  wire [3:0] n1568;
  wire [4:0] n1570;
  wire n1573;
  wire [124:0] n1574;
  wire [127:0] n1576;
  wire [31:0] n1577;
  wire [31:0] n1579;
  wire [3:0] n1580;
  wire [3:0] n1582;
  wire [2:0] n1584;
  wire [4:0] n1586;
  wire [1:0] n1588;
  reg [49:0] n1589;
  reg [127:0] n1590;
  wire [7:0] n1591;
  wire [49:0] n1592;
  wire n1595;
  wire [127:0] n1596;
  wire n1597;
  wire n1598;
  wire n1600;
  wire n1601;
  wire n1604;
  wire n1605;
  wire n1606;
  wire n1607;
  wire n1608;
  wire [31:0] n1609;
  wire [31:0] n1610;
  wire [31:0] n1612;
  wire [3:0] n1613;
  wire [31:0] n1618;
  wire [31:0] n1620;
  wire n1621;
  wire [31:0] n1622;
  wire [31:0] n1623;
  wire [31:0] n1625;
  wire [3:0] n1626;
  wire [31:0] n1631;
  wire [31:0] n1632;
  wire [7:0] n1633;
  wire [31:0] n1634;
  wire [31:0] n1636;
  wire [3:0] n1637;
  wire [122:0] n1642;
  wire [127:0] n1644;
  wire [31:0] n1645;
  wire [31:0] n1647;
  wire [3:0] n1648;
  wire [3:0] n1650;
  wire [4:0] n1652;
  wire n1656;
  wire [123:0] n1657;
  wire [127:0] n1659;
  wire [31:0] n1660;
  wire [31:0] n1662;
  wire [3:0] n1663;
  wire [3:0] n1665;
  wire [3:0] n1667;
  wire [4:0] n1669;
  wire n1672;
  wire [124:0] n1673;
  wire [127:0] n1675;
  wire [31:0] n1676;
  wire [31:0] n1678;
  wire [3:0] n1679;
  wire [3:0] n1681;
  wire [2:0] n1683;
  wire [4:0] n1685;
  wire [1:0] n1687;
  reg [49:0] n1688;
  reg [127:0] n1689;
  wire [7:0] n1690;
  wire [49:0] n1691;
  wire n1694;
  wire [127:0] n1695;
  wire n1696;
  wire n1697;
  wire n1699;
  wire n1700;
  wire n1703;
  wire n1704;
  wire n1705;
  wire [4:0] n1706;
  wire [4:0] n1707;
  wire [4:0] n1708;
  wire [4:0] n1709;
  wire [4:0] n1710;
  wire [4:0] n1711;
  wire [4:0] n1712;
  wire [4:0] n1713;
  wire [4:0] n1714;
  wire [4:0] n1715;
  wire n1717;
  wire [4:0] n1718;
  reg [7:0] n1719;
  reg [3:0] n1720;
  reg [6:0] n1721;
  wire [4:0] n1722;
  reg [4:0] n1723;
  wire [4:0] n1724;
  reg [4:0] n1725;
  wire [4:0] n1726;
  reg [4:0] n1727;
  wire [4:0] n1728;
  reg [4:0] n1729;
  wire [4:0] n1730;
  reg [4:0] n1731;
  wire [4:0] n1732;
  reg [4:0] n1733;
  wire [4:0] n1734;
  reg [4:0] n1735;
  wire [4:0] n1736;
  reg [4:0] n1737;
  wire [4:0] n1738;
  reg [4:0] n1739;
  wire [4:0] n1740;
  reg [4:0] n1741;
  reg [3:0] n1742;
  reg [6:0] n1743;
  reg [49:0] n1744;
  reg n1746;
  reg n1748;
  reg n1750;
  reg n1751;
  reg n1753;
  reg n1755;
  reg [127:0] n1756;
  wire [6:0] n1763;
  wire [6:0] n1765;
  wire [31:0] n1768;
  wire [31:0] n1770;
  wire [7:0] n1771;
  wire [7:0] n1772;
  wire n1774;
  wire [127:0] n1775;
  wire [7:0] n1776;
  wire [3:0] n1777;
  wire [6:0] n1778;
  wire [49:0] n1779;
  wire [49:0] n1780;
  wire [3:0] n1781;
  wire [6:0] n1782;
  wire [49:0] n1783;
  wire n1785;
  wire n1786;
  wire n1787;
  wire n1788;
  wire n1789;
  wire n1790;
  wire n1791;
  wire [127:0] n1792;
  wire [7:0] n1793;
  wire [3:0] n1795;
  wire [6:0] n1797;
  wire [49:0] n1799;
  wire [3:0] n1800;
  wire [6:0] n1801;
  wire [49:0] n1803;
  wire n1805;
  wire n1807;
  wire n1808;
  wire n1809;
  wire n1810;
  wire n1811;
  wire n1812;
  wire [127:0] n1813;
  wire [3:0] n1849;
  wire [2:0] n1850;
  reg [2:0] n1851;
  wire [3:0] n1852;
  reg [3:0] n1853;
  wire [4:0] n1854;
  reg [4:0] n1855;
  wire [7:0] n1856;
  reg [7:0] n1857;
  wire [8:0] n1858;
  reg [8:0] n1859;
  wire [3:0] n1860;
  reg [3:0] n1861;
  wire [6:0] n1862;
  reg [6:0] n1863;
  wire [49:0] n1864;
  reg [49:0] n1865;
  wire [3:0] n1866;
  reg [3:0] n1867;
  wire [6:0] n1868;
  reg [6:0] n1869;
  wire [49:0] n1870;
  reg [49:0] n1871;
  wire [142:0] n1872;
  reg [142:0] n1873;
  wire [129:0] n1874;
  reg [129:0] n1875;
  wire [4:0] n1876;
  reg [4:0] n1877;
  wire n1878;
  reg n1879;
  wire n1880;
  reg n1881;
  wire [2:0] n1882;
  reg [2:0] n1883;
  wire n1884;
  reg n1885;
  wire n1886;
  reg n1887;
  wire n1888;
  reg n1889;
  wire n1890;
  reg n1891;
  wire n1892;
  reg n1893;
  wire n1894;
  reg n1895;
  wire n1896;
  reg n1897;
  wire n1898;
  reg n1899;
  wire n1900;
  reg n1901;
  wire n1902;
  reg n1903;
  wire n1904;
  reg n1905;
  wire n1906;
  reg n1907;
  wire n1908;
  reg n1909;
  wire n1910;
  reg n1911;
  wire n1912;
  reg n1913;
  wire n1914;
  reg n1915;
  wire n1916;
  reg n1917;
  wire n1918;
  reg n1919;
  wire n1920;
  reg n1921;
  wire n1922;
  reg n1923;
  wire n1924;
  reg n1925;
  wire n1926;
  reg n1927;
  wire n1928;
  reg n1929;
  wire n1930;
  reg n1931;
  wire n1932;
  reg n1933;
  wire n1934;
  reg n1935;
  wire n1936;
  reg n1937;
  wire n1938;
  reg n1939;
  wire n1940;
  reg n1941;
  wire n1942;
  reg n1943;
  wire n1944;
  reg n1945;
  wire n1946;
  reg n1947;
  wire n1948;
  reg n1949;
  wire n1950;
  reg n1951;
  wire [1:0] n1952;
  reg [1:0] n1953;
  wire [7:0] n1954;
  reg [7:0] n1955;
  wire [7:0] n1956;
  reg [7:0] n1957;
  wire [13:0] n1958;
  reg [13:0] n1959;
  wire [12:0] n1960;
  reg [12:0] n1961;
  wire [13:0] n1962;
  reg [13:0] n1963;
  wire [13:0] n1964;
  reg [13:0] n1965;
  wire [13:0] n1966;
  reg [13:0] n1967;
  wire [13:0] n1968;
  reg [13:0] n1969;
  wire [13:0] n1970;
  reg [13:0] n1971;
  wire [99:0] n1972;
  reg [99:0] n1973;
  wire [127:0] n1974;
  reg [127:0] n1975;
  wire [6:0] n1978; // mem_rd
  wire [6:0] n1981; // mem_rd
  wire [1:0] n1984; // mem_rd
  wire [1:0] n1985; // mem_rd
  wire [1:0] n1986; // mem_rd
  wire [1:0] n1987; // mem_rd
  wire [7:0] n1990; // mem_rd
  wire [8:0] n1992;
  wire [9:0] n1993; // mem_rd
  wire [8:0] n1994;
  wire [9:0] n1995; // mem_rd
  wire [2:0] n1998; // mem_rd
  wire [2:0] n1999; // mem_rd
  wire [2:0] n2000; // mem_rd
  wire [2:0] n2001; // mem_rd
  wire [2:0] n2002; // mem_rd
  wire [2:0] n2003; // mem_rd
  wire [159:0] n2005;
  wire [9:0] n2006;
  wire [79:0] n2008;
  wire [4:0] n2009;
  wire [159:0] n2011;
  wire [9:0] n2012;
  wire n2013;
  wire n2014;
  wire n2015;
  wire n2016;
  wire n2017;
  wire n2018;
  wire n2019;
  wire n2020;
  wire n2021;
  wire n2022;
  wire n2023;
  wire n2024;
  wire n2025;
  wire n2026;
  wire n2027;
  wire n2028;
  wire n2029;
  wire n2030;
  wire n2031;
  wire n2032;
  wire n2033;
  wire n2034;
  wire n2035;
  wire n2036;
  wire n2037;
  wire n2038;
  wire [9:0] n2039;
  wire [9:0] n2040;
  wire [9:0] n2041;
  wire [9:0] n2042;
  wire [9:0] n2043;
  wire [9:0] n2044;
  wire [9:0] n2045;
  wire [9:0] n2046;
  wire [9:0] n2047;
  wire [9:0] n2048;
  wire [9:0] n2049;
  wire [9:0] n2050;
  wire [9:0] n2051;
  wire [9:0] n2052;
  wire [9:0] n2053;
  wire [9:0] n2054;
  wire [9:0] n2055;
  wire [9:0] n2056;
  wire [9:0] n2057;
  wire [9:0] n2058;
  wire [99:0] n2059;
  wire n2060;
  wire n2061;
  wire n2062;
  wire n2063;
  wire n2064;
  wire n2065;
  wire n2066;
  wire n2067;
  wire n2068;
  wire n2069;
  wire n2070;
  wire n2071;
  wire n2072;
  wire n2073;
  wire n2074;
  wire n2075;
  wire n2076;
  wire n2077;
  wire n2078;
  wire n2079;
  wire n2080;
  wire n2081;
  wire n2082;
  wire n2083;
  wire n2084;
  wire n2085;
  wire [9:0] n2086;
  wire [9:0] n2087;
  wire [9:0] n2088;
  wire [9:0] n2089;
  wire [9:0] n2090;
  wire [9:0] n2091;
  wire [9:0] n2092;
  wire [9:0] n2093;
  wire [9:0] n2094;
  wire [9:0] n2095;
  wire [9:0] n2096;
  wire [9:0] n2097;
  wire [9:0] n2098;
  wire [9:0] n2099;
  wire [9:0] n2100;
  wire [9:0] n2101;
  wire [9:0] n2102;
  wire [9:0] n2103;
  wire [9:0] n2104;
  wire [9:0] n2105;
  wire [99:0] n2106;
  wire [159:0] n2108;
  wire [9:0] n2109;
  wire [79:0] n2111;
  wire [4:0] n2112;
  wire [159:0] n2114;
  wire [9:0] n2115;
  wire n2116;
  wire n2117;
  wire n2118;
  wire n2119;
  wire n2120;
  wire n2121;
  wire n2122;
  wire n2123;
  wire n2124;
  wire n2125;
  wire n2126;
  wire n2127;
  wire n2128;
  wire n2129;
  wire n2130;
  wire n2131;
  wire n2132;
  wire n2133;
  wire n2134;
  wire n2135;
  wire n2136;
  wire n2137;
  wire n2138;
  wire n2139;
  wire n2140;
  wire n2141;
  wire [9:0] n2142;
  wire [9:0] n2143;
  wire [9:0] n2144;
  wire [9:0] n2145;
  wire [9:0] n2146;
  wire [9:0] n2147;
  wire [9:0] n2148;
  wire [9:0] n2149;
  wire [9:0] n2150;
  wire [9:0] n2151;
  wire [9:0] n2152;
  wire [9:0] n2153;
  wire [9:0] n2154;
  wire [9:0] n2155;
  wire [9:0] n2156;
  wire [9:0] n2157;
  wire [9:0] n2158;
  wire [9:0] n2159;
  wire [9:0] n2160;
  wire [9:0] n2161;
  wire [99:0] n2162;
  wire n2163;
  wire n2164;
  wire n2165;
  wire n2166;
  wire n2167;
  wire n2168;
  wire n2169;
  wire n2170;
  wire n2171;
  wire n2172;
  wire n2173;
  wire n2174;
  wire n2175;
  wire n2176;
  wire n2177;
  wire n2178;
  wire n2179;
  wire n2180;
  wire n2181;
  wire n2182;
  wire n2183;
  wire n2184;
  wire n2185;
  wire n2186;
  wire n2187;
  wire n2188;
  wire [4:0] n2189;
  wire [4:0] n2190;
  wire [4:0] n2191;
  wire [4:0] n2192;
  wire [4:0] n2193;
  wire [4:0] n2194;
  wire [4:0] n2195;
  wire [4:0] n2196;
  wire [4:0] n2197;
  wire [4:0] n2198;
  wire [4:0] n2199;
  wire [4:0] n2200;
  wire [4:0] n2201;
  wire [4:0] n2202;
  wire [4:0] n2203;
  wire [4:0] n2204;
  wire [4:0] n2205;
  wire [4:0] n2206;
  wire [4:0] n2207;
  wire [4:0] n2208;
  wire [49:0] n2209;
  wire n2210;
  wire n2211;
  wire n2212;
  wire n2213;
  wire n2214;
  wire n2215;
  wire n2216;
  wire n2217;
  wire n2218;
  wire n2219;
  wire n2220;
  wire n2221;
  wire n2222;
  wire n2223;
  wire n2224;
  wire n2225;
  wire n2226;
  wire n2227;
  wire n2228;
  wire n2229;
  wire n2230;
  wire n2231;
  wire n2232;
  wire n2233;
  wire n2234;
  wire n2235;
  wire [4:0] n2236;
  wire [4:0] n2237;
  wire [4:0] n2238;
  wire [4:0] n2239;
  wire [4:0] n2240;
  wire [4:0] n2241;
  wire [4:0] n2242;
  wire [4:0] n2243;
  wire [4:0] n2244;
  wire [4:0] n2245;
  wire [4:0] n2246;
  wire [4:0] n2247;
  wire [4:0] n2248;
  wire [4:0] n2249;
  wire [4:0] n2250;
  wire [4:0] n2251;
  wire [4:0] n2252;
  wire [4:0] n2253;
  wire [4:0] n2254;
  wire [4:0] n2255;
  wire [49:0] n2256;
  wire n2257;
  wire n2258;
  wire n2259;
  wire n2260;
  wire n2261;
  wire n2262;
  wire n2263;
  wire n2264;
  wire n2265;
  wire n2266;
  wire n2267;
  wire n2268;
  wire n2269;
  wire n2270;
  wire n2271;
  wire n2272;
  wire n2273;
  wire n2274;
  wire n2275;
  wire n2276;
  wire n2277;
  wire n2278;
  wire n2279;
  wire n2280;
  wire n2281;
  wire n2282;
  wire [4:0] n2283;
  wire [4:0] n2284;
  wire [4:0] n2285;
  wire [4:0] n2286;
  wire [4:0] n2287;
  wire [4:0] n2288;
  wire [4:0] n2289;
  wire [4:0] n2290;
  wire [4:0] n2291;
  wire [4:0] n2292;
  wire [4:0] n2293;
  wire [4:0] n2294;
  wire [4:0] n2295;
  wire [4:0] n2296;
  wire [4:0] n2297;
  wire [4:0] n2298;
  wire [4:0] n2299;
  wire [4:0] n2300;
  wire [4:0] n2301;
  wire [4:0] n2302;
  wire [49:0] n2303;
  wire n2304;
  wire n2305;
  wire n2306;
  wire n2307;
  wire n2308;
  wire n2309;
  wire n2310;
  wire n2311;
  wire n2312;
  wire n2313;
  wire n2314;
  wire n2315;
  wire n2316;
  wire n2317;
  wire n2318;
  wire n2319;
  wire n2320;
  wire n2321;
  wire n2322;
  wire n2323;
  wire n2324;
  wire n2325;
  wire n2326;
  wire n2327;
  wire n2328;
  wire n2329;
  wire [4:0] n2330;
  wire [4:0] n2331;
  wire [4:0] n2332;
  wire [4:0] n2333;
  wire [4:0] n2334;
  wire [4:0] n2335;
  wire [4:0] n2336;
  wire [4:0] n2337;
  wire [4:0] n2338;
  wire [4:0] n2339;
  wire [4:0] n2340;
  wire [4:0] n2341;
  wire [4:0] n2342;
  wire [4:0] n2343;
  wire [4:0] n2344;
  wire [4:0] n2345;
  wire [4:0] n2346;
  wire [4:0] n2347;
  wire [4:0] n2348;
  wire [4:0] n2349;
  wire [49:0] n2350;
  wire n2351;
  wire n2352;
  wire n2353;
  wire n2354;
  wire n2355;
  wire n2356;
  wire n2357;
  wire n2358;
  wire n2359;
  wire n2360;
  wire n2361;
  wire n2362;
  wire n2363;
  wire n2364;
  wire n2365;
  wire n2366;
  wire n2367;
  wire n2368;
  wire n2369;
  wire n2370;
  wire n2371;
  wire n2372;
  wire n2373;
  wire n2374;
  wire n2375;
  wire n2376;
  wire [4:0] n2377;
  wire [4:0] n2378;
  wire [4:0] n2379;
  wire [4:0] n2380;
  wire [4:0] n2381;
  wire [4:0] n2382;
  wire [4:0] n2383;
  wire [4:0] n2384;
  wire [4:0] n2385;
  wire [4:0] n2386;
  wire [4:0] n2387;
  wire [4:0] n2388;
  wire [4:0] n2389;
  wire [4:0] n2390;
  wire [4:0] n2391;
  wire [4:0] n2392;
  wire [4:0] n2393;
  wire [4:0] n2394;
  wire [4:0] n2395;
  wire [4:0] n2396;
  wire [49:0] n2397;
  wire n2398;
  wire n2399;
  wire n2400;
  wire n2401;
  wire n2402;
  wire n2403;
  wire n2404;
  wire n2405;
  wire n2406;
  wire n2407;
  wire n2408;
  wire n2409;
  wire n2410;
  wire n2411;
  wire n2412;
  wire n2413;
  wire n2414;
  wire n2415;
  wire n2416;
  wire n2417;
  wire n2418;
  wire n2419;
  wire n2420;
  wire n2421;
  wire n2422;
  wire n2423;
  wire [4:0] n2424;
  wire [4:0] n2425;
  wire [4:0] n2426;
  wire [4:0] n2427;
  wire [4:0] n2428;
  wire [4:0] n2429;
  wire [4:0] n2430;
  wire [4:0] n2431;
  wire [4:0] n2432;
  wire [4:0] n2433;
  wire [4:0] n2434;
  wire [4:0] n2435;
  wire [4:0] n2436;
  wire [4:0] n2437;
  wire [4:0] n2438;
  wire [4:0] n2439;
  wire [4:0] n2440;
  wire [4:0] n2441;
  wire [4:0] n2442;
  wire [4:0] n2443;
  wire [49:0] n2444;
  wire n2445;
  wire n2446;
  wire n2447;
  wire n2448;
  wire n2449;
  wire n2450;
  wire n2451;
  wire n2452;
  wire n2453;
  wire n2454;
  wire n2455;
  wire n2456;
  wire n2457;
  wire n2458;
  wire n2459;
  wire n2460;
  wire n2461;
  wire n2462;
  wire n2463;
  wire n2464;
  wire n2465;
  wire n2466;
  wire n2467;
  wire n2468;
  wire n2469;
  wire n2470;
  wire n2471;
  wire n2472;
  wire n2473;
  wire n2474;
  wire n2475;
  wire n2476;
  wire n2477;
  wire n2478;
  wire n2479;
  wire n2480;
  wire n2481;
  wire n2482;
  wire n2483;
  wire n2484;
  wire n2485;
  wire n2486;
  wire n2487;
  wire n2488;
  wire n2489;
  wire n2490;
  wire n2491;
  wire n2492;
  wire n2493;
  wire n2494;
  wire n2495;
  wire n2496;
  wire n2497;
  wire n2498;
  wire n2499;
  wire n2500;
  wire n2501;
  wire n2502;
  wire n2503;
  wire n2504;
  wire n2505;
  wire n2506;
  wire n2507;
  wire n2508;
  wire n2509;
  wire n2510;
  wire n2511;
  wire n2512;
  wire n2513;
  wire n2514;
  wire n2515;
  wire n2516;
  wire n2517;
  wire n2518;
  wire n2519;
  wire n2520;
  wire n2521;
  wire n2522;
  wire n2523;
  wire n2524;
  wire n2525;
  wire n2526;
  wire n2527;
  wire n2528;
  wire n2529;
  wire n2530;
  wire n2531;
  wire n2532;
  wire n2533;
  wire n2534;
  wire n2535;
  wire n2536;
  wire n2537;
  wire n2538;
  wire n2539;
  wire n2540;
  wire n2541;
  wire n2542;
  wire n2543;
  wire n2544;
  wire n2545;
  wire n2546;
  wire n2547;
  wire n2548;
  wire n2549;
  wire n2550;
  wire n2551;
  wire n2552;
  wire n2553;
  wire n2554;
  wire n2555;
  wire n2556;
  wire n2557;
  wire n2558;
  wire n2559;
  wire n2560;
  wire n2561;
  wire n2562;
  wire n2563;
  wire n2564;
  wire n2565;
  wire n2566;
  wire n2567;
  wire n2568;
  wire n2569;
  wire n2570;
  wire n2571;
  wire n2572;
  wire n2573;
  wire n2574;
  wire n2575;
  wire n2576;
  wire n2577;
  wire n2578;
  wire n2579;
  wire n2580;
  wire n2581;
  wire n2582;
  wire n2583;
  wire n2584;
  wire n2585;
  wire n2586;
  wire n2587;
  wire n2588;
  wire n2589;
  wire n2590;
  wire n2591;
  wire n2592;
  wire n2593;
  wire n2594;
  wire n2595;
  wire n2596;
  wire n2597;
  wire n2598;
  wire n2599;
  wire n2600;
  wire n2601;
  wire n2602;
  wire n2603;
  wire n2604;
  wire n2605;
  wire n2606;
  wire n2607;
  wire n2608;
  wire n2609;
  wire n2610;
  wire n2611;
  wire n2612;
  wire n2613;
  wire n2614;
  wire n2615;
  wire n2616;
  wire n2617;
  wire n2618;
  wire n2619;
  wire n2620;
  wire n2621;
  wire n2622;
  wire n2623;
  wire n2624;
  wire n2625;
  wire n2626;
  wire n2627;
  wire n2628;
  wire n2629;
  wire n2630;
  wire n2631;
  wire n2632;
  wire n2633;
  wire n2634;
  wire n2635;
  wire n2636;
  wire n2637;
  wire n2638;
  wire n2639;
  wire n2640;
  wire n2641;
  wire n2642;
  wire n2643;
  wire n2644;
  wire n2645;
  wire n2646;
  wire n2647;
  wire n2648;
  wire n2649;
  wire n2650;
  wire n2651;
  wire n2652;
  wire n2653;
  wire n2654;
  wire n2655;
  wire n2656;
  wire n2657;
  wire n2658;
  wire n2659;
  wire n2660;
  wire n2661;
  wire n2662;
  wire n2663;
  wire n2664;
  wire n2665;
  wire n2666;
  wire n2667;
  wire n2668;
  wire n2669;
  wire n2670;
  wire n2671;
  wire n2672;
  wire n2673;
  wire n2674;
  wire n2675;
  wire n2676;
  wire n2677;
  wire n2678;
  wire n2679;
  wire n2680;
  wire n2681;
  wire n2682;
  wire n2683;
  wire n2684;
  wire n2685;
  wire n2686;
  wire n2687;
  wire n2688;
  wire n2689;
  wire n2690;
  wire n2691;
  wire n2692;
  wire n2693;
  wire n2694;
  wire n2695;
  wire n2696;
  wire n2697;
  wire n2698;
  wire n2699;
  wire [7:0] n2700;
  wire [7:0] n2701;
  wire n2702;
  wire n2703;
  wire [6:0] n2704;
  wire [7:0] n2705;
  wire [7:0] n2706;
  wire n2707;
  wire n2708;
  wire [6:0] n2709;
  wire [7:0] n2710;
  wire [7:0] n2711;
  wire n2712;
  wire n2713;
  wire [6:0] n2714;
  wire [7:0] n2715;
  wire [7:0] n2716;
  wire n2717;
  wire n2718;
  wire [6:0] n2719;
  wire [7:0] n2720;
  wire [7:0] n2721;
  wire n2722;
  wire n2723;
  wire [6:0] n2724;
  wire [7:0] n2725;
  wire [7:0] n2726;
  wire n2727;
  wire n2728;
  wire [6:0] n2729;
  wire [7:0] n2730;
  wire [7:0] n2731;
  wire n2732;
  wire n2733;
  wire [6:0] n2734;
  wire [7:0] n2735;
  wire [7:0] n2736;
  wire n2737;
  wire n2738;
  wire [6:0] n2739;
  wire [7:0] n2740;
  wire [7:0] n2741;
  wire n2742;
  wire n2743;
  wire [6:0] n2744;
  wire [7:0] n2745;
  wire [7:0] n2746;
  wire n2747;
  wire n2748;
  wire [6:0] n2749;
  wire [7:0] n2750;
  wire [7:0] n2751;
  wire n2752;
  wire n2753;
  wire [6:0] n2754;
  wire [7:0] n2755;
  wire [7:0] n2756;
  wire n2757;
  wire n2758;
  wire [6:0] n2759;
  wire [7:0] n2760;
  wire [7:0] n2761;
  wire n2762;
  wire n2763;
  wire [6:0] n2764;
  wire [7:0] n2765;
  wire [7:0] n2766;
  wire n2767;
  wire n2768;
  wire [6:0] n2769;
  wire [7:0] n2770;
  wire [7:0] n2771;
  wire n2772;
  wire n2773;
  wire [6:0] n2774;
  wire [7:0] n2775;
  wire [7:0] n2776;
  wire n2777;
  wire n2778;
  wire [6:0] n2779;
  wire [7:0] n2780;
  wire [7:0] n2781;
  wire n2782;
  wire n2783;
  wire [6:0] n2784;
  wire [7:0] n2785;
  wire [7:0] n2786;
  wire n2787;
  wire n2788;
  wire [6:0] n2789;
  wire [7:0] n2790;
  wire [7:0] n2791;
  wire n2792;
  wire n2793;
  wire [6:0] n2794;
  wire [7:0] n2795;
  wire [7:0] n2796;
  wire n2797;
  wire n2798;
  wire [6:0] n2799;
  wire [7:0] n2800;
  wire [7:0] n2801;
  wire n2802;
  wire n2803;
  wire [6:0] n2804;
  wire [7:0] n2805;
  wire [7:0] n2806;
  wire n2807;
  wire n2808;
  wire [6:0] n2809;
  wire [7:0] n2810;
  wire [7:0] n2811;
  wire n2812;
  wire n2813;
  wire [6:0] n2814;
  wire [7:0] n2815;
  wire [7:0] n2816;
  wire n2817;
  wire n2818;
  wire [6:0] n2819;
  wire [7:0] n2820;
  wire [7:0] n2821;
  wire n2822;
  wire n2823;
  wire [6:0] n2824;
  wire [7:0] n2825;
  wire [7:0] n2826;
  wire n2827;
  wire n2828;
  wire [6:0] n2829;
  wire [7:0] n2830;
  wire [7:0] n2831;
  wire n2832;
  wire n2833;
  wire [6:0] n2834;
  wire [7:0] n2835;
  wire [7:0] n2836;
  wire n2837;
  wire n2838;
  wire [6:0] n2839;
  wire [7:0] n2840;
  wire [7:0] n2841;
  wire n2842;
  wire n2843;
  wire [6:0] n2844;
  wire [7:0] n2845;
  wire [7:0] n2846;
  wire n2847;
  wire n2848;
  wire [6:0] n2849;
  wire [7:0] n2850;
  wire [7:0] n2851;
  wire n2852;
  wire n2853;
  wire [6:0] n2854;
  wire [7:0] n2855;
  wire [7:0] n2856;
  wire n2857;
  wire n2858;
  wire [6:0] n2859;
  wire [7:0] n2860;
  wire [7:0] n2861;
  wire n2862;
  wire n2863;
  wire [6:0] n2864;
  wire [7:0] n2865;
  wire [7:0] n2866;
  wire n2867;
  wire n2868;
  wire [6:0] n2869;
  wire [7:0] n2870;
  wire [7:0] n2871;
  wire n2872;
  wire n2873;
  wire [6:0] n2874;
  wire [7:0] n2875;
  wire [7:0] n2876;
  wire n2877;
  wire n2878;
  wire [6:0] n2879;
  wire [7:0] n2880;
  wire [7:0] n2881;
  wire n2882;
  wire n2883;
  wire [6:0] n2884;
  wire [7:0] n2885;
  wire [7:0] n2886;
  wire n2887;
  wire n2888;
  wire [6:0] n2889;
  wire [7:0] n2890;
  wire [7:0] n2891;
  wire n2892;
  wire n2893;
  wire [6:0] n2894;
  wire [7:0] n2895;
  wire [7:0] n2896;
  wire n2897;
  wire n2898;
  wire [6:0] n2899;
  wire [7:0] n2900;
  wire [7:0] n2901;
  wire n2902;
  wire n2903;
  wire [6:0] n2904;
  wire [7:0] n2905;
  wire [7:0] n2906;
  wire n2907;
  wire n2908;
  wire [6:0] n2909;
  wire [7:0] n2910;
  wire [7:0] n2911;
  wire n2912;
  wire n2913;
  wire [6:0] n2914;
  wire [7:0] n2915;
  wire [7:0] n2916;
  wire n2917;
  wire n2918;
  wire [6:0] n2919;
  wire [7:0] n2920;
  wire [7:0] n2921;
  wire n2922;
  wire n2923;
  wire [6:0] n2924;
  wire [7:0] n2925;
  wire [7:0] n2926;
  wire n2927;
  wire n2928;
  wire [6:0] n2929;
  wire [7:0] n2930;
  wire [7:0] n2931;
  wire n2932;
  wire n2933;
  wire [6:0] n2934;
  wire [7:0] n2935;
  wire [7:0] n2936;
  wire n2937;
  wire n2938;
  wire [6:0] n2939;
  wire [7:0] n2940;
  wire [7:0] n2941;
  wire n2942;
  wire n2943;
  wire [6:0] n2944;
  wire [7:0] n2945;
  wire [7:0] n2946;
  wire n2947;
  wire n2948;
  wire [6:0] n2949;
  wire [7:0] n2950;
  wire [7:0] n2951;
  wire n2952;
  wire n2953;
  wire [6:0] n2954;
  wire [7:0] n2955;
  wire [7:0] n2956;
  wire n2957;
  wire n2958;
  wire [6:0] n2959;
  wire [7:0] n2960;
  wire [7:0] n2961;
  wire n2962;
  wire n2963;
  wire [6:0] n2964;
  wire [7:0] n2965;
  wire [7:0] n2966;
  wire n2967;
  wire n2968;
  wire [6:0] n2969;
  wire [7:0] n2970;
  wire [7:0] n2971;
  wire n2972;
  wire n2973;
  wire [6:0] n2974;
  wire [7:0] n2975;
  wire [7:0] n2976;
  wire n2977;
  wire n2978;
  wire [6:0] n2979;
  wire [7:0] n2980;
  wire [7:0] n2981;
  wire n2982;
  wire n2983;
  wire [6:0] n2984;
  wire [7:0] n2985;
  wire [7:0] n2986;
  wire n2987;
  wire n2988;
  wire [6:0] n2989;
  wire [7:0] n2990;
  wire [7:0] n2991;
  wire n2992;
  wire n2993;
  wire [6:0] n2994;
  wire [7:0] n2995;
  wire [7:0] n2996;
  wire n2997;
  wire n2998;
  wire [6:0] n2999;
  wire [7:0] n3000;
  wire [7:0] n3001;
  wire n3002;
  wire n3003;
  wire [6:0] n3004;
  wire [7:0] n3005;
  wire [7:0] n3006;
  wire n3007;
  wire n3008;
  wire [6:0] n3009;
  wire [7:0] n3010;
  wire [7:0] n3011;
  wire n3012;
  wire n3013;
  wire [6:0] n3014;
  wire [7:0] n3015;
  wire [7:0] n3016;
  wire n3017;
  wire n3018;
  wire [6:0] n3019;
  wire [7:0] n3020;
  wire [7:0] n3021;
  wire n3022;
  wire n3023;
  wire [6:0] n3024;
  wire [7:0] n3025;
  wire [7:0] n3026;
  wire n3027;
  wire n3028;
  wire [6:0] n3029;
  wire [7:0] n3030;
  wire [7:0] n3031;
  wire n3032;
  wire n3033;
  wire [6:0] n3034;
  wire [7:0] n3035;
  wire [7:0] n3036;
  wire n3037;
  wire n3038;
  wire [6:0] n3039;
  wire [7:0] n3040;
  wire [7:0] n3041;
  wire n3042;
  wire n3043;
  wire [6:0] n3044;
  wire [7:0] n3045;
  wire [7:0] n3046;
  wire n3047;
  wire n3048;
  wire [6:0] n3049;
  wire [7:0] n3050;
  wire [7:0] n3051;
  wire n3052;
  wire n3053;
  wire [6:0] n3054;
  wire [7:0] n3055;
  wire [7:0] n3056;
  wire n3057;
  wire n3058;
  wire [6:0] n3059;
  wire [7:0] n3060;
  wire [7:0] n3061;
  wire n3062;
  wire n3063;
  wire [6:0] n3064;
  wire [7:0] n3065;
  wire [7:0] n3066;
  wire n3067;
  wire n3068;
  wire [6:0] n3069;
  wire [7:0] n3070;
  wire [7:0] n3071;
  wire n3072;
  wire n3073;
  wire [6:0] n3074;
  wire [7:0] n3075;
  wire [7:0] n3076;
  wire n3077;
  wire n3078;
  wire [6:0] n3079;
  wire [7:0] n3080;
  wire [7:0] n3081;
  wire n3082;
  wire n3083;
  wire [6:0] n3084;
  wire [7:0] n3085;
  wire [7:0] n3086;
  wire n3087;
  wire n3088;
  wire [6:0] n3089;
  wire [7:0] n3090;
  wire [7:0] n3091;
  wire n3092;
  wire n3093;
  wire [6:0] n3094;
  wire [7:0] n3095;
  wire [7:0] n3096;
  wire n3097;
  wire n3098;
  wire [6:0] n3099;
  wire [7:0] n3100;
  wire [7:0] n3101;
  wire n3102;
  wire n3103;
  wire [6:0] n3104;
  wire [7:0] n3105;
  wire [7:0] n3106;
  wire n3107;
  wire n3108;
  wire [6:0] n3109;
  wire [7:0] n3110;
  wire [7:0] n3111;
  wire n3112;
  wire n3113;
  wire [6:0] n3114;
  wire [7:0] n3115;
  wire [7:0] n3116;
  wire n3117;
  wire n3118;
  wire [6:0] n3119;
  wire [7:0] n3120;
  wire [7:0] n3121;
  wire n3122;
  wire n3123;
  wire [6:0] n3124;
  wire [7:0] n3125;
  wire [7:0] n3126;
  wire n3127;
  wire n3128;
  wire [6:0] n3129;
  wire [7:0] n3130;
  wire [7:0] n3131;
  wire n3132;
  wire n3133;
  wire [6:0] n3134;
  wire [7:0] n3135;
  wire [7:0] n3136;
  wire n3137;
  wire n3138;
  wire [6:0] n3139;
  wire [7:0] n3140;
  wire [7:0] n3141;
  wire n3142;
  wire n3143;
  wire [6:0] n3144;
  wire [7:0] n3145;
  wire [7:0] n3146;
  wire n3147;
  wire n3148;
  wire [6:0] n3149;
  wire [7:0] n3150;
  wire [7:0] n3151;
  wire n3152;
  wire n3153;
  wire [6:0] n3154;
  wire [7:0] n3155;
  wire [7:0] n3156;
  wire n3157;
  wire n3158;
  wire [6:0] n3159;
  wire [7:0] n3160;
  wire [7:0] n3161;
  wire n3162;
  wire n3163;
  wire [6:0] n3164;
  wire [7:0] n3165;
  wire [7:0] n3166;
  wire n3167;
  wire n3168;
  wire [6:0] n3169;
  wire [7:0] n3170;
  wire [7:0] n3171;
  wire n3172;
  wire n3173;
  wire [6:0] n3174;
  wire [7:0] n3175;
  wire [7:0] n3176;
  wire n3177;
  wire n3178;
  wire [6:0] n3179;
  wire [7:0] n3180;
  wire [7:0] n3181;
  wire n3182;
  wire n3183;
  wire [6:0] n3184;
  wire [7:0] n3185;
  wire [7:0] n3186;
  wire n3187;
  wire n3188;
  wire [6:0] n3189;
  wire [7:0] n3190;
  wire [7:0] n3191;
  wire n3192;
  wire n3193;
  wire [6:0] n3194;
  wire [7:0] n3195;
  wire [7:0] n3196;
  wire n3197;
  wire n3198;
  wire [6:0] n3199;
  wire [7:0] n3200;
  wire [7:0] n3201;
  wire n3202;
  wire n3203;
  wire [6:0] n3204;
  wire [7:0] n3205;
  wire [7:0] n3206;
  wire n3207;
  wire n3208;
  wire [6:0] n3209;
  wire [7:0] n3210;
  wire [7:0] n3211;
  wire n3212;
  wire n3213;
  wire [6:0] n3214;
  wire [7:0] n3215;
  wire [7:0] n3216;
  wire n3217;
  wire n3218;
  wire [6:0] n3219;
  wire [7:0] n3220;
  wire [7:0] n3221;
  wire n3222;
  wire n3223;
  wire [6:0] n3224;
  wire [7:0] n3225;
  wire [7:0] n3226;
  wire n3227;
  wire n3228;
  wire [6:0] n3229;
  wire [7:0] n3230;
  wire [7:0] n3231;
  wire n3232;
  wire n3233;
  wire [6:0] n3234;
  wire [7:0] n3235;
  wire [7:0] n3236;
  wire n3237;
  wire n3238;
  wire [6:0] n3239;
  wire [7:0] n3240;
  wire [7:0] n3241;
  wire n3242;
  wire n3243;
  wire [6:0] n3244;
  wire [7:0] n3245;
  wire [7:0] n3246;
  wire n3247;
  wire n3248;
  wire [6:0] n3249;
  wire [7:0] n3250;
  wire [7:0] n3251;
  wire n3252;
  wire n3253;
  wire [6:0] n3254;
  wire [7:0] n3255;
  wire [7:0] n3256;
  wire n3257;
  wire n3258;
  wire [6:0] n3259;
  wire [7:0] n3260;
  wire [7:0] n3261;
  wire n3262;
  wire n3263;
  wire [6:0] n3264;
  wire [7:0] n3265;
  wire [7:0] n3266;
  wire n3267;
  wire n3268;
  wire [6:0] n3269;
  wire [7:0] n3270;
  wire [7:0] n3271;
  wire n3272;
  wire n3273;
  wire [6:0] n3274;
  wire [7:0] n3275;
  wire [7:0] n3276;
  wire n3277;
  wire n3278;
  wire [6:0] n3279;
  wire [7:0] n3280;
  wire [7:0] n3281;
  wire n3282;
  wire n3283;
  wire [6:0] n3284;
  wire [7:0] n3285;
  wire [7:0] n3286;
  wire n3287;
  wire n3288;
  wire [6:0] n3289;
  wire [7:0] n3290;
  wire [7:0] n3291;
  wire n3292;
  wire n3293;
  wire [6:0] n3294;
  wire [7:0] n3295;
  wire [7:0] n3296;
  wire n3297;
  wire n3298;
  wire [6:0] n3299;
  wire [7:0] n3300;
  wire [7:0] n3301;
  wire [127:0] n3302;
  assign O_DBUS = m_dbo; //(module output)
  assign O_RDYn = n87; //(module output)
  assign O_INTn = n88; //(module output)
  assign O_M0 = n90; //(module output)
  assign O_M1 = n91; //(module output)
  assign O_ADD8 = n92; //(module output)
  assign O_ADD4 = n93; //(module output)
  assign O_ADD2 = n94; //(module output)
  assign O_ADD1 = n95; //(module output)
  assign O_ROMCLK = n96; //(module output)
  assign O_T11 = m_t11; //(module output)
  assign O_IO = n97; //(module output)
  assign O_PRMOUT = n98; //(module output)
  assign O_SPKR = this_sample; //(module output)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:138:16 */
  always @*
    m_ic = n1851; // (isignal)
  initial
    m_ic = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:139:16 */
  always @*
    m_pc = n1853; // (isignal)
  initial
    m_pc = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:140:16 */
  always @*
    m_t = n1855; // (isignal)
  initial
    m_t = 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:141:16 */
  always @*
    m_fifo_ptr = n1857; // (isignal)
  initial
    m_fifo_ptr = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:142:16 */
  always @*
    m_pitch_count = n1859; // (isignal)
  initial
    m_pitch_count = 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:145:16 */
  always @*
    m_new_frame_energy_idx = n1861; // (isignal)
  initial
    m_new_frame_energy_idx = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:146:16 */
  always @*
    m_new_frame_pitch_idx = n1863; // (isignal)
  initial
    m_new_frame_pitch_idx = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  always @*
    m_new_frame_k_idx = n1865; // (isignal)
  initial
    m_new_frame_k_idx = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:149:16 */
  always @*
    tmp_new_frame_energy_idx = n1867; // (isignal)
  initial
    tmp_new_frame_energy_idx = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:150:16 */
  always @*
    tmp_new_frame_pitch_idx = n1869; // (isignal)
  initial
    tmp_new_frame_pitch_idx = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:151:16 */
  always @*
    tmp_new_frame_k_idx = n1871; // (isignal)
  initial
    tmp_new_frame_k_idx = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  always @*
    m_u = n1873; // (isignal)
  initial
    m_u = 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  always @*
    m_x = n1875; // (isignal)
  initial
    m_x = 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:162:16 */
  always @*
    m_wr_busy = n1877; // (isignal)
  initial
    m_wr_busy = 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:163:16 */
  always @*
    m_wr_srv = n1879; // (isignal)
  initial
    m_wr_srv = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:164:16 */
  always @*
    m_wr_data = n1881; // (isignal)
  initial
    m_wr_data = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:165:16 */
  always @*
    m_cmd_reg = n1883; // (isignal)
  initial
    m_cmd_reg = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:168:17 */
  always @*
    m_cyca = n1885; // (isignal)
  initial
    m_cyca = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:169:17 */
  always @*
    m_rst = n216; // (isignal)
  initial
    m_rst = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:172:17 */
  always @*
    m_clk = I_OSC; // (isignal)
  initial
    m_clk = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:173:17 */
  always @*
    m_ddis = n1887; // (isignal)
  initial
    m_ddis = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:174:17 */
  always @*
    m_ena = I_ENA; // (isignal)
  initial
    m_ena = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:175:17 */
  always @*
    m_olde = n1889; // (isignal)
  initial
    m_olde = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:176:17 */
  always @*
    m_oldp = n1891; // (isignal)
  initial
    m_oldp = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:177:17 */
  always @*
    m_rdb_clr = n1893; // (isignal)
  initial
    m_rdb_clr = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:178:17 */
  always @*
    m_rdb_cmd = n1895; // (isignal)
  initial
    m_rdb_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:179:17 */
  always @*
    m_rdb_flag = n1897; // (isignal)
  initial
    m_rdb_flag = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:180:17 */
  always @*
    m_rst_cmd = n1899; // (isignal)
  initial
    m_rst_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:181:17 */
  always @*
    m_sxt_cmd = n1901; // (isignal)
  initial
    m_sxt_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:182:17 */
  always @*
    m_rsn = I_RSn; // (isignal)
  initial
    m_rsn = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:183:17 */
  always @*
    m_rsn_last = n1903; // (isignal)
  initial
    m_rsn_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:184:17 */
  always @*
    m_spen = n1905; // (isignal)
  initial
    m_spen = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:185:17 */
  always @*
    m_t11 = n1907; // (isignal)
  initial
    m_t11 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:186:17 */
  always @*
    m_talk = n1909; // (isignal)
  initial
    m_talk = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:187:17 */
  always @*
    m_talk_last = n1911; // (isignal)
  initial
    m_talk_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:188:17 */
  always @*
    m_talkd = n1913; // (isignal)
  initial
    m_talkd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:189:17 */
  always @*
    m_talkd_last = n1915; // (isignal)
  initial
    m_talkd_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:190:17 */
  always @*
    m_uf = n1917; // (isignal)
  initial
    m_uf = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:191:17 */
  always @*
    m_wsn = I_WSn; // (isignal)
  initial
    m_wsn = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:192:17 */
  always @*
    m_wsn_last = n1919; // (isignal)
  initial
    m_wsn_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:193:17 */
  always @*
    m_wr_pending = n1921; // (isignal)
  initial
    m_wr_pending = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:194:17 */
  always @*
    m_buffer_empty = n109; // (isignal)
  initial
    m_buffer_empty = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:195:17 */
  always @*
    m_buffer_empty_last = n1923; // (isignal)
  initial
    m_buffer_empty_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:196:17 */
  always @*
    m_buffer_low = n103; // (isignal)
  initial
    m_buffer_low = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:197:17 */
  always @*
    m_buffer_low_last = n1925; // (isignal)
  initial
    m_buffer_low_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:198:17 */
  always @*
    m_cycb = n1927; // (isignal)
  initial
    m_cycb = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:199:17 */
  always @*
    m_inhibit = n1929; // (isignal)
  initial
    m_inhibit = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:200:17 */
  always @*
    m_io_ready = n1931; // (isignal)
  initial
    m_io_ready = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:201:17 */
  always @*
    m_irq_pin = n1933; // (isignal)
  initial
    m_irq_pin = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:202:17 */
  always @*
    m_irq_pin_clr = n1935; // (isignal)
  initial
    m_irq_pin_clr = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:203:17 */
  always @*
    m_new_frame_voiced = n1937; // (isignal)
  initial
    m_new_frame_voiced = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:204:17 */
  always @*
    m_new_frame_unvoiced = n1939; // (isignal)
  initial
    m_new_frame_unvoiced = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:205:17 */
  always @*
    m_new_frame_repeat = n1941; // (isignal)
  initial
    m_new_frame_repeat = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:206:17 */
  always @*
    m_new_frame_zero = n1943; // (isignal)
  initial
    m_new_frame_zero = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:207:17 */
  always @*
    m_new_frame_stop = n1945; // (isignal)
  initial
    m_new_frame_stop = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:208:17 */
  always @*
    m_pitch_zero = n1947; // (isignal)
  initial
    m_pitch_zero = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:209:17 */
  always @*
    m_zpar = n1949; // (isignal)
  initial
    m_zpar = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:210:17 */
  always @*
    m_uv_zpar = n1951; // (isignal)
  initial
    m_uv_zpar = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:213:17 */
  always @*
    phictr = n1953; // (isignal)
  initial
    phictr = 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:216:17 */
  always @*
    m_phi = n1849; // (isignal)
  initial
    m_phi = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:219:17 */
  always @*
    m_wr_reg = n1955; // (isignal)
  initial
    m_wr_reg = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:220:17 */
  always @*
    m_dbo = n1957; // (isignal)
  initial
    m_dbo = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:221:17 */
  always @*
    m_dbi = I_DBUS; // (isignal)
  initial
    m_dbi = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:224:17 */
  always @*
    m_speech = this_sample; // (isignal)
  initial
    m_speech = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:227:17 */
  always @*
    m_shift = n1959; // (isignal)
  initial
    m_shift = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:230:17 */
  always @*
    m_rng = n1961; // (isignal)
  initial
    m_rng = 13'b1111111111111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:233:17 */
  always @*
    m_excitation_data = n1963; // (isignal)
  initial
    m_excitation_data = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:234:17 */
  always @*
    m_previous_energy = n1965; // (isignal)
  initial
    m_previous_energy = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:235:17 */
  always @*
    m_current_energy = n1967; // (isignal)
  initial
    m_current_energy = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:236:17 */
  always @*
    m_current_pitch = n1969; // (isignal)
  initial
    m_current_pitch = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:237:17 */
  always @*
    this_sample = n1971; // (isignal)
  initial
    this_sample = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:240:17 */
  always @*
    m_current_k = n1973; // (isignal)
  initial
    m_current_k = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:243:17 */
  always @*
    m_fifo = n1975; // (isignal)
  initial
    m_fifo = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:255:21 */
  assign n87 = ~m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:256:21 */
  assign n88 = ~m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:268:26 */
  assign n96 = m_phi[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:270:28 */
  assign n97 = m_shift[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:274:47 */
  assign n100 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:274:47 */
  assign n102 = $signed(n100) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:274:31 */
  assign n103 = n102 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:275:47 */
  assign n106 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:275:47 */
  assign n108 = n106 == 32'b00000000000000000000000010000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:275:31 */
  assign n109 = n108 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:282:50 */
  assign n114 = phictr + 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:283:44 */
  assign n116 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:285:49 */
  assign n117 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:285:49 */
  assign n119 = n117 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:60 */
  assign n120 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:60 */
  assign n122 = n120 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:56 */
  assign n123 = n122[4:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:285:41 */
  assign n125 = n119 ? 5'b00001 : n123;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:292:49 */
  assign n126 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:292:49 */
  assign n128 = n126 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:292:65 */
  assign n129 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:292:65 */
  assign n131 = n129 != 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:292:55 */
  assign n132 = n131 & n128;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:293:59 */
  assign n133 = ~m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:298:68 */
  assign n136 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:298:68 */
  assign n138 = n136 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:298:59 */
  assign n139 = n138 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:298:84 */
  assign n140 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:298:84 */
  assign n142 = n140 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:298:74 */
  assign n143 = n142 & n139;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:301:58 */
  assign n144 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:301:58 */
  assign n146 = n144 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:304:71 */
  assign n147 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:304:71 */
  assign n149 = n147 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:304:65 */
  assign n150 = n149[2:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:301:49 */
  assign n152 = n146 ? 3'b000 : n150;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:71 */
  assign n153 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:71 */
  assign n155 = n153 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:62 */
  assign n156 = n155 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:307:62 */
  assign n157 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:307:62 */
  assign n159 = n157 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:307:57 */
  assign n160 = n159[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:41 */
  assign n161 = n156 ? n160 : m_pc;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:298:41 */
  assign n164 = n143 ? 4'b0000 : n161;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:283:33 */
  assign n165 = n143 & n116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:283:33 */
  assign n168 = n132 & n116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:283:33 */
  assign n169 = n132 & n116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:281:25 */
  assign n170 = n165 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:281:25 */
  assign n171 = n116 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:281:25 */
  assign n172 = n116 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:281:25 */
  assign n173 = n168 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:281:25 */
  assign n174 = n169 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:315:32 */
  assign n183 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:316:32 */
  assign n184 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:316:22 */
  assign n185 = ~n184;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:317:32 */
  assign n186 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:317:46 */
  assign n187 = phictr[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:317:37 */
  assign n188 = n186 | n187;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:318:32 */
  assign n189 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:318:22 */
  assign n190 = ~n189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:318:46 */
  assign n191 = phictr[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:318:37 */
  assign n192 = n190 | n191;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:331:26 */
  assign n196 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:331:30 */
  assign n197 = ~n196;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:33 */
  assign n198 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:33 */
  assign n200 = n198 == 32'b00000000000000000000000000001011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:338:57 */
  assign n201 = m_shift[13:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:338:48 */
  assign n203 = {1'b0, n201};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:25 */
  assign n206 = n200 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:25 */
  assign n207 = n200 ? m_speech : n203;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:344:35 */
  assign n213 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:344:51 */
  assign n214 = ~m_rsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:344:46 */
  assign n215 = n213 & n214;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:344:30 */
  assign n216 = m_rst_cmd | n215;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:355:61 */
  assign n219 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:355:50 */
  assign n220 = n219 & m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:355:68 */
  assign n221 = m_rsn & n220;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:42 */
  assign n222 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:42 */
  assign n224 = $signed(n222) > $signed(32'b00000000000000000000000000000001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:56 */
  assign n225 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:56 */
  assign n227 = n225 - 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:46 */
  assign n228 = n227[4:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:42 */
  assign n229 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:42 */
  assign n231 = n229 == 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:362:70 */
  assign n232 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:362:70 */
  assign n234 = $signed(n232) < $signed(32'b00000000000000000000000000001000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:362:54 */
  assign n235 = n234 & m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:362:33 */
  assign n238 = n235 ? 5'b10000 : 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:362:33 */
  assign n241 = n235 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:362:33 */
  assign n243 = n235 ? m_io_ready : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:25 */
  assign n244 = n231 ? n238 : m_wr_busy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:25 */
  assign n246 = n231 ? n241 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:25 */
  assign n247 = n231 ? n243 : m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:25 */
  assign n248 = n224 ? n228 : n244;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:25 */
  assign n250 = n224 ? 1'b0 : n246;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:25 */
  assign n251 = n224 ? m_io_ready : n247;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:355:25 */
  assign n253 = n221 ? 5'b10000 : n248;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:355:25 */
  assign n255 = n221 ? 1'b0 : n250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:355:25 */
  assign n256 = n221 ? m_ddis : m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:355:25 */
  assign n258 = n221 ? 1'b0 : n251;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:352:25 */
  assign n260 = m_rst ? 5'b00000 : n253;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:352:25 */
  assign n262 = m_rst ? 1'b0 : n255;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:352:25 */
  assign n264 = m_rst ? m_wr_data : n256;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:352:25 */
  assign n266 = m_rst ? 1'b1 : n258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:378:46 */
  assign n278 = m_rdb_clr | m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:380:25 */
  assign n280 = m_rdb_cmd ? 1'b1 : m_rdb_flag;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:378:25 */
  assign n282 = n278 ? 1'b0 : n280;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:395:79 */
  assign n288 = ~m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:395:60 */
  assign n289 = n288 & m_talk_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:396:54 */
  assign n290 = ~m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:396:60 */
  assign n291 = m_buffer_low & n290;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:395:86 */
  assign n292 = n289 | n291;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:397:54 */
  assign n293 = ~m_buffer_empty_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:397:60 */
  assign n294 = m_buffer_empty & n293;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:396:86 */
  assign n295 = n292 | n294;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:400:53 */
  assign n296 = m_irq_pin_clr | m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:400:25 */
  assign n298 = n296 ? 1'b0 : m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:394:25 */
  assign n300 = n295 ? 1'b1 : n298;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:39 */
  assign n313 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:47 */
  assign n314 = m_talkd & n313;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:47 */
  assign n315 = m_rng[11:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:69 */
  assign n316 = m_rng[12]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:83 */
  assign n317 = m_rng[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:74 */
  assign n318 = n316 ^ n317;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:96 */
  assign n319 = m_rng[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:87 */
  assign n320 = n318 ^ n319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:109 */
  assign n321 = m_rng[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:100 */
  assign n322 = n320 ^ n321;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:418:61 */
  assign n323 = {n315, n322};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:25 */
  assign n324 = n314 ? n323 : m_rng;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:411:25 */
  assign n326 = m_rst ? 13'b1111111111111 : n324;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:64 */
  assign n332 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:64 */
  assign n334 = n332 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:54 */
  assign n335 = n334 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:79 */
  assign n336 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:79 */
  assign n338 = n336 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:69 */
  assign n339 = n338 & n335;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:94 */
  assign n340 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:94 */
  assign n342 = n340 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:85 */
  assign n343 = n342 & n339;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:110 */
  assign n344 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:114 */
  assign n345 = ~n344;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:100 */
  assign n346 = n345 & n343;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:121 */
  assign n347 = m_inhibit & n346;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:64 */
  assign n348 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:64 */
  assign n350 = n348 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:54 */
  assign n351 = n350 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:79 */
  assign n352 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:79 */
  assign n354 = n352 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:69 */
  assign n355 = n354 & n351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:94 */
  assign n356 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:94 */
  assign n358 = n356 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:85 */
  assign n359 = n358 & n355;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:110 */
  assign n360 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:114 */
  assign n361 = ~n360;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:100 */
  assign n362 = n361 & n359;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:431:33 */
  assign n364 = n362 ? 1'b0 : m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:429:33 */
  assign n366 = n347 ? 1'b1 : n364;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:44 */
  assign n368 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:61 */
  assign n369 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:61 */
  assign n371 = n369 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:52 */
  assign n372 = n371 & n368;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:58 */
  assign n373 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:58 */
  assign n375 = n373 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:61 */
  assign n376 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:61 */
  assign n377 = $signed(n375) < $signed(n376);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:98 */
  assign n378 = ~m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:80 */
  assign n379 = n378 & n377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:438:80 */
  assign n380 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:438:80 */
  assign n382 = n380 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:438:66 */
  assign n383 = n382[8:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:41 */
  assign n385 = n379 ? n383 : 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:25 */
  assign n387 = n372 & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:427:17 */
  assign n389 = n387 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:427:17 */
  assign n390 = m_talkd & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:455:59 */
  assign n396 = ~m_rsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:455:48 */
  assign n397 = n396 & m_rsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:455:66 */
  assign n398 = m_wsn & n397;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:462:67 */
  assign n399 = m_talkd | m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:462:78 */
  assign n400 = {n399, m_buffer_low};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:462:93 */
  assign n401 = {n400, m_buffer_empty};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:462:110 */
  assign n403 = {n401, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:456:33 */
  assign n406 = m_rdb_flag ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:456:33 */
  assign n409 = m_rdb_flag ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:456:33 */
  assign n411 = m_rdb_flag ? 8'b00000000 : n403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:455:25 */
  assign n414 = n398 ? n409 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:451:17 */
  assign n417 = n398 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:451:17 */
  assign n420 = n398 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:474:33 */
  assign n428 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:474:33 */
  assign n430 = n428 == 32'b00000000000000000000000000010001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:474:49 */
  assign n431 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:474:53 */
  assign n432 = ~n431;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:474:39 */
  assign n433 = n432 & n430;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:476:50 */
  assign n434 = m_rng[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:476:41 */
  assign n437 = n434 ? 14'b11111111000000 : 14'b00000001000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:482:59 */
  assign n438 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:482:59 */
  assign n440 = $signed(n438) > $signed(32'b00000000000000000000000000110011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:485:81 */
  assign n441 = m_pitch_count[5:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:485:70 */
  assign n447 = {7'b0, n1978};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:482:41 */
  assign n449 = n440 ? 14'b00000000000000 : n447;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:475:33 */
  assign n450 = m_oldp ? n437 : n449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:472:17 */
  assign n452 = n433 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:497:42 */
  assign n457 = m_rst | m_uf;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:57 */
  assign n458 = m_cyca & m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:86 */
  assign n459 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:86 */
  assign n461 = n459 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:76 */
  assign n462 = n461 & n458;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:101 */
  assign n463 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:101 */
  assign n465 = n463 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:91 */
  assign n466 = n465 & n462;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:116 */
  assign n467 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:116 */
  assign n469 = n467 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:107 */
  assign n470 = n469 & n466;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:132 */
  assign n471 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:136 */
  assign n472 = ~n471;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:122 */
  assign n473 = n472 & n470;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:502:75 */
  assign n474 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:502:57 */
  assign n475 = n474 & m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:502:94 */
  assign n476 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:502:82 */
  assign n477 = n476 & n475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:502:25 */
  assign n479 = n477 ? 1'b1 : m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:499:25 */
  assign n481 = n473 ? 1'b0 : n479;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:497:25 */
  assign n483 = n457 ? 1'b0 : n481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:42 */
  assign n489 = m_rst | m_sxt_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:89 */
  assign n490 = m_ddis & m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:120 */
  assign n491 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:108 */
  assign n492 = n491 & n490;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:127 */
  assign n493 = m_buffer_low_last & n492;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:175 */
  assign n494 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:157 */
  assign n495 = n494 & n493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:63 */
  assign n496 = n489 | n495;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:47 */
  assign n497 = m_cyca & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:76 */
  assign n498 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:76 */
  assign n500 = n498 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:66 */
  assign n501 = n500 & n497;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:91 */
  assign n502 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:91 */
  assign n504 = n502 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:81 */
  assign n505 = n504 & n501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:106 */
  assign n506 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:106 */
  assign n508 = n506 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:97 */
  assign n509 = n508 & n505;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:122 */
  assign n510 = m_phi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:126 */
  assign n511 = ~n510;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:112 */
  assign n512 = n511 & n509;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:518:60 */
  assign n513 = {28'b0, m_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:518:60 */
  assign n515 = n513 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:518:33 */
  assign n518 = n515 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:524:59 */
  assign n519 = {25'b0, m_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:524:59 */
  assign n521 = n519 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:524:33 */
  assign n524 = n521 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:25 */
  assign n525 = n512 ? n518 : m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:25 */
  assign n526 = n512 ? n524 : m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:25 */
  assign n528 = n496 ? 1'b1 : n525;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:25 */
  assign n530 = n496 ? 1'b1 : n526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:56 */
  assign n538 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:56 */
  assign n540 = n538 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:46 */
  assign n541 = n540 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:71 */
  assign n542 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:71 */
  assign n544 = n542 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:61 */
  assign n545 = n544 & n541;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:86 */
  assign n546 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:86 */
  assign n548 = n546 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:77 */
  assign n549 = n548 & n545;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:102 */
  assign n550 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:106 */
  assign n551 = ~n550;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:92 */
  assign n552 = n551 & n549;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:545:44 */
  assign n553 = ~m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:545:51 */
  assign n554 = m_spen & n553;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:545:33 */
  assign n556 = n554 ? 1'b1 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:37 */
  assign n557 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:37 */
  assign n559 = n557 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:52 */
  assign n560 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:52 */
  assign n562 = n560 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:42 */
  assign n563 = n562 & n559;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:70 */
  assign n564 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:58 */
  assign n565 = n564 & n563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:550:25 */
  assign n567 = n565 ? 1'b0 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:25 */
  assign n568 = n552 ? n556 : n567;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:542:25 */
  assign n569 = n552 ? m_talk : m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:539:25 */
  assign n571 = m_rst ? 1'b0 : n568;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:539:25 */
  assign n573 = m_rst ? 1'b0 : n569;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:35 */
  assign n574 = ~m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:42 */
  assign n575 = m_buffer_low_last & n574;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:90 */
  assign n576 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:72 */
  assign n577 = n576 & n575;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:109 */
  assign n578 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:97 */
  assign n579 = n578 & n577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:25 */
  assign n581 = n579 ? 1'b1 : n571;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:55 */
  assign n589 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:55 */
  assign n591 = n589 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:46 */
  assign n592 = n591 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:71 */
  assign n593 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:75 */
  assign n594 = ~n593;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:61 */
  assign n595 = n594 & n592;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:82 */
  assign n596 = m_talkd & n595;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:66 */
  assign n597 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:82 */
  assign n598 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:82 */
  assign n600 = n598 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:73 */
  assign n601 = n597 | n600;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:94 */
  assign n602 = {{18{m_current_energy[13]}}, m_current_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:126 */
  assign n608 = {25'b0, n1981};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:126 */
  assign n609 = {{18{m_current_energy[13]}}, m_current_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:126 */
  assign n610 = n608 - n609;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:80 */
  assign n611 = n610[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:150 */
  assign n617 = {29'b0, n1987};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:68 */
  assign n618 = $signed(n611) >>> n617;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:57 */
  assign n619 = {{20{n618[11]}}, n618}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:94 */
  assign n620 = n602 + n619;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:77 */
  assign n621 = n620[13:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:49 */
  assign n622 = n601 ? n621 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:575:49 */
  assign n624 = m_zpar ? 14'b00000000000000 : n622;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:574:41 */
  assign n626 = m_pc == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:584:66 */
  assign n627 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:584:82 */
  assign n628 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:584:82 */
  assign n630 = n628 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:584:73 */
  assign n631 = n627 | n630;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:585:92 */
  assign n632 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:101 */
  assign n633 = m_new_frame_pitch_idx[5:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:124 */
  assign n639 = {24'b0, n1990};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:124 */
  assign n640 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:124 */
  assign n641 = n639 - n640;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:80 */
  assign n642 = n641[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:148 */
  assign n647 = {29'b0, n1986};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:68 */
  assign n648 = $signed(n642) >>> n647;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:57 */
  assign n649 = {{20{n648[11]}}, n648}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:585:92 */
  assign n650 = n632 + n649;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:585:76 */
  assign n651 = n650[13:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:584:49 */
  assign n652 = n631 ? n651 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:49 */
  assign n654 = m_zpar ? 14'b00000000000000 : n652;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:41 */
  assign n656 = m_pc == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:63 */
  assign n657 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:79 */
  assign n658 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:79 */
  assign n660 = n658 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:70 */
  assign n661 = n657 | n660;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:73 */
  assign n662 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:73 */
  assign n664 = n662 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:73 */
  assign n665 = n664[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:73 */
  assign n667 = 4'b1001 - n665;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:96 */
  assign n669 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:96 */
  assign n671 = n669 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:96 */
  assign n672 = n671[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:96 */
  assign n674 = 4'b1001 - n672;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:100 */
  assign n677 = {{22{n2006[9]}}, n2006}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:103 */
  assign n678 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:103 */
  assign n680 = n678 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:103 */
  assign n681 = n680[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:103 */
  assign n683 = 4'b1001 - n681;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:130 */
  assign n685 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:130 */
  assign n687 = n685 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:130 */
  assign n688 = n687[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:130 */
  assign n690 = 4'b1001 - n688;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:125 */
  assign n694 = 5'b11111 - n2009;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:136 */
  assign n699 = {{22{n1995[9]}}, n1995}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:154 */
  assign n700 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:154 */
  assign n702 = n700 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:154 */
  assign n703 = n702[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:154 */
  assign n705 = 4'b1001 - n703;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:136 */
  assign n708 = {{22{n2012[9]}}, n2012}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:136 */
  assign n709 = n699 - n708;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:80 */
  assign n710 = n709[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:165 */
  assign n715 = {29'b0, n1985};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:68 */
  assign n716 = $signed(n710) >>> n715;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:57 */
  assign n717 = {{20{n716[11]}}, n716}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:100 */
  assign n718 = n677 + n717;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:80 */
  assign n719 = n718[9:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:49 */
  assign n721 = n661 ? n2059 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:588:41 */
  assign n724 = $unsigned(m_pc) >= $unsigned(4'b0010);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:588:41 */
  assign n725 = $unsigned(m_pc) <= $unsigned(4'b0101);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:588:41 */
  assign n726 = n724 & n725;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:73 */
  assign n727 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:73 */
  assign n729 = n727 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:73 */
  assign n730 = n729[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:73 */
  assign n732 = 4'b1001 - n730;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:597:71 */
  assign n736 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:597:87 */
  assign n737 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:597:87 */
  assign n739 = n737 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:597:78 */
  assign n740 = n736 | n739;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:81 */
  assign n741 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:81 */
  assign n743 = n741 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:81 */
  assign n744 = n743[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:81 */
  assign n746 = 4'b1001 - n744;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:104 */
  assign n748 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:104 */
  assign n750 = n748 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:104 */
  assign n751 = n750[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:104 */
  assign n753 = 4'b1001 - n751;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:108 */
  assign n756 = {{22{n2109[9]}}, n2109}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:111 */
  assign n757 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:111 */
  assign n759 = n757 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:111 */
  assign n760 = n759[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:111 */
  assign n762 = 4'b1001 - n760;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:138 */
  assign n764 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:138 */
  assign n766 = n764 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:138 */
  assign n767 = n766[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:138 */
  assign n769 = 4'b1001 - n767;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:133 */
  assign n773 = 5'b11111 - n2112;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:144 */
  assign n777 = {{22{n1993[9]}}, n1993}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:162 */
  assign n778 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:162 */
  assign n780 = n778 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:162 */
  assign n781 = n780[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:162 */
  assign n783 = 4'b1001 - n781;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:144 */
  assign n786 = {{22{n2115[9]}}, n2115}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:144 */
  assign n787 = n777 - n786;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:88 */
  assign n788 = n787[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:173 */
  assign n793 = {29'b0, n1984};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:76 */
  assign n794 = $signed(n788) >>> n793;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:65 */
  assign n795 = {{20{n794[11]}}, n794}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:108 */
  assign n796 = n756 + n795;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:88 */
  assign n797 = n796[9:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:597:57 */
  assign n799 = n740 ? n2162 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:49 */
  assign n800 = m_uv_zpar ? n2106 : n799;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:593:41 */
  assign n803 = $unsigned(m_pc) >= $unsigned(4'b0110);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:593:41 */
  assign n804 = $unsigned(m_pc) <= $unsigned(4'b1011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:593:41 */
  assign n805 = n803 & n804;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:573:33 */
  assign n806 = {n805, n726, n656, n626};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:573:33 */
  always @*
    case (n806)
      4'b1000: n807 = m_current_energy;
      4'b0100: n807 = m_current_energy;
      4'b0010: n807 = m_current_energy;
      4'b0001: n807 = n624;
      default: n807 = m_current_energy;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:573:33 */
  always @*
    case (n806)
      4'b1000: n808 = m_current_pitch;
      4'b0100: n808 = m_current_pitch;
      4'b0010: n808 = n654;
      4'b0001: n808 = m_current_pitch;
      default: n808 = m_current_pitch;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:573:33 */
  always @*
    case (n806)
      4'b1000: n809 = n800;
      4'b0100: n809 = n721;
      4'b0010: n809 = m_current_k;
      4'b0001: n809 = m_current_k;
      default: n809 = m_current_k;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:25 */
  assign n810 = n596 ? n807 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:25 */
  assign n811 = n596 ? n808 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:25 */
  assign n812 = n596 ? n809 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:568:25 */
  assign n814 = m_rst ? 14'b00000000000000 : n810;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:568:25 */
  assign n816 = m_rst ? 14'b00000000000000 : n811;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:568:25 */
  assign n817 = m_rst ? m_current_k : n812;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:58 */
  assign n827 = m_phi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:62 */
  assign n828 = ~n827;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:48 */
  assign n829 = n828 & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:111 */
  assign n830 = {{18{m_previous_energy[13]}}, m_previous_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:111 */
  assign n831 = {{18{m_excitation_data[13]}}, m_excitation_data}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:111 */
  assign n832 = $signed(n830) * $signed(n831); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:83 */
  assign n833 = n832[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:71 */
  assign n835 = $signed(n833) >>> 31'b0000000000000000000000000000011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:60 */
  assign n837 = n835[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:41 */
  assign n839 = m_t == 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:63 */
  assign n840 = m_u[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:68 */
  assign n841 = {{19{n840[12]}}, n840}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:114 */
  assign n842 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:119 */
  assign n843 = {{22{n842[9]}}, n842}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:124 */
  assign n844 = m_x[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:119 */
  assign n845 = {{19{n844[12]}}, n844}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:119 */
  assign n846 = $signed(n843) * $signed(n845); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:93 */
  assign n847 = n846[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:81 */
  assign n849 = $signed(n847) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:70 */
  assign n850 = {{10{n849[21]}}, n849}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:68 */
  assign n851 = n841 - n850;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:60 */
  assign n852 = n851[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:623:41 */
  assign n854 = m_t == 5'b00010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:63 */
  assign n855 = m_u[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:68 */
  assign n856 = {{19{n855[12]}}, n855}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:114 */
  assign n857 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:119 */
  assign n858 = {{22{n857[9]}}, n857}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:124 */
  assign n859 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:119 */
  assign n860 = {{19{n859[12]}}, n859}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:119 */
  assign n861 = $signed(n858) * $signed(n860); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:93 */
  assign n862 = n861[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:81 */
  assign n864 = $signed(n862) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:70 */
  assign n865 = {{10{n864[21]}}, n864}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:68 */
  assign n866 = n856 - n865;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:60 */
  assign n867 = n866[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:626:41 */
  assign n869 = m_t == 5'b00011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:63 */
  assign n870 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:68 */
  assign n871 = {{19{n870[12]}}, n870}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:114 */
  assign n872 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:119 */
  assign n873 = {{22{n872[9]}}, n872}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:124 */
  assign n874 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:119 */
  assign n875 = {{19{n874[12]}}, n874}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:119 */
  assign n876 = $signed(n873) * $signed(n875); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:93 */
  assign n877 = n876[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:81 */
  assign n879 = $signed(n877) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:70 */
  assign n880 = {{10{n879[21]}}, n879}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:68 */
  assign n881 = n871 + n880;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:60 */
  assign n882 = n881[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:63 */
  assign n883 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:68 */
  assign n884 = {{19{n883[12]}}, n883}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:114 */
  assign n885 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:119 */
  assign n886 = {{22{n885[9]}}, n885}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:124 */
  assign n887 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:119 */
  assign n888 = {{19{n887[12]}}, n887}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:119 */
  assign n889 = $signed(n886) * $signed(n888); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:93 */
  assign n890 = n889[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:81 */
  assign n892 = $signed(n890) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:70 */
  assign n893 = {{10{n892[21]}}, n892}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:68 */
  assign n894 = n884 - n893;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:60 */
  assign n895 = n894[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:41 */
  assign n897 = m_t == 5'b00100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:63 */
  assign n898 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:68 */
  assign n899 = {{19{n898[12]}}, n898}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:114 */
  assign n900 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:119 */
  assign n901 = {{22{n900[9]}}, n900}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:124 */
  assign n902 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:119 */
  assign n903 = {{19{n902[12]}}, n902}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:119 */
  assign n904 = $signed(n901) * $signed(n903); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:93 */
  assign n905 = n904[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:81 */
  assign n907 = $signed(n905) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:70 */
  assign n908 = {{10{n907[21]}}, n907}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:68 */
  assign n909 = n899 + n908;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:60 */
  assign n910 = n909[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:63 */
  assign n911 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:68 */
  assign n912 = {{19{n911[12]}}, n911}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:114 */
  assign n913 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:119 */
  assign n914 = {{22{n913[9]}}, n913}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:124 */
  assign n915 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:119 */
  assign n916 = {{19{n915[12]}}, n915}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:119 */
  assign n917 = $signed(n914) * $signed(n916); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:93 */
  assign n918 = n917[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:81 */
  assign n920 = $signed(n918) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:70 */
  assign n921 = {{10{n920[21]}}, n920}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:68 */
  assign n922 = n912 - n921;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:60 */
  assign n923 = n922[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:41 */
  assign n925 = m_t == 5'b00101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:63 */
  assign n926 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:68 */
  assign n927 = {{19{n926[12]}}, n926}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:114 */
  assign n928 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:119 */
  assign n929 = {{22{n928[9]}}, n928}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:124 */
  assign n930 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:119 */
  assign n931 = {{19{n930[12]}}, n930}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:119 */
  assign n932 = $signed(n929) * $signed(n931); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:93 */
  assign n933 = n932[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:81 */
  assign n935 = $signed(n933) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:70 */
  assign n936 = {{10{n935[21]}}, n935}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:68 */
  assign n937 = n927 + n936;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:60 */
  assign n938 = n937[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:63 */
  assign n939 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:68 */
  assign n940 = {{19{n939[12]}}, n939}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:114 */
  assign n941 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:119 */
  assign n942 = {{22{n941[9]}}, n941}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:124 */
  assign n943 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:119 */
  assign n944 = {{19{n943[12]}}, n943}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:119 */
  assign n945 = $signed(n942) * $signed(n944); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:93 */
  assign n946 = n945[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:81 */
  assign n948 = $signed(n946) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:70 */
  assign n949 = {{10{n948[21]}}, n948}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:68 */
  assign n950 = n940 - n949;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:60 */
  assign n951 = n950[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:41 */
  assign n953 = m_t == 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:63 */
  assign n954 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:68 */
  assign n955 = {{19{n954[12]}}, n954}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:114 */
  assign n956 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:119 */
  assign n957 = {{22{n956[9]}}, n956}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:124 */
  assign n958 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:119 */
  assign n959 = {{19{n958[12]}}, n958}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:119 */
  assign n960 = $signed(n957) * $signed(n959); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:93 */
  assign n961 = n960[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:81 */
  assign n963 = $signed(n961) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:70 */
  assign n964 = {{10{n963[21]}}, n963}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:68 */
  assign n965 = n955 + n964;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:60 */
  assign n966 = n965[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:63 */
  assign n967 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:68 */
  assign n968 = {{19{n967[12]}}, n967}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:114 */
  assign n969 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n970 = {{22{n969[9]}}, n969}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:124 */
  assign n971 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n972 = {{19{n971[12]}}, n971}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n973 = $signed(n970) * $signed(n972); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:93 */
  assign n974 = n973[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:81 */
  assign n976 = $signed(n974) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:70 */
  assign n977 = {{10{n976[21]}}, n976}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:68 */
  assign n978 = n968 - n977;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:60 */
  assign n979 = n978[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:41 */
  assign n981 = m_t == 5'b00111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:63 */
  assign n982 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:68 */
  assign n983 = {{19{n982[12]}}, n982}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:114 */
  assign n984 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:119 */
  assign n985 = {{22{n984[9]}}, n984}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:124 */
  assign n986 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:119 */
  assign n987 = {{19{n986[12]}}, n986}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:119 */
  assign n988 = $signed(n985) * $signed(n987); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:93 */
  assign n989 = n988[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:81 */
  assign n991 = $signed(n989) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:70 */
  assign n992 = {{10{n991[21]}}, n991}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:68 */
  assign n993 = n983 + n992;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:60 */
  assign n994 = n993[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:63 */
  assign n995 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:68 */
  assign n996 = {{19{n995[12]}}, n995}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:114 */
  assign n997 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n998 = {{22{n997[9]}}, n997}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:124 */
  assign n999 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n1000 = {{19{n999[12]}}, n999}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n1001 = $signed(n998) * $signed(n1000); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:93 */
  assign n1002 = n1001[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:81 */
  assign n1004 = $signed(n1002) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:70 */
  assign n1005 = {{10{n1004[21]}}, n1004}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:68 */
  assign n1006 = n996 - n1005;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:60 */
  assign n1007 = n1006[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:41 */
  assign n1009 = m_t == 5'b01000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:63 */
  assign n1010 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:68 */
  assign n1011 = {{19{n1010[12]}}, n1010}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:114 */
  assign n1012 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:119 */
  assign n1013 = {{22{n1012[9]}}, n1012}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:124 */
  assign n1014 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:119 */
  assign n1015 = {{19{n1014[12]}}, n1014}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:119 */
  assign n1016 = $signed(n1013) * $signed(n1015); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:93 */
  assign n1017 = n1016[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:81 */
  assign n1019 = $signed(n1017) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:70 */
  assign n1020 = {{10{n1019[21]}}, n1019}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:68 */
  assign n1021 = n1011 + n1020;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:60 */
  assign n1022 = n1021[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:63 */
  assign n1023 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:68 */
  assign n1024 = {{19{n1023[12]}}, n1023}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:114 */
  assign n1025 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n1026 = {{22{n1025[9]}}, n1025}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:124 */
  assign n1027 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n1028 = {{19{n1027[12]}}, n1027}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n1029 = $signed(n1026) * $signed(n1028); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:93 */
  assign n1030 = n1029[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:81 */
  assign n1032 = $signed(n1030) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:70 */
  assign n1033 = {{10{n1032[21]}}, n1032}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:68 */
  assign n1034 = n1024 - n1033;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:60 */
  assign n1035 = n1034[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:41 */
  assign n1037 = m_t == 5'b01001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:63 */
  assign n1038 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:68 */
  assign n1039 = {{19{n1038[12]}}, n1038}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:114 */
  assign n1040 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:119 */
  assign n1041 = {{22{n1040[9]}}, n1040}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:124 */
  assign n1042 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:119 */
  assign n1043 = {{19{n1042[12]}}, n1042}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:119 */
  assign n1044 = $signed(n1041) * $signed(n1043); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:93 */
  assign n1045 = n1044[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:81 */
  assign n1047 = $signed(n1045) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:70 */
  assign n1048 = {{10{n1047[21]}}, n1047}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:68 */
  assign n1049 = n1039 + n1048;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:60 */
  assign n1050 = n1049[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:63 */
  assign n1051 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:68 */
  assign n1052 = {{19{n1051[12]}}, n1051}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:114 */
  assign n1053 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:119 */
  assign n1054 = {{22{n1053[9]}}, n1053}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:124 */
  assign n1055 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:119 */
  assign n1056 = {{19{n1055[12]}}, n1055}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:119 */
  assign n1057 = $signed(n1054) * $signed(n1056); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:93 */
  assign n1058 = n1057[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:81 */
  assign n1060 = $signed(n1058) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:70 */
  assign n1061 = {{10{n1060[21]}}, n1060}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:68 */
  assign n1062 = n1052 - n1061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:60 */
  assign n1063 = n1062[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:646:41 */
  assign n1065 = m_t == 5'b01010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:63 */
  assign n1066 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:68 */
  assign n1067 = {{19{n1066[12]}}, n1066}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:114 */
  assign n1068 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:119 */
  assign n1069 = {{22{n1068[9]}}, n1068}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:124 */
  assign n1070 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:119 */
  assign n1071 = {{19{n1070[12]}}, n1070}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:119 */
  assign n1072 = $signed(n1069) * $signed(n1071); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:93 */
  assign n1073 = n1072[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:81 */
  assign n1075 = $signed(n1073) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:70 */
  assign n1076 = {{10{n1075[21]}}, n1075}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:68 */
  assign n1077 = n1067 + n1076;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:60 */
  assign n1078 = n1077[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:63 */
  assign n1079 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:68 */
  assign n1080 = {{19{n1079[12]}}, n1079}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:114 */
  assign n1081 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:119 */
  assign n1082 = {{22{n1081[9]}}, n1081}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:124 */
  assign n1083 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:119 */
  assign n1084 = {{19{n1083[12]}}, n1083}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:119 */
  assign n1085 = $signed(n1082) * $signed(n1084); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:93 */
  assign n1086 = n1085[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:81 */
  assign n1088 = $signed(n1086) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:70 */
  assign n1089 = {{10{n1088[21]}}, n1088}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:68 */
  assign n1090 = n1080 - n1089;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:60 */
  assign n1091 = n1090[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:649:41 */
  assign n1093 = m_t == 5'b01011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:63 */
  assign n1094 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:68 */
  assign n1095 = {{19{n1094[12]}}, n1094}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:114 */
  assign n1096 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:119 */
  assign n1097 = {{22{n1096[9]}}, n1096}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:124 */
  assign n1098 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:119 */
  assign n1099 = {{19{n1098[12]}}, n1098}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:119 */
  assign n1100 = $signed(n1097) * $signed(n1099); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:93 */
  assign n1101 = n1100[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:81 */
  assign n1103 = $signed(n1101) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:70 */
  assign n1104 = {{10{n1103[21]}}, n1103}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:68 */
  assign n1105 = n1095 + n1104;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:60 */
  assign n1106 = n1105[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:63 */
  assign n1107 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:655:67 */
  assign n1108 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:655:64 */
  assign n1109 = {{1{n1108[12]}}, n1108}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:652:41 */
  assign n1111 = m_t == 5'b01100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  assign n1112 = {n1111, n1093, n1065, n1037, n1009, n981, n953, n925, n897, n869, n854, n839};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1113 = m_u[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1114 = n1113;
      12'b010000000000: n1114 = n1113;
      12'b001000000000: n1114 = n1113;
      12'b000100000000: n1114 = n1113;
      12'b000010000000: n1114 = n1113;
      12'b000001000000: n1114 = n1113;
      12'b000000100000: n1114 = n1113;
      12'b000000010000: n1114 = n1113;
      12'b000000001000: n1114 = n1113;
      12'b000000000100: n1114 = n1113;
      12'b000000000010: n1114 = n1113;
      12'b000000000001: n1114 = n837;
      default: n1114 = n1113;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1115 = m_u[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1116 = n1115;
      12'b010000000000: n1116 = n1115;
      12'b001000000000: n1116 = n1115;
      12'b000100000000: n1116 = n1115;
      12'b000010000000: n1116 = n1115;
      12'b000001000000: n1116 = n1115;
      12'b000000100000: n1116 = n1115;
      12'b000000010000: n1116 = n1115;
      12'b000000001000: n1116 = n1115;
      12'b000000000100: n1116 = n1115;
      12'b000000000010: n1116 = n852;
      12'b000000000001: n1116 = n1115;
      default: n1116 = n1115;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1117 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1118 = n1117;
      12'b010000000000: n1118 = n1117;
      12'b001000000000: n1118 = n1117;
      12'b000100000000: n1118 = n1117;
      12'b000010000000: n1118 = n1117;
      12'b000001000000: n1118 = n1117;
      12'b000000100000: n1118 = n1117;
      12'b000000010000: n1118 = n1117;
      12'b000000001000: n1118 = n1117;
      12'b000000000100: n1118 = n867;
      12'b000000000010: n1118 = n1117;
      12'b000000000001: n1118 = n1117;
      default: n1118 = n1117;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1119 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1120 = n1119;
      12'b010000000000: n1120 = n1119;
      12'b001000000000: n1120 = n1119;
      12'b000100000000: n1120 = n1119;
      12'b000010000000: n1120 = n1119;
      12'b000001000000: n1120 = n1119;
      12'b000000100000: n1120 = n1119;
      12'b000000010000: n1120 = n1119;
      12'b000000001000: n1120 = n895;
      12'b000000000100: n1120 = n1119;
      12'b000000000010: n1120 = n1119;
      12'b000000000001: n1120 = n1119;
      default: n1120 = n1119;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1121 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1122 = n1121;
      12'b010000000000: n1122 = n1121;
      12'b001000000000: n1122 = n1121;
      12'b000100000000: n1122 = n1121;
      12'b000010000000: n1122 = n1121;
      12'b000001000000: n1122 = n1121;
      12'b000000100000: n1122 = n1121;
      12'b000000010000: n1122 = n923;
      12'b000000001000: n1122 = n1121;
      12'b000000000100: n1122 = n1121;
      12'b000000000010: n1122 = n1121;
      12'b000000000001: n1122 = n1121;
      default: n1122 = n1121;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1123 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1124 = n1123;
      12'b010000000000: n1124 = n1123;
      12'b001000000000: n1124 = n1123;
      12'b000100000000: n1124 = n1123;
      12'b000010000000: n1124 = n1123;
      12'b000001000000: n1124 = n1123;
      12'b000000100000: n1124 = n951;
      12'b000000010000: n1124 = n1123;
      12'b000000001000: n1124 = n1123;
      12'b000000000100: n1124 = n1123;
      12'b000000000010: n1124 = n1123;
      12'b000000000001: n1124 = n1123;
      default: n1124 = n1123;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1125 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1126 = n1125;
      12'b010000000000: n1126 = n1125;
      12'b001000000000: n1126 = n1125;
      12'b000100000000: n1126 = n1125;
      12'b000010000000: n1126 = n1125;
      12'b000001000000: n1126 = n979;
      12'b000000100000: n1126 = n1125;
      12'b000000010000: n1126 = n1125;
      12'b000000001000: n1126 = n1125;
      12'b000000000100: n1126 = n1125;
      12'b000000000010: n1126 = n1125;
      12'b000000000001: n1126 = n1125;
      default: n1126 = n1125;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1127 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1128 = n1127;
      12'b010000000000: n1128 = n1127;
      12'b001000000000: n1128 = n1127;
      12'b000100000000: n1128 = n1127;
      12'b000010000000: n1128 = n1007;
      12'b000001000000: n1128 = n1127;
      12'b000000100000: n1128 = n1127;
      12'b000000010000: n1128 = n1127;
      12'b000000001000: n1128 = n1127;
      12'b000000000100: n1128 = n1127;
      12'b000000000010: n1128 = n1127;
      12'b000000000001: n1128 = n1127;
      default: n1128 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1129 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1130 = n1129;
      12'b010000000000: n1130 = n1129;
      12'b001000000000: n1130 = n1129;
      12'b000100000000: n1130 = n1035;
      12'b000010000000: n1130 = n1129;
      12'b000001000000: n1130 = n1129;
      12'b000000100000: n1130 = n1129;
      12'b000000010000: n1130 = n1129;
      12'b000000001000: n1130 = n1129;
      12'b000000000100: n1130 = n1129;
      12'b000000000010: n1130 = n1129;
      12'b000000000001: n1130 = n1129;
      default: n1130 = n1129;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1131 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1132 = n1131;
      12'b010000000000: n1132 = n1131;
      12'b001000000000: n1132 = n1063;
      12'b000100000000: n1132 = n1131;
      12'b000010000000: n1132 = n1131;
      12'b000001000000: n1132 = n1131;
      12'b000000100000: n1132 = n1131;
      12'b000000010000: n1132 = n1131;
      12'b000000001000: n1132 = n1131;
      12'b000000000100: n1132 = n1131;
      12'b000000000010: n1132 = n1131;
      12'b000000000001: n1132 = n1131;
      default: n1132 = n1131;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1133 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1134 = n1133;
      12'b010000000000: n1134 = n1091;
      12'b001000000000: n1134 = n1133;
      12'b000100000000: n1134 = n1133;
      12'b000010000000: n1134 = n1133;
      12'b000001000000: n1134 = n1133;
      12'b000000100000: n1134 = n1133;
      12'b000000010000: n1134 = n1133;
      12'b000000001000: n1134 = n1133;
      12'b000000000100: n1134 = n1133;
      12'b000000000010: n1134 = n1133;
      12'b000000000001: n1134 = n1133;
      default: n1134 = n1133;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1135 = m_x[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1136 = n1135;
      12'b010000000000: n1136 = n1135;
      12'b001000000000: n1136 = n1135;
      12'b000100000000: n1136 = n1135;
      12'b000010000000: n1136 = n1135;
      12'b000001000000: n1136 = n1135;
      12'b000000100000: n1136 = n1135;
      12'b000000010000: n1136 = n1135;
      12'b000000001000: n1136 = n882;
      12'b000000000100: n1136 = n1135;
      12'b000000000010: n1136 = n1135;
      12'b000000000001: n1136 = n1135;
      default: n1136 = n1135;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1137 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1138 = n1137;
      12'b010000000000: n1138 = n1137;
      12'b001000000000: n1138 = n1137;
      12'b000100000000: n1138 = n1137;
      12'b000010000000: n1138 = n1137;
      12'b000001000000: n1138 = n1137;
      12'b000000100000: n1138 = n1137;
      12'b000000010000: n1138 = n910;
      12'b000000001000: n1138 = n1137;
      12'b000000000100: n1138 = n1137;
      12'b000000000010: n1138 = n1137;
      12'b000000000001: n1138 = n1137;
      default: n1138 = n1137;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1139 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1140 = n1139;
      12'b010000000000: n1140 = n1139;
      12'b001000000000: n1140 = n1139;
      12'b000100000000: n1140 = n1139;
      12'b000010000000: n1140 = n1139;
      12'b000001000000: n1140 = n1139;
      12'b000000100000: n1140 = n938;
      12'b000000010000: n1140 = n1139;
      12'b000000001000: n1140 = n1139;
      12'b000000000100: n1140 = n1139;
      12'b000000000010: n1140 = n1139;
      12'b000000000001: n1140 = n1139;
      default: n1140 = n1139;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1141 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1142 = n1141;
      12'b010000000000: n1142 = n1141;
      12'b001000000000: n1142 = n1141;
      12'b000100000000: n1142 = n1141;
      12'b000010000000: n1142 = n1141;
      12'b000001000000: n1142 = n966;
      12'b000000100000: n1142 = n1141;
      12'b000000010000: n1142 = n1141;
      12'b000000001000: n1142 = n1141;
      12'b000000000100: n1142 = n1141;
      12'b000000000010: n1142 = n1141;
      12'b000000000001: n1142 = n1141;
      default: n1142 = n1141;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1143 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1144 = n1143;
      12'b010000000000: n1144 = n1143;
      12'b001000000000: n1144 = n1143;
      12'b000100000000: n1144 = n1143;
      12'b000010000000: n1144 = n994;
      12'b000001000000: n1144 = n1143;
      12'b000000100000: n1144 = n1143;
      12'b000000010000: n1144 = n1143;
      12'b000000001000: n1144 = n1143;
      12'b000000000100: n1144 = n1143;
      12'b000000000010: n1144 = n1143;
      12'b000000000001: n1144 = n1143;
      default: n1144 = n1143;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1145 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1146 = n1145;
      12'b010000000000: n1146 = n1145;
      12'b001000000000: n1146 = n1145;
      12'b000100000000: n1146 = n1022;
      12'b000010000000: n1146 = n1145;
      12'b000001000000: n1146 = n1145;
      12'b000000100000: n1146 = n1145;
      12'b000000010000: n1146 = n1145;
      12'b000000001000: n1146 = n1145;
      12'b000000000100: n1146 = n1145;
      12'b000000000010: n1146 = n1145;
      12'b000000000001: n1146 = n1145;
      default: n1146 = n1145;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1147 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1148 = n1147;
      12'b010000000000: n1148 = n1147;
      12'b001000000000: n1148 = n1050;
      12'b000100000000: n1148 = n1147;
      12'b000010000000: n1148 = n1147;
      12'b000001000000: n1148 = n1147;
      12'b000000100000: n1148 = n1147;
      12'b000000010000: n1148 = n1147;
      12'b000000001000: n1148 = n1147;
      12'b000000000100: n1148 = n1147;
      12'b000000000010: n1148 = n1147;
      12'b000000000001: n1148 = n1147;
      default: n1148 = n1147;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1149 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1150 = n1149;
      12'b010000000000: n1150 = n1078;
      12'b001000000000: n1150 = n1149;
      12'b000100000000: n1150 = n1149;
      12'b000010000000: n1150 = n1149;
      12'b000001000000: n1150 = n1149;
      12'b000000100000: n1150 = n1149;
      12'b000000010000: n1150 = n1149;
      12'b000000001000: n1150 = n1149;
      12'b000000000100: n1150 = n1149;
      12'b000000000010: n1150 = n1149;
      12'b000000000001: n1150 = n1149;
      default: n1150 = n1149;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1151 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1152 = n1106;
      12'b010000000000: n1152 = n1151;
      12'b001000000000: n1152 = n1151;
      12'b000100000000: n1152 = n1151;
      12'b000010000000: n1152 = n1151;
      12'b000001000000: n1152 = n1151;
      12'b000000100000: n1152 = n1151;
      12'b000000010000: n1152 = n1151;
      12'b000000001000: n1152 = n1151;
      12'b000000000100: n1152 = n1151;
      12'b000000000010: n1152 = n1151;
      12'b000000000001: n1152 = n1151;
      default: n1152 = n1151;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1153 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1154 = n1107;
      12'b010000000000: n1154 = n1153;
      12'b001000000000: n1154 = n1153;
      12'b000100000000: n1154 = n1153;
      12'b000010000000: n1154 = n1153;
      12'b000001000000: n1154 = n1153;
      12'b000000100000: n1154 = n1153;
      12'b000000010000: n1154 = n1153;
      12'b000000001000: n1154 = n1153;
      12'b000000000100: n1154 = n1153;
      12'b000000000010: n1154 = n1153;
      12'b000000000001: n1154 = n1153;
      default: n1154 = n1153;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1155 = m_previous_energy;
      12'b010000000000: n1155 = m_previous_energy;
      12'b001000000000: n1155 = m_previous_energy;
      12'b000100000000: n1155 = m_previous_energy;
      12'b000010000000: n1155 = m_previous_energy;
      12'b000001000000: n1155 = m_previous_energy;
      12'b000000100000: n1155 = m_previous_energy;
      12'b000000010000: n1155 = m_previous_energy;
      12'b000000001000: n1155 = m_previous_energy;
      12'b000000000100: n1155 = m_previous_energy;
      12'b000000000010: n1155 = m_current_energy;
      12'b000000000001: n1155 = m_previous_energy;
      default: n1155 = m_previous_energy;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:33 */
  always @*
    case (n1112)
      12'b100000000000: n1156 = n1109;
      12'b010000000000: n1156 = this_sample;
      12'b001000000000: n1156 = this_sample;
      12'b000100000000: n1156 = this_sample;
      12'b000010000000: n1156 = this_sample;
      12'b000001000000: n1156 = this_sample;
      12'b000000100000: n1156 = this_sample;
      12'b000000010000: n1156 = this_sample;
      12'b000000001000: n1156 = this_sample;
      12'b000000000100: n1156 = this_sample;
      12'b000000000010: n1156 = this_sample;
      12'b000000000001: n1156 = this_sample;
      default: n1156 = this_sample;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:25 */
  assign n1157 = {n1134, n1132, n1130, n1128, n1126, n1124, n1122, n1120, n1118, n1116, n1114};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:25 */
  assign n1158 = n829 ? n1157 : m_u;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:25 */
  assign n1159 = {n1154, n1152, n1150, n1148, n1146, n1144, n1142, n1140, n1138, n1136};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:25 */
  assign n1160 = n829 ? n1159 : m_x;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:25 */
  assign n1161 = n829 ? n1155 : m_previous_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:25 */
  assign n1162 = n829 ? n1156 : this_sample;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:25 */
  assign n1164 = m_rst ? 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1158;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:25 */
  assign n1166 = m_rst ? 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1160;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:25 */
  assign n1168 = m_rst ? 14'b00000000000000 : n1161;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:25 */
  assign n1169 = m_rst ? this_sample : n1162;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:677:59 */
  assign n1181 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:677:48 */
  assign n1182 = n1181 & m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:677:66 */
  assign n1183 = m_rsn & n1182;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:677:97 */
  assign n1184 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:677:85 */
  assign n1185 = n1184 & n1183;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:678:51 */
  assign n1186 = m_dbi[6:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:680:60 */
  assign n1188 = ~m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:680:45 */
  assign n1189 = n1188 & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:683:41 */
  assign n1191 = m_cmd_reg == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:684:41 */
  assign n1193 = m_cmd_reg == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:686:41 */
  assign n1195 = m_cmd_reg == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:41 */
  assign n1197 = m_cmd_reg == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:688:41 */
  assign n1199 = m_cmd_reg == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:689:41 */
  assign n1201 = m_cmd_reg == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:690:41 */
  assign n1203 = m_cmd_reg == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:692:41 */
  assign n1205 = m_cmd_reg == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:682:33 */
  assign n1206 = {n1205, n1203, n1201, n1199, n1197, n1195, n1193, n1191};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:682:33 */
  always @*
    case (n1206)
      8'b10000000: n1209 = 1'b0;
      8'b01000000: n1209 = 1'b0;
      8'b00100000: n1209 = 1'b0;
      8'b00010000: n1209 = 1'b0;
      8'b00001000: n1209 = 1'b0;
      8'b00000100: n1209 = 1'b0;
      8'b00000010: n1209 = 1'b1;
      8'b00000001: n1209 = 1'b0;
      default: n1209 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:682:33 */
  always @*
    case (n1206)
      8'b10000000: n1212 = 1'b1;
      8'b01000000: n1212 = 1'b0;
      8'b00100000: n1212 = 1'b0;
      8'b00010000: n1212 = 1'b0;
      8'b00001000: n1212 = 1'b0;
      8'b00000100: n1212 = 1'b0;
      8'b00000010: n1212 = 1'b0;
      8'b00000001: n1212 = 1'b0;
      default: n1212 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:682:33 */
  always @*
    case (n1206)
      8'b10000000: n1215 = 1'b0;
      8'b01000000: n1215 = 1'b1;
      8'b00100000: n1215 = 1'b0;
      8'b00010000: n1215 = 1'b0;
      8'b00001000: n1215 = 1'b0;
      8'b00000100: n1215 = 1'b0;
      8'b00000010: n1215 = 1'b0;
      8'b00000001: n1215 = 1'b0;
      default: n1215 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:680:25 */
  assign n1217 = n1189 ? n1209 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:680:25 */
  assign n1220 = n1189 ? n1212 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:680:25 */
  assign n1223 = n1189 ? n1215 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:673:17 */
  assign n1225 = n1185 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:75 */
  assign n1236 = ~m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:64 */
  assign n1237 = n1236 & m_talkd_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:42 */
  assign n1238 = m_rst | n1237;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:708:25 */
  assign n1240 = m_sxt_cmd ? 1'b1 : m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:25 */
  assign n1242 = n1238 ? 1'b0 : n1240;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:56 */
  assign n1250 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:56 */
  assign n1252 = n1250 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:46 */
  assign n1253 = n1252 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:71 */
  assign n1254 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:71 */
  assign n1256 = n1254 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:61 */
  assign n1257 = n1256 & n1253;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:86 */
  assign n1258 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:86 */
  assign n1260 = n1258 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:77 */
  assign n1261 = n1260 & n1257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:102 */
  assign n1262 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:106 */
  assign n1263 = ~n1262;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:92 */
  assign n1264 = n1263 & n1261;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:113 */
  assign n1265 = m_talkd & n1264;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:723:50 */
  assign n1266 = ~m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:723:88 */
  assign n1267 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:723:88 */
  assign n1269 = n1267 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:723:57 */
  assign n1270 = n1269 & n1266;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:87 */
  assign n1271 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:87 */
  assign n1273 = n1271 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:57 */
  assign n1274 = n1273 & m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:723:94 */
  assign n1275 = n1270 | n1274;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:725:87 */
  assign n1276 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:725:87 */
  assign n1278 = n1276 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:725:57 */
  assign n1279 = n1278 & m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:94 */
  assign n1280 = n1275 | n1279;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:88 */
  assign n1281 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:88 */
  assign n1283 = n1281 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:57 */
  assign n1284 = n1283 & m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:725:94 */
  assign n1285 = n1280 | n1284;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:722:33 */
  assign n1288 = n1285 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:25 */
  assign n1289 = n1265 ? n1288 : m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:719:25 */
  assign n1291 = m_rst ? 1'b1 : n1289;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:54 */
  assign n1297 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:76 */
  assign n1299 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:61 */
  assign n1300 = n1299 & n1297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:42 */
  assign n1301 = m_rst | n1300;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:51 */
  assign n1302 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:85 */
  assign n1303 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:73 */
  assign n1304 = n1303 & n1302;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:108 */
  assign n1305 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:108 */
  assign n1307 = $signed(n1305) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:92 */
  assign n1308 = n1307 & n1304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:130 */
  assign n1309 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:130 */
  assign n1311 = $signed(n1309) < $signed(32'b00000000000000000000000001001001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:742:114 */
  assign n1312 = n1311 & n1308;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:85 */
  assign n1313 = n1301 | n1312;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:25 */
  assign n1315 = n1313 ? 1'b1 : m_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:25 */
  assign n1317 = n1313 ? 1'b1 : m_uv_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:53 */
  assign n1318 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:53 */
  assign n1320 = n1318 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:43 */
  assign n1321 = n1320 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:68 */
  assign n1322 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:68 */
  assign n1324 = n1322 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:58 */
  assign n1325 = n1324 & n1321;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:83 */
  assign n1326 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:83 */
  assign n1328 = n1326 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:74 */
  assign n1329 = n1328 & n1325;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:99 */
  assign n1330 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:103 */
  assign n1331 = ~n1330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:89 */
  assign n1332 = n1331 & n1329;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:110 */
  assign n1333 = m_talkd & n1332;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:61 */
  assign n1334 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:61 */
  assign n1336 = n1334 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:96 */
  assign n1337 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:96 */
  assign n1339 = n1337 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:66 */
  assign n1340 = n1339 & n1336;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:132 */
  assign n1341 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:132 */
  assign n1343 = n1341 != 32'b00000000000000000000000000001111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:102 */
  assign n1344 = n1343 & n1340;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:749:33 */
  assign n1347 = n1344 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:25 */
  assign n1349 = n1333 ? 1'b0 : n1315;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:747:25 */
  assign n1350 = n1333 ? n1347 : n1317;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:54 */
  assign n1358 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:76 */
  assign n1360 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:61 */
  assign n1361 = n1360 & n1358;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:42 */
  assign n1362 = m_rst | n1361;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:772:51 */
  assign n1363 = m_wsn_last & m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:772:85 */
  assign n1364 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:772:74 */
  assign n1365 = n1364 & n1363;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:772:92 */
  assign n1366 = m_rsn & n1365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:58 */
  assign n1367 = m_dbi[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:67 */
  assign n1368 = m_dbi[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:61 */
  assign n1369 = {n1367, n1368};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:76 */
  assign n1370 = m_dbi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:70 */
  assign n1371 = {n1369, n1370};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:85 */
  assign n1372 = m_dbi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:79 */
  assign n1373 = {n1371, n1372};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:94 */
  assign n1374 = m_dbi[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:88 */
  assign n1375 = {n1373, n1374};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:103 */
  assign n1376 = m_dbi[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:97 */
  assign n1377 = {n1375, n1376};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:112 */
  assign n1378 = m_dbi[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:106 */
  assign n1379 = {n1377, n1378};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:121 */
  assign n1380 = m_dbi[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:773:115 */
  assign n1381 = {n1379, n1380};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:772:33 */
  assign n1382 = n1366 ? n1381 : m_wr_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:775:53 */
  assign n1383 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:775:33 */
  assign n1385 = n1383 ? 1'b1 : m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:25 */
  assign n1387 = n1362 ? 8'b10000000 : m_fifo_ptr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:25 */
  assign n1388 = n1362 ? m_wr_pending : n1385;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:25 */
  assign n1389 = n1362 ? m_wr_reg : n1382;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:25 */
  assign n1391 = n1362 ? 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : m_fifo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:54 */
  assign n1392 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:76 */
  assign n1394 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:61 */
  assign n1395 = n1394 & n1392;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:42 */
  assign n1396 = m_rst | n1395;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:51 */
  assign n1397 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:85 */
  assign n1398 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:73 */
  assign n1399 = n1398 & n1397;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:108 */
  assign n1400 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:108 */
  assign n1402 = $signed(n1400) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:92 */
  assign n1403 = n1402 & n1399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:130 */
  assign n1404 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:130 */
  assign n1406 = $signed(n1404) < $signed(32'b00000000000000000000000001001001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:114 */
  assign n1407 = n1406 & n1403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:85 */
  assign n1408 = n1396 | n1407;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:56 */
  assign n1409 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:56 */
  assign n1411 = n1409 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:46 */
  assign n1412 = n1411 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:70 */
  assign n1413 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:70 */
  assign n1415 = n1413 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:61 */
  assign n1416 = n1415 & n1412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:86 */
  assign n1417 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:90 */
  assign n1418 = ~n1417;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:76 */
  assign n1419 = n1418 & n1416;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:97 */
  assign n1420 = m_talkd & n1419;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:64 */
  assign n1421 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:64 */
  assign n1423 = $signed(n1421) <= $signed(32'b00000000000000000000000001111100);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:794:82 */
  assign n1424 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:794:82 */
  assign n1426 = n1424 + 32'b00000000000000000000000000000100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:794:71 */
  assign n1427 = n1426[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:73 */
  assign n1428 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:107 */
  assign n1430 = {n1428, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:111 */
  assign n1431 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:70 */
  assign n1433 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:112 */
  assign n1435 = n1433 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:800:70 */
  assign n1436 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:800:112 */
  assign n1438 = n1436 == 4'b1111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:800:57 */
  assign n1440 = n1438 ? m_new_frame_voiced : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:800:57 */
  assign n1442 = n1438 ? m_new_frame_zero : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:800:57 */
  assign n1445 = n1438 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:57 */
  assign n1446 = n1435 ? m_new_frame_voiced : n1440;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:57 */
  assign n1448 = n1435 ? 1'b1 : n1442;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:57 */
  assign n1449 = n1435 ? m_new_frame_stop : n1445;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:49 */
  assign n1450 = n1423 ? n1427 : n1387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:49 */
  assign n1451 = n1423 ? n1431 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:49 */
  assign n1454 = n1423 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:49 */
  assign n1455 = n1423 ? n1446 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:49 */
  assign n1456 = n1423 ? n1448 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:49 */
  assign n1457 = n1423 ? n1449 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:793:49 */
  assign n1458 = n1423 ? n1430 : n1391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:792:41 */
  assign n1460 = m_pc == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:71 */
  assign n1461 = ~m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:100 */
  assign n1462 = ~m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:78 */
  assign n1463 = n1462 & n1461;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:72 */
  assign n1464 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:72 */
  assign n1466 = $signed(n1464) <= $signed(32'b00000000000000000000000001111001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:90 */
  assign n1467 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:90 */
  assign n1469 = n1467 + 32'b00000000000000000000000000000110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:99 */
  assign n1471 = n1469 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:79 */
  assign n1472 = n1471[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:81 */
  assign n1473 = m_fifo[120:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:124 */
  assign n1475 = {n1473, 7'b0000000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:815:93 */
  assign n1476 = m_fifo[127]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:816:118 */
  assign n1477 = m_fifo[126:121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:816:92 */
  assign n1479 = {1'b0, n1477};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:75 */
  assign n1480 = m_fifo[126:121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:135 */
  assign n1482 = n1480 == 6'b000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1484 = n1500 ? 1'b0 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1486 = n1501 ? 1'b1 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1487 = n1496 ? n1472 : n1387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1488 = n1497 ? n1479 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:57 */
  assign n1491 = n1466 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:57 */
  assign n1492 = n1482 & n1466;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:57 */
  assign n1493 = n1482 & n1466;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1494 = n1502 ? n1476 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1495 = n1503 ? n1475 : n1391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1496 = n1466 & n1463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1497 = n1466 & n1463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1499 = n1463 ? n1491 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1500 = n1492 & n1463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1501 = n1493 & n1463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1502 = n1466 & n1463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:49 */
  assign n1503 = n1466 & n1463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:810:41 */
  assign n1505 = m_pc == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:73 */
  assign n1506 = ~m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:112 */
  assign n1507 = m_new_frame_voiced | m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:80 */
  assign n1508 = n1507 & n1506;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:72 */
  assign n1509 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:98 */
  assign n1510 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:98 */
  assign n1512 = n1510 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:98 */
  assign n1513 = n1512[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:85 */
  assign n1519 = {29'b0, n2003};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:85 */
  assign n1521 = 32'b00000000000000000000000010000000 - n1519;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:72 */
  assign n1522 = $signed(n1509) <= $signed(n1521);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:90 */
  assign n1523 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:103 */
  assign n1524 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:103 */
  assign n1526 = n1524 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:103 */
  assign n1527 = n1526[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:90 */
  assign n1532 = {29'b0, n2002};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:90 */
  assign n1533 = n1523 + n1532;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:79 */
  assign n1534 = n1533[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:81 */
  assign n1535 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:81 */
  assign n1537 = n1535 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:81 */
  assign n1538 = n1537[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:97 */
  assign n1543 = m_fifo[122:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:122 */
  assign n1545 = {n1543, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:105 */
  assign n1546 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:105 */
  assign n1548 = n1546 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:105 */
  assign n1549 = n1548[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:105 */
  assign n1551 = 4'b1001 - n1549;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:138 */
  assign n1553 = m_fifo[127:123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:833:73 */
  assign n1557 = n2001 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:837:97 */
  assign n1558 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:837:122 */
  assign n1560 = {n1558, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:105 */
  assign n1561 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:105 */
  assign n1563 = n1561 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:105 */
  assign n1564 = n1563[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:105 */
  assign n1566 = 4'b1001 - n1564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:138 */
  assign n1568 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:112 */
  assign n1570 = {1'b0, n1568};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:73 */
  assign n1573 = n2001 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:840:97 */
  assign n1574 = m_fifo[124:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:840:122 */
  assign n1576 = {n1574, 3'b000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:105 */
  assign n1577 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:105 */
  assign n1579 = n1577 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:105 */
  assign n1580 = n1579[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:105 */
  assign n1582 = 4'b1001 - n1580;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:138 */
  assign n1584 = m_fifo[127:125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:112 */
  assign n1586 = {2'b0, n1584};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:65 */
  assign n1588 = {n1573, n1557};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:65 */
  always @*
    case (n1588)
      2'b10: n1589 = n2256;
      2'b01: n1589 = n2209;
      default: n1589 = n2303;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:65 */
  always @*
    case (n1588)
      2'b10: n1590 = n1560;
      2'b01: n1590 = n1545;
      default: n1590 = n1576;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:49 */
  assign n1591 = n1597 ? n1534 : n1387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:49 */
  assign n1592 = n1598 ? n1589 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:57 */
  assign n1595 = n1522 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:49 */
  assign n1596 = n1601 ? n1590 : n1391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:49 */
  assign n1597 = n1522 & n1508;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:49 */
  assign n1598 = n1522 & n1508;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:49 */
  assign n1600 = n1508 ? n1595 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:49 */
  assign n1601 = n1522 & n1508;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:41 */
  assign n1604 = $unsigned(m_pc) >= $unsigned(4'b0010);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:41 */
  assign n1605 = $unsigned(m_pc) <= $unsigned(4'b0101);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:41 */
  assign n1606 = n1604 & n1605;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:73 */
  assign n1607 = ~m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:80 */
  assign n1608 = m_new_frame_voiced & n1607;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:72 */
  assign n1609 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:98 */
  assign n1610 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:98 */
  assign n1612 = n1610 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:98 */
  assign n1613 = n1612[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:85 */
  assign n1618 = {29'b0, n2000};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:85 */
  assign n1620 = 32'b00000000000000000000000010000000 - n1618;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:72 */
  assign n1621 = $signed(n1609) <= $signed(n1620);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:90 */
  assign n1622 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:103 */
  assign n1623 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:103 */
  assign n1625 = n1623 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:103 */
  assign n1626 = n1625[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:90 */
  assign n1631 = {29'b0, n1999};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:90 */
  assign n1632 = n1622 + n1631;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:79 */
  assign n1633 = n1632[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:854:81 */
  assign n1634 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:854:81 */
  assign n1636 = n1634 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:854:81 */
  assign n1637 = n1636[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:97 */
  assign n1642 = m_fifo[122:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:122 */
  assign n1644 = {n1642, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:105 */
  assign n1645 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:105 */
  assign n1647 = n1645 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:105 */
  assign n1648 = n1647[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:105 */
  assign n1650 = 4'b1001 - n1648;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:138 */
  assign n1652 = m_fifo[127:123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:855:73 */
  assign n1656 = n1998 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:859:97 */
  assign n1657 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:859:122 */
  assign n1659 = {n1657, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:105 */
  assign n1660 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:105 */
  assign n1662 = n1660 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:105 */
  assign n1663 = n1662[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:105 */
  assign n1665 = 4'b1001 - n1663;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:138 */
  assign n1667 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:112 */
  assign n1669 = {1'b0, n1667};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:858:73 */
  assign n1672 = n1998 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:862:97 */
  assign n1673 = m_fifo[124:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:862:122 */
  assign n1675 = {n1673, 3'b000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:105 */
  assign n1676 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:105 */
  assign n1678 = n1676 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:105 */
  assign n1679 = n1678[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:105 */
  assign n1681 = 4'b1001 - n1679;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:138 */
  assign n1683 = m_fifo[127:125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:112 */
  assign n1685 = {2'b0, n1683};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:854:65 */
  assign n1687 = {n1672, n1656};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:854:65 */
  always @*
    case (n1687)
      2'b10: n1688 = n2397;
      2'b01: n1688 = n2350;
      default: n1688 = n2444;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:854:65 */
  always @*
    case (n1687)
      2'b10: n1689 = n1659;
      2'b01: n1689 = n1644;
      default: n1689 = n1675;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:49 */
  assign n1690 = n1696 ? n1633 : n1387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:49 */
  assign n1691 = n1697 ? n1688 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:57 */
  assign n1694 = n1621 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:49 */
  assign n1695 = n1700 ? n1689 : n1391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:49 */
  assign n1696 = n1621 & n1608;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:49 */
  assign n1697 = n1621 & n1608;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:49 */
  assign n1699 = n1608 ? n1694 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:49 */
  assign n1700 = n1621 & n1608;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:41 */
  assign n1703 = $unsigned(m_pc) >= $unsigned(4'b0110);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:41 */
  assign n1704 = $unsigned(m_pc) <= $unsigned(4'b1011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:41 */
  assign n1705 = n1703 & n1704;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:94 */
  assign n1706 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:94 */
  assign n1707 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:879:94 */
  assign n1708 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:880:94 */
  assign n1709 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:881:94 */
  assign n1710 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:882:94 */
  assign n1711 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:883:94 */
  assign n1712 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:884:94 */
  assign n1713 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:885:94 */
  assign n1714 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:886:94 */
  assign n1715 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:870:41 */
  assign n1717 = m_pc == 4'b1100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  assign n1718 = {n1717, n1705, n1606, n1505, n1460};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1719 = n1387;
      5'b01000: n1719 = n1690;
      5'b00100: n1719 = n1591;
      5'b00010: n1719 = n1487;
      5'b00001: n1719 = n1450;
      default: n1719 = n1387;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1720 = tmp_new_frame_energy_idx;
      5'b01000: n1720 = m_new_frame_energy_idx;
      5'b00100: n1720 = m_new_frame_energy_idx;
      5'b00010: n1720 = m_new_frame_energy_idx;
      5'b00001: n1720 = m_new_frame_energy_idx;
      default: n1720 = m_new_frame_energy_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1721 = tmp_new_frame_pitch_idx;
      5'b01000: n1721 = m_new_frame_pitch_idx;
      5'b00100: n1721 = m_new_frame_pitch_idx;
      5'b00010: n1721 = m_new_frame_pitch_idx;
      5'b00001: n1721 = m_new_frame_pitch_idx;
      default: n1721 = m_new_frame_pitch_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1722 = m_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1723 = n1715;
      5'b01000: n1723 = n1722;
      5'b00100: n1723 = n1722;
      5'b00010: n1723 = n1722;
      5'b00001: n1723 = n1722;
      default: n1723 = n1722;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1724 = m_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1725 = n1714;
      5'b01000: n1725 = n1724;
      5'b00100: n1725 = n1724;
      5'b00010: n1725 = n1724;
      5'b00001: n1725 = n1724;
      default: n1725 = n1724;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1726 = m_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1727 = n1713;
      5'b01000: n1727 = n1726;
      5'b00100: n1727 = n1726;
      5'b00010: n1727 = n1726;
      5'b00001: n1727 = n1726;
      default: n1727 = n1726;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1728 = m_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1729 = n1712;
      5'b01000: n1729 = n1728;
      5'b00100: n1729 = n1728;
      5'b00010: n1729 = n1728;
      5'b00001: n1729 = n1728;
      default: n1729 = n1728;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1730 = m_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1731 = n1711;
      5'b01000: n1731 = n1730;
      5'b00100: n1731 = n1730;
      5'b00010: n1731 = n1730;
      5'b00001: n1731 = n1730;
      default: n1731 = n1730;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1732 = m_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1733 = n1710;
      5'b01000: n1733 = n1732;
      5'b00100: n1733 = n1732;
      5'b00010: n1733 = n1732;
      5'b00001: n1733 = n1732;
      default: n1733 = n1732;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1734 = m_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1735 = n1709;
      5'b01000: n1735 = n1734;
      5'b00100: n1735 = n1734;
      5'b00010: n1735 = n1734;
      5'b00001: n1735 = n1734;
      default: n1735 = n1734;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1736 = m_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1737 = n1708;
      5'b01000: n1737 = n1736;
      5'b00100: n1737 = n1736;
      5'b00010: n1737 = n1736;
      5'b00001: n1737 = n1736;
      default: n1737 = n1736;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1738 = m_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1739 = n1707;
      5'b01000: n1739 = n1738;
      5'b00100: n1739 = n1738;
      5'b00010: n1739 = n1738;
      5'b00001: n1739 = n1738;
      default: n1739 = n1738;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1740 = m_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1741 = n1706;
      5'b01000: n1741 = n1740;
      5'b00100: n1741 = n1740;
      5'b00010: n1741 = n1740;
      5'b00001: n1741 = n1740;
      default: n1741 = n1740;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1742 = tmp_new_frame_energy_idx;
      5'b01000: n1742 = tmp_new_frame_energy_idx;
      5'b00100: n1742 = tmp_new_frame_energy_idx;
      5'b00010: n1742 = tmp_new_frame_energy_idx;
      5'b00001: n1742 = n1451;
      default: n1742 = tmp_new_frame_energy_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1743 = tmp_new_frame_pitch_idx;
      5'b01000: n1743 = tmp_new_frame_pitch_idx;
      5'b00100: n1743 = tmp_new_frame_pitch_idx;
      5'b00010: n1743 = n1488;
      5'b00001: n1743 = tmp_new_frame_pitch_idx;
      default: n1743 = tmp_new_frame_pitch_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1744 = tmp_new_frame_k_idx;
      5'b01000: n1744 = n1691;
      5'b00100: n1744 = n1592;
      5'b00010: n1744 = tmp_new_frame_k_idx;
      5'b00001: n1744 = tmp_new_frame_k_idx;
      default: n1744 = tmp_new_frame_k_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1746 = 1'b0;
      5'b01000: n1746 = n1699;
      5'b00100: n1746 = n1600;
      5'b00010: n1746 = n1499;
      5'b00001: n1746 = n1454;
      default: n1746 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1748 = 1'b0;
      5'b01000: n1748 = m_new_frame_voiced;
      5'b00100: n1748 = m_new_frame_voiced;
      5'b00010: n1748 = n1484;
      5'b00001: n1748 = n1455;
      default: n1748 = m_new_frame_voiced;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1750 = 1'b0;
      5'b01000: n1750 = m_new_frame_unvoiced;
      5'b00100: n1750 = m_new_frame_unvoiced;
      5'b00010: n1750 = n1486;
      5'b00001: n1750 = m_new_frame_unvoiced;
      default: n1750 = m_new_frame_unvoiced;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1751 = m_new_frame_repeat;
      5'b01000: n1751 = m_new_frame_repeat;
      5'b00100: n1751 = m_new_frame_repeat;
      5'b00010: n1751 = n1494;
      5'b00001: n1751 = m_new_frame_repeat;
      default: n1751 = m_new_frame_repeat;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1753 = 1'b0;
      5'b01000: n1753 = m_new_frame_zero;
      5'b00100: n1753 = m_new_frame_zero;
      5'b00010: n1753 = m_new_frame_zero;
      5'b00001: n1753 = n1456;
      default: n1753 = m_new_frame_zero;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1755 = 1'b0;
      5'b01000: n1755 = m_new_frame_stop;
      5'b00100: n1755 = m_new_frame_stop;
      5'b00010: n1755 = m_new_frame_stop;
      5'b00001: n1755 = n1457;
      default: n1755 = m_new_frame_stop;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:791:33 */
  always @*
    case (n1718)
      5'b10000: n1756 = n1391;
      5'b01000: n1756 = n1695;
      5'b00100: n1756 = n1596;
      5'b00010: n1756 = n1495;
      5'b00001: n1756 = n1458;
      default: n1756 = n1391;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:39 */
  assign n1763 = m_fifo_ptr[6:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:39 */
  assign n1765 = n1763 + 7'b1111000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:893:58 */
  assign n1768 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:893:58 */
  assign n1770 = n1768 - 32'b00000000000000000000000000001000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:893:47 */
  assign n1771 = n1770[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:890:25 */
  assign n1772 = m_wr_pending ? n1771 : n1387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:890:25 */
  assign n1774 = m_wr_pending ? 1'b0 : n1388;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:890:25 */
  assign n1775 = m_wr_pending ? n3302 : n1391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1776 = n1420 ? n1719 : n1772;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1777 = n1420 ? n1720 : m_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1778 = n1420 ? n1721 : m_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1779 = {n1741, n1739, n1737, n1735, n1733, n1731, n1729, n1727, n1725, n1723};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1780 = n1420 ? n1779 : m_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1781 = n1420 ? n1742 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1782 = n1420 ? n1743 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1783 = n1420 ? n1744 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1785 = n1420 ? n1746 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1786 = n1420 ? n1388 : n1774;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1787 = n1420 ? n1748 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1788 = n1420 ? n1750 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1789 = n1420 ? n1751 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1790 = n1420 ? n1753 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1791 = n1420 ? n1755 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:789:25 */
  assign n1792 = n1420 ? n1756 : n1775;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1793 = n1408 ? n1387 : n1776;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1795 = n1408 ? 4'b0000 : n1777;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1797 = n1408 ? 7'b0000000 : n1778;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1799 = n1408 ? 50'b00000000000000000000011110111101111001110011100111 : n1780;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1800 = n1408 ? tmp_new_frame_energy_idx : n1781;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1801 = n1408 ? tmp_new_frame_pitch_idx : n1782;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1803 = n1408 ? 50'b00000000000000000000011110111101111001110011100111 : n1783;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1805 = n1408 ? 1'b0 : n1785;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1807 = n1408 ? n1388 : n1786;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1808 = n1408 ? m_new_frame_voiced : n1787;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1809 = n1408 ? m_new_frame_unvoiced : n1788;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1810 = n1408 ? m_new_frame_repeat : n1789;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1811 = n1408 ? m_new_frame_zero : n1790;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1812 = n1408 ? m_new_frame_stop : n1791;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:25 */
  assign n1813 = n1408 ? n1391 : n1792;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:216:17 */
  assign n1849 = {n192, n188, n185, n183};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  assign n1850 = n170 ? n152 : m_ic;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  always @(posedge m_clk)
    n1851 <= n1850;
  initial
    n1851 = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  assign n1852 = n171 ? n164 : m_pc;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  always @(posedge m_clk)
    n1853 <= n1852;
  initial
    n1853 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  assign n1854 = n172 ? n125 : m_t;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  always @(posedge m_clk)
    n1855 <= n1854;
  initial
    n1855 = 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1856 = m_ena ? n1793 : m_fifo_ptr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1857 <= n1856;
  initial
    n1857 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:426:17 */
  assign n1858 = n389 ? n385 : m_pitch_count;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:426:17 */
  always @(posedge m_clk)
    n1859 <= n1858;
  initial
    n1859 = 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1860 = m_ena ? n1795 : m_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1861 <= n1860;
  initial
    n1861 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1862 = m_ena ? n1797 : m_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1863 <= n1862;
  initial
    n1863 = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1864 = m_ena ? n1799 : m_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1865 <= n1864;
  initial
    n1865 = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1866 = m_ena ? n1800 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1867 <= n1866;
  initial
    n1867 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1868 = m_ena ? n1801 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1869 <= n1868;
  initial
    n1869 = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1870 = m_ena ? n1803 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1871 <= n1870;
  initial
    n1871 = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  assign n1872 = m_ena ? n1164 : m_u;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  always @(posedge m_clk)
    n1873 <= n1872;
  initial
    n1873 = 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  assign n1874 = m_ena ? n1166 : m_x;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  always @(posedge m_clk)
    n1875 <= n1874;
  initial
    n1875 = 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  assign n1876 = m_ena ? n260 : m_wr_busy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  always @(posedge m_clk)
    n1877 <= n1876;
  initial
    n1877 = 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  assign n1878 = m_ena ? n262 : m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  always @(posedge m_clk)
    n1879 <= n1878;
  initial
    n1879 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  assign n1880 = m_ena ? n264 : m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  always @(posedge m_clk)
    n1881 <= n1880;
  initial
    n1881 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  assign n1882 = n1225 ? n1186 : m_cmd_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  always @(posedge m_clk)
    n1883 <= n1882;
  initial
    n1883 = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  assign n1884 = n173 ? n133 : m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  always @(posedge m_clk)
    n1885 <= n1884;
  initial
    n1885 = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:703:17 */
  assign n1886 = m_ena ? n1242 : m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:703:17 */
  always @(posedge m_clk)
    n1887 <= n1886;
  initial
    n1887 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:511:17 */
  assign n1888 = m_ena ? n528 : m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:511:17 */
  always @(posedge m_clk)
    n1889 <= n1888;
  initial
    n1889 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:511:17 */
  assign n1890 = m_ena ? n530 : m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:511:17 */
  always @(posedge m_clk)
    n1891 <= n1890;
  initial
    n1891 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  assign n1892 = n417 ? n406 : m_rdb_clr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  always @(posedge m_clk)
    n1893 <= n1892;
  initial
    n1893 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  assign n1894 = m_ena ? n1217 : m_rdb_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  always @(posedge m_clk)
    n1895 <= n1894;
  initial
    n1895 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:376:17 */
  assign n1896 = m_ena ? n282 : m_rdb_flag;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:376:17 */
  always @(posedge m_clk)
    n1897 <= n1896;
  initial
    n1897 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  assign n1898 = m_ena ? n1220 : m_rst_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  always @(posedge m_clk)
    n1899 <= n1898;
  initial
    n1899 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  assign n1900 = m_ena ? n1223 : m_sxt_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:17 */
  always @(posedge m_clk)
    n1901 <= n1900;
  initial
    n1901 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  assign n1902 = m_ena ? m_rsn : m_rsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  always @(posedge m_clk)
    n1903 <= n1902;
  initial
    n1903 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:495:17 */
  assign n1904 = m_ena ? n483 : m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:495:17 */
  always @(posedge m_clk)
    n1905 <= n1904;
  initial
    n1905 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:330:17 */
  assign n1906 = n197 ? n206 : m_t11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:330:17 */
  always @(negedge m_clk)
    n1907 <= n1906;
  initial
    n1907 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:536:17 */
  assign n1908 = m_ena ? n581 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:536:17 */
  always @(posedge m_clk)
    n1909 <= n1908;
  initial
    n1909 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  assign n1910 = m_ena ? m_talk : m_talk_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  always @(posedge m_clk)
    n1911 <= n1910;
  initial
    n1911 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:536:17 */
  assign n1912 = m_ena ? n573 : m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:536:17 */
  always @(posedge m_clk)
    n1913 <= n1912;
  initial
    n1913 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:703:17 */
  assign n1914 = m_ena ? m_talkd : m_talkd_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:703:17 */
  always @(posedge m_clk)
    n1915 <= n1914;
  initial
    n1915 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1916 = m_ena ? n1805 : m_uf;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1917 <= n1916;
  initial
    n1917 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1918 = m_ena ? m_wsn : m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1919 <= n1918;
  initial
    n1919 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1920 = m_ena ? n1807 : m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1921 <= n1920;
  initial
    n1921 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  assign n1922 = m_ena ? m_buffer_empty : m_buffer_empty_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  always @(posedge m_clk)
    n1923 <= n1922;
  initial
    n1923 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  assign n1924 = m_ena ? m_buffer_low : m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  always @(posedge m_clk)
    n1925 <= n1924;
  initial
    n1925 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  assign n1926 = n174 ? m_cyca : m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  always @(posedge m_clk)
    n1927 <= n1926;
  initial
    n1927 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:717:17 */
  assign n1928 = m_ena ? n1291 : m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:717:17 */
  always @(posedge m_clk)
    n1929 <= n1928;
  initial
    n1929 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  assign n1930 = m_ena ? n266 : m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:349:17 */
  always @(posedge m_clk)
    n1931 <= n1930;
  initial
    n1931 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  assign n1932 = m_ena ? n300 : m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:389:17 */
  always @(posedge m_clk)
    n1933 <= n1932;
  initial
    n1933 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  assign n1934 = m_ena ? n414 : m_irq_pin_clr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  always @(posedge m_clk)
    n1935 <= n1934;
  initial
    n1935 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1936 = m_ena ? n1808 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1937 <= n1936;
  initial
    n1937 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1938 = m_ena ? n1809 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1939 <= n1938;
  initial
    n1939 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1940 = m_ena ? n1810 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1941 <= n1940;
  initial
    n1941 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1942 = m_ena ? n1811 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1943 <= n1942;
  initial
    n1943 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1944 = m_ena ? n1812 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1945 <= n1944;
  initial
    n1945 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:426:17 */
  assign n1946 = n390 ? n366 : m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:426:17 */
  always @(posedge m_clk)
    n1947 <= n1946;
  initial
    n1947 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:17 */
  assign n1948 = m_ena ? n1349 : m_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:17 */
  always @(posedge m_clk)
    n1949 <= n1948;
  initial
    n1949 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:17 */
  assign n1950 = m_ena ? n1350 : m_uv_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:17 */
  always @(posedge m_clk)
    n1951 <= n1950;
  initial
    n1951 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  assign n1952 = m_ena ? n114 : phictr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:17 */
  always @(posedge m_clk)
    n1953 <= n1952;
  initial
    n1953 = 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1954 = m_ena ? n1389 : m_wr_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1955 <= n1954;
  initial
    n1955 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  assign n1956 = n420 ? n411 : m_dbo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  always @(posedge m_clk)
    n1957 <= n1956;
  initial
    n1957 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:330:17 */
  assign n1958 = n197 ? n207 : m_shift;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:330:17 */
  always @(negedge m_clk)
    n1959 <= n1958;
  initial
    n1959 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:409:17 */
  assign n1960 = m_ena ? n326 : m_rng;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:409:17 */
  always @(posedge m_clk)
    n1961 <= n1960;
  initial
    n1961 = 13'b1111111111111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:471:17 */
  assign n1962 = n452 ? n450 : m_excitation_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:471:17 */
  always @(posedge m_clk)
    n1963 <= n1962;
  initial
    n1963 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  assign n1964 = m_ena ? n1168 : m_previous_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  always @(posedge m_clk)
    n1965 <= n1964;
  initial
    n1965 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:566:17 */
  assign n1966 = m_ena ? n814 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:566:17 */
  always @(posedge m_clk)
    n1967 <= n1966;
  initial
    n1967 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:566:17 */
  assign n1968 = m_ena ? n816 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:566:17 */
  always @(posedge m_clk)
    n1969 <= n1968;
  initial
    n1969 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  assign n1970 = m_ena ? n1169 : this_sample;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:17 */
  always @(posedge m_clk)
    n1971 <= n1970;
  initial
    n1971 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:566:17 */
  assign n1972 = m_ena ? n817 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:566:17 */
  always @(posedge m_clk)
    n1973 <= n1972;
  initial
    n1973 = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  assign n1974 = m_ena ? n1813 : m_fifo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:761:17 */
  always @(posedge m_clk)
    n1975 <= n1974;
  initial
    n1975 = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:485:81 */
  reg [6:0] n1976[51:0] ; // memory
  initial begin
    n1976[51] = 7'b0000000;
    n1976[50] = 7'b0000000;
    n1976[49] = 7'b0000000;
    n1976[48] = 7'b0000000;
    n1976[47] = 7'b0000000;
    n1976[46] = 7'b0000000;
    n1976[45] = 7'b0000000;
    n1976[44] = 7'b0000000;
    n1976[43] = 7'b0000000;
    n1976[42] = 7'b0000000;
    n1976[41] = 7'b0000000;
    n1976[40] = 7'b0000000;
    n1976[39] = 7'b0000000;
    n1976[38] = 7'b0000000;
    n1976[37] = 7'b0000000;
    n1976[36] = 7'b0000000;
    n1976[35] = 7'b0000000;
    n1976[34] = 7'b0000000;
    n1976[33] = 7'b0000000;
    n1976[32] = 7'b0000000;
    n1976[31] = 7'b0000000;
    n1976[30] = 7'b0000000;
    n1976[29] = 7'b0000000;
    n1976[28] = 7'b0000000;
    n1976[27] = 7'b0000000;
    n1976[26] = 7'b0000000;
    n1976[25] = 7'b0000000;
    n1976[24] = 7'b0000000;
    n1976[23] = 7'b0000000;
    n1976[22] = 7'b0000000;
    n1976[21] = 7'b0000000;
    n1976[20] = 7'b0011101;
    n1976[19] = 7'b0011111;
    n1976[18] = 7'b0100101;
    n1976[17] = 7'b0011010;
    n1976[16] = 7'b0110111;
    n1976[15] = 7'b0010011;
    n1976[14] = 7'b0111011;
    n1976[13] = 7'b0110010;
    n1976[12] = 7'b0011010;
    n1976[11] = 7'b1000100;
    n1976[10] = 7'b1001100;
    n1976[9] = 7'b0100110;
    n1976[8] = 7'b0100101;
    n1976[7] = 7'b1010000;
    n1976[6] = 7'b1110001;
    n1976[5] = 7'b1101100;
    n1976[4] = 7'b1001100;
    n1976[3] = 7'b0101000;
    n1976[2] = 7'b0001111;
    n1976[1] = 7'b0000011;
    n1976[0] = 7'b0000000;
    end
  assign n1978 = n1976[n441];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:485:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:102 */
  reg [6:0] n1979[15:0] ; // memory
  initial begin
    n1979[15] = 7'b0000000;
    n1979[14] = 7'b1110010;
    n1979[13] = 7'b1010101;
    n1979[12] = 7'b0111111;
    n1979[11] = 7'b0101111;
    n1979[10] = 7'b0100001;
    n1979[9] = 7'b0010111;
    n1979[8] = 7'b0010000;
    n1979[7] = 7'b0001011;
    n1979[6] = 7'b0001000;
    n1979[5] = 7'b0000110;
    n1979[4] = 7'b0000100;
    n1979[3] = 7'b0000011;
    n1979[2] = 7'b0000010;
    n1979[1] = 7'b0000001;
    n1979[0] = 7'b0000000;
    end
  assign n1981 = n1979[m_new_frame_energy_idx];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:102 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:163 */
  reg [1:0] n1982[7:0] ; // memory
  initial begin
    n1982[7] = 2'b01;
    n1982[6] = 2'b01;
    n1982[5] = 2'b10;
    n1982[4] = 2'b10;
    n1982[3] = 2'b11;
    n1982[2] = 2'b11;
    n1982[1] = 2'b11;
    n1982[0] = 2'b00;
    end
  assign n1984 = n1982[m_ic];
  assign n1985 = n1982[m_ic];
  assign n1986 = n1982[m_ic];
  assign n1987 = n1982[m_ic];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:186 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:178 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:161 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:579:163 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:101 */
  reg [7:0] n1988[63:0] ; // memory
  initial begin
    n1988[63] = 8'b10011111;
    n1988[62] = 8'b10011001;
    n1988[61] = 8'b10010100;
    n1988[60] = 8'b10001110;
    n1988[59] = 8'b10001001;
    n1988[58] = 8'b10000100;
    n1988[57] = 8'b01111111;
    n1988[56] = 8'b01111010;
    n1988[55] = 8'b01110110;
    n1988[54] = 8'b01110010;
    n1988[53] = 8'b01101101;
    n1988[52] = 8'b01101001;
    n1988[51] = 8'b01100101;
    n1988[50] = 8'b01100010;
    n1988[49] = 8'b01011110;
    n1988[48] = 8'b01011011;
    n1988[47] = 8'b01010110;
    n1988[46] = 8'b01010100;
    n1988[45] = 8'b01010000;
    n1988[44] = 8'b01001110;
    n1988[43] = 8'b01001100;
    n1988[42] = 8'b01001000;
    n1988[41] = 8'b01000110;
    n1988[40] = 8'b01000100;
    n1988[39] = 8'b01000001;
    n1988[38] = 8'b00111110;
    n1988[37] = 8'b00111100;
    n1988[36] = 8'b00111010;
    n1988[35] = 8'b00111000;
    n1988[34] = 8'b00110101;
    n1988[33] = 8'b00110100;
    n1988[32] = 8'b00110010;
    n1988[31] = 8'b00110000;
    n1988[30] = 8'b00101110;
    n1988[29] = 8'b00101100;
    n1988[28] = 8'b00101010;
    n1988[27] = 8'b00101001;
    n1988[26] = 8'b00101000;
    n1988[25] = 8'b00100111;
    n1988[24] = 8'b00100110;
    n1988[23] = 8'b00100101;
    n1988[22] = 8'b00100100;
    n1988[21] = 8'b00100011;
    n1988[20] = 8'b00100010;
    n1988[19] = 8'b00100001;
    n1988[18] = 8'b00100000;
    n1988[17] = 8'b00011111;
    n1988[16] = 8'b00011110;
    n1988[15] = 8'b00011101;
    n1988[14] = 8'b00011100;
    n1988[13] = 8'b00011011;
    n1988[12] = 8'b00011010;
    n1988[11] = 8'b00011001;
    n1988[10] = 8'b00011000;
    n1988[9] = 8'b00010111;
    n1988[8] = 8'b00010110;
    n1988[7] = 8'b00010101;
    n1988[6] = 8'b00010100;
    n1988[5] = 8'b00010011;
    n1988[4] = 8'b00010010;
    n1988[3] = 8'b00010001;
    n1988[2] = 8'b00010000;
    n1988[1] = 8'b00001111;
    n1988[0] = 8'b00000000;
    end
  assign n1990 = n1988[n633];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:101 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:100 */
  reg [9:0] n1991[319:0] ; // memory
  initial begin
    n1991[319] = 10'b1000001011;
    n1991[318] = 10'b1000001110;
    n1991[317] = 10'b1000001111;
    n1991[316] = 10'b1000010001;
    n1991[315] = 10'b1000010011;
    n1991[314] = 10'b1000010101;
    n1991[313] = 10'b1000011000;
    n1991[312] = 10'b1000011110;
    n1991[311] = 10'b1000100010;
    n1991[310] = 10'b1000100110;
    n1991[309] = 10'b1000101011;
    n1991[308] = 10'b1000110000;
    n1991[307] = 10'b1000110101;
    n1991[306] = 10'b1000111100;
    n1991[305] = 10'b1001000011;
    n1991[304] = 10'b1001001011;
    n1991[303] = 10'b1001100100;
    n1991[302] = 10'b1010000100;
    n1991[301] = 10'b1010101101;
    n1991[300] = 10'b1011100000;
    n1991[299] = 10'b1100011101;
    n1991[298] = 10'b1101100010;
    n1991[297] = 10'b1110101111;
    n1991[296] = 10'b1111111111;
    n1991[295] = 10'b0001010000;
    n1991[294] = 10'b0010011101;
    n1991[293] = 10'b0011100010;
    n1991[292] = 10'b0100011111;
    n1991[291] = 10'b0101010001;
    n1991[290] = 10'b0101111011;
    n1991[289] = 10'b0110011011;
    n1991[288] = 10'b0110110100;
    n1991[287] = 10'b1010111000;
    n1991[286] = 10'b1011010001;
    n1991[285] = 10'b1011101110;
    n1991[284] = 10'b1100001100;
    n1991[283] = 10'b1100101101;
    n1991[282] = 10'b1101010001;
    n1991[281] = 10'b1101110110;
    n1991[280] = 10'b1110011101;
    n1991[279] = 10'b1111000101;
    n1991[278] = 10'b1111101110;
    n1991[277] = 10'b0000011000;
    n1991[276] = 10'b0001000000;
    n1991[275] = 10'b0001101001;
    n1991[274] = 10'b0010001111;
    n1991[273] = 10'b0010110100;
    n1991[272] = 10'b0011010111;
    n1991[271] = 10'b0011111000;
    n1991[270] = 10'b0100010110;
    n1991[269] = 10'b0100110010;
    n1991[268] = 10'b0101001011;
    n1991[267] = 10'b0101100010;
    n1991[266] = 10'b0101110110;
    n1991[265] = 10'b0110001000;
    n1991[264] = 10'b0110011000;
    n1991[263] = 10'b0110100110;
    n1991[262] = 10'b0110110011;
    n1991[261] = 10'b0110111101;
    n1991[260] = 10'b0111000111;
    n1991[259] = 10'b0111001111;
    n1991[258] = 10'b0111010110;
    n1991[257] = 10'b0111011100;
    n1991[256] = 10'b0111111010;
    n1991[255] = 10'b1001000111;
    n1991[254] = 10'b1001111101;
    n1991[253] = 10'b1010110011;
    n1991[252] = 10'b1011101001;
    n1991[251] = 10'b1100011111;
    n1991[250] = 10'b1101010101;
    n1991[249] = 10'b1110001011;
    n1991[248] = 10'b1111000001;
    n1991[247] = 10'b1111110111;
    n1991[246] = 10'b0000101101;
    n1991[245] = 10'b0001100010;
    n1991[244] = 10'b0010011000;
    n1991[243] = 10'b0011001110;
    n1991[242] = 10'b0100000100;
    n1991[241] = 10'b0100111010;
    n1991[240] = 10'b0101110000;
    n1991[239] = 10'b0000000000;
    n1991[238] = 10'b0000000000;
    n1991[237] = 10'b0000000000;
    n1991[236] = 10'b0000000000;
    n1991[235] = 10'b0000000000;
    n1991[234] = 10'b0000000000;
    n1991[233] = 10'b0000000000;
    n1991[232] = 10'b0000000000;
    n1991[231] = 10'b0000000000;
    n1991[230] = 10'b0000000000;
    n1991[229] = 10'b0000000000;
    n1991[228] = 10'b0000000000;
    n1991[227] = 10'b0000000000;
    n1991[226] = 10'b0000000000;
    n1991[225] = 10'b0000000000;
    n1991[224] = 10'b0000000000;
    n1991[223] = 10'b1010111000;
    n1991[222] = 10'b1011101111;
    n1991[221] = 10'b1100100111;
    n1991[220] = 10'b1101011111;
    n1991[219] = 10'b1110010110;
    n1991[218] = 10'b1111001110;
    n1991[217] = 10'b0000000101;
    n1991[216] = 10'b0000111101;
    n1991[215] = 10'b0001110100;
    n1991[214] = 10'b0010101100;
    n1991[213] = 10'b0011100100;
    n1991[212] = 10'b0100011011;
    n1991[211] = 10'b0101010011;
    n1991[210] = 10'b0110001010;
    n1991[209] = 10'b0111000010;
    n1991[208] = 10'b0111111010;
    n1991[207] = 10'b0000000000;
    n1991[206] = 10'b0000000000;
    n1991[205] = 10'b0000000000;
    n1991[204] = 10'b0000000000;
    n1991[203] = 10'b0000000000;
    n1991[202] = 10'b0000000000;
    n1991[201] = 10'b0000000000;
    n1991[200] = 10'b0000000000;
    n1991[199] = 10'b0000000000;
    n1991[198] = 10'b0000000000;
    n1991[197] = 10'b0000000000;
    n1991[196] = 10'b0000000000;
    n1991[195] = 10'b0000000000;
    n1991[194] = 10'b0000000000;
    n1991[193] = 10'b0000000000;
    n1991[192] = 10'b0000000000;
    n1991[191] = 10'b1010111000;
    n1991[190] = 10'b1011100110;
    n1991[189] = 10'b1100010101;
    n1991[188] = 10'b1101000011;
    n1991[187] = 10'b1101110010;
    n1991[186] = 10'b1110100000;
    n1991[185] = 10'b1111001110;
    n1991[184] = 10'b1111111101;
    n1991[183] = 10'b0000101011;
    n1991[182] = 10'b0001011010;
    n1991[181] = 10'b0010001000;
    n1991[180] = 10'b0010110110;
    n1991[179] = 10'b0011100101;
    n1991[178] = 10'b0100010011;
    n1991[177] = 10'b0101000010;
    n1991[176] = 10'b0101110000;
    n1991[175] = 10'b0000000000;
    n1991[174] = 10'b0000000000;
    n1991[173] = 10'b0000000000;
    n1991[172] = 10'b0000000000;
    n1991[171] = 10'b0000000000;
    n1991[170] = 10'b0000000000;
    n1991[169] = 10'b0000000000;
    n1991[168] = 10'b0000000000;
    n1991[167] = 10'b0000000000;
    n1991[166] = 10'b0000000000;
    n1991[165] = 10'b0000000000;
    n1991[164] = 10'b0000000000;
    n1991[163] = 10'b0000000000;
    n1991[162] = 10'b0000000000;
    n1991[161] = 10'b0000000000;
    n1991[160] = 10'b0000000000;
    n1991[159] = 10'b1100000000;
    n1991[158] = 10'b1100101100;
    n1991[157] = 10'b1101011000;
    n1991[156] = 10'b1110000101;
    n1991[155] = 10'b1110110001;
    n1991[154] = 10'b1111011101;
    n1991[153] = 10'b0000001010;
    n1991[152] = 10'b0000110110;
    n1991[151] = 10'b0001100010;
    n1991[150] = 10'b0010001111;
    n1991[149] = 10'b0010111011;
    n1991[148] = 10'b0011101000;
    n1991[147] = 10'b0100010100;
    n1991[146] = 10'b0101000000;
    n1991[145] = 10'b0101101101;
    n1991[144] = 10'b0110011001;
    n1991[143] = 10'b0000000000;
    n1991[142] = 10'b0000000000;
    n1991[141] = 10'b0000000000;
    n1991[140] = 10'b0000000000;
    n1991[139] = 10'b0000000000;
    n1991[138] = 10'b0000000000;
    n1991[137] = 10'b0000000000;
    n1991[136] = 10'b0000000000;
    n1991[135] = 10'b0000000000;
    n1991[134] = 10'b0000000000;
    n1991[133] = 10'b0000000000;
    n1991[132] = 10'b0000000000;
    n1991[131] = 10'b0000000000;
    n1991[130] = 10'b0000000000;
    n1991[129] = 10'b0000000000;
    n1991[128] = 10'b0000000000;
    n1991[127] = 10'b1011001100;
    n1991[126] = 10'b1011111100;
    n1991[125] = 10'b1100101100;
    n1991[124] = 10'b1101011100;
    n1991[123] = 10'b1110001011;
    n1991[122] = 10'b1110111011;
    n1991[121] = 10'b1111101011;
    n1991[120] = 10'b0000011011;
    n1991[119] = 10'b0001001011;
    n1991[118] = 10'b0001111010;
    n1991[117] = 10'b0010101010;
    n1991[116] = 10'b0011011010;
    n1991[115] = 10'b0100001010;
    n1991[114] = 10'b0100111010;
    n1991[113] = 10'b0101101001;
    n1991[112] = 10'b0110011001;
    n1991[111] = 10'b0000000000;
    n1991[110] = 10'b0000000000;
    n1991[109] = 10'b0000000000;
    n1991[108] = 10'b0000000000;
    n1991[107] = 10'b0000000000;
    n1991[106] = 10'b0000000000;
    n1991[105] = 10'b0000000000;
    n1991[104] = 10'b0000000000;
    n1991[103] = 10'b0000000000;
    n1991[102] = 10'b0000000000;
    n1991[101] = 10'b0000000000;
    n1991[100] = 10'b0000000000;
    n1991[99] = 10'b0000000000;
    n1991[98] = 10'b0000000000;
    n1991[97] = 10'b0000000000;
    n1991[96] = 10'b0000000000;
    n1991[95] = 10'b1100000000;
    n1991[94] = 10'b1101011111;
    n1991[93] = 10'b1110111110;
    n1991[92] = 10'b0000011101;
    n1991[91] = 10'b0001111100;
    n1991[90] = 10'b0011011011;
    n1991[89] = 10'b0100111010;
    n1991[88] = 10'b0110011001;
    n1991[87] = 10'b0000000000;
    n1991[86] = 10'b0000000000;
    n1991[85] = 10'b0000000000;
    n1991[84] = 10'b0000000000;
    n1991[83] = 10'b0000000000;
    n1991[82] = 10'b0000000000;
    n1991[81] = 10'b0000000000;
    n1991[80] = 10'b0000000000;
    n1991[79] = 10'b0000000000;
    n1991[78] = 10'b0000000000;
    n1991[77] = 10'b0000000000;
    n1991[76] = 10'b0000000000;
    n1991[75] = 10'b0000000000;
    n1991[74] = 10'b0000000000;
    n1991[73] = 10'b0000000000;
    n1991[72] = 10'b0000000000;
    n1991[71] = 10'b0000000000;
    n1991[70] = 10'b0000000000;
    n1991[69] = 10'b0000000000;
    n1991[68] = 10'b0000000000;
    n1991[67] = 10'b0000000000;
    n1991[66] = 10'b0000000000;
    n1991[65] = 10'b0000000000;
    n1991[64] = 10'b0000000000;
    n1991[63] = 10'b1100000000;
    n1991[62] = 10'b1101010000;
    n1991[61] = 10'b1110100000;
    n1991[60] = 10'b1111110001;
    n1991[59] = 10'b0001000001;
    n1991[58] = 10'b0010010010;
    n1991[57] = 10'b0011100010;
    n1991[56] = 10'b0100110011;
    n1991[55] = 10'b0000000000;
    n1991[54] = 10'b0000000000;
    n1991[53] = 10'b0000000000;
    n1991[52] = 10'b0000000000;
    n1991[51] = 10'b0000000000;
    n1991[50] = 10'b0000000000;
    n1991[49] = 10'b0000000000;
    n1991[48] = 10'b0000000000;
    n1991[47] = 10'b0000000000;
    n1991[46] = 10'b0000000000;
    n1991[45] = 10'b0000000000;
    n1991[44] = 10'b0000000000;
    n1991[43] = 10'b0000000000;
    n1991[42] = 10'b0000000000;
    n1991[41] = 10'b0000000000;
    n1991[40] = 10'b0000000000;
    n1991[39] = 10'b0000000000;
    n1991[38] = 10'b0000000000;
    n1991[37] = 10'b0000000000;
    n1991[36] = 10'b0000000000;
    n1991[35] = 10'b0000000000;
    n1991[34] = 10'b0000000000;
    n1991[33] = 10'b0000000000;
    n1991[32] = 10'b0000000000;
    n1991[31] = 10'b1100110011;
    n1991[30] = 10'b1101111100;
    n1991[29] = 10'b1111000101;
    n1991[28] = 10'b0000001110;
    n1991[27] = 10'b0001010111;
    n1991[26] = 10'b0010100000;
    n1991[25] = 10'b0011101010;
    n1991[24] = 10'b0100110011;
    n1991[23] = 10'b0000000000;
    n1991[22] = 10'b0000000000;
    n1991[21] = 10'b0000000000;
    n1991[20] = 10'b0000000000;
    n1991[19] = 10'b0000000000;
    n1991[18] = 10'b0000000000;
    n1991[17] = 10'b0000000000;
    n1991[16] = 10'b0000000000;
    n1991[15] = 10'b0000000000;
    n1991[14] = 10'b0000000000;
    n1991[13] = 10'b0000000000;
    n1991[12] = 10'b0000000000;
    n1991[11] = 10'b0000000000;
    n1991[10] = 10'b0000000000;
    n1991[9] = 10'b0000000000;
    n1991[8] = 10'b0000000000;
    n1991[7] = 10'b0000000000;
    n1991[6] = 10'b0000000000;
    n1991[5] = 10'b0000000000;
    n1991[4] = 10'b0000000000;
    n1991[3] = 10'b0000000000;
    n1991[2] = 10'b0000000000;
    n1991[1] = 10'b0000000000;
    n1991[0] = 10'b0000000000;
    end
  assign n1993 = n1991[n1992];
  assign n1995 = n1991[n1994];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:133 */
  assign n1992 = {n762, n773};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:111 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:125 */
  assign n1994 = {n683, n694};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:98 */
  reg [2:0] n1996[9:0] ; // memory
  initial begin
    n1996[9] = 3'b011;
    n1996[8] = 3'b011;
    n1996[7] = 3'b011;
    n1996[6] = 3'b100;
    n1996[5] = 3'b100;
    n1996[4] = 3'b100;
    n1996[3] = 3'b100;
    n1996[2] = 3'b100;
    n1996[1] = 3'b101;
    n1996[0] = 3'b101;
    end
  assign n1998 = n1996[n1637];
  assign n1999 = n1996[n1626];
  assign n2000 = n1996[n1613];
  assign n2001 = n1996[n1538];
  assign n2002 = n1996[n1527];
  assign n2003 = n1996[n1513];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:854:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:98 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:98 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:96 */
  assign n2005 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:96 */
  assign n2006 = n2005[n674 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:130 */
  assign n2008 = {30'bX, m_new_frame_k_idx};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:130 */
  assign n2009 = n2008[n690 * 5 +: 5]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:154 */
  assign n2011 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:154 */
  assign n2012 = n2011[n705 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2013 = n667[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2014 = ~n2013;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2015 = n667[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2016 = ~n2015;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2017 = n2014 & n2016;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2018 = n2014 & n2015;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2019 = n2013 & n2016;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2020 = n667[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2021 = ~n2020;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2022 = n2017 & n2021;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2023 = n2017 & n2020;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2024 = n2018 & n2021;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2025 = n2018 & n2020;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2026 = n2019 & n2021;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2027 = n667[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2028 = ~n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2029 = n2022 & n2028;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2030 = n2022 & n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2031 = n2023 & n2028;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2032 = n2023 & n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2033 = n2024 & n2028;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2034 = n2024 & n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2035 = n2025 & n2028;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2036 = n2025 & n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2037 = n2026 & n2028;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2038 = n2026 & n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2039 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2040 = n2029 ? n719 : n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2041 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2042 = n2030 ? n719 : n2041;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2043 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2044 = n2031 ? n719 : n2043;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2045 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2046 = n2032 ? n719 : n2045;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2047 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2048 = n2033 ? n719 : n2047;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2049 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2050 = n2034 ? n719 : n2049;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2051 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2052 = n2035 ? n719 : n2051;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2053 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2054 = n2036 ? n719 : n2053;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2055 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2056 = n2037 ? n719 : n2055;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2057 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2058 = n2038 ? n719 : n2057;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:57 */
  assign n2059 = {n2058, n2056, n2054, n2052, n2050, n2048, n2046, n2044, n2042, n2040};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2060 = n732[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2061 = ~n2060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2062 = n732[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2063 = ~n2062;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2064 = n2061 & n2063;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2065 = n2061 & n2062;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2066 = n2060 & n2063;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2067 = n732[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2068 = ~n2067;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2069 = n2064 & n2068;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2070 = n2064 & n2067;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2071 = n2065 & n2068;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2072 = n2065 & n2067;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2073 = n2066 & n2068;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2074 = n732[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2075 = ~n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2076 = n2069 & n2075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2077 = n2069 & n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2078 = n2070 & n2075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2079 = n2070 & n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2080 = n2071 & n2075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2081 = n2071 & n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2082 = n2072 & n2075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2083 = n2072 & n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2084 = n2073 & n2075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2085 = n2073 & n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2086 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2087 = n2076 ? 10'b0000000000 : n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2088 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2089 = n2077 ? 10'b0000000000 : n2088;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2090 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2091 = n2078 ? 10'b0000000000 : n2090;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2092 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2093 = n2079 ? 10'b0000000000 : n2092;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2094 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2095 = n2080 ? 10'b0000000000 : n2094;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2096 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2097 = n2081 ? 10'b0000000000 : n2096;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2098 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2099 = n2082 ? 10'b0000000000 : n2098;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2100 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2101 = n2083 ? 10'b0000000000 : n2100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2102 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2103 = n2084 ? 10'b0000000000 : n2102;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2104 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2105 = n2085 ? 10'b0000000000 : n2104;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:595:57 */
  assign n2106 = {n2105, n2103, n2101, n2099, n2097, n2095, n2093, n2091, n2089, n2087};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:104 */
  assign n2108 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:104 */
  assign n2109 = n2108[n753 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:138 */
  assign n2111 = {30'bX, m_new_frame_k_idx};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:138 */
  assign n2112 = n2111[n769 * 5 +: 5]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:162 */
  assign n2114 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:162 */
  assign n2115 = n2114[n783 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2116 = n746[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2117 = ~n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2118 = n746[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2119 = ~n2118;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2120 = n2117 & n2119;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2121 = n2117 & n2118;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2122 = n2116 & n2119;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2123 = n746[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2124 = ~n2123;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2125 = n2120 & n2124;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2126 = n2120 & n2123;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2127 = n2121 & n2124;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2128 = n2121 & n2123;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2129 = n2122 & n2124;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2130 = n746[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2131 = ~n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2132 = n2125 & n2131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2133 = n2125 & n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2134 = n2126 & n2131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2135 = n2126 & n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2136 = n2127 & n2131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2137 = n2127 & n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2138 = n2128 & n2131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2139 = n2128 & n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2140 = n2129 & n2131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2141 = n2129 & n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2142 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2143 = n2132 ? n797 : n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2144 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2145 = n2133 ? n797 : n2144;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2146 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2147 = n2134 ? n797 : n2146;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2148 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2149 = n2135 ? n797 : n2148;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2150 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2151 = n2136 ? n797 : n2150;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2152 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2153 = n2137 ? n797 : n2152;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2154 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2155 = n2138 ? n797 : n2154;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2156 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2157 = n2139 ? n797 : n2156;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2158 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2159 = n2140 ? n797 : n2158;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2160 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2161 = n2141 ? n797 : n2160;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:598:65 */
  assign n2162 = {n2161, n2159, n2157, n2155, n2153, n2151, n2149, n2147, n2145, n2143};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2163 = n1551[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2164 = ~n2163;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2165 = n1551[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2166 = ~n2165;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2167 = n2164 & n2166;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2168 = n2164 & n2165;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2169 = n2163 & n2166;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2170 = n1551[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2171 = ~n2170;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2172 = n2167 & n2171;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2173 = n2167 & n2170;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2174 = n2168 & n2171;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2175 = n2168 & n2170;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2176 = n2169 & n2171;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2177 = n1551[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2178 = ~n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2179 = n2172 & n2178;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2180 = n2172 & n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2181 = n2173 & n2178;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2182 = n2173 & n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2183 = n2174 & n2178;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2184 = n2174 & n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2185 = n2175 & n2178;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2186 = n2175 & n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2187 = n2176 & n2178;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2188 = n2176 & n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2189 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2190 = n2179 ? n1553 : n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2191 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2192 = n2180 ? n1553 : n2191;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2193 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2194 = n2181 ? n1553 : n2193;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2195 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2196 = n2182 ? n1553 : n2195;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2197 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2198 = n2183 ? n1553 : n2197;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2199 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2200 = n2184 ? n1553 : n2199;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2201 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2202 = n2185 ? n1553 : n2201;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2203 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2204 = n2186 ? n1553 : n2203;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2205 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2206 = n2187 ? n1553 : n2205;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2207 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2208 = n2188 ? n1553 : n2207;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:81 */
  assign n2209 = {n2208, n2206, n2204, n2202, n2200, n2198, n2196, n2194, n2192, n2190};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2210 = n1566[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2211 = ~n2210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2212 = n1566[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2213 = ~n2212;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2214 = n2211 & n2213;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2215 = n2211 & n2212;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2216 = n2210 & n2213;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2217 = n1566[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2218 = ~n2217;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2219 = n2214 & n2218;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2220 = n2214 & n2217;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2221 = n2215 & n2218;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2222 = n2215 & n2217;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2223 = n2216 & n2218;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2224 = n1566[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2225 = ~n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2226 = n2219 & n2225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2227 = n2219 & n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2228 = n2220 & n2225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2229 = n2220 & n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2230 = n2221 & n2225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2231 = n2221 & n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2232 = n2222 & n2225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2233 = n2222 & n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2234 = n2223 & n2225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2235 = n2223 & n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2236 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2237 = n2226 ? n1570 : n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2238 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2239 = n2227 ? n1570 : n2238;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2240 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2241 = n2228 ? n1570 : n2240;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2242 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2243 = n2229 ? n1570 : n2242;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2244 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2245 = n2230 ? n1570 : n2244;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2246 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2247 = n2231 ? n1570 : n2246;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2248 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2249 = n2232 ? n1570 : n2248;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2250 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2251 = n2233 ? n1570 : n2250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2252 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2253 = n2234 ? n1570 : n2252;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2254 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2255 = n2235 ? n1570 : n2254;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:838:81 */
  assign n2256 = {n2255, n2253, n2251, n2249, n2247, n2245, n2243, n2241, n2239, n2237};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2257 = n1582[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2258 = ~n2257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2259 = n1582[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2260 = ~n2259;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2261 = n2258 & n2260;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2262 = n2258 & n2259;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2263 = n2257 & n2260;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2264 = n1582[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2265 = ~n2264;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2266 = n2261 & n2265;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2267 = n2261 & n2264;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2268 = n2262 & n2265;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2269 = n2262 & n2264;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2270 = n2263 & n2265;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2271 = n1582[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2272 = ~n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2273 = n2266 & n2272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2274 = n2266 & n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2275 = n2267 & n2272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2276 = n2267 & n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2277 = n2268 & n2272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2278 = n2268 & n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2279 = n2269 & n2272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2280 = n2269 & n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2281 = n2270 & n2272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2282 = n2270 & n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2283 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2284 = n2273 ? n1586 : n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2285 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2286 = n2274 ? n1586 : n2285;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2287 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2288 = n2275 ? n1586 : n2287;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2289 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2290 = n2276 ? n1586 : n2289;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2291 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2292 = n2277 ? n1586 : n2291;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2293 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2294 = n2278 ? n1586 : n2293;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2295 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2296 = n2279 ? n1586 : n2295;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2297 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2298 = n2280 ? n1586 : n2297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2299 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2300 = n2281 ? n1586 : n2299;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2301 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2302 = n2282 ? n1586 : n2301;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:81 */
  assign n2303 = {n2302, n2300, n2298, n2296, n2294, n2292, n2290, n2288, n2286, n2284};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2304 = n1650[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2305 = ~n2304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2306 = n1650[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2307 = ~n2306;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2308 = n2305 & n2307;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2309 = n2305 & n2306;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2310 = n2304 & n2307;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2311 = n1650[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2312 = ~n2311;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2313 = n2308 & n2312;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2314 = n2308 & n2311;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2315 = n2309 & n2312;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2316 = n2309 & n2311;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2317 = n2310 & n2312;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2318 = n1650[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2319 = ~n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2320 = n2313 & n2319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2321 = n2313 & n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2322 = n2314 & n2319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2323 = n2314 & n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2324 = n2315 & n2319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2325 = n2315 & n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2326 = n2316 & n2319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2327 = n2316 & n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2328 = n2317 & n2319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2329 = n2317 & n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2330 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2331 = n2320 ? n1652 : n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2332 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2333 = n2321 ? n1652 : n2332;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2334 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2335 = n2322 ? n1652 : n2334;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2336 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2337 = n2323 ? n1652 : n2336;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2338 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2339 = n2324 ? n1652 : n2338;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2340 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2341 = n2325 ? n1652 : n2340;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2342 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2343 = n2326 ? n1652 : n2342;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2344 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2345 = n2327 ? n1652 : n2344;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2346 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2347 = n2328 ? n1652 : n2346;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2348 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2349 = n2329 ? n1652 : n2348;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:857:81 */
  assign n2350 = {n2349, n2347, n2345, n2343, n2341, n2339, n2337, n2335, n2333, n2331};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2351 = n1665[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2352 = ~n2351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2353 = n1665[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2354 = ~n2353;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2355 = n2352 & n2354;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2356 = n2352 & n2353;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2357 = n2351 & n2354;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2358 = n1665[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2359 = ~n2358;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2360 = n2355 & n2359;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2361 = n2355 & n2358;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2362 = n2356 & n2359;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2363 = n2356 & n2358;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2364 = n2357 & n2359;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2365 = n1665[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2366 = ~n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2367 = n2360 & n2366;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2368 = n2360 & n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2369 = n2361 & n2366;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2370 = n2361 & n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2371 = n2362 & n2366;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2372 = n2362 & n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2373 = n2363 & n2366;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2374 = n2363 & n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2375 = n2364 & n2366;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2376 = n2364 & n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2377 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2378 = n2367 ? n1669 : n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2379 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2380 = n2368 ? n1669 : n2379;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2381 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2382 = n2369 ? n1669 : n2381;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2383 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2384 = n2370 ? n1669 : n2383;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2385 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2386 = n2371 ? n1669 : n2385;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2387 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2388 = n2372 ? n1669 : n2387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2389 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2390 = n2373 ? n1669 : n2389;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2391 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2392 = n2374 ? n1669 : n2391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2393 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2394 = n2375 ? n1669 : n2393;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2395 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2396 = n2376 ? n1669 : n2395;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:860:81 */
  assign n2397 = {n2396, n2394, n2392, n2390, n2388, n2386, n2384, n2382, n2380, n2378};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2398 = n1681[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2399 = ~n2398;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2400 = n1681[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2401 = ~n2400;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2402 = n2399 & n2401;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2403 = n2399 & n2400;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2404 = n2398 & n2401;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2405 = n1681[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2406 = ~n2405;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2407 = n2402 & n2406;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2408 = n2402 & n2405;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2409 = n2403 & n2406;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2410 = n2403 & n2405;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2411 = n2404 & n2406;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2412 = n1681[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2413 = ~n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2414 = n2407 & n2413;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2415 = n2407 & n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2416 = n2408 & n2413;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2417 = n2408 & n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2418 = n2409 & n2413;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2419 = n2409 & n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2420 = n2410 & n2413;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2421 = n2410 & n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2422 = n2411 & n2413;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2423 = n2411 & n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2424 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2425 = n2414 ? n1685 : n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2426 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2427 = n2415 ? n1685 : n2426;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2428 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2429 = n2416 ? n1685 : n2428;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2430 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2431 = n2417 ? n1685 : n2430;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2432 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2433 = n2418 ? n1685 : n2432;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2434 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2435 = n2419 ? n1685 : n2434;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2436 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2437 = n2420 ? n1685 : n2436;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2438 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2439 = n2421 ? n1685 : n2438;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2440 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2441 = n2422 ? n1685 : n2440;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2442 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2443 = n2423 ? n1685 : n2442;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:81 */
  assign n2444 = {n2443, n2441, n2439, n2437, n2435, n2433, n2431, n2429, n2427, n2425};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2445 = n1765[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2446 = ~n2445;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2447 = n1765[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2448 = ~n2447;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2449 = n2446 & n2448;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2450 = n2446 & n2447;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2451 = n2445 & n2448;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2452 = n2445 & n2447;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2453 = n1765[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2454 = ~n2453;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2455 = n2449 & n2454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2456 = n2449 & n2453;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2457 = n2450 & n2454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2458 = n2450 & n2453;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2459 = n2451 & n2454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2460 = n2451 & n2453;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2461 = n2452 & n2454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2462 = n2452 & n2453;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2463 = n1765[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2464 = ~n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2465 = n2455 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2466 = n2455 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2467 = n2456 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2468 = n2456 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2469 = n2457 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2470 = n2457 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2471 = n2458 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2472 = n2458 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2473 = n2459 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2474 = n2459 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2475 = n2460 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2476 = n2460 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2477 = n2461 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2478 = n2461 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2479 = n2462 & n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2480 = n2462 & n2463;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2481 = n1765[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2482 = ~n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2483 = n2465 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2484 = n2465 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2485 = n2466 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2486 = n2466 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2487 = n2467 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2488 = n2467 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2489 = n2468 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2490 = n2468 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2491 = n2469 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2492 = n2469 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2493 = n2470 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2494 = n2470 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2495 = n2471 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2496 = n2471 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2497 = n2472 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2498 = n2472 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2499 = n2473 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2500 = n2473 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2501 = n2474 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2502 = n2474 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2503 = n2475 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2504 = n2475 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2505 = n2476 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2506 = n2476 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2507 = n2477 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2508 = n2477 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2509 = n2478 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2510 = n2478 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2511 = n2479 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2512 = n2479 & n2481;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2513 = n2480 & n2482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2514 = n1765[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2515 = ~n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2516 = n2483 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2517 = n2483 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2518 = n2484 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2519 = n2484 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2520 = n2485 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2521 = n2485 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2522 = n2486 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2523 = n2486 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2524 = n2487 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2525 = n2487 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2526 = n2488 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2527 = n2488 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2528 = n2489 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2529 = n2489 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2530 = n2490 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2531 = n2490 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2532 = n2491 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2533 = n2491 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2534 = n2492 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2535 = n2492 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2536 = n2493 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2537 = n2493 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2538 = n2494 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2539 = n2494 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2540 = n2495 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2541 = n2495 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2542 = n2496 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2543 = n2496 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2544 = n2497 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2545 = n2497 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2546 = n2498 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2547 = n2498 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2548 = n2499 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2549 = n2499 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2550 = n2500 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2551 = n2500 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2552 = n2501 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2553 = n2501 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2554 = n2502 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2555 = n2502 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2556 = n2503 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2557 = n2503 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2558 = n2504 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2559 = n2504 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2560 = n2505 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2561 = n2505 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2562 = n2506 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2563 = n2506 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2564 = n2507 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2565 = n2507 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2566 = n2508 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2567 = n2508 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2568 = n2509 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2569 = n2509 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2570 = n2510 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2571 = n2510 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2572 = n2511 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2573 = n2511 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2574 = n2512 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2575 = n2512 & n2514;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2576 = n2513 & n2515;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2577 = n1765[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2578 = ~n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2579 = n2516 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2580 = n2516 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2581 = n2517 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2582 = n2517 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2583 = n2518 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2584 = n2518 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2585 = n2519 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2586 = n2519 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2587 = n2520 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2588 = n2520 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2589 = n2521 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2590 = n2521 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2591 = n2522 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2592 = n2522 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2593 = n2523 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2594 = n2523 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2595 = n2524 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2596 = n2524 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2597 = n2525 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2598 = n2525 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2599 = n2526 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2600 = n2526 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2601 = n2527 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2602 = n2527 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2603 = n2528 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2604 = n2528 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2605 = n2529 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2606 = n2529 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2607 = n2530 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2608 = n2530 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2609 = n2531 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2610 = n2531 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2611 = n2532 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2612 = n2532 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2613 = n2533 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2614 = n2533 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2615 = n2534 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2616 = n2534 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2617 = n2535 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2618 = n2535 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2619 = n2536 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2620 = n2536 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2621 = n2537 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2622 = n2537 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2623 = n2538 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2624 = n2538 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2625 = n2539 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2626 = n2539 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2627 = n2540 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2628 = n2540 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2629 = n2541 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2630 = n2541 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2631 = n2542 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2632 = n2542 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2633 = n2543 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2634 = n2543 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2635 = n2544 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2636 = n2544 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2637 = n2545 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2638 = n2545 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2639 = n2546 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2640 = n2546 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2641 = n2547 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2642 = n2547 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2643 = n2548 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2644 = n2548 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2645 = n2549 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2646 = n2549 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2647 = n2550 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2648 = n2550 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2649 = n2551 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2650 = n2551 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2651 = n2552 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2652 = n2552 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2653 = n2553 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2654 = n2553 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2655 = n2554 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2656 = n2554 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2657 = n2555 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2658 = n2555 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2659 = n2556 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2660 = n2556 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2661 = n2557 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2662 = n2557 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2663 = n2558 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2664 = n2558 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2665 = n2559 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2666 = n2559 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2667 = n2560 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2668 = n2560 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2669 = n2561 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2670 = n2561 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2671 = n2562 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2672 = n2562 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2673 = n2563 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2674 = n2563 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2675 = n2564 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2676 = n2564 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2677 = n2565 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2678 = n2565 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2679 = n2566 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2680 = n2566 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2681 = n2567 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2682 = n2567 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2683 = n2568 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2684 = n2568 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2685 = n2569 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2686 = n2569 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2687 = n2570 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2688 = n2570 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2689 = n2571 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2690 = n2571 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2691 = n2572 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2692 = n2572 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2693 = n2573 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2694 = n2573 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2695 = n2574 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2696 = n2574 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2697 = n2575 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2698 = n2575 & n2577;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2699 = n2576 & n2578;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2700 = n1391[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2701 = n2579 ? m_wr_reg : n2700;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2702 = n2701[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2703 = n1391[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2704 = n2701[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2705 = {n2703, n2704};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2706 = n2580 ? m_wr_reg : n2705;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2707 = n2706[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2708 = n1391[9]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2709 = n2706[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2710 = {n2708, n2709};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2711 = n2581 ? m_wr_reg : n2710;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2712 = n2711[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2713 = n1391[10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2714 = n2711[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2715 = {n2713, n2714};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2716 = n2582 ? m_wr_reg : n2715;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2717 = n2716[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2718 = n1391[11]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2719 = n2716[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2720 = {n2718, n2719};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2721 = n2583 ? m_wr_reg : n2720;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2722 = n2721[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2723 = n1391[12]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2724 = n2721[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2725 = {n2723, n2724};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2726 = n2584 ? m_wr_reg : n2725;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2727 = n2726[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2728 = n1391[13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2729 = n2726[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2730 = {n2728, n2729};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2731 = n2585 ? m_wr_reg : n2730;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2732 = n2731[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2733 = n1391[14]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2734 = n2731[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2735 = {n2733, n2734};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2736 = n2586 ? m_wr_reg : n2735;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2737 = n2736[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2738 = n1391[15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2739 = n2736[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2740 = {n2738, n2739};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2741 = n2587 ? m_wr_reg : n2740;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2742 = n2741[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2743 = n1391[16]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2744 = n2741[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2745 = {n2743, n2744};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2746 = n2588 ? m_wr_reg : n2745;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2747 = n2746[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2748 = n1391[17]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2749 = n2746[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2750 = {n2748, n2749};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2751 = n2589 ? m_wr_reg : n2750;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2752 = n2751[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2753 = n1391[18]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2754 = n2751[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2755 = {n2753, n2754};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2756 = n2590 ? m_wr_reg : n2755;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2757 = n2756[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2758 = n1391[19]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2759 = n2756[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2760 = {n2758, n2759};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2761 = n2591 ? m_wr_reg : n2760;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2762 = n2761[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2763 = n1391[20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2764 = n2761[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2765 = {n2763, n2764};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2766 = n2592 ? m_wr_reg : n2765;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2767 = n2766[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2768 = n1391[21]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2769 = n2766[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2770 = {n2768, n2769};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2771 = n2593 ? m_wr_reg : n2770;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2772 = n2771[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2773 = n1391[22]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2774 = n2771[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2775 = {n2773, n2774};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2776 = n2594 ? m_wr_reg : n2775;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2777 = n2776[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2778 = n1391[23]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2779 = n2776[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2780 = {n2778, n2779};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2781 = n2595 ? m_wr_reg : n2780;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2782 = n2781[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2783 = n1391[24]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2784 = n2781[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2785 = {n2783, n2784};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2786 = n2596 ? m_wr_reg : n2785;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2787 = n2786[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2788 = n1391[25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2789 = n2786[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2790 = {n2788, n2789};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2791 = n2597 ? m_wr_reg : n2790;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2792 = n2791[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2793 = n1391[26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2794 = n2791[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2795 = {n2793, n2794};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2796 = n2598 ? m_wr_reg : n2795;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2797 = n2796[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2798 = n1391[27]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2799 = n2796[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2800 = {n2798, n2799};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2801 = n2599 ? m_wr_reg : n2800;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2802 = n2801[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2803 = n1391[28]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2804 = n2801[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2805 = {n2803, n2804};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2806 = n2600 ? m_wr_reg : n2805;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2807 = n2806[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2808 = n1391[29]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2809 = n2806[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2810 = {n2808, n2809};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2811 = n2601 ? m_wr_reg : n2810;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2812 = n2811[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2813 = n1391[30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2814 = n2811[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2815 = {n2813, n2814};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2816 = n2602 ? m_wr_reg : n2815;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2817 = n2816[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2818 = n1391[31]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2819 = n2816[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2820 = {n2818, n2819};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2821 = n2603 ? m_wr_reg : n2820;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2822 = n2821[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2823 = n1391[32]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2824 = n2821[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2825 = {n2823, n2824};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2826 = n2604 ? m_wr_reg : n2825;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2827 = n2826[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2828 = n1391[33]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2829 = n2826[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2830 = {n2828, n2829};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2831 = n2605 ? m_wr_reg : n2830;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2832 = n2831[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2833 = n1391[34]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2834 = n2831[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2835 = {n2833, n2834};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2836 = n2606 ? m_wr_reg : n2835;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2837 = n2836[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2838 = n1391[35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2839 = n2836[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2840 = {n2838, n2839};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2841 = n2607 ? m_wr_reg : n2840;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2842 = n2841[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2843 = n1391[36]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2844 = n2841[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2845 = {n2843, n2844};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2846 = n2608 ? m_wr_reg : n2845;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2847 = n2846[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2848 = n1391[37]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2849 = n2846[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2850 = {n2848, n2849};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2851 = n2609 ? m_wr_reg : n2850;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2852 = n2851[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2853 = n1391[38]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2854 = n2851[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2855 = {n2853, n2854};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2856 = n2610 ? m_wr_reg : n2855;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2857 = n2856[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2858 = n1391[39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2859 = n2856[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2860 = {n2858, n2859};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2861 = n2611 ? m_wr_reg : n2860;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2862 = n2861[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2863 = n1391[40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2864 = n2861[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2865 = {n2863, n2864};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2866 = n2612 ? m_wr_reg : n2865;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2867 = n2866[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2868 = n1391[41]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2869 = n2866[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2870 = {n2868, n2869};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2871 = n2613 ? m_wr_reg : n2870;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2872 = n2871[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2873 = n1391[42]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2874 = n2871[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2875 = {n2873, n2874};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2876 = n2614 ? m_wr_reg : n2875;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2877 = n2876[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2878 = n1391[43]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2879 = n2876[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2880 = {n2878, n2879};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2881 = n2615 ? m_wr_reg : n2880;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2882 = n2881[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2883 = n1391[44]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2884 = n2881[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2885 = {n2883, n2884};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2886 = n2616 ? m_wr_reg : n2885;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2887 = n2886[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2888 = n1391[45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2889 = n2886[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2890 = {n2888, n2889};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2891 = n2617 ? m_wr_reg : n2890;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2892 = n2891[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2893 = n1391[46]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2894 = n2891[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2895 = {n2893, n2894};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2896 = n2618 ? m_wr_reg : n2895;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2897 = n2896[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2898 = n1391[47]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2899 = n2896[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2900 = {n2898, n2899};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2901 = n2619 ? m_wr_reg : n2900;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2902 = n2901[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2903 = n1391[48]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2904 = n2901[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2905 = {n2903, n2904};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2906 = n2620 ? m_wr_reg : n2905;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2907 = n2906[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2908 = n1391[49]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2909 = n2906[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2910 = {n2908, n2909};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2911 = n2621 ? m_wr_reg : n2910;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2912 = n2911[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2913 = n1391[50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2914 = n2911[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2915 = {n2913, n2914};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2916 = n2622 ? m_wr_reg : n2915;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2917 = n2916[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2918 = n1391[51]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2919 = n2916[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2920 = {n2918, n2919};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2921 = n2623 ? m_wr_reg : n2920;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2922 = n2921[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2923 = n1391[52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2924 = n2921[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2925 = {n2923, n2924};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2926 = n2624 ? m_wr_reg : n2925;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2927 = n2926[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2928 = n1391[53]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2929 = n2926[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2930 = {n2928, n2929};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2931 = n2625 ? m_wr_reg : n2930;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2932 = n2931[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2933 = n1391[54]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2934 = n2931[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2935 = {n2933, n2934};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2936 = n2626 ? m_wr_reg : n2935;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2937 = n2936[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2938 = n1391[55]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2939 = n2936[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2940 = {n2938, n2939};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2941 = n2627 ? m_wr_reg : n2940;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2942 = n2941[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2943 = n1391[56]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2944 = n2941[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2945 = {n2943, n2944};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2946 = n2628 ? m_wr_reg : n2945;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2947 = n2946[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2948 = n1391[57]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2949 = n2946[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2950 = {n2948, n2949};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2951 = n2629 ? m_wr_reg : n2950;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2952 = n2951[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2953 = n1391[58]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2954 = n2951[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2955 = {n2953, n2954};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2956 = n2630 ? m_wr_reg : n2955;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2957 = n2956[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2958 = n1391[59]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2959 = n2956[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2960 = {n2958, n2959};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2961 = n2631 ? m_wr_reg : n2960;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2962 = n2961[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2963 = n1391[60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2964 = n2961[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2965 = {n2963, n2964};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2966 = n2632 ? m_wr_reg : n2965;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2967 = n2966[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2968 = n1391[61]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2969 = n2966[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2970 = {n2968, n2969};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2971 = n2633 ? m_wr_reg : n2970;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2972 = n2971[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2973 = n1391[62]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2974 = n2971[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2975 = {n2973, n2974};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2976 = n2634 ? m_wr_reg : n2975;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2977 = n2976[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2978 = n1391[63]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2979 = n2976[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2980 = {n2978, n2979};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2981 = n2635 ? m_wr_reg : n2980;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2982 = n2981[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2983 = n1391[64]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2984 = n2981[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2985 = {n2983, n2984};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2986 = n2636 ? m_wr_reg : n2985;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2987 = n2986[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2988 = n1391[65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2989 = n2986[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2990 = {n2988, n2989};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2991 = n2637 ? m_wr_reg : n2990;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2992 = n2991[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2993 = n1391[66]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2994 = n2991[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2995 = {n2993, n2994};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2996 = n2638 ? m_wr_reg : n2995;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2997 = n2996[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2998 = n1391[67]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n2999 = n2996[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3000 = {n2998, n2999};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3001 = n2639 ? m_wr_reg : n3000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3002 = n3001[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3003 = n1391[68]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3004 = n3001[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3005 = {n3003, n3004};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3006 = n2640 ? m_wr_reg : n3005;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3007 = n3006[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3008 = n1391[69]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3009 = n3006[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3010 = {n3008, n3009};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3011 = n2641 ? m_wr_reg : n3010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3012 = n3011[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3013 = n1391[70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3014 = n3011[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3015 = {n3013, n3014};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3016 = n2642 ? m_wr_reg : n3015;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3017 = n3016[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3018 = n1391[71]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3019 = n3016[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3020 = {n3018, n3019};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3021 = n2643 ? m_wr_reg : n3020;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3022 = n3021[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3023 = n1391[72]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3024 = n3021[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3025 = {n3023, n3024};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3026 = n2644 ? m_wr_reg : n3025;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3027 = n3026[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3028 = n1391[73]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3029 = n3026[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3030 = {n3028, n3029};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3031 = n2645 ? m_wr_reg : n3030;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3032 = n3031[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3033 = n1391[74]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3034 = n3031[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3035 = {n3033, n3034};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3036 = n2646 ? m_wr_reg : n3035;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3037 = n3036[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3038 = n1391[75]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3039 = n3036[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3040 = {n3038, n3039};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3041 = n2647 ? m_wr_reg : n3040;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3042 = n3041[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3043 = n1391[76]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3044 = n3041[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3045 = {n3043, n3044};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3046 = n2648 ? m_wr_reg : n3045;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3047 = n3046[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3048 = n1391[77]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3049 = n3046[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3050 = {n3048, n3049};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3051 = n2649 ? m_wr_reg : n3050;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3052 = n3051[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3053 = n1391[78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3054 = n3051[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3055 = {n3053, n3054};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3056 = n2650 ? m_wr_reg : n3055;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3057 = n3056[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3058 = n1391[79]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3059 = n3056[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3060 = {n3058, n3059};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3061 = n2651 ? m_wr_reg : n3060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3062 = n3061[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3063 = n1391[80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3064 = n3061[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3065 = {n3063, n3064};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3066 = n2652 ? m_wr_reg : n3065;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3067 = n3066[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3068 = n1391[81]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3069 = n3066[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3070 = {n3068, n3069};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3071 = n2653 ? m_wr_reg : n3070;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3072 = n3071[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3073 = n1391[82]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3074 = n3071[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3075 = {n3073, n3074};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3076 = n2654 ? m_wr_reg : n3075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3077 = n3076[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3078 = n1391[83]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3079 = n3076[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3080 = {n3078, n3079};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3081 = n2655 ? m_wr_reg : n3080;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3082 = n3081[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3083 = n1391[84]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3084 = n3081[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3085 = {n3083, n3084};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3086 = n2656 ? m_wr_reg : n3085;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3087 = n3086[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3088 = n1391[85]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3089 = n3086[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3090 = {n3088, n3089};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3091 = n2657 ? m_wr_reg : n3090;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3092 = n3091[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3093 = n1391[86]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3094 = n3091[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3095 = {n3093, n3094};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3096 = n2658 ? m_wr_reg : n3095;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3097 = n3096[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3098 = n1391[87]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3099 = n3096[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3100 = {n3098, n3099};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3101 = n2659 ? m_wr_reg : n3100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3102 = n3101[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3103 = n1391[88]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3104 = n3101[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3105 = {n3103, n3104};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3106 = n2660 ? m_wr_reg : n3105;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3107 = n3106[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3108 = n1391[89]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3109 = n3106[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3110 = {n3108, n3109};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3111 = n2661 ? m_wr_reg : n3110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3112 = n3111[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3113 = n1391[90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3114 = n3111[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3115 = {n3113, n3114};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3116 = n2662 ? m_wr_reg : n3115;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3117 = n3116[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3118 = n1391[91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3119 = n3116[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3120 = {n3118, n3119};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3121 = n2663 ? m_wr_reg : n3120;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3122 = n3121[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3123 = n1391[92]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3124 = n3121[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3125 = {n3123, n3124};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3126 = n2664 ? m_wr_reg : n3125;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3127 = n3126[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3128 = n1391[93]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3129 = n3126[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3130 = {n3128, n3129};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3131 = n2665 ? m_wr_reg : n3130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3132 = n3131[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3133 = n1391[94]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3134 = n3131[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3135 = {n3133, n3134};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3136 = n2666 ? m_wr_reg : n3135;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3137 = n3136[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3138 = n1391[95]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3139 = n3136[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3140 = {n3138, n3139};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3141 = n2667 ? m_wr_reg : n3140;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3142 = n3141[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3143 = n1391[96]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3144 = n3141[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3145 = {n3143, n3144};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3146 = n2668 ? m_wr_reg : n3145;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3147 = n3146[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3148 = n1391[97]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3149 = n3146[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3150 = {n3148, n3149};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3151 = n2669 ? m_wr_reg : n3150;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3152 = n3151[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3153 = n1391[98]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3154 = n3151[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3155 = {n3153, n3154};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3156 = n2670 ? m_wr_reg : n3155;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3157 = n3156[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3158 = n1391[99]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3159 = n3156[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3160 = {n3158, n3159};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3161 = n2671 ? m_wr_reg : n3160;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3162 = n3161[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3163 = n1391[100]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3164 = n3161[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3165 = {n3163, n3164};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3166 = n2672 ? m_wr_reg : n3165;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3167 = n3166[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3168 = n1391[101]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3169 = n3166[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3170 = {n3168, n3169};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3171 = n2673 ? m_wr_reg : n3170;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3172 = n3171[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3173 = n1391[102]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3174 = n3171[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3175 = {n3173, n3174};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3176 = n2674 ? m_wr_reg : n3175;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3177 = n3176[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3178 = n1391[103]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3179 = n3176[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3180 = {n3178, n3179};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3181 = n2675 ? m_wr_reg : n3180;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3182 = n3181[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3183 = n1391[104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3184 = n3181[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3185 = {n3183, n3184};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3186 = n2676 ? m_wr_reg : n3185;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3187 = n3186[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3188 = n1391[105]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3189 = n3186[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3190 = {n3188, n3189};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3191 = n2677 ? m_wr_reg : n3190;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3192 = n3191[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3193 = n1391[106]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3194 = n3191[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3195 = {n3193, n3194};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3196 = n2678 ? m_wr_reg : n3195;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3197 = n3196[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3198 = n1391[107]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3199 = n3196[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3200 = {n3198, n3199};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3201 = n2679 ? m_wr_reg : n3200;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3202 = n3201[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3203 = n1391[108]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3204 = n3201[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3205 = {n3203, n3204};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3206 = n2680 ? m_wr_reg : n3205;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3207 = n3206[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3208 = n1391[109]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3209 = n3206[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3210 = {n3208, n3209};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3211 = n2681 ? m_wr_reg : n3210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3212 = n3211[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3213 = n1391[110]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3214 = n3211[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3215 = {n3213, n3214};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3216 = n2682 ? m_wr_reg : n3215;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3217 = n3216[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3218 = n1391[111]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3219 = n3216[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3220 = {n3218, n3219};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3221 = n2683 ? m_wr_reg : n3220;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3222 = n3221[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3223 = n1391[112]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3224 = n3221[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3225 = {n3223, n3224};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3226 = n2684 ? m_wr_reg : n3225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3227 = n3226[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3228 = n1391[113]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3229 = n3226[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3230 = {n3228, n3229};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3231 = n2685 ? m_wr_reg : n3230;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3232 = n3231[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3233 = n1391[114]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3234 = n3231[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3235 = {n3233, n3234};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3236 = n2686 ? m_wr_reg : n3235;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3237 = n3236[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3238 = n1391[115]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3239 = n3236[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3240 = {n3238, n3239};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3241 = n2687 ? m_wr_reg : n3240;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3242 = n3241[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3243 = n1391[116]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3244 = n3241[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3245 = {n3243, n3244};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3246 = n2688 ? m_wr_reg : n3245;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3247 = n3246[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3248 = n1391[117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3249 = n3246[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3250 = {n3248, n3249};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3251 = n2689 ? m_wr_reg : n3250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3252 = n3251[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3253 = n1391[118]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3254 = n3251[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3255 = {n3253, n3254};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3256 = n2690 ? m_wr_reg : n3255;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3257 = n3256[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3258 = n1391[119]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3259 = n3256[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3260 = {n3258, n3259};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3261 = n2691 ? m_wr_reg : n3260;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3262 = n3261[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3263 = n1391[120]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3264 = n3261[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3265 = {n3263, n3264};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3266 = n2692 ? m_wr_reg : n3265;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3267 = n3266[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3268 = n1391[121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3269 = n3266[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3270 = {n3268, n3269};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3271 = n2693 ? m_wr_reg : n3270;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3272 = n3271[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3273 = n1391[122]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3274 = n3271[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3275 = {n3273, n3274};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3276 = n2694 ? m_wr_reg : n3275;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3277 = n3276[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3278 = n1391[123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3279 = n3276[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3280 = {n3278, n3279};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3281 = n2695 ? m_wr_reg : n3280;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3282 = n3281[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3283 = n1391[124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3284 = n3281[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3285 = {n3283, n3284};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3286 = n2696 ? m_wr_reg : n3285;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3287 = n3286[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3288 = n1391[125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3289 = n3286[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3290 = {n3288, n3289};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3291 = n2697 ? m_wr_reg : n3290;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3292 = n3291[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3293 = n1391[126]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3294 = n3291[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3295 = {n3293, n3294};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3296 = n2698 ? m_wr_reg : n3295;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3297 = n3296[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3298 = n1391[127]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3299 = n3296[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3300 = {n3298, n3299};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3301 = n2699 ? m_wr_reg : n3300;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:33 */
  assign n3302 = {n3301, n3297, n3292, n3287, n3282, n3277, n3272, n3267, n3262, n3257, n3252, n3247, n3242, n3237, n3232, n3227, n3222, n3217, n3212, n3207, n3202, n3197, n3192, n3187, n3182, n3177, n3172, n3167, n3162, n3157, n3152, n3147, n3142, n3137, n3132, n3127, n3122, n3117, n3112, n3107, n3102, n3097, n3092, n3087, n3082, n3077, n3072, n3067, n3062, n3057, n3052, n3047, n3042, n3037, n3032, n3027, n3022, n3017, n3012, n3007, n3002, n2997, n2992, n2987, n2982, n2977, n2972, n2967, n2962, n2957, n2952, n2947, n2942, n2937, n2932, n2927, n2922, n2917, n2912, n2907, n2902, n2897, n2892, n2887, n2882, n2877, n2872, n2867, n2862, n2857, n2852, n2847, n2842, n2837, n2832, n2827, n2822, n2817, n2812, n2807, n2802, n2797, n2792, n2787, n2782, n2777, n2772, n2767, n2762, n2757, n2752, n2747, n2742, n2737, n2732, n2727, n2722, n2717, n2712, n2707, n2702};
endmodule

