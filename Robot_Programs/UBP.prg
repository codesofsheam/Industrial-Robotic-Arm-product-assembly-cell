1 'Standard Position
2 Def Jnt j_Home             '                           Home position
3 Def Pos p_Belt             'Tool 2 - Red cylinder      Arrival posiiton of the cylinder at conveyor belt
4 Def Pos p_ProductAsm       'Tool 1 - Red cylinder      Product assembly position
5 Def Pos p_CylinderReGrip   'Tool 1 - Red cylinder      Cylinder regripp position (where the color is checked)
6 Def Pos p_CylindOriCheck   'Tool 1 - Ref. tool         Cylinder orientation check position
7 Def Pos p_Magazine1        'Tool 1 - Red cylinder      Magazine 1 for bad cylinders
8 Def Pos p_Magazine2        'Tool 1 - Blue cover        Magazine 2 for bad covers
9 Def Pos p_SilPistonPal1    'Tool 3 - Silver Piston     First silver piston in the pallet
10 Def Pos p_SilPistonPal4    'Tool 3 - Silver Piston     Last silver piston in the pallet
11 Def Pos p_BlkPistonPal1    'Tool 3 - Black Piston      First black piston in the pallet
12 Def Pos p_BlkPistonPal4    'Tool 3 - Black Piston      Last black piston in the pallet
13 Def Pos p_SpringMagazine   'Tool 3 - Spring            Spring pickup position
14 Def Pos p_CoverMagazine    'Tool 1 - Blue cover        Cover pickup position
15 Def Pos p_CoverOriCheck    'Tool 1 - Blue cover        Cover orientation check position
16 Def Pos p_EdgePos          'not to teach
17 '
18 'OVRD control
19 Const Def Inte m_SpdVerySlow = 20 '[mm/s]
20 Const Def Inte m_SpdSlow = 100    '[mm/s]
21 Const Def Inte m_SpdFast = 200    '[mm/s]
22 Const Def Inte m_OvrdFast = 50    '[%]
23 Const Def Inte m_OvrdSlow = 20    '[%]
24 Const Def Inte m_OvrdVerySlow = 3 '[%]
25 'TCPs
26 Const Def Inte m_None = 0
27 Const Def Inte m_Outer = 2
28 Const Def Inte m_Center = 1
29 Const Def Inte m_Spring = 3
30 Const Def Inte m_Piston = 3
31 Const Def Inte m_Rear = 4
32 '''''''''
33 Def Inte m_SilCnt
34 Def Inte m_BlkCnt
35 Def Inte m_Return
36 Def Inte m_EdgeDir
37 'LIGHT
38 Def Inte m_StartLight
39 Def Inte m_ResetLight
40 Def Inte m_Q1Light
41 Def Inte m_Q2Light
42 'IO Pins
43 '
44 '
45 '>>>>>> INPUTS - RIA1 - X1 - module handling <<<<<<<<'
46 Const Def Inte i_CoverRetracted = 12  'Cover distributing cylinder retracted
47 Const Def Inte i_CoverExtended = 13   'Cover distributing cylinder extended
48 Const Def Inte i_CoverAtPickup = 14   'Cover available at pickup position
49 '
50 Const Def Inte i_SprRetracted = 8     'Spring distributing cylinder retracted
51 Const Def Inte i_SprExtended = 9      'Spring distributing cylinder extended
52 Const Def Inte i_SprAtPickup = 10     'Spring available at pickup position
53 '
54 '>>>>>> INPUTS - RIA1 - X2 - module assembly <<<<<<<<'
55 Const Def Inte i_SensOriCheck = 1     'Sensor to check part orientation at asm position
56 '
57 '>>>>>> INPUTS - RIA1 - X3 <<<<<<<<'
58 Const Def Inte i_StartButton = 3      'Start button
59 Const Def Inte i_StopButton = 4       'Stop button (NC)
60 Const Def Inte i_ResetButton = 5      'Reset button
61 Const Def Inte i_NextStatFree = 7     'Handshake from next station
62 '
63 '>>>>>> INPUTS - RIA1 - X4 - conveyor belt <<<<<<<<'
64 Const Def Inte i_SensBeltFront = 2    'Cylinder detected at conveyor front
65 Const Def Inte i_SensBeltEnd = 15     'Cylinder detected at conveyor end
66 Const Def Inte i_SensBeltMid1 = 6     'Sensor 1 at conveyor middle position
67 Const Def Inte i_SensBeltMid2 = 11    'Sensor 2 at conveyor middle position
68 '
69 '>>>>>> Robot INPUTS <<<<<<<<'
70 Const Def Inte i_SensColCheck = 900   'Sensor at gripper to check part color
71 '
72 '>>>>>> OUTPUTS - RIA1 - X1 <<<<<<<<'
73 Const Def Inte q_SpringExtend = 8    'Extend cylinder of spring magazine
74 Const Def Inte q_CoverExtend = 12    'Extend cylinder of cover magazine
75 '
76 '>>>>>> OUTPUTS - RIA1 - X3 <<<<<<<<'
77 Const Def Inte q_LedStart = 0        'LED of Start button
78 Const Def Inte q_LedReset = 1        'LED of Reset button
79 Const Def Inte q_LedQ1 = 2           'LED Q1
80 Const Def Inte q_LedQ2 = 3           'LED Q2
81 Const Def Inte q_StationFreeQ4 = 4   'Handshake to previous station
82 '
83 '>>>>>> OUTPUTS - RIA1 - X4 <<<<<<<<'
84 Const Def Inte q_BeltFwd = 5         'Start conveyor belt
85 Const Def Inte q_BeltSlow = 7        'Switch to low belt speed
86 '
p_Belt=(+135.63,+134.84,+132.94,-180.00,+0.00,-180.00)(7,0)
p_ProductAsm=(+396.94,-20.59,+57.75,+179.99,-0.21,-180.00)(7,0)
p_CylinderReGrip=(+351.03,-21.70,+70.45,+179.99,-0.21,-180.00,+0.00,+0.00)(7,0)
p_CylindOriCheck=(+320.79,-37.52,+75.13,+179.99,-0.21,-180.00)(7,0)
p_Magazine1=(+323.36,-145.86,+254.06,-180.00,+0.00,+90.00,+0.00,+0.00)(7,0)
p_Magazine2=(+394.54,-145.87,+254.06,-180.00,+0.00,+90.00)(7,0)
p_SilPistonPal1=(+339.44,+93.40,+76.66,+180.00,+0.00,+44.98)(7,0)
p_SilPistonPal4=(+339.49,+168.61,+77.72,+179.99,-0.01,+44.98)(7,0)
p_BlkPistonPal1=(+369.62,+92.40,+77.25,+179.99,-0.01,+135.03)(7,0)
p_BlkPistonPal4=(+369.86,+167.27,+77.32,+179.99,-0.01,+135.02)(7,0)
p_SpringMagazine=(+449.59,+164.96,+58.94,-180.00,+0.00,+90.00,+0.00,+0.00)(7,0)
p_CoverMagazine=(+250.94,+147.66,+62.92,-180.00,+0.00,-180.00)(7,0)
p_CoverReGrip=(+81.36,+245.98,+195.84,-179.58,-0.17,-44.11)(7,0)
p_CoverOriCheck=(+320.44,-4.50,+58.52,-180.00,+0.00,+0.00)(7,0)
p_ProductOutput=(+132.34,+133.89,+132.88,-179.99,-0.01,-180.00,+0.00,+0.00)(7,0)
p_EdgePos=(+320.44,-4.50,+58.52,+180.00,+0.00,+19.57)(7,0)
j_Home=(+25.98,-14.31,+133.92,-1.44,+60.90,+26.31)
