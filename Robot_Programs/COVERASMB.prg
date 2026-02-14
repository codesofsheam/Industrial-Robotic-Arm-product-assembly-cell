1 '##########################################################'
2 '### CoverAsmb
3 '###
4 '### Modifications:
5 '###  - 24.07.2015 DABO        Created
6 '###
7 '### Process of Operation:
8 '### Distributing a cover from the magazine
9 '### Pick it from the magazine and screw it on the cylinder at p_PrdAsm
10 '###
11 '### Local positions to teach:
12 '###
13 '### Global positions to teach (UBP):
14 '###  - j_Home                                        Home position
15 '###  - p_ProductAsm       Tool 1 - Red cylinder      Product assembly position
16 '###  - p_CoverMagazine    Tool 1 - Blue cover        Cover pickup position
17 '###  - p_CoverOriCheck    Tool 1 - Blue cover        Cover orientation check position
18 '###  - p_Magazine2        Tool 1 - Red cylinder      Magazine 2 for bad covers
19 '###
20 '##########################################################'
21 '
22 '##########################################################'
23 ' Decleration Of Input parameters for the function
24 '##########################################################'
25 Def Inte mBlack 'If the cylinder is black
26 FPrm mBlack%
27 '
28 '###########################################################'
29 '       Declaration Of Local positions
30 '###########################################################'
31 Def Pos pColorOffset    'Z offset for different cylinder colors
32 Def Pos pCoverHeight    'Z offset for cover height
33 pCoverHeight = (+0.00,+0.00,+2.00,+0.00,+0.00,+0.00)
34 Def Pos pCoverWithAngle 'Product assembly position adjusted with cover angle and cover height
35 Def Float fScrewAngle   'Screwing angle
36 fScrewAngle = Rad(65)
37 Def Jnt jCoverScrewedOn 'Calculated position to screw the cap onv the cylinder
38 '
39 '###########################################################'
40 '       Declaration Of Local variables
41 '###########################################################'
42 Def Inte mBad        'The last cover was bad, we have to retry
43 '
44 '###########################################################'
45 '       Declaration Of Interrupts
46 '###########################################################'
47 Def Act 1, M_In(i_StopButton) = 0 GoSub *Stopped
48 Act 1 = 1
49 '
50 '
51 '
52 '###########################################################'
53 '       Program
54 '###########################################################'
55 '
56 '>>>>>> Set color offset according to the input parameter <<<<<<<'
57 If mBlack% = 1 Then
58     pColorOffset = (+0.00,+0.00,-2.00,+0.00,+0.00,+0.00)
59 Else
60     pColorOffset = (+0.00,+0.00,+0.00,+0.00,+0.00,+0.00)
61 EndIf
62 '
63 *Retry:
64     '
65     '>>>>>> Distribute cover from magazine <<<<<<<'
66     XRun 3,"DistCover",1
67     Wait M_Run(3) = 1
68     '
69     '>>>>>> Pick cover from p_CoverMagazine and move to p_CoverOriCheck <<<<<<<<'
70     M_Tool = m_Center
71     Cnt 1
72     JOvrd m_OvrdFast
73     Mov  p_CoverMagazine, -50
74     Wait M_Run(3) = 0
75     Cnt 0
76     Spd m_SpdSlow
77     Mvs  p_CoverMagazine
78     Dly  0.1
79     HClose 1
80     Dly  0.5
81     Cnt 1
82     Mvs  p_CoverMagazine, -50
83     JOvrd m_OvrdFast
84     Mov  p_CoverOriCheck, -50
85     Cnt 0
86     Spd m_SpdSlow
87     Mvs  p_CoverOriCheck
88     '
89     '>>>>>> Check orientation <<<<<<<<'
90     Dly 0.1
91     CallP "SearchEdge", p_CoverOriCheck, 240
92     If m_EdgeDir% > 0 Then
93         '>>>>>> Calculate product assembly position <<<<<<<<'
94         pCoverWithAngle = p_ProductAsm + pCoverHeight + pColorOffset
95         If m_EdgeDir% = 1 Then
96             'rising edge
97             pCoverWithAngle.C = P_Curr.C - Rad(30)
98         Else
99             'falling edge
100             pCoverWithAngle.C = P_Curr.C - Rad(0)
101         EndIf
102         '
103         '>>>>>> Move cover to product assembly position <<<<<<<<'
104         Cnt 1
105         Spd m_SpdSlow
106         Mvs  P_Curr, -50
107         JOvrd m_OvrdFast
108         Mov  pCoverWithAngle, -50
109         Cnt 0
110         Spd m_SpdSlow
111         Mvs  pCoverWithAngle
112         '
113         '
114         '>>>>>> Screw on the cover <<<<<<<<'
115         Dly  0.1
116         jCoverScrewedOn = J_Curr
117         jCoverScrewedOn.J6 = jCoverScrewedOn.J6 + fScrewAngle
118         JOvrd m_OvrdVerySlow
119         Mov  jCoverScrewedOn
120         Dly  0.1
121         HOpen 1
122         Dly  0.5
123         Cnt 1
124         Spd m_SpdFast
125         Mvs  P_Curr, -10
126         mBad% = 0
127     Else
128         '>>>>>> Drop bad cover into magazine 2 <<<<<<<<'
129         Cnt 1
130         Spd m_SpdSlow
131         Mvs  P_Curr, -250
132         JOvrd m_OvrdFast
133         Mov  p_Magazine2, -30
134         Cnt 0
135         Spd m_SpdSlow
136         Mvs  p_Magazine2
137         Dly  0.1
138         HOpen 1
139         Dly  0.5
140         Cnt 1
141         Mvs  p_Magazine2, -30
142         JOvrd m_OvrdFast
143         Mov  j_Home
144         mBad% = 1
145     EndIf
146     '
147     If mBad% = 1 Then GoTo *Retry
148     End
149 '
150 '
151 '
152 '###########################################################'
153 '       Interrupts
154 '###########################################################'
155 '
156 '>>>>>> Stop button <<<<<<<<'
157 *Stopped
158     m_StartLight% = 1             'blink LED at START button
159     Wait M_In(i_StartButton) = 1  'wait for START button pressed
160     m_StartLight% = 0             'set LED at START button to steady
161     Return 0
pColorOffset=(+0.00,+0.00,+0.00,+0.00,+0.00,+0.00)(,)
pCoverHeight=(+0.00,+0.00,+2.00,+0.00,+0.00,+0.00)(,)
pCoverWithAngle=(+396.94,-20.59,+59.75,+179.99,-0.21,-10.43)(7,0)
pScrewAngle=(+0.00,+0.00,+0.00,+0.00,+0.00,-65.00)(,)
p_CoverMagazine=(+250.94,+147.66,+62.92,-180.00,+0.00,-180.00)(7,0)
p_CoverOriCheck=(+320.44,-4.50,+58.52,-180.00,+0.00,+0.00)(7,0)
p_ProductAsm=(+396.94,-20.59,+57.75,+179.99,-0.21,-180.00)(7,0)
p_Magazine2=(+394.54,-145.87,+254.06,-180.00,+0.00,+90.00)(7,0)
jCoverScrewedOn=(-2.95,+55.57,+85.97,-0.06,+38.26,-107.48)
j_Home=(+25.98,-14.31,+133.92,-1.44,+60.90,+26.31)
