1 '##########################################################'
2 '### PistonAsmb
3 '###
4 '### Modifications:
5 '###  - 24.07.2015 RJN        Created
6 '###
7 '### Process of Operation:
8 '### Check if the cylinder color is black
9 '### Pick the piston from the Pallet
10 '### Places it to the p_ProductAsm (product assembly) position
11 '###
12 '### Local positions to teach:
13 '###
14 '### Global positions to teach (UBP):
15 '###  - j_Home                                        Home position
16 '###  - p_ProductAsm       Tool 1 - Red cylinder      Product assembly position
17 '###  - p_BlkPistonPal1    Tool 3 - Black Piston      First black piston in the pallet
18 '###  - p_BlkPistonPal4    Tool 3 - Black Piston      Last black piston in the pallet
19 '###  - p_SilPistonPal1    Tool 3 - Silver Piston     First silver piston in the pallet
20 '###  - p_SilPistonPal4    Tool 3 - Silver Piston     Last silver piston in the pallet
21 '###
22 '##########################################################'
23 '
24 '##########################################################'
25 '        Decleration Of Input parameters for the function
26 '##########################################################'
27 Def Inte mBlack 'Color of the cylinder being assembeled
28 FPrm mBlack%
29 '
30 '###########################################################'
31 '       Declaration Of Local positions
32 '###########################################################'
33 Def Plt 1,p_BlkPistonPal1,p_BlkPistonPal4,p_BlkPistonPal1,,4,1,2 'Pallet definition for Black pistons
34 Def Plt 2,p_SilPistonPal1,p_SilPistonPal4,p_SilPistonPal1,,4,1,2 'Pallet definition for Silver pistons
35 Def Pos pColorOffset    'Z offset for different cylinder colors
36 '
37 '###########################################################'
38 '       Declaration Of Local variables
39 '###########################################################'
40 Def Inte mTmpCnt 'Temporary counter for piston count
41 '
42 '###########################################################'
43 '       Declaration Of Interrupts
44 '###########################################################'
45 Def Act 1, M_In(i_StopButton) = 0 GoSub *Stopped
46 Act 1 = 1
47 '
48 '
49 '
50 '###########################################################'
51 '       Program
52 '###########################################################'
53 '
54 '>>>>>> Check if there is a matching piston available <<<<<<<<'
55 If (mBlack% = 1 And m_SilCnt > 4) Or (mBlack% = 0 And m_BlkCnt > 4)  Then
56     m_Q1Light% = 0
57     m_Q2Light% = 0
58     m_StartLight% = 1
59     Wait M_In(i_StartButton) = 1
60     m_StartLight% = 0
61     m_Q1Light% = -1
62     m_Q2Light% = -1
63     m_SilCnt = 1
64     m_BlkCnt = 1
65 EndIf
66 '
67 '>>>>>> Pick the Piston from the Pallet <<<<<<<<'
68 M_Tool = m_Piston
69 Spd m_SpdFast
70 HOpen 1
71 If mBlack% Then
72     Mvs  (Plt 2,m_SilCnt), -50
73     Spd m_SpdSlow
74     Mvs  (Plt 2,m_SilCnt)
75     Dly        0.1
76     HClose    1
77     Dly        0.5
78     Mvs  (Plt 2,m_SilCnt), -50
79     m_SilCnt = m_SilCnt + 1
80 Else
81     Mvs  (Plt 1,m_BlkCnt), -50
82     Spd m_SpdSlow
83     Mvs  (Plt 1,m_BlkCnt)
84     Dly        0.1
85     HClose    1
86     Dly        0.5
87     Mvs  (Plt 1,m_BlkCnt), -50
88     m_BlkCnt = m_BlkCnt + 1
89 EndIf
90 '
91 '>>>>>> Place Piston to product assembly position <<<<<<<<'
92 Spd     m_SpdFast
93 Cnt  1
94 Mvs  p_ProductAsm,-50
95 Spd  m_SpdSlow
96 Cnt  0
97 Mvs p_ProductAsm
98 Dly 0.1
99 HOpen 1
100 Dly 0.5
101 Mvs p_ProductAsm, -50
102 '
103 End
104 '
105 '
106 '
107 '###########################################################'
108 '       Interrupts
109 '###########################################################'
110 '
111 '>>>>>> Stop button <<<<<<<<'
112 *Stopped
113     m_StartLight% = 1             'blink LED at START button
114     Wait M_In(i_StartButton) = 1  'wait for START button pressed
115     m_StartLight% = 0             'set LED at START button to steady
116     Return 0
p_BlkPistonPal1=(+369.62,+92.40,+77.25,+179.99,-0.01,+135.03)(7,0)
p_BlkPistonPal4=(+369.86,+167.27,+77.32,+179.99,-0.01,+135.02)(7,0)
p_SilPistonPal1=(+339.44,+93.40,+76.66,+180.00,+0.00,+44.98)(7,0)
p_SilPistonPal4=(+339.49,+168.61,+77.72,+179.99,-0.01,+44.98)(7,0)
pColorOffset=(0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00)(,)
p_ProductAsm=(+396.94,-20.59,+57.75,+179.99,-0.21,-180.00)(7,0)
