1 '##########################################################'
2 '### ProductOut
3 '###
4 '### Modifications:
5 '###  - 24.07.2015 RJN        Created
6 '###
7 '### Process of Operation:
8 '### Pick the assembeled product from p_ProductAsm position with outer gripper
9 '### Place the product at p_ProductOutput
10 '### Return to j_Home position
11 '###
12 '### Local positions to teach:
13 '###
14 '### Global positions to teach (UBP):
15 '###  - j_Home                                        Home position
16 '###  - p_ProductAsm        Tool 1 - Red cylinder     Product assembly position
17 '###  - p_Belt              Tool 2 - Red cylinder     Product belt position
18 '###
19 '##########################################################'
20 '
21 '###########################################################'
22 '       Declaration Of Local positions
23 '###########################################################'
24 Def Pos pCoverHight 'Z offset for cover height
25 pCoverHight = (+0.00,+0.00,+2.00,+0.00,+0.00,+0.00)
26 '
27 '###########################################################'
28 '       Declaration Of Interrupts
29 '###########################################################'
30 Def Act 1, M_In(i_StopButton) = 0 GoSub *Stopped
31 Act 1 = 1 'activate interrupt 1
32 '
33 '
34 '
35 '###########################################################'
36 '       Program
37 '###########################################################'
38 '
39 '>>>>>> Pick the product from p_ProductAsm <<<<<<<<'
40 M_Tool = m_Outer 'activate TCP
41 JOvrd m_OvrdFast
42 Cnt 1
43 Mov  p_ProductAsm, -50
44 Spd m_SpdSlow
45 Cnt 0
46 Mvs  p_ProductAsm + pCoverHight
47 Dly  0.1
48 HClose 1
49 Dly  0.5
50 Mvs  p_ProductAsm, -50
51 '
52 '>>>>>> Place the product at p_PrdOut <<<<<<<<'
53 JOvrd m_OvrdFast
54 Cnt 1
55 Mov  j_Home
56 Mov  p_Belt, -50
57 Spd m_SpdSlow
58 Cnt 0
59 Mvs  p_Belt + pCoverHight
60 Dly  0.1
61 HOpen 1
62 Dly  0.5
63 Mvs  p_Belt, -50
64 '
65 '>>>>>> Return to Home position <<<<<<<<'
66 JOvrd m_OvrdFast
67 Mov  j_Home
68 '
69 '>>>>>> Transport part to end of conveyor belt <<<<<<<<'
70 M_Out(q_BeltFwd) = 1          'start conveyor belt
71 Wait M_In(i_SensBeltEnd) = 0  'wait cylinder arrived at conveyor end
72 M_Out(q_BeltFwd) = 0          'stop conveyor belt
73 m_StartLight% = 4             'blink LED at START button
74 Wait M_In(i_NextStatFree) = 1 Or M_In(i_StartButton) = 1 'wait for next station free or START button
75 m_StartLight% = 0             'set LED at START button to steady
76 M_Out(q_BeltFwd) = 1          'start conveyor belt
77 Wait M_In(i_NextStatFree) = 0 And M_In(i_StartButton) = 0 'wait cylinder left the belt
78 M_Out(q_BeltFwd) = 0          'stop conveyor belt
79 End
80 '
81 '
82 '
83 '###########################################################'
84 '       Interrupts
85 '###########################################################'
86 '
87 '>>>>>> Stop button <<<<<<<<'
88 *Stopped
89     m_StartLight% = 1             'blink LED at START button
90     Wait M_In(i_StartButton) = 1  'wait for START button pressed
91     m_StartLight% = 0             'set LED at START button to steady
92     Return 0
pCoverHight=(+0.00,+0.00,+2.00,+0.00,+0.00,+0.00)(,)
p_ProductAsm=(+396.94,-20.59,+57.75,+179.99,-0.21,-180.00)(7,0)
p_Belt=(+135.63,+134.84,+132.94,-180.00,+0.00,-180.00)(7,0)
j_Home=(+25.98,-14.31,+133.92,-1.44,+60.90,+26.31)
