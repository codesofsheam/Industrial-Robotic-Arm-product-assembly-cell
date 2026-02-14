1 '##########################################################'
2 '### SearchEdge
3 '###
4 '### Modifications:
5 '###  - 07.04.2022 LDWR        Created
6 '###
7 '### Process of Operation:
8 '### Search edge of hole in part with sensor at orientation check position
9 '###
10 '### Local positions to teach:
11 '###
12 '### Global positions to teach (UBP):
13 '###
14 '##########################################################'
15 '
16 '##########################################################'
17 ' Decleration Of Input parameters for the function
18 '##########################################################'
19 '
20 Def Pos pStartPos 'Start position to search the edge
21 Def Float mAngle   'Angle to search
22 FPrm pStartPos, mAngle
23 '
24 '
25 '###########################################################'
26 '       Declaration Of Local positions
27 '###########################################################'
28 Def Pos pRotation
29 pRotation = (+0.00,+0.00,+0.00,+0.00,+0.00,+0.00)
30 pRotation.C = Rad(mAngle)
31 '
32 '
33 '###########################################################'
34 '       Declaration Of Local variables
35 '###########################################################'
36 '
37 Def Inte mSensOld
38 '
39 '###########################################################'
40 '       Declaration Of Interrupts
41 '###########################################################'
42 Def Act 1, M_In(i_StopButton ) = 0 GoSub *Stopped
43 Act 1 = 1
44 Def Act 2, M_In(i_SensOriCheck) <> mSensOld% GoSub *EdgeFound
45 '
46 '
47 '###########################################################'
48 '       Program
49 '###########################################################'
50 '
51 '
52 '>>>>>> Move to start position <<<<<<<<'
53 Cnt 0
54 Spd m_SpdVerySlow
55 Mvs  pStartPos
56 '
57 '>>>>>> Activate edge detection <<<<<<<<'
58 mSensOld% = M_In(i_SensOriCheck)
59 Act 2 = 1
60 '
61 '>>>>>> Start search movement <<<<<<<<'
62 JOvrd m_OvrdVerySlow
63 Mov  P_Curr + pRotation
64 '>>>>>> Program should not arrive here - no edge found <<<<<<<<'
65 m_EdgeDir% = -1
66 End
67 '
68 '###########################################################'
69 '       Interrupts
70 '###########################################################'
71 '
72 '>>>>>> Stop button <<<<<<<<'
73 *Stopped
74     m_StartLight% = 1             'blink LED at START button
75     Wait M_In(i_StartButton) = 1  'wait for START button pressed
76     m_StartLight% = 0             'set LED at START button to steady
77     Return 0
78 '
79 '>>>>>> Edge found <<<<<<<<'
80 *EdgeFound
81     p_EdgePos = P_Curr     'save cuttent position
82     Act 2 = 0              'deactivate interrupt
83     Ovrd 0.01              'set override to smallest value
84     Spd 0.01               'set speed to smallest value
85     JOvrd 0.01             'set joint override to smallest value
86     If mSensOld% = 0 Then
87         m_EdgeDir% = 1     'rising edge was detected
88     EndIf
89     If mSensOld% = 1 Then
90         m_EdgeDir% = 2     'falling edge was detected
91     EndIf
92     End
pStartPos=(+320.44,-4.50,+58.52,-180.00,+0.00,+0.00)(7,0)
pRotation=(+0.00,+0.00,+0.00,+0.00,+0.00,+240.00)(,)
p_EdgePos=(+320.44,-4.50,+58.52,+180.00,+0.00,+19.57)(7,0)
