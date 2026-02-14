1 '##########################################################'
2 '### DistCover
3 '###
4 '### Modifications:
5 '###  - 07.04.2022 LDWR        Created
6 '###
7 '### Process of Operation:
8 '### Distributing a cover from the magazine
9 '###
10 '### Local positions to teach:
11 '###
12 '### Global positions to teach (UBP):
13 '###
14 '##########################################################'
15 '
16 '###########################################################'
17 '       Declaration Of Interrupts
18 '###########################################################'
19 Def Act 1, M_In(i_StopButton) = 0 GoSub *Stopped
20 Act 1 = 1
21 '
22 '###########################################################'
23 '       Program
24 '###########################################################'
25 '
26 '
27 '>>>>>> Distribute cover from magazine <<<<<<<'
28 M_Out(q_CoverExtend) = 0              'retract cylinder
29 Wait M_In(i_CoverRetracted) = 1       'wait cylinder is retracted
30 Dly 0.5
31 While M_In(i_CoverAtPickup) = 0       'repeat until cover was pushed out successfully
32     M_Out(q_CoverExtend) = 1          'extend cylinder
33     Wait M_In(i_CoverExtended) = 1    'wait clyinder is extended
34     Dly 0.5
35     M_Out(q_CoverExtend) = 0          'retract cylinder
36     Wait M_In(i_CoverRetracted) = 1   'wait cylinder is retracted
37     Dly 0.5
38     If M_In(i_CoverAtPickup) = 0 Then 'no cover was pushed out
39         m_Q2Light% = 0                'set light Q2
40         m_StartLight% = 1             'blink LED at START button with 1Hz
41         Wait M_In(i_StartButton) = 1  'wait for START button pressed
42         m_StartLight% = 0             'set LED at START button
43         m_Q2Light% = -1               'switch light Q2 off
44     EndIf
45 WEnd
46 End
47 '
48 '###########################################################'
49 '       Interrupts
50 '###########################################################'
51 '
52 '>>>>>> Stop button <<<<<<<<'
53 *Stopped
54     m_StartLight% = 1             'blink LED at START button
55     Wait M_In(i_StartButton) = 1  'wait for START button pressed
56     m_StartLight% = 0             'set LED at START button to steady
57     Return 0
