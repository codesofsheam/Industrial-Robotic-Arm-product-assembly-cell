1 '----------------------------------------------------
2 '| Control panel lights control - dabo - 28.02.2014 |
3 '----------------------------------------------------
4 '
5 Def Io H1Light = Bit,q_LedStart    'Lampe Start/lamp start control panel
6 Def Io H2Light = Bit,q_LedReset    'Lampe Richen/lamp reset control panel
7 Def Io H3Light = Bit,q_LedQ1       'Lampe Q1/lamp Q1 control panel
8 Def Io H4Light = Bit,q_LedQ2       'Lampe Q2/lamp Q2 control panel
9 '
10 Def Inte Timer
11 Def Inte Blink1Hz
12 Def Inte Blink2Hz
13 Def Inte Blink4Hz
14 Def Inte OldH1
15 Def Inte OldH2
16 Def Inte OldH3
17 Def Inte OldH4
18 Def Inte Stopped
19 '
20 Timer% = 0
21 Stopped% = 0
22 m_StartLight = -1
23 m_ResetLight = -1
24 m_Q1Light = -1
25 m_Q2Light = -1
26 '
27 ' Infinite loop
28 *Loop
29 '
30 If M_Err > 0 Then
31     If Stopped% = 0 Then
32         Stopped% = 1
33         OldH1% = m_StartLight
34         OldH2% = m_ResetLight
35         OldH3% = m_Q1Light
36         OldH4% = m_Q2Light
37     EndIf
38 ' 4Hz
39     m_StartLight = -1
40     m_ResetLight = -1
41     m_Q1Light = 4
42     m_Q2Light = -1
43 Else
44    If Stopped% = 1 Then
45        Stopped% = 0
46        m_StartLight = OldH1%
47        m_ResetLight = OldH2%
48        m_Q1Light = OldH3%
49        m_Q2Light = OldH4%
50    EndIf
51 EndIf
52 '
53 ' -1 (off)
54 If m_StartLight = -1 Then H1Light = 0
55 If m_ResetLight = -1 Then H2Light = 0
56 If m_Q1Light = -1 Then H3Light = 0
57 If m_Q2Light = -1 Then H4Light = 0
58 '
59 ' 0Hz (on)
60 If m_StartLight = 0 Then H1Light = 1
61 If m_ResetLight = 0 Then H2Light = 1
62 If m_Q1Light = 0 Then H3Light = 1
63 If m_Q2Light = 0 Then H4Light = 1
64 '
65 ' 1Hz
66 Blink1Hz% = Timer% \ 4
67 If m_StartLight = 1 Then H1Light = Blink1Hz%
68 If m_ResetLight = 1 Then H2Light = Blink1Hz%
69 If m_Q1Light = 1 Then H3Light = Blink1Hz%
70 If m_Q2Light = 1 Then H4Light = Blink1Hz%
71 '
72 ' 2Hz
73 Blink2Hz% = (Timer% \ 2) Mod 2
74 If m_StartLight = 2 Then H1Light = Blink2Hz%
75 If m_ResetLight = 2 Then H2Light = Blink2Hz%
76 If m_Q1Light = 2 Then H3Light = Blink2Hz%
77 If m_Q2Light = 2 Then H4Light = Blink2Hz%
78 '
79 ' 4Hz
80 Blink4Hz% = Timer% Mod 4
81 If m_StartLight = 4 Then H1Light = Blink4Hz%
82 If m_ResetLight = 4 Then H2Light = Blink4Hz%
83 If m_Q1Light = 4 Then H3Light = Blink4Hz%
84 If m_Q2Light = 4 Then H4Light = Blink4Hz%
85 '
86 ' Increase the timer
87 Dly 0.125
88 Timer% = Timer% + 1
89 If Timer% > 7 Then Timer% = 0
90 '
91 GoTo *Loop
