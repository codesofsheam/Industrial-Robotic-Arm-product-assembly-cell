1 '##########################################################'
2 '### Main
3 '###
4 '### Modifications:
5 '###  - 24.07.2015 DABO/RJN        Created
6 '###
7 '### Process of Operation:
8 '### Assemble the pneumatic cylinder from body, piston, spring and cover
9 '###
10 '### Local positions to teach:
11 '###
12 '### Global positions to teach (UBP):
13 '###  - j_Home    Home position
14 '###  - Check inside the called functions, too!
15 '###
16 '### Used functions:
17 '###  - InitVariables
18 '###  - MoveHome        (Positions to teach!)
19 '###  - CylinderIn      (Positions to teach!)
20 '###  - CylinderAsmb    (Positions to teach!)
21 '###  - PistonAsmb      (Positions to teach!)
22 '###  - SpringAsmb      (Positions to teach!)
23 '###  - CoverAsmb       (Positions to teach!)
24 '###  - ProductOut      (Positions to teach!)
25 '###
26 '##########################################################'
27 '
28 '
29 '###########################################################'
30 '       Declaration Of Local variables
31 '###########################################################'
32 Def Inte mBlack
33 '
34 '###########################################################'
35 '       Declaration Of Interrupts
36 '###########################################################'
37 Def Act 1, M_In(i_StopButton) = 0 GoSub *Stopped
38 '
39 '
40 '###########################################################'
41 '       Program
42 '###########################################################'
43 '
44 '>>>>>> Initialization <<<<<<<<'
45 CallP "VariableInit"             'initialize global variables
46 CallP "MoveHome"                 'move to HOME position
47 m_ResetLight% = -1               'switch off LED at RESET button
48 m_StartLight% = 1                'blink LED at START button
49 Wait M_In(i_StartButton) = 1     'wait for START button pressed
50 m_StartLight% = 0                'set LED at START button to steady
51 '
52 '>>>>>> Main loop <<<<<<<<'
53 *Loop:
54     Act 1 = 1                    'enable interrupt 1
55     CallP "CylinderIn"           'wait for cylinder and move it to mid of conveyor
56     CallP "CylinderAsmb"         'pick cylinder from belt and place at assembly position
57     If m_Return < 0 Then GoTo *Loop 'part was discard; wait for next part
58     mBlack% = m_Return           'save color of cylinder in global variable
59     CallP "PistonAsmb", mBlack%  'pick pistom from pallet and assemble it
60     CallP "SpringAsmb"           'pick spring from magazine and assemble it
61     CallP "CoverAsmb", mBlack%   'pick cover from magazine and assemble it
62     CallP "ProductOut"           'pick cylinder from assembly and place it to belt; transfer to next station
63     Mov j_Home                   'move robot arm to home position
64     GoTo *Loop
65 '
66 '###########################################################'
67 '       Interrupts
68 '###########################################################'
69 '
70 '>>>>>> Stop button <<<<<<<<'
71 *Stopped
72     m_StartLight% = 1             'blink LED at START button
73     Wait M_In(i_StartButton) = 1  'wait for START button pressed
74     m_StartLight% = 0             'set LED at START button to steady
75     Return 0
j_Home=(+25.98,-14.31,+133.92,-1.44,+60.90,+26.31)
