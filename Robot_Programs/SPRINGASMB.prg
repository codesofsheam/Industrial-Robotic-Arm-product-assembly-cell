1 '##########################################################'
2 '### SpringAsmb
3 '###
4 '### Modifications:
5 '###  - 24.07.2015 DABO        Created
6 '###
7 '### Process of Operation:
8 '### Distributing a spring from the magazine
9 '### Pick it from the magazine and place it in the cylinder at p_ProductAsm
10 '###
11 '### Local positions to teach:
12 '###
13 '### Global positions to teach (UBP):
14 '###  - j_Home                                           Home position
15 '###  - p_ProductAsm           Tool 1 - Red cylinder     Product assembly position
16 '###  - p_SpringMagazine       Tool 3 - Spring           Spring pickup position
17 '###
18 '##########################################################'
19 '
20 '###########################################################'
21 '       Declaration Of Interrupts
22 '###########################################################'
23 Def Act 1, M_In(i_StopButton ) = 0 GoSub *Stopped
24 Act 1 = 1
25 '
26 '
27 '
28 '###########################################################'
29 '       Program
30 '###########################################################'
31 '
32 '>>>>>> Distribute spring from magazine <<<<<<<'
33 XRun 3,"DistSpring",1
34 Wait M_Run(3) = 1
35 '
36 '>>>>>> Pick spring from p_SpringMagazine drop at p_ProductAsm <<<<<<<<'
37 M_Tool = m_Spring
38 Cnt 1
39 JOvrd m_OvrdFast
40 Mvs  p_SpringMagazine, -50
41 Wait M_Run(3) = 0
42 Spd m_SpdSlow
43 Cnt 0
44 Mvs  p_SpringMagazine
45 Dly  0.1
46 HClose 1
47 Dly  0.5
48 Mvs  p_SpringMagazine, -50
49 Cnt 1
50 Spd m_SpdFast
51 Mvs  p_ProductAsm, -50
52 Cnt 0
53 Spd m_SpdSlow
54 Mvs  p_ProductAsm
55 Dly  0.1
56 HOpen 1
57 Dly  0.5
58 Mvs  p_ProductAsm, -50
59 End
60 '
61 '
62 '
63 '###########################################################'
64 '       Interrupts
65 '###########################################################'
66 '
67 '>>>>>> Stop button <<<<<<<<'
68 *Stopped
69     m_StartLight% = 1             'blink LED at START button
70     Wait M_In(i_StartButton) = 1  'wait for START button pressed
71     m_StartLight% = 0             'set LED at START button to steady
72     Return 0
p_SpringMagazine=(+449.59,+164.96,+58.94,-180.00,+0.00,+90.00,+0.00,+0.00)(7,0)
p_ProductAsm=(+396.94,-20.59,+57.75,+179.99,-0.21,-180.00)(7,0)
