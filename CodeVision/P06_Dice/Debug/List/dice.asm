
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : AT90USB1286
;Program type           : Application
;Clock frequency        : 1.000000 MHz
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
;Enhanced function parameter passing: Yes
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
	JMP  _timer3_ovf_isr
	JMP  0x00
	JMP  0x00

_Dice:
	.DB  0x0,0x0,0x0,0x18,0x18,0x0,0x0,0x0
	.DB  0xC0,0xC0,0x0,0x0,0x0,0x0,0x3,0x3
	.DB  0xC0,0xC0,0x0,0x18,0x18,0x0,0x3,0x3
	.DB  0xC3,0xC3,0x0,0x0,0x0,0x0,0xC3,0xC3
	.DB  0xC3,0xC3,0x0,0x18,0x18,0x0,0xC3,0xC3
	.DB  0xDB,0xDB,0x0,0x0,0x0,0x0,0xDB,0xDB
_SmallDice:
	.DB  0x0,0x2,0x0,0x4,0x0,0x1,0x4,0x2
	.DB  0x1,0x5,0x0,0x5,0x5,0x2,0x5,0x7
	.DB  0x0,0x7
_Letras:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xF2
	.DB  0x0,0x0,0x0,0xE0,0x0,0xE0,0x0,0x28
	.DB  0xFE,0x28,0xFE,0x28,0x24,0x54,0xFE,0x54
	.DB  0x48,0xC4,0xC8,0x10,0x26,0x46,0x6C,0x92
	.DB  0xAA,0x84,0xA,0x0,0xA0,0xC0,0x0,0x0
	.DB  0x0,0x38,0x44,0x82,0x0,0x0,0x82,0x44
	.DB  0x38,0x0,0x28,0x10,0x7C,0x10,0x28,0x10
	.DB  0x10,0x7C,0x10,0x10,0x0,0x5,0x6,0x0
	.DB  0x0,0x10,0x10,0x10,0x10,0x10,0x0,0x6
	.DB  0x6,0x0,0x0,0x4,0x8,0x10,0x20,0x40
	.DB  0x7C,0x8A,0x92,0xA2,0x7C,0x0,0x42,0xFE
	.DB  0x2,0x0,0x42,0x86,0x8A,0x92,0x62,0x84
	.DB  0x82,0xA2,0xE2,0x9C,0x18,0x28,0x48,0xFE
	.DB  0x8,0xE4,0xA2,0xA2,0xA2,0x9C,0x3C,0x52
	.DB  0x92,0x92,0xC,0x80,0x8E,0x90,0xA0,0xC0
	.DB  0x6C,0x92,0x92,0x92,0x6C,0x60,0x92,0x92
	.DB  0x94,0x78,0x0,0x36,0x36,0x0,0x0,0x0
	.DB  0x35,0x36,0x0,0x0,0x10,0x28,0x44,0x82
	.DB  0x0,0x28,0x28,0x28,0x28,0x28,0x0,0x82
	.DB  0x44,0x28,0x10,0x40,0x80,0x8A,0x90,0x60
	.DB  0x4C,0x92,0x9E,0x82,0x7C,0x7E,0x90,0x90
	.DB  0x90,0x7E,0xFE,0x92,0x92,0x92,0x6C,0x7C
	.DB  0x82,0x82,0x82,0x44,0xFE,0x82,0x82,0x82
	.DB  0x7C,0xFE,0x92,0x92,0x92,0x92,0xFE,0x90
	.DB  0x90,0x90,0x90,0x7C,0x82,0x92,0x92,0x5C
	.DB  0xFE,0x10,0x10,0x10,0xFE,0x0,0x82,0xFE
	.DB  0x82,0x0,0x84,0x82,0x82,0x82,0xFC,0xFE
	.DB  0x10,0x28,0x44,0x82,0xFE,0x2,0x2,0x2
	.DB  0x2,0xFE,0x40,0x20,0x40,0xFE,0xFE,0x40
	.DB  0x20,0x10,0xFE,0x7C,0x82,0x82,0x82,0x7C
	.DB  0xFE,0x90,0x90,0x90,0x60,0x7C,0x82,0x86
	.DB  0x82,0x7D,0xFE,0x90,0x98,0x94,0x62,0x64
	.DB  0x92,0x92,0x92,0x4C,0x80,0x80,0xFE,0x80
	.DB  0x80,0xFC,0x2,0x2,0x2,0xFC,0xF8,0x4
	.DB  0x2,0x4,0xF8,0xFE,0x4,0x8,0x4,0xFE
	.DB  0xC6,0x28,0x10,0x28,0xC6,0xC0,0x20,0x1E
	.DB  0x20,0xC0,0x86,0x8A,0x92,0xA2,0xC2,0x0
	.DB  0xFE,0x82,0x82,0x0,0x40,0x20,0x10,0x8
	.DB  0x4,0x0,0x82,0x82,0xFE,0x0,0x20,0x40
	.DB  0x80,0x40,0x20,0x2,0x2,0x2,0x2,0x2
	.DB  0x0,0x80,0x40,0x20,0x0,0x4,0x2A,0x2A
	.DB  0x2A,0x1E,0xFE,0x12,0x22,0x22,0x1C,0x1C
	.DB  0x22,0x22,0x22,0x22,0x1C,0x22,0x22,0x12
	.DB  0xFE,0x1C,0x2A,0x2A,0x2A,0x18,0x10,0x7E
	.DB  0x90,0x80,0x40,0x18,0x25,0x25,0x25,0x3E
	.DB  0xFE,0x10,0x20,0x20,0x1E,0x0,0x22,0xBE
	.DB  0x2,0x0,0x4,0x2,0x22,0xBC,0x0,0xFE
	.DB  0x8,0x14,0x22,0x0,0x0,0x82,0xFE,0x2
	.DB  0x0,0x3E,0x20,0x18,0x20,0x1E,0x3E,0x10
	.DB  0x20,0x20,0x1E,0x1C,0x22,0x22,0x22,0x1C
	.DB  0x3F,0x24,0x24,0x24,0x18,0x18,0x24,0x24
	.DB  0x24,0x3F,0x3E,0x10,0x20,0x20,0x10,0x12
	.DB  0x2A,0x2A,0x2A,0x4,0x20,0xFE,0x22,0x2
	.DB  0x4,0x3C,0x2,0x2,0x4,0x3E,0x38,0x4
	.DB  0x2,0x4,0x38,0x3C,0x2,0xC,0x2,0x3C
	.DB  0x22,0x14,0x8,0x14,0x22,0x30,0xA,0xA
	.DB  0xA,0x3C,0x22,0x26,0x2A,0x32,0x22,0x0
	.DB  0x10,0x6C,0x82,0x0,0x0,0x0,0xFE,0x0
	.DB  0x0,0x0,0x82,0x6C,0x10,0x0,0x10,0x20
	.DB  0x10,0x8,0x10,0x0,0x0,0x0,0x0,0x0
	.DB  0x4,0xAA,0x2A,0xAA,0x1E,0x1C,0xA2,0x22
	.DB  0xA2,0x1C,0x1C,0x42,0x2,0x42,0x1C,0x3E
	.DB  0xD0,0x50,0xD0,0x3E,0x3C,0xC2,0x42,0xC2
	.DB  0x3C,0x3C,0x82,0x2,0x82,0x3C,0x7F,0x90
	.DB  0x92,0x92,0x6C,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0
_Animacion:
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
	.DB  0x18,0x18,0x0,0x2,0x2,0x0,0x18,0x18
	.DB  0x8,0x10,0x8,0x2,0x2,0x8,0x10,0x8
	.DB  0x18,0x18,0x0,0x2,0x2,0x0,0x18,0x18
	.DB  0x8,0x10,0x8,0x2,0x2,0x8,0x10,0x8
	.DB  0x18,0x18,0x0,0x2,0x2,0x0,0x18,0x18
	.DB  0x8,0x10,0x8,0x2,0x2,0x8,0x10,0x8
	.DB  0x8,0x10,0xA,0x3,0x3,0xA,0x10,0x8
	.DB  0x8,0x10,0x8,0x2,0x2,0x8,0x10,0x8
	.DB  0x8,0x10,0xA,0x3,0x3,0xA,0x10,0x8
	.DB  0x8,0x10,0x8,0x2,0x2,0x8,0x10,0x8
	.DB  0x8,0x10,0xA,0x3,0x3,0xA,0x10,0x8
	.DB  0x0,0xFE,0x10,0x10,0x10,0xFE,0x0,0x0
	.DB  0x0,0x0,0x22,0xBE,0x2,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0xF2,0x0,0x0,0x0,0x0
	.DB  0x8,0x8,0x11,0x2,0x2,0x11,0x8,0x8
	.DB  0x8,0x8,0x10,0x3,0x3,0x10,0x8,0x8
	.DB  0x8,0x8,0x11,0x2,0x2,0x11,0x8,0x8
	.DB  0x8,0x8,0x10,0x3,0x3,0x10,0x8,0x8
	.DB  0x0,0xFE,0x92,0x92,0x92,0x6C,0x0,0x0
	.DB  0x0,0x30,0xA,0xA,0xA,0x3C,0x0,0x0
	.DB  0x0,0x1C,0x2A,0x2A,0x2A,0x18,0x0,0x0
	.DB  0x0,0x0,0x0,0xF2,0x0,0x0,0x0,0x0
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x3,0x3,0x10,0x8,0x10
	.DB  0x10,0x8,0x10,0x2,0x2,0x10,0x8,0x10
_MarioBros:
	.DB  0x94,0x2,0x94,0x2,0x1,0x0,0x94,0x2
	.DB  0x1,0x0,0xC,0x2,0x94,0x2,0x1,0x0
	.DB  0xE,0x3,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x87,0x1,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0xC,0x2,0x1,0x0,0x1,0x0,0x87,0x1
	.DB  0x1,0x0,0x1,0x0,0x4A,0x1,0x1,0x0
	.DB  0x1,0x0,0xB8,0x1,0x1,0x0,0xEE,0x1
	.DB  0x1,0x0,0xD3,0x1,0xB8,0x1,0x1,0x0
	.DB  0x87,0x1,0x94,0x2,0x1,0x0,0xE,0x3
	.DB  0x70,0x3,0x1,0x0,0xBA,0x2,0xE,0x3
	.DB  0x1,0x0,0x94,0x2,0x1,0x0,0xC,0x2
	.DB  0x4C,0x2,0xEE,0x1,0x1,0x0,0x1,0x0
	.DB  0xC,0x2,0x1,0x0,0x1,0x0,0x87,0x1
	.DB  0x1,0x0,0x1,0x0,0x4A,0x1,0x1,0x0
	.DB  0x1,0x0,0xB8,0x1,0x1,0x0,0xEE,0x1
	.DB  0x1,0x0,0xD3,0x1,0xB8,0x1,0x1,0x0
	.DB  0x87,0x1,0x94,0x2,0x1,0x0,0xE,0x3
	.DB  0x70,0x3,0x1,0x0,0xBA,0x2,0xE,0x3
	.DB  0x1,0x0,0x94,0x2,0x1,0x0,0xC,0x2
	.DB  0x4C,0x2,0xEE,0x1,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0xE,0x3,0xE4,0x2
	.DB  0xBA,0x2,0x70,0x2,0x1,0x0,0x94,0x2
	.DB  0x1,0x0,0xA0,0x1,0xB8,0x1,0xC,0x2
	.DB  0x1,0x0,0xB8,0x1,0xC,0x2,0x4C,0x2
	.DB  0x1,0x0,0x1,0x0,0xE,0x3,0xE4,0x2
	.DB  0xBA,0x2,0x70,0x2,0x1,0x0,0x94,0x2
	.DB  0x1,0x0,0x18,0x4,0x1,0x0,0x18,0x4
	.DB  0x18,0x4,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0xE,0x3,0xE4,0x2
	.DB  0xBA,0x2,0x70,0x2,0x1,0x0,0x94,0x2
	.DB  0x1,0x0,0xA0,0x1,0xB8,0x1,0xC,0x2
	.DB  0x1,0x0,0xB8,0x1,0xC,0x2,0x4C,0x2
	.DB  0x1,0x0,0x1,0x0,0x70,0x2,0x1,0x0
	.DB  0x1,0x0,0x4C,0x2,0x1,0x0,0x1,0x0
	.DB  0xC,0x2,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0xE,0x3,0xE4,0x2
	.DB  0xBA,0x2,0x70,0x2,0x1,0x0,0x94,0x2
	.DB  0x1,0x0,0xA0,0x1,0xB8,0x1,0xC,0x2
	.DB  0x1,0x0,0xB8,0x1,0xC,0x2,0x4C,0x2
	.DB  0x1,0x0,0x1,0x0,0xE,0x3,0xE4,0x2
	.DB  0xBA,0x2,0x70,0x2,0x1,0x0,0x94,0x2
	.DB  0x1,0x0,0x18,0x4,0x1,0x0,0x18,0x4
	.DB  0x18,0x4,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0xE,0x3,0xE4,0x2
	.DB  0xBA,0x2,0x70,0x2,0x1,0x0,0x94,0x2
	.DB  0x1,0x0,0xA0,0x1,0xB8,0x1,0xC,0x2
	.DB  0x1,0x0,0xB8,0x1,0xC,0x2,0x4C,0x2
	.DB  0x1,0x0,0x1,0x0,0x70,0x2,0x1,0x0
	.DB  0x1,0x0,0x4C,0x2,0x1,0x0,0x1,0x0
	.DB  0xC,0x2,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0xC,0x2,0xC,0x2,0x1,0x0,0xC,0x2
	.DB  0x1,0x0,0xC,0x2,0x4C,0x2,0x1,0x0
	.DB  0x94,0x2,0xC,0x2,0x1,0x0,0xB8,0x1
	.DB  0x87,0x1,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0xC,0x2,0xC,0x2,0x1,0x0,0xC,0x2
	.DB  0x1,0x0,0xC,0x2,0x4C,0x2,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xC,0x2
	.DB  0xC,0x2,0x1,0x0,0xC,0x2,0x1,0x0
	.DB  0xC,0x2,0x4C,0x2,0x1,0x0,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0xB8,0x1,0x87,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x94,0x2
	.DB  0x94,0x2,0x1,0x0,0x94,0x2,0x1,0x0
	.DB  0xC,0x2,0x94,0x2,0x1,0x0,0xE,0x3
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x87,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xC,0x2
	.DB  0x1,0x0,0x1,0x0,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0x4A,0x1,0x1,0x0,0x1,0x0
	.DB  0xB8,0x1,0x1,0x0,0xEE,0x1,0x1,0x0
	.DB  0xD3,0x1,0xB8,0x1,0x1,0x0,0x87,0x1
	.DB  0x94,0x2,0x1,0x0,0xE,0x3,0x70,0x3
	.DB  0x1,0x0,0xBA,0x2,0xE,0x3,0x1,0x0
	.DB  0x94,0x2,0x1,0x0,0xC,0x2,0x4C,0x2
	.DB  0xEE,0x1,0x1,0x0,0x1,0x0,0xC,0x2
	.DB  0x1,0x0,0x1,0x0,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0x4A,0x1,0x1,0x0,0x1,0x0
	.DB  0xB8,0x1,0x1,0x0,0xEE,0x1,0x1,0x0
	.DB  0xD3,0x1,0xB8,0x1,0x1,0x0,0x87,0x1
	.DB  0x94,0x2,0x1,0x0,0xE,0x3,0x70,0x3
	.DB  0x1,0x0,0xBA,0x2,0xE,0x3,0x1,0x0
	.DB  0x94,0x2,0x1,0x0,0xC,0x2,0x4C,0x2
	.DB  0xEE,0x1,0x1,0x0,0x1,0x0,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0xA0,0x1,0x1,0x0,0xB8,0x1
	.DB  0xBA,0x2,0x1,0x0,0xBA,0x2,0xB8,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xEE,0x1
	.DB  0x70,0x3,0x1,0x0,0x70,0x3,0x70,0x3
	.DB  0xE,0x3,0x1,0x0,0xBA,0x2,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0xB8,0x1,0x87,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0xA0,0x1,0x1,0x0,0xB8,0x1
	.DB  0xBA,0x2,0x1,0x0,0xBA,0x2,0xB8,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xEE,0x1
	.DB  0xBA,0x2,0x1,0x0,0xBA,0x2,0xBA,0x2
	.DB  0x94,0x2,0x1,0x0,0x4C,0x2,0x87,0x1
	.DB  0x4A,0x1,0x1,0x0,0x4A,0x1,0x6,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0xA0,0x1,0x1,0x0,0xB8,0x1
	.DB  0xBA,0x2,0x1,0x0,0xBA,0x2,0xB8,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xEE,0x1
	.DB  0x70,0x3,0x1,0x0,0x70,0x3,0x70,0x3
	.DB  0xE,0x3,0x1,0x0,0xBA,0x2,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0xB8,0x1,0x87,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0xA0,0x1,0x1,0x0,0xB8,0x1
	.DB  0xBA,0x2,0x1,0x0,0xBA,0x2,0xB8,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xEE,0x1
	.DB  0xBA,0x2,0x1,0x0,0xBA,0x2,0xBA,0x2
	.DB  0x94,0x2,0x1,0x0,0x4C,0x2,0x87,0x1
	.DB  0x4A,0x1,0x1,0x0,0x4A,0x1,0x6,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xC,0x2
	.DB  0xC,0x2,0x1,0x0,0xC,0x2,0x1,0x0
	.DB  0xC,0x2,0x4C,0x2,0x1,0x0,0x94,0x2
	.DB  0xC,0x2,0x1,0x0,0xB8,0x1,0x87,0x1
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0xC,0x2
	.DB  0xC,0x2,0x1,0x0,0xC,0x2,0x1,0x0
	.DB  0xC,0x2,0x4C,0x2,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0xC,0x2,0xC,0x2
	.DB  0x1,0x0,0xC,0x2,0x1,0x0,0xC,0x2
	.DB  0x4C,0x2,0x1,0x0,0x94,0x2,0xC,0x2
	.DB  0x1,0x0,0xB8,0x1,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x94,0x2,0x94,0x2
	.DB  0x1,0x0,0x94,0x2,0x1,0x0,0xC,0x2
	.DB  0x94,0x2,0x1,0x0,0xE,0x3,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x94,0x2,0xC,0x2
	.DB  0x1,0x0,0x87,0x1,0x1,0x0,0x1,0x0
	.DB  0xA0,0x1,0x1,0x0,0xB8,0x1,0xBA,0x2
	.DB  0x1,0x0,0xBA,0x2,0xB8,0x1,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0xEE,0x1,0x70,0x3
	.DB  0x1,0x0,0x70,0x3,0x70,0x3,0xE,0x3
	.DB  0x1,0x0,0xBA,0x2,0x94,0x2,0xC,0x2
	.DB  0x1,0x0,0xB8,0x1,0x87,0x1,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x94,0x2,0xC,0x2
	.DB  0x1,0x0,0x87,0x1,0x1,0x0,0x1,0x0
	.DB  0xA0,0x1,0x1,0x0,0xB8,0x1,0xBA,0x2
	.DB  0x1,0x0,0xBA,0x2,0xB8,0x1,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0xEE,0x1,0xBA,0x2
	.DB  0x1,0x0,0xBA,0x2,0xBA,0x2,0x94,0x2
	.DB  0x1,0x0,0x4C,0x2,0x87,0x1,0x4A,0x1
	.DB  0x1,0x0,0x4A,0x1,0x6,0x1,0x1,0x0
	.DB  0x1,0x0,0x1,0x0,0x0,0x0

_0x19:
	.DB  0x57,0x65,0x6C,0x63,0x6F,0x6D,0x65
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x07
	.DW  _str
	.DW  _0x19*2

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

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
	.ORG 0

	.DSEG
	.ORG 0x900

	.CSEG
;/*
; * dice.c
; *
; * Created: 28-Apr-20 4:26:07 PM
; * Author: javie
; */
;
;#include <io.h>
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
;#include <stdlib.h>
;#include <delay.h>
;#include "MatrixDice.h"
;#include "Letras.h"
;#include "Animacion.h"
;
;#define DIN PORTC.0
;#define LOAD PORTC.1
;#define CLK PORTC.2
;
;unsigned int i=0, j=0;
;
;flash int du=262,re= 294, ri=312, mi =330,fa=349, fi=370, sol=391,si=416, la=440, li=467, ti=494;
;flash int MarioBros[591]={mi*2,mi*2,1,mi*2,1,du*2,mi*2,1,sol*2,1,1,1,sol,1,1,1,du*2,1,1,sol,1,1,mi,1,1,la,1,ti,1,li,la,1 ...
;1,mi*2,1,du*2,re*2,ti,1,1,du*2,1,1,sol,1,1,mi,1,1,la,1,ti,1,li,la,1,sol,mi*2,1,sol*2,la*2,1,fa*2,sol*2,1,mi*2,1,du*2,re* ...
;mi*2,1,si,la,du*2,1,la,du*2,re*2,1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,du*4,1,du*4,du*4,1,1,1,1,1,sol*2,fi*2,fa*2,ri*2,1,mi* ...
;ri*2,1,1,re*2,1,1,du*2,1,1,1,1,1,1,1,1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,si,la,du*2,1,la,du*2,re*2,1,1,sol*2,fi*2,fa*2,ri* ...
;1,1,sol*2,fi*2,fa*2,ri*2,1,mi*2,1,si,la,du*2,1,la,du*2,re*2,1,1,ri*2,1,1,re*2,1,1,du*2,1,1,1,1,1,1,1,du*2,du*2,1,du*2,1, ...
;du*2,du*2,1,du*2,1,du*2,re*2,1,1,1,1,1,1,1,1,du*2,du*2,1,du*2,1,du*2,re*2,1,mi*2,du*2,1,la,sol,1,1,1,mi*2,mi*2,1,mi*2,1, ...
;1,1,sol,1,1,mi,1,1,la,1,ti,1,li,la,1,sol,mi*2,1,sol*2,la*2,1,fa*2,sol*2,1,mi*2,1,du*2,re*2,ti,1,1,du*2,1,1,sol,1,1,mi,1, ...
;la*2,1,fa*2,sol*2,1,mi*2,1,du*2,re*2,ti,1,1,mi*2,du*2,1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,la*2,1,la*2,la*2,sol*2,1 ...
;1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,fa*2,1,fa*2,fa*2,mi*2,1,re*2,sol,mi,1,mi,du,1,1,1,mi*2,du*2,1,sol,1,1,si,1,la, ...
;sol*2,1,fa*2,mi*2,du*2,1,la,sol,1,1,1,mi*2,du*2,1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,fa*2,1,fa*2,fa*2,mi*2,1,re*2,s ...
;du*2,re*2,1,mi*2,du*2,1,la,sol,1,1,1,du*2,du*2,1,du*2,1,du*2,re*2,1,1,1,1,1,1,1,1,du*2,du*2,1,du*2,1,du*2,re*2,1,mi*2,du ...
;mi*2,1,sol*2,1,1,1,sol,1,1,1,mi*2,du*2,1,sol,1,1,si,1,la,fa*2,1,fa*2,la,1,1,1,ti,la*2,1,la*2,la*2,sol*2,1,fa*2,mi*2,du*2 ...
;fa*2,1,fa*2,la,1,1,1,ti,fa*2,1,fa*2,fa*2,mi*2,1,re*2,sol,mi,1,mi,du,1,1,1,0};
;
;
;void noTono(){
; 0000 0025 void noTono(){

	.CSEG
_noTono:
; .FSTART _noTono
; 0000 0026     TCCR1B=0x00;
	LDI  R30,LOW(0)
	STS  129,R30
; 0000 0027 }
	RET
; .FEND
;
;void tono(float freq){
; 0000 0029 void tono(float freq){
_tono:
; .FSTART _tono
; 0000 002A     float cuentas;
; 0000 002B     unsigned int cuentasEnt;
; 0000 002C 
; 0000 002D     cuentas = 500000.0/freq;
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
;	freq -> Y+6
;	cuentas -> Y+2
;	cuentasEnt -> R16,R17
	__GETD1S 6
	__GETD2N 0x48F42400
	CALL __DIVF21
	__PUTD1S 2
; 0000 002E     cuentasEnt = cuentas;
	CALL __CFD1U
	MOVW R16,R30
; 0000 002F     if(cuentas-cuentasEnt>=0.5)
	__GETD2S 2
	CLR  R22
	CLR  R23
	CALL __CDF1
	CALL __SWAPD12
	CALL __SUBF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3F000000
	CALL __CMPF12
	BRLO _0x3
; 0000 0030         cuentasEnt++;
	__ADDWRN 16,17,1
; 0000 0031     OCR1AH=(cuentasEnt-1)/256;
_0x3:
	MOVW R30,R16
	SBIW R30,1
	MOV  R30,R31
	LDI  R31,0
	STS  137,R30
; 0000 0032     OCR1AL=(cuentasEnt-1)%256;
	MOV  R30,R16
	SUBI R30,LOW(1)
	STS  136,R30
; 0000 0033     TCCR1A=0x40;    // Timer 1 en modo de CTC
	LDI  R30,LOW(64)
	STS  128,R30
; 0000 0034     TCCR1B=0x09;    // Timer en CK (sin pre-escalador)
	LDI  R30,LOW(9)
	STS  129,R30
; 0000 0035 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
;
;void MandaMax7219 (unsigned int dato)
; 0000 0038 {
_MandaMax7219:
; .FSTART _MandaMax7219
; 0000 0039     unsigned char i;        //Contador para 16b
; 0000 003A     CLK=0;                  //Valores de inicializacion
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R16
;	dato -> Y+1
;	i -> R16
	CBI  0x8,2
; 0000 003B     LOAD=0;                 //Valores de inicializacion
	CBI  0x8,1
; 0000 003C     for (i=0;i<16;i++)
	LDI  R16,LOW(0)
_0x9:
	CPI  R16,16
	BRSH _0xA
; 0000 003D     {
; 0000 003E         if ((dato&0x8000)==0)
	LDD  R30,Y+2
	ANDI R30,LOW(0x80)
	BRNE _0xB
; 0000 003F             DIN=0;
	CBI  0x8,0
; 0000 0040         else
	RJMP _0xE
_0xB:
; 0000 0041             DIN=1;
	SBI  0x8,0
; 0000 0042         CLK=1;
_0xE:
	SBI  0x8,2
; 0000 0043         CLK=0;
	CBI  0x8,2
; 0000 0044         dato=dato<<1;         //El siguiente bit pasa a ser el mas significativo
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LSL  R30
	ROL  R31
	STD  Y+1,R30
	STD  Y+1+1,R31
; 0000 0045     }
	SUBI R16,-1
	RJMP _0x9
_0xA:
; 0000 0046     LOAD=1;
	SBI  0x8,1
; 0000 0047     LOAD=0;
	CBI  0x8,1
; 0000 0048 }
	LDD  R16,Y+0
	RJMP _0x2080003
; .FEND
;
;void ConfiguraMax(void)
; 0000 004B {
_ConfiguraMax:
; .FSTART _ConfiguraMax
; 0000 004C     DDRC=0x07;              //Salidas en PC0,PC1,PC2
	LDI  R30,LOW(7)
	OUT  0x7,R30
; 0000 004D     MandaMax7219(0x0900);    //Mando a 0x09 un 0x00 (Decode Mode)
	LDI  R26,LOW(2304)
	LDI  R27,HIGH(2304)
	RCALL _MandaMax7219
; 0000 004E     MandaMax7219(0x0A08);    //Mando a 0x0A un 0x08 (Decode Mode)
	LDI  R26,LOW(2568)
	LDI  R27,HIGH(2568)
	RCALL _MandaMax7219
; 0000 004F     MandaMax7219(0x0B07);    //Mando a 0x0B un 0x07 (Decode Mode)
	LDI  R26,LOW(2823)
	LDI  R27,HIGH(2823)
	RCALL _MandaMax7219
; 0000 0050     MandaMax7219(0x0C01);    //Mando a 0x01 un 0x01 (Decode Mode)
	LDI  R26,LOW(3073)
	LDI  R27,HIGH(3073)
	RCALL _MandaMax7219
; 0000 0051     MandaMax7219(0x0F00);    //Mando a 0x0F un 0x00 (Decode Mode)
	LDI  R26,LOW(3840)
	LDI  R27,HIGH(3840)
	RJMP _0x2080002
; 0000 0052 }
; .FEND
;
;void MandaLetra(char letra)
; 0000 0055 {
_MandaLetra:
; .FSTART _MandaLetra
; 0000 0056     letra=letra-32;          //offset de la tabla (espacio es el primer caracter)
	ST   -Y,R26
;	letra -> Y+0
	LD   R30,Y
	SUBI R30,LOW(32)
	ST   Y,R30
; 0000 0057     MandaMax7219(0x0100);    //elimino las columnas que no ocupo
	CALL SUBOPT_0x0
; 0000 0058     MandaMax7219(0x0200);    //elimino las columnas que no ocupo
; 0000 0059     MandaMax7219(0x0800);    //elimino las columnas que no ocupo
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
	CALL SUBOPT_0x1
; 0000 005A 
; 0000 005B     //    Unimos la columna y el valor de cada renglon
; 0000 005C     MandaMax7219(0x0300|Letras[letra][4]);
	ADIW R30,4
	CALL SUBOPT_0x2
	CALL SUBOPT_0x1
; 0000 005D     MandaMax7219(0x0400|Letras[letra][3]);
	ADIW R30,3
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x400)
	MOVW R26,R30
	CALL SUBOPT_0x1
; 0000 005E     MandaMax7219(0x0500|Letras[letra][2]);
	ADIW R30,2
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x500)
	MOVW R26,R30
	CALL SUBOPT_0x1
; 0000 005F     MandaMax7219(0x0600|Letras[letra][1]);
	ADIW R30,1
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x600)
	MOVW R26,R30
	CALL SUBOPT_0x1
; 0000 0060     MandaMax7219(0x0700|Letras[letra][0]);
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x700)
	RJMP _0x2080004
; 0000 0061 }
; .FEND
;
;void Dice1(char n)
; 0000 0064 {
_Dice1:
; .FSTART _Dice1
; 0000 0065     //    Enviamos la columna y el valor de cada renglon
; 0000 0066     MandaMax7219(0x0100|Dice[n-1][7]);
	ST   -Y,R26
;	n -> Y+0
	CALL SUBOPT_0x3
	ADIW R30,7
	CALL SUBOPT_0x4
; 0000 0067     MandaMax7219(0x0200|Dice[n-1][6]);
	CALL SUBOPT_0x3
	ADIW R30,6
	CALL SUBOPT_0x5
; 0000 0068     MandaMax7219(0x0300|Dice[n-1][5]);
	CALL SUBOPT_0x3
	ADIW R30,5
	CALL SUBOPT_0x2
	CALL SUBOPT_0x6
; 0000 0069     MandaMax7219(0x0400|Dice[n-1][4]);
	ADIW R30,4
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x400)
	MOVW R26,R30
	CALL SUBOPT_0x6
; 0000 006A     MandaMax7219(0x0500|Dice[n-1][3]);
	ADIW R30,3
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x500)
	MOVW R26,R30
	CALL SUBOPT_0x6
; 0000 006B     MandaMax7219(0x0600|Dice[n-1][2]);
	CALL SUBOPT_0x7
	MOVW R26,R30
	CALL SUBOPT_0x6
; 0000 006C     MandaMax7219(0x0700|Dice[n-1][1]);
	CALL SUBOPT_0x8
	MOVW R26,R30
	CALL SUBOPT_0x6
; 0000 006D     MandaMax7219(0x0800|Dice[n-1][0]);
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x800)
_0x2080004:
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 006E }
	ADIW R28,1
	RET
; .FEND
;
;void Dice2(char n1, char n2)
; 0000 0071 {
_Dice2:
; .FSTART _Dice2
; 0000 0072     //    Enviamos la columna y el valor de cada renglon
; 0000 0073     MandaMax7219(0x0100|SmallDice[n2-1][2]);
	ST   -Y,R26
;	n1 -> Y+1
;	n2 -> Y+0
	CALL SUBOPT_0x9
	ADIW R30,2
	CALL SUBOPT_0x4
; 0000 0074     MandaMax7219(0x0200|SmallDice[n2-1][1]);
	CALL SUBOPT_0x9
	ADIW R30,1
	CALL SUBOPT_0x5
; 0000 0075     MandaMax7219(0x0300|SmallDice[n2-1][0]);
	CALL SUBOPT_0x9
	CALL SUBOPT_0x2
	CALL SUBOPT_0xA
; 0000 0076     MandaMax7219(0x0600|(SmallDice[n1-1][2]<<5));
	CALL SUBOPT_0xB
	ORI  R31,HIGH(0x600)
	MOVW R26,R30
	CALL SUBOPT_0xA
; 0000 0077     MandaMax7219(0x0700|(SmallDice[n1-1][1]<<5));
	CALL SUBOPT_0xC
	ORI  R31,HIGH(0x700)
	MOVW R26,R30
	CALL SUBOPT_0xA
; 0000 0078     MandaMax7219(0x0800|(SmallDice[n1-1][0]<<5));
	CALL SUBOPT_0xD
	ORI  R31,HIGH(0x800)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0079 }
	RJMP _0x2080001
; .FEND
;
;void Dice3(char n1, char n2, char n3)
; 0000 007C {
_Dice3:
; .FSTART _Dice3
; 0000 007D     //    Enviamos la columna y el valor de cada renglon
; 0000 007E     MandaMax7219(0x0100|SmallDice[n2-1][2]);
	ST   -Y,R26
;	n1 -> Y+2
;	n2 -> Y+1
;	n3 -> Y+0
	CALL SUBOPT_0xE
	ADIW R30,2
	CALL SUBOPT_0x4
; 0000 007F     MandaMax7219(0x0200|SmallDice[n2-1][1]);
	CALL SUBOPT_0xE
	ADIW R30,1
	CALL SUBOPT_0x5
; 0000 0080     MandaMax7219(0x0300|SmallDice[n2-1][0]);
	CALL SUBOPT_0xE
	CALL SUBOPT_0x2
	CALL SUBOPT_0xF
; 0000 0081     MandaMax7219(0x0600|SmallDice[n3-1][2]|(SmallDice[n1-1][2]<<5));
	CALL SUBOPT_0x7
	CALL SUBOPT_0x10
	CALL SUBOPT_0xB
	OR   R30,R22
	OR   R31,R23
	MOVW R26,R30
	CALL SUBOPT_0xF
; 0000 0082     MandaMax7219(0x0700|SmallDice[n3-1][1]|(SmallDice[n1-1][1]<<5));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x10
	CALL SUBOPT_0xC
	OR   R30,R22
	OR   R31,R23
	MOVW R26,R30
	CALL SUBOPT_0xF
; 0000 0083     MandaMax7219(0x0800|SmallDice[n3-1][0]|(SmallDice[n1-1][0]<<5));
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x800)
	CALL SUBOPT_0x10
	CALL SUBOPT_0xD
	CALL SUBOPT_0x11
; 0000 0084 }
_0x2080003:
	ADIW R28,3
	RET
; .FEND
;
;void Dice4(char n1, char n2, char n3, char n4)
; 0000 0087 {
_Dice4:
; .FSTART _Dice4
; 0000 0088     //    Enviamos la columna y el valor de cada renglon
; 0000 0089     MandaMax7219(0x0100|SmallDice[n2-1][2]|(SmallDice[n4-1][2]<<5));
	ST   -Y,R26
;	n1 -> Y+3
;	n2 -> Y+2
;	n3 -> Y+1
;	n4 -> Y+0
	CALL SUBOPT_0x12
	ADIW R30,2
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x100)
	MOVW R22,R30
	CALL SUBOPT_0x9
	CALL SUBOPT_0xB
	CALL SUBOPT_0x11
; 0000 008A     MandaMax7219(0x0200|SmallDice[n2-1][1]|(SmallDice[n4-1][1]<<5));
	CALL SUBOPT_0x12
	ADIW R30,1
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x200)
	MOVW R22,R30
	CALL SUBOPT_0x9
	CALL SUBOPT_0xC
	CALL SUBOPT_0x11
; 0000 008B     MandaMax7219(0x0300|SmallDice[n2-1][0]|(SmallDice[n4-1][0]<<5));
	CALL SUBOPT_0x12
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x300)
	MOVW R22,R30
	CALL SUBOPT_0x9
	CALL SUBOPT_0xD
	CALL SUBOPT_0x13
; 0000 008C     MandaMax7219(0x0600|SmallDice[n3-1][2]|(SmallDice[n1-1][2]<<5));
	CALL SUBOPT_0x7
	CALL SUBOPT_0x14
	CALL SUBOPT_0xB
	CALL SUBOPT_0x13
; 0000 008D     MandaMax7219(0x0700|SmallDice[n3-1][1]|(SmallDice[n1-1][1]<<5));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x14
	CALL SUBOPT_0xC
	CALL SUBOPT_0x13
; 0000 008E     MandaMax7219(0x0800|SmallDice[n3-1][0]|(SmallDice[n1-1][0]<<5));
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x800)
	CALL SUBOPT_0x14
	CALL SUBOPT_0xD
	CALL SUBOPT_0x11
; 0000 008F }
	ADIW R28,4
	RET
; .FEND
;
;void clear(){
; 0000 0091 void clear(){
_clear:
; .FSTART _clear
; 0000 0092     MandaMax7219(0x0100);
	CALL SUBOPT_0x0
; 0000 0093     MandaMax7219(0x0200);
; 0000 0094     MandaMax7219(0x0300);
	LDI  R26,LOW(768)
	LDI  R27,HIGH(768)
	RCALL _MandaMax7219
; 0000 0095     MandaMax7219(0x0400);
	LDI  R26,LOW(1024)
	LDI  R27,HIGH(1024)
	RCALL _MandaMax7219
; 0000 0096     MandaMax7219(0x0500);
	LDI  R26,LOW(1280)
	LDI  R27,HIGH(1280)
	RCALL _MandaMax7219
; 0000 0097     MandaMax7219(0x0600);
	LDI  R26,LOW(1536)
	LDI  R27,HIGH(1536)
	RCALL _MandaMax7219
; 0000 0098     MandaMax7219(0x0700);
	LDI  R26,LOW(1792)
	LDI  R27,HIGH(1792)
	RCALL _MandaMax7219
; 0000 0099     MandaMax7219(0x0800);
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
_0x2080002:
	RCALL _MandaMax7219
; 0000 009A }
	RET
; .FEND
;
;char str[9] = "Welcome";

	.DSEG
;char welcomeLetter=0;
;// Timer3 overflow interrupt service routine
;interrupt [TIM3_OVF] void timer3_ovf_isr(void)
; 0000 00A0 {

	.CSEG
_timer3_ovf_isr:
; .FSTART _timer3_ovf_isr
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
; 0000 00A1 // Reinitialize Timer3 value
; 0000 00A2 // Place your code here
; 0000 00A3     if(j%20==0){
	CALL SUBOPT_0x15
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CALL __MODW21U
	SBIW R30,0
	BRNE _0x1A
; 0000 00A4         MandaLetra(str[welcomeLetter]);
	LDS  R30,_welcomeLetter
	LDI  R31,0
	SUBI R30,LOW(-_str)
	SBCI R31,HIGH(-_str)
	LD   R26,Z
	RCALL _MandaLetra
; 0000 00A5         welcomeLetter++;
	LDS  R30,_welcomeLetter
	SUBI R30,-LOW(1)
	STS  _welcomeLetter,R30
; 0000 00A6     }
; 0000 00A7     j++;
_0x1A:
	CALL SUBOPT_0x16
; 0000 00A8     if(j<140){
	CALL SUBOPT_0x15
	CPI  R26,LOW(0x8C)
	LDI  R30,HIGH(0x8C)
	CPC  R27,R30
	BRSH _0x1B
; 0000 00A9         TCNT3H=0xCF2C >> 8;
	CALL SUBOPT_0x17
; 0000 00AA         TCNT3L=0xCF2C & 0xff;
; 0000 00AB     }else{
	RJMP _0x1C
_0x1B:
; 0000 00AC         clear();
	RCALL _clear
; 0000 00AD         noTono();
	RCALL _noTono
; 0000 00AE         DDRB.5=0;       //disable speaker output
	CBI  0x4,5
; 0000 00AF         TCNT3H=0;
	LDI  R30,LOW(0)
	STS  149,R30
; 0000 00B0         TCNT3L=0;
	STS  148,R30
; 0000 00B1         TIMSK3=0;
	STS  113,R30
; 0000 00B2     }
_0x1C:
; 0000 00B3 }
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
;void tirarAnimacion(){
; 0000 00B5 void tirarAnimacion(){
_tirarAnimacion:
; .FSTART _tirarAnimacion
; 0000 00B6     for (j=9;j<15;j++)
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	STS  _j,R30
	STS  _j+1,R31
_0x20:
	CALL SUBOPT_0x15
	SBIW R26,15
	BRSH _0x21
; 0000 00B7     {
; 0000 00B8         for (i=1;i<9;i++)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _i,R30
	STS  _i+1,R31
_0x23:
	CALL SUBOPT_0x18
	SBIW R26,9
	BRSH _0x24
; 0000 00B9         {
; 0000 00BA             MandaMax7219((i<<8)|Animacion[j][8-i]);
	LDS  R31,_i
	LDI  R30,LOW(0)
	MOVW R22,R30
	CALL SUBOPT_0x19
	LPM  R30,Z
	LDI  R31,0
	CALL SUBOPT_0x11
; 0000 00BB         }
	CALL SUBOPT_0x1A
	RJMP _0x23
_0x24:
; 0000 00BC         delay_ms(400);
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
; 0000 00BD     }
	CALL SUBOPT_0x16
	RJMP _0x20
_0x21:
; 0000 00BE     clear();
	RCALL _clear
; 0000 00BF }
	RET
; .FEND
;
;char mode, n1, n2, n3, n4;
;void main(void)
; 0000 00C3 {
_main:
; .FSTART _main
; 0000 00C4 PORTD=0x03;     //init buttons
	LDI  R30,LOW(3)
	OUT  0xB,R30
; 0000 00C5 
; 0000 00C6 mode=0;
	LDI  R30,LOW(0)
	STS  _mode,R30
; 0000 00C7 ConfiguraMax();
	RCALL _ConfiguraMax
; 0000 00C8 DDRC.6=1;
	SBI  0x7,6
; 0000 00C9 
; 0000 00CA TCCR0B=0x01;    //init timer
	LDI  R30,LOW(1)
	OUT  0x25,R30
; 0000 00CB DDRB.5=1;       //init speaker output
	SBI  0x4,5
; 0000 00CC //// init timer 3
; 0000 00CD TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
	LDI  R30,LOW(0)
	STS  144,R30
; 0000 00CE TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (1<<CS31) | (0<<CS30);
	LDI  R30,LOW(2)
	STS  145,R30
; 0000 00CF TCNT3H=0xCF;
	CALL SUBOPT_0x17
; 0000 00D0 TCNT3L=0x2C;
; 0000 00D1 OCR3AH=0x30;
	LDI  R30,LOW(48)
	STS  153,R30
; 0000 00D2 OCR3AL=0xD3;
	LDI  R30,LOW(211)
	STS  152,R30
; 0000 00D3 TIMSK3=0x01;
	LDI  R30,LOW(1)
	STS  113,R30
; 0000 00D4 #asm("sei")
	sei
; 0000 00D5 
; 0000 00D6 while(j<140){
_0x29:
	CALL SUBOPT_0x15
	CPI  R26,LOW(0x8C)
	LDI  R30,HIGH(0x8C)
	CPC  R27,R30
	BRSH _0x2B
; 0000 00D7     if(MarioBros[i]!=1){
	CALL SUBOPT_0x1B
	CALL __GETW2PF
	SBIW R26,1
	BREQ _0x2C
; 0000 00D8         tono(MarioBros[i]);
	CALL SUBOPT_0x1B
	CALL __GETW1PF
	CALL __CWD1
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	RCALL _tono
; 0000 00D9         delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 00DA         noTono();
	RCALL _noTono
; 0000 00DB     }else
	RJMP _0x2D
_0x2C:
; 0000 00DC         delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 00DD     i++;
_0x2D:
	CALL SUBOPT_0x1A
; 0000 00DE     if(i==591)
	CALL SUBOPT_0x18
	CPI  R26,LOW(0x24F)
	LDI  R30,HIGH(0x24F)
	CPC  R27,R30
	BRNE _0x2E
; 0000 00DF         i=0;
	LDI  R30,LOW(0)
	STS  _i,R30
	STS  _i+1,R30
; 0000 00E0 }
_0x2E:
	RJMP _0x29
_0x2B:
; 0000 00E1 j=0;
	LDI  R30,LOW(0)
	STS  _j,R30
	STS  _j+1,R30
; 0000 00E2 i=0;
	STS  _i,R30
	STS  _i+1,R30
; 0000 00E3 delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 00E4 MandaLetra('1');
	LDI  R26,LOW(49)
	CALL SUBOPT_0x1C
; 0000 00E5 delay_ms(1000);
; 0000 00E6 clear();
; 0000 00E7 while (1){
_0x2F:
; 0000 00E8     // Please write your application code here
; 0000 00E9     if(!PIND.0){ // 1 Dice
	SBIC 0x9,0
	RJMP _0x32
; 0000 00EA         clear();
	RCALL _clear
; 0000 00EB         tirarAnimacion();
	RCALL _tirarAnimacion
; 0000 00EC         for (i=9;i<15;i++)
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	STS  _i,R30
	STS  _i+1,R31
_0x34:
	CALL SUBOPT_0x18
	SBIW R26,15
	BRSH _0x35
; 0000 00ED         {
; 0000 00EE             MandaMax7219(Animacion[j][8-i]);
	CALL SUBOPT_0x19
	LPM  R26,Z
	LDI  R27,0
	RCALL _MandaMax7219
; 0000 00EF         }
	CALL SUBOPT_0x1A
	RJMP _0x34
_0x35:
; 0000 00F0         if(mode==0){
	LDS  R30,_mode
	CPI  R30,0
	BRNE _0x36
; 0000 00F1             srand(TCNT0);
	CALL SUBOPT_0x1D
; 0000 00F2             n1 = rand()%6+1;
; 0000 00F3             Dice1(n1);
	LDS  R26,_n1
	RCALL _Dice1
; 0000 00F4         }else if(mode==1){
	RJMP _0x37
_0x36:
	LDS  R26,_mode
	CPI  R26,LOW(0x1)
	BRNE _0x38
; 0000 00F5             srand(TCNT0);
	CALL SUBOPT_0x1D
; 0000 00F6             n1 = rand()%6+1;
; 0000 00F7             srand(TCNT0);
	CALL SUBOPT_0x1E
; 0000 00F8             n2 = rand()%6+1;
; 0000 00F9             Dice2(n1, n2);
	LDS  R30,_n1
	ST   -Y,R30
	LDS  R26,_n2
	RCALL _Dice2
; 0000 00FA         }else if(mode==2){
	RJMP _0x39
_0x38:
	LDS  R26,_mode
	CPI  R26,LOW(0x2)
	BRNE _0x3A
; 0000 00FB             n1 = rand()%6+1;
	CALL SUBOPT_0x1F
	STS  _n1,R30
; 0000 00FC             srand(TCNT0);
	CALL SUBOPT_0x1E
; 0000 00FD             n2 = rand()%6+1;
; 0000 00FE             srand(TCNT0);
	CALL SUBOPT_0x20
; 0000 00FF             n3 = rand()%6+1;
	STS  _n3,R30
; 0000 0100             Dice3(n1, n2, n3);
	CALL SUBOPT_0x21
	LDS  R26,_n3
	RCALL _Dice3
; 0000 0101         }else if(mode==3){
	RJMP _0x3B
_0x3A:
	LDS  R26,_mode
	CPI  R26,LOW(0x3)
	BRNE _0x3C
; 0000 0102             srand(TCNT0);
	CALL SUBOPT_0x1D
; 0000 0103             n1 = rand()%6+1;
; 0000 0104             srand(TCNT0);
	CALL SUBOPT_0x1E
; 0000 0105             n2 = rand()%6+1;
; 0000 0106             srand(TCNT0);
	CALL SUBOPT_0x20
; 0000 0107             n3 = rand()%6+1;
	STS  _n3,R30
; 0000 0108             srand(TCNT0);
	CALL SUBOPT_0x20
; 0000 0109             n4 = rand()%6+1;
	STS  _n4,R30
; 0000 010A             Dice4(n1, n2, n3, n4);
	CALL SUBOPT_0x21
	LDS  R30,_n3
	ST   -Y,R30
	LDS  R26,_n4
	RCALL _Dice4
; 0000 010B         }
; 0000 010C     }if(!PIND.1){
_0x3C:
_0x3B:
_0x39:
_0x37:
_0x32:
	SBIC 0x9,1
	RJMP _0x3D
; 0000 010D         mode++;
	LDS  R30,_mode
	SUBI R30,-LOW(1)
	STS  _mode,R30
; 0000 010E         if(mode>3)
	LDS  R26,_mode
	CPI  R26,LOW(0x4)
	BRLO _0x3E
; 0000 010F             mode=0;
	LDI  R30,LOW(0)
	STS  _mode,R30
; 0000 0110         MandaLetra(mode+49);
_0x3E:
	LDS  R26,_mode
	SUBI R26,-LOW(49)
	CALL SUBOPT_0x1C
; 0000 0111         delay_ms(1000);
; 0000 0112         clear();
; 0000 0113     }
; 0000 0114 }
_0x3D:
	RJMP _0x2F
; 0000 0115 }
_0x3F:
	RJMP _0x3F
; .FEND

	.CSEG

	.DSEG

	.CSEG
_srand:
; .FSTART _srand
	ST   -Y,R27
	ST   -Y,R26
	LD   R30,Y
	LDD  R31,Y+1
	CALL __CWD1
	CALL SUBOPT_0x22
_0x2080001:
	ADIW R28,2
	RET
; .FEND
_rand:
; .FSTART _rand
	LDS  R30,__seed_G100
	LDS  R31,__seed_G100+1
	LDS  R22,__seed_G100+2
	LDS  R23,__seed_G100+3
	__GETD2N 0x41C64E6D
	CALL __MULD12U
	__ADDD1N 30562
	CALL SUBOPT_0x22
	movw r30,r22
	andi r31,0x7F
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_i:
	.BYTE 0x2
_j:
	.BYTE 0x2
_str:
	.BYTE 0x9
_welcomeLetter:
	.BYTE 0x1
_mode:
	.BYTE 0x1
_n1:
	.BYTE 0x1
_n2:
	.BYTE 0x1
_n3:
	.BYTE 0x1
_n4:
	.BYTE 0x1
__seed_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(256)
	LDI  R27,HIGH(256)
	CALL _MandaMax7219
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x1:
	CALL _MandaMax7219
	LD   R30,Y
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_Letras*2)
	SBCI R31,HIGH(-_Letras*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x300)
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:32 WORDS
SUBOPT_0x3:
	LD   R30,Y
	LDI  R31,0
	SBIW R30,1
	CALL __LSLW3
	SUBI R30,LOW(-_Dice*2)
	SBCI R31,HIGH(-_Dice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x100)
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5:
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x200)
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	CALL _MandaMax7219
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	ADIW R30,2
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x600)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	ADIW R30,1
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x700)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x9:
	LD   R30,Y
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0xA:
	CALL _MandaMax7219
	LDD  R30,Y+1
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB:
	ADIW R30,2
	LPM  R26,Z
	LDI  R27,0
	LDI  R30,LOW(5)
	CALL __LSLW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xC:
	ADIW R30,1
	LPM  R26,Z
	LDI  R27,0
	LDI  R30,LOW(5)
	CALL __LSLW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xD:
	LPM  R26,Z
	LDI  R27,0
	LDI  R30,LOW(5)
	CALL __LSLW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xE:
	LDD  R30,Y+1
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	CALL _MandaMax7219
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x10:
	MOVW R22,R30
	LDD  R30,Y+2
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	OR   R30,R22
	OR   R31,R23
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x12:
	LDD  R30,Y+2
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	OR   R30,R22
	OR   R31,R23
	MOVW R26,R30
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x14:
	MOVW R22,R30
	LDD  R30,Y+3
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	LDS  R26,_j
	LDS  R27,_j+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x16:
	LDI  R26,LOW(_j)
	LDI  R27,HIGH(_j)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	LDI  R30,LOW(207)
	STS  149,R30
	LDI  R30,LOW(44)
	STS  148,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x18:
	LDS  R26,_i
	LDS  R27,_i+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x19:
	LDS  R30,_j
	LDS  R31,_j+1
	CALL __LSLW3
	SUBI R30,LOW(-_Animacion*2)
	SBCI R31,HIGH(-_Animacion*2)
	MOVW R0,R30
	RCALL SUBOPT_0x18
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	SUB  R30,R26
	SBC  R31,R27
	ADD  R30,R0
	ADC  R31,R1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1A:
	LDI  R26,LOW(_i)
	LDI  R27,HIGH(_i)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1B:
	LDS  R30,_i
	LDS  R31,_i+1
	LDI  R26,LOW(_MarioBros*2)
	LDI  R27,HIGH(_MarioBros*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1C:
	CALL _MandaLetra
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
	JMP  _clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x1D:
	IN   R30,0x26
	LDI  R31,0
	MOVW R26,R30
	CALL _srand
	CALL _rand
	MOVW R26,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MODW21
	SUBI R30,-LOW(1)
	STS  _n1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x1E:
	IN   R30,0x26
	LDI  R31,0
	MOVW R26,R30
	CALL _srand
	CALL _rand
	MOVW R26,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MODW21
	SUBI R30,-LOW(1)
	STS  _n2,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x1F:
	CALL _rand
	MOVW R26,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MODW21
	SUBI R30,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x20:
	IN   R30,0x26
	LDI  R31,0
	MOVW R26,R30
	CALL _srand
	RJMP SUBOPT_0x1F

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	LDS  R30,_n1
	ST   -Y,R30
	LDS  R30,_n2
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x22:
	STS  __seed_G100,R30
	STS  __seed_G100+1,R31
	STS  __seed_G100+2,R22
	STS  __seed_G100+3,R23
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

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
	CLR  R22
	CLR  R23
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

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETW2PF:
	LPM  R26,Z+
	LPM  R27,Z
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

;END OF CODE MARKER
__END_OF_CODE:
