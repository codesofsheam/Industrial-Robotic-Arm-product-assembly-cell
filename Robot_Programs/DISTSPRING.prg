1 '##########################################################'
2 '### DistSpring
3 '###
4 '### Modifications:
5 '###  - 07.04.2022 LDWR        Created
6 '###
7 '### Process of Operation:
8 '### Distributing a spring from the magazine
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
20 Act 1 = 1 'activate interrupt 1
21 '
22 '
23 '
24 '###########################################################'
25 '       Program
26 '###########################################################'
27 '
28 '
29 '>>>>>> Distribute spring from magazine <<<<<<<'
30 M_Out(q_SpringExtend) = 1            'extend cylinder to push spring to pick position
31 Wait M_In(i_SprExtended) = 1         'wait until cylinder is extended
32 Dly 0.5
33 While M_In(i_SprAtPickup) = 0        'repead as long as no spring is detected with the sensor
34     M_Out(q_SpringExtend) = 0        'retract cylinder at spring magazine
35     Wait M_In(i_SprRetracted) = 1    'wait until cylinder is retracted
36     Dly 0.5
37     M_Out(q_SpringExtend) = 1        'extend cylinder to push spring to pick position
38     Wait M_In(i_SprExtended) = 1     'wait until cylinder is extended
39     Dly 0.5
40     If M_In(i_SprAtPickup) = 0 Then  'no spring distributed
41         m_Q1Light% = 0               'set light Q1
42         m_StartLight% = 1            'blink LED at START button with 1Hz
43         Wait M_In(i_StartButton) = 1 'wait for START button pressed
44         m_StartLight% = 0            'set LED at START button
45         m_Q1Light% = -1              'switch light Q1 OFF
46     EndIf
47 WEnd
48 End
49 '
50 '###########################################################'
51 '       Interrupts
52 '###########################################################'
53 '
54 '>>>>>> Stop button <<<<<<<<'
55 *Stopped
56     m_StartLight% = 1             'blink LED at START button
57     Wait M_In(i_StartButton) = 1  'wait for START button pressed
58     m_StartLight% = 0             'set LED at START button to steady
59     Return 0
