1 '##########################################################'
2 '### CylinderAsmb
3 '###
4 '### Modifications:
5 '###  - 24.07.2015 DABO/RJN        Created
6 '###
7 '### Process of Operation:
8 '### The Robot picks the cylinder from p_Belt position with outer gripper
9 '### It places to the p_CylinderReGrip and checks the color
10 '### Picks it with center gripper and checks the orientation
11 '### Places it to the p_ProductAsm (product assembly) position
12 '###
13 '### Local positions to teach:
14 '###
15 '### Global positions to teach (UBP):
16 '###  - j_Home                                            Home position
17 '###  - p_ProductAsm         Tool 1 - Red cylinder        Product assembly position
18 '###  - p_CylinderReGrip     Tool 1 - Red cylinder        Cylinder regripp position (where the color is checked)
19 '###  - p_CylindOriCheck     Tool 1 - Ref. tool           Cylinder orientation check position
20 '###  - p_Magazine1          Tool 1 - Red cylinder        Magazine 1 for bad cylinders
21 '###  - p_Belt               Tool 2 - Red cylinder        Arrival posiiton of the cylinder at conveyor belt
22 '###
23 '##########################################################'
24 '
25 '###########################################################'
26 '       Declaration Of Local positions
27 '###########################################################'
28 Def Pos pCylindColCheck 'Color check of the cylinder
29 pCylindColCheck = p_CylinderReGrip + (-38.00,+54.00,-10.00,+0.00,+0.00,-8.00)
30 Def Pos pColorOffset    'Z offset for different cylinder colors
31 Def Pos pCylAsmRotated    'Product assembly position adjusted with cylinder angle
32 '
33 '###########################################################'
34 '       Declaration Of Interrupts
35 '###########################################################'
36 Def Act 1, M_In(i_StopButton) = 0 GoSub *Stopped
37 Act 1 = 1
38 '
39 '
40 '
41 '###########################################################'
42 '       Program
43 '###########################################################'
44 '
45 '>>>>>> Pick cylinder from p_Belt drop at p_CylinderReGrip <<<<<<<<'
46 M_Tool = m_Outer
47 Cnt 1
48 JOvrd m_OvrdFast
49 Mov  p_Belt, -50
50 Cnt 0
51 Spd m_SpdSlow
52 Mvs  p_Belt
53 Dly  0.1
54 HClose 1
55 Dly  0.5
56 Cnt 1
57 Mvs  p_Belt, -50
58 JOvrd m_OvrdFast
59 Mov  p_CylinderReGrip, -50
60 Cnt 0
61 Spd m_SpdSlow
62 Mvs  p_CylinderReGrip
63 Dly  0.1
64 HOpen 1
65 Dly  0.5
66 Cnt 1
67 Mvs  p_CylinderReGrip, -50
68 '
69 '>>>>>> Check color <<<<<<<<'
70 M_Tool = m_Center
71 JOvrd m_OvrdFast
72 Mov  pCylindColCheck,-50
73 Spd m_SpdSlow
74 Mvs  pCylindColCheck
75 Dly  0.5
76 If  M_In(i_SensColCheck) = 1 Then
77     pColorOffset = (+0.00,+0.00,+0.00,+0.00,+0.00,+0.00)
78     m_Return = 0
79 Else
80     pColorOffset = (+0.00,+0.00,-2.00,+0.00,+0.00,+0.00)
81     m_Return = 1
82 EndIf
83 Mvs pCylindColCheck,-50
84 '
85 '>>>>>> Move cylinder to orientation check position <<<<<<<<'
86 M_Tool = m_Center
87 JOvrd m_OvrdFast
88 Mov  p_CylinderReGrip,-50
89 Cnt 0
90 Spd m_SpdSlow
91 Mvs  p_CylinderReGrip + pColorOffset
92 Dly  0.1
93 HClose 1
94 Dly  0.5
95 Cnt 1
96 Mvs  p_CylinderReGrip, -10
97 JOvrd m_OvrdFast
98 Mov  p_CylindOriCheck, -10
99 Cnt 0
100 Spd m_SpdSlow
101 Mvs  p_CylindOriCheck + pColorOffset
102 Spd m_SpdVerySlow
103 '
104 '>>>>>> Check orientation <<<<<<<<'
105 Dly 0.5
106 CallP "SearchEdge", p_CylindOriCheck+pColorOffset, 175
107 If m_EdgeDir% > 0 Then
108     '>>>>>> Calculate product assembly position <<<<<<<<'
109     pCylAsmRotated = p_ProductAsm + pColorOffset
110     If m_EdgeDir% = 1 Then
111         'rising edge
112         pCylAsmRotated.C = p_EdgePos.C - Rad(30)
113     Else
114         'falling edge
115         pCylAsmRotated.C = p_EdgePos.C - Rad(35)
116     EndIf
117     '
118     '>>>>>> Move cylinder to product assembly position <<<<<<<<'
119     Spd m_SpdSlow
120     Cnt 1
121     Mvs  P_Curr, -50
122     JOvrd m_OvrdFast
123     Mov  pCylAsmRotated, -50
124     Cnt 0
125     Spd m_SpdSlow
126     Mvs  pCylAsmRotated
127     Dly  0.1
128     HOpen 1
129     Dly  0.5
130     Cnt 1
131     JOvrd m_OvrdFast
132     Mvs  pCylAsmRotated, -50
133     '
134 Else
135     '>>>>>> No edge was detected. Drop cylinder into magazine 1 <<<<<<<<'
136     Cnt 1
137     Spd m_SpdSlow
138     Mvs  P_Curr, -250
139     JOvrd m_OvrdFast
140     Mov  p_Magazine1, -30
141     Cnt 0
142     Spd m_SpdSlow
143     Mvs  p_Magazine1
144     Dly  0.1
145     HOpen 1
146     Dly  0.5
147     JOvrd m_OvrdSlow
148     Cnt 1
149     Mvs  p_Magazine1, -30
150     JOvrd m_OvrdFast
151     Mov  j_Home
152     m_Return = -1
153 EndIf
154 End
155 '
156 '
157 '
158 '###########################################################'
159 '       Interrupts
160 '###########################################################'
161 '
162 '>>>>>> Stop button <<<<<<<<'
163 *Stopped
164     m_StartLight% = 1             'blink LED at START button
165     Wait M_In(i_StartButton) = 1  'wait for START button pressed
166     m_StartLight% = 0             'set LED at START button to steady
167     Return 0
pCylindColCheck=(+313.03,+32.30,+60.45,+179.99,-0.21,-188.00,+0.00,+0.00)(7,0)
p_CylinderReGrip=(+351.03,-21.70,+70.45,+179.99,-0.21,-180.00,+0.00,+0.00)(7,0)
pColorOffset=(+0.00,+0.00,+0.00,+0.00,+0.00,+0.00)(,)
pCylAsmRotated=(+396.94,-20.59,+57.75,+179.99,-0.21,+3.67)(7,0)
p_Belt=(+135.63,+134.84,+132.94,-180.00,+0.00,-180.00)(7,0)
p_CylindOriCheck=(+320.79,-37.52,+75.13,+179.99,-0.21,-180.00)(7,0)
p_ProductAsm=(+396.94,-20.59,+57.75,+179.99,-0.21,-180.00)(7,0)
p_EdgePos=(+320.44,-4.50,+58.52,+180.00,+0.00,+19.57)(7,0)
p_Magazine1=(+323.36,-145.86,+254.06,-180.00,+0.00,+90.00,+0.00,+0.00)(7,0)
j_Home=(+25.98,-14.31,+133.92,-1.44,+60.90,+26.31)
