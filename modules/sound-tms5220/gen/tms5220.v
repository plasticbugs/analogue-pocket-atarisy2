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
  wire n134;
  wire n135;
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
  wire [2:0] n162;
  wire [3:0] n164;
  wire n165;
  wire [3:0] n166;
  wire [4:0] n167;
  wire n168;
  wire n169;
  wire [2:0] n171;
  wire [3:0] n173;
  wire [4:0] n175;
  wire n177;
  wire n179;
  wire [1:0] n181;
  wire n195;
  wire n196;
  wire n197;
  wire n198;
  wire n199;
  wire n200;
  wire n201;
  wire n202;
  wire n203;
  wire n204;
  wire n208;
  wire n209;
  wire [31:0] n210;
  wire n212;
  wire [12:0] n213;
  wire [13:0] n215;
  wire n218;
  wire [13:0] n219;
  wire n225;
  wire n226;
  wire n227;
  wire n228;
  wire n231;
  wire n232;
  wire n233;
  wire [31:0] n234;
  wire n236;
  wire [31:0] n237;
  wire [31:0] n239;
  wire [4:0] n240;
  wire [31:0] n241;
  wire n243;
  wire [31:0] n244;
  wire n246;
  wire n247;
  wire [4:0] n250;
  wire n253;
  wire n255;
  wire [4:0] n256;
  wire n258;
  wire n259;
  wire [4:0] n260;
  wire n262;
  wire n263;
  wire [4:0] n265;
  wire n267;
  wire n268;
  wire n270;
  wire [4:0] n272;
  wire n274;
  wire n276;
  wire n278;
  wire n290;
  wire n292;
  wire n294;
  wire n300;
  wire n301;
  wire n302;
  wire n303;
  wire n304;
  wire n305;
  wire n306;
  wire n307;
  wire n308;
  wire n310;
  wire n312;
  wire n325;
  wire n326;
  wire [11:0] n327;
  wire n328;
  wire n329;
  wire n330;
  wire n331;
  wire n332;
  wire n333;
  wire n334;
  wire [12:0] n335;
  wire [12:0] n336;
  wire [12:0] n338;
  wire [31:0] n344;
  wire n346;
  wire n347;
  wire [31:0] n348;
  wire n350;
  wire n351;
  wire [31:0] n352;
  wire n354;
  wire n355;
  wire n356;
  wire n357;
  wire n358;
  wire n359;
  wire [31:0] n360;
  wire n362;
  wire n363;
  wire [31:0] n364;
  wire n366;
  wire n367;
  wire [31:0] n368;
  wire n370;
  wire n371;
  wire n372;
  wire n373;
  wire n374;
  wire n376;
  wire n378;
  wire n380;
  wire [31:0] n381;
  wire n383;
  wire n384;
  wire [31:0] n385;
  wire [31:0] n387;
  wire [31:0] n388;
  wire n389;
  wire n390;
  wire n391;
  wire [31:0] n392;
  wire [31:0] n394;
  wire [8:0] n395;
  wire [8:0] n397;
  wire n399;
  wire n401;
  wire n402;
  wire n408;
  wire n409;
  wire n410;
  wire n411;
  wire [1:0] n412;
  wire [2:0] n413;
  wire [7:0] n415;
  wire n418;
  wire n421;
  wire [7:0] n423;
  wire n426;
  wire n429;
  wire n432;
  wire [31:0] n440;
  wire n442;
  wire n443;
  wire n444;
  wire n445;
  wire n446;
  wire [13:0] n449;
  wire [31:0] n450;
  wire n452;
  wire [5:0] n453;
  wire [13:0] n459;
  wire [13:0] n461;
  wire [13:0] n462;
  wire n464;
  wire n469;
  wire n470;
  wire [31:0] n471;
  wire n473;
  wire n474;
  wire [31:0] n475;
  wire n477;
  wire n478;
  wire [31:0] n479;
  wire n481;
  wire n482;
  wire n483;
  wire n484;
  wire n485;
  wire n486;
  wire n487;
  wire n488;
  wire n489;
  wire n491;
  wire n493;
  wire n495;
  wire n501;
  wire n502;
  wire n503;
  wire n504;
  wire n505;
  wire n506;
  wire n507;
  wire n508;
  wire n509;
  wire [31:0] n510;
  wire n512;
  wire n513;
  wire [31:0] n514;
  wire n516;
  wire n517;
  wire [31:0] n518;
  wire n520;
  wire n521;
  wire n522;
  wire n523;
  wire n524;
  wire [31:0] n525;
  wire n527;
  wire n530;
  wire [31:0] n531;
  wire n533;
  wire n536;
  wire n537;
  wire n538;
  wire n540;
  wire n542;
  wire [31:0] n550;
  wire n552;
  wire n553;
  wire [31:0] n554;
  wire n556;
  wire n557;
  wire [31:0] n558;
  wire n560;
  wire n561;
  wire n562;
  wire n563;
  wire n564;
  wire n565;
  wire n566;
  wire n568;
  wire [31:0] n569;
  wire n571;
  wire [31:0] n572;
  wire n574;
  wire n575;
  wire n576;
  wire n577;
  wire n579;
  wire n580;
  wire n581;
  wire n583;
  wire n585;
  wire n586;
  wire n587;
  wire n588;
  wire n589;
  wire n590;
  wire n591;
  wire n593;
  wire [31:0] n601;
  wire n603;
  wire n604;
  wire n605;
  wire n606;
  wire n607;
  wire n608;
  wire n609;
  wire [31:0] n610;
  wire n612;
  wire n613;
  wire [31:0] n614;
  wire [31:0] n620;
  wire [31:0] n621;
  wire [31:0] n622;
  wire [11:0] n623;
  wire [30:0] n629;
  wire [11:0] n630;
  wire [31:0] n631;
  wire [31:0] n632;
  wire [13:0] n633;
  wire [13:0] n634;
  wire [13:0] n636;
  wire n638;
  wire n639;
  wire [31:0] n640;
  wire n642;
  wire n643;
  wire [31:0] n644;
  wire [5:0] n645;
  wire [31:0] n651;
  wire [31:0] n652;
  wire [31:0] n653;
  wire [11:0] n654;
  wire [30:0] n659;
  wire [11:0] n660;
  wire [31:0] n661;
  wire [31:0] n662;
  wire [13:0] n663;
  wire [13:0] n664;
  wire [13:0] n666;
  wire n668;
  wire n669;
  wire [31:0] n670;
  wire n672;
  wire n673;
  wire [31:0] n674;
  wire [31:0] n676;
  wire [3:0] n677;
  wire [3:0] n679;
  wire [31:0] n681;
  wire [31:0] n683;
  wire [3:0] n684;
  wire [3:0] n686;
  wire [31:0] n689;
  wire [31:0] n690;
  wire [31:0] n692;
  wire [3:0] n693;
  wire [3:0] n695;
  wire [31:0] n697;
  wire [31:0] n699;
  wire [3:0] n700;
  wire [3:0] n702;
  wire [4:0] n706;
  wire [31:0] n711;
  wire [31:0] n712;
  wire [31:0] n714;
  wire [3:0] n715;
  wire [3:0] n717;
  wire [31:0] n720;
  wire [31:0] n721;
  wire [11:0] n722;
  wire [30:0] n727;
  wire [11:0] n728;
  wire [31:0] n729;
  wire [31:0] n730;
  wire [9:0] n731;
  wire [99:0] n733;
  wire n736;
  wire n737;
  wire n738;
  wire [31:0] n739;
  wire [31:0] n741;
  wire [3:0] n742;
  wire [3:0] n744;
  wire n748;
  wire [31:0] n749;
  wire n751;
  wire n752;
  wire [31:0] n753;
  wire [31:0] n755;
  wire [3:0] n756;
  wire [3:0] n758;
  wire [31:0] n760;
  wire [31:0] n762;
  wire [3:0] n763;
  wire [3:0] n765;
  wire [31:0] n768;
  wire [31:0] n769;
  wire [31:0] n771;
  wire [3:0] n772;
  wire [3:0] n774;
  wire [31:0] n776;
  wire [31:0] n778;
  wire [3:0] n779;
  wire [3:0] n781;
  wire [4:0] n785;
  wire [31:0] n789;
  wire [31:0] n790;
  wire [31:0] n792;
  wire [3:0] n793;
  wire [3:0] n795;
  wire [31:0] n798;
  wire [31:0] n799;
  wire [11:0] n800;
  wire [30:0] n805;
  wire [11:0] n806;
  wire [31:0] n807;
  wire [31:0] n808;
  wire [9:0] n809;
  wire [99:0] n811;
  wire [99:0] n812;
  wire n815;
  wire n816;
  wire n817;
  wire [3:0] n818;
  reg [13:0] n819;
  reg [13:0] n820;
  reg [99:0] n821;
  wire [13:0] n822;
  wire [13:0] n823;
  wire [99:0] n824;
  wire [13:0] n826;
  wire [13:0] n828;
  wire [99:0] n829;
  wire n839;
  wire n840;
  wire n841;
  wire [31:0] n842;
  wire [31:0] n843;
  wire [31:0] n844;
  wire [21:0] n845;
  wire [21:0] n847;
  wire [12:0] n849;
  wire n851;
  wire [12:0] n852;
  wire [31:0] n853;
  wire [9:0] n854;
  wire [31:0] n855;
  wire [12:0] n856;
  wire [31:0] n857;
  wire [31:0] n858;
  wire [21:0] n859;
  wire [21:0] n861;
  wire [31:0] n862;
  wire [31:0] n863;
  wire [12:0] n864;
  wire n866;
  wire [12:0] n867;
  wire [31:0] n868;
  wire [9:0] n869;
  wire [31:0] n870;
  wire [12:0] n871;
  wire [31:0] n872;
  wire [31:0] n873;
  wire [21:0] n874;
  wire [21:0] n876;
  wire [31:0] n877;
  wire [31:0] n878;
  wire [12:0] n879;
  wire n881;
  wire [12:0] n882;
  wire [31:0] n883;
  wire [9:0] n884;
  wire [31:0] n885;
  wire [12:0] n886;
  wire [31:0] n887;
  wire [31:0] n888;
  wire [21:0] n889;
  wire [21:0] n891;
  wire [31:0] n892;
  wire [31:0] n893;
  wire [12:0] n894;
  wire [12:0] n895;
  wire [31:0] n896;
  wire [9:0] n897;
  wire [31:0] n898;
  wire [12:0] n899;
  wire [31:0] n900;
  wire [31:0] n901;
  wire [21:0] n902;
  wire [21:0] n904;
  wire [31:0] n905;
  wire [31:0] n906;
  wire [12:0] n907;
  wire n909;
  wire [12:0] n910;
  wire [31:0] n911;
  wire [9:0] n912;
  wire [31:0] n913;
  wire [12:0] n914;
  wire [31:0] n915;
  wire [31:0] n916;
  wire [21:0] n917;
  wire [21:0] n919;
  wire [31:0] n920;
  wire [31:0] n921;
  wire [12:0] n922;
  wire [12:0] n923;
  wire [31:0] n924;
  wire [9:0] n925;
  wire [31:0] n926;
  wire [12:0] n927;
  wire [31:0] n928;
  wire [31:0] n929;
  wire [21:0] n930;
  wire [21:0] n932;
  wire [31:0] n933;
  wire [31:0] n934;
  wire [12:0] n935;
  wire n937;
  wire [12:0] n938;
  wire [31:0] n939;
  wire [9:0] n940;
  wire [31:0] n941;
  wire [12:0] n942;
  wire [31:0] n943;
  wire [31:0] n944;
  wire [21:0] n945;
  wire [21:0] n947;
  wire [31:0] n948;
  wire [31:0] n949;
  wire [12:0] n950;
  wire [12:0] n951;
  wire [31:0] n952;
  wire [9:0] n953;
  wire [31:0] n954;
  wire [12:0] n955;
  wire [31:0] n956;
  wire [31:0] n957;
  wire [21:0] n958;
  wire [21:0] n960;
  wire [31:0] n961;
  wire [31:0] n962;
  wire [12:0] n963;
  wire n965;
  wire [12:0] n966;
  wire [31:0] n967;
  wire [9:0] n968;
  wire [31:0] n969;
  wire [12:0] n970;
  wire [31:0] n971;
  wire [31:0] n972;
  wire [21:0] n973;
  wire [21:0] n975;
  wire [31:0] n976;
  wire [31:0] n977;
  wire [12:0] n978;
  wire [12:0] n979;
  wire [31:0] n980;
  wire [9:0] n981;
  wire [31:0] n982;
  wire [12:0] n983;
  wire [31:0] n984;
  wire [31:0] n985;
  wire [21:0] n986;
  wire [21:0] n988;
  wire [31:0] n989;
  wire [31:0] n990;
  wire [12:0] n991;
  wire n993;
  wire [12:0] n994;
  wire [31:0] n995;
  wire [9:0] n996;
  wire [31:0] n997;
  wire [12:0] n998;
  wire [31:0] n999;
  wire [31:0] n1000;
  wire [21:0] n1001;
  wire [21:0] n1003;
  wire [31:0] n1004;
  wire [31:0] n1005;
  wire [12:0] n1006;
  wire [12:0] n1007;
  wire [31:0] n1008;
  wire [9:0] n1009;
  wire [31:0] n1010;
  wire [12:0] n1011;
  wire [31:0] n1012;
  wire [31:0] n1013;
  wire [21:0] n1014;
  wire [21:0] n1016;
  wire [31:0] n1017;
  wire [31:0] n1018;
  wire [12:0] n1019;
  wire n1021;
  wire [12:0] n1022;
  wire [31:0] n1023;
  wire [9:0] n1024;
  wire [31:0] n1025;
  wire [12:0] n1026;
  wire [31:0] n1027;
  wire [31:0] n1028;
  wire [21:0] n1029;
  wire [21:0] n1031;
  wire [31:0] n1032;
  wire [31:0] n1033;
  wire [12:0] n1034;
  wire [12:0] n1035;
  wire [31:0] n1036;
  wire [9:0] n1037;
  wire [31:0] n1038;
  wire [12:0] n1039;
  wire [31:0] n1040;
  wire [31:0] n1041;
  wire [21:0] n1042;
  wire [21:0] n1044;
  wire [31:0] n1045;
  wire [31:0] n1046;
  wire [12:0] n1047;
  wire n1049;
  wire [12:0] n1050;
  wire [31:0] n1051;
  wire [9:0] n1052;
  wire [31:0] n1053;
  wire [12:0] n1054;
  wire [31:0] n1055;
  wire [31:0] n1056;
  wire [21:0] n1057;
  wire [21:0] n1059;
  wire [31:0] n1060;
  wire [31:0] n1061;
  wire [12:0] n1062;
  wire [12:0] n1063;
  wire [31:0] n1064;
  wire [9:0] n1065;
  wire [31:0] n1066;
  wire [12:0] n1067;
  wire [31:0] n1068;
  wire [31:0] n1069;
  wire [21:0] n1070;
  wire [21:0] n1072;
  wire [31:0] n1073;
  wire [31:0] n1074;
  wire [12:0] n1075;
  wire n1077;
  wire [12:0] n1078;
  wire [31:0] n1079;
  wire [9:0] n1080;
  wire [31:0] n1081;
  wire [12:0] n1082;
  wire [31:0] n1083;
  wire [31:0] n1084;
  wire [21:0] n1085;
  wire [21:0] n1087;
  wire [31:0] n1088;
  wire [31:0] n1089;
  wire [12:0] n1090;
  wire [12:0] n1091;
  wire [31:0] n1092;
  wire [9:0] n1093;
  wire [31:0] n1094;
  wire [12:0] n1095;
  wire [31:0] n1096;
  wire [31:0] n1097;
  wire [21:0] n1098;
  wire [21:0] n1100;
  wire [31:0] n1101;
  wire [31:0] n1102;
  wire [12:0] n1103;
  wire n1105;
  wire [12:0] n1106;
  wire [31:0] n1107;
  wire [9:0] n1108;
  wire [31:0] n1109;
  wire [12:0] n1110;
  wire [31:0] n1111;
  wire [31:0] n1112;
  wire [21:0] n1113;
  wire [21:0] n1115;
  wire [31:0] n1116;
  wire [31:0] n1117;
  wire [12:0] n1118;
  wire [12:0] n1119;
  wire [12:0] n1120;
  wire [13:0] n1121;
  wire n1123;
  wire [11:0] n1124;
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
  wire [12:0] n1155;
  reg [12:0] n1156;
  wire [12:0] n1157;
  reg [12:0] n1158;
  wire [12:0] n1159;
  reg [12:0] n1160;
  wire [12:0] n1161;
  reg [12:0] n1162;
  wire [12:0] n1163;
  reg [12:0] n1164;
  wire [12:0] n1165;
  reg [12:0] n1166;
  reg [13:0] n1167;
  reg [13:0] n1168;
  wire [142:0] n1169;
  wire [142:0] n1170;
  wire [129:0] n1171;
  wire [129:0] n1172;
  wire [13:0] n1173;
  wire [13:0] n1174;
  wire [142:0] n1176;
  wire [129:0] n1178;
  wire [13:0] n1180;
  wire [13:0] n1181;
  wire n1193;
  wire n1194;
  wire n1195;
  wire n1196;
  wire n1197;
  wire [2:0] n1198;
  wire n1200;
  wire n1201;
  wire n1203;
  wire n1205;
  wire n1207;
  wire n1209;
  wire n1211;
  wire n1213;
  wire n1215;
  wire n1217;
  wire [7:0] n1218;
  reg n1221;
  reg n1224;
  reg n1227;
  wire n1229;
  wire n1232;
  wire n1235;
  wire n1237;
  wire n1248;
  wire n1249;
  wire n1250;
  wire n1252;
  wire n1254;
  wire [31:0] n1262;
  wire n1264;
  wire n1265;
  wire [31:0] n1266;
  wire n1268;
  wire n1269;
  wire [31:0] n1270;
  wire n1272;
  wire n1273;
  wire n1274;
  wire n1275;
  wire n1276;
  wire n1277;
  wire n1278;
  wire [31:0] n1279;
  wire n1281;
  wire n1282;
  wire [31:0] n1283;
  wire n1285;
  wire n1286;
  wire n1287;
  wire [31:0] n1288;
  wire n1290;
  wire n1291;
  wire n1292;
  wire [31:0] n1293;
  wire n1295;
  wire n1296;
  wire n1297;
  wire n1300;
  wire n1301;
  wire n1303;
  wire n1309;
  wire n1311;
  wire n1312;
  wire n1313;
  wire n1314;
  wire n1315;
  wire n1316;
  wire [31:0] n1317;
  wire n1319;
  wire n1320;
  wire [31:0] n1321;
  wire n1323;
  wire n1324;
  wire n1325;
  wire n1327;
  wire n1329;
  wire [31:0] n1330;
  wire n1332;
  wire n1333;
  wire [31:0] n1334;
  wire n1336;
  wire n1337;
  wire [31:0] n1338;
  wire n1340;
  wire n1341;
  wire n1342;
  wire n1343;
  wire n1344;
  wire n1345;
  wire [31:0] n1346;
  wire n1348;
  wire [31:0] n1349;
  wire n1351;
  wire n1352;
  wire [31:0] n1353;
  wire n1355;
  wire n1356;
  wire n1359;
  wire n1361;
  wire n1362;
  wire n1370;
  wire n1372;
  wire n1373;
  wire n1374;
  wire n1375;
  wire n1376;
  wire n1377;
  wire n1378;
  wire n1379;
  wire n1380;
  wire [1:0] n1381;
  wire n1382;
  wire [2:0] n1383;
  wire n1384;
  wire [3:0] n1385;
  wire n1386;
  wire [4:0] n1387;
  wire n1388;
  wire [5:0] n1389;
  wire n1390;
  wire [6:0] n1391;
  wire n1392;
  wire [7:0] n1393;
  wire [7:0] n1394;
  wire n1395;
  wire n1397;
  wire [7:0] n1399;
  wire n1400;
  wire [7:0] n1401;
  wire [127:0] n1403;
  wire n1404;
  wire n1406;
  wire n1407;
  wire n1408;
  wire n1409;
  wire n1410;
  wire n1411;
  wire [31:0] n1412;
  wire n1414;
  wire n1415;
  wire [31:0] n1416;
  wire n1418;
  wire n1419;
  wire n1420;
  wire [31:0] n1421;
  wire n1423;
  wire n1424;
  wire [31:0] n1425;
  wire n1427;
  wire n1428;
  wire n1429;
  wire n1430;
  wire n1431;
  wire n1432;
  wire [31:0] n1433;
  wire n1435;
  wire [31:0] n1436;
  wire [31:0] n1438;
  wire [7:0] n1439;
  wire [123:0] n1440;
  wire [127:0] n1442;
  wire [3:0] n1443;
  wire [3:0] n1445;
  wire n1447;
  wire [3:0] n1448;
  wire n1450;
  wire n1452;
  wire n1454;
  wire n1457;
  wire n1458;
  wire n1460;
  wire n1461;
  wire [7:0] n1462;
  wire [3:0] n1463;
  wire n1466;
  wire n1467;
  wire n1468;
  wire n1469;
  wire [127:0] n1470;
  wire n1472;
  wire n1473;
  wire n1474;
  wire n1475;
  wire [31:0] n1476;
  wire n1478;
  wire [31:0] n1479;
  wire [31:0] n1481;
  wire [31:0] n1483;
  wire [7:0] n1484;
  wire [120:0] n1485;
  wire [127:0] n1487;
  wire n1488;
  wire [5:0] n1489;
  wire [6:0] n1491;
  wire [5:0] n1492;
  wire n1494;
  wire n1496;
  wire n1498;
  wire [7:0] n1499;
  wire [6:0] n1500;
  wire n1503;
  wire n1504;
  wire n1505;
  wire n1506;
  wire [127:0] n1507;
  wire n1508;
  wire n1509;
  wire n1511;
  wire n1512;
  wire n1513;
  wire n1514;
  wire n1515;
  wire n1517;
  wire n1518;
  wire n1519;
  wire n1520;
  wire [31:0] n1521;
  wire [31:0] n1522;
  wire [31:0] n1524;
  wire [3:0] n1525;
  wire [31:0] n1531;
  wire [31:0] n1533;
  wire n1534;
  wire [31:0] n1535;
  wire [31:0] n1536;
  wire [31:0] n1538;
  wire [3:0] n1539;
  wire [31:0] n1544;
  wire [31:0] n1545;
  wire [7:0] n1546;
  wire [31:0] n1547;
  wire [31:0] n1549;
  wire [3:0] n1550;
  wire [122:0] n1555;
  wire [127:0] n1557;
  wire [31:0] n1558;
  wire [31:0] n1560;
  wire [3:0] n1561;
  wire [3:0] n1563;
  wire [4:0] n1565;
  wire n1569;
  wire [123:0] n1570;
  wire [127:0] n1572;
  wire [31:0] n1573;
  wire [31:0] n1575;
  wire [3:0] n1576;
  wire [3:0] n1578;
  wire [3:0] n1580;
  wire [4:0] n1582;
  wire n1585;
  wire [124:0] n1586;
  wire [127:0] n1588;
  wire [31:0] n1589;
  wire [31:0] n1591;
  wire [3:0] n1592;
  wire [3:0] n1594;
  wire [2:0] n1596;
  wire [4:0] n1598;
  wire [1:0] n1600;
  reg [49:0] n1601;
  reg [127:0] n1602;
  wire [7:0] n1603;
  wire [49:0] n1604;
  wire n1607;
  wire [127:0] n1608;
  wire n1609;
  wire n1610;
  wire n1612;
  wire n1613;
  wire n1616;
  wire n1617;
  wire n1618;
  wire n1619;
  wire n1620;
  wire [31:0] n1621;
  wire [31:0] n1622;
  wire [31:0] n1624;
  wire [3:0] n1625;
  wire [31:0] n1630;
  wire [31:0] n1632;
  wire n1633;
  wire [31:0] n1634;
  wire [31:0] n1635;
  wire [31:0] n1637;
  wire [3:0] n1638;
  wire [31:0] n1643;
  wire [31:0] n1644;
  wire [7:0] n1645;
  wire [31:0] n1646;
  wire [31:0] n1648;
  wire [3:0] n1649;
  wire [122:0] n1654;
  wire [127:0] n1656;
  wire [31:0] n1657;
  wire [31:0] n1659;
  wire [3:0] n1660;
  wire [3:0] n1662;
  wire [4:0] n1664;
  wire n1668;
  wire [123:0] n1669;
  wire [127:0] n1671;
  wire [31:0] n1672;
  wire [31:0] n1674;
  wire [3:0] n1675;
  wire [3:0] n1677;
  wire [3:0] n1679;
  wire [4:0] n1681;
  wire n1684;
  wire [124:0] n1685;
  wire [127:0] n1687;
  wire [31:0] n1688;
  wire [31:0] n1690;
  wire [3:0] n1691;
  wire [3:0] n1693;
  wire [2:0] n1695;
  wire [4:0] n1697;
  wire [1:0] n1699;
  reg [49:0] n1700;
  reg [127:0] n1701;
  wire [7:0] n1702;
  wire [49:0] n1703;
  wire n1706;
  wire [127:0] n1707;
  wire n1708;
  wire n1709;
  wire n1711;
  wire n1712;
  wire n1715;
  wire n1716;
  wire n1717;
  wire [4:0] n1718;
  wire [4:0] n1719;
  wire [4:0] n1720;
  wire [4:0] n1721;
  wire [4:0] n1722;
  wire [4:0] n1723;
  wire [4:0] n1724;
  wire [4:0] n1725;
  wire [4:0] n1726;
  wire [4:0] n1727;
  wire n1729;
  wire [4:0] n1730;
  reg [7:0] n1731;
  reg [3:0] n1732;
  reg [6:0] n1733;
  wire [4:0] n1734;
  reg [4:0] n1735;
  wire [4:0] n1736;
  reg [4:0] n1737;
  wire [4:0] n1738;
  reg [4:0] n1739;
  wire [4:0] n1740;
  reg [4:0] n1741;
  wire [4:0] n1742;
  reg [4:0] n1743;
  wire [4:0] n1744;
  reg [4:0] n1745;
  wire [4:0] n1746;
  reg [4:0] n1747;
  wire [4:0] n1748;
  reg [4:0] n1749;
  wire [4:0] n1750;
  reg [4:0] n1751;
  wire [4:0] n1752;
  reg [4:0] n1753;
  reg [3:0] n1754;
  reg [6:0] n1755;
  reg [49:0] n1756;
  reg n1758;
  reg n1760;
  reg n1762;
  reg n1763;
  reg n1765;
  reg n1767;
  reg [127:0] n1768;
  wire [6:0] n1775;
  wire [6:0] n1777;
  wire [31:0] n1780;
  wire [31:0] n1782;
  wire [7:0] n1783;
  wire [7:0] n1784;
  wire n1786;
  wire [127:0] n1787;
  wire [7:0] n1788;
  wire [3:0] n1789;
  wire [6:0] n1790;
  wire [49:0] n1791;
  wire [49:0] n1792;
  wire [3:0] n1793;
  wire [6:0] n1794;
  wire [49:0] n1795;
  wire n1797;
  wire n1798;
  wire n1799;
  wire n1800;
  wire n1801;
  wire n1802;
  wire n1803;
  wire [127:0] n1804;
  wire [7:0] n1805;
  wire [3:0] n1807;
  wire [6:0] n1809;
  wire [49:0] n1811;
  wire [3:0] n1812;
  wire [6:0] n1813;
  wire [49:0] n1815;
  wire n1817;
  wire n1819;
  wire n1820;
  wire n1821;
  wire n1822;
  wire n1823;
  wire n1824;
  wire [127:0] n1825;
  wire [3:0] n1861;
  wire [2:0] n1862;
  reg [2:0] n1863;
  wire [3:0] n1864;
  reg [3:0] n1865;
  wire [4:0] n1866;
  reg [4:0] n1867;
  wire [7:0] n1868;
  reg [7:0] n1869;
  wire [8:0] n1870;
  reg [8:0] n1871;
  wire [3:0] n1872;
  reg [3:0] n1873;
  wire [6:0] n1874;
  reg [6:0] n1875;
  wire [49:0] n1876;
  reg [49:0] n1877;
  wire [3:0] n1878;
  reg [3:0] n1879;
  wire [6:0] n1880;
  reg [6:0] n1881;
  wire [49:0] n1882;
  reg [49:0] n1883;
  wire [142:0] n1884;
  reg [142:0] n1885;
  wire [129:0] n1886;
  reg [129:0] n1887;
  wire [4:0] n1888;
  reg [4:0] n1889;
  wire n1890;
  reg n1891;
  wire n1892;
  reg n1893;
  wire [2:0] n1894;
  reg [2:0] n1895;
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
  wire n1952;
  reg n1953;
  wire n1954;
  reg n1955;
  wire n1956;
  reg n1957;
  wire n1958;
  reg n1959;
  wire n1960;
  reg n1961;
  wire n1962;
  reg n1963;
  wire [1:0] n1964;
  reg [1:0] n1965;
  wire [7:0] n1966;
  reg [7:0] n1967;
  wire [7:0] n1968;
  reg [7:0] n1969;
  wire [13:0] n1970;
  reg [13:0] n1971;
  wire [12:0] n1972;
  reg [12:0] n1973;
  wire [13:0] n1974;
  reg [13:0] n1975;
  wire [13:0] n1976;
  reg [13:0] n1977;
  wire [13:0] n1978;
  reg [13:0] n1979;
  wire [13:0] n1980;
  reg [13:0] n1981;
  wire [13:0] n1982;
  reg [13:0] n1983;
  wire [99:0] n1984;
  reg [99:0] n1985;
  wire [127:0] n1986;
  reg [127:0] n1987;
  wire [6:0] n1990; // mem_rd
  wire [6:0] n1993; // mem_rd
  wire [1:0] n1996; // mem_rd
  wire [1:0] n1997; // mem_rd
  wire [1:0] n1998; // mem_rd
  wire [1:0] n1999; // mem_rd
  wire [7:0] n2002; // mem_rd
  wire [8:0] n2004;
  wire [9:0] n2005; // mem_rd
  wire [8:0] n2006;
  wire [9:0] n2007; // mem_rd
  wire [2:0] n2010; // mem_rd
  wire [2:0] n2011; // mem_rd
  wire [2:0] n2012; // mem_rd
  wire [2:0] n2013; // mem_rd
  wire [2:0] n2014; // mem_rd
  wire [2:0] n2015; // mem_rd
  wire [159:0] n2017;
  wire [9:0] n2018;
  wire [79:0] n2020;
  wire [4:0] n2021;
  wire [159:0] n2023;
  wire [9:0] n2024;
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
  wire n2039;
  wire n2040;
  wire n2041;
  wire n2042;
  wire n2043;
  wire n2044;
  wire n2045;
  wire n2046;
  wire n2047;
  wire n2048;
  wire n2049;
  wire n2050;
  wire [9:0] n2051;
  wire [9:0] n2052;
  wire [9:0] n2053;
  wire [9:0] n2054;
  wire [9:0] n2055;
  wire [9:0] n2056;
  wire [9:0] n2057;
  wire [9:0] n2058;
  wire [9:0] n2059;
  wire [9:0] n2060;
  wire [9:0] n2061;
  wire [9:0] n2062;
  wire [9:0] n2063;
  wire [9:0] n2064;
  wire [9:0] n2065;
  wire [9:0] n2066;
  wire [9:0] n2067;
  wire [9:0] n2068;
  wire [9:0] n2069;
  wire [9:0] n2070;
  wire [99:0] n2071;
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
  wire n2086;
  wire n2087;
  wire n2088;
  wire n2089;
  wire n2090;
  wire n2091;
  wire n2092;
  wire n2093;
  wire n2094;
  wire n2095;
  wire n2096;
  wire n2097;
  wire [9:0] n2098;
  wire [9:0] n2099;
  wire [9:0] n2100;
  wire [9:0] n2101;
  wire [9:0] n2102;
  wire [9:0] n2103;
  wire [9:0] n2104;
  wire [9:0] n2105;
  wire [9:0] n2106;
  wire [9:0] n2107;
  wire [9:0] n2108;
  wire [9:0] n2109;
  wire [9:0] n2110;
  wire [9:0] n2111;
  wire [9:0] n2112;
  wire [9:0] n2113;
  wire [9:0] n2114;
  wire [9:0] n2115;
  wire [9:0] n2116;
  wire [9:0] n2117;
  wire [99:0] n2118;
  wire [159:0] n2120;
  wire [9:0] n2121;
  wire [79:0] n2123;
  wire [4:0] n2124;
  wire [159:0] n2126;
  wire [9:0] n2127;
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
  wire n2142;
  wire n2143;
  wire n2144;
  wire n2145;
  wire n2146;
  wire n2147;
  wire n2148;
  wire n2149;
  wire n2150;
  wire n2151;
  wire n2152;
  wire n2153;
  wire [9:0] n2154;
  wire [9:0] n2155;
  wire [9:0] n2156;
  wire [9:0] n2157;
  wire [9:0] n2158;
  wire [9:0] n2159;
  wire [9:0] n2160;
  wire [9:0] n2161;
  wire [9:0] n2162;
  wire [9:0] n2163;
  wire [9:0] n2164;
  wire [9:0] n2165;
  wire [9:0] n2166;
  wire [9:0] n2167;
  wire [9:0] n2168;
  wire [9:0] n2169;
  wire [9:0] n2170;
  wire [9:0] n2171;
  wire [9:0] n2172;
  wire [9:0] n2173;
  wire [99:0] n2174;
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
  wire n2189;
  wire n2190;
  wire n2191;
  wire n2192;
  wire n2193;
  wire n2194;
  wire n2195;
  wire n2196;
  wire n2197;
  wire n2198;
  wire n2199;
  wire n2200;
  wire [4:0] n2201;
  wire [4:0] n2202;
  wire [4:0] n2203;
  wire [4:0] n2204;
  wire [4:0] n2205;
  wire [4:0] n2206;
  wire [4:0] n2207;
  wire [4:0] n2208;
  wire [4:0] n2209;
  wire [4:0] n2210;
  wire [4:0] n2211;
  wire [4:0] n2212;
  wire [4:0] n2213;
  wire [4:0] n2214;
  wire [4:0] n2215;
  wire [4:0] n2216;
  wire [4:0] n2217;
  wire [4:0] n2218;
  wire [4:0] n2219;
  wire [4:0] n2220;
  wire [49:0] n2221;
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
  wire n2236;
  wire n2237;
  wire n2238;
  wire n2239;
  wire n2240;
  wire n2241;
  wire n2242;
  wire n2243;
  wire n2244;
  wire n2245;
  wire n2246;
  wire n2247;
  wire [4:0] n2248;
  wire [4:0] n2249;
  wire [4:0] n2250;
  wire [4:0] n2251;
  wire [4:0] n2252;
  wire [4:0] n2253;
  wire [4:0] n2254;
  wire [4:0] n2255;
  wire [4:0] n2256;
  wire [4:0] n2257;
  wire [4:0] n2258;
  wire [4:0] n2259;
  wire [4:0] n2260;
  wire [4:0] n2261;
  wire [4:0] n2262;
  wire [4:0] n2263;
  wire [4:0] n2264;
  wire [4:0] n2265;
  wire [4:0] n2266;
  wire [4:0] n2267;
  wire [49:0] n2268;
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
  wire n2283;
  wire n2284;
  wire n2285;
  wire n2286;
  wire n2287;
  wire n2288;
  wire n2289;
  wire n2290;
  wire n2291;
  wire n2292;
  wire n2293;
  wire n2294;
  wire [4:0] n2295;
  wire [4:0] n2296;
  wire [4:0] n2297;
  wire [4:0] n2298;
  wire [4:0] n2299;
  wire [4:0] n2300;
  wire [4:0] n2301;
  wire [4:0] n2302;
  wire [4:0] n2303;
  wire [4:0] n2304;
  wire [4:0] n2305;
  wire [4:0] n2306;
  wire [4:0] n2307;
  wire [4:0] n2308;
  wire [4:0] n2309;
  wire [4:0] n2310;
  wire [4:0] n2311;
  wire [4:0] n2312;
  wire [4:0] n2313;
  wire [4:0] n2314;
  wire [49:0] n2315;
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
  wire n2330;
  wire n2331;
  wire n2332;
  wire n2333;
  wire n2334;
  wire n2335;
  wire n2336;
  wire n2337;
  wire n2338;
  wire n2339;
  wire n2340;
  wire n2341;
  wire [4:0] n2342;
  wire [4:0] n2343;
  wire [4:0] n2344;
  wire [4:0] n2345;
  wire [4:0] n2346;
  wire [4:0] n2347;
  wire [4:0] n2348;
  wire [4:0] n2349;
  wire [4:0] n2350;
  wire [4:0] n2351;
  wire [4:0] n2352;
  wire [4:0] n2353;
  wire [4:0] n2354;
  wire [4:0] n2355;
  wire [4:0] n2356;
  wire [4:0] n2357;
  wire [4:0] n2358;
  wire [4:0] n2359;
  wire [4:0] n2360;
  wire [4:0] n2361;
  wire [49:0] n2362;
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
  wire n2377;
  wire n2378;
  wire n2379;
  wire n2380;
  wire n2381;
  wire n2382;
  wire n2383;
  wire n2384;
  wire n2385;
  wire n2386;
  wire n2387;
  wire n2388;
  wire [4:0] n2389;
  wire [4:0] n2390;
  wire [4:0] n2391;
  wire [4:0] n2392;
  wire [4:0] n2393;
  wire [4:0] n2394;
  wire [4:0] n2395;
  wire [4:0] n2396;
  wire [4:0] n2397;
  wire [4:0] n2398;
  wire [4:0] n2399;
  wire [4:0] n2400;
  wire [4:0] n2401;
  wire [4:0] n2402;
  wire [4:0] n2403;
  wire [4:0] n2404;
  wire [4:0] n2405;
  wire [4:0] n2406;
  wire [4:0] n2407;
  wire [4:0] n2408;
  wire [49:0] n2409;
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
  wire n2424;
  wire n2425;
  wire n2426;
  wire n2427;
  wire n2428;
  wire n2429;
  wire n2430;
  wire n2431;
  wire n2432;
  wire n2433;
  wire n2434;
  wire n2435;
  wire [4:0] n2436;
  wire [4:0] n2437;
  wire [4:0] n2438;
  wire [4:0] n2439;
  wire [4:0] n2440;
  wire [4:0] n2441;
  wire [4:0] n2442;
  wire [4:0] n2443;
  wire [4:0] n2444;
  wire [4:0] n2445;
  wire [4:0] n2446;
  wire [4:0] n2447;
  wire [4:0] n2448;
  wire [4:0] n2449;
  wire [4:0] n2450;
  wire [4:0] n2451;
  wire [4:0] n2452;
  wire [4:0] n2453;
  wire [4:0] n2454;
  wire [4:0] n2455;
  wire [49:0] n2456;
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
  wire n2700;
  wire n2701;
  wire n2702;
  wire n2703;
  wire n2704;
  wire n2705;
  wire n2706;
  wire n2707;
  wire n2708;
  wire n2709;
  wire n2710;
  wire n2711;
  wire [7:0] n2712;
  wire [7:0] n2713;
  wire n2714;
  wire n2715;
  wire [6:0] n2716;
  wire [7:0] n2717;
  wire [7:0] n2718;
  wire n2719;
  wire n2720;
  wire [6:0] n2721;
  wire [7:0] n2722;
  wire [7:0] n2723;
  wire n2724;
  wire n2725;
  wire [6:0] n2726;
  wire [7:0] n2727;
  wire [7:0] n2728;
  wire n2729;
  wire n2730;
  wire [6:0] n2731;
  wire [7:0] n2732;
  wire [7:0] n2733;
  wire n2734;
  wire n2735;
  wire [6:0] n2736;
  wire [7:0] n2737;
  wire [7:0] n2738;
  wire n2739;
  wire n2740;
  wire [6:0] n2741;
  wire [7:0] n2742;
  wire [7:0] n2743;
  wire n2744;
  wire n2745;
  wire [6:0] n2746;
  wire [7:0] n2747;
  wire [7:0] n2748;
  wire n2749;
  wire n2750;
  wire [6:0] n2751;
  wire [7:0] n2752;
  wire [7:0] n2753;
  wire n2754;
  wire n2755;
  wire [6:0] n2756;
  wire [7:0] n2757;
  wire [7:0] n2758;
  wire n2759;
  wire n2760;
  wire [6:0] n2761;
  wire [7:0] n2762;
  wire [7:0] n2763;
  wire n2764;
  wire n2765;
  wire [6:0] n2766;
  wire [7:0] n2767;
  wire [7:0] n2768;
  wire n2769;
  wire n2770;
  wire [6:0] n2771;
  wire [7:0] n2772;
  wire [7:0] n2773;
  wire n2774;
  wire n2775;
  wire [6:0] n2776;
  wire [7:0] n2777;
  wire [7:0] n2778;
  wire n2779;
  wire n2780;
  wire [6:0] n2781;
  wire [7:0] n2782;
  wire [7:0] n2783;
  wire n2784;
  wire n2785;
  wire [6:0] n2786;
  wire [7:0] n2787;
  wire [7:0] n2788;
  wire n2789;
  wire n2790;
  wire [6:0] n2791;
  wire [7:0] n2792;
  wire [7:0] n2793;
  wire n2794;
  wire n2795;
  wire [6:0] n2796;
  wire [7:0] n2797;
  wire [7:0] n2798;
  wire n2799;
  wire n2800;
  wire [6:0] n2801;
  wire [7:0] n2802;
  wire [7:0] n2803;
  wire n2804;
  wire n2805;
  wire [6:0] n2806;
  wire [7:0] n2807;
  wire [7:0] n2808;
  wire n2809;
  wire n2810;
  wire [6:0] n2811;
  wire [7:0] n2812;
  wire [7:0] n2813;
  wire n2814;
  wire n2815;
  wire [6:0] n2816;
  wire [7:0] n2817;
  wire [7:0] n2818;
  wire n2819;
  wire n2820;
  wire [6:0] n2821;
  wire [7:0] n2822;
  wire [7:0] n2823;
  wire n2824;
  wire n2825;
  wire [6:0] n2826;
  wire [7:0] n2827;
  wire [7:0] n2828;
  wire n2829;
  wire n2830;
  wire [6:0] n2831;
  wire [7:0] n2832;
  wire [7:0] n2833;
  wire n2834;
  wire n2835;
  wire [6:0] n2836;
  wire [7:0] n2837;
  wire [7:0] n2838;
  wire n2839;
  wire n2840;
  wire [6:0] n2841;
  wire [7:0] n2842;
  wire [7:0] n2843;
  wire n2844;
  wire n2845;
  wire [6:0] n2846;
  wire [7:0] n2847;
  wire [7:0] n2848;
  wire n2849;
  wire n2850;
  wire [6:0] n2851;
  wire [7:0] n2852;
  wire [7:0] n2853;
  wire n2854;
  wire n2855;
  wire [6:0] n2856;
  wire [7:0] n2857;
  wire [7:0] n2858;
  wire n2859;
  wire n2860;
  wire [6:0] n2861;
  wire [7:0] n2862;
  wire [7:0] n2863;
  wire n2864;
  wire n2865;
  wire [6:0] n2866;
  wire [7:0] n2867;
  wire [7:0] n2868;
  wire n2869;
  wire n2870;
  wire [6:0] n2871;
  wire [7:0] n2872;
  wire [7:0] n2873;
  wire n2874;
  wire n2875;
  wire [6:0] n2876;
  wire [7:0] n2877;
  wire [7:0] n2878;
  wire n2879;
  wire n2880;
  wire [6:0] n2881;
  wire [7:0] n2882;
  wire [7:0] n2883;
  wire n2884;
  wire n2885;
  wire [6:0] n2886;
  wire [7:0] n2887;
  wire [7:0] n2888;
  wire n2889;
  wire n2890;
  wire [6:0] n2891;
  wire [7:0] n2892;
  wire [7:0] n2893;
  wire n2894;
  wire n2895;
  wire [6:0] n2896;
  wire [7:0] n2897;
  wire [7:0] n2898;
  wire n2899;
  wire n2900;
  wire [6:0] n2901;
  wire [7:0] n2902;
  wire [7:0] n2903;
  wire n2904;
  wire n2905;
  wire [6:0] n2906;
  wire [7:0] n2907;
  wire [7:0] n2908;
  wire n2909;
  wire n2910;
  wire [6:0] n2911;
  wire [7:0] n2912;
  wire [7:0] n2913;
  wire n2914;
  wire n2915;
  wire [6:0] n2916;
  wire [7:0] n2917;
  wire [7:0] n2918;
  wire n2919;
  wire n2920;
  wire [6:0] n2921;
  wire [7:0] n2922;
  wire [7:0] n2923;
  wire n2924;
  wire n2925;
  wire [6:0] n2926;
  wire [7:0] n2927;
  wire [7:0] n2928;
  wire n2929;
  wire n2930;
  wire [6:0] n2931;
  wire [7:0] n2932;
  wire [7:0] n2933;
  wire n2934;
  wire n2935;
  wire [6:0] n2936;
  wire [7:0] n2937;
  wire [7:0] n2938;
  wire n2939;
  wire n2940;
  wire [6:0] n2941;
  wire [7:0] n2942;
  wire [7:0] n2943;
  wire n2944;
  wire n2945;
  wire [6:0] n2946;
  wire [7:0] n2947;
  wire [7:0] n2948;
  wire n2949;
  wire n2950;
  wire [6:0] n2951;
  wire [7:0] n2952;
  wire [7:0] n2953;
  wire n2954;
  wire n2955;
  wire [6:0] n2956;
  wire [7:0] n2957;
  wire [7:0] n2958;
  wire n2959;
  wire n2960;
  wire [6:0] n2961;
  wire [7:0] n2962;
  wire [7:0] n2963;
  wire n2964;
  wire n2965;
  wire [6:0] n2966;
  wire [7:0] n2967;
  wire [7:0] n2968;
  wire n2969;
  wire n2970;
  wire [6:0] n2971;
  wire [7:0] n2972;
  wire [7:0] n2973;
  wire n2974;
  wire n2975;
  wire [6:0] n2976;
  wire [7:0] n2977;
  wire [7:0] n2978;
  wire n2979;
  wire n2980;
  wire [6:0] n2981;
  wire [7:0] n2982;
  wire [7:0] n2983;
  wire n2984;
  wire n2985;
  wire [6:0] n2986;
  wire [7:0] n2987;
  wire [7:0] n2988;
  wire n2989;
  wire n2990;
  wire [6:0] n2991;
  wire [7:0] n2992;
  wire [7:0] n2993;
  wire n2994;
  wire n2995;
  wire [6:0] n2996;
  wire [7:0] n2997;
  wire [7:0] n2998;
  wire n2999;
  wire n3000;
  wire [6:0] n3001;
  wire [7:0] n3002;
  wire [7:0] n3003;
  wire n3004;
  wire n3005;
  wire [6:0] n3006;
  wire [7:0] n3007;
  wire [7:0] n3008;
  wire n3009;
  wire n3010;
  wire [6:0] n3011;
  wire [7:0] n3012;
  wire [7:0] n3013;
  wire n3014;
  wire n3015;
  wire [6:0] n3016;
  wire [7:0] n3017;
  wire [7:0] n3018;
  wire n3019;
  wire n3020;
  wire [6:0] n3021;
  wire [7:0] n3022;
  wire [7:0] n3023;
  wire n3024;
  wire n3025;
  wire [6:0] n3026;
  wire [7:0] n3027;
  wire [7:0] n3028;
  wire n3029;
  wire n3030;
  wire [6:0] n3031;
  wire [7:0] n3032;
  wire [7:0] n3033;
  wire n3034;
  wire n3035;
  wire [6:0] n3036;
  wire [7:0] n3037;
  wire [7:0] n3038;
  wire n3039;
  wire n3040;
  wire [6:0] n3041;
  wire [7:0] n3042;
  wire [7:0] n3043;
  wire n3044;
  wire n3045;
  wire [6:0] n3046;
  wire [7:0] n3047;
  wire [7:0] n3048;
  wire n3049;
  wire n3050;
  wire [6:0] n3051;
  wire [7:0] n3052;
  wire [7:0] n3053;
  wire n3054;
  wire n3055;
  wire [6:0] n3056;
  wire [7:0] n3057;
  wire [7:0] n3058;
  wire n3059;
  wire n3060;
  wire [6:0] n3061;
  wire [7:0] n3062;
  wire [7:0] n3063;
  wire n3064;
  wire n3065;
  wire [6:0] n3066;
  wire [7:0] n3067;
  wire [7:0] n3068;
  wire n3069;
  wire n3070;
  wire [6:0] n3071;
  wire [7:0] n3072;
  wire [7:0] n3073;
  wire n3074;
  wire n3075;
  wire [6:0] n3076;
  wire [7:0] n3077;
  wire [7:0] n3078;
  wire n3079;
  wire n3080;
  wire [6:0] n3081;
  wire [7:0] n3082;
  wire [7:0] n3083;
  wire n3084;
  wire n3085;
  wire [6:0] n3086;
  wire [7:0] n3087;
  wire [7:0] n3088;
  wire n3089;
  wire n3090;
  wire [6:0] n3091;
  wire [7:0] n3092;
  wire [7:0] n3093;
  wire n3094;
  wire n3095;
  wire [6:0] n3096;
  wire [7:0] n3097;
  wire [7:0] n3098;
  wire n3099;
  wire n3100;
  wire [6:0] n3101;
  wire [7:0] n3102;
  wire [7:0] n3103;
  wire n3104;
  wire n3105;
  wire [6:0] n3106;
  wire [7:0] n3107;
  wire [7:0] n3108;
  wire n3109;
  wire n3110;
  wire [6:0] n3111;
  wire [7:0] n3112;
  wire [7:0] n3113;
  wire n3114;
  wire n3115;
  wire [6:0] n3116;
  wire [7:0] n3117;
  wire [7:0] n3118;
  wire n3119;
  wire n3120;
  wire [6:0] n3121;
  wire [7:0] n3122;
  wire [7:0] n3123;
  wire n3124;
  wire n3125;
  wire [6:0] n3126;
  wire [7:0] n3127;
  wire [7:0] n3128;
  wire n3129;
  wire n3130;
  wire [6:0] n3131;
  wire [7:0] n3132;
  wire [7:0] n3133;
  wire n3134;
  wire n3135;
  wire [6:0] n3136;
  wire [7:0] n3137;
  wire [7:0] n3138;
  wire n3139;
  wire n3140;
  wire [6:0] n3141;
  wire [7:0] n3142;
  wire [7:0] n3143;
  wire n3144;
  wire n3145;
  wire [6:0] n3146;
  wire [7:0] n3147;
  wire [7:0] n3148;
  wire n3149;
  wire n3150;
  wire [6:0] n3151;
  wire [7:0] n3152;
  wire [7:0] n3153;
  wire n3154;
  wire n3155;
  wire [6:0] n3156;
  wire [7:0] n3157;
  wire [7:0] n3158;
  wire n3159;
  wire n3160;
  wire [6:0] n3161;
  wire [7:0] n3162;
  wire [7:0] n3163;
  wire n3164;
  wire n3165;
  wire [6:0] n3166;
  wire [7:0] n3167;
  wire [7:0] n3168;
  wire n3169;
  wire n3170;
  wire [6:0] n3171;
  wire [7:0] n3172;
  wire [7:0] n3173;
  wire n3174;
  wire n3175;
  wire [6:0] n3176;
  wire [7:0] n3177;
  wire [7:0] n3178;
  wire n3179;
  wire n3180;
  wire [6:0] n3181;
  wire [7:0] n3182;
  wire [7:0] n3183;
  wire n3184;
  wire n3185;
  wire [6:0] n3186;
  wire [7:0] n3187;
  wire [7:0] n3188;
  wire n3189;
  wire n3190;
  wire [6:0] n3191;
  wire [7:0] n3192;
  wire [7:0] n3193;
  wire n3194;
  wire n3195;
  wire [6:0] n3196;
  wire [7:0] n3197;
  wire [7:0] n3198;
  wire n3199;
  wire n3200;
  wire [6:0] n3201;
  wire [7:0] n3202;
  wire [7:0] n3203;
  wire n3204;
  wire n3205;
  wire [6:0] n3206;
  wire [7:0] n3207;
  wire [7:0] n3208;
  wire n3209;
  wire n3210;
  wire [6:0] n3211;
  wire [7:0] n3212;
  wire [7:0] n3213;
  wire n3214;
  wire n3215;
  wire [6:0] n3216;
  wire [7:0] n3217;
  wire [7:0] n3218;
  wire n3219;
  wire n3220;
  wire [6:0] n3221;
  wire [7:0] n3222;
  wire [7:0] n3223;
  wire n3224;
  wire n3225;
  wire [6:0] n3226;
  wire [7:0] n3227;
  wire [7:0] n3228;
  wire n3229;
  wire n3230;
  wire [6:0] n3231;
  wire [7:0] n3232;
  wire [7:0] n3233;
  wire n3234;
  wire n3235;
  wire [6:0] n3236;
  wire [7:0] n3237;
  wire [7:0] n3238;
  wire n3239;
  wire n3240;
  wire [6:0] n3241;
  wire [7:0] n3242;
  wire [7:0] n3243;
  wire n3244;
  wire n3245;
  wire [6:0] n3246;
  wire [7:0] n3247;
  wire [7:0] n3248;
  wire n3249;
  wire n3250;
  wire [6:0] n3251;
  wire [7:0] n3252;
  wire [7:0] n3253;
  wire n3254;
  wire n3255;
  wire [6:0] n3256;
  wire [7:0] n3257;
  wire [7:0] n3258;
  wire n3259;
  wire n3260;
  wire [6:0] n3261;
  wire [7:0] n3262;
  wire [7:0] n3263;
  wire n3264;
  wire n3265;
  wire [6:0] n3266;
  wire [7:0] n3267;
  wire [7:0] n3268;
  wire n3269;
  wire n3270;
  wire [6:0] n3271;
  wire [7:0] n3272;
  wire [7:0] n3273;
  wire n3274;
  wire n3275;
  wire [6:0] n3276;
  wire [7:0] n3277;
  wire [7:0] n3278;
  wire n3279;
  wire n3280;
  wire [6:0] n3281;
  wire [7:0] n3282;
  wire [7:0] n3283;
  wire n3284;
  wire n3285;
  wire [6:0] n3286;
  wire [7:0] n3287;
  wire [7:0] n3288;
  wire n3289;
  wire n3290;
  wire [6:0] n3291;
  wire [7:0] n3292;
  wire [7:0] n3293;
  wire n3294;
  wire n3295;
  wire [6:0] n3296;
  wire [7:0] n3297;
  wire [7:0] n3298;
  wire n3299;
  wire n3300;
  wire [6:0] n3301;
  wire [7:0] n3302;
  wire [7:0] n3303;
  wire n3304;
  wire n3305;
  wire [6:0] n3306;
  wire [7:0] n3307;
  wire [7:0] n3308;
  wire n3309;
  wire n3310;
  wire [6:0] n3311;
  wire [7:0] n3312;
  wire [7:0] n3313;
  wire [127:0] n3314;
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
    m_ic = n1863; // (isignal)
  initial
    m_ic = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:139:16 */
  always @*
    m_pc = n1865; // (isignal)
  initial
    m_pc = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:140:16 */
  always @*
    m_t = n1867; // (isignal)
  initial
    m_t = 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:141:16 */
  always @*
    m_fifo_ptr = n1869; // (isignal)
  initial
    m_fifo_ptr = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:142:16 */
  always @*
    m_pitch_count = n1871; // (isignal)
  initial
    m_pitch_count = 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:145:16 */
  always @*
    m_new_frame_energy_idx = n1873; // (isignal)
  initial
    m_new_frame_energy_idx = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:146:16 */
  always @*
    m_new_frame_pitch_idx = n1875; // (isignal)
  initial
    m_new_frame_pitch_idx = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  always @*
    m_new_frame_k_idx = n1877; // (isignal)
  initial
    m_new_frame_k_idx = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:149:16 */
  always @*
    tmp_new_frame_energy_idx = n1879; // (isignal)
  initial
    tmp_new_frame_energy_idx = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:150:16 */
  always @*
    tmp_new_frame_pitch_idx = n1881; // (isignal)
  initial
    tmp_new_frame_pitch_idx = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:151:16 */
  always @*
    tmp_new_frame_k_idx = n1883; // (isignal)
  initial
    tmp_new_frame_k_idx = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  always @*
    m_u = n1885; // (isignal)
  initial
    m_u = 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  always @*
    m_x = n1887; // (isignal)
  initial
    m_x = 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:162:16 */
  always @*
    m_wr_busy = n1889; // (isignal)
  initial
    m_wr_busy = 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:163:16 */
  always @*
    m_wr_srv = n1891; // (isignal)
  initial
    m_wr_srv = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:164:16 */
  always @*
    m_wr_data = n1893; // (isignal)
  initial
    m_wr_data = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:165:16 */
  always @*
    m_cmd_reg = n1895; // (isignal)
  initial
    m_cmd_reg = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:168:17 */
  always @*
    m_cyca = n1897; // (isignal)
  initial
    m_cyca = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:169:17 */
  always @*
    m_rst = n228; // (isignal)
  initial
    m_rst = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:172:17 */
  always @*
    m_clk = I_OSC; // (isignal)
  initial
    m_clk = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:173:17 */
  always @*
    m_ddis = n1899; // (isignal)
  initial
    m_ddis = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:174:17 */
  always @*
    m_ena = I_ENA; // (isignal)
  initial
    m_ena = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:175:17 */
  always @*
    m_olde = n1901; // (isignal)
  initial
    m_olde = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:176:17 */
  always @*
    m_oldp = n1903; // (isignal)
  initial
    m_oldp = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:177:17 */
  always @*
    m_rdb_clr = n1905; // (isignal)
  initial
    m_rdb_clr = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:178:17 */
  always @*
    m_rdb_cmd = n1907; // (isignal)
  initial
    m_rdb_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:179:17 */
  always @*
    m_rdb_flag = n1909; // (isignal)
  initial
    m_rdb_flag = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:180:17 */
  always @*
    m_rst_cmd = n1911; // (isignal)
  initial
    m_rst_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:181:17 */
  always @*
    m_sxt_cmd = n1913; // (isignal)
  initial
    m_sxt_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:182:17 */
  always @*
    m_rsn = I_RSn; // (isignal)
  initial
    m_rsn = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:183:17 */
  always @*
    m_rsn_last = n1915; // (isignal)
  initial
    m_rsn_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:184:17 */
  always @*
    m_spen = n1917; // (isignal)
  initial
    m_spen = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:185:17 */
  always @*
    m_t11 = n1919; // (isignal)
  initial
    m_t11 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:186:17 */
  always @*
    m_talk = n1921; // (isignal)
  initial
    m_talk = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:187:17 */
  always @*
    m_talk_last = n1923; // (isignal)
  initial
    m_talk_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:188:17 */
  always @*
    m_talkd = n1925; // (isignal)
  initial
    m_talkd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:189:17 */
  always @*
    m_talkd_last = n1927; // (isignal)
  initial
    m_talkd_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:190:17 */
  always @*
    m_uf = n1929; // (isignal)
  initial
    m_uf = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:191:17 */
  always @*
    m_wsn = I_WSn; // (isignal)
  initial
    m_wsn = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:192:17 */
  always @*
    m_wsn_last = n1931; // (isignal)
  initial
    m_wsn_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:193:17 */
  always @*
    m_wr_pending = n1933; // (isignal)
  initial
    m_wr_pending = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:194:17 */
  always @*
    m_buffer_empty = n109; // (isignal)
  initial
    m_buffer_empty = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:195:17 */
  always @*
    m_buffer_empty_last = n1935; // (isignal)
  initial
    m_buffer_empty_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:196:17 */
  always @*
    m_buffer_low = n103; // (isignal)
  initial
    m_buffer_low = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:197:17 */
  always @*
    m_buffer_low_last = n1937; // (isignal)
  initial
    m_buffer_low_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:198:17 */
  always @*
    m_cycb = n1939; // (isignal)
  initial
    m_cycb = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:199:17 */
  always @*
    m_inhibit = n1941; // (isignal)
  initial
    m_inhibit = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:200:17 */
  always @*
    m_io_ready = n1943; // (isignal)
  initial
    m_io_ready = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:201:17 */
  always @*
    m_irq_pin = n1945; // (isignal)
  initial
    m_irq_pin = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:202:17 */
  always @*
    m_irq_pin_clr = n1947; // (isignal)
  initial
    m_irq_pin_clr = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:203:17 */
  always @*
    m_new_frame_voiced = n1949; // (isignal)
  initial
    m_new_frame_voiced = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:204:17 */
  always @*
    m_new_frame_unvoiced = n1951; // (isignal)
  initial
    m_new_frame_unvoiced = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:205:17 */
  always @*
    m_new_frame_repeat = n1953; // (isignal)
  initial
    m_new_frame_repeat = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:206:17 */
  always @*
    m_new_frame_zero = n1955; // (isignal)
  initial
    m_new_frame_zero = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:207:17 */
  always @*
    m_new_frame_stop = n1957; // (isignal)
  initial
    m_new_frame_stop = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:208:17 */
  always @*
    m_pitch_zero = n1959; // (isignal)
  initial
    m_pitch_zero = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:209:17 */
  always @*
    m_zpar = n1961; // (isignal)
  initial
    m_zpar = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:210:17 */
  always @*
    m_uv_zpar = n1963; // (isignal)
  initial
    m_uv_zpar = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:213:17 */
  always @*
    phictr = n1965; // (isignal)
  initial
    phictr = 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:216:17 */
  always @*
    m_phi = n1861; // (isignal)
  initial
    m_phi = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:219:17 */
  always @*
    m_wr_reg = n1967; // (isignal)
  initial
    m_wr_reg = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:220:17 */
  always @*
    m_dbo = n1969; // (isignal)
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
    m_shift = n1971; // (isignal)
  initial
    m_shift = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:230:17 */
  always @*
    m_rng = n1973; // (isignal)
  initial
    m_rng = 13'b1111111111111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:233:17 */
  always @*
    m_excitation_data = n1975; // (isignal)
  initial
    m_excitation_data = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:234:17 */
  always @*
    m_previous_energy = n1977; // (isignal)
  initial
    m_previous_energy = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:235:17 */
  always @*
    m_current_energy = n1979; // (isignal)
  initial
    m_current_energy = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:236:17 */
  always @*
    m_current_pitch = n1981; // (isignal)
  initial
    m_current_pitch = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:237:17 */
  always @*
    this_sample = n1983; // (isignal)
  initial
    this_sample = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:240:17 */
  always @*
    m_current_k = n1985; // (isignal)
  initial
    m_current_k = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:243:17 */
  always @*
    m_fifo = n1987; // (isignal)
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
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:296:50 */
  assign n114 = phictr + 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:44 */
  assign n116 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:299:49 */
  assign n117 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:299:49 */
  assign n119 = n117 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:302:60 */
  assign n120 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:302:60 */
  assign n122 = n120 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:302:56 */
  assign n123 = n122[4:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:299:41 */
  assign n125 = n119 ? 5'b00001 : n123;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:49 */
  assign n126 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:49 */
  assign n128 = n126 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:65 */
  assign n129 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:65 */
  assign n131 = n129 != 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:55 */
  assign n132 = n131 & n128;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:307:59 */
  assign n133 = ~m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n134 = n168 ? n133 : m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n135 = n169 ? m_cyca : m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:312:68 */
  assign n136 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:312:68 */
  assign n138 = n136 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:312:59 */
  assign n139 = n138 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:312:84 */
  assign n140 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:312:84 */
  assign n142 = n140 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:312:74 */
  assign n143 = n142 & n139;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:315:58 */
  assign n144 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:315:58 */
  assign n146 = n144 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:318:71 */
  assign n147 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:318:71 */
  assign n149 = n147 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:318:65 */
  assign n150 = n149[2:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:315:49 */
  assign n152 = n146 ? 3'b000 : n150;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:320:71 */
  assign n153 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:320:71 */
  assign n155 = n153 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:320:62 */
  assign n156 = n155 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:321:62 */
  assign n157 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:321:62 */
  assign n159 = n157 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:321:57 */
  assign n160 = n159[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:320:41 */
  assign n161 = n156 ? n160 : m_pc;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n162 = n165 ? n152 : m_ic;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:312:41 */
  assign n164 = n143 ? 4'b0000 : n161;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n165 = n143 & n116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n166 = n116 ? n164 : m_pc;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n167 = n116 ? n125 : m_t;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n168 = n132 & n116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:33 */
  assign n169 = n132 & n116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:25 */
  assign n171 = m_rst ? 3'b000 : n162;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:25 */
  assign n173 = m_rst ? 4'b0000 : n166;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:25 */
  assign n175 = m_rst ? 5'b00001 : n167;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:25 */
  assign n177 = m_rst ? 1'b1 : n134;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:25 */
  assign n179 = m_rst ? 1'b0 : n135;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:288:25 */
  assign n181 = m_rst ? 2'b00 : n114;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:330:32 */
  assign n195 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:331:32 */
  assign n196 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:331:22 */
  assign n197 = ~n196;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:332:32 */
  assign n198 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:332:46 */
  assign n199 = phictr[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:332:37 */
  assign n200 = n198 | n199;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:32 */
  assign n201 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:22 */
  assign n202 = ~n201;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:46 */
  assign n203 = phictr[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:333:37 */
  assign n204 = n202 | n203;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:346:26 */
  assign n208 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:346:30 */
  assign n209 = ~n208;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:33 */
  assign n210 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:33 */
  assign n212 = n210 == 32'b00000000000000000000000000001011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:353:57 */
  assign n213 = m_shift[13:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:353:48 */
  assign n215 = {1'b0, n213};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:25 */
  assign n218 = n212 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:25 */
  assign n219 = n212 ? m_speech : n215;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:35 */
  assign n225 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:51 */
  assign n226 = ~m_rsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:46 */
  assign n227 = n225 & n226;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:30 */
  assign n228 = m_rst_cmd | n227;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:370:61 */
  assign n231 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:370:50 */
  assign n232 = n231 & m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:370:68 */
  assign n233 = m_rsn & n232;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:374:42 */
  assign n234 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:374:42 */
  assign n236 = $signed(n234) > $signed(32'b00000000000000000000000000000001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:375:56 */
  assign n237 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:375:56 */
  assign n239 = n237 - 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:375:46 */
  assign n240 = n239[4:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:376:42 */
  assign n241 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:376:42 */
  assign n243 = n241 == 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:70 */
  assign n244 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:70 */
  assign n246 = $signed(n244) < $signed(32'b00000000000000000000000000001000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:54 */
  assign n247 = n246 & m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:33 */
  assign n250 = n247 ? 5'b10000 : 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:33 */
  assign n253 = n247 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:33 */
  assign n255 = n247 ? m_io_ready : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:376:25 */
  assign n256 = n243 ? n250 : m_wr_busy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:376:25 */
  assign n258 = n243 ? n253 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:376:25 */
  assign n259 = n243 ? n255 : m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:374:25 */
  assign n260 = n236 ? n240 : n256;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:374:25 */
  assign n262 = n236 ? 1'b0 : n258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:374:25 */
  assign n263 = n236 ? m_io_ready : n259;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:370:25 */
  assign n265 = n233 ? 5'b10000 : n260;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:370:25 */
  assign n267 = n233 ? 1'b0 : n262;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:370:25 */
  assign n268 = n233 ? m_ddis : m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:370:25 */
  assign n270 = n233 ? 1'b0 : n263;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:367:25 */
  assign n272 = m_rst ? 5'b00000 : n265;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:367:25 */
  assign n274 = m_rst ? 1'b0 : n267;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:367:25 */
  assign n276 = m_rst ? m_wr_data : n268;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:367:25 */
  assign n278 = m_rst ? 1'b1 : n270;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:393:46 */
  assign n290 = m_rdb_clr | m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:395:25 */
  assign n292 = m_rdb_cmd ? 1'b1 : m_rdb_flag;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:393:25 */
  assign n294 = n290 ? 1'b0 : n292;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:410:79 */
  assign n300 = ~m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:410:60 */
  assign n301 = n300 & m_talk_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:411:54 */
  assign n302 = ~m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:411:60 */
  assign n303 = m_buffer_low & n302;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:410:86 */
  assign n304 = n301 | n303;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:412:54 */
  assign n305 = ~m_buffer_empty_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:412:60 */
  assign n306 = m_buffer_empty & n305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:411:86 */
  assign n307 = n304 | n306;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:415:53 */
  assign n308 = m_irq_pin_clr | m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:415:25 */
  assign n310 = n308 ? 1'b0 : m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:409:25 */
  assign n312 = n307 ? 1'b1 : n310;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:432:39 */
  assign n325 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:432:47 */
  assign n326 = m_talkd & n325;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:47 */
  assign n327 = m_rng[11:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:69 */
  assign n328 = m_rng[12]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:83 */
  assign n329 = m_rng[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:74 */
  assign n330 = n328 ^ n329;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:96 */
  assign n331 = m_rng[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:87 */
  assign n332 = n330 ^ n331;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:109 */
  assign n333 = m_rng[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:100 */
  assign n334 = n332 ^ n333;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:433:61 */
  assign n335 = {n327, n334};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:432:25 */
  assign n336 = n326 ? n335 : m_rng;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:426:25 */
  assign n338 = m_rst ? 13'b1111111111111 : n336;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:64 */
  assign n344 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:64 */
  assign n346 = n344 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:54 */
  assign n347 = n346 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:79 */
  assign n348 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:79 */
  assign n350 = n348 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:69 */
  assign n351 = n350 & n347;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:94 */
  assign n352 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:94 */
  assign n354 = n352 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:85 */
  assign n355 = n354 & n351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:110 */
  assign n356 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:114 */
  assign n357 = ~n356;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:100 */
  assign n358 = n357 & n355;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:121 */
  assign n359 = m_inhibit & n358;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:64 */
  assign n360 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:64 */
  assign n362 = n360 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:54 */
  assign n363 = n362 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:79 */
  assign n364 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:79 */
  assign n366 = n364 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:69 */
  assign n367 = n366 & n363;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:94 */
  assign n368 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:94 */
  assign n370 = n368 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:85 */
  assign n371 = n370 & n367;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:110 */
  assign n372 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:114 */
  assign n373 = ~n372;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:100 */
  assign n374 = n373 & n371;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:446:33 */
  assign n376 = n374 ? 1'b0 : m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:444:33 */
  assign n378 = n359 ? 1'b1 : n376;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:451:44 */
  assign n380 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:451:61 */
  assign n381 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:451:61 */
  assign n383 = n381 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:451:52 */
  assign n384 = n383 & n380;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:452:58 */
  assign n385 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:452:58 */
  assign n387 = n385 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:452:61 */
  assign n388 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:452:61 */
  assign n389 = $signed(n387) < $signed(n388);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:452:98 */
  assign n390 = ~m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:452:80 */
  assign n391 = n390 & n389;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:453:80 */
  assign n392 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:453:80 */
  assign n394 = n392 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:453:66 */
  assign n395 = n394[8:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:452:41 */
  assign n397 = n391 ? n395 : 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:443:25 */
  assign n399 = n384 & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:442:17 */
  assign n401 = n399 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:442:17 */
  assign n402 = m_talkd & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:470:59 */
  assign n408 = ~m_rsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:470:48 */
  assign n409 = n408 & m_rsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:470:66 */
  assign n410 = m_wsn & n409;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:477:67 */
  assign n411 = m_talkd | m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:477:78 */
  assign n412 = {n411, m_buffer_low};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:477:93 */
  assign n413 = {n412, m_buffer_empty};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:477:110 */
  assign n415 = {n413, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:471:33 */
  assign n418 = m_rdb_flag ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:471:33 */
  assign n421 = m_rdb_flag ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:471:33 */
  assign n423 = m_rdb_flag ? 8'b00000000 : n415;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:470:25 */
  assign n426 = n410 ? n421 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:466:17 */
  assign n429 = n410 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:466:17 */
  assign n432 = n410 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:489:33 */
  assign n440 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:489:33 */
  assign n442 = n440 == 32'b00000000000000000000000000010001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:489:49 */
  assign n443 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:489:53 */
  assign n444 = ~n443;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:489:39 */
  assign n445 = n444 & n442;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:491:50 */
  assign n446 = m_rng[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:491:41 */
  assign n449 = n446 ? 14'b11111111000000 : 14'b00000001000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:497:59 */
  assign n450 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:497:59 */
  assign n452 = $signed(n450) > $signed(32'b00000000000000000000000000110011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:500:81 */
  assign n453 = m_pitch_count[5:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:500:70 */
  assign n459 = {7'b0, n1990};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:497:41 */
  assign n461 = n452 ? 14'b00000000000000 : n459;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:490:33 */
  assign n462 = m_oldp ? n449 : n461;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:487:17 */
  assign n464 = n445 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:512:42 */
  assign n469 = m_rst | m_uf;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:57 */
  assign n470 = m_cyca & m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:86 */
  assign n471 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:86 */
  assign n473 = n471 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:76 */
  assign n474 = n473 & n470;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:101 */
  assign n475 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:101 */
  assign n477 = n475 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:91 */
  assign n478 = n477 & n474;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:116 */
  assign n479 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:116 */
  assign n481 = n479 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:107 */
  assign n482 = n481 & n478;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:132 */
  assign n483 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:136 */
  assign n484 = ~n483;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:122 */
  assign n485 = n484 & n482;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:75 */
  assign n486 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:57 */
  assign n487 = n486 & m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:94 */
  assign n488 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:82 */
  assign n489 = n488 & n487;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:25 */
  assign n491 = n489 ? 1'b1 : m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:514:25 */
  assign n493 = n485 ? 1'b0 : n491;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:512:25 */
  assign n495 = n469 ? 1'b0 : n493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:42 */
  assign n501 = m_rst | m_sxt_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:89 */
  assign n502 = m_ddis & m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:120 */
  assign n503 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:108 */
  assign n504 = n503 & n502;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:127 */
  assign n505 = m_buffer_low_last & n504;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:175 */
  assign n506 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:157 */
  assign n507 = n506 & n505;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:63 */
  assign n508 = n501 | n507;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:47 */
  assign n509 = m_cyca & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:76 */
  assign n510 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:76 */
  assign n512 = n510 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:66 */
  assign n513 = n512 & n509;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:91 */
  assign n514 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:91 */
  assign n516 = n514 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:81 */
  assign n517 = n516 & n513;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:106 */
  assign n518 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:106 */
  assign n520 = n518 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:97 */
  assign n521 = n520 & n517;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:122 */
  assign n522 = m_phi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:126 */
  assign n523 = ~n522;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:112 */
  assign n524 = n523 & n521;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:533:60 */
  assign n525 = {28'b0, m_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:533:60 */
  assign n527 = n525 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:533:33 */
  assign n530 = n527 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:539:59 */
  assign n531 = {25'b0, m_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:539:59 */
  assign n533 = n531 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:539:33 */
  assign n536 = n533 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:25 */
  assign n537 = n524 ? n530 : m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:532:25 */
  assign n538 = n524 ? n536 : m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:25 */
  assign n540 = n508 ? 1'b1 : n537;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:529:25 */
  assign n542 = n508 ? 1'b1 : n538;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:56 */
  assign n550 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:56 */
  assign n552 = n550 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:46 */
  assign n553 = n552 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:71 */
  assign n554 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:71 */
  assign n556 = n554 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:61 */
  assign n557 = n556 & n553;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:86 */
  assign n558 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:86 */
  assign n560 = n558 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:77 */
  assign n561 = n560 & n557;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:102 */
  assign n562 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:106 */
  assign n563 = ~n562;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:92 */
  assign n564 = n563 & n561;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:560:44 */
  assign n565 = ~m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:560:51 */
  assign n566 = m_spen & n565;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:560:33 */
  assign n568 = n566 ? 1'b1 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:37 */
  assign n569 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:37 */
  assign n571 = n569 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:52 */
  assign n572 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:52 */
  assign n574 = n572 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:42 */
  assign n575 = n574 & n571;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:70 */
  assign n576 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:58 */
  assign n577 = n576 & n575;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:25 */
  assign n579 = n577 ? 1'b0 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:25 */
  assign n580 = n564 ? n568 : n579;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:557:25 */
  assign n581 = n564 ? m_talk : m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:554:25 */
  assign n583 = m_rst ? 1'b0 : n580;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:554:25 */
  assign n585 = m_rst ? 1'b0 : n581;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:572:35 */
  assign n586 = ~m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:572:42 */
  assign n587 = m_buffer_low_last & n586;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:572:90 */
  assign n588 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:572:72 */
  assign n589 = n588 & n587;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:572:109 */
  assign n590 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:572:97 */
  assign n591 = n590 & n589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:572:25 */
  assign n593 = n591 ? 1'b1 : n583;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:55 */
  assign n601 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:55 */
  assign n603 = n601 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:46 */
  assign n604 = n603 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:71 */
  assign n605 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:75 */
  assign n606 = ~n605;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:61 */
  assign n607 = n606 & n604;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:82 */
  assign n608 = m_talkd & n607;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:592:66 */
  assign n609 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:592:82 */
  assign n610 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:592:82 */
  assign n612 = n610 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:592:73 */
  assign n613 = n609 | n612;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:593:94 */
  assign n614 = {{18{m_current_energy[13]}}, m_current_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:126 */
  assign n620 = {25'b0, n1993};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:126 */
  assign n621 = {{18{m_current_energy[13]}}, m_current_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:126 */
  assign n622 = n620 - n621;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:80 */
  assign n623 = n622[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:150 */
  assign n629 = {29'b0, n1999};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:68 */
  assign n630 = $signed(n623) >>> n629;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:57 */
  assign n631 = {{20{n630[11]}}, n630}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:593:94 */
  assign n632 = n614 + n631;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:593:77 */
  assign n633 = n632[13:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:592:49 */
  assign n634 = n613 ? n633 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:49 */
  assign n636 = m_zpar ? 14'b00000000000000 : n634;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:41 */
  assign n638 = m_pc == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:66 */
  assign n639 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:82 */
  assign n640 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:82 */
  assign n642 = n640 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:73 */
  assign n643 = n639 | n642;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:600:92 */
  assign n644 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:101 */
  assign n645 = m_new_frame_pitch_idx[5:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:124 */
  assign n651 = {24'b0, n2002};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:124 */
  assign n652 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:124 */
  assign n653 = n651 - n652;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:80 */
  assign n654 = n653[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:148 */
  assign n659 = {29'b0, n1998};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:68 */
  assign n660 = $signed(n654) >>> n659;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:57 */
  assign n661 = {{20{n660[11]}}, n660}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:600:92 */
  assign n662 = n644 + n661;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:600:76 */
  assign n663 = n662[13:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:599:49 */
  assign n664 = n643 ? n663 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:597:49 */
  assign n666 = m_zpar ? 14'b00000000000000 : n664;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:596:41 */
  assign n668 = m_pc == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:63 */
  assign n669 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:79 */
  assign n670 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:79 */
  assign n672 = n670 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:70 */
  assign n673 = n669 | n672;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:73 */
  assign n674 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:73 */
  assign n676 = n674 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:73 */
  assign n677 = n676[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:73 */
  assign n679 = 4'b1001 - n677;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:96 */
  assign n681 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:96 */
  assign n683 = n681 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:96 */
  assign n684 = n683[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:96 */
  assign n686 = 4'b1001 - n684;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:100 */
  assign n689 = {{22{n2018[9]}}, n2018}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:103 */
  assign n690 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:103 */
  assign n692 = n690 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:103 */
  assign n693 = n692[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:103 */
  assign n695 = 4'b1001 - n693;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:130 */
  assign n697 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:130 */
  assign n699 = n697 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:130 */
  assign n700 = n699[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:130 */
  assign n702 = 4'b1001 - n700;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:125 */
  assign n706 = 5'b11111 - n2021;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:136 */
  assign n711 = {{22{n2007[9]}}, n2007}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:154 */
  assign n712 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:154 */
  assign n714 = n712 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:154 */
  assign n715 = n714[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:154 */
  assign n717 = 4'b1001 - n715;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:136 */
  assign n720 = {{22{n2024[9]}}, n2024}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:136 */
  assign n721 = n711 - n720;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:80 */
  assign n722 = n721[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:165 */
  assign n727 = {29'b0, n1997};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:68 */
  assign n728 = $signed(n722) >>> n727;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:57 */
  assign n729 = {{20{n728[11]}}, n728}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:100 */
  assign n730 = n689 + n729;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:80 */
  assign n731 = n730[9:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:49 */
  assign n733 = n673 ? n2071 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:603:41 */
  assign n736 = $unsigned(m_pc) >= $unsigned(4'b0010);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:603:41 */
  assign n737 = $unsigned(m_pc) <= $unsigned(4'b0101);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:603:41 */
  assign n738 = n736 & n737;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:73 */
  assign n739 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:73 */
  assign n741 = n739 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:73 */
  assign n742 = n741[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:73 */
  assign n744 = 4'b1001 - n742;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:71 */
  assign n748 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:87 */
  assign n749 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:87 */
  assign n751 = n749 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:78 */
  assign n752 = n748 | n751;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:81 */
  assign n753 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:81 */
  assign n755 = n753 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:81 */
  assign n756 = n755[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:81 */
  assign n758 = 4'b1001 - n756;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:104 */
  assign n760 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:104 */
  assign n762 = n760 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:104 */
  assign n763 = n762[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:104 */
  assign n765 = 4'b1001 - n763;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:108 */
  assign n768 = {{22{n2121[9]}}, n2121}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  assign n769 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  assign n771 = n769 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  assign n772 = n771[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  assign n774 = 4'b1001 - n772;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:138 */
  assign n776 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:138 */
  assign n778 = n776 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:138 */
  assign n779 = n778[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:138 */
  assign n781 = 4'b1001 - n779;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:133 */
  assign n785 = 5'b11111 - n2124;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:144 */
  assign n789 = {{22{n2005[9]}}, n2005}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:162 */
  assign n790 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:162 */
  assign n792 = n790 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:162 */
  assign n793 = n792[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:162 */
  assign n795 = 4'b1001 - n793;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:144 */
  assign n798 = {{22{n2127[9]}}, n2127}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:144 */
  assign n799 = n789 - n798;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:88 */
  assign n800 = n799[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:173 */
  assign n805 = {29'b0, n1996};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:76 */
  assign n806 = $signed(n800) >>> n805;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:65 */
  assign n807 = {{20{n806[11]}}, n806}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:108 */
  assign n808 = n768 + n807;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:88 */
  assign n809 = n808[9:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:57 */
  assign n811 = n752 ? n2174 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:609:49 */
  assign n812 = m_uv_zpar ? n2118 : n811;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:608:41 */
  assign n815 = $unsigned(m_pc) >= $unsigned(4'b0110);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:608:41 */
  assign n816 = $unsigned(m_pc) <= $unsigned(4'b1011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:608:41 */
  assign n817 = n815 & n816;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:588:33 */
  assign n818 = {n817, n738, n668, n638};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:588:33 */
  always @*
    case (n818)
      4'b1000: n819 = m_current_energy;
      4'b0100: n819 = m_current_energy;
      4'b0010: n819 = m_current_energy;
      4'b0001: n819 = n636;
      default: n819 = m_current_energy;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:588:33 */
  always @*
    case (n818)
      4'b1000: n820 = m_current_pitch;
      4'b0100: n820 = m_current_pitch;
      4'b0010: n820 = n666;
      4'b0001: n820 = m_current_pitch;
      default: n820 = m_current_pitch;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:588:33 */
  always @*
    case (n818)
      4'b1000: n821 = n812;
      4'b0100: n821 = n733;
      4'b0010: n821 = m_current_k;
      4'b0001: n821 = m_current_k;
      default: n821 = m_current_k;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:25 */
  assign n822 = n608 ? n819 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:25 */
  assign n823 = n608 ? n820 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:25 */
  assign n824 = n608 ? n821 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:25 */
  assign n826 = m_rst ? 14'b00000000000000 : n822;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:25 */
  assign n828 = m_rst ? 14'b00000000000000 : n823;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:25 */
  assign n829 = m_rst ? m_current_k : n824;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:58 */
  assign n839 = m_phi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:62 */
  assign n840 = ~n839;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:48 */
  assign n841 = n840 & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:111 */
  assign n842 = {{18{m_previous_energy[13]}}, m_previous_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:111 */
  assign n843 = {{18{m_excitation_data[13]}}, m_excitation_data}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:111 */
  assign n844 = $signed(n842) * $signed(n843); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:83 */
  assign n845 = n844[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:71 */
  assign n847 = $signed(n845) >>> 31'b0000000000000000000000000000011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:60 */
  assign n849 = n847[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:41 */
  assign n851 = m_t == 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:63 */
  assign n852 = m_u[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:68 */
  assign n853 = {{19{n852[12]}}, n852}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:114 */
  assign n854 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n855 = {{22{n854[9]}}, n854}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:124 */
  assign n856 = m_x[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n857 = {{19{n856[12]}}, n856}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n858 = $signed(n855) * $signed(n857); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:93 */
  assign n859 = n858[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:81 */
  assign n861 = $signed(n859) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:70 */
  assign n862 = {{10{n861[21]}}, n861}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:68 */
  assign n863 = n853 - n862;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:60 */
  assign n864 = n863[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:41 */
  assign n866 = m_t == 5'b00010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:63 */
  assign n867 = m_u[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:68 */
  assign n868 = {{19{n867[12]}}, n867}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:114 */
  assign n869 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n870 = {{22{n869[9]}}, n869}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:124 */
  assign n871 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n872 = {{19{n871[12]}}, n871}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n873 = $signed(n870) * $signed(n872); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:93 */
  assign n874 = n873[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:81 */
  assign n876 = $signed(n874) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:70 */
  assign n877 = {{10{n876[21]}}, n876}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:68 */
  assign n878 = n868 - n877;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:60 */
  assign n879 = n878[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:41 */
  assign n881 = m_t == 5'b00011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:63 */
  assign n882 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:68 */
  assign n883 = {{19{n882[12]}}, n882}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:114 */
  assign n884 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:119 */
  assign n885 = {{22{n884[9]}}, n884}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:124 */
  assign n886 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:119 */
  assign n887 = {{19{n886[12]}}, n886}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:119 */
  assign n888 = $signed(n885) * $signed(n887); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:93 */
  assign n889 = n888[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:81 */
  assign n891 = $signed(n889) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:70 */
  assign n892 = {{10{n891[21]}}, n891}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:68 */
  assign n893 = n883 + n892;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:60 */
  assign n894 = n893[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:63 */
  assign n895 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:68 */
  assign n896 = {{19{n895[12]}}, n895}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:114 */
  assign n897 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n898 = {{22{n897[9]}}, n897}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:124 */
  assign n899 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n900 = {{19{n899[12]}}, n899}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n901 = $signed(n898) * $signed(n900); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:93 */
  assign n902 = n901[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:81 */
  assign n904 = $signed(n902) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:70 */
  assign n905 = {{10{n904[21]}}, n904}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:68 */
  assign n906 = n896 - n905;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:60 */
  assign n907 = n906[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:41 */
  assign n909 = m_t == 5'b00100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:63 */
  assign n910 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:68 */
  assign n911 = {{19{n910[12]}}, n910}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:114 */
  assign n912 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:119 */
  assign n913 = {{22{n912[9]}}, n912}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:124 */
  assign n914 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:119 */
  assign n915 = {{19{n914[12]}}, n914}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:119 */
  assign n916 = $signed(n913) * $signed(n915); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:93 */
  assign n917 = n916[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:81 */
  assign n919 = $signed(n917) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:70 */
  assign n920 = {{10{n919[21]}}, n919}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:68 */
  assign n921 = n911 + n920;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:60 */
  assign n922 = n921[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:63 */
  assign n923 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:68 */
  assign n924 = {{19{n923[12]}}, n923}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:114 */
  assign n925 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:119 */
  assign n926 = {{22{n925[9]}}, n925}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:124 */
  assign n927 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:119 */
  assign n928 = {{19{n927[12]}}, n927}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:119 */
  assign n929 = $signed(n926) * $signed(n928); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:93 */
  assign n930 = n929[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:81 */
  assign n932 = $signed(n930) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:70 */
  assign n933 = {{10{n932[21]}}, n932}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:68 */
  assign n934 = n924 - n933;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:648:60 */
  assign n935 = n934[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:646:41 */
  assign n937 = m_t == 5'b00101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:63 */
  assign n938 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:68 */
  assign n939 = {{19{n938[12]}}, n938}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:114 */
  assign n940 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:119 */
  assign n941 = {{22{n940[9]}}, n940}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:124 */
  assign n942 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:119 */
  assign n943 = {{19{n942[12]}}, n942}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:119 */
  assign n944 = $signed(n941) * $signed(n943); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:93 */
  assign n945 = n944[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:81 */
  assign n947 = $signed(n945) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:70 */
  assign n948 = {{10{n947[21]}}, n947}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:68 */
  assign n949 = n939 + n948;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:650:60 */
  assign n950 = n949[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:63 */
  assign n951 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:68 */
  assign n952 = {{19{n951[12]}}, n951}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:114 */
  assign n953 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:119 */
  assign n954 = {{22{n953[9]}}, n953}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:124 */
  assign n955 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:119 */
  assign n956 = {{19{n955[12]}}, n955}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:119 */
  assign n957 = $signed(n954) * $signed(n956); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:93 */
  assign n958 = n957[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:81 */
  assign n960 = $signed(n958) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:70 */
  assign n961 = {{10{n960[21]}}, n960}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:68 */
  assign n962 = n952 - n961;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:651:60 */
  assign n963 = n962[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:649:41 */
  assign n965 = m_t == 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:63 */
  assign n966 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:68 */
  assign n967 = {{19{n966[12]}}, n966}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:114 */
  assign n968 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:119 */
  assign n969 = {{22{n968[9]}}, n968}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:124 */
  assign n970 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:119 */
  assign n971 = {{19{n970[12]}}, n970}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:119 */
  assign n972 = $signed(n969) * $signed(n971); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:93 */
  assign n973 = n972[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:81 */
  assign n975 = $signed(n973) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:70 */
  assign n976 = {{10{n975[21]}}, n975}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:68 */
  assign n977 = n967 + n976;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:653:60 */
  assign n978 = n977[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:63 */
  assign n979 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:68 */
  assign n980 = {{19{n979[12]}}, n979}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:114 */
  assign n981 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:119 */
  assign n982 = {{22{n981[9]}}, n981}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:124 */
  assign n983 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:119 */
  assign n984 = {{19{n983[12]}}, n983}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:119 */
  assign n985 = $signed(n982) * $signed(n984); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:93 */
  assign n986 = n985[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:81 */
  assign n988 = $signed(n986) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:70 */
  assign n989 = {{10{n988[21]}}, n988}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:68 */
  assign n990 = n980 - n989;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:654:60 */
  assign n991 = n990[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:652:41 */
  assign n993 = m_t == 5'b00111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:63 */
  assign n994 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:68 */
  assign n995 = {{19{n994[12]}}, n994}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:114 */
  assign n996 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:119 */
  assign n997 = {{22{n996[9]}}, n996}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:124 */
  assign n998 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:119 */
  assign n999 = {{19{n998[12]}}, n998}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:119 */
  assign n1000 = $signed(n997) * $signed(n999); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:93 */
  assign n1001 = n1000[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:81 */
  assign n1003 = $signed(n1001) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:70 */
  assign n1004 = {{10{n1003[21]}}, n1003}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:68 */
  assign n1005 = n995 + n1004;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:656:60 */
  assign n1006 = n1005[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:63 */
  assign n1007 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:68 */
  assign n1008 = {{19{n1007[12]}}, n1007}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:114 */
  assign n1009 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:119 */
  assign n1010 = {{22{n1009[9]}}, n1009}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:124 */
  assign n1011 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:119 */
  assign n1012 = {{19{n1011[12]}}, n1011}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:119 */
  assign n1013 = $signed(n1010) * $signed(n1012); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:93 */
  assign n1014 = n1013[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:81 */
  assign n1016 = $signed(n1014) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:70 */
  assign n1017 = {{10{n1016[21]}}, n1016}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:68 */
  assign n1018 = n1008 - n1017;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:60 */
  assign n1019 = n1018[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:655:41 */
  assign n1021 = m_t == 5'b01000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:63 */
  assign n1022 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:68 */
  assign n1023 = {{19{n1022[12]}}, n1022}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:114 */
  assign n1024 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:119 */
  assign n1025 = {{22{n1024[9]}}, n1024}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:124 */
  assign n1026 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:119 */
  assign n1027 = {{19{n1026[12]}}, n1026}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:119 */
  assign n1028 = $signed(n1025) * $signed(n1027); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:93 */
  assign n1029 = n1028[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:81 */
  assign n1031 = $signed(n1029) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:70 */
  assign n1032 = {{10{n1031[21]}}, n1031}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:68 */
  assign n1033 = n1023 + n1032;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:60 */
  assign n1034 = n1033[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:63 */
  assign n1035 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:68 */
  assign n1036 = {{19{n1035[12]}}, n1035}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:114 */
  assign n1037 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:119 */
  assign n1038 = {{22{n1037[9]}}, n1037}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:124 */
  assign n1039 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:119 */
  assign n1040 = {{19{n1039[12]}}, n1039}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:119 */
  assign n1041 = $signed(n1038) * $signed(n1040); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:93 */
  assign n1042 = n1041[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:81 */
  assign n1044 = $signed(n1042) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:70 */
  assign n1045 = {{10{n1044[21]}}, n1044}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:68 */
  assign n1046 = n1036 - n1045;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:660:60 */
  assign n1047 = n1046[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:658:41 */
  assign n1049 = m_t == 5'b01001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:63 */
  assign n1050 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:68 */
  assign n1051 = {{19{n1050[12]}}, n1050}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:114 */
  assign n1052 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:119 */
  assign n1053 = {{22{n1052[9]}}, n1052}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:124 */
  assign n1054 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:119 */
  assign n1055 = {{19{n1054[12]}}, n1054}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:119 */
  assign n1056 = $signed(n1053) * $signed(n1055); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:93 */
  assign n1057 = n1056[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:81 */
  assign n1059 = $signed(n1057) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:70 */
  assign n1060 = {{10{n1059[21]}}, n1059}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:68 */
  assign n1061 = n1051 + n1060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:662:60 */
  assign n1062 = n1061[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:63 */
  assign n1063 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:68 */
  assign n1064 = {{19{n1063[12]}}, n1063}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:114 */
  assign n1065 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:119 */
  assign n1066 = {{22{n1065[9]}}, n1065}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:124 */
  assign n1067 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:119 */
  assign n1068 = {{19{n1067[12]}}, n1067}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:119 */
  assign n1069 = $signed(n1066) * $signed(n1068); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:93 */
  assign n1070 = n1069[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:81 */
  assign n1072 = $signed(n1070) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:70 */
  assign n1073 = {{10{n1072[21]}}, n1072}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:68 */
  assign n1074 = n1064 - n1073;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:60 */
  assign n1075 = n1074[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:661:41 */
  assign n1077 = m_t == 5'b01010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:63 */
  assign n1078 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:68 */
  assign n1079 = {{19{n1078[12]}}, n1078}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:114 */
  assign n1080 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:119 */
  assign n1081 = {{22{n1080[9]}}, n1080}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:124 */
  assign n1082 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:119 */
  assign n1083 = {{19{n1082[12]}}, n1082}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:119 */
  assign n1084 = $signed(n1081) * $signed(n1083); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:93 */
  assign n1085 = n1084[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:81 */
  assign n1087 = $signed(n1085) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:70 */
  assign n1088 = {{10{n1087[21]}}, n1087}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:68 */
  assign n1089 = n1079 + n1088;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:665:60 */
  assign n1090 = n1089[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:63 */
  assign n1091 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:68 */
  assign n1092 = {{19{n1091[12]}}, n1091}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:114 */
  assign n1093 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:119 */
  assign n1094 = {{22{n1093[9]}}, n1093}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:124 */
  assign n1095 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:119 */
  assign n1096 = {{19{n1095[12]}}, n1095}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:119 */
  assign n1097 = $signed(n1094) * $signed(n1096); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:93 */
  assign n1098 = n1097[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:81 */
  assign n1100 = $signed(n1098) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:70 */
  assign n1101 = {{10{n1100[21]}}, n1100}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:68 */
  assign n1102 = n1092 - n1101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:60 */
  assign n1103 = n1102[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:664:41 */
  assign n1105 = m_t == 5'b01011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:63 */
  assign n1106 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:68 */
  assign n1107 = {{19{n1106[12]}}, n1106}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:114 */
  assign n1108 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:119 */
  assign n1109 = {{22{n1108[9]}}, n1108}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:124 */
  assign n1110 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:119 */
  assign n1111 = {{19{n1110[12]}}, n1110}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:119 */
  assign n1112 = $signed(n1109) * $signed(n1111); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:93 */
  assign n1113 = n1112[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:81 */
  assign n1115 = $signed(n1113) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:70 */
  assign n1116 = {{10{n1115[21]}}, n1115}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:68 */
  assign n1117 = n1107 + n1116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:60 */
  assign n1118 = n1117[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:669:63 */
  assign n1119 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:670:67 */
  assign n1120 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:670:64 */
  assign n1121 = {{1{n1120[12]}}, n1120}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:667:41 */
  assign n1123 = m_t == 5'b01100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  assign n1124 = {n1123, n1105, n1077, n1049, n1021, n993, n965, n937, n909, n881, n866, n851};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1125 = m_u[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1126 = n1125;
      12'b010000000000: n1126 = n1125;
      12'b001000000000: n1126 = n1125;
      12'b000100000000: n1126 = n1125;
      12'b000010000000: n1126 = n1125;
      12'b000001000000: n1126 = n1125;
      12'b000000100000: n1126 = n1125;
      12'b000000010000: n1126 = n1125;
      12'b000000001000: n1126 = n1125;
      12'b000000000100: n1126 = n1125;
      12'b000000000010: n1126 = n1125;
      12'b000000000001: n1126 = n849;
      default: n1126 = n1125;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1127 = m_u[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1128 = n1127;
      12'b010000000000: n1128 = n1127;
      12'b001000000000: n1128 = n1127;
      12'b000100000000: n1128 = n1127;
      12'b000010000000: n1128 = n1127;
      12'b000001000000: n1128 = n1127;
      12'b000000100000: n1128 = n1127;
      12'b000000010000: n1128 = n1127;
      12'b000000001000: n1128 = n1127;
      12'b000000000100: n1128 = n1127;
      12'b000000000010: n1128 = n864;
      12'b000000000001: n1128 = n1127;
      default: n1128 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1129 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1130 = n1129;
      12'b010000000000: n1130 = n1129;
      12'b001000000000: n1130 = n1129;
      12'b000100000000: n1130 = n1129;
      12'b000010000000: n1130 = n1129;
      12'b000001000000: n1130 = n1129;
      12'b000000100000: n1130 = n1129;
      12'b000000010000: n1130 = n1129;
      12'b000000001000: n1130 = n1129;
      12'b000000000100: n1130 = n879;
      12'b000000000010: n1130 = n1129;
      12'b000000000001: n1130 = n1129;
      default: n1130 = n1129;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1131 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1132 = n1131;
      12'b010000000000: n1132 = n1131;
      12'b001000000000: n1132 = n1131;
      12'b000100000000: n1132 = n1131;
      12'b000010000000: n1132 = n1131;
      12'b000001000000: n1132 = n1131;
      12'b000000100000: n1132 = n1131;
      12'b000000010000: n1132 = n1131;
      12'b000000001000: n1132 = n907;
      12'b000000000100: n1132 = n1131;
      12'b000000000010: n1132 = n1131;
      12'b000000000001: n1132 = n1131;
      default: n1132 = n1131;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1133 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1134 = n1133;
      12'b010000000000: n1134 = n1133;
      12'b001000000000: n1134 = n1133;
      12'b000100000000: n1134 = n1133;
      12'b000010000000: n1134 = n1133;
      12'b000001000000: n1134 = n1133;
      12'b000000100000: n1134 = n1133;
      12'b000000010000: n1134 = n935;
      12'b000000001000: n1134 = n1133;
      12'b000000000100: n1134 = n1133;
      12'b000000000010: n1134 = n1133;
      12'b000000000001: n1134 = n1133;
      default: n1134 = n1133;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1135 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1136 = n1135;
      12'b010000000000: n1136 = n1135;
      12'b001000000000: n1136 = n1135;
      12'b000100000000: n1136 = n1135;
      12'b000010000000: n1136 = n1135;
      12'b000001000000: n1136 = n1135;
      12'b000000100000: n1136 = n963;
      12'b000000010000: n1136 = n1135;
      12'b000000001000: n1136 = n1135;
      12'b000000000100: n1136 = n1135;
      12'b000000000010: n1136 = n1135;
      12'b000000000001: n1136 = n1135;
      default: n1136 = n1135;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1137 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1138 = n1137;
      12'b010000000000: n1138 = n1137;
      12'b001000000000: n1138 = n1137;
      12'b000100000000: n1138 = n1137;
      12'b000010000000: n1138 = n1137;
      12'b000001000000: n1138 = n991;
      12'b000000100000: n1138 = n1137;
      12'b000000010000: n1138 = n1137;
      12'b000000001000: n1138 = n1137;
      12'b000000000100: n1138 = n1137;
      12'b000000000010: n1138 = n1137;
      12'b000000000001: n1138 = n1137;
      default: n1138 = n1137;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1139 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1140 = n1139;
      12'b010000000000: n1140 = n1139;
      12'b001000000000: n1140 = n1139;
      12'b000100000000: n1140 = n1139;
      12'b000010000000: n1140 = n1019;
      12'b000001000000: n1140 = n1139;
      12'b000000100000: n1140 = n1139;
      12'b000000010000: n1140 = n1139;
      12'b000000001000: n1140 = n1139;
      12'b000000000100: n1140 = n1139;
      12'b000000000010: n1140 = n1139;
      12'b000000000001: n1140 = n1139;
      default: n1140 = n1139;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1141 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1142 = n1141;
      12'b010000000000: n1142 = n1141;
      12'b001000000000: n1142 = n1141;
      12'b000100000000: n1142 = n1047;
      12'b000010000000: n1142 = n1141;
      12'b000001000000: n1142 = n1141;
      12'b000000100000: n1142 = n1141;
      12'b000000010000: n1142 = n1141;
      12'b000000001000: n1142 = n1141;
      12'b000000000100: n1142 = n1141;
      12'b000000000010: n1142 = n1141;
      12'b000000000001: n1142 = n1141;
      default: n1142 = n1141;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1143 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1144 = n1143;
      12'b010000000000: n1144 = n1143;
      12'b001000000000: n1144 = n1075;
      12'b000100000000: n1144 = n1143;
      12'b000010000000: n1144 = n1143;
      12'b000001000000: n1144 = n1143;
      12'b000000100000: n1144 = n1143;
      12'b000000010000: n1144 = n1143;
      12'b000000001000: n1144 = n1143;
      12'b000000000100: n1144 = n1143;
      12'b000000000010: n1144 = n1143;
      12'b000000000001: n1144 = n1143;
      default: n1144 = n1143;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1145 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1146 = n1145;
      12'b010000000000: n1146 = n1103;
      12'b001000000000: n1146 = n1145;
      12'b000100000000: n1146 = n1145;
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
  assign n1147 = m_x[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1148 = n1147;
      12'b010000000000: n1148 = n1147;
      12'b001000000000: n1148 = n1147;
      12'b000100000000: n1148 = n1147;
      12'b000010000000: n1148 = n1147;
      12'b000001000000: n1148 = n1147;
      12'b000000100000: n1148 = n1147;
      12'b000000010000: n1148 = n1147;
      12'b000000001000: n1148 = n894;
      12'b000000000100: n1148 = n1147;
      12'b000000000010: n1148 = n1147;
      12'b000000000001: n1148 = n1147;
      default: n1148 = n1147;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1149 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1150 = n1149;
      12'b010000000000: n1150 = n1149;
      12'b001000000000: n1150 = n1149;
      12'b000100000000: n1150 = n1149;
      12'b000010000000: n1150 = n1149;
      12'b000001000000: n1150 = n1149;
      12'b000000100000: n1150 = n1149;
      12'b000000010000: n1150 = n922;
      12'b000000001000: n1150 = n1149;
      12'b000000000100: n1150 = n1149;
      12'b000000000010: n1150 = n1149;
      12'b000000000001: n1150 = n1149;
      default: n1150 = n1149;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1151 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1152 = n1151;
      12'b010000000000: n1152 = n1151;
      12'b001000000000: n1152 = n1151;
      12'b000100000000: n1152 = n1151;
      12'b000010000000: n1152 = n1151;
      12'b000001000000: n1152 = n1151;
      12'b000000100000: n1152 = n950;
      12'b000000010000: n1152 = n1151;
      12'b000000001000: n1152 = n1151;
      12'b000000000100: n1152 = n1151;
      12'b000000000010: n1152 = n1151;
      12'b000000000001: n1152 = n1151;
      default: n1152 = n1151;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1153 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1154 = n1153;
      12'b010000000000: n1154 = n1153;
      12'b001000000000: n1154 = n1153;
      12'b000100000000: n1154 = n1153;
      12'b000010000000: n1154 = n1153;
      12'b000001000000: n1154 = n978;
      12'b000000100000: n1154 = n1153;
      12'b000000010000: n1154 = n1153;
      12'b000000001000: n1154 = n1153;
      12'b000000000100: n1154 = n1153;
      12'b000000000010: n1154 = n1153;
      12'b000000000001: n1154 = n1153;
      default: n1154 = n1153;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1155 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1156 = n1155;
      12'b010000000000: n1156 = n1155;
      12'b001000000000: n1156 = n1155;
      12'b000100000000: n1156 = n1155;
      12'b000010000000: n1156 = n1006;
      12'b000001000000: n1156 = n1155;
      12'b000000100000: n1156 = n1155;
      12'b000000010000: n1156 = n1155;
      12'b000000001000: n1156 = n1155;
      12'b000000000100: n1156 = n1155;
      12'b000000000010: n1156 = n1155;
      12'b000000000001: n1156 = n1155;
      default: n1156 = n1155;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1157 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1158 = n1157;
      12'b010000000000: n1158 = n1157;
      12'b001000000000: n1158 = n1157;
      12'b000100000000: n1158 = n1034;
      12'b000010000000: n1158 = n1157;
      12'b000001000000: n1158 = n1157;
      12'b000000100000: n1158 = n1157;
      12'b000000010000: n1158 = n1157;
      12'b000000001000: n1158 = n1157;
      12'b000000000100: n1158 = n1157;
      12'b000000000010: n1158 = n1157;
      12'b000000000001: n1158 = n1157;
      default: n1158 = n1157;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1159 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1160 = n1159;
      12'b010000000000: n1160 = n1159;
      12'b001000000000: n1160 = n1062;
      12'b000100000000: n1160 = n1159;
      12'b000010000000: n1160 = n1159;
      12'b000001000000: n1160 = n1159;
      12'b000000100000: n1160 = n1159;
      12'b000000010000: n1160 = n1159;
      12'b000000001000: n1160 = n1159;
      12'b000000000100: n1160 = n1159;
      12'b000000000010: n1160 = n1159;
      12'b000000000001: n1160 = n1159;
      default: n1160 = n1159;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1161 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1162 = n1161;
      12'b010000000000: n1162 = n1090;
      12'b001000000000: n1162 = n1161;
      12'b000100000000: n1162 = n1161;
      12'b000010000000: n1162 = n1161;
      12'b000001000000: n1162 = n1161;
      12'b000000100000: n1162 = n1161;
      12'b000000010000: n1162 = n1161;
      12'b000000001000: n1162 = n1161;
      12'b000000000100: n1162 = n1161;
      12'b000000000010: n1162 = n1161;
      12'b000000000001: n1162 = n1161;
      default: n1162 = n1161;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1163 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1164 = n1118;
      12'b010000000000: n1164 = n1163;
      12'b001000000000: n1164 = n1163;
      12'b000100000000: n1164 = n1163;
      12'b000010000000: n1164 = n1163;
      12'b000001000000: n1164 = n1163;
      12'b000000100000: n1164 = n1163;
      12'b000000010000: n1164 = n1163;
      12'b000000001000: n1164 = n1163;
      12'b000000000100: n1164 = n1163;
      12'b000000000010: n1164 = n1163;
      12'b000000000001: n1164 = n1163;
      default: n1164 = n1163;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1165 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1166 = n1119;
      12'b010000000000: n1166 = n1165;
      12'b001000000000: n1166 = n1165;
      12'b000100000000: n1166 = n1165;
      12'b000010000000: n1166 = n1165;
      12'b000001000000: n1166 = n1165;
      12'b000000100000: n1166 = n1165;
      12'b000000010000: n1166 = n1165;
      12'b000000001000: n1166 = n1165;
      12'b000000000100: n1166 = n1165;
      12'b000000000010: n1166 = n1165;
      12'b000000000001: n1166 = n1165;
      default: n1166 = n1165;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1167 = m_previous_energy;
      12'b010000000000: n1167 = m_previous_energy;
      12'b001000000000: n1167 = m_previous_energy;
      12'b000100000000: n1167 = m_previous_energy;
      12'b000010000000: n1167 = m_previous_energy;
      12'b000001000000: n1167 = m_previous_energy;
      12'b000000100000: n1167 = m_previous_energy;
      12'b000000010000: n1167 = m_previous_energy;
      12'b000000001000: n1167 = m_previous_energy;
      12'b000000000100: n1167 = m_previous_energy;
      12'b000000000010: n1167 = m_current_energy;
      12'b000000000001: n1167 = m_previous_energy;
      default: n1167 = m_previous_energy;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:33 */
  always @*
    case (n1124)
      12'b100000000000: n1168 = n1121;
      12'b010000000000: n1168 = this_sample;
      12'b001000000000: n1168 = this_sample;
      12'b000100000000: n1168 = this_sample;
      12'b000010000000: n1168 = this_sample;
      12'b000001000000: n1168 = this_sample;
      12'b000000100000: n1168 = this_sample;
      12'b000000010000: n1168 = this_sample;
      12'b000000001000: n1168 = this_sample;
      12'b000000000100: n1168 = this_sample;
      12'b000000000010: n1168 = this_sample;
      12'b000000000001: n1168 = this_sample;
      default: n1168 = this_sample;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:25 */
  assign n1169 = {n1146, n1144, n1142, n1140, n1138, n1136, n1134, n1132, n1130, n1128, n1126};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:25 */
  assign n1170 = n841 ? n1169 : m_u;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:25 */
  assign n1171 = {n1166, n1164, n1162, n1160, n1158, n1156, n1154, n1152, n1150, n1148};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:25 */
  assign n1172 = n841 ? n1171 : m_x;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:25 */
  assign n1173 = n841 ? n1167 : m_previous_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:25 */
  assign n1174 = n841 ? n1168 : this_sample;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:25 */
  assign n1176 = m_rst ? 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1170;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:25 */
  assign n1178 = m_rst ? 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1172;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:25 */
  assign n1180 = m_rst ? 14'b00000000000000 : n1173;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:25 */
  assign n1181 = m_rst ? this_sample : n1174;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:692:59 */
  assign n1193 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:692:48 */
  assign n1194 = n1193 & m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:692:66 */
  assign n1195 = m_rsn & n1194;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:692:97 */
  assign n1196 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:692:85 */
  assign n1197 = n1196 & n1195;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:693:51 */
  assign n1198 = m_dbi[6:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:695:60 */
  assign n1200 = ~m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:695:45 */
  assign n1201 = n1200 & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:698:41 */
  assign n1203 = m_cmd_reg == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:699:41 */
  assign n1205 = m_cmd_reg == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:701:41 */
  assign n1207 = m_cmd_reg == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:702:41 */
  assign n1209 = m_cmd_reg == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:703:41 */
  assign n1211 = m_cmd_reg == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:704:41 */
  assign n1213 = m_cmd_reg == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:705:41 */
  assign n1215 = m_cmd_reg == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:707:41 */
  assign n1217 = m_cmd_reg == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:697:33 */
  assign n1218 = {n1217, n1215, n1213, n1211, n1209, n1207, n1205, n1203};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:697:33 */
  always @*
    case (n1218)
      8'b10000000: n1221 = 1'b0;
      8'b01000000: n1221 = 1'b0;
      8'b00100000: n1221 = 1'b0;
      8'b00010000: n1221 = 1'b0;
      8'b00001000: n1221 = 1'b0;
      8'b00000100: n1221 = 1'b0;
      8'b00000010: n1221 = 1'b1;
      8'b00000001: n1221 = 1'b0;
      default: n1221 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:697:33 */
  always @*
    case (n1218)
      8'b10000000: n1224 = 1'b1;
      8'b01000000: n1224 = 1'b0;
      8'b00100000: n1224 = 1'b0;
      8'b00010000: n1224 = 1'b0;
      8'b00001000: n1224 = 1'b0;
      8'b00000100: n1224 = 1'b0;
      8'b00000010: n1224 = 1'b0;
      8'b00000001: n1224 = 1'b0;
      default: n1224 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:697:33 */
  always @*
    case (n1218)
      8'b10000000: n1227 = 1'b0;
      8'b01000000: n1227 = 1'b1;
      8'b00100000: n1227 = 1'b0;
      8'b00010000: n1227 = 1'b0;
      8'b00001000: n1227 = 1'b0;
      8'b00000100: n1227 = 1'b0;
      8'b00000010: n1227 = 1'b0;
      8'b00000001: n1227 = 1'b0;
      default: n1227 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:695:25 */
  assign n1229 = n1201 ? n1221 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:695:25 */
  assign n1232 = n1201 ? n1224 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:695:25 */
  assign n1235 = n1201 ? n1227 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:688:17 */
  assign n1237 = n1197 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:75 */
  assign n1248 = ~m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:64 */
  assign n1249 = n1248 & m_talkd_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:42 */
  assign n1250 = m_rst | n1249;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:723:25 */
  assign n1252 = m_sxt_cmd ? 1'b1 : m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:721:25 */
  assign n1254 = n1250 ? 1'b0 : n1252;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:56 */
  assign n1262 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:56 */
  assign n1264 = n1262 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:46 */
  assign n1265 = n1264 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:71 */
  assign n1266 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:71 */
  assign n1268 = n1266 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:61 */
  assign n1269 = n1268 & n1265;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:86 */
  assign n1270 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:86 */
  assign n1272 = n1270 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:77 */
  assign n1273 = n1272 & n1269;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:102 */
  assign n1274 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:106 */
  assign n1275 = ~n1274;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:92 */
  assign n1276 = n1275 & n1273;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:113 */
  assign n1277 = m_talkd & n1276;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:738:50 */
  assign n1278 = ~m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:738:88 */
  assign n1279 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:738:88 */
  assign n1281 = n1279 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:738:57 */
  assign n1282 = n1281 & n1278;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:87 */
  assign n1283 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:87 */
  assign n1285 = n1283 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:57 */
  assign n1286 = n1285 & m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:738:94 */
  assign n1287 = n1282 | n1286;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:740:87 */
  assign n1288 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:740:87 */
  assign n1290 = n1288 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:740:57 */
  assign n1291 = n1290 & m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:739:94 */
  assign n1292 = n1287 | n1291;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:88 */
  assign n1293 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:88 */
  assign n1295 = n1293 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:741:57 */
  assign n1296 = n1295 & m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:740:94 */
  assign n1297 = n1292 | n1296;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:737:33 */
  assign n1300 = n1297 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:736:25 */
  assign n1301 = n1277 ? n1300 : m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:25 */
  assign n1303 = m_rst ? 1'b1 : n1301;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:756:54 */
  assign n1309 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:756:76 */
  assign n1311 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:756:61 */
  assign n1312 = n1311 & n1309;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:756:42 */
  assign n1313 = m_rst | n1312;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:51 */
  assign n1314 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:85 */
  assign n1315 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:73 */
  assign n1316 = n1315 & n1314;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:108 */
  assign n1317 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:108 */
  assign n1319 = $signed(n1317) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:92 */
  assign n1320 = n1319 & n1316;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:130 */
  assign n1321 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:130 */
  assign n1323 = $signed(n1321) < $signed(32'b00000000000000000000000001001001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:114 */
  assign n1324 = n1323 & n1320;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:756:85 */
  assign n1325 = n1313 | n1324;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:756:25 */
  assign n1327 = n1325 ? 1'b1 : m_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:756:25 */
  assign n1329 = n1325 ? 1'b1 : m_uv_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:53 */
  assign n1330 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:53 */
  assign n1332 = n1330 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:43 */
  assign n1333 = n1332 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:68 */
  assign n1334 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:68 */
  assign n1336 = n1334 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:58 */
  assign n1337 = n1336 & n1333;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:83 */
  assign n1338 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:83 */
  assign n1340 = n1338 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:74 */
  assign n1341 = n1340 & n1337;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:99 */
  assign n1342 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:103 */
  assign n1343 = ~n1342;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:89 */
  assign n1344 = n1343 & n1341;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:110 */
  assign n1345 = m_talkd & n1344;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:61 */
  assign n1346 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:61 */
  assign n1348 = n1346 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:96 */
  assign n1349 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:96 */
  assign n1351 = n1349 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:66 */
  assign n1352 = n1351 & n1348;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:132 */
  assign n1353 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:132 */
  assign n1355 = n1353 != 32'b00000000000000000000000000001111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:102 */
  assign n1356 = n1355 & n1352;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:764:33 */
  assign n1359 = n1356 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:25 */
  assign n1361 = n1345 ? 1'b0 : n1327;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:762:25 */
  assign n1362 = n1345 ? n1359 : n1329;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:54 */
  assign n1370 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:76 */
  assign n1372 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:61 */
  assign n1373 = n1372 & n1370;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:42 */
  assign n1374 = m_rst | n1373;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:787:51 */
  assign n1375 = m_wsn_last & m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:787:85 */
  assign n1376 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:787:74 */
  assign n1377 = n1376 & n1375;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:787:92 */
  assign n1378 = m_rsn & n1377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:58 */
  assign n1379 = m_dbi[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:67 */
  assign n1380 = m_dbi[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:61 */
  assign n1381 = {n1379, n1380};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:76 */
  assign n1382 = m_dbi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:70 */
  assign n1383 = {n1381, n1382};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:85 */
  assign n1384 = m_dbi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:79 */
  assign n1385 = {n1383, n1384};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:94 */
  assign n1386 = m_dbi[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:88 */
  assign n1387 = {n1385, n1386};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:103 */
  assign n1388 = m_dbi[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:97 */
  assign n1389 = {n1387, n1388};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:112 */
  assign n1390 = m_dbi[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:106 */
  assign n1391 = {n1389, n1390};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:121 */
  assign n1392 = m_dbi[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:788:115 */
  assign n1393 = {n1391, n1392};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:787:33 */
  assign n1394 = n1378 ? n1393 : m_wr_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:790:53 */
  assign n1395 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:790:33 */
  assign n1397 = n1395 ? 1'b1 : m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:25 */
  assign n1399 = n1374 ? 8'b10000000 : m_fifo_ptr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:25 */
  assign n1400 = n1374 ? m_wr_pending : n1397;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:25 */
  assign n1401 = n1374 ? m_wr_reg : n1394;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:25 */
  assign n1403 = n1374 ? 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : m_fifo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:54 */
  assign n1404 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:76 */
  assign n1406 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:61 */
  assign n1407 = n1406 & n1404;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:42 */
  assign n1408 = m_rst | n1407;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:51 */
  assign n1409 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:85 */
  assign n1410 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:73 */
  assign n1411 = n1410 & n1409;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:108 */
  assign n1412 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:108 */
  assign n1414 = $signed(n1412) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:92 */
  assign n1415 = n1414 & n1411;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:130 */
  assign n1416 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:130 */
  assign n1418 = $signed(n1416) < $signed(32'b00000000000000000000000001001001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:114 */
  assign n1419 = n1418 & n1415;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:85 */
  assign n1420 = n1408 | n1419;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:56 */
  assign n1421 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:56 */
  assign n1423 = n1421 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:46 */
  assign n1424 = n1423 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:70 */
  assign n1425 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:70 */
  assign n1427 = n1425 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:61 */
  assign n1428 = n1427 & n1424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:86 */
  assign n1429 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:90 */
  assign n1430 = ~n1429;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:76 */
  assign n1431 = n1430 & n1428;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:97 */
  assign n1432 = m_talkd & n1431;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:64 */
  assign n1433 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:64 */
  assign n1435 = $signed(n1433) <= $signed(32'b00000000000000000000000001111100);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:809:82 */
  assign n1436 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:809:82 */
  assign n1438 = n1436 + 32'b00000000000000000000000000000100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:809:71 */
  assign n1439 = n1438[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:810:73 */
  assign n1440 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:810:107 */
  assign n1442 = {n1440, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:111 */
  assign n1443 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:70 */
  assign n1445 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:112 */
  assign n1447 = n1445 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:815:70 */
  assign n1448 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:815:112 */
  assign n1450 = n1448 == 4'b1111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:815:57 */
  assign n1452 = n1450 ? m_new_frame_voiced : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:815:57 */
  assign n1454 = n1450 ? m_new_frame_zero : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:815:57 */
  assign n1457 = n1450 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:57 */
  assign n1458 = n1447 ? m_new_frame_voiced : n1452;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:57 */
  assign n1460 = n1447 ? 1'b1 : n1454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:57 */
  assign n1461 = n1447 ? m_new_frame_stop : n1457;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:49 */
  assign n1462 = n1435 ? n1439 : n1399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:49 */
  assign n1463 = n1435 ? n1443 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:49 */
  assign n1466 = n1435 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:49 */
  assign n1467 = n1435 ? n1458 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:49 */
  assign n1468 = n1435 ? n1460 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:49 */
  assign n1469 = n1435 ? n1461 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:808:49 */
  assign n1470 = n1435 ? n1442 : n1403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:807:41 */
  assign n1472 = m_pc == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:71 */
  assign n1473 = ~m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:100 */
  assign n1474 = ~m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:78 */
  assign n1475 = n1474 & n1473;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:72 */
  assign n1476 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:72 */
  assign n1478 = $signed(n1476) <= $signed(32'b00000000000000000000000001111001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:90 */
  assign n1479 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:90 */
  assign n1481 = n1479 + 32'b00000000000000000000000000000110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:99 */
  assign n1483 = n1481 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:828:79 */
  assign n1484 = n1483[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:81 */
  assign n1485 = m_fifo[120:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:829:124 */
  assign n1487 = {n1485, 7'b0000000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:830:93 */
  assign n1488 = m_fifo[127]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:831:118 */
  assign n1489 = m_fifo[126:121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:831:92 */
  assign n1491 = {1'b0, n1489};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:75 */
  assign n1492 = m_fifo[126:121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:832:135 */
  assign n1494 = n1492 == 6'b000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1496 = n1512 ? 1'b0 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1498 = n1513 ? 1'b1 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1499 = n1508 ? n1484 : n1399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1500 = n1509 ? n1491 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:57 */
  assign n1503 = n1478 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:57 */
  assign n1504 = n1494 & n1478;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:827:57 */
  assign n1505 = n1494 & n1478;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1506 = n1514 ? n1488 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1507 = n1515 ? n1487 : n1403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1508 = n1478 & n1475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1509 = n1478 & n1475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1511 = n1475 ? n1503 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1512 = n1504 & n1475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1513 = n1505 & n1475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1514 = n1478 & n1475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:49 */
  assign n1515 = n1478 & n1475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:825:41 */
  assign n1517 = m_pc == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:73 */
  assign n1518 = ~m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:112 */
  assign n1519 = m_new_frame_voiced | m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:80 */
  assign n1520 = n1519 & n1518;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:72 */
  assign n1521 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:98 */
  assign n1522 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:98 */
  assign n1524 = n1522 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:98 */
  assign n1525 = n1524[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:85 */
  assign n1531 = {29'b0, n2015};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:85 */
  assign n1533 = 32'b00000000000000000000000010000000 - n1531;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:72 */
  assign n1534 = $signed(n1521) <= $signed(n1533);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:90 */
  assign n1535 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:103 */
  assign n1536 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:103 */
  assign n1538 = n1536 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:103 */
  assign n1539 = n1538[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:90 */
  assign n1544 = {29'b0, n2014};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:90 */
  assign n1545 = n1535 + n1544;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:79 */
  assign n1546 = n1545[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:81 */
  assign n1547 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:81 */
  assign n1549 = n1547 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:81 */
  assign n1550 = n1549[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:97 */
  assign n1555 = m_fifo[122:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:849:122 */
  assign n1557 = {n1555, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:105 */
  assign n1558 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:105 */
  assign n1560 = n1558 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:105 */
  assign n1561 = n1560[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:105 */
  assign n1563 = 4'b1001 - n1561;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:138 */
  assign n1565 = m_fifo[127:123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:73 */
  assign n1569 = n2013 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:852:97 */
  assign n1570 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:852:122 */
  assign n1572 = {n1570, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:105 */
  assign n1573 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:105 */
  assign n1575 = n1573 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:105 */
  assign n1576 = n1575[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:105 */
  assign n1578 = 4'b1001 - n1576;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:138 */
  assign n1580 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:112 */
  assign n1582 = {1'b0, n1580};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:851:73 */
  assign n1585 = n2013 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:855:97 */
  assign n1586 = m_fifo[124:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:855:122 */
  assign n1588 = {n1586, 3'b000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:105 */
  assign n1589 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:105 */
  assign n1591 = n1589 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:105 */
  assign n1592 = n1591[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:105 */
  assign n1594 = 4'b1001 - n1592;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:138 */
  assign n1596 = m_fifo[127:125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:112 */
  assign n1598 = {2'b0, n1596};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:65 */
  assign n1600 = {n1585, n1569};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:65 */
  always @*
    case (n1600)
      2'b10: n1601 = n2268;
      2'b01: n1601 = n2221;
      default: n1601 = n2315;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:65 */
  always @*
    case (n1600)
      2'b10: n1602 = n1572;
      2'b01: n1602 = n1557;
      default: n1602 = n1588;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:49 */
  assign n1603 = n1609 ? n1546 : n1399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:49 */
  assign n1604 = n1610 ? n1601 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:57 */
  assign n1607 = n1534 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:49 */
  assign n1608 = n1613 ? n1602 : n1403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:49 */
  assign n1609 = n1534 & n1520;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:49 */
  assign n1610 = n1534 & n1520;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:49 */
  assign n1612 = n1520 ? n1607 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:49 */
  assign n1613 = n1534 & n1520;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:41 */
  assign n1616 = $unsigned(m_pc) >= $unsigned(4'b0010);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:41 */
  assign n1617 = $unsigned(m_pc) <= $unsigned(4'b0101);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:41 */
  assign n1618 = n1616 & n1617;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:73 */
  assign n1619 = ~m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:80 */
  assign n1620 = m_new_frame_voiced & n1619;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:72 */
  assign n1621 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:98 */
  assign n1622 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:98 */
  assign n1624 = n1622 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:98 */
  assign n1625 = n1624[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:85 */
  assign n1630 = {29'b0, n2012};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:85 */
  assign n1632 = 32'b00000000000000000000000010000000 - n1630;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:72 */
  assign n1633 = $signed(n1621) <= $signed(n1632);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:90 */
  assign n1634 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:103 */
  assign n1635 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:103 */
  assign n1637 = n1635 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:103 */
  assign n1638 = n1637[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:90 */
  assign n1643 = {29'b0, n2011};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:90 */
  assign n1644 = n1634 + n1643;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:79 */
  assign n1645 = n1644[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:81 */
  assign n1646 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:81 */
  assign n1648 = n1646 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:81 */
  assign n1649 = n1648[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:871:97 */
  assign n1654 = m_fifo[122:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:871:122 */
  assign n1656 = {n1654, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:105 */
  assign n1657 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:105 */
  assign n1659 = n1657 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:105 */
  assign n1660 = n1659[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:105 */
  assign n1662 = 4'b1001 - n1660;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:138 */
  assign n1664 = m_fifo[127:123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:870:73 */
  assign n1668 = n2010 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:874:97 */
  assign n1669 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:874:122 */
  assign n1671 = {n1669, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:105 */
  assign n1672 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:105 */
  assign n1674 = n1672 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:105 */
  assign n1675 = n1674[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:105 */
  assign n1677 = 4'b1001 - n1675;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:138 */
  assign n1679 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:112 */
  assign n1681 = {1'b0, n1679};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:873:73 */
  assign n1684 = n2010 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:97 */
  assign n1685 = m_fifo[124:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:122 */
  assign n1687 = {n1685, 3'b000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:105 */
  assign n1688 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:105 */
  assign n1690 = n1688 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:105 */
  assign n1691 = n1690[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:105 */
  assign n1693 = 4'b1001 - n1691;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:138 */
  assign n1695 = m_fifo[127:125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:112 */
  assign n1697 = {2'b0, n1695};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:65 */
  assign n1699 = {n1684, n1668};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:65 */
  always @*
    case (n1699)
      2'b10: n1700 = n2409;
      2'b01: n1700 = n2362;
      default: n1700 = n2456;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:65 */
  always @*
    case (n1699)
      2'b10: n1701 = n1671;
      2'b01: n1701 = n1656;
      default: n1701 = n1687;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:49 */
  assign n1702 = n1708 ? n1645 : n1399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:49 */
  assign n1703 = n1709 ? n1700 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:57 */
  assign n1706 = n1633 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:49 */
  assign n1707 = n1712 ? n1701 : n1403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:49 */
  assign n1708 = n1633 & n1620;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:49 */
  assign n1709 = n1633 & n1620;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:49 */
  assign n1711 = n1620 ? n1706 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:49 */
  assign n1712 = n1633 & n1620;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:41 */
  assign n1715 = $unsigned(m_pc) >= $unsigned(4'b0110);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:41 */
  assign n1716 = $unsigned(m_pc) <= $unsigned(4'b1011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:41 */
  assign n1717 = n1715 & n1716;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:892:94 */
  assign n1718 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:893:94 */
  assign n1719 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:894:94 */
  assign n1720 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:895:94 */
  assign n1721 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:896:94 */
  assign n1722 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:897:94 */
  assign n1723 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:898:94 */
  assign n1724 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:899:94 */
  assign n1725 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:900:94 */
  assign n1726 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:901:94 */
  assign n1727 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:885:41 */
  assign n1729 = m_pc == 4'b1100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  assign n1730 = {n1729, n1717, n1618, n1517, n1472};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1731 = n1399;
      5'b01000: n1731 = n1702;
      5'b00100: n1731 = n1603;
      5'b00010: n1731 = n1499;
      5'b00001: n1731 = n1462;
      default: n1731 = n1399;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1732 = tmp_new_frame_energy_idx;
      5'b01000: n1732 = m_new_frame_energy_idx;
      5'b00100: n1732 = m_new_frame_energy_idx;
      5'b00010: n1732 = m_new_frame_energy_idx;
      5'b00001: n1732 = m_new_frame_energy_idx;
      default: n1732 = m_new_frame_energy_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1733 = tmp_new_frame_pitch_idx;
      5'b01000: n1733 = m_new_frame_pitch_idx;
      5'b00100: n1733 = m_new_frame_pitch_idx;
      5'b00010: n1733 = m_new_frame_pitch_idx;
      5'b00001: n1733 = m_new_frame_pitch_idx;
      default: n1733 = m_new_frame_pitch_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1734 = m_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1735 = n1727;
      5'b01000: n1735 = n1734;
      5'b00100: n1735 = n1734;
      5'b00010: n1735 = n1734;
      5'b00001: n1735 = n1734;
      default: n1735 = n1734;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1736 = m_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1737 = n1726;
      5'b01000: n1737 = n1736;
      5'b00100: n1737 = n1736;
      5'b00010: n1737 = n1736;
      5'b00001: n1737 = n1736;
      default: n1737 = n1736;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1738 = m_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1739 = n1725;
      5'b01000: n1739 = n1738;
      5'b00100: n1739 = n1738;
      5'b00010: n1739 = n1738;
      5'b00001: n1739 = n1738;
      default: n1739 = n1738;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1740 = m_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1741 = n1724;
      5'b01000: n1741 = n1740;
      5'b00100: n1741 = n1740;
      5'b00010: n1741 = n1740;
      5'b00001: n1741 = n1740;
      default: n1741 = n1740;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1742 = m_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1743 = n1723;
      5'b01000: n1743 = n1742;
      5'b00100: n1743 = n1742;
      5'b00010: n1743 = n1742;
      5'b00001: n1743 = n1742;
      default: n1743 = n1742;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1744 = m_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1745 = n1722;
      5'b01000: n1745 = n1744;
      5'b00100: n1745 = n1744;
      5'b00010: n1745 = n1744;
      5'b00001: n1745 = n1744;
      default: n1745 = n1744;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1746 = m_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1747 = n1721;
      5'b01000: n1747 = n1746;
      5'b00100: n1747 = n1746;
      5'b00010: n1747 = n1746;
      5'b00001: n1747 = n1746;
      default: n1747 = n1746;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1748 = m_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1749 = n1720;
      5'b01000: n1749 = n1748;
      5'b00100: n1749 = n1748;
      5'b00010: n1749 = n1748;
      5'b00001: n1749 = n1748;
      default: n1749 = n1748;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1750 = m_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1751 = n1719;
      5'b01000: n1751 = n1750;
      5'b00100: n1751 = n1750;
      5'b00010: n1751 = n1750;
      5'b00001: n1751 = n1750;
      default: n1751 = n1750;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1752 = m_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1753 = n1718;
      5'b01000: n1753 = n1752;
      5'b00100: n1753 = n1752;
      5'b00010: n1753 = n1752;
      5'b00001: n1753 = n1752;
      default: n1753 = n1752;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1754 = tmp_new_frame_energy_idx;
      5'b01000: n1754 = tmp_new_frame_energy_idx;
      5'b00100: n1754 = tmp_new_frame_energy_idx;
      5'b00010: n1754 = tmp_new_frame_energy_idx;
      5'b00001: n1754 = n1463;
      default: n1754 = tmp_new_frame_energy_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1755 = tmp_new_frame_pitch_idx;
      5'b01000: n1755 = tmp_new_frame_pitch_idx;
      5'b00100: n1755 = tmp_new_frame_pitch_idx;
      5'b00010: n1755 = n1500;
      5'b00001: n1755 = tmp_new_frame_pitch_idx;
      default: n1755 = tmp_new_frame_pitch_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1756 = tmp_new_frame_k_idx;
      5'b01000: n1756 = n1703;
      5'b00100: n1756 = n1604;
      5'b00010: n1756 = tmp_new_frame_k_idx;
      5'b00001: n1756 = tmp_new_frame_k_idx;
      default: n1756 = tmp_new_frame_k_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1758 = 1'b0;
      5'b01000: n1758 = n1711;
      5'b00100: n1758 = n1612;
      5'b00010: n1758 = n1511;
      5'b00001: n1758 = n1466;
      default: n1758 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1760 = 1'b0;
      5'b01000: n1760 = m_new_frame_voiced;
      5'b00100: n1760 = m_new_frame_voiced;
      5'b00010: n1760 = n1496;
      5'b00001: n1760 = n1467;
      default: n1760 = m_new_frame_voiced;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1762 = 1'b0;
      5'b01000: n1762 = m_new_frame_unvoiced;
      5'b00100: n1762 = m_new_frame_unvoiced;
      5'b00010: n1762 = n1498;
      5'b00001: n1762 = m_new_frame_unvoiced;
      default: n1762 = m_new_frame_unvoiced;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1763 = m_new_frame_repeat;
      5'b01000: n1763 = m_new_frame_repeat;
      5'b00100: n1763 = m_new_frame_repeat;
      5'b00010: n1763 = n1506;
      5'b00001: n1763 = m_new_frame_repeat;
      default: n1763 = m_new_frame_repeat;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1765 = 1'b0;
      5'b01000: n1765 = m_new_frame_zero;
      5'b00100: n1765 = m_new_frame_zero;
      5'b00010: n1765 = m_new_frame_zero;
      5'b00001: n1765 = n1468;
      default: n1765 = m_new_frame_zero;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1767 = 1'b0;
      5'b01000: n1767 = m_new_frame_stop;
      5'b00100: n1767 = m_new_frame_stop;
      5'b00010: n1767 = m_new_frame_stop;
      5'b00001: n1767 = n1469;
      default: n1767 = m_new_frame_stop;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:806:33 */
  always @*
    case (n1730)
      5'b10000: n1768 = n1403;
      5'b01000: n1768 = n1707;
      5'b00100: n1768 = n1608;
      5'b00010: n1768 = n1507;
      5'b00001: n1768 = n1470;
      default: n1768 = n1403;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:39 */
  assign n1775 = m_fifo_ptr[6:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:39 */
  assign n1777 = n1775 + 7'b1111000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:908:58 */
  assign n1780 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:908:58 */
  assign n1782 = n1780 - 32'b00000000000000000000000000001000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:908:47 */
  assign n1783 = n1782[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:905:25 */
  assign n1784 = m_wr_pending ? n1783 : n1399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:905:25 */
  assign n1786 = m_wr_pending ? 1'b0 : n1400;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:905:25 */
  assign n1787 = m_wr_pending ? n3314 : n1403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1788 = n1432 ? n1731 : n1784;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1789 = n1432 ? n1732 : m_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1790 = n1432 ? n1733 : m_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1791 = {n1753, n1751, n1749, n1747, n1745, n1743, n1741, n1739, n1737, n1735};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1792 = n1432 ? n1791 : m_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1793 = n1432 ? n1754 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1794 = n1432 ? n1755 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1795 = n1432 ? n1756 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1797 = n1432 ? n1758 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1798 = n1432 ? n1400 : n1786;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1799 = n1432 ? n1760 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1800 = n1432 ? n1762 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1801 = n1432 ? n1763 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1802 = n1432 ? n1765 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1803 = n1432 ? n1767 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:804:25 */
  assign n1804 = n1432 ? n1768 : n1787;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1805 = n1420 ? n1399 : n1788;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1807 = n1420 ? 4'b0000 : n1789;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1809 = n1420 ? 7'b0000000 : n1790;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1811 = n1420 ? 50'b00000000000000000000011110111101111001110011100111 : n1792;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1812 = n1420 ? tmp_new_frame_energy_idx : n1793;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1813 = n1420 ? tmp_new_frame_pitch_idx : n1794;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1815 = n1420 ? 50'b00000000000000000000011110111101111001110011100111 : n1795;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1817 = n1420 ? 1'b0 : n1797;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1819 = n1420 ? n1400 : n1798;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1820 = n1420 ? m_new_frame_voiced : n1799;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1821 = n1420 ? m_new_frame_unvoiced : n1800;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1822 = n1420 ? m_new_frame_repeat : n1801;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1823 = n1420 ? m_new_frame_zero : n1802;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1824 = n1420 ? m_new_frame_stop : n1803;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:25 */
  assign n1825 = n1420 ? n1403 : n1804;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:216:17 */
  assign n1861 = {n204, n200, n197, n195};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  assign n1862 = m_ena ? n171 : m_ic;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  always @(posedge m_clk)
    n1863 <= n1862;
  initial
    n1863 = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  assign n1864 = m_ena ? n173 : m_pc;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  always @(posedge m_clk)
    n1865 <= n1864;
  initial
    n1865 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  assign n1866 = m_ena ? n175 : m_t;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  always @(posedge m_clk)
    n1867 <= n1866;
  initial
    n1867 = 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1868 = m_ena ? n1805 : m_fifo_ptr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1869 <= n1868;
  initial
    n1869 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:441:17 */
  assign n1870 = n401 ? n397 : m_pitch_count;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:441:17 */
  always @(posedge m_clk)
    n1871 <= n1870;
  initial
    n1871 = 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1872 = m_ena ? n1807 : m_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1873 <= n1872;
  initial
    n1873 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1874 = m_ena ? n1809 : m_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1875 <= n1874;
  initial
    n1875 = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1876 = m_ena ? n1811 : m_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1877 <= n1876;
  initial
    n1877 = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1878 = m_ena ? n1812 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1879 <= n1878;
  initial
    n1879 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1880 = m_ena ? n1813 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1881 <= n1880;
  initial
    n1881 = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1882 = m_ena ? n1815 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1883 <= n1882;
  initial
    n1883 = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  assign n1884 = m_ena ? n1176 : m_u;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  always @(posedge m_clk)
    n1885 <= n1884;
  initial
    n1885 = 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  assign n1886 = m_ena ? n1178 : m_x;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  always @(posedge m_clk)
    n1887 <= n1886;
  initial
    n1887 = 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  assign n1888 = m_ena ? n272 : m_wr_busy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  always @(posedge m_clk)
    n1889 <= n1888;
  initial
    n1889 = 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  assign n1890 = m_ena ? n274 : m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  always @(posedge m_clk)
    n1891 <= n1890;
  initial
    n1891 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  assign n1892 = m_ena ? n276 : m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  always @(posedge m_clk)
    n1893 <= n1892;
  initial
    n1893 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  assign n1894 = n1237 ? n1198 : m_cmd_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  always @(posedge m_clk)
    n1895 <= n1894;
  initial
    n1895 = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  assign n1896 = m_ena ? n177 : m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  always @(posedge m_clk)
    n1897 <= n1896;
  initial
    n1897 = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:718:17 */
  assign n1898 = m_ena ? n1254 : m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:718:17 */
  always @(posedge m_clk)
    n1899 <= n1898;
  initial
    n1899 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:526:17 */
  assign n1900 = m_ena ? n540 : m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:526:17 */
  always @(posedge m_clk)
    n1901 <= n1900;
  initial
    n1901 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:526:17 */
  assign n1902 = m_ena ? n542 : m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:526:17 */
  always @(posedge m_clk)
    n1903 <= n1902;
  initial
    n1903 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  assign n1904 = n429 ? n418 : m_rdb_clr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  always @(posedge m_clk)
    n1905 <= n1904;
  initial
    n1905 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  assign n1906 = m_ena ? n1229 : m_rdb_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  always @(posedge m_clk)
    n1907 <= n1906;
  initial
    n1907 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:391:17 */
  assign n1908 = m_ena ? n294 : m_rdb_flag;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:391:17 */
  always @(posedge m_clk)
    n1909 <= n1908;
  initial
    n1909 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  assign n1910 = m_ena ? n1232 : m_rst_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  always @(posedge m_clk)
    n1911 <= n1910;
  initial
    n1911 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  assign n1912 = m_ena ? n1235 : m_sxt_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:687:17 */
  always @(posedge m_clk)
    n1913 <= n1912;
  initial
    n1913 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  assign n1914 = m_ena ? m_rsn : m_rsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  always @(posedge m_clk)
    n1915 <= n1914;
  initial
    n1915 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:510:17 */
  assign n1916 = m_ena ? n495 : m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:510:17 */
  always @(posedge m_clk)
    n1917 <= n1916;
  initial
    n1917 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:345:17 */
  assign n1918 = n209 ? n218 : m_t11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:345:17 */
  always @(negedge m_clk)
    n1919 <= n1918;
  initial
    n1919 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:551:17 */
  assign n1920 = m_ena ? n593 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:551:17 */
  always @(posedge m_clk)
    n1921 <= n1920;
  initial
    n1921 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  assign n1922 = m_ena ? m_talk : m_talk_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  always @(posedge m_clk)
    n1923 <= n1922;
  initial
    n1923 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:551:17 */
  assign n1924 = m_ena ? n585 : m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:551:17 */
  always @(posedge m_clk)
    n1925 <= n1924;
  initial
    n1925 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:718:17 */
  assign n1926 = m_ena ? m_talkd : m_talkd_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:718:17 */
  always @(posedge m_clk)
    n1927 <= n1926;
  initial
    n1927 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1928 = m_ena ? n1817 : m_uf;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1929 <= n1928;
  initial
    n1929 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1930 = m_ena ? m_wsn : m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1931 <= n1930;
  initial
    n1931 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1932 = m_ena ? n1819 : m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1933 <= n1932;
  initial
    n1933 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  assign n1934 = m_ena ? m_buffer_empty : m_buffer_empty_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  always @(posedge m_clk)
    n1935 <= n1934;
  initial
    n1935 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  assign n1936 = m_ena ? m_buffer_low : m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  always @(posedge m_clk)
    n1937 <= n1936;
  initial
    n1937 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  assign n1938 = m_ena ? n179 : m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  always @(posedge m_clk)
    n1939 <= n1938;
  initial
    n1939 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:17 */
  assign n1940 = m_ena ? n1303 : m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:17 */
  always @(posedge m_clk)
    n1941 <= n1940;
  initial
    n1941 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  assign n1942 = m_ena ? n278 : m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:364:17 */
  always @(posedge m_clk)
    n1943 <= n1942;
  initial
    n1943 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  assign n1944 = m_ena ? n312 : m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:404:17 */
  always @(posedge m_clk)
    n1945 <= n1944;
  initial
    n1945 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  assign n1946 = m_ena ? n426 : m_irq_pin_clr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  always @(posedge m_clk)
    n1947 <= n1946;
  initial
    n1947 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1948 = m_ena ? n1820 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1949 <= n1948;
  initial
    n1949 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1950 = m_ena ? n1821 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1951 <= n1950;
  initial
    n1951 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1952 = m_ena ? n1822 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1953 <= n1952;
  initial
    n1953 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1954 = m_ena ? n1823 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1955 <= n1954;
  initial
    n1955 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1956 = m_ena ? n1824 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1957 <= n1956;
  initial
    n1957 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:441:17 */
  assign n1958 = n402 ? n378 : m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:441:17 */
  always @(posedge m_clk)
    n1959 <= n1958;
  initial
    n1959 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:754:17 */
  assign n1960 = m_ena ? n1361 : m_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:754:17 */
  always @(posedge m_clk)
    n1961 <= n1960;
  initial
    n1961 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:754:17 */
  assign n1962 = m_ena ? n1362 : m_uv_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:754:17 */
  always @(posedge m_clk)
    n1963 <= n1962;
  initial
    n1963 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  assign n1964 = m_ena ? n181 : phictr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:286:17 */
  always @(posedge m_clk)
    n1965 <= n1964;
  initial
    n1965 = 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1966 = m_ena ? n1401 : m_wr_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1967 <= n1966;
  initial
    n1967 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  assign n1968 = n432 ? n423 : m_dbo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:465:17 */
  always @(posedge m_clk)
    n1969 <= n1968;
  initial
    n1969 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:345:17 */
  assign n1970 = n209 ? n219 : m_shift;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:345:17 */
  always @(negedge m_clk)
    n1971 <= n1970;
  initial
    n1971 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:424:17 */
  assign n1972 = m_ena ? n338 : m_rng;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:424:17 */
  always @(posedge m_clk)
    n1973 <= n1972;
  initial
    n1973 = 13'b1111111111111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:486:17 */
  assign n1974 = n464 ? n462 : m_excitation_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:486:17 */
  always @(posedge m_clk)
    n1975 <= n1974;
  initial
    n1975 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  assign n1976 = m_ena ? n1180 : m_previous_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  always @(posedge m_clk)
    n1977 <= n1976;
  initial
    n1977 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:17 */
  assign n1978 = m_ena ? n826 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:17 */
  always @(posedge m_clk)
    n1979 <= n1978;
  initial
    n1979 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:17 */
  assign n1980 = m_ena ? n828 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:17 */
  always @(posedge m_clk)
    n1981 <= n1980;
  initial
    n1981 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  assign n1982 = m_ena ? n1181 : this_sample;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:17 */
  always @(posedge m_clk)
    n1983 <= n1982;
  initial
    n1983 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:17 */
  assign n1984 = m_ena ? n829 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:17 */
  always @(posedge m_clk)
    n1985 <= n1984;
  initial
    n1985 = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  assign n1986 = m_ena ? n1825 : m_fifo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:17 */
  always @(posedge m_clk)
    n1987 <= n1986;
  initial
    n1987 = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:500:81 */
  reg [6:0] n1988[51:0] ; // memory
  initial begin
    n1988[51] = 7'b0000000;
    n1988[50] = 7'b0000000;
    n1988[49] = 7'b0000000;
    n1988[48] = 7'b0000000;
    n1988[47] = 7'b0000000;
    n1988[46] = 7'b0000000;
    n1988[45] = 7'b0000000;
    n1988[44] = 7'b0000000;
    n1988[43] = 7'b0000000;
    n1988[42] = 7'b0000000;
    n1988[41] = 7'b0000000;
    n1988[40] = 7'b0000000;
    n1988[39] = 7'b0000000;
    n1988[38] = 7'b0000000;
    n1988[37] = 7'b0000000;
    n1988[36] = 7'b0000000;
    n1988[35] = 7'b0000000;
    n1988[34] = 7'b0000000;
    n1988[33] = 7'b0000000;
    n1988[32] = 7'b0000000;
    n1988[31] = 7'b0000000;
    n1988[30] = 7'b0000000;
    n1988[29] = 7'b0000000;
    n1988[28] = 7'b0000000;
    n1988[27] = 7'b0000000;
    n1988[26] = 7'b0000000;
    n1988[25] = 7'b0000000;
    n1988[24] = 7'b0000000;
    n1988[23] = 7'b0000000;
    n1988[22] = 7'b0000000;
    n1988[21] = 7'b0000000;
    n1988[20] = 7'b0011101;
    n1988[19] = 7'b0011111;
    n1988[18] = 7'b0100101;
    n1988[17] = 7'b0011010;
    n1988[16] = 7'b0110111;
    n1988[15] = 7'b0010011;
    n1988[14] = 7'b0111011;
    n1988[13] = 7'b0110010;
    n1988[12] = 7'b0011010;
    n1988[11] = 7'b1000100;
    n1988[10] = 7'b1001100;
    n1988[9] = 7'b0100110;
    n1988[8] = 7'b0100101;
    n1988[7] = 7'b1010000;
    n1988[6] = 7'b1110001;
    n1988[5] = 7'b1101100;
    n1988[4] = 7'b1001100;
    n1988[3] = 7'b0101000;
    n1988[2] = 7'b0001111;
    n1988[1] = 7'b0000011;
    n1988[0] = 7'b0000000;
    end
  assign n1990 = n1988[n453];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:500:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:102 */
  reg [6:0] n1991[15:0] ; // memory
  initial begin
    n1991[15] = 7'b0000000;
    n1991[14] = 7'b1110010;
    n1991[13] = 7'b1010101;
    n1991[12] = 7'b0111111;
    n1991[11] = 7'b0101111;
    n1991[10] = 7'b0100001;
    n1991[9] = 7'b0010111;
    n1991[8] = 7'b0010000;
    n1991[7] = 7'b0001011;
    n1991[6] = 7'b0001000;
    n1991[5] = 7'b0000110;
    n1991[4] = 7'b0000100;
    n1991[3] = 7'b0000011;
    n1991[2] = 7'b0000010;
    n1991[1] = 7'b0000001;
    n1991[0] = 7'b0000000;
    end
  assign n1993 = n1991[m_new_frame_energy_idx];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:102 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:163 */
  reg [1:0] n1994[7:0] ; // memory
  initial begin
    n1994[7] = 2'b01;
    n1994[6] = 2'b01;
    n1994[5] = 2'b10;
    n1994[4] = 2'b10;
    n1994[3] = 2'b11;
    n1994[2] = 2'b11;
    n1994[1] = 2'b11;
    n1994[0] = 2'b00;
    end
  assign n1996 = n1994[m_ic];
  assign n1997 = n1994[m_ic];
  assign n1998 = n1994[m_ic];
  assign n1999 = n1994[m_ic];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:186 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:178 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:161 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:594:163 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:101 */
  reg [7:0] n2000[63:0] ; // memory
  initial begin
    n2000[63] = 8'b10011111;
    n2000[62] = 8'b10011001;
    n2000[61] = 8'b10010100;
    n2000[60] = 8'b10001110;
    n2000[59] = 8'b10001001;
    n2000[58] = 8'b10000100;
    n2000[57] = 8'b01111111;
    n2000[56] = 8'b01111010;
    n2000[55] = 8'b01110110;
    n2000[54] = 8'b01110010;
    n2000[53] = 8'b01101101;
    n2000[52] = 8'b01101001;
    n2000[51] = 8'b01100101;
    n2000[50] = 8'b01100010;
    n2000[49] = 8'b01011110;
    n2000[48] = 8'b01011011;
    n2000[47] = 8'b01010110;
    n2000[46] = 8'b01010100;
    n2000[45] = 8'b01010000;
    n2000[44] = 8'b01001110;
    n2000[43] = 8'b01001100;
    n2000[42] = 8'b01001000;
    n2000[41] = 8'b01000110;
    n2000[40] = 8'b01000100;
    n2000[39] = 8'b01000001;
    n2000[38] = 8'b00111110;
    n2000[37] = 8'b00111100;
    n2000[36] = 8'b00111010;
    n2000[35] = 8'b00111000;
    n2000[34] = 8'b00110101;
    n2000[33] = 8'b00110100;
    n2000[32] = 8'b00110010;
    n2000[31] = 8'b00110000;
    n2000[30] = 8'b00101110;
    n2000[29] = 8'b00101100;
    n2000[28] = 8'b00101010;
    n2000[27] = 8'b00101001;
    n2000[26] = 8'b00101000;
    n2000[25] = 8'b00100111;
    n2000[24] = 8'b00100110;
    n2000[23] = 8'b00100101;
    n2000[22] = 8'b00100100;
    n2000[21] = 8'b00100011;
    n2000[20] = 8'b00100010;
    n2000[19] = 8'b00100001;
    n2000[18] = 8'b00100000;
    n2000[17] = 8'b00011111;
    n2000[16] = 8'b00011110;
    n2000[15] = 8'b00011101;
    n2000[14] = 8'b00011100;
    n2000[13] = 8'b00011011;
    n2000[12] = 8'b00011010;
    n2000[11] = 8'b00011001;
    n2000[10] = 8'b00011000;
    n2000[9] = 8'b00010111;
    n2000[8] = 8'b00010110;
    n2000[7] = 8'b00010101;
    n2000[6] = 8'b00010100;
    n2000[5] = 8'b00010011;
    n2000[4] = 8'b00010010;
    n2000[3] = 8'b00010001;
    n2000[2] = 8'b00010000;
    n2000[1] = 8'b00001111;
    n2000[0] = 8'b00000000;
    end
  assign n2002 = n2000[n645];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:101 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:601:100 */
  reg [9:0] n2003[319:0] ; // memory
  initial begin
    n2003[319] = 10'b1000001011;
    n2003[318] = 10'b1000001110;
    n2003[317] = 10'b1000001111;
    n2003[316] = 10'b1000010001;
    n2003[315] = 10'b1000010011;
    n2003[314] = 10'b1000010101;
    n2003[313] = 10'b1000011000;
    n2003[312] = 10'b1000011110;
    n2003[311] = 10'b1000100010;
    n2003[310] = 10'b1000100110;
    n2003[309] = 10'b1000101011;
    n2003[308] = 10'b1000110000;
    n2003[307] = 10'b1000110101;
    n2003[306] = 10'b1000111100;
    n2003[305] = 10'b1001000011;
    n2003[304] = 10'b1001001011;
    n2003[303] = 10'b1001100100;
    n2003[302] = 10'b1010000100;
    n2003[301] = 10'b1010101101;
    n2003[300] = 10'b1011100000;
    n2003[299] = 10'b1100011101;
    n2003[298] = 10'b1101100010;
    n2003[297] = 10'b1110101111;
    n2003[296] = 10'b1111111111;
    n2003[295] = 10'b0001010000;
    n2003[294] = 10'b0010011101;
    n2003[293] = 10'b0011100010;
    n2003[292] = 10'b0100011111;
    n2003[291] = 10'b0101010001;
    n2003[290] = 10'b0101111011;
    n2003[289] = 10'b0110011011;
    n2003[288] = 10'b0110110100;
    n2003[287] = 10'b1010111000;
    n2003[286] = 10'b1011010001;
    n2003[285] = 10'b1011101110;
    n2003[284] = 10'b1100001100;
    n2003[283] = 10'b1100101101;
    n2003[282] = 10'b1101010001;
    n2003[281] = 10'b1101110110;
    n2003[280] = 10'b1110011101;
    n2003[279] = 10'b1111000101;
    n2003[278] = 10'b1111101110;
    n2003[277] = 10'b0000011000;
    n2003[276] = 10'b0001000000;
    n2003[275] = 10'b0001101001;
    n2003[274] = 10'b0010001111;
    n2003[273] = 10'b0010110100;
    n2003[272] = 10'b0011010111;
    n2003[271] = 10'b0011111000;
    n2003[270] = 10'b0100010110;
    n2003[269] = 10'b0100110010;
    n2003[268] = 10'b0101001011;
    n2003[267] = 10'b0101100010;
    n2003[266] = 10'b0101110110;
    n2003[265] = 10'b0110001000;
    n2003[264] = 10'b0110011000;
    n2003[263] = 10'b0110100110;
    n2003[262] = 10'b0110110011;
    n2003[261] = 10'b0110111101;
    n2003[260] = 10'b0111000111;
    n2003[259] = 10'b0111001111;
    n2003[258] = 10'b0111010110;
    n2003[257] = 10'b0111011100;
    n2003[256] = 10'b0111111010;
    n2003[255] = 10'b1001000111;
    n2003[254] = 10'b1001111101;
    n2003[253] = 10'b1010110011;
    n2003[252] = 10'b1011101001;
    n2003[251] = 10'b1100011111;
    n2003[250] = 10'b1101010101;
    n2003[249] = 10'b1110001011;
    n2003[248] = 10'b1111000001;
    n2003[247] = 10'b1111110111;
    n2003[246] = 10'b0000101101;
    n2003[245] = 10'b0001100010;
    n2003[244] = 10'b0010011000;
    n2003[243] = 10'b0011001110;
    n2003[242] = 10'b0100000100;
    n2003[241] = 10'b0100111010;
    n2003[240] = 10'b0101110000;
    n2003[239] = 10'b0000000000;
    n2003[238] = 10'b0000000000;
    n2003[237] = 10'b0000000000;
    n2003[236] = 10'b0000000000;
    n2003[235] = 10'b0000000000;
    n2003[234] = 10'b0000000000;
    n2003[233] = 10'b0000000000;
    n2003[232] = 10'b0000000000;
    n2003[231] = 10'b0000000000;
    n2003[230] = 10'b0000000000;
    n2003[229] = 10'b0000000000;
    n2003[228] = 10'b0000000000;
    n2003[227] = 10'b0000000000;
    n2003[226] = 10'b0000000000;
    n2003[225] = 10'b0000000000;
    n2003[224] = 10'b0000000000;
    n2003[223] = 10'b1010111000;
    n2003[222] = 10'b1011101111;
    n2003[221] = 10'b1100100111;
    n2003[220] = 10'b1101011111;
    n2003[219] = 10'b1110010110;
    n2003[218] = 10'b1111001110;
    n2003[217] = 10'b0000000101;
    n2003[216] = 10'b0000111101;
    n2003[215] = 10'b0001110100;
    n2003[214] = 10'b0010101100;
    n2003[213] = 10'b0011100100;
    n2003[212] = 10'b0100011011;
    n2003[211] = 10'b0101010011;
    n2003[210] = 10'b0110001010;
    n2003[209] = 10'b0111000010;
    n2003[208] = 10'b0111111010;
    n2003[207] = 10'b0000000000;
    n2003[206] = 10'b0000000000;
    n2003[205] = 10'b0000000000;
    n2003[204] = 10'b0000000000;
    n2003[203] = 10'b0000000000;
    n2003[202] = 10'b0000000000;
    n2003[201] = 10'b0000000000;
    n2003[200] = 10'b0000000000;
    n2003[199] = 10'b0000000000;
    n2003[198] = 10'b0000000000;
    n2003[197] = 10'b0000000000;
    n2003[196] = 10'b0000000000;
    n2003[195] = 10'b0000000000;
    n2003[194] = 10'b0000000000;
    n2003[193] = 10'b0000000000;
    n2003[192] = 10'b0000000000;
    n2003[191] = 10'b1010111000;
    n2003[190] = 10'b1011100110;
    n2003[189] = 10'b1100010101;
    n2003[188] = 10'b1101000011;
    n2003[187] = 10'b1101110010;
    n2003[186] = 10'b1110100000;
    n2003[185] = 10'b1111001110;
    n2003[184] = 10'b1111111101;
    n2003[183] = 10'b0000101011;
    n2003[182] = 10'b0001011010;
    n2003[181] = 10'b0010001000;
    n2003[180] = 10'b0010110110;
    n2003[179] = 10'b0011100101;
    n2003[178] = 10'b0100010011;
    n2003[177] = 10'b0101000010;
    n2003[176] = 10'b0101110000;
    n2003[175] = 10'b0000000000;
    n2003[174] = 10'b0000000000;
    n2003[173] = 10'b0000000000;
    n2003[172] = 10'b0000000000;
    n2003[171] = 10'b0000000000;
    n2003[170] = 10'b0000000000;
    n2003[169] = 10'b0000000000;
    n2003[168] = 10'b0000000000;
    n2003[167] = 10'b0000000000;
    n2003[166] = 10'b0000000000;
    n2003[165] = 10'b0000000000;
    n2003[164] = 10'b0000000000;
    n2003[163] = 10'b0000000000;
    n2003[162] = 10'b0000000000;
    n2003[161] = 10'b0000000000;
    n2003[160] = 10'b0000000000;
    n2003[159] = 10'b1100000000;
    n2003[158] = 10'b1100101100;
    n2003[157] = 10'b1101011000;
    n2003[156] = 10'b1110000101;
    n2003[155] = 10'b1110110001;
    n2003[154] = 10'b1111011101;
    n2003[153] = 10'b0000001010;
    n2003[152] = 10'b0000110110;
    n2003[151] = 10'b0001100010;
    n2003[150] = 10'b0010001111;
    n2003[149] = 10'b0010111011;
    n2003[148] = 10'b0011101000;
    n2003[147] = 10'b0100010100;
    n2003[146] = 10'b0101000000;
    n2003[145] = 10'b0101101101;
    n2003[144] = 10'b0110011001;
    n2003[143] = 10'b0000000000;
    n2003[142] = 10'b0000000000;
    n2003[141] = 10'b0000000000;
    n2003[140] = 10'b0000000000;
    n2003[139] = 10'b0000000000;
    n2003[138] = 10'b0000000000;
    n2003[137] = 10'b0000000000;
    n2003[136] = 10'b0000000000;
    n2003[135] = 10'b0000000000;
    n2003[134] = 10'b0000000000;
    n2003[133] = 10'b0000000000;
    n2003[132] = 10'b0000000000;
    n2003[131] = 10'b0000000000;
    n2003[130] = 10'b0000000000;
    n2003[129] = 10'b0000000000;
    n2003[128] = 10'b0000000000;
    n2003[127] = 10'b1011001100;
    n2003[126] = 10'b1011111100;
    n2003[125] = 10'b1100101100;
    n2003[124] = 10'b1101011100;
    n2003[123] = 10'b1110001011;
    n2003[122] = 10'b1110111011;
    n2003[121] = 10'b1111101011;
    n2003[120] = 10'b0000011011;
    n2003[119] = 10'b0001001011;
    n2003[118] = 10'b0001111010;
    n2003[117] = 10'b0010101010;
    n2003[116] = 10'b0011011010;
    n2003[115] = 10'b0100001010;
    n2003[114] = 10'b0100111010;
    n2003[113] = 10'b0101101001;
    n2003[112] = 10'b0110011001;
    n2003[111] = 10'b0000000000;
    n2003[110] = 10'b0000000000;
    n2003[109] = 10'b0000000000;
    n2003[108] = 10'b0000000000;
    n2003[107] = 10'b0000000000;
    n2003[106] = 10'b0000000000;
    n2003[105] = 10'b0000000000;
    n2003[104] = 10'b0000000000;
    n2003[103] = 10'b0000000000;
    n2003[102] = 10'b0000000000;
    n2003[101] = 10'b0000000000;
    n2003[100] = 10'b0000000000;
    n2003[99] = 10'b0000000000;
    n2003[98] = 10'b0000000000;
    n2003[97] = 10'b0000000000;
    n2003[96] = 10'b0000000000;
    n2003[95] = 10'b1100000000;
    n2003[94] = 10'b1101011111;
    n2003[93] = 10'b1110111110;
    n2003[92] = 10'b0000011101;
    n2003[91] = 10'b0001111100;
    n2003[90] = 10'b0011011011;
    n2003[89] = 10'b0100111010;
    n2003[88] = 10'b0110011001;
    n2003[87] = 10'b0000000000;
    n2003[86] = 10'b0000000000;
    n2003[85] = 10'b0000000000;
    n2003[84] = 10'b0000000000;
    n2003[83] = 10'b0000000000;
    n2003[82] = 10'b0000000000;
    n2003[81] = 10'b0000000000;
    n2003[80] = 10'b0000000000;
    n2003[79] = 10'b0000000000;
    n2003[78] = 10'b0000000000;
    n2003[77] = 10'b0000000000;
    n2003[76] = 10'b0000000000;
    n2003[75] = 10'b0000000000;
    n2003[74] = 10'b0000000000;
    n2003[73] = 10'b0000000000;
    n2003[72] = 10'b0000000000;
    n2003[71] = 10'b0000000000;
    n2003[70] = 10'b0000000000;
    n2003[69] = 10'b0000000000;
    n2003[68] = 10'b0000000000;
    n2003[67] = 10'b0000000000;
    n2003[66] = 10'b0000000000;
    n2003[65] = 10'b0000000000;
    n2003[64] = 10'b0000000000;
    n2003[63] = 10'b1100000000;
    n2003[62] = 10'b1101010000;
    n2003[61] = 10'b1110100000;
    n2003[60] = 10'b1111110001;
    n2003[59] = 10'b0001000001;
    n2003[58] = 10'b0010010010;
    n2003[57] = 10'b0011100010;
    n2003[56] = 10'b0100110011;
    n2003[55] = 10'b0000000000;
    n2003[54] = 10'b0000000000;
    n2003[53] = 10'b0000000000;
    n2003[52] = 10'b0000000000;
    n2003[51] = 10'b0000000000;
    n2003[50] = 10'b0000000000;
    n2003[49] = 10'b0000000000;
    n2003[48] = 10'b0000000000;
    n2003[47] = 10'b0000000000;
    n2003[46] = 10'b0000000000;
    n2003[45] = 10'b0000000000;
    n2003[44] = 10'b0000000000;
    n2003[43] = 10'b0000000000;
    n2003[42] = 10'b0000000000;
    n2003[41] = 10'b0000000000;
    n2003[40] = 10'b0000000000;
    n2003[39] = 10'b0000000000;
    n2003[38] = 10'b0000000000;
    n2003[37] = 10'b0000000000;
    n2003[36] = 10'b0000000000;
    n2003[35] = 10'b0000000000;
    n2003[34] = 10'b0000000000;
    n2003[33] = 10'b0000000000;
    n2003[32] = 10'b0000000000;
    n2003[31] = 10'b1100110011;
    n2003[30] = 10'b1101111100;
    n2003[29] = 10'b1111000101;
    n2003[28] = 10'b0000001110;
    n2003[27] = 10'b0001010111;
    n2003[26] = 10'b0010100000;
    n2003[25] = 10'b0011101010;
    n2003[24] = 10'b0100110011;
    n2003[23] = 10'b0000000000;
    n2003[22] = 10'b0000000000;
    n2003[21] = 10'b0000000000;
    n2003[20] = 10'b0000000000;
    n2003[19] = 10'b0000000000;
    n2003[18] = 10'b0000000000;
    n2003[17] = 10'b0000000000;
    n2003[16] = 10'b0000000000;
    n2003[15] = 10'b0000000000;
    n2003[14] = 10'b0000000000;
    n2003[13] = 10'b0000000000;
    n2003[12] = 10'b0000000000;
    n2003[11] = 10'b0000000000;
    n2003[10] = 10'b0000000000;
    n2003[9] = 10'b0000000000;
    n2003[8] = 10'b0000000000;
    n2003[7] = 10'b0000000000;
    n2003[6] = 10'b0000000000;
    n2003[5] = 10'b0000000000;
    n2003[4] = 10'b0000000000;
    n2003[3] = 10'b0000000000;
    n2003[2] = 10'b0000000000;
    n2003[1] = 10'b0000000000;
    n2003[0] = 10'b0000000000;
    end
  assign n2005 = n2003[n2004];
  assign n2007 = n2003[n2006];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:133 */
  assign n2004 = {n774, n785};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:125 */
  assign n2006 = {n695, n706};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:98 */
  reg [2:0] n2008[9:0] ; // memory
  initial begin
    n2008[9] = 3'b011;
    n2008[8] = 3'b011;
    n2008[7] = 3'b011;
    n2008[6] = 3'b100;
    n2008[5] = 3'b100;
    n2008[4] = 3'b100;
    n2008[3] = 3'b100;
    n2008[2] = 3'b100;
    n2008[1] = 3'b101;
    n2008[0] = 3'b101;
    end
  assign n2010 = n2008[n1649];
  assign n2011 = n2008[n1638];
  assign n2012 = n2008[n1625];
  assign n2013 = n2008[n1550];
  assign n2014 = n2008[n1539];
  assign n2015 = n2008[n1525];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:98 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:98 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:96 */
  assign n2017 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:96 */
  assign n2018 = n2017[n686 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:130 */
  assign n2020 = {30'bX, m_new_frame_k_idx};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:130 */
  assign n2021 = n2020[n702 * 5 +: 5]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:154 */
  assign n2023 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:154 */
  assign n2024 = n2023[n717 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2025 = n679[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2026 = ~n2025;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2027 = n679[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2028 = ~n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2029 = n2026 & n2028;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2030 = n2026 & n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2031 = n2025 & n2028;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2032 = n679[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2033 = ~n2032;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2034 = n2029 & n2033;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2035 = n2029 & n2032;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2036 = n2030 & n2033;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2037 = n2030 & n2032;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2038 = n2031 & n2033;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2039 = n679[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2040 = ~n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2041 = n2034 & n2040;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2042 = n2034 & n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2043 = n2035 & n2040;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2044 = n2035 & n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2045 = n2036 & n2040;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2046 = n2036 & n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2047 = n2037 & n2040;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2048 = n2037 & n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2049 = n2038 & n2040;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2050 = n2038 & n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2051 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2052 = n2041 ? n731 : n2051;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2053 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2054 = n2042 ? n731 : n2053;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2055 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2056 = n2043 ? n731 : n2055;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2057 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2058 = n2044 ? n731 : n2057;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2059 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2060 = n2045 ? n731 : n2059;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2061 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2062 = n2046 ? n731 : n2061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2063 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2064 = n2047 ? n731 : n2063;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2065 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2066 = n2048 ? n731 : n2065;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2067 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2068 = n2049 ? n731 : n2067;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2069 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2070 = n2050 ? n731 : n2069;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:605:57 */
  assign n2071 = {n2070, n2068, n2066, n2064, n2062, n2060, n2058, n2056, n2054, n2052};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2072 = n744[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2073 = ~n2072;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2074 = n744[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2075 = ~n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2076 = n2073 & n2075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2077 = n2073 & n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2078 = n2072 & n2075;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2079 = n744[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2080 = ~n2079;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2081 = n2076 & n2080;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2082 = n2076 & n2079;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2083 = n2077 & n2080;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2084 = n2077 & n2079;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2085 = n2078 & n2080;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2086 = n744[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2087 = ~n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2088 = n2081 & n2087;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2089 = n2081 & n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2090 = n2082 & n2087;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2091 = n2082 & n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2092 = n2083 & n2087;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2093 = n2083 & n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2094 = n2084 & n2087;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2095 = n2084 & n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2096 = n2085 & n2087;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2097 = n2085 & n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2098 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2099 = n2088 ? 10'b0000000000 : n2098;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2100 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2101 = n2089 ? 10'b0000000000 : n2100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2102 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2103 = n2090 ? 10'b0000000000 : n2102;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2104 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2105 = n2091 ? 10'b0000000000 : n2104;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2106 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2107 = n2092 ? 10'b0000000000 : n2106;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2108 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2109 = n2093 ? 10'b0000000000 : n2108;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2110 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2111 = n2094 ? 10'b0000000000 : n2110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2112 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2113 = n2095 ? 10'b0000000000 : n2112;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2114 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2115 = n2096 ? 10'b0000000000 : n2114;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2116 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2117 = n2097 ? 10'b0000000000 : n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:57 */
  assign n2118 = {n2117, n2115, n2113, n2111, n2109, n2107, n2105, n2103, n2101, n2099};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:104 */
  assign n2120 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:104 */
  assign n2121 = n2120[n765 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:138 */
  assign n2123 = {30'bX, m_new_frame_k_idx};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:138 */
  assign n2124 = n2123[n781 * 5 +: 5]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:162 */
  assign n2126 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:162 */
  assign n2127 = n2126[n795 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2128 = n758[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2129 = ~n2128;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2130 = n758[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2131 = ~n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2132 = n2129 & n2131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2133 = n2129 & n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2134 = n2128 & n2131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2135 = n758[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2136 = ~n2135;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2137 = n2132 & n2136;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2138 = n2132 & n2135;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2139 = n2133 & n2136;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2140 = n2133 & n2135;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2141 = n2134 & n2136;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2142 = n758[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2143 = ~n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2144 = n2137 & n2143;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2145 = n2137 & n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2146 = n2138 & n2143;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2147 = n2138 & n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2148 = n2139 & n2143;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2149 = n2139 & n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2150 = n2140 & n2143;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2151 = n2140 & n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2152 = n2141 & n2143;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2153 = n2141 & n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2154 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2155 = n2144 ? n809 : n2154;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2156 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2157 = n2145 ? n809 : n2156;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2158 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2159 = n2146 ? n809 : n2158;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2160 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2161 = n2147 ? n809 : n2160;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2162 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2163 = n2148 ? n809 : n2162;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2164 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2165 = n2149 ? n809 : n2164;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2166 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2167 = n2150 ? n809 : n2166;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2168 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2169 = n2151 ? n809 : n2168;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2170 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2171 = n2152 ? n809 : n2170;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2172 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2173 = n2153 ? n809 : n2172;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:65 */
  assign n2174 = {n2173, n2171, n2169, n2167, n2165, n2163, n2161, n2159, n2157, n2155};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2175 = n1563[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2176 = ~n2175;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2177 = n1563[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2178 = ~n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2179 = n2176 & n2178;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2180 = n2176 & n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2181 = n2175 & n2178;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2182 = n1563[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2183 = ~n2182;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2184 = n2179 & n2183;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2185 = n2179 & n2182;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2186 = n2180 & n2183;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2187 = n2180 & n2182;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2188 = n2181 & n2183;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2189 = n1563[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2190 = ~n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2191 = n2184 & n2190;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2192 = n2184 & n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2193 = n2185 & n2190;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2194 = n2185 & n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2195 = n2186 & n2190;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2196 = n2186 & n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2197 = n2187 & n2190;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2198 = n2187 & n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2199 = n2188 & n2190;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2200 = n2188 & n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2201 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2202 = n2191 ? n1565 : n2201;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2203 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2204 = n2192 ? n1565 : n2203;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2205 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2206 = n2193 ? n1565 : n2205;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2207 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2208 = n2194 ? n1565 : n2207;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2209 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2210 = n2195 ? n1565 : n2209;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2211 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2212 = n2196 ? n1565 : n2211;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2213 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2214 = n2197 ? n1565 : n2213;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2215 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2216 = n2198 ? n1565 : n2215;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2217 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2218 = n2199 ? n1565 : n2217;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2219 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2220 = n2200 ? n1565 : n2219;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:850:81 */
  assign n2221 = {n2220, n2218, n2216, n2214, n2212, n2210, n2208, n2206, n2204, n2202};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2222 = n1578[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2223 = ~n2222;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2224 = n1578[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2225 = ~n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2226 = n2223 & n2225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2227 = n2223 & n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2228 = n2222 & n2225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2229 = n1578[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2230 = ~n2229;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2231 = n2226 & n2230;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2232 = n2226 & n2229;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2233 = n2227 & n2230;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2234 = n2227 & n2229;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2235 = n2228 & n2230;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2236 = n1578[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2237 = ~n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2238 = n2231 & n2237;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2239 = n2231 & n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2240 = n2232 & n2237;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2241 = n2232 & n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2242 = n2233 & n2237;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2243 = n2233 & n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2244 = n2234 & n2237;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2245 = n2234 & n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2246 = n2235 & n2237;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2247 = n2235 & n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2248 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2249 = n2238 ? n1582 : n2248;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2250 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2251 = n2239 ? n1582 : n2250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2252 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2253 = n2240 ? n1582 : n2252;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2254 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2255 = n2241 ? n1582 : n2254;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2256 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2257 = n2242 ? n1582 : n2256;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2258 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2259 = n2243 ? n1582 : n2258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2260 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2261 = n2244 ? n1582 : n2260;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2262 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2263 = n2245 ? n1582 : n2262;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2264 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2265 = n2246 ? n1582 : n2264;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2266 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2267 = n2247 ? n1582 : n2266;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:853:81 */
  assign n2268 = {n2267, n2265, n2263, n2261, n2259, n2257, n2255, n2253, n2251, n2249};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2269 = n1594[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2270 = ~n2269;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2271 = n1594[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2272 = ~n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2273 = n2270 & n2272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2274 = n2270 & n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2275 = n2269 & n2272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2276 = n1594[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2277 = ~n2276;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2278 = n2273 & n2277;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2279 = n2273 & n2276;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2280 = n2274 & n2277;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2281 = n2274 & n2276;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2282 = n2275 & n2277;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2283 = n1594[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2284 = ~n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2285 = n2278 & n2284;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2286 = n2278 & n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2287 = n2279 & n2284;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2288 = n2279 & n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2289 = n2280 & n2284;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2290 = n2280 & n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2291 = n2281 & n2284;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2292 = n2281 & n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2293 = n2282 & n2284;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2294 = n2282 & n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2295 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2296 = n2285 ? n1598 : n2295;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2297 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2298 = n2286 ? n1598 : n2297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2299 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2300 = n2287 ? n1598 : n2299;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2301 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2302 = n2288 ? n1598 : n2301;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2303 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2304 = n2289 ? n1598 : n2303;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2305 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2306 = n2290 ? n1598 : n2305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2307 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2308 = n2291 ? n1598 : n2307;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2309 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2310 = n2292 ? n1598 : n2309;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2311 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2312 = n2293 ? n1598 : n2311;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2313 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2314 = n2294 ? n1598 : n2313;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:856:81 */
  assign n2315 = {n2314, n2312, n2310, n2308, n2306, n2304, n2302, n2300, n2298, n2296};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2316 = n1662[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2317 = ~n2316;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2318 = n1662[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2319 = ~n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2320 = n2317 & n2319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2321 = n2317 & n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2322 = n2316 & n2319;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2323 = n1662[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2324 = ~n2323;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2325 = n2320 & n2324;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2326 = n2320 & n2323;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2327 = n2321 & n2324;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2328 = n2321 & n2323;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2329 = n2322 & n2324;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2330 = n1662[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2331 = ~n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2332 = n2325 & n2331;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2333 = n2325 & n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2334 = n2326 & n2331;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2335 = n2326 & n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2336 = n2327 & n2331;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2337 = n2327 & n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2338 = n2328 & n2331;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2339 = n2328 & n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2340 = n2329 & n2331;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2341 = n2329 & n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2342 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2343 = n2332 ? n1664 : n2342;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2344 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2345 = n2333 ? n1664 : n2344;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2346 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2347 = n2334 ? n1664 : n2346;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2348 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2349 = n2335 ? n1664 : n2348;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2350 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2351 = n2336 ? n1664 : n2350;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2352 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2353 = n2337 ? n1664 : n2352;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2354 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2355 = n2338 ? n1664 : n2354;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2356 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2357 = n2339 ? n1664 : n2356;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2358 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2359 = n2340 ? n1664 : n2358;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2360 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2361 = n2341 ? n1664 : n2360;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:872:81 */
  assign n2362 = {n2361, n2359, n2357, n2355, n2353, n2351, n2349, n2347, n2345, n2343};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2363 = n1677[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2364 = ~n2363;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2365 = n1677[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2366 = ~n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2367 = n2364 & n2366;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2368 = n2364 & n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2369 = n2363 & n2366;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2370 = n1677[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2371 = ~n2370;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2372 = n2367 & n2371;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2373 = n2367 & n2370;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2374 = n2368 & n2371;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2375 = n2368 & n2370;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2376 = n2369 & n2371;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2377 = n1677[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2378 = ~n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2379 = n2372 & n2378;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2380 = n2372 & n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2381 = n2373 & n2378;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2382 = n2373 & n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2383 = n2374 & n2378;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2384 = n2374 & n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2385 = n2375 & n2378;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2386 = n2375 & n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2387 = n2376 & n2378;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2388 = n2376 & n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2389 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2390 = n2379 ? n1681 : n2389;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2391 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2392 = n2380 ? n1681 : n2391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2393 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2394 = n2381 ? n1681 : n2393;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2395 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2396 = n2382 ? n1681 : n2395;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2397 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2398 = n2383 ? n1681 : n2397;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2399 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2400 = n2384 ? n1681 : n2399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2401 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2402 = n2385 ? n1681 : n2401;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2403 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2404 = n2386 ? n1681 : n2403;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2405 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2406 = n2387 ? n1681 : n2405;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2407 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2408 = n2388 ? n1681 : n2407;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:81 */
  assign n2409 = {n2408, n2406, n2404, n2402, n2400, n2398, n2396, n2394, n2392, n2390};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2410 = n1693[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2411 = ~n2410;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2412 = n1693[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2413 = ~n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2414 = n2411 & n2413;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2415 = n2411 & n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2416 = n2410 & n2413;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2417 = n1693[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2418 = ~n2417;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2419 = n2414 & n2418;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2420 = n2414 & n2417;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2421 = n2415 & n2418;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2422 = n2415 & n2417;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2423 = n2416 & n2418;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2424 = n1693[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2425 = ~n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2426 = n2419 & n2425;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2427 = n2419 & n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2428 = n2420 & n2425;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2429 = n2420 & n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2430 = n2421 & n2425;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2431 = n2421 & n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2432 = n2422 & n2425;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2433 = n2422 & n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2434 = n2423 & n2425;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2435 = n2423 & n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2436 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2437 = n2426 ? n1697 : n2436;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2438 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2439 = n2427 ? n1697 : n2438;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2440 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2441 = n2428 ? n1697 : n2440;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2442 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2443 = n2429 ? n1697 : n2442;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2444 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2445 = n2430 ? n1697 : n2444;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2446 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2447 = n2431 ? n1697 : n2446;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2448 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2449 = n2432 ? n1697 : n2448;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2450 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2451 = n2433 ? n1697 : n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2452 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2453 = n2434 ? n1697 : n2452;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2454 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2455 = n2435 ? n1697 : n2454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:81 */
  assign n2456 = {n2455, n2453, n2451, n2449, n2447, n2445, n2443, n2441, n2439, n2437};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2457 = n1777[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2458 = ~n2457;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2459 = n1777[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2460 = ~n2459;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2461 = n2458 & n2460;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2462 = n2458 & n2459;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2463 = n2457 & n2460;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2464 = n2457 & n2459;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2465 = n1777[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2466 = ~n2465;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2467 = n2461 & n2466;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2468 = n2461 & n2465;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2469 = n2462 & n2466;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2470 = n2462 & n2465;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2471 = n2463 & n2466;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2472 = n2463 & n2465;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2473 = n2464 & n2466;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2474 = n2464 & n2465;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2475 = n1777[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2476 = ~n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2477 = n2467 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2478 = n2467 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2479 = n2468 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2480 = n2468 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2481 = n2469 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2482 = n2469 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2483 = n2470 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2484 = n2470 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2485 = n2471 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2486 = n2471 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2487 = n2472 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2488 = n2472 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2489 = n2473 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2490 = n2473 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2491 = n2474 & n2476;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2492 = n2474 & n2475;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2493 = n1777[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2494 = ~n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2495 = n2477 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2496 = n2477 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2497 = n2478 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2498 = n2478 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2499 = n2479 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2500 = n2479 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2501 = n2480 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2502 = n2480 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2503 = n2481 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2504 = n2481 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2505 = n2482 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2506 = n2482 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2507 = n2483 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2508 = n2483 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2509 = n2484 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2510 = n2484 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2511 = n2485 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2512 = n2485 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2513 = n2486 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2514 = n2486 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2515 = n2487 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2516 = n2487 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2517 = n2488 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2518 = n2488 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2519 = n2489 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2520 = n2489 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2521 = n2490 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2522 = n2490 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2523 = n2491 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2524 = n2491 & n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2525 = n2492 & n2494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2526 = n1777[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2527 = ~n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2528 = n2495 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2529 = n2495 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2530 = n2496 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2531 = n2496 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2532 = n2497 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2533 = n2497 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2534 = n2498 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2535 = n2498 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2536 = n2499 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2537 = n2499 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2538 = n2500 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2539 = n2500 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2540 = n2501 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2541 = n2501 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2542 = n2502 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2543 = n2502 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2544 = n2503 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2545 = n2503 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2546 = n2504 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2547 = n2504 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2548 = n2505 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2549 = n2505 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2550 = n2506 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2551 = n2506 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2552 = n2507 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2553 = n2507 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2554 = n2508 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2555 = n2508 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2556 = n2509 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2557 = n2509 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2558 = n2510 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2559 = n2510 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2560 = n2511 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2561 = n2511 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2562 = n2512 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2563 = n2512 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2564 = n2513 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2565 = n2513 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2566 = n2514 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2567 = n2514 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2568 = n2515 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2569 = n2515 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2570 = n2516 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2571 = n2516 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2572 = n2517 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2573 = n2517 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2574 = n2518 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2575 = n2518 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2576 = n2519 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2577 = n2519 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2578 = n2520 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2579 = n2520 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2580 = n2521 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2581 = n2521 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2582 = n2522 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2583 = n2522 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2584 = n2523 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2585 = n2523 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2586 = n2524 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2587 = n2524 & n2526;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2588 = n2525 & n2527;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2589 = n1777[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2590 = ~n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2591 = n2528 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2592 = n2528 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2593 = n2529 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2594 = n2529 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2595 = n2530 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2596 = n2530 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2597 = n2531 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2598 = n2531 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2599 = n2532 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2600 = n2532 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2601 = n2533 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2602 = n2533 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2603 = n2534 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2604 = n2534 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2605 = n2535 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2606 = n2535 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2607 = n2536 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2608 = n2536 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2609 = n2537 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2610 = n2537 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2611 = n2538 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2612 = n2538 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2613 = n2539 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2614 = n2539 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2615 = n2540 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2616 = n2540 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2617 = n2541 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2618 = n2541 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2619 = n2542 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2620 = n2542 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2621 = n2543 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2622 = n2543 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2623 = n2544 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2624 = n2544 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2625 = n2545 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2626 = n2545 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2627 = n2546 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2628 = n2546 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2629 = n2547 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2630 = n2547 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2631 = n2548 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2632 = n2548 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2633 = n2549 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2634 = n2549 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2635 = n2550 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2636 = n2550 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2637 = n2551 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2638 = n2551 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2639 = n2552 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2640 = n2552 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2641 = n2553 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2642 = n2553 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2643 = n2554 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2644 = n2554 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2645 = n2555 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2646 = n2555 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2647 = n2556 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2648 = n2556 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2649 = n2557 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2650 = n2557 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2651 = n2558 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2652 = n2558 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2653 = n2559 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2654 = n2559 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2655 = n2560 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2656 = n2560 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2657 = n2561 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2658 = n2561 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2659 = n2562 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2660 = n2562 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2661 = n2563 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2662 = n2563 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2663 = n2564 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2664 = n2564 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2665 = n2565 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2666 = n2565 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2667 = n2566 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2668 = n2566 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2669 = n2567 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2670 = n2567 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2671 = n2568 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2672 = n2568 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2673 = n2569 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2674 = n2569 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2675 = n2570 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2676 = n2570 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2677 = n2571 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2678 = n2571 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2679 = n2572 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2680 = n2572 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2681 = n2573 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2682 = n2573 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2683 = n2574 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2684 = n2574 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2685 = n2575 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2686 = n2575 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2687 = n2576 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2688 = n2576 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2689 = n2577 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2690 = n2577 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2691 = n2578 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2692 = n2578 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2693 = n2579 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2694 = n2579 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2695 = n2580 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2696 = n2580 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2697 = n2581 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2698 = n2581 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2699 = n2582 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2700 = n2582 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2701 = n2583 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2702 = n2583 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2703 = n2584 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2704 = n2584 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2705 = n2585 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2706 = n2585 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2707 = n2586 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2708 = n2586 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2709 = n2587 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2710 = n2587 & n2589;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2711 = n2588 & n2590;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2712 = n1403[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2713 = n2591 ? m_wr_reg : n2712;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2714 = n2713[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2715 = n1403[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2716 = n2713[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2717 = {n2715, n2716};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2718 = n2592 ? m_wr_reg : n2717;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2719 = n2718[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2720 = n1403[9]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2721 = n2718[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2722 = {n2720, n2721};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2723 = n2593 ? m_wr_reg : n2722;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2724 = n2723[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2725 = n1403[10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2726 = n2723[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2727 = {n2725, n2726};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2728 = n2594 ? m_wr_reg : n2727;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2729 = n2728[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2730 = n1403[11]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2731 = n2728[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2732 = {n2730, n2731};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2733 = n2595 ? m_wr_reg : n2732;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2734 = n2733[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2735 = n1403[12]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2736 = n2733[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2737 = {n2735, n2736};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2738 = n2596 ? m_wr_reg : n2737;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2739 = n2738[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2740 = n1403[13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2741 = n2738[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2742 = {n2740, n2741};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2743 = n2597 ? m_wr_reg : n2742;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2744 = n2743[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2745 = n1403[14]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2746 = n2743[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2747 = {n2745, n2746};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2748 = n2598 ? m_wr_reg : n2747;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2749 = n2748[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2750 = n1403[15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2751 = n2748[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2752 = {n2750, n2751};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2753 = n2599 ? m_wr_reg : n2752;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2754 = n2753[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2755 = n1403[16]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2756 = n2753[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2757 = {n2755, n2756};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2758 = n2600 ? m_wr_reg : n2757;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2759 = n2758[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2760 = n1403[17]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2761 = n2758[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2762 = {n2760, n2761};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2763 = n2601 ? m_wr_reg : n2762;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2764 = n2763[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2765 = n1403[18]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2766 = n2763[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2767 = {n2765, n2766};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2768 = n2602 ? m_wr_reg : n2767;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2769 = n2768[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2770 = n1403[19]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2771 = n2768[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2772 = {n2770, n2771};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2773 = n2603 ? m_wr_reg : n2772;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2774 = n2773[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2775 = n1403[20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2776 = n2773[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2777 = {n2775, n2776};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2778 = n2604 ? m_wr_reg : n2777;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2779 = n2778[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2780 = n1403[21]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2781 = n2778[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2782 = {n2780, n2781};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2783 = n2605 ? m_wr_reg : n2782;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2784 = n2783[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2785 = n1403[22]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2786 = n2783[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2787 = {n2785, n2786};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2788 = n2606 ? m_wr_reg : n2787;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2789 = n2788[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2790 = n1403[23]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2791 = n2788[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2792 = {n2790, n2791};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2793 = n2607 ? m_wr_reg : n2792;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2794 = n2793[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2795 = n1403[24]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2796 = n2793[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2797 = {n2795, n2796};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2798 = n2608 ? m_wr_reg : n2797;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2799 = n2798[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2800 = n1403[25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2801 = n2798[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2802 = {n2800, n2801};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2803 = n2609 ? m_wr_reg : n2802;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2804 = n2803[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2805 = n1403[26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2806 = n2803[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2807 = {n2805, n2806};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2808 = n2610 ? m_wr_reg : n2807;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2809 = n2808[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2810 = n1403[27]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2811 = n2808[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2812 = {n2810, n2811};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2813 = n2611 ? m_wr_reg : n2812;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2814 = n2813[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2815 = n1403[28]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2816 = n2813[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2817 = {n2815, n2816};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2818 = n2612 ? m_wr_reg : n2817;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2819 = n2818[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2820 = n1403[29]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2821 = n2818[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2822 = {n2820, n2821};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2823 = n2613 ? m_wr_reg : n2822;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2824 = n2823[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2825 = n1403[30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2826 = n2823[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2827 = {n2825, n2826};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2828 = n2614 ? m_wr_reg : n2827;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2829 = n2828[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2830 = n1403[31]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2831 = n2828[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2832 = {n2830, n2831};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2833 = n2615 ? m_wr_reg : n2832;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2834 = n2833[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2835 = n1403[32]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2836 = n2833[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2837 = {n2835, n2836};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2838 = n2616 ? m_wr_reg : n2837;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2839 = n2838[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2840 = n1403[33]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2841 = n2838[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2842 = {n2840, n2841};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2843 = n2617 ? m_wr_reg : n2842;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2844 = n2843[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2845 = n1403[34]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2846 = n2843[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2847 = {n2845, n2846};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2848 = n2618 ? m_wr_reg : n2847;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2849 = n2848[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2850 = n1403[35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2851 = n2848[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2852 = {n2850, n2851};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2853 = n2619 ? m_wr_reg : n2852;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2854 = n2853[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2855 = n1403[36]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2856 = n2853[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2857 = {n2855, n2856};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2858 = n2620 ? m_wr_reg : n2857;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2859 = n2858[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2860 = n1403[37]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2861 = n2858[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2862 = {n2860, n2861};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2863 = n2621 ? m_wr_reg : n2862;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2864 = n2863[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2865 = n1403[38]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2866 = n2863[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2867 = {n2865, n2866};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2868 = n2622 ? m_wr_reg : n2867;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2869 = n2868[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2870 = n1403[39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2871 = n2868[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2872 = {n2870, n2871};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2873 = n2623 ? m_wr_reg : n2872;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2874 = n2873[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2875 = n1403[40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2876 = n2873[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2877 = {n2875, n2876};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2878 = n2624 ? m_wr_reg : n2877;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2879 = n2878[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2880 = n1403[41]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2881 = n2878[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2882 = {n2880, n2881};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2883 = n2625 ? m_wr_reg : n2882;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2884 = n2883[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2885 = n1403[42]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2886 = n2883[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2887 = {n2885, n2886};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2888 = n2626 ? m_wr_reg : n2887;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2889 = n2888[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2890 = n1403[43]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2891 = n2888[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2892 = {n2890, n2891};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2893 = n2627 ? m_wr_reg : n2892;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2894 = n2893[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2895 = n1403[44]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2896 = n2893[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2897 = {n2895, n2896};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2898 = n2628 ? m_wr_reg : n2897;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2899 = n2898[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2900 = n1403[45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2901 = n2898[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2902 = {n2900, n2901};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2903 = n2629 ? m_wr_reg : n2902;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2904 = n2903[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2905 = n1403[46]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2906 = n2903[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2907 = {n2905, n2906};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2908 = n2630 ? m_wr_reg : n2907;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2909 = n2908[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2910 = n1403[47]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2911 = n2908[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2912 = {n2910, n2911};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2913 = n2631 ? m_wr_reg : n2912;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2914 = n2913[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2915 = n1403[48]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2916 = n2913[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2917 = {n2915, n2916};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2918 = n2632 ? m_wr_reg : n2917;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2919 = n2918[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2920 = n1403[49]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2921 = n2918[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2922 = {n2920, n2921};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2923 = n2633 ? m_wr_reg : n2922;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2924 = n2923[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2925 = n1403[50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2926 = n2923[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2927 = {n2925, n2926};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2928 = n2634 ? m_wr_reg : n2927;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2929 = n2928[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2930 = n1403[51]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2931 = n2928[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2932 = {n2930, n2931};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2933 = n2635 ? m_wr_reg : n2932;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2934 = n2933[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2935 = n1403[52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2936 = n2933[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2937 = {n2935, n2936};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2938 = n2636 ? m_wr_reg : n2937;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2939 = n2938[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2940 = n1403[53]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2941 = n2938[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2942 = {n2940, n2941};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2943 = n2637 ? m_wr_reg : n2942;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2944 = n2943[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2945 = n1403[54]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2946 = n2943[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2947 = {n2945, n2946};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2948 = n2638 ? m_wr_reg : n2947;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2949 = n2948[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2950 = n1403[55]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2951 = n2948[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2952 = {n2950, n2951};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2953 = n2639 ? m_wr_reg : n2952;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2954 = n2953[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2955 = n1403[56]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2956 = n2953[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2957 = {n2955, n2956};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2958 = n2640 ? m_wr_reg : n2957;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2959 = n2958[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2960 = n1403[57]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2961 = n2958[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2962 = {n2960, n2961};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2963 = n2641 ? m_wr_reg : n2962;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2964 = n2963[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2965 = n1403[58]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2966 = n2963[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2967 = {n2965, n2966};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2968 = n2642 ? m_wr_reg : n2967;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2969 = n2968[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2970 = n1403[59]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2971 = n2968[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2972 = {n2970, n2971};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2973 = n2643 ? m_wr_reg : n2972;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2974 = n2973[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2975 = n1403[60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2976 = n2973[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2977 = {n2975, n2976};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2978 = n2644 ? m_wr_reg : n2977;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2979 = n2978[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2980 = n1403[61]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2981 = n2978[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2982 = {n2980, n2981};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2983 = n2645 ? m_wr_reg : n2982;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2984 = n2983[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2985 = n1403[62]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2986 = n2983[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2987 = {n2985, n2986};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2988 = n2646 ? m_wr_reg : n2987;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2989 = n2988[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2990 = n1403[63]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2991 = n2988[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2992 = {n2990, n2991};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2993 = n2647 ? m_wr_reg : n2992;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2994 = n2993[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2995 = n1403[64]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2996 = n2993[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2997 = {n2995, n2996};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2998 = n2648 ? m_wr_reg : n2997;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n2999 = n2998[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3000 = n1403[65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3001 = n2998[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3002 = {n3000, n3001};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3003 = n2649 ? m_wr_reg : n3002;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3004 = n3003[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3005 = n1403[66]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3006 = n3003[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3007 = {n3005, n3006};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3008 = n2650 ? m_wr_reg : n3007;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3009 = n3008[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3010 = n1403[67]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3011 = n3008[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3012 = {n3010, n3011};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3013 = n2651 ? m_wr_reg : n3012;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3014 = n3013[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3015 = n1403[68]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3016 = n3013[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3017 = {n3015, n3016};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3018 = n2652 ? m_wr_reg : n3017;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3019 = n3018[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3020 = n1403[69]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3021 = n3018[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3022 = {n3020, n3021};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3023 = n2653 ? m_wr_reg : n3022;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3024 = n3023[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3025 = n1403[70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3026 = n3023[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3027 = {n3025, n3026};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3028 = n2654 ? m_wr_reg : n3027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3029 = n3028[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3030 = n1403[71]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3031 = n3028[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3032 = {n3030, n3031};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3033 = n2655 ? m_wr_reg : n3032;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3034 = n3033[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3035 = n1403[72]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3036 = n3033[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3037 = {n3035, n3036};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3038 = n2656 ? m_wr_reg : n3037;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3039 = n3038[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3040 = n1403[73]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3041 = n3038[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3042 = {n3040, n3041};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3043 = n2657 ? m_wr_reg : n3042;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3044 = n3043[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3045 = n1403[74]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3046 = n3043[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3047 = {n3045, n3046};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3048 = n2658 ? m_wr_reg : n3047;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3049 = n3048[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3050 = n1403[75]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3051 = n3048[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3052 = {n3050, n3051};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3053 = n2659 ? m_wr_reg : n3052;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3054 = n3053[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3055 = n1403[76]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3056 = n3053[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3057 = {n3055, n3056};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3058 = n2660 ? m_wr_reg : n3057;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3059 = n3058[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3060 = n1403[77]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3061 = n3058[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3062 = {n3060, n3061};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3063 = n2661 ? m_wr_reg : n3062;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3064 = n3063[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3065 = n1403[78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3066 = n3063[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3067 = {n3065, n3066};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3068 = n2662 ? m_wr_reg : n3067;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3069 = n3068[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3070 = n1403[79]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3071 = n3068[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3072 = {n3070, n3071};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3073 = n2663 ? m_wr_reg : n3072;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3074 = n3073[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3075 = n1403[80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3076 = n3073[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3077 = {n3075, n3076};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3078 = n2664 ? m_wr_reg : n3077;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3079 = n3078[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3080 = n1403[81]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3081 = n3078[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3082 = {n3080, n3081};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3083 = n2665 ? m_wr_reg : n3082;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3084 = n3083[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3085 = n1403[82]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3086 = n3083[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3087 = {n3085, n3086};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3088 = n2666 ? m_wr_reg : n3087;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3089 = n3088[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3090 = n1403[83]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3091 = n3088[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3092 = {n3090, n3091};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3093 = n2667 ? m_wr_reg : n3092;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3094 = n3093[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3095 = n1403[84]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3096 = n3093[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3097 = {n3095, n3096};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3098 = n2668 ? m_wr_reg : n3097;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3099 = n3098[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3100 = n1403[85]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3101 = n3098[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3102 = {n3100, n3101};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3103 = n2669 ? m_wr_reg : n3102;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3104 = n3103[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3105 = n1403[86]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3106 = n3103[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3107 = {n3105, n3106};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3108 = n2670 ? m_wr_reg : n3107;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3109 = n3108[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3110 = n1403[87]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3111 = n3108[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3112 = {n3110, n3111};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3113 = n2671 ? m_wr_reg : n3112;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3114 = n3113[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3115 = n1403[88]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3116 = n3113[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3117 = {n3115, n3116};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3118 = n2672 ? m_wr_reg : n3117;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3119 = n3118[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3120 = n1403[89]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3121 = n3118[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3122 = {n3120, n3121};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3123 = n2673 ? m_wr_reg : n3122;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3124 = n3123[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3125 = n1403[90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3126 = n3123[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3127 = {n3125, n3126};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3128 = n2674 ? m_wr_reg : n3127;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3129 = n3128[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3130 = n1403[91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3131 = n3128[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3132 = {n3130, n3131};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3133 = n2675 ? m_wr_reg : n3132;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3134 = n3133[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3135 = n1403[92]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3136 = n3133[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3137 = {n3135, n3136};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3138 = n2676 ? m_wr_reg : n3137;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3139 = n3138[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3140 = n1403[93]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3141 = n3138[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3142 = {n3140, n3141};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3143 = n2677 ? m_wr_reg : n3142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3144 = n3143[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3145 = n1403[94]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3146 = n3143[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3147 = {n3145, n3146};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3148 = n2678 ? m_wr_reg : n3147;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3149 = n3148[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3150 = n1403[95]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3151 = n3148[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3152 = {n3150, n3151};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3153 = n2679 ? m_wr_reg : n3152;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3154 = n3153[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3155 = n1403[96]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3156 = n3153[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3157 = {n3155, n3156};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3158 = n2680 ? m_wr_reg : n3157;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3159 = n3158[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3160 = n1403[97]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3161 = n3158[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3162 = {n3160, n3161};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3163 = n2681 ? m_wr_reg : n3162;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3164 = n3163[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3165 = n1403[98]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3166 = n3163[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3167 = {n3165, n3166};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3168 = n2682 ? m_wr_reg : n3167;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3169 = n3168[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3170 = n1403[99]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3171 = n3168[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3172 = {n3170, n3171};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3173 = n2683 ? m_wr_reg : n3172;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3174 = n3173[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3175 = n1403[100]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3176 = n3173[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3177 = {n3175, n3176};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3178 = n2684 ? m_wr_reg : n3177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3179 = n3178[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3180 = n1403[101]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3181 = n3178[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3182 = {n3180, n3181};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3183 = n2685 ? m_wr_reg : n3182;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3184 = n3183[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3185 = n1403[102]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3186 = n3183[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3187 = {n3185, n3186};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3188 = n2686 ? m_wr_reg : n3187;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3189 = n3188[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3190 = n1403[103]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3191 = n3188[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3192 = {n3190, n3191};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3193 = n2687 ? m_wr_reg : n3192;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3194 = n3193[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3195 = n1403[104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3196 = n3193[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3197 = {n3195, n3196};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3198 = n2688 ? m_wr_reg : n3197;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3199 = n3198[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3200 = n1403[105]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3201 = n3198[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3202 = {n3200, n3201};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3203 = n2689 ? m_wr_reg : n3202;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3204 = n3203[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3205 = n1403[106]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3206 = n3203[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3207 = {n3205, n3206};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3208 = n2690 ? m_wr_reg : n3207;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3209 = n3208[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3210 = n1403[107]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3211 = n3208[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3212 = {n3210, n3211};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3213 = n2691 ? m_wr_reg : n3212;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3214 = n3213[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3215 = n1403[108]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3216 = n3213[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3217 = {n3215, n3216};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3218 = n2692 ? m_wr_reg : n3217;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3219 = n3218[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3220 = n1403[109]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3221 = n3218[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3222 = {n3220, n3221};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3223 = n2693 ? m_wr_reg : n3222;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3224 = n3223[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3225 = n1403[110]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3226 = n3223[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3227 = {n3225, n3226};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3228 = n2694 ? m_wr_reg : n3227;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3229 = n3228[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3230 = n1403[111]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3231 = n3228[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3232 = {n3230, n3231};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3233 = n2695 ? m_wr_reg : n3232;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3234 = n3233[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3235 = n1403[112]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3236 = n3233[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3237 = {n3235, n3236};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3238 = n2696 ? m_wr_reg : n3237;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3239 = n3238[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3240 = n1403[113]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3241 = n3238[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3242 = {n3240, n3241};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3243 = n2697 ? m_wr_reg : n3242;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3244 = n3243[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3245 = n1403[114]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3246 = n3243[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3247 = {n3245, n3246};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3248 = n2698 ? m_wr_reg : n3247;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3249 = n3248[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3250 = n1403[115]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3251 = n3248[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3252 = {n3250, n3251};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3253 = n2699 ? m_wr_reg : n3252;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3254 = n3253[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3255 = n1403[116]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3256 = n3253[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3257 = {n3255, n3256};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3258 = n2700 ? m_wr_reg : n3257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3259 = n3258[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3260 = n1403[117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3261 = n3258[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3262 = {n3260, n3261};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3263 = n2701 ? m_wr_reg : n3262;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3264 = n3263[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3265 = n1403[118]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3266 = n3263[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3267 = {n3265, n3266};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3268 = n2702 ? m_wr_reg : n3267;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3269 = n3268[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3270 = n1403[119]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3271 = n3268[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3272 = {n3270, n3271};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3273 = n2703 ? m_wr_reg : n3272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3274 = n3273[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3275 = n1403[120]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3276 = n3273[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3277 = {n3275, n3276};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3278 = n2704 ? m_wr_reg : n3277;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3279 = n3278[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3280 = n1403[121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3281 = n3278[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3282 = {n3280, n3281};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3283 = n2705 ? m_wr_reg : n3282;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3284 = n3283[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3285 = n1403[122]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3286 = n3283[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3287 = {n3285, n3286};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3288 = n2706 ? m_wr_reg : n3287;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3289 = n3288[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3290 = n1403[123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3291 = n3288[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3292 = {n3290, n3291};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3293 = n2707 ? m_wr_reg : n3292;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3294 = n3293[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3295 = n1403[124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3296 = n3293[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3297 = {n3295, n3296};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3298 = n2708 ? m_wr_reg : n3297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3299 = n3298[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3300 = n1403[125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3301 = n3298[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3302 = {n3300, n3301};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3303 = n2709 ? m_wr_reg : n3302;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3304 = n3303[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3305 = n1403[126]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3306 = n3303[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3307 = {n3305, n3306};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3308 = n2710 ? m_wr_reg : n3307;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3309 = n3308[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3310 = n1403[127]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3311 = n3308[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3312 = {n3310, n3311};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3313 = n2711 ? m_wr_reg : n3312;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:907:33 */
  assign n3314 = {n3313, n3309, n3304, n3299, n3294, n3289, n3284, n3279, n3274, n3269, n3264, n3259, n3254, n3249, n3244, n3239, n3234, n3229, n3224, n3219, n3214, n3209, n3204, n3199, n3194, n3189, n3184, n3179, n3174, n3169, n3164, n3159, n3154, n3149, n3144, n3139, n3134, n3129, n3124, n3119, n3114, n3109, n3104, n3099, n3094, n3089, n3084, n3079, n3074, n3069, n3064, n3059, n3054, n3049, n3044, n3039, n3034, n3029, n3024, n3019, n3014, n3009, n3004, n2999, n2994, n2989, n2984, n2979, n2974, n2969, n2964, n2959, n2954, n2949, n2944, n2939, n2934, n2929, n2924, n2919, n2914, n2909, n2904, n2899, n2894, n2889, n2884, n2879, n2874, n2869, n2864, n2859, n2854, n2849, n2844, n2839, n2834, n2829, n2824, n2819, n2814, n2809, n2804, n2799, n2794, n2789, n2784, n2779, n2774, n2769, n2764, n2759, n2754, n2749, n2744, n2739, n2734, n2729, n2724, n2719, n2714};
endmodule

