1 '##########################################################'
2 '### VaiableInit
3 '###
4 '### Modifications:
5 '###  - 24.07.2015 DABO        Created
6 '###
7 '### Process of Operation:
8 '### Reset of piston pallet counters
9 '### Reset of control panel lights
10 '### Reset of outputs
11 '###
12 '### Local positions to teach:
13 '###
14 '### Global positions to teach (UBP):
15 '###
16 '##########################################################'
17 '
18 '
19 '>>>>>> Light controls <<<<<<<<'
20 m_StartLight = -1
21 m_ResetLight = -1
22 m_Q1Light = -1
23 m_Q2Light = -1
24 '
25 '>>>>>> Counters for the piston pallet <<<<<<<<'
26 m_SilCnt = 1
27 m_BlkCnt = 1
28 '
29 '>>>>>> Reset outputs <<<<<<<<'
30 M_Out(q_StationFreeQ4) = 0  'reset station free singnal to previous station
31 M_Out(q_BeltFwd) = 0        'Conveyor belt off
32 M_Out(q_BeltSlow) = 0       'Conveyor belt slow speed off
33 '
34 If M_Run(2) = 0 Then
35     XRun 2,"LIGHTS"
36 EndIf
