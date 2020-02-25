
;CodeVisionAVR C Compiler V3.32 Evaluation
;(C) Copyright 1998-2017 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : AT90USB1286
;Program type           : Application
;Clock frequency        : 2.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 2048 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: Off
;Smart register allocation: Off

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME AT90USB1286
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8192
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU WDTCSR=0x60
	.EQU UCSR1A=0xC8
	.EQU UDR1=0xCE
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x20FF
	.EQU __DSTACK_SIZE=0x0800
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_k1:
	.DB  0x20,0x22,0x2A,0x2B,0x2C,0x5B,0x3D,0x5D
	.DB  0x7C,0x7F,0x0
_vst_G102:
	.DB  0x0,0x4,0x0,0x2,0x0,0x1,0x80,0x0
	.DB  0x40,0x0,0x20,0x0,0x10,0x0,0x8,0x0
	.DB  0x4,0x0,0x2,0x0,0x0,0x0
_cst_G102:
	.DB  0x0,0x80,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x4,0x0,0x2
_tbl10_G103:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G103:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x3:
	.DB  0x3,0x3,0x3,0x2,0x2,0xC,0x0,0x8
	.DB  0x0,0x1,0x0,0x6
_0x25:
	.DB  0x30,0x3A,0x6D,0x75,0x65,0x73,0x74,0x72
	.DB  0x61,0x2E,0x74,0x78,0x74
_0x0:
	.DB  0x41,0x72,0x63,0x68,0x69,0x76,0x6F,0x20
	.DB  0x4E,0x4F,0x20,0x45,0x6E,0x63,0x6F,0x6E
	.DB  0x74,0x72,0x61,0x64,0x6F,0x0,0x44,0x72
	.DB  0x69,0x76,0x65,0x20,0x4E,0x4F,0x20,0x44
	.DB  0x65,0x74,0x65,0x63,0x74,0x61,0x64,0x6F
	.DB  0x0,0x25,0x30,0x32,0x69,0x3A,0x25,0x30
	.DB  0x32,0x69,0x3A,0x25,0x30,0x32,0x69,0x20
	.DB  0x56,0x31,0x3A,0x20,0x25,0x69,0x2E,0x25
	.DB  0x69,0x0,0x25,0x30,0x32,0x69,0x3A,0x25
	.DB  0x30,0x32,0x69,0x3A,0x25,0x30,0x32,0x69
	.DB  0x20,0x56,0x32,0x3A,0x20,0x25,0x69,0x2E
	.DB  0x25,0x69,0x0,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x0
_0x2020003:
	.DB  0x1
_0x20200FE:
	.DB  0x4
_0x2040000:
	.DB  0xEB,0xFE,0x90,0x4D,0x53,0x44,0x4F,0x53
	.DB  0x35,0x2E,0x30,0x0,0x4E,0x4F,0x20,0x4E
	.DB  0x41,0x4D,0x45,0x20,0x20,0x20,0x20,0x46
	.DB  0x41,0x54,0x33,0x32,0x20,0x20,0x20,0x0
	.DB  0x4E,0x4F,0x20,0x4E,0x41,0x4D,0x45,0x20
	.DB  0x20,0x20,0x20,0x46,0x41,0x54,0x20,0x20
	.DB  0x20,0x20,0x20,0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _status_G101
	.DW  _0x2020003*2

	.DW  0x01
	.DW  _flags_S101000C000
	.DW  _0x20200FE*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x900

	.CSEG
;/*
; * logger.c
; *
; * Created: 25-Feb-20 4:46:27 PM
; * Author: javie
; */
;
;// LCD config
;#asm
    .equ __lcd_port=0x11
    .equ __lcd_EN=4
    .equ __lcd_RS=5
    .equ __lcd_D4=0
    .equ __lcd_D5=1
    .equ __lcd_D6=2
    .equ __lcd_D7=3
; 0000 0011 #endasm
;
;// DS1302 config
;#asm
	.equ __ds1302_port=0x0B
	.equ __ds1302_io=2
	.equ __ds1302_sclk=1
	.equ __ds1302_rst=0
; 0000 0019 #endasm
;
;#include <90usb1286.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include <ds1302.h>
;#include <display.h>

	.CSEG
_SetupLCD:
; .FSTART _SetupLCD
	SBIW R28,12
	LDI  R24,12
	__GETWRN 22,23,0
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	RCALL __INITLOCB
	ST   -Y,R16
;	TableSetup -> Y+1
;	i -> R16
; 0000 001D     SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_RS
    SBI __lcd_port-1,__lcd_D4
    SBI __lcd_port-1,__lcd_D5
    SBI __lcd_port-1,__lcd_D6
    SBI __lcd_port-1,__lcd_D7
	LDI  R26,LOW(50)
	LDI  R27,0
	RCALL _delay_ms
	LDI  R16,LOW(0)
_0x5:
	CPI  R16,12
	BRSH _0x6
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	MOV  R30,R16
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RCALL _SendDataBitsLCD
	RCALL _PulseEn
	SUBI R16,-1
	RJMP _0x5
_0x6:
	LDI  R30,LOW(12)
	STS  _cursor,R30
	LDS  R26,_cursor
	RCALL _WriteComandLCD
	LDD  R16,Y+0
	ADIW R28,13
	RET
; .FEND
_PulseEn:
; .FSTART _PulseEn
    SBI __lcd_port,__lcd_EN  // EN=1;
    CBI __lcd_port,__lcd_EN // EN=0;
	RET
; .FEND
_SendDataBitsLCD:
; .FSTART _SendDataBitsLCD
	ST   -Y,R16
	MOV  R16,R26
;	dato -> R16
	SBRS R16,3
	RJMP _0x7
	SBI __lcd_port,__lcd_D7
	RJMP _0x8
_0x7:
	CBI __lcd_port,__lcd_D7
_0x8:
	SBRS R16,2
	RJMP _0x9
	SBI __lcd_port,__lcd_D6
	RJMP _0xA
_0x9:
	CBI __lcd_port,__lcd_D6
_0xA:
	SBRS R16,1
	RJMP _0xB
	SBI __lcd_port,__lcd_D5
	RJMP _0xC
_0xB:
	CBI __lcd_port,__lcd_D5
_0xC:
	SBRS R16,0
	RJMP _0xD
	SBI __lcd_port,__lcd_D4
	RJMP _0xE
_0xD:
	CBI __lcd_port,__lcd_D4
_0xE:
	JMP  _0x20E0001
; .FEND
_WriteComandLCD:
; .FSTART _WriteComandLCD
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
;	Comando -> R17
;	tempComando -> R16
	CBI __lcd_port,__lcd_RS
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	MOV  R16,R30
	SWAP R16
	ANDI R16,0xF
	MOV  R26,R16
	RCALL _SendDataBitsLCD
	RCALL _PulseEn
	MOV  R30,R17
	ANDI R30,LOW(0xF)
	MOV  R16,R30
	MOV  R26,R16
	RCALL _SendDataBitsLCD
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	RCALL _PulseEn
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;	dato -> R17
;	tempdato -> R16
;	Mensaje -> R17,R18
;	i -> R16
;	Mensaje -> R19,R20
;	tiempo -> R17,R18
;	i -> R16
;	Mensaje -> R17,R18
;	i -> R16
;	x -> R17
;	y -> R16
;	NoCaracter -> R19
;	datos -> R17,R18
;	i -> R16
;#include <delay.h>
;#include <stdio.h>
;#include <ff.h>
;
;// ADC
;
;// ADC variables
;
;
;// Voltage Reference: Int., cap. on AREF
;#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))
;
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0000 002D {
_read_adc:
; .FSTART _read_adc
; 0000 002E     ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R16
	MOV  R16,R26
;	adc_input -> R16
	MOV  R30,R16
	ORI  R30,LOW(0xC0)
	STS  124,R30
; 0000 002F     // Start the AD conversion
; 0000 0030     ADCSRA|=(1<<ADSC);
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0031     // Wait for the AD conversion to complete
; 0000 0032     while ((ADCSRA & (1<<ADIF))==0);
_0x22:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x22
; 0000 0033     ADCSRA|=(1<<ADIF);
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
; 0000 0034     return ADCW;
	LDS  R30,120
	LDS  R31,120+1
	JMP  _0x20E0001
; 0000 0035 }
; .FEND
;
;float v1, v2;
;int v1I, v1D, v2I, v2D;
;
;void updateADC(){
; 0000 003A void updateADC(){
_updateADC:
; .FSTART _updateADC
; 0000 003B     v1 = read_adc(7);
	LDI  R26,LOW(7)
	RCALL _read_adc
	LDI  R26,LOW(_v1)
	LDI  R27,HIGH(_v1)
	RCALL SUBOPT_0x0
; 0000 003C     v2 = read_adc(6);
	LDI  R26,LOW(6)
	RCALL _read_adc
	LDI  R26,LOW(_v2)
	LDI  R27,HIGH(_v2)
	RCALL SUBOPT_0x0
; 0000 003D     v1I = (int)v1;
	LDS  R30,_v1
	LDS  R31,_v1+1
	LDS  R22,_v1+2
	LDS  R23,_v1+3
	RCALL __CFD1
	STS  _v1I,R30
	STS  _v1I+1,R31
; 0000 003E     v1D = (int)((v1 - (float)v1I)*10.0);
	RCALL __CWD1
	RCALL __CDF1
	LDS  R26,_v1
	LDS  R27,_v1+1
	LDS  R24,_v1+2
	LDS  R25,_v1+3
	RCALL SUBOPT_0x1
	STS  _v1D,R30
	STS  _v1D+1,R31
; 0000 003F     v2I = (int)v2;
	LDS  R30,_v2
	LDS  R31,_v2+1
	LDS  R22,_v2+2
	LDS  R23,_v2+3
	RCALL __CFD1
	STS  _v2I,R30
	STS  _v2I+1,R31
; 0000 0040     v2D = (int)((v2 - (float)v2I)*10.0);
	RCALL __CWD1
	RCALL __CDF1
	LDS  R26,_v2
	LDS  R27,_v2+1
	LDS  R24,_v2+2
	LDS  R25,_v2+3
	RCALL SUBOPT_0x1
	STS  _v2D,R30
	STS  _v2D+1,R31
; 0000 0041 }
	RET
; .FEND
;
;// SD
;char fileName[]  = "0:muestra.txt";

	.DSEG
;
;interrupt [TIM1_COMPA] void timer1_compa_isr(void)
; 0000 0047 {

	.CSEG
_timer1_compa_isr:
; .FSTART _timer1_compa_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0048 disk_timerproc();
	RCALL _disk_timerproc
; 0000 0049 /* MMC/SD/SD HC card access low level timing function */
; 0000 004A }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;// Open SD
;
;void sd(char NombreArchivo[], char *TextoEscritura){
; 0000 004E void sd(char NombreArchivo[], char *TextoEscritura){
; 0000 004F 
; 0000 0050     unsigned int br;
; 0000 0051     char buffer[100];
; 0000 0052 
; 0000 0053     /* FAT function result */
; 0000 0054     FRESULT res;
; 0000 0055 
; 0000 0056     /* will hold the information for logical drive 0: */
; 0000 0057     FATFS drive;
; 0000 0058     FIL archivo; // file objects
; 0000 0059 
; 0000 005A     /* mount logical drive 0: */
; 0000 005B     if ((res=f_mount(0,&drive))==FR_OK){
;	NombreArchivo -> Y+1211
;	*TextoEscritura -> R19,R20
;	br -> R16,R17
;	buffer -> Y+1111
;	res -> R18
;	drive -> Y+549
;	archivo -> Y+5
; 0000 005C 
; 0000 005D         /*Lectura de Archivo*/
; 0000 005E         res = f_open(&archivo, NombreArchivo, FA_OPEN_ALWAYS | FA_WRITE | FA_READ);
; 0000 005F         if (res==FR_OK){
; 0000 0060 
; 0000 0061             f_read(&archivo, buffer, 10,&br); //leer archivo en buffer
; 0000 0062 
; 0000 0063             f_lseek(&archivo,archivo.fsize);
; 0000 0064 
; 0000 0065             buffer[0] = 0x0D;                //Carriage return
; 0000 0066             buffer[1] = 0x0A;                //Line Feed
; 0000 0067             f_write(&archivo,buffer,2,&br);
; 0000 0068             /*Escribiendo el Texto*/
; 0000 0069             f_write(&archivo,TextoEscritura,sizeof(TextoEscritura),&br);   // Write of TextoEscritura
; 0000 006A             f_close(&archivo);
; 0000 006B         }
; 0000 006C         else{
; 0000 006D             StringLCD("Archivo NO Encontrado");
; 0000 006E         }
; 0000 006F     }
; 0000 0070     else{
; 0000 0071          StringLCD("Drive NO Detectado");
; 0000 0072     }
; 0000 0073     f_mount(0, 0); //Cerrar drive de SD
; 0000 0074 }
;
;// Clock
;unsigned char H=0,M=0,S=0, D=0,Mes=0,A=0; // Variables for clock
;
;unsigned char time[16];
;
;void updateClock(){
; 0000 007B void updateClock(){
; 0000 007C     rtc_get_time(&H, &M, &S);
; 0000 007D     rtc_get_date(&D, &Mes, &A);
; 0000 007E }
;
;// LCD
;void printTime(){
; 0000 0081 void printTime(){
; 0000 0082     sprintf(time, "%02i:%02i:%02i V1: %i.%i", H, M, S, v1I, v1D);
; 0000 0083     MoveCursor(0,0);
; 0000 0084     StringLCDVar(time);
; 0000 0085     sprintf(time, "%02i:%02i:%02i V2: %i.%i", D, Mes, A, v2I, v2D);
; 0000 0086     MoveCursor(0,1);
; 0000 0087     StringLCDVar(time);
; 0000 0088 }
;void eraseLCD(){
; 0000 0089 void eraseLCD(){
; 0000 008A     MoveCursor(0,0);
; 0000 008B     StringLCD("                ");
; 0000 008C     MoveCursor(0,1);
; 0000 008D     StringLCD("                ");
; 0000 008E }
;
;
;
;void main(void)
; 0000 0093 {
_main:
; .FSTART _main
; 0000 0094 
; 0000 0095 // ADC
; 0000 0096 
; 0000 0097 // ADC initialization
; 0000 0098 // ADC Clock frequency: 1000.000 kHz
; 0000 0099 // ADC Voltage Reference: Int., cap. on AREF
; 0000 009A // ADC High Speed Mode: On
; 0000 009B // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
; 0000 009C // ADC4: On, ADC5: On, ADC6: On, ADC7: Off
; 0000 009D DIDR0=(1<<ADC7D) | (1<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
	LDI  R30,LOW(192)
	STS  126,R30
; 0000 009E ADMUX=ADC_VREF_TYPE;
	STS  124,R30
; 0000 009F ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(131)
	STS  122,R30
; 0000 00A0 ADCSRB=(1<<ADHSM);
	LDI  R30,LOW(128)
	STS  123,R30
; 0000 00A1 
; 0000 00A2 // LCD
; 0000 00A3 
; 0000 00A4 SetupLCD();
	RCALL _SetupLCD
; 0000 00A5 
; 0000 00A6 // DS1302
; 0000 00A7 rtc_init(0,0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _rtc_init
; 0000 00A8 
; 0000 00A9 // SD
; 0000 00AA // Código para hacer una interrupción periódica cada 10ms
; 0000 00AB // Timer/Counter 1 initialization
; 0000 00AC // Clock source: System Clock
; 0000 00AD // Clock value: 1000.000 kHz
; 0000 00AE // Mode: CTC top=OCR1A
; 0000 00AF // Compare A Match Interrupt: On
; 0000 00B0 TCCR1B=0x09;
	LDI  R30,LOW(9)
	STS  129,R30
; 0000 00B1 OCR1AH=19999/256;
	LDI  R30,LOW(78)
	STS  137,R30
; 0000 00B2 OCR1AL=19999%256;   //20000cuentas a 0.5us por cuenta=10mseg
	LDI  R30,LOW(31)
	STS  136,R30
; 0000 00B3 TIMSK1=0x02;
	LDI  R30,LOW(2)
	STS  111,R30
; 0000 00B4 SetupLCD();
	RCALL _SetupLCD
; 0000 00B5 #asm("sei")
	SEI
; 0000 00B6 /* Inicia el puerto SPI para la SD */
; 0000 00B7 disk_initialize(0);
	LDI  R26,LOW(0)
	RCALL _disk_initialize
; 0000 00B8 delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00B9 
; 0000 00BA // First actions
; 0000 00BB PORTC = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x8,R30
; 0000 00BC 
; 0000 00BD while (1)
_0x2A:
; 0000 00BE     {
; 0000 00BF     // Please write your application code here
; 0000 00C0         // Verify the correct range on clock time
; 0000 00C1 
; 0000 00C2         // ADC
; 0000 00C3         updateADC();
	RCALL _updateADC
; 0000 00C4 
; 0000 00C5         // Clock
; 0000 00C6 
; 0000 00C7         // If alarm is on, switch will turn alarm off without
; 0000 00C8         //  changing the default variable
; 0000 00C9         if(!PINC.0){
	SBIC 0x6,0
	RJMP _0x2D
; 0000 00CA             H++;
	LDS  R30,_H
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x2
; 0000 00CB             rtc_set_time(H, M, S);
; 0000 00CC         }
; 0000 00CD         if(!PINC.1){
_0x2D:
	SBIC 0x6,1
	RJMP _0x2E
; 0000 00CE             M++;
	LDS  R30,_M
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x3
; 0000 00CF             rtc_set_time(H, M, S);
; 0000 00D0         }
; 0000 00D1         if(!PINC.2){
_0x2E:
	SBIC 0x6,2
	RJMP _0x2F
; 0000 00D2             S=0;
	RCALL SUBOPT_0x4
; 0000 00D3             rtc_set_time(H, M, S);
; 0000 00D4         }
; 0000 00D5         if(!PINC.3){
_0x2F:
	SBIC 0x6,3
	RJMP _0x30
; 0000 00D6             D++;
	LDS  R30,_D
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x5
; 0000 00D7             rtc_set_date(D, Mes, A);
; 0000 00D8         }
; 0000 00D9         if(!PINC.3){
_0x30:
	SBIC 0x6,3
	RJMP _0x31
; 0000 00DA             Mes++;
	LDS  R30,_Mes
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x6
; 0000 00DB             rtc_set_date(D, Mes, A);
; 0000 00DC         }
; 0000 00DD         if(!PINC.3){
_0x31:
	SBIC 0x6,3
	RJMP _0x32
; 0000 00DE             A++;
	LDS  R30,_A
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x7
; 0000 00DF             rtc_set_date(D, Mes, A);
; 0000 00E0         }
; 0000 00E1         if(S>59){
_0x32:
	LDS  R26,_S
	CPI  R26,LOW(0x3C)
	BRLO _0x33
; 0000 00E2             S=0;
	RCALL SUBOPT_0x4
; 0000 00E3             rtc_set_time(H, M, S);
; 0000 00E4         }
; 0000 00E5         if(M>59){
_0x33:
	LDS  R26,_M
	CPI  R26,LOW(0x3C)
	BRLO _0x34
; 0000 00E6             M=0;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x3
; 0000 00E7             rtc_set_time(H, M, S);
; 0000 00E8         }
; 0000 00E9         if(H>23){
_0x34:
	LDS  R26,_H
	CPI  R26,LOW(0x18)
	BRLO _0x35
; 0000 00EA             H=0;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x2
; 0000 00EB             rtc_set_time(H, M, S);
; 0000 00EC         }
; 0000 00ED         if(D>31){
_0x35:
	LDS  R26,_D
	CPI  R26,LOW(0x20)
	BRLO _0x36
; 0000 00EE             D=0;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x5
; 0000 00EF             rtc_set_date(D, Mes, A);
; 0000 00F0         }
; 0000 00F1         if(Mes>12){
_0x36:
	LDS  R26,_Mes
	CPI  R26,LOW(0xD)
	BRLO _0x37
; 0000 00F2             Mes=0;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x6
; 0000 00F3             rtc_set_date(D, Mes, A);
; 0000 00F4         }
; 0000 00F5         if(A>25){
_0x37:
	LDS  R26,_A
	CPI  R26,LOW(0x1A)
	BRLO _0x38
; 0000 00F6             A=00;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x7
; 0000 00F7             rtc_set_date(D, Mes, A);
; 0000 00F8         }
; 0000 00F9     }
_0x38:
	RJMP _0x2A
; 0000 00FA }
_0x39:
	RJMP _0x39
; .FEND

	.CSEG
_ds1302_rst0_G100:
; .FSTART _ds1302_rst0_G100
	cbi  __ds1302_port,__ds1302_rst
	__DELAY_USB 3
	RET
; .FEND
_ds1302_write0_G100:
; .FSTART _ds1302_write0_G100
	ST   -Y,R16
	MOV  R16,R26
    sbi  __ds1302_port-1,__ds1302_sclk
    sbi  __ds1302_port-1,__ds1302_io
    sbi  __ds1302_port-1,__ds1302_rst
    sbi  __ds1302_port,__ds1302_rst
	__DELAY_USB 3
	MOV  R26,R16
	RCALL _ds1302_write1_G100
	JMP  _0x20E0001
; .FEND
_ds1302_write1_G100:
; .FSTART _ds1302_write1_G100
	ST   -Y,R26
    ld   r30,y+
    ldi  r26,8
ds1302_write2:
    ror  r30
    cbi  __ds1302_port,__ds1302_io
    brcc ds1302_write3
    sbi  __ds1302_port,__ds1302_io
ds1302_write3:
    nop
    nop
    nop
    nop
    sbi  __ds1302_port,__ds1302_sclk
	__DELAY_USB 1
	cbi  __ds1302_port,__ds1302_sclk
	__DELAY_USB 1
    dec  r26
    brne ds1302_write2
    ret
; .FEND
_ds1302_write:
; .FSTART _ds1302_write
	ST   -Y,R17
	ST   -Y,R16
	MOV  R16,R26
	LDD  R17,Y+2
	MOV  R30,R17
	ANDI R30,0xFE
	MOV  R26,R30
	RCALL _ds1302_write0_G100
	MOV  R26,R16
	RCALL _ds1302_write1_G100
	RCALL _ds1302_rst0_G100
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0005
; .FEND
_rtc_init:
; .FSTART _rtc_init
	RCALL SUBOPT_0x8
	ANDI R16,LOW(3)
	CPI  R18,0
	BREQ _0x2000003
	ORI  R16,LOW(160)
_0x2000003:
	CPI  R17,1
	BRNE _0x2000004
	ORI  R16,LOW(4)
	RJMP _0x2000005
_0x2000004:
	CPI  R17,2
	BRNE _0x2000006
	ORI  R16,LOW(8)
	RJMP _0x2000007
_0x2000006:
	LDI  R16,LOW(0)
_0x2000007:
_0x2000005:
	RCALL SUBOPT_0x9
	LDI  R30,LOW(144)
	ST   -Y,R30
	MOV  R26,R16
	RJMP _0x20E0007
; .FEND
_rtc_set_time:
; .FSTART _rtc_set_time
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x9
	LDI  R30,LOW(132)
	RCALL SUBOPT_0xA
	LDI  R30,LOW(130)
	RCALL SUBOPT_0xB
	LDI  R30,LOW(128)
	RJMP _0x20E0006
; .FEND
_rtc_set_date:
; .FSTART _rtc_set_date
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x9
	LDI  R30,LOW(134)
	RCALL SUBOPT_0xA
	LDI  R30,LOW(136)
	RCALL SUBOPT_0xB
	LDI  R30,LOW(140)
_0x20E0006:
	ST   -Y,R30
	MOV  R26,R16
	RCALL _bin2bcd
	MOV  R26,R30
_0x20E0007:
	RCALL _ds1302_write
	LDI  R30,LOW(142)
	ST   -Y,R30
	LDI  R26,LOW(128)
	RCALL _ds1302_write
	RCALL __LOADLOCR3
	ADIW R28,5
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
_wait_ready_G101:
; .FSTART _wait_ready_G101
	ST   -Y,R16
	LDI  R30,LOW(50)
	STS  _timer2_G101,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x202000B:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202000B
_0x202000F:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020011:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020011
	IN   R16,46
	CPI  R16,255
	BREQ _0x2020014
	LDS  R30,_timer2_G101
	CPI  R30,0
	BRNE _0x2020015
_0x2020014:
	RJMP _0x2020010
_0x2020015:
	RJMP _0x202000F
_0x2020010:
	MOV  R30,R16
	RJMP _0x20E0001
; .FEND
_deselect_card_G101:
; .FSTART _deselect_card_G101
	SBI  0x5,0
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020016:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020016
	RET
; .FEND
_send_cmd_G101:
; .FSTART _send_cmd_G101
	RCALL __PUTPARD2
	RCALL __SAVELOCR3
	LDD  R18,Y+7
	SBRS R18,7
	RJMP _0x202004F
	ANDI R18,LOW(127)
	LDI  R30,LOW(119)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	MOV  R17,R30
	CPI  R17,2
	BRLO _0x2020050
	RCALL __LOADLOCR3
	RJMP _0x20E0004
_0x2020050:
_0x202004F:
	CPI  R18,76
	BREQ _0x2020051
	RCALL _deselect_card_G101
	CBI  0x5,0
	RCALL _wait_ready_G101
	CPI  R30,LOW(0xFF)
	BREQ _0x2020052
	LDI  R30,LOW(255)
	RCALL __LOADLOCR3
	RJMP _0x20E0004
_0x2020052:
_0x2020051:
	OUT  0x2E,R18
_0x2020053:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020053
	LDD  R30,Y+6
	OUT  0x2E,R30
_0x2020056:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020056
	LDD  R30,Y+5
	OUT  0x2E,R30
_0x2020059:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020059
	LDD  R30,Y+4
	OUT  0x2E,R30
_0x202005C:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202005C
	LDD  R30,Y+3
	OUT  0x2E,R30
_0x202005F:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202005F
	LDI  R16,LOW(1)
	CPI  R18,64
	BRNE _0x2020062
	LDI  R16,LOW(149)
	RJMP _0x2020063
_0x2020062:
	CPI  R18,72
	BRNE _0x2020064
	LDI  R16,LOW(135)
_0x2020064:
_0x2020063:
	OUT  0x2E,R16
_0x2020065:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020065
	CPI  R18,76
	BRNE _0x2020068
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020069:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020069
_0x2020068:
	LDI  R16,LOW(255)
_0x202006D:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x202006F:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202006F
	IN   R17,46
	SBRS R17,7
	RJMP _0x2020072
	SUBI R16,LOW(1)
	BRNE _0x2020073
_0x2020072:
	RJMP _0x202006E
_0x2020073:
	RJMP _0x202006D
_0x202006E:
	MOV  R30,R17
	RCALL __LOADLOCR3
	RJMP _0x20E0004
; .FEND
_rx_spi4_G101:
; .FSTART _rx_spi4_G101
	RCALL __SAVELOCR3
	__PUTW2R 17,18
	LDI  R16,4
_0x2020075:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020077:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020077
	PUSH R18
	PUSH R17
	__ADDWRN 17,18,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	SUBI R16,LOW(1)
	BRNE _0x2020075
	RCALL __LOADLOCR3
_0x20E0005:
	ADIW R28,3
	RET
; .FEND
_disk_initialize:
; .FSTART _disk_initialize
	SBIW R28,4
	RCALL __SAVELOCR4
	MOV  R19,R26
	CPI  R19,0
	BREQ _0x202007A
	LDI  R30,LOW(1)
	RJMP _0x20E0003
_0x202007A:
	CBI  0x4,4
	CBI  0x4,5
	LDI  R30,LOW(10)
	STS  _timer1_G101,R30
_0x202007B:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BRNE _0x202007B
	LDS  R30,_status_G101
	ANDI R30,LOW(0x2)
	BREQ _0x202007E
	RJMP _0x20E0002
_0x202007E:
	SBI  0x4,0
	SBI  0x5,0
	IN   R30,0x5
	ANDI R30,LOW(0xF9)
	OUT  0x5,R30
	SBI  0x5,3
	CBI  0x4,3
	IN   R30,0x4
	ORI  R30,LOW(0x7)
	OUT  0x4,R30
	LDI  R30,LOW(81)
	OUT  0x2C,R30
	LDI  R30,LOW(0)
	OUT  0x2D,R30
	LDI  R18,LOW(255)
_0x2020080:
	LDI  R16,LOW(10)
_0x2020083:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020085:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020085
	SUBI R16,LOW(1)
	BRNE _0x2020083
	LDI  R30,LOW(64)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	MOV  R17,R30
	SUBI R18,LOW(1)
	CPI  R17,1
	BREQ _0x2020088
	CPI  R18,0
	BRNE _0x2020089
_0x2020088:
	RJMP _0x2020081
_0x2020089:
	RJMP _0x2020080
_0x2020081:
	LDI  R18,LOW(0)
	CPI  R17,1
	BREQ PC+2
	RJMP _0x202008A
	LDI  R30,LOW(100)
	STS  _timer1_G101,R30
	LDI  R30,LOW(72)
	ST   -Y,R30
	__GETD2N 0x1AA
	RCALL _send_cmd_G101
	CPI  R30,LOW(0x1)
	BRNE _0x202008B
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G101
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x202008D
	LDD  R26,Y+7
	CPI  R26,LOW(0xAA)
	BREQ _0x202008E
_0x202008D:
	RJMP _0x202008C
_0x202008E:
_0x202008F:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x2020092
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x40000000
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x2020093
_0x2020092:
	RJMP _0x2020091
_0x2020093:
	RJMP _0x202008F
_0x2020091:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x2020095
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BREQ _0x2020096
_0x2020095:
	RJMP _0x2020094
_0x2020096:
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G101
	LDD  R30,Y+4
	ANDI R30,LOW(0x40)
	BREQ _0x2020097
	LDI  R30,LOW(12)
	RJMP _0x2020098
_0x2020097:
	LDI  R30,LOW(4)
_0x2020098:
	MOV  R18,R30
_0x2020094:
_0x202008C:
	RJMP _0x202009A
_0x202008B:
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,LOW(0x2)
	BRSH _0x202009B
	LDI  R18,LOW(2)
	LDI  R17,LOW(233)
	RJMP _0x202009C
_0x202009B:
	LDI  R18,LOW(1)
	LDI  R17,LOW(65)
_0x202009C:
_0x202009D:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x20200A0
	ST   -Y,R17
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200A1
_0x20200A0:
	RJMP _0x202009F
_0x20200A1:
	RJMP _0x202009D
_0x202009F:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x20200A3
	LDI  R30,LOW(80)
	ST   -Y,R30
	__GETD2N 0x200
	RCALL _send_cmd_G101
	CPI  R30,0
	BREQ _0x20200A2
_0x20200A3:
	LDI  R18,LOW(0)
_0x20200A2:
_0x202009A:
_0x202008A:
	STS  _card_type_G101,R18
	RCALL _deselect_card_G101
	CPI  R18,0
	BREQ _0x20200A5
	LDS  R30,_status_G101
	ANDI R30,0xFE
	STS  _status_G101,R30
	LDI  R30,LOW(80)
	OUT  0x2C,R30
	LDI  R30,LOW(1)
	OUT  0x2D,R30
	RJMP _0x20200A6
_0x20200A5:
	CBI  0x5,0
	RCALL _wait_ready_G101
	RCALL _deselect_card_G101
	LDI  R30,LOW(0)
	OUT  0x2C,R30
	IN   R30,0x4
	ANDI R30,LOW(0xF0)
	OUT  0x4,R30
	IN   R30,0x5
	ANDI R30,LOW(0xF0)
	OUT  0x5,R30
	CBI  0x4,0
	LDS  R30,_status_G101
	ORI  R30,1
	STS  _status_G101,R30
_0x20200A6:
_0x20E0002:
	LDS  R30,_status_G101
_0x20E0003:
	RCALL __LOADLOCR4
_0x20E0004:
	ADIW R28,8
	RET
; .FEND
_disk_timerproc:
; .FSTART _disk_timerproc

	.DSEG

	.CSEG
	ST   -Y,R16
	LDS  R16,_timer1_G101
	CPI  R16,0
	BREQ _0x20200FF
	SUBI R16,LOW(1)
	STS  _timer1_G101,R16
_0x20200FF:
	LDS  R16,_timer2_G101
	CPI  R16,0
	BREQ _0x2020100
	SUBI R16,LOW(1)
	STS  _timer2_G101,R16
_0x2020100:
	LDS  R16,_flags_S101000C000
	LDI  R30,LOW(0)
	STS  _flags_S101000C000,R30
	SBIC 0x3,4
	RJMP _0x2020101
	LDI  R30,LOW(1)
	STS  _flags_S101000C000,R30
_0x2020101:
	SBIS 0x3,5
	RJMP _0x2020102
	LDS  R30,_flags_S101000C000
	ORI  R30,2
	STS  _flags_S101000C000,R30
_0x2020102:
	LDS  R30,_flags_S101000C000
	CP   R30,R16
	BRNE _0x2020103
	LDS  R16,_status_G101
	ANDI R30,LOW(0x1)
	BREQ _0x2020104
	ANDI R16,LOW(253)
	RJMP _0x2020105
_0x2020104:
	ORI  R16,LOW(3)
_0x2020105:
	LDS  R30,_flags_S101000C000
	ANDI R30,LOW(0x2)
	BREQ _0x2020106
	ORI  R16,LOW(4)
	RJMP _0x2020107
_0x2020106:
	ANDI R16,LOW(251)
_0x2020107:
	STS  _status_G101,R16
_0x2020103:
_0x20E0001:
	LD   R16,Y+
	RET
; .FEND

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG
_bin2bcd:
; .FSTART _bin2bcd
	ST   -Y,R26
    ld   r26,y+
    clr  r30
bin2bcd0:
    subi r26,10
    brmi bin2bcd1
    subi r30,-16
    rjmp bin2bcd0
bin2bcd1:
    subi r26,-10
    add  r30,r26
    ret
; .FEND

	.CSEG

	.CSEG

	.DSEG
_cursor:
	.BYTE 0x1
_prtc_get_time:
	.BYTE 0x2
_prtc_get_date:
	.BYTE 0x2
_v1:
	.BYTE 0x4
_v2:
	.BYTE 0x4
_v1I:
	.BYTE 0x2
_v1D:
	.BYTE 0x2
_v2I:
	.BYTE 0x2
_v2D:
	.BYTE 0x2
_H:
	.BYTE 0x1
_M:
	.BYTE 0x1
_S:
	.BYTE 0x1
_D:
	.BYTE 0x1
_Mes:
	.BYTE 0x1
_A:
	.BYTE 0x1
_time:
	.BYTE 0x10
_status_G101:
	.BYTE 0x1
_timer1_G101:
	.BYTE 0x1
_timer2_G101:
	.BYTE 0x1
_card_type_G101:
	.BYTE 0x1
_flags_S101000C000:
	.BYTE 0x1
_FatFs_G102:
	.BYTE 0x2
_Fsid_G102:
	.BYTE 0x2
_Drive_G102:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	CLR  R22
	CLR  R23
	RCALL __CDF1
	RCALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	RCALL __SWAPD12
	RCALL __SUBF12
	__GETD2N 0x41200000
	RCALL __MULF12
	RCALL __CFD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x2:
	STS  _H,R30
	ST   -Y,R30
	LDS  R30,_M
	ST   -Y,R30
	LDS  R26,_S
	RJMP _rtc_set_time

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x3:
	STS  _M,R30
	LDS  R30,_H
	ST   -Y,R30
	LDS  R30,_M
	ST   -Y,R30
	LDS  R26,_S
	RJMP _rtc_set_time

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(0)
	STS  _S,R30
	LDS  R30,_H
	ST   -Y,R30
	LDS  R30,_M
	ST   -Y,R30
	LDS  R26,_S
	RJMP _rtc_set_time

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x5:
	STS  _D,R30
	ST   -Y,R30
	LDS  R30,_Mes
	ST   -Y,R30
	LDS  R26,_A
	RJMP _rtc_set_date

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x6:
	STS  _Mes,R30
	LDS  R30,_D
	ST   -Y,R30
	LDS  R30,_Mes
	ST   -Y,R30
	LDS  R26,_A
	RJMP _rtc_set_date

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x7:
	STS  _A,R30
	LDS  R30,_D
	ST   -Y,R30
	LDS  R30,_Mes
	ST   -Y,R30
	LDS  R26,_A
	RJMP _rtc_set_date

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	RCALL __SAVELOCR3
	MOV  R16,R26
	LDD  R17,Y+3
	LDD  R18,Y+4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(142)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RJMP _ds1302_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA:
	ST   -Y,R30
	MOV  R26,R18
	RCALL _bin2bcd
	MOV  R26,R30
	RJMP _ds1302_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB:
	ST   -Y,R30
	MOV  R26,R17
	RCALL _bin2bcd
	MOV  R26,R30
	RJMP _ds1302_write

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	PUSH R26
	PUSH R27
	MOVW R26,R22
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	POP  R27
	POP  R26
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	MOVW R22,R30
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x1F4
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
