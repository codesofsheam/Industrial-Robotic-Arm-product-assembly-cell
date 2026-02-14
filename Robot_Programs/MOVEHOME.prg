1 '##########################################################'
2 '### Main
3 '###
4 '### Modifications:
5 '###  - 11.04.2022 LDWR        Created
6 '###
7 '### Process of Operation:
8 '### Move robot to HOME position as long as the Reset button is pressed
9 '###
10 '### Local positions to teach:
11 '###
12 '### Global positions to teach (UBP):
13 '###
14 '##########################################################'
15 '
16 '###########################################################'
17 '       Declaration Of Local positions
18 '###########################################################'
19 Def Pos pTmp  'Temporary position
20 '
21 '
22 '###########################################################'
23 '       Program
24 '###########################################################'
25 '
26     'Robot is kind of stopped
27 m_ResetLight% = 1                'blink LED of RESET button
28 Wait M_In(i_ResetButton) = 1     'wait RESET button is pressed
29 m_ResetLight% = 0                'set LED of RESET button to steady
30 '
31 HOpen 1                          'open gripper
32 Dly 0.5
33 M_Tool = m_None                  'set tool to 0; Robot flange
34 M_Out(q_BeltFwd) = 0             'conveyor belt off
35 M_Out(q_BeltSlow) = 0
36 '
37 *Continue:
38     Def Act 2, M_In(i_ResetButton) = 0 GoTo *Halt 'Declaration of interrupt; RESET button is released
39     Act 2 = 1                    'activate interrupt
40     Ovrd 100                     'set control internal override to 100%
41     pTmp = P_Curr                'get current position
42     pTmp.Z = 360.0               'calculate temporary position straight above current position
43     Spd m_SpdSlow                'set linear speed to slow
44     Mvs pTmp                     'move linear to calculated position
45     JOvrd m_OvrdSlow             'set joint override to slow
46     Mov j_Home                   'move to HOME position
47 End
48 '
49 *Halt: 'RESET button was released
50     Act 2 = -1                   'deactivate interrupt
51     Ovrd 0.01                    'set override to smallest value
52     Spd 0.01                     'set speed to smallest value
53     JOvrd 0.01                   'set joint override to smallest value
54     'Robot is kind of stopped
55     m_ResetLight% = 1            'blink LED at RESET button
56     Wait M_In(i_ResetButton) = 1 'wait RESET button is pressed again
57     m_ResetLight% = 0            'swtich LED at RESET button to steady
58     GoTo *Continue               'Jump back to motion part
pTmp=(+397.31,-20.79,+360.00,-179.97,-0.21,+143.77)(7,0)
j_Home=(+25.98,-14.31,+133.92,-1.44,+60.90,+26.31)
