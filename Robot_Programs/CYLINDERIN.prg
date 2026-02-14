1 '##########################################################'
2 '### CylinderIn
3 '###
4 '### Modifications:
5 '###  - 15.05.2023 LDWR        Created
6 '###
7 '### Process of Operation:
8 '### Wait for cylinder at conveyor front and move it to conveyor mid
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
19 Def Act 1, M_In(i_StopButton%) = 0 GoSub *Stopped
20 Act 1 = 1
21 '
22 '###########################################################'
23 '       Program
24 '###########################################################'
25 '
26 '>>>>>> Wait for cylinder at conveyor front and move it to conveyor mid <<<<<<<<'
27 M_Out(q_BeltFwd) = 0           'Conveyor belt off
28 M_Out(q_BeltSlow) = 0
29 M_Out(q_StationFreeQ4) = 1     'set station free singnal to previous station
30 Wait M_In(i_SensBeltFront) = 0 'wait cylinder arrives at conveyor front
31 M_Out(q_BeltFwd) = 1           'start conveyor belt
32 Wait M_In(i_SensBeltFront) = 1 'wait clyinder left the conveyor front, is fully inside the station
33 M_Out(q_StationFreeQ4) = 0     'reset station free signal to previous station
34 Wait M_In(i_SensBeltMid1) = 1  'wait cylinder arrived at conveyor middle
35 M_Out(q_BeltSlow) = 1          'switch belt to slow speed
36 Wait M_In(i_SensBeltMid1) = 0  'wait cylinder left first light sensor
37 M_Out(q_BeltFwd) = 0           'Conveyor belt off
38 M_Out(q_BeltSlow) = 0
39 Dly 1
40 End
41 '
42 '
43 '###########################################################'
44 '       Interrupts
45 '###########################################################'
46 '
47 '>>>>>> Stop button <<<<<<<<'
48 *Stopped
49     m_StartLight% = 1             'blink LED at START button
50     Wait M_In(i_StartButton) = 1  'wait for START button pressed
51     m_StartLight% = 0             'set LED at START button to steady
52     Return 0
