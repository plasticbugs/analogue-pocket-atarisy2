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
  wire n86;
  wire n87;
  localparam n89 = 1'b1;
  localparam n90 = 1'b1;
  localparam n91 = 1'b1;
  localparam n92 = 1'b1;
  localparam n93 = 1'b1;
  localparam n94 = 1'b1;
  wire n95;
  wire n96;
  localparam n97 = 1'b1;
  wire [31:0] n99;
  wire n101;
  wire n102;
  wire [31:0] n105;
  wire n107;
  wire n108;
  wire [1:0] n113;
  wire n115;
  wire [31:0] n116;
  wire n118;
  wire [31:0] n119;
  wire [31:0] n121;
  wire [4:0] n122;
  wire [4:0] n124;
  wire [31:0] n125;
  wire n127;
  wire [31:0] n128;
  wire n130;
  wire n131;
  wire n132;
  wire [31:0] n135;
  wire n137;
  wire n138;
  wire [31:0] n139;
  wire n141;
  wire n142;
  wire [31:0] n143;
  wire n145;
  wire [31:0] n146;
  wire [31:0] n148;
  wire [2:0] n149;
  wire [2:0] n151;
  wire [31:0] n152;
  wire n154;
  wire n155;
  wire [31:0] n156;
  wire [31:0] n158;
  wire [3:0] n159;
  wire [3:0] n160;
  wire [3:0] n163;
  wire n164;
  wire n167;
  wire n168;
  wire n169;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire n182;
  wire n183;
  wire n184;
  wire n185;
  wire n186;
  wire n187;
  wire n188;
  wire n189;
  wire n190;
  wire n191;
  wire n195;
  wire n196;
  wire [31:0] n197;
  wire n199;
  wire [12:0] n200;
  wire [13:0] n202;
  wire n205;
  wire [13:0] n206;
  wire n212;
  wire n213;
  wire n214;
  wire n215;
  wire n218;
  wire n219;
  wire n220;
  wire [31:0] n221;
  wire n223;
  wire [31:0] n224;
  wire [31:0] n226;
  wire [4:0] n227;
  wire [31:0] n228;
  wire n230;
  wire [31:0] n231;
  wire n233;
  wire n234;
  wire [4:0] n237;
  wire n240;
  wire n242;
  wire [4:0] n243;
  wire n245;
  wire n246;
  wire [4:0] n247;
  wire n249;
  wire n250;
  wire [4:0] n252;
  wire n254;
  wire n255;
  wire n257;
  wire [4:0] n259;
  wire n261;
  wire n263;
  wire n265;
  wire n277;
  wire n279;
  wire n281;
  wire n287;
  wire n288;
  wire n289;
  wire n290;
  wire n291;
  wire n292;
  wire n293;
  wire n294;
  wire n295;
  wire n297;
  wire n299;
  wire n312;
  wire n313;
  wire [11:0] n314;
  wire n315;
  wire n316;
  wire n317;
  wire n318;
  wire n319;
  wire n320;
  wire n321;
  wire [12:0] n322;
  wire [12:0] n323;
  wire [12:0] n325;
  wire [31:0] n331;
  wire n333;
  wire n334;
  wire [31:0] n335;
  wire n337;
  wire n338;
  wire [31:0] n339;
  wire n341;
  wire n342;
  wire n343;
  wire n344;
  wire n345;
  wire n346;
  wire [31:0] n347;
  wire n349;
  wire n350;
  wire [31:0] n351;
  wire n353;
  wire n354;
  wire [31:0] n355;
  wire n357;
  wire n358;
  wire n359;
  wire n360;
  wire n361;
  wire n363;
  wire n365;
  wire n367;
  wire [31:0] n368;
  wire n370;
  wire n371;
  wire [31:0] n372;
  wire [31:0] n374;
  wire [31:0] n375;
  wire n376;
  wire n377;
  wire n378;
  wire [31:0] n379;
  wire [31:0] n381;
  wire [8:0] n382;
  wire [8:0] n384;
  wire n386;
  wire n388;
  wire n389;
  wire n395;
  wire n396;
  wire n397;
  wire n398;
  wire [1:0] n399;
  wire [2:0] n400;
  wire [7:0] n402;
  wire n405;
  wire n408;
  wire [7:0] n410;
  wire n413;
  wire n416;
  wire n419;
  wire [31:0] n427;
  wire n429;
  wire n430;
  wire n431;
  wire n432;
  wire n433;
  wire [13:0] n436;
  wire [31:0] n437;
  wire n439;
  wire [5:0] n440;
  wire [13:0] n446;
  wire [13:0] n448;
  wire [13:0] n449;
  wire n451;
  wire n456;
  wire n457;
  wire [31:0] n458;
  wire n460;
  wire n461;
  wire [31:0] n462;
  wire n464;
  wire n465;
  wire [31:0] n466;
  wire n468;
  wire n469;
  wire n470;
  wire n471;
  wire n472;
  wire n473;
  wire n474;
  wire n475;
  wire n476;
  wire n478;
  wire n480;
  wire n482;
  wire n488;
  wire n489;
  wire n490;
  wire n491;
  wire n492;
  wire n493;
  wire n494;
  wire n495;
  wire n496;
  wire [31:0] n497;
  wire n499;
  wire n500;
  wire [31:0] n501;
  wire n503;
  wire n504;
  wire [31:0] n505;
  wire n507;
  wire n508;
  wire n509;
  wire n510;
  wire n511;
  wire [31:0] n512;
  wire n514;
  wire n517;
  wire [31:0] n518;
  wire n520;
  wire n523;
  wire n524;
  wire n525;
  wire n527;
  wire n529;
  wire [31:0] n537;
  wire n539;
  wire n540;
  wire [31:0] n541;
  wire n543;
  wire n544;
  wire [31:0] n545;
  wire n547;
  wire n548;
  wire n549;
  wire n550;
  wire n551;
  wire n552;
  wire n553;
  wire n555;
  wire [31:0] n556;
  wire n558;
  wire [31:0] n559;
  wire n561;
  wire n562;
  wire n563;
  wire n564;
  wire n566;
  wire n567;
  wire n568;
  wire n570;
  wire n572;
  wire [31:0] n580;
  wire n582;
  wire n583;
  wire n584;
  wire n585;
  wire n586;
  wire n587;
  wire n588;
  wire [31:0] n589;
  wire n591;
  wire n592;
  wire [31:0] n593;
  wire [31:0] n599;
  wire [31:0] n600;
  wire [31:0] n601;
  wire [11:0] n602;
  wire [30:0] n608;
  wire [11:0] n609;
  wire [31:0] n610;
  wire [31:0] n611;
  wire [13:0] n612;
  wire [13:0] n613;
  wire [13:0] n615;
  wire n617;
  wire n618;
  wire [31:0] n619;
  wire n621;
  wire n622;
  wire [31:0] n623;
  wire [5:0] n624;
  wire [31:0] n630;
  wire [31:0] n631;
  wire [31:0] n632;
  wire [11:0] n633;
  wire [30:0] n638;
  wire [11:0] n639;
  wire [31:0] n640;
  wire [31:0] n641;
  wire [13:0] n642;
  wire [13:0] n643;
  wire [13:0] n645;
  wire n647;
  wire n648;
  wire [31:0] n649;
  wire n651;
  wire n652;
  wire [31:0] n653;
  wire [31:0] n655;
  wire [3:0] n656;
  wire [3:0] n658;
  wire [31:0] n660;
  wire [31:0] n662;
  wire [3:0] n663;
  wire [3:0] n665;
  wire [31:0] n668;
  wire [31:0] n669;
  wire [31:0] n671;
  wire [3:0] n672;
  wire [3:0] n674;
  wire [31:0] n676;
  wire [31:0] n678;
  wire [3:0] n679;
  wire [3:0] n681;
  wire [4:0] n685;
  wire [31:0] n690;
  wire [31:0] n691;
  wire [31:0] n693;
  wire [3:0] n694;
  wire [3:0] n696;
  wire [31:0] n699;
  wire [31:0] n700;
  wire [11:0] n701;
  wire [30:0] n706;
  wire [11:0] n707;
  wire [31:0] n708;
  wire [31:0] n709;
  wire [9:0] n710;
  wire [99:0] n712;
  wire n715;
  wire n716;
  wire n717;
  wire [31:0] n718;
  wire [31:0] n720;
  wire [3:0] n721;
  wire [3:0] n723;
  wire n727;
  wire [31:0] n728;
  wire n730;
  wire n731;
  wire [31:0] n732;
  wire [31:0] n734;
  wire [3:0] n735;
  wire [3:0] n737;
  wire [31:0] n739;
  wire [31:0] n741;
  wire [3:0] n742;
  wire [3:0] n744;
  wire [31:0] n747;
  wire [31:0] n748;
  wire [31:0] n750;
  wire [3:0] n751;
  wire [3:0] n753;
  wire [31:0] n755;
  wire [31:0] n757;
  wire [3:0] n758;
  wire [3:0] n760;
  wire [4:0] n764;
  wire [31:0] n768;
  wire [31:0] n769;
  wire [31:0] n771;
  wire [3:0] n772;
  wire [3:0] n774;
  wire [31:0] n777;
  wire [31:0] n778;
  wire [11:0] n779;
  wire [30:0] n784;
  wire [11:0] n785;
  wire [31:0] n786;
  wire [31:0] n787;
  wire [9:0] n788;
  wire [99:0] n790;
  wire [99:0] n791;
  wire n794;
  wire n795;
  wire n796;
  wire [3:0] n797;
  reg [13:0] n798;
  reg [13:0] n799;
  reg [99:0] n800;
  wire [13:0] n801;
  wire [13:0] n802;
  wire [99:0] n803;
  wire [13:0] n805;
  wire [13:0] n807;
  wire [99:0] n808;
  wire n818;
  wire n819;
  wire n820;
  wire [31:0] n821;
  wire [31:0] n822;
  wire [31:0] n823;
  wire [21:0] n824;
  wire [21:0] n826;
  wire [12:0] n828;
  wire n830;
  wire [12:0] n831;
  wire [31:0] n832;
  wire [9:0] n833;
  wire [31:0] n834;
  wire [12:0] n835;
  wire [31:0] n836;
  wire [31:0] n837;
  wire [21:0] n838;
  wire [21:0] n840;
  wire [31:0] n841;
  wire [31:0] n842;
  wire [12:0] n843;
  wire n845;
  wire [12:0] n846;
  wire [31:0] n847;
  wire [9:0] n848;
  wire [31:0] n849;
  wire [12:0] n850;
  wire [31:0] n851;
  wire [31:0] n852;
  wire [21:0] n853;
  wire [21:0] n855;
  wire [31:0] n856;
  wire [31:0] n857;
  wire [12:0] n858;
  wire n860;
  wire [12:0] n861;
  wire [31:0] n862;
  wire [9:0] n863;
  wire [31:0] n864;
  wire [12:0] n865;
  wire [31:0] n866;
  wire [31:0] n867;
  wire [21:0] n868;
  wire [21:0] n870;
  wire [31:0] n871;
  wire [31:0] n872;
  wire [12:0] n873;
  wire [12:0] n874;
  wire [31:0] n875;
  wire [9:0] n876;
  wire [31:0] n877;
  wire [12:0] n878;
  wire [31:0] n879;
  wire [31:0] n880;
  wire [21:0] n881;
  wire [21:0] n883;
  wire [31:0] n884;
  wire [31:0] n885;
  wire [12:0] n886;
  wire n888;
  wire [12:0] n889;
  wire [31:0] n890;
  wire [9:0] n891;
  wire [31:0] n892;
  wire [12:0] n893;
  wire [31:0] n894;
  wire [31:0] n895;
  wire [21:0] n896;
  wire [21:0] n898;
  wire [31:0] n899;
  wire [31:0] n900;
  wire [12:0] n901;
  wire [12:0] n902;
  wire [31:0] n903;
  wire [9:0] n904;
  wire [31:0] n905;
  wire [12:0] n906;
  wire [31:0] n907;
  wire [31:0] n908;
  wire [21:0] n909;
  wire [21:0] n911;
  wire [31:0] n912;
  wire [31:0] n913;
  wire [12:0] n914;
  wire n916;
  wire [12:0] n917;
  wire [31:0] n918;
  wire [9:0] n919;
  wire [31:0] n920;
  wire [12:0] n921;
  wire [31:0] n922;
  wire [31:0] n923;
  wire [21:0] n924;
  wire [21:0] n926;
  wire [31:0] n927;
  wire [31:0] n928;
  wire [12:0] n929;
  wire [12:0] n930;
  wire [31:0] n931;
  wire [9:0] n932;
  wire [31:0] n933;
  wire [12:0] n934;
  wire [31:0] n935;
  wire [31:0] n936;
  wire [21:0] n937;
  wire [21:0] n939;
  wire [31:0] n940;
  wire [31:0] n941;
  wire [12:0] n942;
  wire n944;
  wire [12:0] n945;
  wire [31:0] n946;
  wire [9:0] n947;
  wire [31:0] n948;
  wire [12:0] n949;
  wire [31:0] n950;
  wire [31:0] n951;
  wire [21:0] n952;
  wire [21:0] n954;
  wire [31:0] n955;
  wire [31:0] n956;
  wire [12:0] n957;
  wire [12:0] n958;
  wire [31:0] n959;
  wire [9:0] n960;
  wire [31:0] n961;
  wire [12:0] n962;
  wire [31:0] n963;
  wire [31:0] n964;
  wire [21:0] n965;
  wire [21:0] n967;
  wire [31:0] n968;
  wire [31:0] n969;
  wire [12:0] n970;
  wire n972;
  wire [12:0] n973;
  wire [31:0] n974;
  wire [9:0] n975;
  wire [31:0] n976;
  wire [12:0] n977;
  wire [31:0] n978;
  wire [31:0] n979;
  wire [21:0] n980;
  wire [21:0] n982;
  wire [31:0] n983;
  wire [31:0] n984;
  wire [12:0] n985;
  wire [12:0] n986;
  wire [31:0] n987;
  wire [9:0] n988;
  wire [31:0] n989;
  wire [12:0] n990;
  wire [31:0] n991;
  wire [31:0] n992;
  wire [21:0] n993;
  wire [21:0] n995;
  wire [31:0] n996;
  wire [31:0] n997;
  wire [12:0] n998;
  wire n1000;
  wire [12:0] n1001;
  wire [31:0] n1002;
  wire [9:0] n1003;
  wire [31:0] n1004;
  wire [12:0] n1005;
  wire [31:0] n1006;
  wire [31:0] n1007;
  wire [21:0] n1008;
  wire [21:0] n1010;
  wire [31:0] n1011;
  wire [31:0] n1012;
  wire [12:0] n1013;
  wire [12:0] n1014;
  wire [31:0] n1015;
  wire [9:0] n1016;
  wire [31:0] n1017;
  wire [12:0] n1018;
  wire [31:0] n1019;
  wire [31:0] n1020;
  wire [21:0] n1021;
  wire [21:0] n1023;
  wire [31:0] n1024;
  wire [31:0] n1025;
  wire [12:0] n1026;
  wire n1028;
  wire [12:0] n1029;
  wire [31:0] n1030;
  wire [9:0] n1031;
  wire [31:0] n1032;
  wire [12:0] n1033;
  wire [31:0] n1034;
  wire [31:0] n1035;
  wire [21:0] n1036;
  wire [21:0] n1038;
  wire [31:0] n1039;
  wire [31:0] n1040;
  wire [12:0] n1041;
  wire [12:0] n1042;
  wire [31:0] n1043;
  wire [9:0] n1044;
  wire [31:0] n1045;
  wire [12:0] n1046;
  wire [31:0] n1047;
  wire [31:0] n1048;
  wire [21:0] n1049;
  wire [21:0] n1051;
  wire [31:0] n1052;
  wire [31:0] n1053;
  wire [12:0] n1054;
  wire n1056;
  wire [12:0] n1057;
  wire [31:0] n1058;
  wire [9:0] n1059;
  wire [31:0] n1060;
  wire [12:0] n1061;
  wire [31:0] n1062;
  wire [31:0] n1063;
  wire [21:0] n1064;
  wire [21:0] n1066;
  wire [31:0] n1067;
  wire [31:0] n1068;
  wire [12:0] n1069;
  wire [12:0] n1070;
  wire [31:0] n1071;
  wire [9:0] n1072;
  wire [31:0] n1073;
  wire [12:0] n1074;
  wire [31:0] n1075;
  wire [31:0] n1076;
  wire [21:0] n1077;
  wire [21:0] n1079;
  wire [31:0] n1080;
  wire [31:0] n1081;
  wire [12:0] n1082;
  wire n1084;
  wire [12:0] n1085;
  wire [31:0] n1086;
  wire [9:0] n1087;
  wire [31:0] n1088;
  wire [12:0] n1089;
  wire [31:0] n1090;
  wire [31:0] n1091;
  wire [21:0] n1092;
  wire [21:0] n1094;
  wire [31:0] n1095;
  wire [31:0] n1096;
  wire [12:0] n1097;
  wire [12:0] n1098;
  wire [12:0] n1099;
  wire [13:0] n1100;
  wire n1102;
  wire [11:0] n1103;
  wire [12:0] n1104;
  reg [12:0] n1105;
  wire [12:0] n1106;
  reg [12:0] n1107;
  wire [12:0] n1108;
  reg [12:0] n1109;
  wire [12:0] n1110;
  reg [12:0] n1111;
  wire [12:0] n1112;
  reg [12:0] n1113;
  wire [12:0] n1114;
  reg [12:0] n1115;
  wire [12:0] n1116;
  reg [12:0] n1117;
  wire [12:0] n1118;
  reg [12:0] n1119;
  wire [12:0] n1120;
  reg [12:0] n1121;
  wire [12:0] n1122;
  reg [12:0] n1123;
  wire [12:0] n1124;
  reg [12:0] n1125;
  wire [12:0] n1126;
  reg [12:0] n1127;
  wire [12:0] n1128;
  reg [12:0] n1129;
  wire [12:0] n1130;
  reg [12:0] n1131;
  wire [12:0] n1132;
  reg [12:0] n1133;
  wire [12:0] n1134;
  reg [12:0] n1135;
  wire [12:0] n1136;
  reg [12:0] n1137;
  wire [12:0] n1138;
  reg [12:0] n1139;
  wire [12:0] n1140;
  reg [12:0] n1141;
  wire [12:0] n1142;
  reg [12:0] n1143;
  wire [12:0] n1144;
  reg [12:0] n1145;
  reg [13:0] n1146;
  reg [13:0] n1147;
  wire [142:0] n1148;
  wire [142:0] n1149;
  wire [129:0] n1150;
  wire [129:0] n1151;
  wire [13:0] n1152;
  wire [13:0] n1153;
  wire [142:0] n1155;
  wire [129:0] n1157;
  wire [13:0] n1159;
  wire [13:0] n1160;
  wire n1172;
  wire n1173;
  wire n1174;
  wire n1175;
  wire [2:0] n1176;
  wire n1178;
  wire n1180;
  wire n1182;
  wire n1184;
  wire n1186;
  wire n1188;
  wire n1190;
  wire n1192;
  wire [7:0] n1193;
  reg n1196;
  reg n1199;
  reg n1202;
  wire n1204;
  wire n1207;
  wire n1210;
  wire n1215;
  wire n1216;
  wire n1217;
  wire n1224;
  wire n1225;
  wire n1226;
  wire n1228;
  wire n1230;
  wire [31:0] n1238;
  wire n1240;
  wire n1241;
  wire [31:0] n1242;
  wire n1244;
  wire n1245;
  wire [31:0] n1246;
  wire n1248;
  wire n1249;
  wire n1250;
  wire n1251;
  wire n1252;
  wire n1253;
  wire n1254;
  wire [31:0] n1255;
  wire n1257;
  wire n1258;
  wire [31:0] n1259;
  wire n1261;
  wire n1262;
  wire n1263;
  wire [31:0] n1264;
  wire n1266;
  wire n1267;
  wire n1268;
  wire [31:0] n1269;
  wire n1271;
  wire n1272;
  wire n1273;
  wire n1276;
  wire n1277;
  wire n1279;
  wire n1285;
  wire n1287;
  wire n1288;
  wire n1289;
  wire n1290;
  wire n1291;
  wire n1292;
  wire [31:0] n1293;
  wire n1295;
  wire n1296;
  wire [31:0] n1297;
  wire n1299;
  wire n1300;
  wire n1301;
  wire n1303;
  wire n1305;
  wire [31:0] n1306;
  wire n1308;
  wire n1309;
  wire [31:0] n1310;
  wire n1312;
  wire n1313;
  wire [31:0] n1314;
  wire n1316;
  wire n1317;
  wire n1318;
  wire n1319;
  wire n1320;
  wire n1321;
  wire [31:0] n1322;
  wire n1324;
  wire [31:0] n1325;
  wire n1327;
  wire n1328;
  wire [31:0] n1329;
  wire n1331;
  wire n1332;
  wire n1335;
  wire n1337;
  wire n1338;
  wire n1346;
  wire n1348;
  wire n1349;
  wire n1350;
  wire n1351;
  wire n1352;
  wire n1353;
  wire n1354;
  wire n1355;
  wire n1356;
  wire [1:0] n1357;
  wire n1358;
  wire [2:0] n1359;
  wire n1360;
  wire [3:0] n1361;
  wire n1362;
  wire [4:0] n1363;
  wire n1364;
  wire [5:0] n1365;
  wire n1366;
  wire [6:0] n1367;
  wire n1368;
  wire [7:0] n1369;
  wire [7:0] n1370;
  wire n1371;
  wire n1373;
  wire [7:0] n1375;
  wire n1376;
  wire [7:0] n1377;
  wire [127:0] n1379;
  wire n1380;
  wire n1382;
  wire n1383;
  wire n1384;
  wire n1385;
  wire n1386;
  wire n1387;
  wire [31:0] n1388;
  wire n1390;
  wire n1391;
  wire [31:0] n1392;
  wire n1394;
  wire n1395;
  wire n1396;
  wire [31:0] n1397;
  wire n1399;
  wire n1400;
  wire [31:0] n1401;
  wire n1403;
  wire n1404;
  wire n1405;
  wire n1406;
  wire n1407;
  wire n1408;
  wire [31:0] n1409;
  wire n1411;
  wire [31:0] n1412;
  wire [31:0] n1414;
  wire [7:0] n1415;
  wire [123:0] n1416;
  wire [127:0] n1418;
  wire [3:0] n1419;
  wire [3:0] n1421;
  wire n1423;
  wire [3:0] n1424;
  wire n1426;
  wire n1428;
  wire n1430;
  wire n1433;
  wire n1434;
  wire n1436;
  wire n1437;
  wire [7:0] n1438;
  wire [3:0] n1439;
  wire n1442;
  wire n1443;
  wire n1444;
  wire n1445;
  wire [127:0] n1446;
  wire n1448;
  wire n1449;
  wire n1450;
  wire n1451;
  wire [31:0] n1452;
  wire n1454;
  wire [31:0] n1455;
  wire [31:0] n1457;
  wire [31:0] n1459;
  wire [7:0] n1460;
  wire [120:0] n1461;
  wire [127:0] n1463;
  wire n1464;
  wire [5:0] n1465;
  wire [6:0] n1467;
  wire [5:0] n1468;
  wire n1470;
  wire n1472;
  wire n1474;
  wire [7:0] n1475;
  wire [6:0] n1476;
  wire n1479;
  wire n1480;
  wire n1481;
  wire n1482;
  wire [127:0] n1483;
  wire n1484;
  wire n1485;
  wire n1487;
  wire n1488;
  wire n1489;
  wire n1490;
  wire n1491;
  wire n1493;
  wire n1494;
  wire n1495;
  wire n1496;
  wire [31:0] n1497;
  wire [31:0] n1498;
  wire [31:0] n1500;
  wire [3:0] n1501;
  wire [31:0] n1507;
  wire [31:0] n1509;
  wire n1510;
  wire [31:0] n1511;
  wire [31:0] n1512;
  wire [31:0] n1514;
  wire [3:0] n1515;
  wire [31:0] n1520;
  wire [31:0] n1521;
  wire [7:0] n1522;
  wire [31:0] n1523;
  wire [31:0] n1525;
  wire [3:0] n1526;
  wire [122:0] n1531;
  wire [127:0] n1533;
  wire [31:0] n1534;
  wire [31:0] n1536;
  wire [3:0] n1537;
  wire [3:0] n1539;
  wire [4:0] n1541;
  wire n1545;
  wire [123:0] n1546;
  wire [127:0] n1548;
  wire [31:0] n1549;
  wire [31:0] n1551;
  wire [3:0] n1552;
  wire [3:0] n1554;
  wire [3:0] n1556;
  wire [4:0] n1558;
  wire n1561;
  wire [124:0] n1562;
  wire [127:0] n1564;
  wire [31:0] n1565;
  wire [31:0] n1567;
  wire [3:0] n1568;
  wire [3:0] n1570;
  wire [2:0] n1572;
  wire [4:0] n1574;
  wire [1:0] n1576;
  reg [49:0] n1577;
  reg [127:0] n1578;
  wire [7:0] n1579;
  wire [49:0] n1580;
  wire n1583;
  wire [127:0] n1584;
  wire n1585;
  wire n1586;
  wire n1588;
  wire n1589;
  wire n1592;
  wire n1593;
  wire n1594;
  wire n1595;
  wire n1596;
  wire [31:0] n1597;
  wire [31:0] n1598;
  wire [31:0] n1600;
  wire [3:0] n1601;
  wire [31:0] n1606;
  wire [31:0] n1608;
  wire n1609;
  wire [31:0] n1610;
  wire [31:0] n1611;
  wire [31:0] n1613;
  wire [3:0] n1614;
  wire [31:0] n1619;
  wire [31:0] n1620;
  wire [7:0] n1621;
  wire [31:0] n1622;
  wire [31:0] n1624;
  wire [3:0] n1625;
  wire [122:0] n1630;
  wire [127:0] n1632;
  wire [31:0] n1633;
  wire [31:0] n1635;
  wire [3:0] n1636;
  wire [3:0] n1638;
  wire [4:0] n1640;
  wire n1644;
  wire [123:0] n1645;
  wire [127:0] n1647;
  wire [31:0] n1648;
  wire [31:0] n1650;
  wire [3:0] n1651;
  wire [3:0] n1653;
  wire [3:0] n1655;
  wire [4:0] n1657;
  wire n1660;
  wire [124:0] n1661;
  wire [127:0] n1663;
  wire [31:0] n1664;
  wire [31:0] n1666;
  wire [3:0] n1667;
  wire [3:0] n1669;
  wire [2:0] n1671;
  wire [4:0] n1673;
  wire [1:0] n1675;
  reg [49:0] n1676;
  reg [127:0] n1677;
  wire [7:0] n1678;
  wire [49:0] n1679;
  wire n1682;
  wire [127:0] n1683;
  wire n1684;
  wire n1685;
  wire n1687;
  wire n1688;
  wire n1691;
  wire n1692;
  wire n1693;
  wire [4:0] n1694;
  wire [4:0] n1695;
  wire [4:0] n1696;
  wire [4:0] n1697;
  wire [4:0] n1698;
  wire [4:0] n1699;
  wire [4:0] n1700;
  wire [4:0] n1701;
  wire [4:0] n1702;
  wire [4:0] n1703;
  wire n1705;
  wire [4:0] n1706;
  reg [7:0] n1707;
  reg [3:0] n1708;
  reg [6:0] n1709;
  wire [4:0] n1710;
  reg [4:0] n1711;
  wire [4:0] n1712;
  reg [4:0] n1713;
  wire [4:0] n1714;
  reg [4:0] n1715;
  wire [4:0] n1716;
  reg [4:0] n1717;
  wire [4:0] n1718;
  reg [4:0] n1719;
  wire [4:0] n1720;
  reg [4:0] n1721;
  wire [4:0] n1722;
  reg [4:0] n1723;
  wire [4:0] n1724;
  reg [4:0] n1725;
  wire [4:0] n1726;
  reg [4:0] n1727;
  wire [4:0] n1728;
  reg [4:0] n1729;
  reg [3:0] n1730;
  reg [6:0] n1731;
  reg [49:0] n1732;
  reg n1734;
  reg n1736;
  reg n1738;
  reg n1739;
  reg n1741;
  reg n1743;
  reg [127:0] n1744;
  wire [6:0] n1751;
  wire [6:0] n1753;
  wire [31:0] n1756;
  wire [31:0] n1758;
  wire [7:0] n1759;
  wire [7:0] n1760;
  wire n1762;
  wire [127:0] n1763;
  wire [7:0] n1764;
  wire [3:0] n1765;
  wire [6:0] n1766;
  wire [49:0] n1767;
  wire [49:0] n1768;
  wire [3:0] n1769;
  wire [6:0] n1770;
  wire [49:0] n1771;
  wire n1773;
  wire n1774;
  wire n1775;
  wire n1776;
  wire n1777;
  wire n1778;
  wire n1779;
  wire [127:0] n1780;
  wire [7:0] n1781;
  wire [3:0] n1783;
  wire [6:0] n1785;
  wire [49:0] n1787;
  wire [3:0] n1788;
  wire [6:0] n1789;
  wire [49:0] n1791;
  wire n1793;
  wire n1795;
  wire n1796;
  wire n1797;
  wire n1798;
  wire n1799;
  wire n1800;
  wire [127:0] n1801;
  wire [3:0] n1837;
  wire [2:0] n1838;
  reg [2:0] n1839;
  wire [3:0] n1840;
  reg [3:0] n1841;
  wire [4:0] n1842;
  reg [4:0] n1843;
  wire [7:0] n1844;
  reg [7:0] n1845;
  wire [8:0] n1846;
  reg [8:0] n1847;
  wire [3:0] n1848;
  reg [3:0] n1849;
  wire [6:0] n1850;
  reg [6:0] n1851;
  wire [49:0] n1852;
  reg [49:0] n1853;
  wire [3:0] n1854;
  reg [3:0] n1855;
  wire [6:0] n1856;
  reg [6:0] n1857;
  wire [49:0] n1858;
  reg [49:0] n1859;
  wire [142:0] n1860;
  reg [142:0] n1861;
  wire [129:0] n1862;
  reg [129:0] n1863;
  wire [4:0] n1864;
  reg [4:0] n1865;
  wire n1866;
  reg n1867;
  wire n1868;
  reg n1869;
  wire n1870;
  reg n1871;
  wire n1872;
  reg n1873;
  wire n1874;
  reg n1875;
  wire n1876;
  reg n1877;
  wire n1878;
  reg n1879;
  wire n1880;
  reg n1881;
  wire n1882;
  reg n1883;
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
  wire [1:0] n1938;
  reg [1:0] n1939;
  wire [7:0] n1940;
  reg [7:0] n1941;
  wire [7:0] n1942;
  reg [7:0] n1943;
  wire [13:0] n1944;
  reg [13:0] n1945;
  wire [12:0] n1946;
  reg [12:0] n1947;
  wire [13:0] n1948;
  reg [13:0] n1949;
  wire [13:0] n1950;
  reg [13:0] n1951;
  wire [13:0] n1952;
  reg [13:0] n1953;
  wire [13:0] n1954;
  reg [13:0] n1955;
  wire [13:0] n1956;
  reg [13:0] n1957;
  wire [99:0] n1958;
  reg [99:0] n1959;
  wire [127:0] n1960;
  reg [127:0] n1961;
  wire [6:0] n1964; // mem_rd
  wire [6:0] n1967; // mem_rd
  wire [1:0] n1970; // mem_rd
  wire [1:0] n1971; // mem_rd
  wire [1:0] n1972; // mem_rd
  wire [1:0] n1973; // mem_rd
  wire [7:0] n1976; // mem_rd
  wire [8:0] n1978;
  wire [9:0] n1979; // mem_rd
  wire [8:0] n1980;
  wire [9:0] n1981; // mem_rd
  wire [2:0] n1984; // mem_rd
  wire [2:0] n1985; // mem_rd
  wire [2:0] n1986; // mem_rd
  wire [2:0] n1987; // mem_rd
  wire [2:0] n1988; // mem_rd
  wire [2:0] n1989; // mem_rd
  wire [159:0] n1991;
  wire [9:0] n1992;
  wire [79:0] n1994;
  wire [4:0] n1995;
  wire [159:0] n1997;
  wire [9:0] n1998;
  wire n1999;
  wire n2000;
  wire n2001;
  wire n2002;
  wire n2003;
  wire n2004;
  wire n2005;
  wire n2006;
  wire n2007;
  wire n2008;
  wire n2009;
  wire n2010;
  wire n2011;
  wire n2012;
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
  wire [9:0] n2025;
  wire [9:0] n2026;
  wire [9:0] n2027;
  wire [9:0] n2028;
  wire [9:0] n2029;
  wire [9:0] n2030;
  wire [9:0] n2031;
  wire [9:0] n2032;
  wire [9:0] n2033;
  wire [9:0] n2034;
  wire [9:0] n2035;
  wire [9:0] n2036;
  wire [9:0] n2037;
  wire [9:0] n2038;
  wire [9:0] n2039;
  wire [9:0] n2040;
  wire [9:0] n2041;
  wire [9:0] n2042;
  wire [9:0] n2043;
  wire [9:0] n2044;
  wire [99:0] n2045;
  wire n2046;
  wire n2047;
  wire n2048;
  wire n2049;
  wire n2050;
  wire n2051;
  wire n2052;
  wire n2053;
  wire n2054;
  wire n2055;
  wire n2056;
  wire n2057;
  wire n2058;
  wire n2059;
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
  wire [9:0] n2072;
  wire [9:0] n2073;
  wire [9:0] n2074;
  wire [9:0] n2075;
  wire [9:0] n2076;
  wire [9:0] n2077;
  wire [9:0] n2078;
  wire [9:0] n2079;
  wire [9:0] n2080;
  wire [9:0] n2081;
  wire [9:0] n2082;
  wire [9:0] n2083;
  wire [9:0] n2084;
  wire [9:0] n2085;
  wire [9:0] n2086;
  wire [9:0] n2087;
  wire [9:0] n2088;
  wire [9:0] n2089;
  wire [9:0] n2090;
  wire [9:0] n2091;
  wire [99:0] n2092;
  wire [159:0] n2094;
  wire [9:0] n2095;
  wire [79:0] n2097;
  wire [4:0] n2098;
  wire [159:0] n2100;
  wire [9:0] n2101;
  wire n2102;
  wire n2103;
  wire n2104;
  wire n2105;
  wire n2106;
  wire n2107;
  wire n2108;
  wire n2109;
  wire n2110;
  wire n2111;
  wire n2112;
  wire n2113;
  wire n2114;
  wire n2115;
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
  wire [9:0] n2128;
  wire [9:0] n2129;
  wire [9:0] n2130;
  wire [9:0] n2131;
  wire [9:0] n2132;
  wire [9:0] n2133;
  wire [9:0] n2134;
  wire [9:0] n2135;
  wire [9:0] n2136;
  wire [9:0] n2137;
  wire [9:0] n2138;
  wire [9:0] n2139;
  wire [9:0] n2140;
  wire [9:0] n2141;
  wire [9:0] n2142;
  wire [9:0] n2143;
  wire [9:0] n2144;
  wire [9:0] n2145;
  wire [9:0] n2146;
  wire [9:0] n2147;
  wire [99:0] n2148;
  wire n2149;
  wire n2150;
  wire n2151;
  wire n2152;
  wire n2153;
  wire n2154;
  wire n2155;
  wire n2156;
  wire n2157;
  wire n2158;
  wire n2159;
  wire n2160;
  wire n2161;
  wire n2162;
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
  wire [4:0] n2175;
  wire [4:0] n2176;
  wire [4:0] n2177;
  wire [4:0] n2178;
  wire [4:0] n2179;
  wire [4:0] n2180;
  wire [4:0] n2181;
  wire [4:0] n2182;
  wire [4:0] n2183;
  wire [4:0] n2184;
  wire [4:0] n2185;
  wire [4:0] n2186;
  wire [4:0] n2187;
  wire [4:0] n2188;
  wire [4:0] n2189;
  wire [4:0] n2190;
  wire [4:0] n2191;
  wire [4:0] n2192;
  wire [4:0] n2193;
  wire [4:0] n2194;
  wire [49:0] n2195;
  wire n2196;
  wire n2197;
  wire n2198;
  wire n2199;
  wire n2200;
  wire n2201;
  wire n2202;
  wire n2203;
  wire n2204;
  wire n2205;
  wire n2206;
  wire n2207;
  wire n2208;
  wire n2209;
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
  wire [4:0] n2222;
  wire [4:0] n2223;
  wire [4:0] n2224;
  wire [4:0] n2225;
  wire [4:0] n2226;
  wire [4:0] n2227;
  wire [4:0] n2228;
  wire [4:0] n2229;
  wire [4:0] n2230;
  wire [4:0] n2231;
  wire [4:0] n2232;
  wire [4:0] n2233;
  wire [4:0] n2234;
  wire [4:0] n2235;
  wire [4:0] n2236;
  wire [4:0] n2237;
  wire [4:0] n2238;
  wire [4:0] n2239;
  wire [4:0] n2240;
  wire [4:0] n2241;
  wire [49:0] n2242;
  wire n2243;
  wire n2244;
  wire n2245;
  wire n2246;
  wire n2247;
  wire n2248;
  wire n2249;
  wire n2250;
  wire n2251;
  wire n2252;
  wire n2253;
  wire n2254;
  wire n2255;
  wire n2256;
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
  wire [4:0] n2269;
  wire [4:0] n2270;
  wire [4:0] n2271;
  wire [4:0] n2272;
  wire [4:0] n2273;
  wire [4:0] n2274;
  wire [4:0] n2275;
  wire [4:0] n2276;
  wire [4:0] n2277;
  wire [4:0] n2278;
  wire [4:0] n2279;
  wire [4:0] n2280;
  wire [4:0] n2281;
  wire [4:0] n2282;
  wire [4:0] n2283;
  wire [4:0] n2284;
  wire [4:0] n2285;
  wire [4:0] n2286;
  wire [4:0] n2287;
  wire [4:0] n2288;
  wire [49:0] n2289;
  wire n2290;
  wire n2291;
  wire n2292;
  wire n2293;
  wire n2294;
  wire n2295;
  wire n2296;
  wire n2297;
  wire n2298;
  wire n2299;
  wire n2300;
  wire n2301;
  wire n2302;
  wire n2303;
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
  wire [4:0] n2316;
  wire [4:0] n2317;
  wire [4:0] n2318;
  wire [4:0] n2319;
  wire [4:0] n2320;
  wire [4:0] n2321;
  wire [4:0] n2322;
  wire [4:0] n2323;
  wire [4:0] n2324;
  wire [4:0] n2325;
  wire [4:0] n2326;
  wire [4:0] n2327;
  wire [4:0] n2328;
  wire [4:0] n2329;
  wire [4:0] n2330;
  wire [4:0] n2331;
  wire [4:0] n2332;
  wire [4:0] n2333;
  wire [4:0] n2334;
  wire [4:0] n2335;
  wire [49:0] n2336;
  wire n2337;
  wire n2338;
  wire n2339;
  wire n2340;
  wire n2341;
  wire n2342;
  wire n2343;
  wire n2344;
  wire n2345;
  wire n2346;
  wire n2347;
  wire n2348;
  wire n2349;
  wire n2350;
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
  wire [4:0] n2363;
  wire [4:0] n2364;
  wire [4:0] n2365;
  wire [4:0] n2366;
  wire [4:0] n2367;
  wire [4:0] n2368;
  wire [4:0] n2369;
  wire [4:0] n2370;
  wire [4:0] n2371;
  wire [4:0] n2372;
  wire [4:0] n2373;
  wire [4:0] n2374;
  wire [4:0] n2375;
  wire [4:0] n2376;
  wire [4:0] n2377;
  wire [4:0] n2378;
  wire [4:0] n2379;
  wire [4:0] n2380;
  wire [4:0] n2381;
  wire [4:0] n2382;
  wire [49:0] n2383;
  wire n2384;
  wire n2385;
  wire n2386;
  wire n2387;
  wire n2388;
  wire n2389;
  wire n2390;
  wire n2391;
  wire n2392;
  wire n2393;
  wire n2394;
  wire n2395;
  wire n2396;
  wire n2397;
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
  wire [4:0] n2410;
  wire [4:0] n2411;
  wire [4:0] n2412;
  wire [4:0] n2413;
  wire [4:0] n2414;
  wire [4:0] n2415;
  wire [4:0] n2416;
  wire [4:0] n2417;
  wire [4:0] n2418;
  wire [4:0] n2419;
  wire [4:0] n2420;
  wire [4:0] n2421;
  wire [4:0] n2422;
  wire [4:0] n2423;
  wire [4:0] n2424;
  wire [4:0] n2425;
  wire [4:0] n2426;
  wire [4:0] n2427;
  wire [4:0] n2428;
  wire [4:0] n2429;
  wire [49:0] n2430;
  wire n2431;
  wire n2432;
  wire n2433;
  wire n2434;
  wire n2435;
  wire n2436;
  wire n2437;
  wire n2438;
  wire n2439;
  wire n2440;
  wire n2441;
  wire n2442;
  wire n2443;
  wire n2444;
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
  wire [7:0] n2686;
  wire [7:0] n2687;
  wire n2688;
  wire n2689;
  wire [6:0] n2690;
  wire [7:0] n2691;
  wire [7:0] n2692;
  wire n2693;
  wire n2694;
  wire [6:0] n2695;
  wire [7:0] n2696;
  wire [7:0] n2697;
  wire n2698;
  wire n2699;
  wire [6:0] n2700;
  wire [7:0] n2701;
  wire [7:0] n2702;
  wire n2703;
  wire n2704;
  wire [6:0] n2705;
  wire [7:0] n2706;
  wire [7:0] n2707;
  wire n2708;
  wire n2709;
  wire [6:0] n2710;
  wire [7:0] n2711;
  wire [7:0] n2712;
  wire n2713;
  wire n2714;
  wire [6:0] n2715;
  wire [7:0] n2716;
  wire [7:0] n2717;
  wire n2718;
  wire n2719;
  wire [6:0] n2720;
  wire [7:0] n2721;
  wire [7:0] n2722;
  wire n2723;
  wire n2724;
  wire [6:0] n2725;
  wire [7:0] n2726;
  wire [7:0] n2727;
  wire n2728;
  wire n2729;
  wire [6:0] n2730;
  wire [7:0] n2731;
  wire [7:0] n2732;
  wire n2733;
  wire n2734;
  wire [6:0] n2735;
  wire [7:0] n2736;
  wire [7:0] n2737;
  wire n2738;
  wire n2739;
  wire [6:0] n2740;
  wire [7:0] n2741;
  wire [7:0] n2742;
  wire n2743;
  wire n2744;
  wire [6:0] n2745;
  wire [7:0] n2746;
  wire [7:0] n2747;
  wire n2748;
  wire n2749;
  wire [6:0] n2750;
  wire [7:0] n2751;
  wire [7:0] n2752;
  wire n2753;
  wire n2754;
  wire [6:0] n2755;
  wire [7:0] n2756;
  wire [7:0] n2757;
  wire n2758;
  wire n2759;
  wire [6:0] n2760;
  wire [7:0] n2761;
  wire [7:0] n2762;
  wire n2763;
  wire n2764;
  wire [6:0] n2765;
  wire [7:0] n2766;
  wire [7:0] n2767;
  wire n2768;
  wire n2769;
  wire [6:0] n2770;
  wire [7:0] n2771;
  wire [7:0] n2772;
  wire n2773;
  wire n2774;
  wire [6:0] n2775;
  wire [7:0] n2776;
  wire [7:0] n2777;
  wire n2778;
  wire n2779;
  wire [6:0] n2780;
  wire [7:0] n2781;
  wire [7:0] n2782;
  wire n2783;
  wire n2784;
  wire [6:0] n2785;
  wire [7:0] n2786;
  wire [7:0] n2787;
  wire n2788;
  wire n2789;
  wire [6:0] n2790;
  wire [7:0] n2791;
  wire [7:0] n2792;
  wire n2793;
  wire n2794;
  wire [6:0] n2795;
  wire [7:0] n2796;
  wire [7:0] n2797;
  wire n2798;
  wire n2799;
  wire [6:0] n2800;
  wire [7:0] n2801;
  wire [7:0] n2802;
  wire n2803;
  wire n2804;
  wire [6:0] n2805;
  wire [7:0] n2806;
  wire [7:0] n2807;
  wire n2808;
  wire n2809;
  wire [6:0] n2810;
  wire [7:0] n2811;
  wire [7:0] n2812;
  wire n2813;
  wire n2814;
  wire [6:0] n2815;
  wire [7:0] n2816;
  wire [7:0] n2817;
  wire n2818;
  wire n2819;
  wire [6:0] n2820;
  wire [7:0] n2821;
  wire [7:0] n2822;
  wire n2823;
  wire n2824;
  wire [6:0] n2825;
  wire [7:0] n2826;
  wire [7:0] n2827;
  wire n2828;
  wire n2829;
  wire [6:0] n2830;
  wire [7:0] n2831;
  wire [7:0] n2832;
  wire n2833;
  wire n2834;
  wire [6:0] n2835;
  wire [7:0] n2836;
  wire [7:0] n2837;
  wire n2838;
  wire n2839;
  wire [6:0] n2840;
  wire [7:0] n2841;
  wire [7:0] n2842;
  wire n2843;
  wire n2844;
  wire [6:0] n2845;
  wire [7:0] n2846;
  wire [7:0] n2847;
  wire n2848;
  wire n2849;
  wire [6:0] n2850;
  wire [7:0] n2851;
  wire [7:0] n2852;
  wire n2853;
  wire n2854;
  wire [6:0] n2855;
  wire [7:0] n2856;
  wire [7:0] n2857;
  wire n2858;
  wire n2859;
  wire [6:0] n2860;
  wire [7:0] n2861;
  wire [7:0] n2862;
  wire n2863;
  wire n2864;
  wire [6:0] n2865;
  wire [7:0] n2866;
  wire [7:0] n2867;
  wire n2868;
  wire n2869;
  wire [6:0] n2870;
  wire [7:0] n2871;
  wire [7:0] n2872;
  wire n2873;
  wire n2874;
  wire [6:0] n2875;
  wire [7:0] n2876;
  wire [7:0] n2877;
  wire n2878;
  wire n2879;
  wire [6:0] n2880;
  wire [7:0] n2881;
  wire [7:0] n2882;
  wire n2883;
  wire n2884;
  wire [6:0] n2885;
  wire [7:0] n2886;
  wire [7:0] n2887;
  wire n2888;
  wire n2889;
  wire [6:0] n2890;
  wire [7:0] n2891;
  wire [7:0] n2892;
  wire n2893;
  wire n2894;
  wire [6:0] n2895;
  wire [7:0] n2896;
  wire [7:0] n2897;
  wire n2898;
  wire n2899;
  wire [6:0] n2900;
  wire [7:0] n2901;
  wire [7:0] n2902;
  wire n2903;
  wire n2904;
  wire [6:0] n2905;
  wire [7:0] n2906;
  wire [7:0] n2907;
  wire n2908;
  wire n2909;
  wire [6:0] n2910;
  wire [7:0] n2911;
  wire [7:0] n2912;
  wire n2913;
  wire n2914;
  wire [6:0] n2915;
  wire [7:0] n2916;
  wire [7:0] n2917;
  wire n2918;
  wire n2919;
  wire [6:0] n2920;
  wire [7:0] n2921;
  wire [7:0] n2922;
  wire n2923;
  wire n2924;
  wire [6:0] n2925;
  wire [7:0] n2926;
  wire [7:0] n2927;
  wire n2928;
  wire n2929;
  wire [6:0] n2930;
  wire [7:0] n2931;
  wire [7:0] n2932;
  wire n2933;
  wire n2934;
  wire [6:0] n2935;
  wire [7:0] n2936;
  wire [7:0] n2937;
  wire n2938;
  wire n2939;
  wire [6:0] n2940;
  wire [7:0] n2941;
  wire [7:0] n2942;
  wire n2943;
  wire n2944;
  wire [6:0] n2945;
  wire [7:0] n2946;
  wire [7:0] n2947;
  wire n2948;
  wire n2949;
  wire [6:0] n2950;
  wire [7:0] n2951;
  wire [7:0] n2952;
  wire n2953;
  wire n2954;
  wire [6:0] n2955;
  wire [7:0] n2956;
  wire [7:0] n2957;
  wire n2958;
  wire n2959;
  wire [6:0] n2960;
  wire [7:0] n2961;
  wire [7:0] n2962;
  wire n2963;
  wire n2964;
  wire [6:0] n2965;
  wire [7:0] n2966;
  wire [7:0] n2967;
  wire n2968;
  wire n2969;
  wire [6:0] n2970;
  wire [7:0] n2971;
  wire [7:0] n2972;
  wire n2973;
  wire n2974;
  wire [6:0] n2975;
  wire [7:0] n2976;
  wire [7:0] n2977;
  wire n2978;
  wire n2979;
  wire [6:0] n2980;
  wire [7:0] n2981;
  wire [7:0] n2982;
  wire n2983;
  wire n2984;
  wire [6:0] n2985;
  wire [7:0] n2986;
  wire [7:0] n2987;
  wire n2988;
  wire n2989;
  wire [6:0] n2990;
  wire [7:0] n2991;
  wire [7:0] n2992;
  wire n2993;
  wire n2994;
  wire [6:0] n2995;
  wire [7:0] n2996;
  wire [7:0] n2997;
  wire n2998;
  wire n2999;
  wire [6:0] n3000;
  wire [7:0] n3001;
  wire [7:0] n3002;
  wire n3003;
  wire n3004;
  wire [6:0] n3005;
  wire [7:0] n3006;
  wire [7:0] n3007;
  wire n3008;
  wire n3009;
  wire [6:0] n3010;
  wire [7:0] n3011;
  wire [7:0] n3012;
  wire n3013;
  wire n3014;
  wire [6:0] n3015;
  wire [7:0] n3016;
  wire [7:0] n3017;
  wire n3018;
  wire n3019;
  wire [6:0] n3020;
  wire [7:0] n3021;
  wire [7:0] n3022;
  wire n3023;
  wire n3024;
  wire [6:0] n3025;
  wire [7:0] n3026;
  wire [7:0] n3027;
  wire n3028;
  wire n3029;
  wire [6:0] n3030;
  wire [7:0] n3031;
  wire [7:0] n3032;
  wire n3033;
  wire n3034;
  wire [6:0] n3035;
  wire [7:0] n3036;
  wire [7:0] n3037;
  wire n3038;
  wire n3039;
  wire [6:0] n3040;
  wire [7:0] n3041;
  wire [7:0] n3042;
  wire n3043;
  wire n3044;
  wire [6:0] n3045;
  wire [7:0] n3046;
  wire [7:0] n3047;
  wire n3048;
  wire n3049;
  wire [6:0] n3050;
  wire [7:0] n3051;
  wire [7:0] n3052;
  wire n3053;
  wire n3054;
  wire [6:0] n3055;
  wire [7:0] n3056;
  wire [7:0] n3057;
  wire n3058;
  wire n3059;
  wire [6:0] n3060;
  wire [7:0] n3061;
  wire [7:0] n3062;
  wire n3063;
  wire n3064;
  wire [6:0] n3065;
  wire [7:0] n3066;
  wire [7:0] n3067;
  wire n3068;
  wire n3069;
  wire [6:0] n3070;
  wire [7:0] n3071;
  wire [7:0] n3072;
  wire n3073;
  wire n3074;
  wire [6:0] n3075;
  wire [7:0] n3076;
  wire [7:0] n3077;
  wire n3078;
  wire n3079;
  wire [6:0] n3080;
  wire [7:0] n3081;
  wire [7:0] n3082;
  wire n3083;
  wire n3084;
  wire [6:0] n3085;
  wire [7:0] n3086;
  wire [7:0] n3087;
  wire n3088;
  wire n3089;
  wire [6:0] n3090;
  wire [7:0] n3091;
  wire [7:0] n3092;
  wire n3093;
  wire n3094;
  wire [6:0] n3095;
  wire [7:0] n3096;
  wire [7:0] n3097;
  wire n3098;
  wire n3099;
  wire [6:0] n3100;
  wire [7:0] n3101;
  wire [7:0] n3102;
  wire n3103;
  wire n3104;
  wire [6:0] n3105;
  wire [7:0] n3106;
  wire [7:0] n3107;
  wire n3108;
  wire n3109;
  wire [6:0] n3110;
  wire [7:0] n3111;
  wire [7:0] n3112;
  wire n3113;
  wire n3114;
  wire [6:0] n3115;
  wire [7:0] n3116;
  wire [7:0] n3117;
  wire n3118;
  wire n3119;
  wire [6:0] n3120;
  wire [7:0] n3121;
  wire [7:0] n3122;
  wire n3123;
  wire n3124;
  wire [6:0] n3125;
  wire [7:0] n3126;
  wire [7:0] n3127;
  wire n3128;
  wire n3129;
  wire [6:0] n3130;
  wire [7:0] n3131;
  wire [7:0] n3132;
  wire n3133;
  wire n3134;
  wire [6:0] n3135;
  wire [7:0] n3136;
  wire [7:0] n3137;
  wire n3138;
  wire n3139;
  wire [6:0] n3140;
  wire [7:0] n3141;
  wire [7:0] n3142;
  wire n3143;
  wire n3144;
  wire [6:0] n3145;
  wire [7:0] n3146;
  wire [7:0] n3147;
  wire n3148;
  wire n3149;
  wire [6:0] n3150;
  wire [7:0] n3151;
  wire [7:0] n3152;
  wire n3153;
  wire n3154;
  wire [6:0] n3155;
  wire [7:0] n3156;
  wire [7:0] n3157;
  wire n3158;
  wire n3159;
  wire [6:0] n3160;
  wire [7:0] n3161;
  wire [7:0] n3162;
  wire n3163;
  wire n3164;
  wire [6:0] n3165;
  wire [7:0] n3166;
  wire [7:0] n3167;
  wire n3168;
  wire n3169;
  wire [6:0] n3170;
  wire [7:0] n3171;
  wire [7:0] n3172;
  wire n3173;
  wire n3174;
  wire [6:0] n3175;
  wire [7:0] n3176;
  wire [7:0] n3177;
  wire n3178;
  wire n3179;
  wire [6:0] n3180;
  wire [7:0] n3181;
  wire [7:0] n3182;
  wire n3183;
  wire n3184;
  wire [6:0] n3185;
  wire [7:0] n3186;
  wire [7:0] n3187;
  wire n3188;
  wire n3189;
  wire [6:0] n3190;
  wire [7:0] n3191;
  wire [7:0] n3192;
  wire n3193;
  wire n3194;
  wire [6:0] n3195;
  wire [7:0] n3196;
  wire [7:0] n3197;
  wire n3198;
  wire n3199;
  wire [6:0] n3200;
  wire [7:0] n3201;
  wire [7:0] n3202;
  wire n3203;
  wire n3204;
  wire [6:0] n3205;
  wire [7:0] n3206;
  wire [7:0] n3207;
  wire n3208;
  wire n3209;
  wire [6:0] n3210;
  wire [7:0] n3211;
  wire [7:0] n3212;
  wire n3213;
  wire n3214;
  wire [6:0] n3215;
  wire [7:0] n3216;
  wire [7:0] n3217;
  wire n3218;
  wire n3219;
  wire [6:0] n3220;
  wire [7:0] n3221;
  wire [7:0] n3222;
  wire n3223;
  wire n3224;
  wire [6:0] n3225;
  wire [7:0] n3226;
  wire [7:0] n3227;
  wire n3228;
  wire n3229;
  wire [6:0] n3230;
  wire [7:0] n3231;
  wire [7:0] n3232;
  wire n3233;
  wire n3234;
  wire [6:0] n3235;
  wire [7:0] n3236;
  wire [7:0] n3237;
  wire n3238;
  wire n3239;
  wire [6:0] n3240;
  wire [7:0] n3241;
  wire [7:0] n3242;
  wire n3243;
  wire n3244;
  wire [6:0] n3245;
  wire [7:0] n3246;
  wire [7:0] n3247;
  wire n3248;
  wire n3249;
  wire [6:0] n3250;
  wire [7:0] n3251;
  wire [7:0] n3252;
  wire n3253;
  wire n3254;
  wire [6:0] n3255;
  wire [7:0] n3256;
  wire [7:0] n3257;
  wire n3258;
  wire n3259;
  wire [6:0] n3260;
  wire [7:0] n3261;
  wire [7:0] n3262;
  wire n3263;
  wire n3264;
  wire [6:0] n3265;
  wire [7:0] n3266;
  wire [7:0] n3267;
  wire n3268;
  wire n3269;
  wire [6:0] n3270;
  wire [7:0] n3271;
  wire [7:0] n3272;
  wire n3273;
  wire n3274;
  wire [6:0] n3275;
  wire [7:0] n3276;
  wire [7:0] n3277;
  wire n3278;
  wire n3279;
  wire [6:0] n3280;
  wire [7:0] n3281;
  wire [7:0] n3282;
  wire n3283;
  wire n3284;
  wire [6:0] n3285;
  wire [7:0] n3286;
  wire [7:0] n3287;
  wire [127:0] n3288;
  assign O_DBUS = m_dbo; //(module output)
  assign O_RDYn = n86; //(module output)
  assign O_INTn = n87; //(module output)
  assign O_M0 = n89; //(module output)
  assign O_M1 = n90; //(module output)
  assign O_ADD8 = n91; //(module output)
  assign O_ADD4 = n92; //(module output)
  assign O_ADD2 = n93; //(module output)
  assign O_ADD1 = n94; //(module output)
  assign O_ROMCLK = n95; //(module output)
  assign O_T11 = m_t11; //(module output)
  assign O_IO = n96; //(module output)
  assign O_PRMOUT = n97; //(module output)
  assign O_SPKR = this_sample; //(module output)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:138:16 */
  always @*
    m_ic = n1839; // (isignal)
  initial
    m_ic = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:139:16 */
  always @*
    m_pc = n1841; // (isignal)
  initial
    m_pc = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:140:16 */
  always @*
    m_t = n1843; // (isignal)
  initial
    m_t = 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:141:16 */
  always @*
    m_fifo_ptr = n1845; // (isignal)
  initial
    m_fifo_ptr = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:142:16 */
  always @*
    m_pitch_count = n1847; // (isignal)
  initial
    m_pitch_count = 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:145:16 */
  always @*
    m_new_frame_energy_idx = n1849; // (isignal)
  initial
    m_new_frame_energy_idx = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:146:16 */
  always @*
    m_new_frame_pitch_idx = n1851; // (isignal)
  initial
    m_new_frame_pitch_idx = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  always @*
    m_new_frame_k_idx = n1853; // (isignal)
  initial
    m_new_frame_k_idx = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:149:16 */
  always @*
    tmp_new_frame_energy_idx = n1855; // (isignal)
  initial
    tmp_new_frame_energy_idx = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:150:16 */
  always @*
    tmp_new_frame_pitch_idx = n1857; // (isignal)
  initial
    tmp_new_frame_pitch_idx = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:151:16 */
  always @*
    tmp_new_frame_k_idx = n1859; // (isignal)
  initial
    tmp_new_frame_k_idx = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  always @*
    m_u = n1861; // (isignal)
  initial
    m_u = 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  always @*
    m_x = n1863; // (isignal)
  initial
    m_x = 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:162:16 */
  always @*
    m_wr_busy = n1865; // (isignal)
  initial
    m_wr_busy = 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:163:16 */
  always @*
    m_wr_srv = n1867; // (isignal)
  initial
    m_wr_srv = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:164:16 */
  always @*
    m_wr_data = n1869; // (isignal)
  initial
    m_wr_data = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:167:17 */
  always @*
    m_cyca = n1871; // (isignal)
  initial
    m_cyca = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:168:17 */
  always @*
    m_rst = n215; // (isignal)
  initial
    m_rst = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:171:17 */
  always @*
    m_clk = I_OSC; // (isignal)
  initial
    m_clk = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:172:17 */
  always @*
    m_ddis = n1873; // (isignal)
  initial
    m_ddis = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:173:17 */
  always @*
    m_ena = I_ENA; // (isignal)
  initial
    m_ena = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:174:17 */
  always @*
    m_olde = n1875; // (isignal)
  initial
    m_olde = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:175:17 */
  always @*
    m_oldp = n1877; // (isignal)
  initial
    m_oldp = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:176:17 */
  always @*
    m_rdb_clr = n1879; // (isignal)
  initial
    m_rdb_clr = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:177:17 */
  always @*
    m_rdb_cmd = n1881; // (isignal)
  initial
    m_rdb_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:178:17 */
  always @*
    m_rdb_flag = n1883; // (isignal)
  initial
    m_rdb_flag = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:179:17 */
  always @*
    m_rst_cmd = n1885; // (isignal)
  initial
    m_rst_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:180:17 */
  always @*
    m_sxt_cmd = n1887; // (isignal)
  initial
    m_sxt_cmd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:181:17 */
  always @*
    m_rsn = I_RSn; // (isignal)
  initial
    m_rsn = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:182:17 */
  always @*
    m_rsn_last = n1889; // (isignal)
  initial
    m_rsn_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:183:17 */
  always @*
    m_spen = n1891; // (isignal)
  initial
    m_spen = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:184:17 */
  always @*
    m_t11 = n1893; // (isignal)
  initial
    m_t11 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:185:17 */
  always @*
    m_talk = n1895; // (isignal)
  initial
    m_talk = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:186:17 */
  always @*
    m_talk_last = n1897; // (isignal)
  initial
    m_talk_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:187:17 */
  always @*
    m_talkd = n1899; // (isignal)
  initial
    m_talkd = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:188:17 */
  always @*
    m_talkd_last = n1901; // (isignal)
  initial
    m_talkd_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:189:17 */
  always @*
    m_uf = n1903; // (isignal)
  initial
    m_uf = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:190:17 */
  always @*
    m_wsn = I_WSn; // (isignal)
  initial
    m_wsn = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:191:17 */
  always @*
    m_wsn_last = n1905; // (isignal)
  initial
    m_wsn_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:192:17 */
  always @*
    m_wr_pending = n1907; // (isignal)
  initial
    m_wr_pending = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:193:17 */
  always @*
    m_buffer_empty = n108; // (isignal)
  initial
    m_buffer_empty = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:194:17 */
  always @*
    m_buffer_empty_last = n1909; // (isignal)
  initial
    m_buffer_empty_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:195:17 */
  always @*
    m_buffer_low = n102; // (isignal)
  initial
    m_buffer_low = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:196:17 */
  always @*
    m_buffer_low_last = n1911; // (isignal)
  initial
    m_buffer_low_last = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:197:17 */
  always @*
    m_cycb = n1913; // (isignal)
  initial
    m_cycb = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:198:17 */
  always @*
    m_inhibit = n1915; // (isignal)
  initial
    m_inhibit = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:199:17 */
  always @*
    m_io_ready = n1917; // (isignal)
  initial
    m_io_ready = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:200:17 */
  always @*
    m_irq_pin = n1919; // (isignal)
  initial
    m_irq_pin = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:201:17 */
  always @*
    m_irq_pin_clr = n1921; // (isignal)
  initial
    m_irq_pin_clr = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:202:17 */
  always @*
    m_new_frame_voiced = n1923; // (isignal)
  initial
    m_new_frame_voiced = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:203:17 */
  always @*
    m_new_frame_unvoiced = n1925; // (isignal)
  initial
    m_new_frame_unvoiced = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:204:17 */
  always @*
    m_new_frame_repeat = n1927; // (isignal)
  initial
    m_new_frame_repeat = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:205:17 */
  always @*
    m_new_frame_zero = n1929; // (isignal)
  initial
    m_new_frame_zero = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:206:17 */
  always @*
    m_new_frame_stop = n1931; // (isignal)
  initial
    m_new_frame_stop = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:207:17 */
  always @*
    m_pitch_zero = n1933; // (isignal)
  initial
    m_pitch_zero = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:208:17 */
  always @*
    m_zpar = n1935; // (isignal)
  initial
    m_zpar = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:209:17 */
  always @*
    m_uv_zpar = n1937; // (isignal)
  initial
    m_uv_zpar = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:212:17 */
  always @*
    phictr = n1939; // (isignal)
  initial
    phictr = 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:215:17 */
  always @*
    m_phi = n1837; // (isignal)
  initial
    m_phi = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:218:17 */
  always @*
    m_wr_reg = n1941; // (isignal)
  initial
    m_wr_reg = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:219:17 */
  always @*
    m_dbo = n1943; // (isignal)
  initial
    m_dbo = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:220:17 */
  always @*
    m_dbi = I_DBUS; // (isignal)
  initial
    m_dbi = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:223:17 */
  always @*
    m_speech = this_sample; // (isignal)
  initial
    m_speech = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:226:17 */
  always @*
    m_shift = n1945; // (isignal)
  initial
    m_shift = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:229:17 */
  always @*
    m_rng = n1947; // (isignal)
  initial
    m_rng = 13'b1111111111111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:232:17 */
  always @*
    m_excitation_data = n1949; // (isignal)
  initial
    m_excitation_data = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:233:17 */
  always @*
    m_previous_energy = n1951; // (isignal)
  initial
    m_previous_energy = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:234:17 */
  always @*
    m_current_energy = n1953; // (isignal)
  initial
    m_current_energy = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:235:17 */
  always @*
    m_current_pitch = n1955; // (isignal)
  initial
    m_current_pitch = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:236:17 */
  always @*
    this_sample = n1957; // (isignal)
  initial
    this_sample = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:239:17 */
  always @*
    m_current_k = n1959; // (isignal)
  initial
    m_current_k = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:242:17 */
  always @*
    m_fifo = n1961; // (isignal)
  initial
    m_fifo = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:254:21 */
  assign n86 = ~m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:255:21 */
  assign n87 = ~m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:267:26 */
  assign n95 = m_phi[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:269:28 */
  assign n96 = m_shift[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:273:47 */
  assign n99 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:273:47 */
  assign n101 = $signed(n99) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:273:31 */
  assign n102 = n101 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:274:47 */
  assign n105 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:274:47 */
  assign n107 = n105 == 32'b00000000000000000000000010000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:274:31 */
  assign n108 = n107 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:281:50 */
  assign n113 = phictr + 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:282:44 */
  assign n115 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:284:49 */
  assign n116 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:284:49 */
  assign n118 = n116 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:287:60 */
  assign n119 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:287:60 */
  assign n121 = n119 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:287:56 */
  assign n122 = n121[4:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:284:41 */
  assign n124 = n118 ? 5'b00001 : n122;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:291:49 */
  assign n125 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:291:49 */
  assign n127 = n125 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:291:65 */
  assign n128 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:291:65 */
  assign n130 = n128 != 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:291:55 */
  assign n131 = n130 & n127;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:292:59 */
  assign n132 = ~m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:68 */
  assign n135 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:68 */
  assign n137 = n135 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:59 */
  assign n138 = n137 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:84 */
  assign n139 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:84 */
  assign n141 = n139 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:74 */
  assign n142 = n141 & n138;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:300:58 */
  assign n143 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:300:58 */
  assign n145 = n143 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:303:71 */
  assign n146 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:303:71 */
  assign n148 = n146 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:303:65 */
  assign n149 = n148[2:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:300:49 */
  assign n151 = n145 ? 3'b000 : n149;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:305:71 */
  assign n152 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:305:71 */
  assign n154 = n152 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:305:62 */
  assign n155 = n154 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:62 */
  assign n156 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:62 */
  assign n158 = n156 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:306:57 */
  assign n159 = n158[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:305:41 */
  assign n160 = n155 ? n159 : m_pc;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:297:41 */
  assign n163 = n142 ? 4'b0000 : n160;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:282:33 */
  assign n164 = n142 & n115;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:282:33 */
  assign n167 = n131 & n115;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:282:33 */
  assign n168 = n131 & n115;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:25 */
  assign n169 = n164 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:25 */
  assign n170 = n115 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:25 */
  assign n171 = n115 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:25 */
  assign n172 = n167 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:280:25 */
  assign n173 = n168 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:314:32 */
  assign n182 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:315:32 */
  assign n183 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:315:22 */
  assign n184 = ~n183;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:316:32 */
  assign n185 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:316:46 */
  assign n186 = phictr[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:316:37 */
  assign n187 = n185 | n186;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:317:32 */
  assign n188 = phictr[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:317:22 */
  assign n189 = ~n188;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:317:46 */
  assign n190 = phictr[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:317:37 */
  assign n191 = n189 | n190;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:330:26 */
  assign n195 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:330:30 */
  assign n196 = ~n195;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:332:33 */
  assign n197 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:332:33 */
  assign n199 = n197 == 32'b00000000000000000000000000001011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:337:57 */
  assign n200 = m_shift[13:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:337:48 */
  assign n202 = {1'b0, n200};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:332:25 */
  assign n205 = n199 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:332:25 */
  assign n206 = n199 ? m_speech : n202;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:343:35 */
  assign n212 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:343:51 */
  assign n213 = ~m_rsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:343:46 */
  assign n214 = n212 & n213;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:343:30 */
  assign n215 = m_rst_cmd | n214;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:354:61 */
  assign n218 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:354:50 */
  assign n219 = n218 & m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:354:68 */
  assign n220 = m_rsn & n219;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:358:42 */
  assign n221 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:358:42 */
  assign n223 = $signed(n221) > $signed(32'b00000000000000000000000000000001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:56 */
  assign n224 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:56 */
  assign n226 = n224 - 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:359:46 */
  assign n227 = n226[4:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:42 */
  assign n228 = {27'b0, m_wr_busy};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:42 */
  assign n230 = n228 == 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:70 */
  assign n231 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:70 */
  assign n233 = $signed(n231) < $signed(32'b00000000000000000000000000001000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:54 */
  assign n234 = n233 & m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:33 */
  assign n237 = n234 ? 5'b10000 : 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:33 */
  assign n240 = n234 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:361:33 */
  assign n242 = n234 ? m_io_ready : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:25 */
  assign n243 = n230 ? n237 : m_wr_busy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:25 */
  assign n245 = n230 ? n240 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:360:25 */
  assign n246 = n230 ? n242 : m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:358:25 */
  assign n247 = n223 ? n227 : n243;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:358:25 */
  assign n249 = n223 ? 1'b0 : n245;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:358:25 */
  assign n250 = n223 ? m_io_ready : n246;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:354:25 */
  assign n252 = n220 ? 5'b10000 : n247;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:354:25 */
  assign n254 = n220 ? 1'b0 : n249;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:354:25 */
  assign n255 = n220 ? m_ddis : m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:354:25 */
  assign n257 = n220 ? 1'b0 : n250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:351:25 */
  assign n259 = m_rst ? 5'b00000 : n252;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:351:25 */
  assign n261 = m_rst ? 1'b0 : n254;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:351:25 */
  assign n263 = m_rst ? m_wr_data : n255;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:351:25 */
  assign n265 = m_rst ? 1'b1 : n257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:46 */
  assign n277 = m_rdb_clr | m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:379:25 */
  assign n279 = m_rdb_cmd ? 1'b1 : m_rdb_flag;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:377:25 */
  assign n281 = n277 ? 1'b0 : n279;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:394:79 */
  assign n287 = ~m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:394:60 */
  assign n288 = n287 & m_talk_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:395:54 */
  assign n289 = ~m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:395:60 */
  assign n290 = m_buffer_low & n289;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:394:86 */
  assign n291 = n288 | n290;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:396:54 */
  assign n292 = ~m_buffer_empty_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:396:60 */
  assign n293 = m_buffer_empty & n292;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:395:86 */
  assign n294 = n291 | n293;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:399:53 */
  assign n295 = m_irq_pin_clr | m_rst;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:399:25 */
  assign n297 = n295 ? 1'b0 : m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:393:25 */
  assign n299 = n294 ? 1'b1 : n297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:416:39 */
  assign n312 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:416:47 */
  assign n313 = m_talkd & n312;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:47 */
  assign n314 = m_rng[11:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:69 */
  assign n315 = m_rng[12]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:83 */
  assign n316 = m_rng[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:74 */
  assign n317 = n315 ^ n316;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:96 */
  assign n318 = m_rng[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:87 */
  assign n319 = n317 ^ n318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:109 */
  assign n320 = m_rng[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:100 */
  assign n321 = n319 ^ n320;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:417:61 */
  assign n322 = {n314, n321};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:416:25 */
  assign n323 = n313 ? n322 : m_rng;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:410:25 */
  assign n325 = m_rst ? 13'b1111111111111 : n323;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:64 */
  assign n331 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:64 */
  assign n333 = n331 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:54 */
  assign n334 = n333 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:79 */
  assign n335 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:79 */
  assign n337 = n335 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:69 */
  assign n338 = n337 & n334;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:94 */
  assign n339 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:94 */
  assign n341 = n339 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:85 */
  assign n342 = n341 & n338;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:110 */
  assign n343 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:114 */
  assign n344 = ~n343;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:100 */
  assign n345 = n344 & n342;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:121 */
  assign n346 = m_inhibit & n345;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:64 */
  assign n347 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:64 */
  assign n349 = n347 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:54 */
  assign n350 = n349 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:79 */
  assign n351 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:79 */
  assign n353 = n351 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:69 */
  assign n354 = n353 & n350;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:94 */
  assign n355 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:94 */
  assign n357 = n355 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:85 */
  assign n358 = n357 & n354;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:110 */
  assign n359 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:114 */
  assign n360 = ~n359;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:100 */
  assign n361 = n360 & n358;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:430:33 */
  assign n363 = n361 ? 1'b0 : m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:428:33 */
  assign n365 = n346 ? 1'b1 : n363;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:435:44 */
  assign n367 = phictr == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:435:61 */
  assign n368 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:435:61 */
  assign n370 = n368 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:435:52 */
  assign n371 = n370 & n367;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:58 */
  assign n372 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:58 */
  assign n374 = n372 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:61 */
  assign n375 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:61 */
  assign n376 = $signed(n374) < $signed(n375);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:98 */
  assign n377 = ~m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:80 */
  assign n378 = n377 & n376;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:80 */
  assign n379 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:80 */
  assign n381 = n379 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:437:66 */
  assign n382 = n381[8:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:436:41 */
  assign n384 = n378 ? n382 : 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:427:25 */
  assign n386 = n371 & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:426:17 */
  assign n388 = n386 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:426:17 */
  assign n389 = m_talkd & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:454:59 */
  assign n395 = ~m_rsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:454:48 */
  assign n396 = n395 & m_rsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:454:66 */
  assign n397 = m_wsn & n396;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:461:67 */
  assign n398 = m_talkd | m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:461:78 */
  assign n399 = {n398, m_buffer_low};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:461:93 */
  assign n400 = {n399, m_buffer_empty};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:461:110 */
  assign n402 = {n400, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:455:33 */
  assign n405 = m_rdb_flag ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:455:33 */
  assign n408 = m_rdb_flag ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:455:33 */
  assign n410 = m_rdb_flag ? 8'b00000000 : n402;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:454:25 */
  assign n413 = n397 ? n408 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  assign n416 = n397 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:450:17 */
  assign n419 = n397 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:473:33 */
  assign n427 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:473:33 */
  assign n429 = n427 == 32'b00000000000000000000000000010001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:473:49 */
  assign n430 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:473:53 */
  assign n431 = ~n430;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:473:39 */
  assign n432 = n431 & n429;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:475:50 */
  assign n433 = m_rng[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:475:41 */
  assign n436 = n433 ? 14'b11111111000000 : 14'b00000001000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:481:59 */
  assign n437 = {23'b0, m_pitch_count};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:481:59 */
  assign n439 = $signed(n437) > $signed(32'b00000000000000000000000000110011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:484:81 */
  assign n440 = m_pitch_count[5:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:484:70 */
  assign n446 = {7'b0, n1964};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:481:41 */
  assign n448 = n439 ? 14'b00000000000000 : n446;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:474:33 */
  assign n449 = m_oldp ? n436 : n448;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:471:17 */
  assign n451 = n432 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:496:42 */
  assign n456 = m_rst | m_uf;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:57 */
  assign n457 = m_cyca & m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:86 */
  assign n458 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:86 */
  assign n460 = n458 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:76 */
  assign n461 = n460 & n457;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:101 */
  assign n462 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:101 */
  assign n464 = n462 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:91 */
  assign n465 = n464 & n461;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:116 */
  assign n466 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:116 */
  assign n468 = n466 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:107 */
  assign n469 = n468 & n465;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:132 */
  assign n470 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:136 */
  assign n471 = ~n470;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:122 */
  assign n472 = n471 & n469;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:501:75 */
  assign n473 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:501:57 */
  assign n474 = n473 & m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:501:94 */
  assign n475 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:501:82 */
  assign n476 = n475 & n474;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:501:25 */
  assign n478 = n476 ? 1'b1 : m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:498:25 */
  assign n480 = n472 ? 1'b0 : n478;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:496:25 */
  assign n482 = n456 ? 1'b0 : n480;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:42 */
  assign n488 = m_rst | m_sxt_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:89 */
  assign n489 = m_ddis & m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:120 */
  assign n490 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:108 */
  assign n491 = n490 & n489;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:127 */
  assign n492 = m_buffer_low_last & n491;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:175 */
  assign n493 = ~m_buffer_low;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:157 */
  assign n494 = n493 & n492;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:63 */
  assign n495 = n488 | n494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:47 */
  assign n496 = m_cyca & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:76 */
  assign n497 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:76 */
  assign n499 = n497 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:66 */
  assign n500 = n499 & n496;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:91 */
  assign n501 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:91 */
  assign n503 = n501 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:81 */
  assign n504 = n503 & n500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:106 */
  assign n505 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:106 */
  assign n507 = n505 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:97 */
  assign n508 = n507 & n504;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:122 */
  assign n509 = m_phi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:126 */
  assign n510 = ~n509;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:112 */
  assign n511 = n510 & n508;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:60 */
  assign n512 = {28'b0, m_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:60 */
  assign n514 = n512 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:517:33 */
  assign n517 = n514 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:523:59 */
  assign n518 = {25'b0, m_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:523:59 */
  assign n520 = n518 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:523:33 */
  assign n523 = n520 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:25 */
  assign n524 = n511 ? n517 : m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:516:25 */
  assign n525 = n511 ? n523 : m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:25 */
  assign n527 = n495 ? 1'b1 : n524;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:513:25 */
  assign n529 = n495 ? 1'b1 : n525;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:56 */
  assign n537 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:56 */
  assign n539 = n537 == 32'b00000000000000000000000000000111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:46 */
  assign n540 = n539 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:71 */
  assign n541 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:71 */
  assign n543 = n541 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:61 */
  assign n544 = n543 & n540;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:86 */
  assign n545 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:86 */
  assign n547 = n545 == 32'b00000000000000000000000000010000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:77 */
  assign n548 = n547 & n544;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:102 */
  assign n549 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:106 */
  assign n550 = ~n549;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:92 */
  assign n551 = n550 & n548;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:544:44 */
  assign n552 = ~m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:544:51 */
  assign n553 = m_spen & n552;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:544:33 */
  assign n555 = n553 ? 1'b1 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:37 */
  assign n556 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:37 */
  assign n558 = n556 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:52 */
  assign n559 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:52 */
  assign n561 = n559 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:42 */
  assign n562 = n561 & n558;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:70 */
  assign n563 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:58 */
  assign n564 = n563 & n562;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:549:25 */
  assign n566 = n564 ? 1'b0 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:25 */
  assign n567 = n551 ? n555 : n566;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:541:25 */
  assign n568 = n551 ? m_talk : m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:538:25 */
  assign n570 = m_rst ? 1'b0 : n567;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:538:25 */
  assign n572 = m_rst ? 1'b0 : n568;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:55 */
  assign n580 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:55 */
  assign n582 = n580 == 32'b00000000000000000000000000010100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:46 */
  assign n583 = n582 & m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:71 */
  assign n584 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:75 */
  assign n585 = ~n584;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:61 */
  assign n586 = n585 & n583;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:82 */
  assign n587 = m_talkd & n586;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:569:66 */
  assign n588 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:569:82 */
  assign n589 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:569:82 */
  assign n591 = n589 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:569:73 */
  assign n592 = n588 | n591;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:570:94 */
  assign n593 = {{18{m_current_energy[13]}}, m_current_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:126 */
  assign n599 = {25'b0, n1967};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:126 */
  assign n600 = {{18{m_current_energy[13]}}, m_current_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:126 */
  assign n601 = n599 - n600;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:80 */
  assign n602 = n601[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:150 */
  assign n608 = {29'b0, n1973};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:68 */
  assign n609 = $signed(n602) >>> n608;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:57 */
  assign n610 = {{20{n609[11]}}, n609}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:570:94 */
  assign n611 = n593 + n610;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:570:77 */
  assign n612 = n611[13:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:569:49 */
  assign n613 = n592 ? n612 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:567:49 */
  assign n615 = m_zpar ? 14'b00000000000000 : n613;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:566:41 */
  assign n617 = m_pc == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:576:66 */
  assign n618 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:576:82 */
  assign n619 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:576:82 */
  assign n621 = n619 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:576:73 */
  assign n622 = n618 | n621;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:92 */
  assign n623 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:101 */
  assign n624 = m_new_frame_pitch_idx[5:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:124 */
  assign n630 = {24'b0, n1976};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:124 */
  assign n631 = {{18{m_current_pitch[13]}}, m_current_pitch}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:124 */
  assign n632 = n630 - n631;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:80 */
  assign n633 = n632[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:148 */
  assign n638 = {29'b0, n1972};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:68 */
  assign n639 = $signed(n633) >>> n638;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:57 */
  assign n640 = {{20{n639[11]}}, n639}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:92 */
  assign n641 = n623 + n640;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:577:76 */
  assign n642 = n641[13:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:576:49 */
  assign n643 = n622 ? n642 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:574:49 */
  assign n645 = m_zpar ? 14'b00000000000000 : n643;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:573:41 */
  assign n647 = m_pc == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:63 */
  assign n648 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:79 */
  assign n649 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:79 */
  assign n651 = n649 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:70 */
  assign n652 = n648 | n651;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:73 */
  assign n653 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:73 */
  assign n655 = n653 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:73 */
  assign n656 = n655[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:73 */
  assign n658 = 4'b1001 - n656;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:96 */
  assign n660 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:96 */
  assign n662 = n660 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:96 */
  assign n663 = n662[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:96 */
  assign n665 = 4'b1001 - n663;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:100 */
  assign n668 = {{22{n1992[9]}}, n1992}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:103 */
  assign n669 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:103 */
  assign n671 = n669 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:103 */
  assign n672 = n671[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:103 */
  assign n674 = 4'b1001 - n672;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:130 */
  assign n676 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:130 */
  assign n678 = n676 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:130 */
  assign n679 = n678[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:130 */
  assign n681 = 4'b1001 - n679;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:125 */
  assign n685 = 5'b11111 - n1995;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:136 */
  assign n690 = {{22{n1981[9]}}, n1981}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:154 */
  assign n691 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:154 */
  assign n693 = n691 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:154 */
  assign n694 = n693[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:154 */
  assign n696 = 4'b1001 - n694;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:136 */
  assign n699 = {{22{n1998[9]}}, n1998}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:136 */
  assign n700 = n690 - n699;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:80 */
  assign n701 = n700[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:165 */
  assign n706 = {29'b0, n1971};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:68 */
  assign n707 = $signed(n701) >>> n706;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:57 */
  assign n708 = {{20{n707[11]}}, n707}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:100 */
  assign n709 = n668 + n708;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:80 */
  assign n710 = n709[9:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:581:49 */
  assign n712 = n652 ? n2045 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:580:41 */
  assign n715 = $unsigned(m_pc) >= $unsigned(4'b0010);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:580:41 */
  assign n716 = $unsigned(m_pc) <= $unsigned(4'b0101);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:580:41 */
  assign n717 = n715 & n716;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:73 */
  assign n718 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:73 */
  assign n720 = n718 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:73 */
  assign n721 = n720[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:73 */
  assign n723 = 4'b1001 - n721;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:71 */
  assign n727 = ~m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:87 */
  assign n728 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:87 */
  assign n730 = n728 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:78 */
  assign n731 = n727 | n730;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:81 */
  assign n732 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:81 */
  assign n734 = n732 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:81 */
  assign n735 = n734[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:81 */
  assign n737 = 4'b1001 - n735;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:104 */
  assign n739 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:104 */
  assign n741 = n739 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:104 */
  assign n742 = n741[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:104 */
  assign n744 = 4'b1001 - n742;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:108 */
  assign n747 = {{22{n2095[9]}}, n2095}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:111 */
  assign n748 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:111 */
  assign n750 = n748 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:111 */
  assign n751 = n750[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:111 */
  assign n753 = 4'b1001 - n751;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:138 */
  assign n755 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:138 */
  assign n757 = n755 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:138 */
  assign n758 = n757[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:138 */
  assign n760 = 4'b1001 - n758;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:133 */
  assign n764 = 5'b11111 - n2098;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:144 */
  assign n768 = {{22{n1979[9]}}, n1979}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:162 */
  assign n769 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:162 */
  assign n771 = n769 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:162 */
  assign n772 = n771[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:162 */
  assign n774 = 4'b1001 - n772;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:144 */
  assign n777 = {{22{n2101[9]}}, n2101}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:144 */
  assign n778 = n768 - n777;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:88 */
  assign n779 = n778[11:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:173 */
  assign n784 = {29'b0, n1970};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:76 */
  assign n785 = $signed(n779) >>> n784;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:65 */
  assign n786 = {{20{n785[11]}}, n785}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:108 */
  assign n787 = n747 + n786;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:88 */
  assign n788 = n787[9:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:589:57 */
  assign n790 = n731 ? n2148 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:586:49 */
  assign n791 = m_uv_zpar ? n2092 : n790;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:585:41 */
  assign n794 = $unsigned(m_pc) >= $unsigned(4'b0110);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:585:41 */
  assign n795 = $unsigned(m_pc) <= $unsigned(4'b1011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:585:41 */
  assign n796 = n794 & n795;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:33 */
  assign n797 = {n796, n717, n647, n617};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:33 */
  always @*
    case (n797)
      4'b1000: n798 = m_current_energy;
      4'b0100: n798 = m_current_energy;
      4'b0010: n798 = m_current_energy;
      4'b0001: n798 = n615;
      default: n798 = m_current_energy;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:33 */
  always @*
    case (n797)
      4'b1000: n799 = m_current_pitch;
      4'b0100: n799 = m_current_pitch;
      4'b0010: n799 = n645;
      4'b0001: n799 = m_current_pitch;
      default: n799 = m_current_pitch;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:565:33 */
  always @*
    case (n797)
      4'b1000: n800 = n791;
      4'b0100: n800 = n712;
      4'b0010: n800 = m_current_k;
      4'b0001: n800 = m_current_k;
      default: n800 = m_current_k;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:25 */
  assign n801 = n587 ? n798 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:25 */
  assign n802 = n587 ? n799 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:563:25 */
  assign n803 = n587 ? n800 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:560:25 */
  assign n805 = m_rst ? 14'b00000000000000 : n801;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:560:25 */
  assign n807 = m_rst ? 14'b00000000000000 : n802;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:560:25 */
  assign n808 = m_rst ? m_current_k : n803;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:58 */
  assign n818 = m_phi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:62 */
  assign n819 = ~n818;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:48 */
  assign n820 = n819 & m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  assign n821 = {{18{m_previous_energy[13]}}, m_previous_energy}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  assign n822 = {{18{m_excitation_data[13]}}, m_excitation_data}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:111 */
  assign n823 = $signed(n821) * $signed(n822); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:83 */
  assign n824 = n823[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:71 */
  assign n826 = $signed(n824) >>> 31'b0000000000000000000000000000011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:614:60 */
  assign n828 = n826[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:613:41 */
  assign n830 = m_t == 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:63 */
  assign n831 = m_u[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:68 */
  assign n832 = {{19{n831[12]}}, n831}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:114 */
  assign n833 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:119 */
  assign n834 = {{22{n833[9]}}, n833}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:124 */
  assign n835 = m_x[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:119 */
  assign n836 = {{19{n835[12]}}, n835}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:119 */
  assign n837 = $signed(n834) * $signed(n836); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:93 */
  assign n838 = n837[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:81 */
  assign n840 = $signed(n838) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:70 */
  assign n841 = {{10{n840[21]}}, n840}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:68 */
  assign n842 = n832 - n841;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:616:60 */
  assign n843 = n842[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:615:41 */
  assign n845 = m_t == 5'b00010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:63 */
  assign n846 = m_u[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:68 */
  assign n847 = {{19{n846[12]}}, n846}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:114 */
  assign n848 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:119 */
  assign n849 = {{22{n848[9]}}, n848}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:124 */
  assign n850 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:119 */
  assign n851 = {{19{n850[12]}}, n850}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:119 */
  assign n852 = $signed(n849) * $signed(n851); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:93 */
  assign n853 = n852[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:81 */
  assign n855 = $signed(n853) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:70 */
  assign n856 = {{10{n855[21]}}, n855}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:68 */
  assign n857 = n847 - n856;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:619:60 */
  assign n858 = n857[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:618:41 */
  assign n860 = m_t == 5'b00011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:63 */
  assign n861 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:68 */
  assign n862 = {{19{n861[12]}}, n861}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:114 */
  assign n863 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:119 */
  assign n864 = {{22{n863[9]}}, n863}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:124 */
  assign n865 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:119 */
  assign n866 = {{19{n865[12]}}, n865}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:119 */
  assign n867 = $signed(n864) * $signed(n866); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:93 */
  assign n868 = n867[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:81 */
  assign n870 = $signed(n868) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:70 */
  assign n871 = {{10{n870[21]}}, n870}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:68 */
  assign n872 = n862 + n871;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:621:60 */
  assign n873 = n872[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:63 */
  assign n874 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:68 */
  assign n875 = {{19{n874[12]}}, n874}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:114 */
  assign n876 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:119 */
  assign n877 = {{22{n876[9]}}, n876}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:124 */
  assign n878 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:119 */
  assign n879 = {{19{n878[12]}}, n878}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:119 */
  assign n880 = $signed(n877) * $signed(n879); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:93 */
  assign n881 = n880[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:81 */
  assign n883 = $signed(n881) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:70 */
  assign n884 = {{10{n883[21]}}, n883}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:68 */
  assign n885 = n875 - n884;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:622:60 */
  assign n886 = n885[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:620:41 */
  assign n888 = m_t == 5'b00100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:63 */
  assign n889 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:68 */
  assign n890 = {{19{n889[12]}}, n889}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:114 */
  assign n891 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:119 */
  assign n892 = {{22{n891[9]}}, n891}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:124 */
  assign n893 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:119 */
  assign n894 = {{19{n893[12]}}, n893}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:119 */
  assign n895 = $signed(n892) * $signed(n894); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:93 */
  assign n896 = n895[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:81 */
  assign n898 = $signed(n896) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:70 */
  assign n899 = {{10{n898[21]}}, n898}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:68 */
  assign n900 = n890 + n899;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:624:60 */
  assign n901 = n900[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:63 */
  assign n902 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:68 */
  assign n903 = {{19{n902[12]}}, n902}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:114 */
  assign n904 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:119 */
  assign n905 = {{22{n904[9]}}, n904}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:124 */
  assign n906 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:119 */
  assign n907 = {{19{n906[12]}}, n906}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:119 */
  assign n908 = $signed(n905) * $signed(n907); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:93 */
  assign n909 = n908[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:81 */
  assign n911 = $signed(n909) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:70 */
  assign n912 = {{10{n911[21]}}, n911}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:68 */
  assign n913 = n903 - n912;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:625:60 */
  assign n914 = n913[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:623:41 */
  assign n916 = m_t == 5'b00101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:63 */
  assign n917 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:68 */
  assign n918 = {{19{n917[12]}}, n917}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:114 */
  assign n919 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:119 */
  assign n920 = {{22{n919[9]}}, n919}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:124 */
  assign n921 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:119 */
  assign n922 = {{19{n921[12]}}, n921}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:119 */
  assign n923 = $signed(n920) * $signed(n922); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:93 */
  assign n924 = n923[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:81 */
  assign n926 = $signed(n924) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:70 */
  assign n927 = {{10{n926[21]}}, n926}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:68 */
  assign n928 = n918 + n927;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:627:60 */
  assign n929 = n928[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:63 */
  assign n930 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:68 */
  assign n931 = {{19{n930[12]}}, n930}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:114 */
  assign n932 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:119 */
  assign n933 = {{22{n932[9]}}, n932}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:124 */
  assign n934 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:119 */
  assign n935 = {{19{n934[12]}}, n934}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:119 */
  assign n936 = $signed(n933) * $signed(n935); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:93 */
  assign n937 = n936[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:81 */
  assign n939 = $signed(n937) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:70 */
  assign n940 = {{10{n939[21]}}, n939}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:68 */
  assign n941 = n931 - n940;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:628:60 */
  assign n942 = n941[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:626:41 */
  assign n944 = m_t == 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:63 */
  assign n945 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:68 */
  assign n946 = {{19{n945[12]}}, n945}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:114 */
  assign n947 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:119 */
  assign n948 = {{22{n947[9]}}, n947}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:124 */
  assign n949 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:119 */
  assign n950 = {{19{n949[12]}}, n949}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:119 */
  assign n951 = $signed(n948) * $signed(n950); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:93 */
  assign n952 = n951[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:81 */
  assign n954 = $signed(n952) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:70 */
  assign n955 = {{10{n954[21]}}, n954}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:68 */
  assign n956 = n946 + n955;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:630:60 */
  assign n957 = n956[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:63 */
  assign n958 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:68 */
  assign n959 = {{19{n958[12]}}, n958}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:114 */
  assign n960 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:119 */
  assign n961 = {{22{n960[9]}}, n960}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:124 */
  assign n962 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:119 */
  assign n963 = {{19{n962[12]}}, n962}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:119 */
  assign n964 = $signed(n961) * $signed(n963); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:93 */
  assign n965 = n964[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:81 */
  assign n967 = $signed(n965) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:70 */
  assign n968 = {{10{n967[21]}}, n967}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:68 */
  assign n969 = n959 - n968;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:631:60 */
  assign n970 = n969[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:629:41 */
  assign n972 = m_t == 5'b00111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:63 */
  assign n973 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:68 */
  assign n974 = {{19{n973[12]}}, n973}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:114 */
  assign n975 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:119 */
  assign n976 = {{22{n975[9]}}, n975}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:124 */
  assign n977 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:119 */
  assign n978 = {{19{n977[12]}}, n977}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:119 */
  assign n979 = $signed(n976) * $signed(n978); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:93 */
  assign n980 = n979[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:81 */
  assign n982 = $signed(n980) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:70 */
  assign n983 = {{10{n982[21]}}, n982}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:68 */
  assign n984 = n974 + n983;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:633:60 */
  assign n985 = n984[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:63 */
  assign n986 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:68 */
  assign n987 = {{19{n986[12]}}, n986}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:114 */
  assign n988 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:119 */
  assign n989 = {{22{n988[9]}}, n988}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:124 */
  assign n990 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:119 */
  assign n991 = {{19{n990[12]}}, n990}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:119 */
  assign n992 = $signed(n989) * $signed(n991); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:93 */
  assign n993 = n992[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:81 */
  assign n995 = $signed(n993) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:70 */
  assign n996 = {{10{n995[21]}}, n995}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:68 */
  assign n997 = n987 - n996;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:634:60 */
  assign n998 = n997[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:632:41 */
  assign n1000 = m_t == 5'b01000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:63 */
  assign n1001 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:68 */
  assign n1002 = {{19{n1001[12]}}, n1001}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:114 */
  assign n1003 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:119 */
  assign n1004 = {{22{n1003[9]}}, n1003}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:124 */
  assign n1005 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:119 */
  assign n1006 = {{19{n1005[12]}}, n1005}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:119 */
  assign n1007 = $signed(n1004) * $signed(n1006); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:93 */
  assign n1008 = n1007[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:81 */
  assign n1010 = $signed(n1008) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:70 */
  assign n1011 = {{10{n1010[21]}}, n1010}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:68 */
  assign n1012 = n1002 + n1011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:636:60 */
  assign n1013 = n1012[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:63 */
  assign n1014 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:68 */
  assign n1015 = {{19{n1014[12]}}, n1014}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:114 */
  assign n1016 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:119 */
  assign n1017 = {{22{n1016[9]}}, n1016}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:124 */
  assign n1018 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:119 */
  assign n1019 = {{19{n1018[12]}}, n1018}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:119 */
  assign n1020 = $signed(n1017) * $signed(n1019); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:93 */
  assign n1021 = n1020[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:81 */
  assign n1023 = $signed(n1021) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:70 */
  assign n1024 = {{10{n1023[21]}}, n1023}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:68 */
  assign n1025 = n1015 - n1024;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:637:60 */
  assign n1026 = n1025[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:635:41 */
  assign n1028 = m_t == 5'b01001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:63 */
  assign n1029 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:68 */
  assign n1030 = {{19{n1029[12]}}, n1029}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:114 */
  assign n1031 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n1032 = {{22{n1031[9]}}, n1031}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:124 */
  assign n1033 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n1034 = {{19{n1033[12]}}, n1033}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:119 */
  assign n1035 = $signed(n1032) * $signed(n1034); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:93 */
  assign n1036 = n1035[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:81 */
  assign n1038 = $signed(n1036) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:70 */
  assign n1039 = {{10{n1038[21]}}, n1038}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:68 */
  assign n1040 = n1030 + n1039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:639:60 */
  assign n1041 = n1040[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:63 */
  assign n1042 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:68 */
  assign n1043 = {{19{n1042[12]}}, n1042}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:114 */
  assign n1044 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:119 */
  assign n1045 = {{22{n1044[9]}}, n1044}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:124 */
  assign n1046 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:119 */
  assign n1047 = {{19{n1046[12]}}, n1046}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:119 */
  assign n1048 = $signed(n1045) * $signed(n1047); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:93 */
  assign n1049 = n1048[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:81 */
  assign n1051 = $signed(n1049) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:70 */
  assign n1052 = {{10{n1051[21]}}, n1051}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:68 */
  assign n1053 = n1043 - n1052;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:640:60 */
  assign n1054 = n1053[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:638:41 */
  assign n1056 = m_t == 5'b01010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:63 */
  assign n1057 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:68 */
  assign n1058 = {{19{n1057[12]}}, n1057}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:114 */
  assign n1059 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n1060 = {{22{n1059[9]}}, n1059}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:124 */
  assign n1061 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n1062 = {{19{n1061[12]}}, n1061}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:119 */
  assign n1063 = $signed(n1060) * $signed(n1062); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:93 */
  assign n1064 = n1063[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:81 */
  assign n1066 = $signed(n1064) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:70 */
  assign n1067 = {{10{n1066[21]}}, n1066}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:68 */
  assign n1068 = n1058 + n1067;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:642:60 */
  assign n1069 = n1068[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:63 */
  assign n1070 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:68 */
  assign n1071 = {{19{n1070[12]}}, n1070}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:114 */
  assign n1072 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:119 */
  assign n1073 = {{22{n1072[9]}}, n1072}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:124 */
  assign n1074 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:119 */
  assign n1075 = {{19{n1074[12]}}, n1074}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:119 */
  assign n1076 = $signed(n1073) * $signed(n1075); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:93 */
  assign n1077 = n1076[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:81 */
  assign n1079 = $signed(n1077) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:70 */
  assign n1080 = {{10{n1079[21]}}, n1079}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:68 */
  assign n1081 = n1071 - n1080;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:643:60 */
  assign n1082 = n1081[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:641:41 */
  assign n1084 = m_t == 5'b01011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:63 */
  assign n1085 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:68 */
  assign n1086 = {{19{n1085[12]}}, n1085}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:114 */
  assign n1087 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n1088 = {{22{n1087[9]}}, n1087}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:124 */
  assign n1089 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n1090 = {{19{n1089[12]}}, n1089}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:119 */
  assign n1091 = $signed(n1088) * $signed(n1090); // smul
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:93 */
  assign n1092 = n1091[21:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:81 */
  assign n1094 = $signed(n1092) >>> 31'b0000000000000000000000000001001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:70 */
  assign n1095 = {{10{n1094[21]}}, n1094}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:68 */
  assign n1096 = n1086 + n1095;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:645:60 */
  assign n1097 = n1096[12:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:646:63 */
  assign n1098 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:67 */
  assign n1099 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:647:64 */
  assign n1100 = {{1{n1099[12]}}, n1099}; // sext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:644:41 */
  assign n1102 = m_t == 5'b01100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  assign n1103 = {n1102, n1084, n1056, n1028, n1000, n972, n944, n916, n888, n860, n845, n830};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1104 = m_u[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1105 = n1104;
      12'b010000000000: n1105 = n1104;
      12'b001000000000: n1105 = n1104;
      12'b000100000000: n1105 = n1104;
      12'b000010000000: n1105 = n1104;
      12'b000001000000: n1105 = n1104;
      12'b000000100000: n1105 = n1104;
      12'b000000010000: n1105 = n1104;
      12'b000000001000: n1105 = n1104;
      12'b000000000100: n1105 = n1104;
      12'b000000000010: n1105 = n1104;
      12'b000000000001: n1105 = n828;
      default: n1105 = n1104;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1106 = m_u[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1107 = n1106;
      12'b010000000000: n1107 = n1106;
      12'b001000000000: n1107 = n1106;
      12'b000100000000: n1107 = n1106;
      12'b000010000000: n1107 = n1106;
      12'b000001000000: n1107 = n1106;
      12'b000000100000: n1107 = n1106;
      12'b000000010000: n1107 = n1106;
      12'b000000001000: n1107 = n1106;
      12'b000000000100: n1107 = n1106;
      12'b000000000010: n1107 = n843;
      12'b000000000001: n1107 = n1106;
      default: n1107 = n1106;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1108 = m_u[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1109 = n1108;
      12'b010000000000: n1109 = n1108;
      12'b001000000000: n1109 = n1108;
      12'b000100000000: n1109 = n1108;
      12'b000010000000: n1109 = n1108;
      12'b000001000000: n1109 = n1108;
      12'b000000100000: n1109 = n1108;
      12'b000000010000: n1109 = n1108;
      12'b000000001000: n1109 = n1108;
      12'b000000000100: n1109 = n858;
      12'b000000000010: n1109 = n1108;
      12'b000000000001: n1109 = n1108;
      default: n1109 = n1108;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1110 = m_u[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1111 = n1110;
      12'b010000000000: n1111 = n1110;
      12'b001000000000: n1111 = n1110;
      12'b000100000000: n1111 = n1110;
      12'b000010000000: n1111 = n1110;
      12'b000001000000: n1111 = n1110;
      12'b000000100000: n1111 = n1110;
      12'b000000010000: n1111 = n1110;
      12'b000000001000: n1111 = n886;
      12'b000000000100: n1111 = n1110;
      12'b000000000010: n1111 = n1110;
      12'b000000000001: n1111 = n1110;
      default: n1111 = n1110;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1112 = m_u[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1113 = n1112;
      12'b010000000000: n1113 = n1112;
      12'b001000000000: n1113 = n1112;
      12'b000100000000: n1113 = n1112;
      12'b000010000000: n1113 = n1112;
      12'b000001000000: n1113 = n1112;
      12'b000000100000: n1113 = n1112;
      12'b000000010000: n1113 = n914;
      12'b000000001000: n1113 = n1112;
      12'b000000000100: n1113 = n1112;
      12'b000000000010: n1113 = n1112;
      12'b000000000001: n1113 = n1112;
      default: n1113 = n1112;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1114 = m_u[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1115 = n1114;
      12'b010000000000: n1115 = n1114;
      12'b001000000000: n1115 = n1114;
      12'b000100000000: n1115 = n1114;
      12'b000010000000: n1115 = n1114;
      12'b000001000000: n1115 = n1114;
      12'b000000100000: n1115 = n942;
      12'b000000010000: n1115 = n1114;
      12'b000000001000: n1115 = n1114;
      12'b000000000100: n1115 = n1114;
      12'b000000000010: n1115 = n1114;
      12'b000000000001: n1115 = n1114;
      default: n1115 = n1114;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1116 = m_u[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1117 = n1116;
      12'b010000000000: n1117 = n1116;
      12'b001000000000: n1117 = n1116;
      12'b000100000000: n1117 = n1116;
      12'b000010000000: n1117 = n1116;
      12'b000001000000: n1117 = n970;
      12'b000000100000: n1117 = n1116;
      12'b000000010000: n1117 = n1116;
      12'b000000001000: n1117 = n1116;
      12'b000000000100: n1117 = n1116;
      12'b000000000010: n1117 = n1116;
      12'b000000000001: n1117 = n1116;
      default: n1117 = n1116;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1118 = m_u[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1119 = n1118;
      12'b010000000000: n1119 = n1118;
      12'b001000000000: n1119 = n1118;
      12'b000100000000: n1119 = n1118;
      12'b000010000000: n1119 = n998;
      12'b000001000000: n1119 = n1118;
      12'b000000100000: n1119 = n1118;
      12'b000000010000: n1119 = n1118;
      12'b000000001000: n1119 = n1118;
      12'b000000000100: n1119 = n1118;
      12'b000000000010: n1119 = n1118;
      12'b000000000001: n1119 = n1118;
      default: n1119 = n1118;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1120 = m_u[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1121 = n1120;
      12'b010000000000: n1121 = n1120;
      12'b001000000000: n1121 = n1120;
      12'b000100000000: n1121 = n1026;
      12'b000010000000: n1121 = n1120;
      12'b000001000000: n1121 = n1120;
      12'b000000100000: n1121 = n1120;
      12'b000000010000: n1121 = n1120;
      12'b000000001000: n1121 = n1120;
      12'b000000000100: n1121 = n1120;
      12'b000000000010: n1121 = n1120;
      12'b000000000001: n1121 = n1120;
      default: n1121 = n1120;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1122 = m_u[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1123 = n1122;
      12'b010000000000: n1123 = n1122;
      12'b001000000000: n1123 = n1054;
      12'b000100000000: n1123 = n1122;
      12'b000010000000: n1123 = n1122;
      12'b000001000000: n1123 = n1122;
      12'b000000100000: n1123 = n1122;
      12'b000000010000: n1123 = n1122;
      12'b000000001000: n1123 = n1122;
      12'b000000000100: n1123 = n1122;
      12'b000000000010: n1123 = n1122;
      12'b000000000001: n1123 = n1122;
      default: n1123 = n1122;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:153:16 */
  assign n1124 = m_u[142:130]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1125 = n1124;
      12'b010000000000: n1125 = n1082;
      12'b001000000000: n1125 = n1124;
      12'b000100000000: n1125 = n1124;
      12'b000010000000: n1125 = n1124;
      12'b000001000000: n1125 = n1124;
      12'b000000100000: n1125 = n1124;
      12'b000000010000: n1125 = n1124;
      12'b000000001000: n1125 = n1124;
      12'b000000000100: n1125 = n1124;
      12'b000000000010: n1125 = n1124;
      12'b000000000001: n1125 = n1124;
      default: n1125 = n1124;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1126 = m_x[12:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1127 = n1126;
      12'b010000000000: n1127 = n1126;
      12'b001000000000: n1127 = n1126;
      12'b000100000000: n1127 = n1126;
      12'b000010000000: n1127 = n1126;
      12'b000001000000: n1127 = n1126;
      12'b000000100000: n1127 = n1126;
      12'b000000010000: n1127 = n1126;
      12'b000000001000: n1127 = n873;
      12'b000000000100: n1127 = n1126;
      12'b000000000010: n1127 = n1126;
      12'b000000000001: n1127 = n1126;
      default: n1127 = n1126;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1128 = m_x[25:13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1129 = n1128;
      12'b010000000000: n1129 = n1128;
      12'b001000000000: n1129 = n1128;
      12'b000100000000: n1129 = n1128;
      12'b000010000000: n1129 = n1128;
      12'b000001000000: n1129 = n1128;
      12'b000000100000: n1129 = n1128;
      12'b000000010000: n1129 = n901;
      12'b000000001000: n1129 = n1128;
      12'b000000000100: n1129 = n1128;
      12'b000000000010: n1129 = n1128;
      12'b000000000001: n1129 = n1128;
      default: n1129 = n1128;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1130 = m_x[38:26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1131 = n1130;
      12'b010000000000: n1131 = n1130;
      12'b001000000000: n1131 = n1130;
      12'b000100000000: n1131 = n1130;
      12'b000010000000: n1131 = n1130;
      12'b000001000000: n1131 = n1130;
      12'b000000100000: n1131 = n929;
      12'b000000010000: n1131 = n1130;
      12'b000000001000: n1131 = n1130;
      12'b000000000100: n1131 = n1130;
      12'b000000000010: n1131 = n1130;
      12'b000000000001: n1131 = n1130;
      default: n1131 = n1130;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1132 = m_x[51:39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1133 = n1132;
      12'b010000000000: n1133 = n1132;
      12'b001000000000: n1133 = n1132;
      12'b000100000000: n1133 = n1132;
      12'b000010000000: n1133 = n1132;
      12'b000001000000: n1133 = n957;
      12'b000000100000: n1133 = n1132;
      12'b000000010000: n1133 = n1132;
      12'b000000001000: n1133 = n1132;
      12'b000000000100: n1133 = n1132;
      12'b000000000010: n1133 = n1132;
      12'b000000000001: n1133 = n1132;
      default: n1133 = n1132;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1134 = m_x[64:52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1135 = n1134;
      12'b010000000000: n1135 = n1134;
      12'b001000000000: n1135 = n1134;
      12'b000100000000: n1135 = n1134;
      12'b000010000000: n1135 = n985;
      12'b000001000000: n1135 = n1134;
      12'b000000100000: n1135 = n1134;
      12'b000000010000: n1135 = n1134;
      12'b000000001000: n1135 = n1134;
      12'b000000000100: n1135 = n1134;
      12'b000000000010: n1135 = n1134;
      12'b000000000001: n1135 = n1134;
      default: n1135 = n1134;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1136 = m_x[77:65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1137 = n1136;
      12'b010000000000: n1137 = n1136;
      12'b001000000000: n1137 = n1136;
      12'b000100000000: n1137 = n1013;
      12'b000010000000: n1137 = n1136;
      12'b000001000000: n1137 = n1136;
      12'b000000100000: n1137 = n1136;
      12'b000000010000: n1137 = n1136;
      12'b000000001000: n1137 = n1136;
      12'b000000000100: n1137 = n1136;
      12'b000000000010: n1137 = n1136;
      12'b000000000001: n1137 = n1136;
      default: n1137 = n1136;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1138 = m_x[90:78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1139 = n1138;
      12'b010000000000: n1139 = n1138;
      12'b001000000000: n1139 = n1041;
      12'b000100000000: n1139 = n1138;
      12'b000010000000: n1139 = n1138;
      12'b000001000000: n1139 = n1138;
      12'b000000100000: n1139 = n1138;
      12'b000000010000: n1139 = n1138;
      12'b000000001000: n1139 = n1138;
      12'b000000000100: n1139 = n1138;
      12'b000000000010: n1139 = n1138;
      12'b000000000001: n1139 = n1138;
      default: n1139 = n1138;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1140 = m_x[103:91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1141 = n1140;
      12'b010000000000: n1141 = n1069;
      12'b001000000000: n1141 = n1140;
      12'b000100000000: n1141 = n1140;
      12'b000010000000: n1141 = n1140;
      12'b000001000000: n1141 = n1140;
      12'b000000100000: n1141 = n1140;
      12'b000000010000: n1141 = n1140;
      12'b000000001000: n1141 = n1140;
      12'b000000000100: n1141 = n1140;
      12'b000000000010: n1141 = n1140;
      12'b000000000001: n1141 = n1140;
      default: n1141 = n1140;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1142 = m_x[116:104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1143 = n1097;
      12'b010000000000: n1143 = n1142;
      12'b001000000000: n1143 = n1142;
      12'b000100000000: n1143 = n1142;
      12'b000010000000: n1143 = n1142;
      12'b000001000000: n1143 = n1142;
      12'b000000100000: n1143 = n1142;
      12'b000000010000: n1143 = n1142;
      12'b000000001000: n1143 = n1142;
      12'b000000000100: n1143 = n1142;
      12'b000000000010: n1143 = n1142;
      12'b000000000001: n1143 = n1142;
      default: n1143 = n1142;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:154:16 */
  assign n1144 = m_x[129:117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1145 = n1098;
      12'b010000000000: n1145 = n1144;
      12'b001000000000: n1145 = n1144;
      12'b000100000000: n1145 = n1144;
      12'b000010000000: n1145 = n1144;
      12'b000001000000: n1145 = n1144;
      12'b000000100000: n1145 = n1144;
      12'b000000010000: n1145 = n1144;
      12'b000000001000: n1145 = n1144;
      12'b000000000100: n1145 = n1144;
      12'b000000000010: n1145 = n1144;
      12'b000000000001: n1145 = n1144;
      default: n1145 = n1144;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1146 = m_previous_energy;
      12'b010000000000: n1146 = m_previous_energy;
      12'b001000000000: n1146 = m_previous_energy;
      12'b000100000000: n1146 = m_previous_energy;
      12'b000010000000: n1146 = m_previous_energy;
      12'b000001000000: n1146 = m_previous_energy;
      12'b000000100000: n1146 = m_previous_energy;
      12'b000000010000: n1146 = m_previous_energy;
      12'b000000001000: n1146 = m_previous_energy;
      12'b000000000100: n1146 = m_previous_energy;
      12'b000000000010: n1146 = m_current_energy;
      12'b000000000001: n1146 = m_previous_energy;
      default: n1146 = m_previous_energy;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:612:33 */
  always @*
    case (n1103)
      12'b100000000000: n1147 = n1100;
      12'b010000000000: n1147 = this_sample;
      12'b001000000000: n1147 = this_sample;
      12'b000100000000: n1147 = this_sample;
      12'b000010000000: n1147 = this_sample;
      12'b000001000000: n1147 = this_sample;
      12'b000000100000: n1147 = this_sample;
      12'b000000010000: n1147 = this_sample;
      12'b000000001000: n1147 = this_sample;
      12'b000000000100: n1147 = this_sample;
      12'b000000000010: n1147 = this_sample;
      12'b000000000001: n1147 = this_sample;
      default: n1147 = this_sample;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:25 */
  assign n1148 = {n1125, n1123, n1121, n1119, n1117, n1115, n1113, n1111, n1109, n1107, n1105};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:25 */
  assign n1149 = n820 ? n1148 : m_u;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:25 */
  assign n1150 = {n1145, n1143, n1141, n1139, n1137, n1135, n1133, n1131, n1129, n1127};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:25 */
  assign n1151 = n820 ? n1150 : m_x;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:25 */
  assign n1152 = n820 ? n1146 : m_previous_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:610:25 */
  assign n1153 = n820 ? n1147 : this_sample;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:25 */
  assign n1155 = m_rst ? 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1149;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:25 */
  assign n1157 = m_rst ? 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1151;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:25 */
  assign n1159 = m_rst ? 14'b00000000000000 : n1152;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:606:25 */
  assign n1160 = m_rst ? this_sample : n1153;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:59 */
  assign n1172 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:48 */
  assign n1173 = n1172 & m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:659:66 */
  assign n1174 = m_rsn & n1173;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:44 */
  assign n1175 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:51 */
  assign n1176 = m_dbi[6:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:667:49 */
  assign n1178 = n1176 == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:668:49 */
  assign n1180 = n1176 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:670:49 */
  assign n1182 = n1176 == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:671:49 */
  assign n1184 = n1176 == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:672:49 */
  assign n1186 = n1176 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:673:49 */
  assign n1188 = n1176 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:674:49 */
  assign n1190 = n1176 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:676:49 */
  assign n1192 = n1176 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:41 */
  assign n1193 = {n1192, n1190, n1188, n1186, n1184, n1182, n1180, n1178};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:41 */
  always @*
    case (n1193)
      8'b10000000: n1196 = 1'b0;
      8'b01000000: n1196 = 1'b0;
      8'b00100000: n1196 = 1'b0;
      8'b00010000: n1196 = 1'b0;
      8'b00001000: n1196 = 1'b0;
      8'b00000100: n1196 = 1'b0;
      8'b00000010: n1196 = 1'b1;
      8'b00000001: n1196 = 1'b0;
      default: n1196 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:41 */
  always @*
    case (n1193)
      8'b10000000: n1199 = 1'b1;
      8'b01000000: n1199 = 1'b0;
      8'b00100000: n1199 = 1'b0;
      8'b00010000: n1199 = 1'b0;
      8'b00001000: n1199 = 1'b0;
      8'b00000100: n1199 = 1'b0;
      8'b00000010: n1199 = 1'b0;
      8'b00000001: n1199 = 1'b0;
      default: n1199 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:666:41 */
  always @*
    case (n1193)
      8'b10000000: n1202 = 1'b0;
      8'b01000000: n1202 = 1'b1;
      8'b00100000: n1202 = 1'b0;
      8'b00010000: n1202 = 1'b0;
      8'b00001000: n1202 = 1'b0;
      8'b00000100: n1202 = 1'b0;
      8'b00000010: n1202 = 1'b0;
      8'b00000001: n1202 = 1'b0;
      default: n1202 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:33 */
  assign n1204 = n1175 ? n1196 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:33 */
  assign n1207 = n1175 ? n1199 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:663:33 */
  assign n1210 = n1175 ? n1202 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:658:17 */
  assign n1215 = n1174 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:658:17 */
  assign n1216 = n1174 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:658:17 */
  assign n1217 = n1174 & m_ena;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:691:75 */
  assign n1224 = ~m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:691:64 */
  assign n1225 = n1224 & m_talkd_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:691:42 */
  assign n1226 = m_rst | n1225;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:693:25 */
  assign n1228 = m_sxt_cmd ? 1'b1 : m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:691:25 */
  assign n1230 = n1226 ? 1'b0 : n1228;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:56 */
  assign n1238 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:56 */
  assign n1240 = n1238 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:46 */
  assign n1241 = n1240 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:71 */
  assign n1242 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:71 */
  assign n1244 = n1242 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:61 */
  assign n1245 = n1244 & n1241;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:86 */
  assign n1246 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:86 */
  assign n1248 = n1246 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:77 */
  assign n1249 = n1248 & n1245;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:102 */
  assign n1250 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:106 */
  assign n1251 = ~n1250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:92 */
  assign n1252 = n1251 & n1249;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:113 */
  assign n1253 = m_talkd & n1252;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:708:50 */
  assign n1254 = ~m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:708:88 */
  assign n1255 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:708:88 */
  assign n1257 = n1255 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:708:57 */
  assign n1258 = n1257 & n1254;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:709:87 */
  assign n1259 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:709:87 */
  assign n1261 = n1259 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:709:57 */
  assign n1262 = n1261 & m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:708:94 */
  assign n1263 = n1258 | n1262;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:710:87 */
  assign n1264 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:710:87 */
  assign n1266 = n1264 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:710:57 */
  assign n1267 = n1266 & m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:709:94 */
  assign n1268 = n1263 | n1267;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:711:88 */
  assign n1269 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:711:88 */
  assign n1271 = n1269 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:711:57 */
  assign n1272 = n1271 & m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:710:94 */
  assign n1273 = n1268 | n1272;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:707:33 */
  assign n1276 = n1273 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:706:25 */
  assign n1277 = n1253 ? n1276 : m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:704:25 */
  assign n1279 = m_rst ? 1'b1 : n1277;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:54 */
  assign n1285 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:76 */
  assign n1287 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:61 */
  assign n1288 = n1287 & n1285;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:42 */
  assign n1289 = m_rst | n1288;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:51 */
  assign n1290 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:85 */
  assign n1291 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:73 */
  assign n1292 = n1291 & n1290;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:108 */
  assign n1293 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:108 */
  assign n1295 = $signed(n1293) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:92 */
  assign n1296 = n1295 & n1292;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:130 */
  assign n1297 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:130 */
  assign n1299 = $signed(n1297) < $signed(32'b00000000000000000000000001001001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:727:114 */
  assign n1300 = n1299 & n1296;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:85 */
  assign n1301 = n1289 | n1300;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:25 */
  assign n1303 = n1301 ? 1'b1 : m_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:726:25 */
  assign n1305 = n1301 ? 1'b1 : m_uv_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:53 */
  assign n1306 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:53 */
  assign n1308 = n1306 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:43 */
  assign n1309 = n1308 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:68 */
  assign n1310 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:68 */
  assign n1312 = n1310 == 32'b00000000000000000000000000001100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:58 */
  assign n1313 = n1312 & n1309;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:83 */
  assign n1314 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:83 */
  assign n1316 = n1314 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:74 */
  assign n1317 = n1316 & n1313;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:99 */
  assign n1318 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:103 */
  assign n1319 = ~n1318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:89 */
  assign n1320 = n1319 & n1317;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:110 */
  assign n1321 = m_talkd & n1320;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:61 */
  assign n1322 = {25'b0, tmp_new_frame_pitch_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:61 */
  assign n1324 = n1322 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:96 */
  assign n1325 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:96 */
  assign n1327 = n1325 != 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:66 */
  assign n1328 = n1327 & n1324;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:132 */
  assign n1329 = {28'b0, tmp_new_frame_energy_idx};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:132 */
  assign n1331 = n1329 != 32'b00000000000000000000000000001111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:102 */
  assign n1332 = n1331 & n1328;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:734:33 */
  assign n1335 = n1332 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:25 */
  assign n1337 = n1321 ? 1'b0 : n1303;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:732:25 */
  assign n1338 = n1321 ? n1335 : n1305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:54 */
  assign n1346 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:76 */
  assign n1348 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:61 */
  assign n1349 = n1348 & n1346;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:42 */
  assign n1350 = m_rst | n1349;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:51 */
  assign n1351 = m_wsn_last & m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:85 */
  assign n1352 = ~m_wsn;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:74 */
  assign n1353 = n1352 & n1351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:92 */
  assign n1354 = m_rsn & n1353;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:58 */
  assign n1355 = m_dbi[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:67 */
  assign n1356 = m_dbi[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:61 */
  assign n1357 = {n1355, n1356};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:76 */
  assign n1358 = m_dbi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:70 */
  assign n1359 = {n1357, n1358};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:85 */
  assign n1360 = m_dbi[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:79 */
  assign n1361 = {n1359, n1360};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:94 */
  assign n1362 = m_dbi[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:88 */
  assign n1363 = {n1361, n1362};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:103 */
  assign n1364 = m_dbi[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:97 */
  assign n1365 = {n1363, n1364};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:112 */
  assign n1366 = m_dbi[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:106 */
  assign n1367 = {n1365, n1366};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:121 */
  assign n1368 = m_dbi[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:758:115 */
  assign n1369 = {n1367, n1368};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:757:33 */
  assign n1370 = n1354 ? n1369 : m_wr_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:760:53 */
  assign n1371 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:760:33 */
  assign n1373 = n1371 ? 1'b1 : m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:25 */
  assign n1375 = n1350 ? 8'b10000000 : m_fifo_ptr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:25 */
  assign n1376 = n1350 ? m_wr_pending : n1373;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:25 */
  assign n1377 = n1350 ? m_wr_reg : n1370;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:751:25 */
  assign n1379 = n1350 ? 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : m_fifo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:54 */
  assign n1380 = ~m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:76 */
  assign n1382 = $unsigned(m_sxt_cmd) <= $unsigned(1'b1);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:61 */
  assign n1383 = n1382 & n1380;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:42 */
  assign n1384 = m_rst | n1383;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:51 */
  assign n1385 = m_wr_data & m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:85 */
  assign n1386 = ~m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:73 */
  assign n1387 = n1386 & n1385;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:108 */
  assign n1388 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:108 */
  assign n1390 = $signed(n1388) > $signed(32'b00000000000000000000000001000000);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:92 */
  assign n1391 = n1390 & n1387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:130 */
  assign n1392 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:130 */
  assign n1394 = $signed(n1392) < $signed(32'b00000000000000000000000001001001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:766:114 */
  assign n1395 = n1394 & n1391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:85 */
  assign n1396 = n1384 | n1395;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:56 */
  assign n1397 = {29'b0, m_ic};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:56 */
  assign n1399 = n1397 == 32'b00000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:46 */
  assign n1400 = n1399 & m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:70 */
  assign n1401 = {27'b0, m_t};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:70 */
  assign n1403 = n1401 == 32'b00000000000000000000000000010011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:61 */
  assign n1404 = n1403 & n1400;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:86 */
  assign n1405 = m_phi[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:90 */
  assign n1406 = ~n1405;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:76 */
  assign n1407 = n1406 & n1404;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:97 */
  assign n1408 = m_talkd & n1407;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:64 */
  assign n1409 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:64 */
  assign n1411 = $signed(n1409) <= $signed(32'b00000000000000000000000001111100);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:779:82 */
  assign n1412 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:779:82 */
  assign n1414 = n1412 + 32'b00000000000000000000000000000100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:779:71 */
  assign n1415 = n1414[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:73 */
  assign n1416 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:780:107 */
  assign n1418 = {n1416, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:781:111 */
  assign n1419 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:783:70 */
  assign n1421 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:783:112 */
  assign n1423 = n1421 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:785:70 */
  assign n1424 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:785:112 */
  assign n1426 = n1424 == 4'b1111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:785:57 */
  assign n1428 = n1426 ? m_new_frame_voiced : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:785:57 */
  assign n1430 = n1426 ? m_new_frame_zero : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:785:57 */
  assign n1433 = n1426 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:783:57 */
  assign n1434 = n1423 ? m_new_frame_voiced : n1428;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:783:57 */
  assign n1436 = n1423 ? 1'b1 : n1430;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:783:57 */
  assign n1437 = n1423 ? m_new_frame_stop : n1433;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:49 */
  assign n1438 = n1411 ? n1415 : n1375;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:49 */
  assign n1439 = n1411 ? n1419 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:49 */
  assign n1442 = n1411 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:49 */
  assign n1443 = n1411 ? n1434 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:49 */
  assign n1444 = n1411 ? n1436 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:49 */
  assign n1445 = n1411 ? n1437 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:778:49 */
  assign n1446 = n1411 ? n1418 : n1379;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:777:41 */
  assign n1448 = m_pc == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:71 */
  assign n1449 = ~m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:100 */
  assign n1450 = ~m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:78 */
  assign n1451 = n1450 & n1449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:797:72 */
  assign n1452 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:797:72 */
  assign n1454 = $signed(n1452) <= $signed(32'b00000000000000000000000001111001);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:90 */
  assign n1455 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:90 */
  assign n1457 = n1455 + 32'b00000000000000000000000000000110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:99 */
  assign n1459 = n1457 + 32'b00000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:798:79 */
  assign n1460 = n1459[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:799:81 */
  assign n1461 = m_fifo[120:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:799:124 */
  assign n1463 = {n1461, 7'b0000000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:800:93 */
  assign n1464 = m_fifo[127]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:801:118 */
  assign n1465 = m_fifo[126:121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:801:92 */
  assign n1467 = {1'b0, n1465};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:802:75 */
  assign n1468 = m_fifo[126:121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:802:135 */
  assign n1470 = n1468 == 6'b000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1472 = n1488 ? 1'b0 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1474 = n1489 ? 1'b1 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1475 = n1484 ? n1460 : n1375;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1476 = n1485 ? n1467 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:797:57 */
  assign n1479 = n1454 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:797:57 */
  assign n1480 = n1470 & n1454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:797:57 */
  assign n1481 = n1470 & n1454;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1482 = n1490 ? n1464 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1483 = n1491 ? n1463 : n1379;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1484 = n1454 & n1451;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1485 = n1454 & n1451;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1487 = n1451 ? n1479 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1488 = n1480 & n1451;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1489 = n1481 & n1451;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1490 = n1454 & n1451;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:796:49 */
  assign n1491 = n1454 & n1451;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:795:41 */
  assign n1493 = m_pc == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:73 */
  assign n1494 = ~m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:112 */
  assign n1495 = m_new_frame_voiced | m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:80 */
  assign n1496 = n1495 & n1494;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:72 */
  assign n1497 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:98 */
  assign n1498 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:98 */
  assign n1500 = n1498 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:98 */
  assign n1501 = n1500[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:85 */
  assign n1507 = {29'b0, n1989};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:85 */
  assign n1509 = 32'b00000000000000000000000010000000 - n1507;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:72 */
  assign n1510 = $signed(n1497) <= $signed(n1509);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:90 */
  assign n1511 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:103 */
  assign n1512 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:103 */
  assign n1514 = n1512 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:103 */
  assign n1515 = n1514[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:90 */
  assign n1520 = {29'b0, n1988};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:90 */
  assign n1521 = n1511 + n1520;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:79 */
  assign n1522 = n1521[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:81 */
  assign n1523 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:81 */
  assign n1525 = n1523 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:81 */
  assign n1526 = n1525[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:819:97 */
  assign n1531 = m_fifo[122:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:819:122 */
  assign n1533 = {n1531, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:105 */
  assign n1534 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:105 */
  assign n1536 = n1534 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:105 */
  assign n1537 = n1536[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:105 */
  assign n1539 = 4'b1001 - n1537;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:138 */
  assign n1541 = m_fifo[127:123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:818:73 */
  assign n1545 = n1987 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:822:97 */
  assign n1546 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:822:122 */
  assign n1548 = {n1546, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:105 */
  assign n1549 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:105 */
  assign n1551 = n1549 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:105 */
  assign n1552 = n1551[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:105 */
  assign n1554 = 4'b1001 - n1552;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:138 */
  assign n1556 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:112 */
  assign n1558 = {1'b0, n1556};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:821:73 */
  assign n1561 = n1987 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:825:97 */
  assign n1562 = m_fifo[124:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:825:122 */
  assign n1564 = {n1562, 3'b000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:105 */
  assign n1565 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:105 */
  assign n1567 = n1565 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:105 */
  assign n1568 = n1567[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:105 */
  assign n1570 = 4'b1001 - n1568;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:138 */
  assign n1572 = m_fifo[127:125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:112 */
  assign n1574 = {2'b0, n1572};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:65 */
  assign n1576 = {n1561, n1545};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:65 */
  always @*
    case (n1576)
      2'b10: n1577 = n2242;
      2'b01: n1577 = n2195;
      default: n1577 = n2289;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:65 */
  always @*
    case (n1576)
      2'b10: n1578 = n1548;
      2'b01: n1578 = n1533;
      default: n1578 = n1564;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:49 */
  assign n1579 = n1585 ? n1522 : n1375;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:49 */
  assign n1580 = n1586 ? n1577 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:57 */
  assign n1583 = n1510 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:49 */
  assign n1584 = n1589 ? n1578 : n1379;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:49 */
  assign n1585 = n1510 & n1496;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:49 */
  assign n1586 = n1510 & n1496;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:49 */
  assign n1588 = n1496 ? n1583 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:812:49 */
  assign n1589 = n1510 & n1496;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:41 */
  assign n1592 = $unsigned(m_pc) >= $unsigned(4'b0010);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:41 */
  assign n1593 = $unsigned(m_pc) <= $unsigned(4'b0101);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:811:41 */
  assign n1594 = n1592 & n1593;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:73 */
  assign n1595 = ~m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:80 */
  assign n1596 = m_new_frame_voiced & n1595;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:72 */
  assign n1597 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:98 */
  assign n1598 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:98 */
  assign n1600 = n1598 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:98 */
  assign n1601 = n1600[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:85 */
  assign n1606 = {29'b0, n1986};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:85 */
  assign n1608 = 32'b00000000000000000000000010000000 - n1606;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:72 */
  assign n1609 = $signed(n1597) <= $signed(n1608);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:90 */
  assign n1610 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:103 */
  assign n1611 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:103 */
  assign n1613 = n1611 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:103 */
  assign n1614 = n1613[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:90 */
  assign n1619 = {29'b0, n1985};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:90 */
  assign n1620 = n1610 + n1619;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:79 */
  assign n1621 = n1620[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:839:81 */
  assign n1622 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:839:81 */
  assign n1624 = n1622 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:839:81 */
  assign n1625 = n1624[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:97 */
  assign n1630 = m_fifo[122:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:841:122 */
  assign n1632 = {n1630, 5'b00000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:105 */
  assign n1633 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:105 */
  assign n1635 = n1633 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:105 */
  assign n1636 = n1635[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:105 */
  assign n1638 = 4'b1001 - n1636;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:138 */
  assign n1640 = m_fifo[127:123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:840:73 */
  assign n1644 = n1984 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:97 */
  assign n1645 = m_fifo[123:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:844:122 */
  assign n1647 = {n1645, 4'b0000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:105 */
  assign n1648 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:105 */
  assign n1650 = n1648 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:105 */
  assign n1651 = n1650[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:105 */
  assign n1653 = 4'b1001 - n1651;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:138 */
  assign n1655 = m_fifo[127:124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:112 */
  assign n1657 = {1'b0, n1655};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:843:73 */
  assign n1660 = n1984 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:97 */
  assign n1661 = m_fifo[124:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:847:122 */
  assign n1663 = {n1661, 3'b000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:105 */
  assign n1664 = {28'b0, m_pc};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:105 */
  assign n1666 = n1664 - 32'b00000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:105 */
  assign n1667 = n1666[3:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:105 */
  assign n1669 = 4'b1001 - n1667;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:138 */
  assign n1671 = m_fifo[127:125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:112 */
  assign n1673 = {2'b0, n1671};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:839:65 */
  assign n1675 = {n1660, n1644};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:839:65 */
  always @*
    case (n1675)
      2'b10: n1676 = n2383;
      2'b01: n1676 = n2336;
      default: n1676 = n2430;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:839:65 */
  always @*
    case (n1675)
      2'b10: n1677 = n1647;
      2'b01: n1677 = n1632;
      default: n1677 = n1663;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:49 */
  assign n1678 = n1684 ? n1621 : n1375;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:49 */
  assign n1679 = n1685 ? n1676 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:57 */
  assign n1682 = n1609 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:49 */
  assign n1683 = n1688 ? n1677 : n1379;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:49 */
  assign n1684 = n1609 & n1596;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:49 */
  assign n1685 = n1609 & n1596;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:49 */
  assign n1687 = n1596 ? n1682 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:834:49 */
  assign n1688 = n1609 & n1596;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:833:41 */
  assign n1691 = $unsigned(m_pc) >= $unsigned(4'b0110);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:833:41 */
  assign n1692 = $unsigned(m_pc) <= $unsigned(4'b1011);
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:833:41 */
  assign n1693 = n1691 & n1692;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:862:94 */
  assign n1694 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:863:94 */
  assign n1695 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:864:94 */
  assign n1696 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:865:94 */
  assign n1697 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:866:94 */
  assign n1698 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:867:94 */
  assign n1699 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:868:94 */
  assign n1700 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:869:94 */
  assign n1701 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:870:94 */
  assign n1702 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:871:94 */
  assign n1703 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:855:41 */
  assign n1705 = m_pc == 4'b1100;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  assign n1706 = {n1705, n1693, n1594, n1493, n1448};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1707 = n1375;
      5'b01000: n1707 = n1678;
      5'b00100: n1707 = n1579;
      5'b00010: n1707 = n1475;
      5'b00001: n1707 = n1438;
      default: n1707 = n1375;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1708 = tmp_new_frame_energy_idx;
      5'b01000: n1708 = m_new_frame_energy_idx;
      5'b00100: n1708 = m_new_frame_energy_idx;
      5'b00010: n1708 = m_new_frame_energy_idx;
      5'b00001: n1708 = m_new_frame_energy_idx;
      default: n1708 = m_new_frame_energy_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1709 = tmp_new_frame_pitch_idx;
      5'b01000: n1709 = m_new_frame_pitch_idx;
      5'b00100: n1709 = m_new_frame_pitch_idx;
      5'b00010: n1709 = m_new_frame_pitch_idx;
      5'b00001: n1709 = m_new_frame_pitch_idx;
      default: n1709 = m_new_frame_pitch_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1710 = m_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1711 = n1703;
      5'b01000: n1711 = n1710;
      5'b00100: n1711 = n1710;
      5'b00010: n1711 = n1710;
      5'b00001: n1711 = n1710;
      default: n1711 = n1710;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1712 = m_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1713 = n1702;
      5'b01000: n1713 = n1712;
      5'b00100: n1713 = n1712;
      5'b00010: n1713 = n1712;
      5'b00001: n1713 = n1712;
      default: n1713 = n1712;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1714 = m_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1715 = n1701;
      5'b01000: n1715 = n1714;
      5'b00100: n1715 = n1714;
      5'b00010: n1715 = n1714;
      5'b00001: n1715 = n1714;
      default: n1715 = n1714;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1716 = m_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1717 = n1700;
      5'b01000: n1717 = n1716;
      5'b00100: n1717 = n1716;
      5'b00010: n1717 = n1716;
      5'b00001: n1717 = n1716;
      default: n1717 = n1716;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1718 = m_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1719 = n1699;
      5'b01000: n1719 = n1718;
      5'b00100: n1719 = n1718;
      5'b00010: n1719 = n1718;
      5'b00001: n1719 = n1718;
      default: n1719 = n1718;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1720 = m_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1721 = n1698;
      5'b01000: n1721 = n1720;
      5'b00100: n1721 = n1720;
      5'b00010: n1721 = n1720;
      5'b00001: n1721 = n1720;
      default: n1721 = n1720;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1722 = m_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1723 = n1697;
      5'b01000: n1723 = n1722;
      5'b00100: n1723 = n1722;
      5'b00010: n1723 = n1722;
      5'b00001: n1723 = n1722;
      default: n1723 = n1722;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1724 = m_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1725 = n1696;
      5'b01000: n1725 = n1724;
      5'b00100: n1725 = n1724;
      5'b00010: n1725 = n1724;
      5'b00001: n1725 = n1724;
      default: n1725 = n1724;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1726 = m_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1727 = n1695;
      5'b01000: n1727 = n1726;
      5'b00100: n1727 = n1726;
      5'b00010: n1727 = n1726;
      5'b00001: n1727 = n1726;
      default: n1727 = n1726;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:147:16 */
  assign n1728 = m_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1729 = n1694;
      5'b01000: n1729 = n1728;
      5'b00100: n1729 = n1728;
      5'b00010: n1729 = n1728;
      5'b00001: n1729 = n1728;
      default: n1729 = n1728;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1730 = tmp_new_frame_energy_idx;
      5'b01000: n1730 = tmp_new_frame_energy_idx;
      5'b00100: n1730 = tmp_new_frame_energy_idx;
      5'b00010: n1730 = tmp_new_frame_energy_idx;
      5'b00001: n1730 = n1439;
      default: n1730 = tmp_new_frame_energy_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1731 = tmp_new_frame_pitch_idx;
      5'b01000: n1731 = tmp_new_frame_pitch_idx;
      5'b00100: n1731 = tmp_new_frame_pitch_idx;
      5'b00010: n1731 = n1476;
      5'b00001: n1731 = tmp_new_frame_pitch_idx;
      default: n1731 = tmp_new_frame_pitch_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1732 = tmp_new_frame_k_idx;
      5'b01000: n1732 = n1679;
      5'b00100: n1732 = n1580;
      5'b00010: n1732 = tmp_new_frame_k_idx;
      5'b00001: n1732 = tmp_new_frame_k_idx;
      default: n1732 = tmp_new_frame_k_idx;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1734 = 1'b0;
      5'b01000: n1734 = n1687;
      5'b00100: n1734 = n1588;
      5'b00010: n1734 = n1487;
      5'b00001: n1734 = n1442;
      default: n1734 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1736 = 1'b0;
      5'b01000: n1736 = m_new_frame_voiced;
      5'b00100: n1736 = m_new_frame_voiced;
      5'b00010: n1736 = n1472;
      5'b00001: n1736 = n1443;
      default: n1736 = m_new_frame_voiced;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1738 = 1'b0;
      5'b01000: n1738 = m_new_frame_unvoiced;
      5'b00100: n1738 = m_new_frame_unvoiced;
      5'b00010: n1738 = n1474;
      5'b00001: n1738 = m_new_frame_unvoiced;
      default: n1738 = m_new_frame_unvoiced;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1739 = m_new_frame_repeat;
      5'b01000: n1739 = m_new_frame_repeat;
      5'b00100: n1739 = m_new_frame_repeat;
      5'b00010: n1739 = n1482;
      5'b00001: n1739 = m_new_frame_repeat;
      default: n1739 = m_new_frame_repeat;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1741 = 1'b0;
      5'b01000: n1741 = m_new_frame_zero;
      5'b00100: n1741 = m_new_frame_zero;
      5'b00010: n1741 = m_new_frame_zero;
      5'b00001: n1741 = n1444;
      default: n1741 = m_new_frame_zero;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1743 = 1'b0;
      5'b01000: n1743 = m_new_frame_stop;
      5'b00100: n1743 = m_new_frame_stop;
      5'b00010: n1743 = m_new_frame_stop;
      5'b00001: n1743 = n1445;
      default: n1743 = m_new_frame_stop;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:776:33 */
  always @*
    case (n1706)
      5'b10000: n1744 = n1379;
      5'b01000: n1744 = n1683;
      5'b00100: n1744 = n1584;
      5'b00010: n1744 = n1483;
      5'b00001: n1744 = n1446;
      default: n1744 = n1379;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:39 */
  assign n1751 = m_fifo_ptr[6:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:39 */
  assign n1753 = n1751 + 7'b1111000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:58 */
  assign n1756 = {24'b0, m_fifo_ptr};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:58 */
  assign n1758 = n1756 - 32'b00000000000000000000000000001000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:878:47 */
  assign n1759 = n1758[7:0];  // trunc
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:25 */
  assign n1760 = m_wr_pending ? n1759 : n1375;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:25 */
  assign n1762 = m_wr_pending ? 1'b0 : n1376;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:875:25 */
  assign n1763 = m_wr_pending ? n3288 : n1379;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1764 = n1408 ? n1707 : n1760;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1765 = n1408 ? n1708 : m_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1766 = n1408 ? n1709 : m_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1767 = {n1729, n1727, n1725, n1723, n1721, n1719, n1717, n1715, n1713, n1711};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1768 = n1408 ? n1767 : m_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1769 = n1408 ? n1730 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1770 = n1408 ? n1731 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1771 = n1408 ? n1732 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1773 = n1408 ? n1734 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1774 = n1408 ? n1376 : n1762;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1775 = n1408 ? n1736 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1776 = n1408 ? n1738 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1777 = n1408 ? n1739 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1778 = n1408 ? n1741 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1779 = n1408 ? n1743 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:774:25 */
  assign n1780 = n1408 ? n1744 : n1763;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1781 = n1396 ? n1375 : n1764;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1783 = n1396 ? 4'b0000 : n1765;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1785 = n1396 ? 7'b0000000 : n1766;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1787 = n1396 ? 50'b00000000000000000000011110111101111001110011100111 : n1768;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1788 = n1396 ? tmp_new_frame_energy_idx : n1769;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1789 = n1396 ? tmp_new_frame_pitch_idx : n1770;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1791 = n1396 ? 50'b00000000000000000000011110111101111001110011100111 : n1771;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1793 = n1396 ? 1'b0 : n1773;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1795 = n1396 ? n1376 : n1774;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1796 = n1396 ? m_new_frame_voiced : n1775;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1797 = n1396 ? m_new_frame_unvoiced : n1776;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1798 = n1396 ? m_new_frame_repeat : n1777;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1799 = n1396 ? m_new_frame_zero : n1778;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1800 = n1396 ? m_new_frame_stop : n1779;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:765:25 */
  assign n1801 = n1396 ? n1379 : n1780;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:215:17 */
  assign n1837 = {n191, n187, n184, n182};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  assign n1838 = n169 ? n151 : m_ic;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  always @(posedge m_clk)
    n1839 <= n1838;
  initial
    n1839 = 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  assign n1840 = n170 ? n163 : m_pc;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  always @(posedge m_clk)
    n1841 <= n1840;
  initial
    n1841 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  assign n1842 = n171 ? n124 : m_t;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  always @(posedge m_clk)
    n1843 <= n1842;
  initial
    n1843 = 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1844 = m_ena ? n1781 : m_fifo_ptr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1845 <= n1844;
  initial
    n1845 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:425:17 */
  assign n1846 = n388 ? n384 : m_pitch_count;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:425:17 */
  always @(posedge m_clk)
    n1847 <= n1846;
  initial
    n1847 = 9'b000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1848 = m_ena ? n1783 : m_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1849 <= n1848;
  initial
    n1849 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1850 = m_ena ? n1785 : m_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1851 <= n1850;
  initial
    n1851 = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1852 = m_ena ? n1787 : m_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1853 <= n1852;
  initial
    n1853 = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1854 = m_ena ? n1788 : tmp_new_frame_energy_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1855 <= n1854;
  initial
    n1855 = 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1856 = m_ena ? n1789 : tmp_new_frame_pitch_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1857 <= n1856;
  initial
    n1857 = 7'b0000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1858 = m_ena ? n1791 : tmp_new_frame_k_idx;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1859 <= n1858;
  initial
    n1859 = 50'b00000000000000000000011110111101111001110011100111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  assign n1860 = m_ena ? n1155 : m_u;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  always @(posedge m_clk)
    n1861 <= n1860;
  initial
    n1861 = 143'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  assign n1862 = m_ena ? n1157 : m_x;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  always @(posedge m_clk)
    n1863 <= n1862;
  initial
    n1863 = 130'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  assign n1864 = m_ena ? n259 : m_wr_busy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  always @(posedge m_clk)
    n1865 <= n1864;
  initial
    n1865 = 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  assign n1866 = m_ena ? n261 : m_wr_srv;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  always @(posedge m_clk)
    n1867 <= n1866;
  initial
    n1867 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  assign n1868 = m_ena ? n263 : m_wr_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  always @(posedge m_clk)
    n1869 <= n1868;
  initial
    n1869 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  assign n1870 = n172 ? n132 : m_cyca;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  always @(posedge m_clk)
    n1871 <= n1870;
  initial
    n1871 = 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:688:17 */
  assign n1872 = m_ena ? n1230 : m_ddis;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:688:17 */
  always @(posedge m_clk)
    n1873 <= n1872;
  initial
    n1873 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:510:17 */
  assign n1874 = m_ena ? n527 : m_olde;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:510:17 */
  always @(posedge m_clk)
    n1875 <= n1874;
  initial
    n1875 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:510:17 */
  assign n1876 = m_ena ? n529 : m_oldp;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:510:17 */
  always @(posedge m_clk)
    n1877 <= n1876;
  initial
    n1877 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  assign n1878 = n416 ? n405 : m_rdb_clr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  always @(posedge m_clk)
    n1879 <= n1878;
  initial
    n1879 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:17 */
  assign n1880 = n1215 ? n1204 : m_rdb_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:17 */
  always @(posedge m_clk)
    n1881 <= n1880;
  initial
    n1881 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:375:17 */
  assign n1882 = m_ena ? n281 : m_rdb_flag;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:375:17 */
  always @(posedge m_clk)
    n1883 <= n1882;
  initial
    n1883 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:17 */
  assign n1884 = n1216 ? n1207 : m_rst_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:17 */
  always @(posedge m_clk)
    n1885 <= n1884;
  initial
    n1885 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:17 */
  assign n1886 = n1217 ? n1210 : m_sxt_cmd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:657:17 */
  always @(posedge m_clk)
    n1887 <= n1886;
  initial
    n1887 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  assign n1888 = m_ena ? m_rsn : m_rsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  always @(posedge m_clk)
    n1889 <= n1888;
  initial
    n1889 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:494:17 */
  assign n1890 = m_ena ? n482 : m_spen;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:494:17 */
  always @(posedge m_clk)
    n1891 <= n1890;
  initial
    n1891 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:329:17 */
  assign n1892 = n196 ? n205 : m_t11;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:329:17 */
  always @(negedge m_clk)
    n1893 <= n1892;
  initial
    n1893 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:535:17 */
  assign n1894 = m_ena ? n570 : m_talk;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:535:17 */
  always @(posedge m_clk)
    n1895 <= n1894;
  initial
    n1895 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  assign n1896 = m_ena ? m_talk : m_talk_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  always @(posedge m_clk)
    n1897 <= n1896;
  initial
    n1897 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:535:17 */
  assign n1898 = m_ena ? n572 : m_talkd;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:535:17 */
  always @(posedge m_clk)
    n1899 <= n1898;
  initial
    n1899 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:688:17 */
  assign n1900 = m_ena ? m_talkd : m_talkd_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:688:17 */
  always @(posedge m_clk)
    n1901 <= n1900;
  initial
    n1901 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1902 = m_ena ? n1793 : m_uf;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1903 <= n1902;
  initial
    n1903 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1904 = m_ena ? m_wsn : m_wsn_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1905 <= n1904;
  initial
    n1905 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1906 = m_ena ? n1795 : m_wr_pending;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1907 <= n1906;
  initial
    n1907 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  assign n1908 = m_ena ? m_buffer_empty : m_buffer_empty_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  always @(posedge m_clk)
    n1909 <= n1908;
  initial
    n1909 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  assign n1910 = m_ena ? m_buffer_low : m_buffer_low_last;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  always @(posedge m_clk)
    n1911 <= n1910;
  initial
    n1911 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  assign n1912 = n173 ? m_cyca : m_cycb;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  always @(posedge m_clk)
    n1913 <= n1912;
  initial
    n1913 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:702:17 */
  assign n1914 = m_ena ? n1279 : m_inhibit;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:702:17 */
  always @(posedge m_clk)
    n1915 <= n1914;
  initial
    n1915 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  assign n1916 = m_ena ? n265 : m_io_ready;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:348:17 */
  always @(posedge m_clk)
    n1917 <= n1916;
  initial
    n1917 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  assign n1918 = m_ena ? n299 : m_irq_pin;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:388:17 */
  always @(posedge m_clk)
    n1919 <= n1918;
  initial
    n1919 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  assign n1920 = m_ena ? n413 : m_irq_pin_clr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  always @(posedge m_clk)
    n1921 <= n1920;
  initial
    n1921 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1922 = m_ena ? n1796 : m_new_frame_voiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1923 <= n1922;
  initial
    n1923 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1924 = m_ena ? n1797 : m_new_frame_unvoiced;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1925 <= n1924;
  initial
    n1925 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1926 = m_ena ? n1798 : m_new_frame_repeat;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1927 <= n1926;
  initial
    n1927 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1928 = m_ena ? n1799 : m_new_frame_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1929 <= n1928;
  initial
    n1929 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1930 = m_ena ? n1800 : m_new_frame_stop;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1931 <= n1930;
  initial
    n1931 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:425:17 */
  assign n1932 = n389 ? n365 : m_pitch_zero;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:425:17 */
  always @(posedge m_clk)
    n1933 <= n1932;
  initial
    n1933 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:17 */
  assign n1934 = m_ena ? n1337 : m_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:17 */
  always @(posedge m_clk)
    n1935 <= n1934;
  initial
    n1935 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:17 */
  assign n1936 = m_ena ? n1338 : m_uv_zpar;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:724:17 */
  always @(posedge m_clk)
    n1937 <= n1936;
  initial
    n1937 = 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  assign n1938 = m_ena ? n113 : phictr;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:279:17 */
  always @(posedge m_clk)
    n1939 <= n1938;
  initial
    n1939 = 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1940 = m_ena ? n1377 : m_wr_reg;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1941 <= n1940;
  initial
    n1941 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  assign n1942 = n419 ? n410 : m_dbo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:449:17 */
  always @(posedge m_clk)
    n1943 <= n1942;
  initial
    n1943 = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:329:17 */
  assign n1944 = n196 ? n206 : m_shift;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:329:17 */
  always @(negedge m_clk)
    n1945 <= n1944;
  initial
    n1945 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:408:17 */
  assign n1946 = m_ena ? n325 : m_rng;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:408:17 */
  always @(posedge m_clk)
    n1947 <= n1946;
  initial
    n1947 = 13'b1111111111111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:470:17 */
  assign n1948 = n451 ? n449 : m_excitation_data;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:470:17 */
  always @(posedge m_clk)
    n1949 <= n1948;
  initial
    n1949 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  assign n1950 = m_ena ? n1159 : m_previous_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  always @(posedge m_clk)
    n1951 <= n1950;
  initial
    n1951 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:558:17 */
  assign n1952 = m_ena ? n805 : m_current_energy;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:558:17 */
  always @(posedge m_clk)
    n1953 <= n1952;
  initial
    n1953 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:558:17 */
  assign n1954 = m_ena ? n807 : m_current_pitch;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:558:17 */
  always @(posedge m_clk)
    n1955 <= n1954;
  initial
    n1955 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  assign n1956 = m_ena ? n1160 : this_sample;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:604:17 */
  always @(posedge m_clk)
    n1957 <= n1956;
  initial
    n1957 = 14'b00000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:558:17 */
  assign n1958 = m_ena ? n808 : m_current_k;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:558:17 */
  always @(posedge m_clk)
    n1959 <= n1958;
  initial
    n1959 = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  assign n1960 = m_ena ? n1801 : m_fifo;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:746:17 */
  always @(posedge m_clk)
    n1961 <= n1960;
  initial
    n1961 = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:484:81 */
  reg [6:0] n1962[51:0] ; // memory
  initial begin
    n1962[51] = 7'b0000000;
    n1962[50] = 7'b0000000;
    n1962[49] = 7'b0000000;
    n1962[48] = 7'b0000000;
    n1962[47] = 7'b0000000;
    n1962[46] = 7'b0000000;
    n1962[45] = 7'b0000000;
    n1962[44] = 7'b0000000;
    n1962[43] = 7'b0000000;
    n1962[42] = 7'b0000000;
    n1962[41] = 7'b0000000;
    n1962[40] = 7'b0000000;
    n1962[39] = 7'b0000000;
    n1962[38] = 7'b0000000;
    n1962[37] = 7'b0000000;
    n1962[36] = 7'b0000000;
    n1962[35] = 7'b0000000;
    n1962[34] = 7'b0000000;
    n1962[33] = 7'b0000000;
    n1962[32] = 7'b0000000;
    n1962[31] = 7'b0000000;
    n1962[30] = 7'b0000000;
    n1962[29] = 7'b0000000;
    n1962[28] = 7'b0000000;
    n1962[27] = 7'b0000000;
    n1962[26] = 7'b0000000;
    n1962[25] = 7'b0000000;
    n1962[24] = 7'b0000000;
    n1962[23] = 7'b0000000;
    n1962[22] = 7'b0000000;
    n1962[21] = 7'b0000000;
    n1962[20] = 7'b0011101;
    n1962[19] = 7'b0011111;
    n1962[18] = 7'b0100101;
    n1962[17] = 7'b0011010;
    n1962[16] = 7'b0110111;
    n1962[15] = 7'b0010011;
    n1962[14] = 7'b0111011;
    n1962[13] = 7'b0110010;
    n1962[12] = 7'b0011010;
    n1962[11] = 7'b1000100;
    n1962[10] = 7'b1001100;
    n1962[9] = 7'b0100110;
    n1962[8] = 7'b0100101;
    n1962[7] = 7'b1010000;
    n1962[6] = 7'b1110001;
    n1962[5] = 7'b1101100;
    n1962[4] = 7'b1001100;
    n1962[3] = 7'b0101000;
    n1962[2] = 7'b0001111;
    n1962[1] = 7'b0000011;
    n1962[0] = 7'b0000000;
    end
  assign n1964 = n1962[n440];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:484:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:102 */
  reg [6:0] n1965[15:0] ; // memory
  initial begin
    n1965[15] = 7'b0000000;
    n1965[14] = 7'b1110010;
    n1965[13] = 7'b1010101;
    n1965[12] = 7'b0111111;
    n1965[11] = 7'b0101111;
    n1965[10] = 7'b0100001;
    n1965[9] = 7'b0010111;
    n1965[8] = 7'b0010000;
    n1965[7] = 7'b0001011;
    n1965[6] = 7'b0001000;
    n1965[5] = 7'b0000110;
    n1965[4] = 7'b0000100;
    n1965[3] = 7'b0000011;
    n1965[2] = 7'b0000010;
    n1965[1] = 7'b0000001;
    n1965[0] = 7'b0000000;
    end
  assign n1967 = n1965[m_new_frame_energy_idx];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:102 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:163 */
  reg [1:0] n1968[7:0] ; // memory
  initial begin
    n1968[7] = 2'b01;
    n1968[6] = 2'b01;
    n1968[5] = 2'b10;
    n1968[4] = 2'b10;
    n1968[3] = 2'b11;
    n1968[2] = 2'b11;
    n1968[1] = 2'b11;
    n1968[0] = 2'b00;
    end
  assign n1970 = n1968[m_ic];
  assign n1971 = n1968[m_ic];
  assign n1972 = n1968[m_ic];
  assign n1973 = n1968[m_ic];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:186 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:178 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:161 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:571:163 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:101 */
  reg [7:0] n1974[63:0] ; // memory
  initial begin
    n1974[63] = 8'b10011111;
    n1974[62] = 8'b10011001;
    n1974[61] = 8'b10010100;
    n1974[60] = 8'b10001110;
    n1974[59] = 8'b10001001;
    n1974[58] = 8'b10000100;
    n1974[57] = 8'b01111111;
    n1974[56] = 8'b01111010;
    n1974[55] = 8'b01110110;
    n1974[54] = 8'b01110010;
    n1974[53] = 8'b01101101;
    n1974[52] = 8'b01101001;
    n1974[51] = 8'b01100101;
    n1974[50] = 8'b01100010;
    n1974[49] = 8'b01011110;
    n1974[48] = 8'b01011011;
    n1974[47] = 8'b01010110;
    n1974[46] = 8'b01010100;
    n1974[45] = 8'b01010000;
    n1974[44] = 8'b01001110;
    n1974[43] = 8'b01001100;
    n1974[42] = 8'b01001000;
    n1974[41] = 8'b01000110;
    n1974[40] = 8'b01000100;
    n1974[39] = 8'b01000001;
    n1974[38] = 8'b00111110;
    n1974[37] = 8'b00111100;
    n1974[36] = 8'b00111010;
    n1974[35] = 8'b00111000;
    n1974[34] = 8'b00110101;
    n1974[33] = 8'b00110100;
    n1974[32] = 8'b00110010;
    n1974[31] = 8'b00110000;
    n1974[30] = 8'b00101110;
    n1974[29] = 8'b00101100;
    n1974[28] = 8'b00101010;
    n1974[27] = 8'b00101001;
    n1974[26] = 8'b00101000;
    n1974[25] = 8'b00100111;
    n1974[24] = 8'b00100110;
    n1974[23] = 8'b00100101;
    n1974[22] = 8'b00100100;
    n1974[21] = 8'b00100011;
    n1974[20] = 8'b00100010;
    n1974[19] = 8'b00100001;
    n1974[18] = 8'b00100000;
    n1974[17] = 8'b00011111;
    n1974[16] = 8'b00011110;
    n1974[15] = 8'b00011101;
    n1974[14] = 8'b00011100;
    n1974[13] = 8'b00011011;
    n1974[12] = 8'b00011010;
    n1974[11] = 8'b00011001;
    n1974[10] = 8'b00011000;
    n1974[9] = 8'b00010111;
    n1974[8] = 8'b00010110;
    n1974[7] = 8'b00010101;
    n1974[6] = 8'b00010100;
    n1974[5] = 8'b00010011;
    n1974[4] = 8'b00010010;
    n1974[3] = 8'b00010001;
    n1974[2] = 8'b00010000;
    n1974[1] = 8'b00001111;
    n1974[0] = 8'b00000000;
    end
  assign n1976 = n1974[n624];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:101 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:578:100 */
  reg [9:0] n1977[319:0] ; // memory
  initial begin
    n1977[319] = 10'b1000001011;
    n1977[318] = 10'b1000001110;
    n1977[317] = 10'b1000001111;
    n1977[316] = 10'b1000010001;
    n1977[315] = 10'b1000010011;
    n1977[314] = 10'b1000010101;
    n1977[313] = 10'b1000011000;
    n1977[312] = 10'b1000011110;
    n1977[311] = 10'b1000100010;
    n1977[310] = 10'b1000100110;
    n1977[309] = 10'b1000101011;
    n1977[308] = 10'b1000110000;
    n1977[307] = 10'b1000110101;
    n1977[306] = 10'b1000111100;
    n1977[305] = 10'b1001000011;
    n1977[304] = 10'b1001001011;
    n1977[303] = 10'b1001100100;
    n1977[302] = 10'b1010000100;
    n1977[301] = 10'b1010101101;
    n1977[300] = 10'b1011100000;
    n1977[299] = 10'b1100011101;
    n1977[298] = 10'b1101100010;
    n1977[297] = 10'b1110101111;
    n1977[296] = 10'b1111111111;
    n1977[295] = 10'b0001010000;
    n1977[294] = 10'b0010011101;
    n1977[293] = 10'b0011100010;
    n1977[292] = 10'b0100011111;
    n1977[291] = 10'b0101010001;
    n1977[290] = 10'b0101111011;
    n1977[289] = 10'b0110011011;
    n1977[288] = 10'b0110110100;
    n1977[287] = 10'b1010111000;
    n1977[286] = 10'b1011010001;
    n1977[285] = 10'b1011101110;
    n1977[284] = 10'b1100001100;
    n1977[283] = 10'b1100101101;
    n1977[282] = 10'b1101010001;
    n1977[281] = 10'b1101110110;
    n1977[280] = 10'b1110011101;
    n1977[279] = 10'b1111000101;
    n1977[278] = 10'b1111101110;
    n1977[277] = 10'b0000011000;
    n1977[276] = 10'b0001000000;
    n1977[275] = 10'b0001101001;
    n1977[274] = 10'b0010001111;
    n1977[273] = 10'b0010110100;
    n1977[272] = 10'b0011010111;
    n1977[271] = 10'b0011111000;
    n1977[270] = 10'b0100010110;
    n1977[269] = 10'b0100110010;
    n1977[268] = 10'b0101001011;
    n1977[267] = 10'b0101100010;
    n1977[266] = 10'b0101110110;
    n1977[265] = 10'b0110001000;
    n1977[264] = 10'b0110011000;
    n1977[263] = 10'b0110100110;
    n1977[262] = 10'b0110110011;
    n1977[261] = 10'b0110111101;
    n1977[260] = 10'b0111000111;
    n1977[259] = 10'b0111001111;
    n1977[258] = 10'b0111010110;
    n1977[257] = 10'b0111011100;
    n1977[256] = 10'b0111111010;
    n1977[255] = 10'b1001000111;
    n1977[254] = 10'b1001111101;
    n1977[253] = 10'b1010110011;
    n1977[252] = 10'b1011101001;
    n1977[251] = 10'b1100011111;
    n1977[250] = 10'b1101010101;
    n1977[249] = 10'b1110001011;
    n1977[248] = 10'b1111000001;
    n1977[247] = 10'b1111110111;
    n1977[246] = 10'b0000101101;
    n1977[245] = 10'b0001100010;
    n1977[244] = 10'b0010011000;
    n1977[243] = 10'b0011001110;
    n1977[242] = 10'b0100000100;
    n1977[241] = 10'b0100111010;
    n1977[240] = 10'b0101110000;
    n1977[239] = 10'b0000000000;
    n1977[238] = 10'b0000000000;
    n1977[237] = 10'b0000000000;
    n1977[236] = 10'b0000000000;
    n1977[235] = 10'b0000000000;
    n1977[234] = 10'b0000000000;
    n1977[233] = 10'b0000000000;
    n1977[232] = 10'b0000000000;
    n1977[231] = 10'b0000000000;
    n1977[230] = 10'b0000000000;
    n1977[229] = 10'b0000000000;
    n1977[228] = 10'b0000000000;
    n1977[227] = 10'b0000000000;
    n1977[226] = 10'b0000000000;
    n1977[225] = 10'b0000000000;
    n1977[224] = 10'b0000000000;
    n1977[223] = 10'b1010111000;
    n1977[222] = 10'b1011101111;
    n1977[221] = 10'b1100100111;
    n1977[220] = 10'b1101011111;
    n1977[219] = 10'b1110010110;
    n1977[218] = 10'b1111001110;
    n1977[217] = 10'b0000000101;
    n1977[216] = 10'b0000111101;
    n1977[215] = 10'b0001110100;
    n1977[214] = 10'b0010101100;
    n1977[213] = 10'b0011100100;
    n1977[212] = 10'b0100011011;
    n1977[211] = 10'b0101010011;
    n1977[210] = 10'b0110001010;
    n1977[209] = 10'b0111000010;
    n1977[208] = 10'b0111111010;
    n1977[207] = 10'b0000000000;
    n1977[206] = 10'b0000000000;
    n1977[205] = 10'b0000000000;
    n1977[204] = 10'b0000000000;
    n1977[203] = 10'b0000000000;
    n1977[202] = 10'b0000000000;
    n1977[201] = 10'b0000000000;
    n1977[200] = 10'b0000000000;
    n1977[199] = 10'b0000000000;
    n1977[198] = 10'b0000000000;
    n1977[197] = 10'b0000000000;
    n1977[196] = 10'b0000000000;
    n1977[195] = 10'b0000000000;
    n1977[194] = 10'b0000000000;
    n1977[193] = 10'b0000000000;
    n1977[192] = 10'b0000000000;
    n1977[191] = 10'b1010111000;
    n1977[190] = 10'b1011100110;
    n1977[189] = 10'b1100010101;
    n1977[188] = 10'b1101000011;
    n1977[187] = 10'b1101110010;
    n1977[186] = 10'b1110100000;
    n1977[185] = 10'b1111001110;
    n1977[184] = 10'b1111111101;
    n1977[183] = 10'b0000101011;
    n1977[182] = 10'b0001011010;
    n1977[181] = 10'b0010001000;
    n1977[180] = 10'b0010110110;
    n1977[179] = 10'b0011100101;
    n1977[178] = 10'b0100010011;
    n1977[177] = 10'b0101000010;
    n1977[176] = 10'b0101110000;
    n1977[175] = 10'b0000000000;
    n1977[174] = 10'b0000000000;
    n1977[173] = 10'b0000000000;
    n1977[172] = 10'b0000000000;
    n1977[171] = 10'b0000000000;
    n1977[170] = 10'b0000000000;
    n1977[169] = 10'b0000000000;
    n1977[168] = 10'b0000000000;
    n1977[167] = 10'b0000000000;
    n1977[166] = 10'b0000000000;
    n1977[165] = 10'b0000000000;
    n1977[164] = 10'b0000000000;
    n1977[163] = 10'b0000000000;
    n1977[162] = 10'b0000000000;
    n1977[161] = 10'b0000000000;
    n1977[160] = 10'b0000000000;
    n1977[159] = 10'b1100000000;
    n1977[158] = 10'b1100101100;
    n1977[157] = 10'b1101011000;
    n1977[156] = 10'b1110000101;
    n1977[155] = 10'b1110110001;
    n1977[154] = 10'b1111011101;
    n1977[153] = 10'b0000001010;
    n1977[152] = 10'b0000110110;
    n1977[151] = 10'b0001100010;
    n1977[150] = 10'b0010001111;
    n1977[149] = 10'b0010111011;
    n1977[148] = 10'b0011101000;
    n1977[147] = 10'b0100010100;
    n1977[146] = 10'b0101000000;
    n1977[145] = 10'b0101101101;
    n1977[144] = 10'b0110011001;
    n1977[143] = 10'b0000000000;
    n1977[142] = 10'b0000000000;
    n1977[141] = 10'b0000000000;
    n1977[140] = 10'b0000000000;
    n1977[139] = 10'b0000000000;
    n1977[138] = 10'b0000000000;
    n1977[137] = 10'b0000000000;
    n1977[136] = 10'b0000000000;
    n1977[135] = 10'b0000000000;
    n1977[134] = 10'b0000000000;
    n1977[133] = 10'b0000000000;
    n1977[132] = 10'b0000000000;
    n1977[131] = 10'b0000000000;
    n1977[130] = 10'b0000000000;
    n1977[129] = 10'b0000000000;
    n1977[128] = 10'b0000000000;
    n1977[127] = 10'b1011001100;
    n1977[126] = 10'b1011111100;
    n1977[125] = 10'b1100101100;
    n1977[124] = 10'b1101011100;
    n1977[123] = 10'b1110001011;
    n1977[122] = 10'b1110111011;
    n1977[121] = 10'b1111101011;
    n1977[120] = 10'b0000011011;
    n1977[119] = 10'b0001001011;
    n1977[118] = 10'b0001111010;
    n1977[117] = 10'b0010101010;
    n1977[116] = 10'b0011011010;
    n1977[115] = 10'b0100001010;
    n1977[114] = 10'b0100111010;
    n1977[113] = 10'b0101101001;
    n1977[112] = 10'b0110011001;
    n1977[111] = 10'b0000000000;
    n1977[110] = 10'b0000000000;
    n1977[109] = 10'b0000000000;
    n1977[108] = 10'b0000000000;
    n1977[107] = 10'b0000000000;
    n1977[106] = 10'b0000000000;
    n1977[105] = 10'b0000000000;
    n1977[104] = 10'b0000000000;
    n1977[103] = 10'b0000000000;
    n1977[102] = 10'b0000000000;
    n1977[101] = 10'b0000000000;
    n1977[100] = 10'b0000000000;
    n1977[99] = 10'b0000000000;
    n1977[98] = 10'b0000000000;
    n1977[97] = 10'b0000000000;
    n1977[96] = 10'b0000000000;
    n1977[95] = 10'b1100000000;
    n1977[94] = 10'b1101011111;
    n1977[93] = 10'b1110111110;
    n1977[92] = 10'b0000011101;
    n1977[91] = 10'b0001111100;
    n1977[90] = 10'b0011011011;
    n1977[89] = 10'b0100111010;
    n1977[88] = 10'b0110011001;
    n1977[87] = 10'b0000000000;
    n1977[86] = 10'b0000000000;
    n1977[85] = 10'b0000000000;
    n1977[84] = 10'b0000000000;
    n1977[83] = 10'b0000000000;
    n1977[82] = 10'b0000000000;
    n1977[81] = 10'b0000000000;
    n1977[80] = 10'b0000000000;
    n1977[79] = 10'b0000000000;
    n1977[78] = 10'b0000000000;
    n1977[77] = 10'b0000000000;
    n1977[76] = 10'b0000000000;
    n1977[75] = 10'b0000000000;
    n1977[74] = 10'b0000000000;
    n1977[73] = 10'b0000000000;
    n1977[72] = 10'b0000000000;
    n1977[71] = 10'b0000000000;
    n1977[70] = 10'b0000000000;
    n1977[69] = 10'b0000000000;
    n1977[68] = 10'b0000000000;
    n1977[67] = 10'b0000000000;
    n1977[66] = 10'b0000000000;
    n1977[65] = 10'b0000000000;
    n1977[64] = 10'b0000000000;
    n1977[63] = 10'b1100000000;
    n1977[62] = 10'b1101010000;
    n1977[61] = 10'b1110100000;
    n1977[60] = 10'b1111110001;
    n1977[59] = 10'b0001000001;
    n1977[58] = 10'b0010010010;
    n1977[57] = 10'b0011100010;
    n1977[56] = 10'b0100110011;
    n1977[55] = 10'b0000000000;
    n1977[54] = 10'b0000000000;
    n1977[53] = 10'b0000000000;
    n1977[52] = 10'b0000000000;
    n1977[51] = 10'b0000000000;
    n1977[50] = 10'b0000000000;
    n1977[49] = 10'b0000000000;
    n1977[48] = 10'b0000000000;
    n1977[47] = 10'b0000000000;
    n1977[46] = 10'b0000000000;
    n1977[45] = 10'b0000000000;
    n1977[44] = 10'b0000000000;
    n1977[43] = 10'b0000000000;
    n1977[42] = 10'b0000000000;
    n1977[41] = 10'b0000000000;
    n1977[40] = 10'b0000000000;
    n1977[39] = 10'b0000000000;
    n1977[38] = 10'b0000000000;
    n1977[37] = 10'b0000000000;
    n1977[36] = 10'b0000000000;
    n1977[35] = 10'b0000000000;
    n1977[34] = 10'b0000000000;
    n1977[33] = 10'b0000000000;
    n1977[32] = 10'b0000000000;
    n1977[31] = 10'b1100110011;
    n1977[30] = 10'b1101111100;
    n1977[29] = 10'b1111000101;
    n1977[28] = 10'b0000001110;
    n1977[27] = 10'b0001010111;
    n1977[26] = 10'b0010100000;
    n1977[25] = 10'b0011101010;
    n1977[24] = 10'b0100110011;
    n1977[23] = 10'b0000000000;
    n1977[22] = 10'b0000000000;
    n1977[21] = 10'b0000000000;
    n1977[20] = 10'b0000000000;
    n1977[19] = 10'b0000000000;
    n1977[18] = 10'b0000000000;
    n1977[17] = 10'b0000000000;
    n1977[16] = 10'b0000000000;
    n1977[15] = 10'b0000000000;
    n1977[14] = 10'b0000000000;
    n1977[13] = 10'b0000000000;
    n1977[12] = 10'b0000000000;
    n1977[11] = 10'b0000000000;
    n1977[10] = 10'b0000000000;
    n1977[9] = 10'b0000000000;
    n1977[8] = 10'b0000000000;
    n1977[7] = 10'b0000000000;
    n1977[6] = 10'b0000000000;
    n1977[5] = 10'b0000000000;
    n1977[4] = 10'b0000000000;
    n1977[3] = 10'b0000000000;
    n1977[2] = 10'b0000000000;
    n1977[1] = 10'b0000000000;
    n1977[0] = 10'b0000000000;
    end
  assign n1979 = n1977[n1978];
  assign n1981 = n1977[n1980];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:133 */
  assign n1978 = {n753, n764};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:111 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:125 */
  assign n1980 = {n674, n685};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:98 */
  reg [2:0] n1982[9:0] ; // memory
  initial begin
    n1982[9] = 3'b011;
    n1982[8] = 3'b011;
    n1982[7] = 3'b011;
    n1982[6] = 3'b100;
    n1982[5] = 3'b100;
    n1982[4] = 3'b100;
    n1982[3] = 3'b100;
    n1982[2] = 3'b100;
    n1982[1] = 3'b101;
    n1982[0] = 3'b101;
    end
  assign n1984 = n1982[n1625];
  assign n1985 = n1982[n1614];
  assign n1986 = n1982[n1601];
  assign n1987 = n1982[n1526];
  assign n1988 = n1982[n1515];
  assign n1989 = n1982[n1501];
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:839:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:836:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:835:98 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:817:81 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:814:103 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:813:98 */
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:96 */
  assign n1991 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:96 */
  assign n1992 = n1991[n665 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:130 */
  assign n1994 = {30'bX, m_new_frame_k_idx};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:130 */
  assign n1995 = n1994[n681 * 5 +: 5]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:154 */
  assign n1997 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:583:154 */
  assign n1998 = n1997[n696 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n1999 = n658[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2000 = ~n1999;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2001 = n658[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2002 = ~n2001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2003 = n2000 & n2002;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2004 = n2000 & n2001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2005 = n1999 & n2002;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2006 = n658[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2007 = ~n2006;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2008 = n2003 & n2007;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2009 = n2003 & n2006;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2010 = n2004 & n2007;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2011 = n2004 & n2006;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2012 = n2005 & n2007;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2013 = n658[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2014 = ~n2013;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2015 = n2008 & n2014;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2016 = n2008 & n2013;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2017 = n2009 & n2014;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2018 = n2009 & n2013;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2019 = n2010 & n2014;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2020 = n2010 & n2013;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2021 = n2011 & n2014;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2022 = n2011 & n2013;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2023 = n2012 & n2014;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2024 = n2012 & n2013;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2025 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2026 = n2015 ? n710 : n2025;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2027 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2028 = n2016 ? n710 : n2027;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2029 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2030 = n2017 ? n710 : n2029;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2031 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2032 = n2018 ? n710 : n2031;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2033 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2034 = n2019 ? n710 : n2033;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2035 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2036 = n2020 ? n710 : n2035;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2037 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2038 = n2021 ? n710 : n2037;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2039 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2040 = n2022 ? n710 : n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2041 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2042 = n2023 ? n710 : n2041;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2043 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2044 = n2024 ? n710 : n2043;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:582:57 */
  assign n2045 = {n2044, n2042, n2040, n2038, n2036, n2034, n2032, n2030, n2028, n2026};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2046 = n723[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2047 = ~n2046;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2048 = n723[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2049 = ~n2048;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2050 = n2047 & n2049;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2051 = n2047 & n2048;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2052 = n2046 & n2049;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2053 = n723[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2054 = ~n2053;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2055 = n2050 & n2054;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2056 = n2050 & n2053;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2057 = n2051 & n2054;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2058 = n2051 & n2053;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2059 = n2052 & n2054;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2060 = n723[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2061 = ~n2060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2062 = n2055 & n2061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2063 = n2055 & n2060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2064 = n2056 & n2061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2065 = n2056 & n2060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2066 = n2057 & n2061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2067 = n2057 & n2060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2068 = n2058 & n2061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2069 = n2058 & n2060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2070 = n2059 & n2061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2071 = n2059 & n2060;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2072 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2073 = n2062 ? 10'b0000000000 : n2072;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2074 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2075 = n2063 ? 10'b0000000000 : n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2076 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2077 = n2064 ? 10'b0000000000 : n2076;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2078 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2079 = n2065 ? 10'b0000000000 : n2078;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2080 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2081 = n2066 ? 10'b0000000000 : n2080;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2082 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2083 = n2067 ? 10'b0000000000 : n2082;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2084 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2085 = n2068 ? 10'b0000000000 : n2084;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2086 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2087 = n2069 ? 10'b0000000000 : n2086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2088 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2089 = n2070 ? 10'b0000000000 : n2088;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2090 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2091 = n2071 ? 10'b0000000000 : n2090;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:587:57 */
  assign n2092 = {n2091, n2089, n2087, n2085, n2083, n2081, n2079, n2077, n2075, n2073};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:104 */
  assign n2094 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:104 */
  assign n2095 = n2094[n744 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:138 */
  assign n2097 = {30'bX, m_new_frame_k_idx};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:138 */
  assign n2098 = n2097[n760 * 5 +: 5]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:162 */
  assign n2100 = {60'bX, m_current_k};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:591:162 */
  assign n2101 = n2100[n774 * 10 +: 10]; //(Bmux)
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2102 = n737[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2103 = ~n2102;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2104 = n737[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2105 = ~n2104;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2106 = n2103 & n2105;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2107 = n2103 & n2104;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2108 = n2102 & n2105;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2109 = n737[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2110 = ~n2109;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2111 = n2106 & n2110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2112 = n2106 & n2109;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2113 = n2107 & n2110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2114 = n2107 & n2109;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2115 = n2108 & n2110;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2116 = n737[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2117 = ~n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2118 = n2111 & n2117;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2119 = n2111 & n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2120 = n2112 & n2117;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2121 = n2112 & n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2122 = n2113 & n2117;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2123 = n2113 & n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2124 = n2114 & n2117;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2125 = n2114 & n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2126 = n2115 & n2117;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2127 = n2115 & n2116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2128 = m_current_k[9:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2129 = n2118 ? n788 : n2128;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2130 = m_current_k[19:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2131 = n2119 ? n788 : n2130;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2132 = m_current_k[29:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2133 = n2120 ? n788 : n2132;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2134 = m_current_k[39:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2135 = n2121 ? n788 : n2134;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2136 = m_current_k[49:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2137 = n2122 ? n788 : n2136;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2138 = m_current_k[59:50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2139 = n2123 ? n788 : n2138;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2140 = m_current_k[69:60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2141 = n2124 ? n788 : n2140;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2142 = m_current_k[79:70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2143 = n2125 ? n788 : n2142;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2144 = m_current_k[89:80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2145 = n2126 ? n788 : n2144;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2146 = m_current_k[99:90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2147 = n2127 ? n788 : n2146;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:590:65 */
  assign n2148 = {n2147, n2145, n2143, n2141, n2139, n2137, n2135, n2133, n2131, n2129};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2149 = n1539[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2150 = ~n2149;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2151 = n1539[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2152 = ~n2151;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2153 = n2150 & n2152;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2154 = n2150 & n2151;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2155 = n2149 & n2152;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2156 = n1539[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2157 = ~n2156;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2158 = n2153 & n2157;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2159 = n2153 & n2156;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2160 = n2154 & n2157;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2161 = n2154 & n2156;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2162 = n2155 & n2157;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2163 = n1539[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2164 = ~n2163;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2165 = n2158 & n2164;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2166 = n2158 & n2163;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2167 = n2159 & n2164;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2168 = n2159 & n2163;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2169 = n2160 & n2164;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2170 = n2160 & n2163;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2171 = n2161 & n2164;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2172 = n2161 & n2163;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2173 = n2162 & n2164;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2174 = n2162 & n2163;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2175 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2176 = n2165 ? n1541 : n2175;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2177 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2178 = n2166 ? n1541 : n2177;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2179 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2180 = n2167 ? n1541 : n2179;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2181 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2182 = n2168 ? n1541 : n2181;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2183 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2184 = n2169 ? n1541 : n2183;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2185 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2186 = n2170 ? n1541 : n2185;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2187 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2188 = n2171 ? n1541 : n2187;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2189 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2190 = n2172 ? n1541 : n2189;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2191 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2192 = n2173 ? n1541 : n2191;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2193 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2194 = n2174 ? n1541 : n2193;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:820:81 */
  assign n2195 = {n2194, n2192, n2190, n2188, n2186, n2184, n2182, n2180, n2178, n2176};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2196 = n1554[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2197 = ~n2196;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2198 = n1554[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2199 = ~n2198;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2200 = n2197 & n2199;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2201 = n2197 & n2198;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2202 = n2196 & n2199;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2203 = n1554[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2204 = ~n2203;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2205 = n2200 & n2204;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2206 = n2200 & n2203;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2207 = n2201 & n2204;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2208 = n2201 & n2203;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2209 = n2202 & n2204;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2210 = n1554[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2211 = ~n2210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2212 = n2205 & n2211;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2213 = n2205 & n2210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2214 = n2206 & n2211;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2215 = n2206 & n2210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2216 = n2207 & n2211;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2217 = n2207 & n2210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2218 = n2208 & n2211;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2219 = n2208 & n2210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2220 = n2209 & n2211;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2221 = n2209 & n2210;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2222 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2223 = n2212 ? n1558 : n2222;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2224 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2225 = n2213 ? n1558 : n2224;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2226 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2227 = n2214 ? n1558 : n2226;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2228 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2229 = n2215 ? n1558 : n2228;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2230 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2231 = n2216 ? n1558 : n2230;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2232 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2233 = n2217 ? n1558 : n2232;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2234 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2235 = n2218 ? n1558 : n2234;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2236 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2237 = n2219 ? n1558 : n2236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2238 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2239 = n2220 ? n1558 : n2238;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2240 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2241 = n2221 ? n1558 : n2240;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:823:81 */
  assign n2242 = {n2241, n2239, n2237, n2235, n2233, n2231, n2229, n2227, n2225, n2223};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2243 = n1570[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2244 = ~n2243;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2245 = n1570[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2246 = ~n2245;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2247 = n2244 & n2246;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2248 = n2244 & n2245;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2249 = n2243 & n2246;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2250 = n1570[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2251 = ~n2250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2252 = n2247 & n2251;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2253 = n2247 & n2250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2254 = n2248 & n2251;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2255 = n2248 & n2250;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2256 = n2249 & n2251;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2257 = n1570[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2258 = ~n2257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2259 = n2252 & n2258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2260 = n2252 & n2257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2261 = n2253 & n2258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2262 = n2253 & n2257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2263 = n2254 & n2258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2264 = n2254 & n2257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2265 = n2255 & n2258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2266 = n2255 & n2257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2267 = n2256 & n2258;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2268 = n2256 & n2257;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2269 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2270 = n2259 ? n1574 : n2269;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2271 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2272 = n2260 ? n1574 : n2271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2273 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2274 = n2261 ? n1574 : n2273;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2275 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2276 = n2262 ? n1574 : n2275;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2277 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2278 = n2263 ? n1574 : n2277;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2279 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2280 = n2264 ? n1574 : n2279;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2281 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2282 = n2265 ? n1574 : n2281;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2283 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2284 = n2266 ? n1574 : n2283;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2285 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2286 = n2267 ? n1574 : n2285;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2287 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2288 = n2268 ? n1574 : n2287;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:826:81 */
  assign n2289 = {n2288, n2286, n2284, n2282, n2280, n2278, n2276, n2274, n2272, n2270};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2290 = n1638[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2291 = ~n2290;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2292 = n1638[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2293 = ~n2292;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2294 = n2291 & n2293;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2295 = n2291 & n2292;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2296 = n2290 & n2293;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2297 = n1638[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2298 = ~n2297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2299 = n2294 & n2298;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2300 = n2294 & n2297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2301 = n2295 & n2298;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2302 = n2295 & n2297;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2303 = n2296 & n2298;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2304 = n1638[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2305 = ~n2304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2306 = n2299 & n2305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2307 = n2299 & n2304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2308 = n2300 & n2305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2309 = n2300 & n2304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2310 = n2301 & n2305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2311 = n2301 & n2304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2312 = n2302 & n2305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2313 = n2302 & n2304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2314 = n2303 & n2305;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2315 = n2303 & n2304;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2316 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2317 = n2306 ? n1640 : n2316;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2318 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2319 = n2307 ? n1640 : n2318;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2320 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2321 = n2308 ? n1640 : n2320;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2322 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2323 = n2309 ? n1640 : n2322;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2324 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2325 = n2310 ? n1640 : n2324;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2326 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2327 = n2311 ? n1640 : n2326;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2328 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2329 = n2312 ? n1640 : n2328;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2330 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2331 = n2313 ? n1640 : n2330;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2332 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2333 = n2314 ? n1640 : n2332;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2334 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2335 = n2315 ? n1640 : n2334;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:842:81 */
  assign n2336 = {n2335, n2333, n2331, n2329, n2327, n2325, n2323, n2321, n2319, n2317};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2337 = n1653[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2338 = ~n2337;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2339 = n1653[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2340 = ~n2339;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2341 = n2338 & n2340;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2342 = n2338 & n2339;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2343 = n2337 & n2340;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2344 = n1653[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2345 = ~n2344;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2346 = n2341 & n2345;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2347 = n2341 & n2344;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2348 = n2342 & n2345;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2349 = n2342 & n2344;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2350 = n2343 & n2345;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2351 = n1653[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2352 = ~n2351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2353 = n2346 & n2352;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2354 = n2346 & n2351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2355 = n2347 & n2352;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2356 = n2347 & n2351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2357 = n2348 & n2352;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2358 = n2348 & n2351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2359 = n2349 & n2352;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2360 = n2349 & n2351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2361 = n2350 & n2352;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2362 = n2350 & n2351;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2363 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2364 = n2353 ? n1657 : n2363;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2365 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2366 = n2354 ? n1657 : n2365;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2367 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2368 = n2355 ? n1657 : n2367;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2369 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2370 = n2356 ? n1657 : n2369;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2371 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2372 = n2357 ? n1657 : n2371;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2373 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2374 = n2358 ? n1657 : n2373;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2375 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2376 = n2359 ? n1657 : n2375;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2377 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2378 = n2360 ? n1657 : n2377;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2379 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2380 = n2361 ? n1657 : n2379;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2381 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2382 = n2362 ? n1657 : n2381;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:845:81 */
  assign n2383 = {n2382, n2380, n2378, n2376, n2374, n2372, n2370, n2368, n2366, n2364};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2384 = n1669[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2385 = ~n2384;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2386 = n1669[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2387 = ~n2386;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2388 = n2385 & n2387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2389 = n2385 & n2386;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2390 = n2384 & n2387;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2391 = n1669[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2392 = ~n2391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2393 = n2388 & n2392;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2394 = n2388 & n2391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2395 = n2389 & n2392;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2396 = n2389 & n2391;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2397 = n2390 & n2392;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2398 = n1669[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2399 = ~n2398;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2400 = n2393 & n2399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2401 = n2393 & n2398;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2402 = n2394 & n2399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2403 = n2394 & n2398;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2404 = n2395 & n2399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2405 = n2395 & n2398;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2406 = n2396 & n2399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2407 = n2396 & n2398;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2408 = n2397 & n2399;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2409 = n2397 & n2398;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2410 = tmp_new_frame_k_idx[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2411 = n2400 ? n1673 : n2410;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2412 = tmp_new_frame_k_idx[9:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2413 = n2401 ? n1673 : n2412;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2414 = tmp_new_frame_k_idx[14:10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2415 = n2402 ? n1673 : n2414;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2416 = tmp_new_frame_k_idx[19:15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2417 = n2403 ? n1673 : n2416;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2418 = tmp_new_frame_k_idx[24:20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2419 = n2404 ? n1673 : n2418;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2420 = tmp_new_frame_k_idx[29:25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2421 = n2405 ? n1673 : n2420;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2422 = tmp_new_frame_k_idx[34:30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2423 = n2406 ? n1673 : n2422;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2424 = tmp_new_frame_k_idx[39:35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2425 = n2407 ? n1673 : n2424;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2426 = tmp_new_frame_k_idx[44:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2427 = n2408 ? n1673 : n2426;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2428 = tmp_new_frame_k_idx[49:45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2429 = n2409 ? n1673 : n2428;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:848:81 */
  assign n2430 = {n2429, n2427, n2425, n2423, n2421, n2419, n2417, n2415, n2413, n2411};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2431 = n1753[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2432 = ~n2431;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2433 = n1753[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2434 = ~n2433;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2435 = n2432 & n2434;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2436 = n2432 & n2433;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2437 = n2431 & n2434;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2438 = n2431 & n2433;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2439 = n1753[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2440 = ~n2439;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2441 = n2435 & n2440;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2442 = n2435 & n2439;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2443 = n2436 & n2440;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2444 = n2436 & n2439;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2445 = n2437 & n2440;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2446 = n2437 & n2439;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2447 = n2438 & n2440;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2448 = n2438 & n2439;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2449 = n1753[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2450 = ~n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2451 = n2441 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2452 = n2441 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2453 = n2442 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2454 = n2442 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2455 = n2443 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2456 = n2443 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2457 = n2444 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2458 = n2444 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2459 = n2445 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2460 = n2445 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2461 = n2446 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2462 = n2446 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2463 = n2447 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2464 = n2447 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2465 = n2448 & n2450;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2466 = n2448 & n2449;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2467 = n1753[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2468 = ~n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2469 = n2451 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2470 = n2451 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2471 = n2452 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2472 = n2452 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2473 = n2453 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2474 = n2453 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2475 = n2454 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2476 = n2454 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2477 = n2455 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2478 = n2455 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2479 = n2456 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2480 = n2456 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2481 = n2457 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2482 = n2457 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2483 = n2458 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2484 = n2458 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2485 = n2459 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2486 = n2459 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2487 = n2460 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2488 = n2460 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2489 = n2461 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2490 = n2461 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2491 = n2462 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2492 = n2462 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2493 = n2463 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2494 = n2463 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2495 = n2464 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2496 = n2464 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2497 = n2465 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2498 = n2465 & n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2499 = n2466 & n2468;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2500 = n1753[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2501 = ~n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2502 = n2469 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2503 = n2469 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2504 = n2470 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2505 = n2470 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2506 = n2471 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2507 = n2471 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2508 = n2472 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2509 = n2472 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2510 = n2473 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2511 = n2473 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2512 = n2474 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2513 = n2474 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2514 = n2475 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2515 = n2475 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2516 = n2476 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2517 = n2476 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2518 = n2477 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2519 = n2477 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2520 = n2478 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2521 = n2478 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2522 = n2479 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2523 = n2479 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2524 = n2480 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2525 = n2480 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2526 = n2481 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2527 = n2481 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2528 = n2482 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2529 = n2482 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2530 = n2483 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2531 = n2483 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2532 = n2484 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2533 = n2484 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2534 = n2485 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2535 = n2485 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2536 = n2486 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2537 = n2486 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2538 = n2487 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2539 = n2487 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2540 = n2488 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2541 = n2488 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2542 = n2489 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2543 = n2489 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2544 = n2490 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2545 = n2490 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2546 = n2491 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2547 = n2491 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2548 = n2492 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2549 = n2492 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2550 = n2493 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2551 = n2493 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2552 = n2494 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2553 = n2494 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2554 = n2495 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2555 = n2495 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2556 = n2496 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2557 = n2496 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2558 = n2497 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2559 = n2497 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2560 = n2498 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2561 = n2498 & n2500;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2562 = n2499 & n2501;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2563 = n1753[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2564 = ~n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2565 = n2502 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2566 = n2502 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2567 = n2503 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2568 = n2503 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2569 = n2504 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2570 = n2504 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2571 = n2505 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2572 = n2505 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2573 = n2506 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2574 = n2506 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2575 = n2507 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2576 = n2507 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2577 = n2508 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2578 = n2508 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2579 = n2509 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2580 = n2509 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2581 = n2510 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2582 = n2510 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2583 = n2511 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2584 = n2511 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2585 = n2512 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2586 = n2512 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2587 = n2513 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2588 = n2513 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2589 = n2514 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2590 = n2514 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2591 = n2515 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2592 = n2515 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2593 = n2516 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2594 = n2516 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2595 = n2517 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2596 = n2517 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2597 = n2518 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2598 = n2518 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2599 = n2519 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2600 = n2519 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2601 = n2520 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2602 = n2520 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2603 = n2521 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2604 = n2521 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2605 = n2522 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2606 = n2522 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2607 = n2523 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2608 = n2523 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2609 = n2524 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2610 = n2524 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2611 = n2525 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2612 = n2525 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2613 = n2526 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2614 = n2526 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2615 = n2527 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2616 = n2527 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2617 = n2528 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2618 = n2528 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2619 = n2529 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2620 = n2529 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2621 = n2530 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2622 = n2530 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2623 = n2531 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2624 = n2531 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2625 = n2532 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2626 = n2532 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2627 = n2533 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2628 = n2533 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2629 = n2534 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2630 = n2534 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2631 = n2535 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2632 = n2535 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2633 = n2536 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2634 = n2536 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2635 = n2537 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2636 = n2537 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2637 = n2538 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2638 = n2538 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2639 = n2539 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2640 = n2539 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2641 = n2540 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2642 = n2540 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2643 = n2541 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2644 = n2541 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2645 = n2542 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2646 = n2542 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2647 = n2543 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2648 = n2543 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2649 = n2544 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2650 = n2544 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2651 = n2545 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2652 = n2545 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2653 = n2546 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2654 = n2546 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2655 = n2547 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2656 = n2547 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2657 = n2548 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2658 = n2548 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2659 = n2549 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2660 = n2549 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2661 = n2550 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2662 = n2550 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2663 = n2551 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2664 = n2551 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2665 = n2552 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2666 = n2552 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2667 = n2553 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2668 = n2553 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2669 = n2554 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2670 = n2554 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2671 = n2555 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2672 = n2555 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2673 = n2556 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2674 = n2556 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2675 = n2557 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2676 = n2557 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2677 = n2558 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2678 = n2558 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2679 = n2559 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2680 = n2559 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2681 = n2560 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2682 = n2560 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2683 = n2561 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2684 = n2561 & n2563;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2685 = n2562 & n2564;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2686 = n1379[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2687 = n2565 ? m_wr_reg : n2686;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2688 = n2687[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2689 = n1379[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2690 = n2687[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2691 = {n2689, n2690};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2692 = n2566 ? m_wr_reg : n2691;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2693 = n2692[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2694 = n1379[9]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2695 = n2692[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2696 = {n2694, n2695};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2697 = n2567 ? m_wr_reg : n2696;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2698 = n2697[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2699 = n1379[10]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2700 = n2697[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2701 = {n2699, n2700};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2702 = n2568 ? m_wr_reg : n2701;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2703 = n2702[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2704 = n1379[11]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2705 = n2702[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2706 = {n2704, n2705};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2707 = n2569 ? m_wr_reg : n2706;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2708 = n2707[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2709 = n1379[12]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2710 = n2707[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2711 = {n2709, n2710};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2712 = n2570 ? m_wr_reg : n2711;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2713 = n2712[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2714 = n1379[13]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2715 = n2712[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2716 = {n2714, n2715};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2717 = n2571 ? m_wr_reg : n2716;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2718 = n2717[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2719 = n1379[14]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2720 = n2717[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2721 = {n2719, n2720};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2722 = n2572 ? m_wr_reg : n2721;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2723 = n2722[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2724 = n1379[15]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2725 = n2722[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2726 = {n2724, n2725};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2727 = n2573 ? m_wr_reg : n2726;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2728 = n2727[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2729 = n1379[16]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2730 = n2727[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2731 = {n2729, n2730};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2732 = n2574 ? m_wr_reg : n2731;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2733 = n2732[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2734 = n1379[17]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2735 = n2732[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2736 = {n2734, n2735};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2737 = n2575 ? m_wr_reg : n2736;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2738 = n2737[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2739 = n1379[18]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2740 = n2737[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2741 = {n2739, n2740};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2742 = n2576 ? m_wr_reg : n2741;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2743 = n2742[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2744 = n1379[19]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2745 = n2742[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2746 = {n2744, n2745};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2747 = n2577 ? m_wr_reg : n2746;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2748 = n2747[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2749 = n1379[20]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2750 = n2747[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2751 = {n2749, n2750};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2752 = n2578 ? m_wr_reg : n2751;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2753 = n2752[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2754 = n1379[21]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2755 = n2752[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2756 = {n2754, n2755};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2757 = n2579 ? m_wr_reg : n2756;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2758 = n2757[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2759 = n1379[22]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2760 = n2757[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2761 = {n2759, n2760};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2762 = n2580 ? m_wr_reg : n2761;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2763 = n2762[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2764 = n1379[23]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2765 = n2762[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2766 = {n2764, n2765};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2767 = n2581 ? m_wr_reg : n2766;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2768 = n2767[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2769 = n1379[24]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2770 = n2767[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2771 = {n2769, n2770};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2772 = n2582 ? m_wr_reg : n2771;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2773 = n2772[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2774 = n1379[25]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2775 = n2772[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2776 = {n2774, n2775};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2777 = n2583 ? m_wr_reg : n2776;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2778 = n2777[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2779 = n1379[26]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2780 = n2777[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2781 = {n2779, n2780};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2782 = n2584 ? m_wr_reg : n2781;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2783 = n2782[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2784 = n1379[27]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2785 = n2782[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2786 = {n2784, n2785};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2787 = n2585 ? m_wr_reg : n2786;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2788 = n2787[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2789 = n1379[28]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2790 = n2787[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2791 = {n2789, n2790};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2792 = n2586 ? m_wr_reg : n2791;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2793 = n2792[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2794 = n1379[29]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2795 = n2792[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2796 = {n2794, n2795};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2797 = n2587 ? m_wr_reg : n2796;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2798 = n2797[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2799 = n1379[30]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2800 = n2797[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2801 = {n2799, n2800};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2802 = n2588 ? m_wr_reg : n2801;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2803 = n2802[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2804 = n1379[31]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2805 = n2802[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2806 = {n2804, n2805};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2807 = n2589 ? m_wr_reg : n2806;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2808 = n2807[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2809 = n1379[32]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2810 = n2807[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2811 = {n2809, n2810};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2812 = n2590 ? m_wr_reg : n2811;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2813 = n2812[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2814 = n1379[33]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2815 = n2812[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2816 = {n2814, n2815};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2817 = n2591 ? m_wr_reg : n2816;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2818 = n2817[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2819 = n1379[34]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2820 = n2817[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2821 = {n2819, n2820};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2822 = n2592 ? m_wr_reg : n2821;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2823 = n2822[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2824 = n1379[35]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2825 = n2822[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2826 = {n2824, n2825};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2827 = n2593 ? m_wr_reg : n2826;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2828 = n2827[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2829 = n1379[36]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2830 = n2827[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2831 = {n2829, n2830};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2832 = n2594 ? m_wr_reg : n2831;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2833 = n2832[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2834 = n1379[37]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2835 = n2832[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2836 = {n2834, n2835};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2837 = n2595 ? m_wr_reg : n2836;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2838 = n2837[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2839 = n1379[38]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2840 = n2837[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2841 = {n2839, n2840};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2842 = n2596 ? m_wr_reg : n2841;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2843 = n2842[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2844 = n1379[39]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2845 = n2842[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2846 = {n2844, n2845};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2847 = n2597 ? m_wr_reg : n2846;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2848 = n2847[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2849 = n1379[40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2850 = n2847[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2851 = {n2849, n2850};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2852 = n2598 ? m_wr_reg : n2851;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2853 = n2852[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2854 = n1379[41]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2855 = n2852[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2856 = {n2854, n2855};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2857 = n2599 ? m_wr_reg : n2856;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2858 = n2857[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2859 = n1379[42]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2860 = n2857[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2861 = {n2859, n2860};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2862 = n2600 ? m_wr_reg : n2861;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2863 = n2862[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2864 = n1379[43]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2865 = n2862[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2866 = {n2864, n2865};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2867 = n2601 ? m_wr_reg : n2866;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2868 = n2867[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2869 = n1379[44]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2870 = n2867[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2871 = {n2869, n2870};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2872 = n2602 ? m_wr_reg : n2871;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2873 = n2872[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2874 = n1379[45]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2875 = n2872[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2876 = {n2874, n2875};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2877 = n2603 ? m_wr_reg : n2876;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2878 = n2877[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2879 = n1379[46]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2880 = n2877[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2881 = {n2879, n2880};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2882 = n2604 ? m_wr_reg : n2881;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2883 = n2882[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2884 = n1379[47]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2885 = n2882[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2886 = {n2884, n2885};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2887 = n2605 ? m_wr_reg : n2886;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2888 = n2887[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2889 = n1379[48]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2890 = n2887[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2891 = {n2889, n2890};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2892 = n2606 ? m_wr_reg : n2891;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2893 = n2892[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2894 = n1379[49]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2895 = n2892[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2896 = {n2894, n2895};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2897 = n2607 ? m_wr_reg : n2896;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2898 = n2897[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2899 = n1379[50]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2900 = n2897[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2901 = {n2899, n2900};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2902 = n2608 ? m_wr_reg : n2901;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2903 = n2902[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2904 = n1379[51]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2905 = n2902[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2906 = {n2904, n2905};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2907 = n2609 ? m_wr_reg : n2906;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2908 = n2907[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2909 = n1379[52]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2910 = n2907[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2911 = {n2909, n2910};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2912 = n2610 ? m_wr_reg : n2911;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2913 = n2912[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2914 = n1379[53]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2915 = n2912[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2916 = {n2914, n2915};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2917 = n2611 ? m_wr_reg : n2916;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2918 = n2917[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2919 = n1379[54]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2920 = n2917[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2921 = {n2919, n2920};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2922 = n2612 ? m_wr_reg : n2921;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2923 = n2922[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2924 = n1379[55]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2925 = n2922[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2926 = {n2924, n2925};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2927 = n2613 ? m_wr_reg : n2926;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2928 = n2927[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2929 = n1379[56]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2930 = n2927[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2931 = {n2929, n2930};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2932 = n2614 ? m_wr_reg : n2931;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2933 = n2932[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2934 = n1379[57]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2935 = n2932[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2936 = {n2934, n2935};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2937 = n2615 ? m_wr_reg : n2936;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2938 = n2937[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2939 = n1379[58]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2940 = n2937[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2941 = {n2939, n2940};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2942 = n2616 ? m_wr_reg : n2941;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2943 = n2942[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2944 = n1379[59]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2945 = n2942[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2946 = {n2944, n2945};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2947 = n2617 ? m_wr_reg : n2946;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2948 = n2947[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2949 = n1379[60]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2950 = n2947[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2951 = {n2949, n2950};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2952 = n2618 ? m_wr_reg : n2951;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2953 = n2952[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2954 = n1379[61]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2955 = n2952[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2956 = {n2954, n2955};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2957 = n2619 ? m_wr_reg : n2956;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2958 = n2957[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2959 = n1379[62]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2960 = n2957[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2961 = {n2959, n2960};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2962 = n2620 ? m_wr_reg : n2961;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2963 = n2962[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2964 = n1379[63]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2965 = n2962[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2966 = {n2964, n2965};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2967 = n2621 ? m_wr_reg : n2966;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2968 = n2967[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2969 = n1379[64]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2970 = n2967[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2971 = {n2969, n2970};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2972 = n2622 ? m_wr_reg : n2971;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2973 = n2972[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2974 = n1379[65]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2975 = n2972[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2976 = {n2974, n2975};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2977 = n2623 ? m_wr_reg : n2976;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2978 = n2977[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2979 = n1379[66]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2980 = n2977[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2981 = {n2979, n2980};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2982 = n2624 ? m_wr_reg : n2981;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2983 = n2982[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2984 = n1379[67]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2985 = n2982[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2986 = {n2984, n2985};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2987 = n2625 ? m_wr_reg : n2986;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2988 = n2987[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2989 = n1379[68]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2990 = n2987[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2991 = {n2989, n2990};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2992 = n2626 ? m_wr_reg : n2991;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2993 = n2992[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2994 = n1379[69]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2995 = n2992[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2996 = {n2994, n2995};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2997 = n2627 ? m_wr_reg : n2996;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2998 = n2997[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n2999 = n1379[70]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3000 = n2997[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3001 = {n2999, n3000};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3002 = n2628 ? m_wr_reg : n3001;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3003 = n3002[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3004 = n1379[71]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3005 = n3002[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3006 = {n3004, n3005};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3007 = n2629 ? m_wr_reg : n3006;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3008 = n3007[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3009 = n1379[72]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3010 = n3007[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3011 = {n3009, n3010};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3012 = n2630 ? m_wr_reg : n3011;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3013 = n3012[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3014 = n1379[73]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3015 = n3012[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3016 = {n3014, n3015};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3017 = n2631 ? m_wr_reg : n3016;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3018 = n3017[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3019 = n1379[74]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3020 = n3017[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3021 = {n3019, n3020};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3022 = n2632 ? m_wr_reg : n3021;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3023 = n3022[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3024 = n1379[75]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3025 = n3022[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3026 = {n3024, n3025};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3027 = n2633 ? m_wr_reg : n3026;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3028 = n3027[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3029 = n1379[76]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3030 = n3027[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3031 = {n3029, n3030};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3032 = n2634 ? m_wr_reg : n3031;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3033 = n3032[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3034 = n1379[77]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3035 = n3032[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3036 = {n3034, n3035};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3037 = n2635 ? m_wr_reg : n3036;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3038 = n3037[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3039 = n1379[78]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3040 = n3037[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3041 = {n3039, n3040};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3042 = n2636 ? m_wr_reg : n3041;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3043 = n3042[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3044 = n1379[79]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3045 = n3042[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3046 = {n3044, n3045};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3047 = n2637 ? m_wr_reg : n3046;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3048 = n3047[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3049 = n1379[80]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3050 = n3047[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3051 = {n3049, n3050};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3052 = n2638 ? m_wr_reg : n3051;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3053 = n3052[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3054 = n1379[81]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3055 = n3052[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3056 = {n3054, n3055};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3057 = n2639 ? m_wr_reg : n3056;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3058 = n3057[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3059 = n1379[82]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3060 = n3057[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3061 = {n3059, n3060};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3062 = n2640 ? m_wr_reg : n3061;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3063 = n3062[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3064 = n1379[83]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3065 = n3062[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3066 = {n3064, n3065};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3067 = n2641 ? m_wr_reg : n3066;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3068 = n3067[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3069 = n1379[84]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3070 = n3067[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3071 = {n3069, n3070};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3072 = n2642 ? m_wr_reg : n3071;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3073 = n3072[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3074 = n1379[85]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3075 = n3072[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3076 = {n3074, n3075};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3077 = n2643 ? m_wr_reg : n3076;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3078 = n3077[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3079 = n1379[86]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3080 = n3077[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3081 = {n3079, n3080};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3082 = n2644 ? m_wr_reg : n3081;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3083 = n3082[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3084 = n1379[87]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3085 = n3082[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3086 = {n3084, n3085};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3087 = n2645 ? m_wr_reg : n3086;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3088 = n3087[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3089 = n1379[88]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3090 = n3087[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3091 = {n3089, n3090};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3092 = n2646 ? m_wr_reg : n3091;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3093 = n3092[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3094 = n1379[89]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3095 = n3092[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3096 = {n3094, n3095};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3097 = n2647 ? m_wr_reg : n3096;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3098 = n3097[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3099 = n1379[90]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3100 = n3097[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3101 = {n3099, n3100};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3102 = n2648 ? m_wr_reg : n3101;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3103 = n3102[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3104 = n1379[91]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3105 = n3102[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3106 = {n3104, n3105};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3107 = n2649 ? m_wr_reg : n3106;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3108 = n3107[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3109 = n1379[92]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3110 = n3107[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3111 = {n3109, n3110};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3112 = n2650 ? m_wr_reg : n3111;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3113 = n3112[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3114 = n1379[93]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3115 = n3112[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3116 = {n3114, n3115};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3117 = n2651 ? m_wr_reg : n3116;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3118 = n3117[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3119 = n1379[94]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3120 = n3117[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3121 = {n3119, n3120};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3122 = n2652 ? m_wr_reg : n3121;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3123 = n3122[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3124 = n1379[95]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3125 = n3122[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3126 = {n3124, n3125};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3127 = n2653 ? m_wr_reg : n3126;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3128 = n3127[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3129 = n1379[96]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3130 = n3127[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3131 = {n3129, n3130};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3132 = n2654 ? m_wr_reg : n3131;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3133 = n3132[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3134 = n1379[97]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3135 = n3132[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3136 = {n3134, n3135};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3137 = n2655 ? m_wr_reg : n3136;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3138 = n3137[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3139 = n1379[98]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3140 = n3137[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3141 = {n3139, n3140};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3142 = n2656 ? m_wr_reg : n3141;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3143 = n3142[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3144 = n1379[99]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3145 = n3142[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3146 = {n3144, n3145};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3147 = n2657 ? m_wr_reg : n3146;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3148 = n3147[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3149 = n1379[100]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3150 = n3147[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3151 = {n3149, n3150};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3152 = n2658 ? m_wr_reg : n3151;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3153 = n3152[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3154 = n1379[101]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3155 = n3152[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3156 = {n3154, n3155};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3157 = n2659 ? m_wr_reg : n3156;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3158 = n3157[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3159 = n1379[102]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3160 = n3157[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3161 = {n3159, n3160};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3162 = n2660 ? m_wr_reg : n3161;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3163 = n3162[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3164 = n1379[103]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3165 = n3162[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3166 = {n3164, n3165};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3167 = n2661 ? m_wr_reg : n3166;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3168 = n3167[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3169 = n1379[104]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3170 = n3167[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3171 = {n3169, n3170};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3172 = n2662 ? m_wr_reg : n3171;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3173 = n3172[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3174 = n1379[105]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3175 = n3172[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3176 = {n3174, n3175};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3177 = n2663 ? m_wr_reg : n3176;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3178 = n3177[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3179 = n1379[106]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3180 = n3177[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3181 = {n3179, n3180};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3182 = n2664 ? m_wr_reg : n3181;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3183 = n3182[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3184 = n1379[107]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3185 = n3182[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3186 = {n3184, n3185};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3187 = n2665 ? m_wr_reg : n3186;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3188 = n3187[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3189 = n1379[108]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3190 = n3187[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3191 = {n3189, n3190};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3192 = n2666 ? m_wr_reg : n3191;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3193 = n3192[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3194 = n1379[109]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3195 = n3192[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3196 = {n3194, n3195};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3197 = n2667 ? m_wr_reg : n3196;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3198 = n3197[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3199 = n1379[110]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3200 = n3197[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3201 = {n3199, n3200};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3202 = n2668 ? m_wr_reg : n3201;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3203 = n3202[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3204 = n1379[111]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3205 = n3202[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3206 = {n3204, n3205};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3207 = n2669 ? m_wr_reg : n3206;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3208 = n3207[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3209 = n1379[112]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3210 = n3207[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3211 = {n3209, n3210};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3212 = n2670 ? m_wr_reg : n3211;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3213 = n3212[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3214 = n1379[113]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3215 = n3212[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3216 = {n3214, n3215};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3217 = n2671 ? m_wr_reg : n3216;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3218 = n3217[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3219 = n1379[114]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3220 = n3217[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3221 = {n3219, n3220};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3222 = n2672 ? m_wr_reg : n3221;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3223 = n3222[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3224 = n1379[115]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3225 = n3222[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3226 = {n3224, n3225};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3227 = n2673 ? m_wr_reg : n3226;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3228 = n3227[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3229 = n1379[116]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3230 = n3227[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3231 = {n3229, n3230};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3232 = n2674 ? m_wr_reg : n3231;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3233 = n3232[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3234 = n1379[117]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3235 = n3232[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3236 = {n3234, n3235};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3237 = n2675 ? m_wr_reg : n3236;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3238 = n3237[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3239 = n1379[118]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3240 = n3237[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3241 = {n3239, n3240};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3242 = n2676 ? m_wr_reg : n3241;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3243 = n3242[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3244 = n1379[119]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3245 = n3242[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3246 = {n3244, n3245};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3247 = n2677 ? m_wr_reg : n3246;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3248 = n3247[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3249 = n1379[120]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3250 = n3247[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3251 = {n3249, n3250};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3252 = n2678 ? m_wr_reg : n3251;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3253 = n3252[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3254 = n1379[121]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3255 = n3252[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3256 = {n3254, n3255};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3257 = n2679 ? m_wr_reg : n3256;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3258 = n3257[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3259 = n1379[122]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3260 = n3257[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3261 = {n3259, n3260};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3262 = n2680 ? m_wr_reg : n3261;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3263 = n3262[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3264 = n1379[123]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3265 = n3262[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3266 = {n3264, n3265};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3267 = n2681 ? m_wr_reg : n3266;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3268 = n3267[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3269 = n1379[124]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3270 = n3267[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3271 = {n3269, n3270};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3272 = n2682 ? m_wr_reg : n3271;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3273 = n3272[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3274 = n1379[125]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3275 = n3272[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3276 = {n3274, n3275};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3277 = n2683 ? m_wr_reg : n3276;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3278 = n3277[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3279 = n1379[126]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3280 = n3277[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3281 = {n3279, n3280};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3282 = n2684 ? m_wr_reg : n3281;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3283 = n3282[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3284 = n1379[127]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3285 = n3282[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3286 = {n3284, n3285};
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3287 = n2685 ? m_wr_reg : n3286;
  /*# /Users/scottmoschella/work/supersprint/modules/sound-tms5220/TMS5220.vhd:877:33 */
  assign n3288 = {n3287, n3283, n3278, n3273, n3268, n3263, n3258, n3253, n3248, n3243, n3238, n3233, n3228, n3223, n3218, n3213, n3208, n3203, n3198, n3193, n3188, n3183, n3178, n3173, n3168, n3163, n3158, n3153, n3148, n3143, n3138, n3133, n3128, n3123, n3118, n3113, n3108, n3103, n3098, n3093, n3088, n3083, n3078, n3073, n3068, n3063, n3058, n3053, n3048, n3043, n3038, n3033, n3028, n3023, n3018, n3013, n3008, n3003, n2998, n2993, n2988, n2983, n2978, n2973, n2968, n2963, n2958, n2953, n2948, n2943, n2938, n2933, n2928, n2923, n2918, n2913, n2908, n2903, n2898, n2893, n2888, n2883, n2878, n2873, n2868, n2863, n2858, n2853, n2848, n2843, n2838, n2833, n2828, n2823, n2818, n2813, n2808, n2803, n2798, n2793, n2788, n2783, n2778, n2773, n2768, n2763, n2758, n2753, n2748, n2743, n2738, n2733, n2728, n2723, n2718, n2713, n2708, n2703, n2698, n2693, n2688};
endmodule

