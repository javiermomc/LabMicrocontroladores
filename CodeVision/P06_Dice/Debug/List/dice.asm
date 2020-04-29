
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : AT90USB1286
;Program type           : Application
;Clock frequency        : 8.000000 MHz
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
	JMP  0x00
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

_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
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
;
;#define DIN PORTC.0
;#define LOAD PORTC.1
;#define CLK PORTC.2
;
;void MandaMax7219 (unsigned int dato)
; 0000 0012 {

	.CSEG
_MandaMax7219:
; .FSTART _MandaMax7219
; 0000 0013     unsigned char i;        //Contador para 16b
; 0000 0014     CLK=0;                  //Valores de inicializacion
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R16
;	dato -> Y+1
;	i -> R16
	CBI  0x8,2
; 0000 0015     LOAD=0;                 //Valores de inicializacion
	CBI  0x8,1
; 0000 0016     for (i=0;i<16;i++)
	LDI  R16,LOW(0)
_0x8:
	CPI  R16,16
	BRSH _0x9
; 0000 0017     {
; 0000 0018         if ((dato&0x8000)==0)
	LDD  R30,Y+2
	ANDI R30,LOW(0x80)
	BRNE _0xA
; 0000 0019             DIN=0;
	CBI  0x8,0
; 0000 001A         else
	RJMP _0xD
_0xA:
; 0000 001B             DIN=1;
	SBI  0x8,0
; 0000 001C         CLK=1;
_0xD:
	SBI  0x8,2
; 0000 001D         CLK=0;
	CBI  0x8,2
; 0000 001E         dato=dato<<1;         //El siguiente bit pasa a ser el mas significativo
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LSL  R30
	ROL  R31
	STD  Y+1,R30
	STD  Y+1+1,R31
; 0000 001F     }
	SUBI R16,-1
	RJMP _0x8
_0x9:
; 0000 0020     LOAD=1;
	SBI  0x8,1
; 0000 0021     LOAD=0;
	CBI  0x8,1
; 0000 0022 }
	LDD  R16,Y+0
	RJMP _0x2080003
; .FEND
;
;void ConfiguraMax(void)
; 0000 0025 {
_ConfiguraMax:
; .FSTART _ConfiguraMax
; 0000 0026     DDRC=0x07;              //Salidas en PC0,PC1,PC2
	LDI  R30,LOW(7)
	OUT  0x7,R30
; 0000 0027     MandaMax7219(0x0900);    //Mando a 0x09 un 0x00 (Decode Mode)
	LDI  R26,LOW(2304)
	LDI  R27,HIGH(2304)
	RCALL _MandaMax7219
; 0000 0028     MandaMax7219(0x0A08);    //Mando a 0x0A un 0x08 (Decode Mode)
	LDI  R26,LOW(2568)
	LDI  R27,HIGH(2568)
	RCALL _MandaMax7219
; 0000 0029     MandaMax7219(0x0B07);    //Mando a 0x0B un 0x07 (Decode Mode)
	LDI  R26,LOW(2823)
	LDI  R27,HIGH(2823)
	RCALL _MandaMax7219
; 0000 002A     MandaMax7219(0x0C01);    //Mando a 0x01 un 0x01 (Decode Mode)
	LDI  R26,LOW(3073)
	LDI  R27,HIGH(3073)
	RCALL _MandaMax7219
; 0000 002B     MandaMax7219(0x0F00);    //Mando a 0x0F un 0x00 (Decode Mode)
	LDI  R26,LOW(3840)
	LDI  R27,HIGH(3840)
	RJMP _0x2080002
; 0000 002C }
; .FEND
;
;void Dice1(char n)
; 0000 002F {
_Dice1:
; .FSTART _Dice1
; 0000 0030     //    Enviamos la columna y el valor de cada renglon
; 0000 0031     MandaMax7219(0x0100|Dice[n-1][7]);
	ST   -Y,R26
;	n -> Y+0
	CALL SUBOPT_0x0
	ADIW R30,7
	CALL SUBOPT_0x1
; 0000 0032     MandaMax7219(0x0200|Dice[n-1][6]);
	CALL SUBOPT_0x0
	ADIW R30,6
	CALL SUBOPT_0x2
; 0000 0033     MandaMax7219(0x0300|Dice[n-1][5]);
	CALL SUBOPT_0x0
	ADIW R30,5
	CALL SUBOPT_0x3
; 0000 0034     MandaMax7219(0x0400|Dice[n-1][4]);
	CALL SUBOPT_0x0
	ADIW R30,4
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x400)
	CALL SUBOPT_0x4
; 0000 0035     MandaMax7219(0x0500|Dice[n-1][3]);
	ADIW R30,3
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x500)
	CALL SUBOPT_0x4
; 0000 0036     MandaMax7219(0x0600|Dice[n-1][2]);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x4
; 0000 0037     MandaMax7219(0x0700|Dice[n-1][1]);
	CALL SUBOPT_0x6
	CALL SUBOPT_0x4
; 0000 0038     MandaMax7219(0x0800|Dice[n-1][0]);
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x800)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0039 }
	ADIW R28,1
	RET
; .FEND
;
;void Dice2(char n1, char n2)
; 0000 003C {
_Dice2:
; .FSTART _Dice2
; 0000 003D     //    Enviamos la columna y el valor de cada renglon
; 0000 003E     MandaMax7219(0x0100|SmallDice[n2-1][2]);
	ST   -Y,R26
;	n1 -> Y+1
;	n2 -> Y+0
	CALL SUBOPT_0x7
	ADIW R30,2
	CALL SUBOPT_0x1
; 0000 003F     MandaMax7219(0x0200|SmallDice[n2-1][1]);
	CALL SUBOPT_0x7
	ADIW R30,1
	CALL SUBOPT_0x2
; 0000 0040     MandaMax7219(0x0300|SmallDice[n2-1][0]);
	CALL SUBOPT_0x7
	CALL SUBOPT_0x3
; 0000 0041     MandaMax7219(0x0600|(SmallDice[n1-1][2]<<5));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x9
	ORI  R31,HIGH(0x600)
	CALL SUBOPT_0xA
; 0000 0042     MandaMax7219(0x0700|(SmallDice[n1-1][1]<<5));
	CALL SUBOPT_0xB
	ORI  R31,HIGH(0x700)
	CALL SUBOPT_0xA
; 0000 0043     MandaMax7219(0x0800|(SmallDice[n1-1][0]<<5));
	CALL SUBOPT_0xC
	ORI  R31,HIGH(0x800)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0044 }
	RJMP _0x2080001
; .FEND
;
;void Dice3(char n1, char n2, char n3)
; 0000 0047 {
_Dice3:
; .FSTART _Dice3
; 0000 0048     //    Enviamos la columna y el valor de cada renglon
; 0000 0049     MandaMax7219(0x0100|SmallDice[n2-1][2]);
	ST   -Y,R26
;	n1 -> Y+2
;	n2 -> Y+1
;	n3 -> Y+0
	CALL SUBOPT_0x8
	ADIW R30,2
	CALL SUBOPT_0x1
; 0000 004A     MandaMax7219(0x0200|SmallDice[n2-1][1]);
	CALL SUBOPT_0x8
	ADIW R30,1
	CALL SUBOPT_0x2
; 0000 004B     MandaMax7219(0x0300|SmallDice[n2-1][0]);
	CALL SUBOPT_0x8
	CALL SUBOPT_0x3
; 0000 004C     MandaMax7219(0x0600|SmallDice[n3-1][2]|(SmallDice[n1-1][2]<<5));
	CALL SUBOPT_0x7
	CALL SUBOPT_0x5
	CALL SUBOPT_0xD
	CALL SUBOPT_0x9
	CALL SUBOPT_0xE
; 0000 004D     MandaMax7219(0x0700|SmallDice[n3-1][1]|(SmallDice[n1-1][1]<<5));
	CALL SUBOPT_0x6
	CALL SUBOPT_0xD
	CALL SUBOPT_0xB
	CALL SUBOPT_0xE
; 0000 004E     MandaMax7219(0x0800|SmallDice[n3-1][0]|(SmallDice[n1-1][0]<<5));
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x800)
	CALL SUBOPT_0xD
	CALL SUBOPT_0xC
	CALL SUBOPT_0xF
; 0000 004F }
_0x2080003:
	ADIW R28,3
	RET
; .FEND
;
;void Dice4(char n1, char n2, char n3, char n4)
; 0000 0052 {
_Dice4:
; .FSTART _Dice4
; 0000 0053     //    Enviamos la columna y el valor de cada renglon
; 0000 0054     MandaMax7219(0x0100|SmallDice[n2-1][2]|(SmallDice[n4-1][2]<<5));
	ST   -Y,R26
;	n1 -> Y+3
;	n2 -> Y+2
;	n3 -> Y+1
;	n4 -> Y+0
	CALL SUBOPT_0x10
	ADIW R30,2
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x100)
	MOVW R22,R30
	CALL SUBOPT_0x7
	CALL SUBOPT_0x9
	CALL SUBOPT_0xF
; 0000 0055     MandaMax7219(0x0200|SmallDice[n2-1][1]|(SmallDice[n4-1][1]<<5));
	CALL SUBOPT_0x10
	ADIW R30,1
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x200)
	MOVW R22,R30
	CALL SUBOPT_0x7
	CALL SUBOPT_0xB
	CALL SUBOPT_0xF
; 0000 0056     MandaMax7219(0x0300|SmallDice[n2-1][0]|(SmallDice[n4-1][0]<<5));
	CALL SUBOPT_0x10
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x300)
	MOVW R22,R30
	CALL SUBOPT_0x7
	CALL SUBOPT_0xC
	CALL SUBOPT_0x11
; 0000 0057     MandaMax7219(0x0600|SmallDice[n3-1][2]|(SmallDice[n1-1][2]<<5));
	CALL SUBOPT_0x5
	CALL SUBOPT_0x12
	CALL SUBOPT_0x9
	CALL SUBOPT_0x11
; 0000 0058     MandaMax7219(0x0700|SmallDice[n3-1][1]|(SmallDice[n1-1][1]<<5));
	CALL SUBOPT_0x6
	CALL SUBOPT_0x12
	CALL SUBOPT_0xB
	CALL SUBOPT_0x11
; 0000 0059     MandaMax7219(0x0800|SmallDice[n3-1][0]|(SmallDice[n1-1][0]<<5));
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x800)
	CALL SUBOPT_0x12
	CALL SUBOPT_0xC
	CALL SUBOPT_0xF
; 0000 005A }
	ADIW R28,4
	RET
; .FEND
;
;void clear(){
; 0000 005C void clear(){
_clear:
; .FSTART _clear
; 0000 005D     MandaMax7219(0x0100);
	LDI  R26,LOW(256)
	LDI  R27,HIGH(256)
	RCALL _MandaMax7219
; 0000 005E     MandaMax7219(0x0200);
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _MandaMax7219
; 0000 005F     MandaMax7219(0x0300);
	LDI  R26,LOW(768)
	LDI  R27,HIGH(768)
	RCALL _MandaMax7219
; 0000 0060     MandaMax7219(0x0400);
	LDI  R26,LOW(1024)
	LDI  R27,HIGH(1024)
	RCALL _MandaMax7219
; 0000 0061     MandaMax7219(0x0500);
	LDI  R26,LOW(1280)
	LDI  R27,HIGH(1280)
	RCALL _MandaMax7219
; 0000 0062     MandaMax7219(0x0600);
	LDI  R26,LOW(1536)
	LDI  R27,HIGH(1536)
	RCALL _MandaMax7219
; 0000 0063     MandaMax7219(0x0700);
	LDI  R26,LOW(1792)
	LDI  R27,HIGH(1792)
	RCALL _MandaMax7219
; 0000 0064     MandaMax7219(0x0800);
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
_0x2080002:
	RCALL _MandaMax7219
; 0000 0065 }
	RET
; .FEND
;
;char mode, n1, n2, n3, n4;
;void main(void)
; 0000 0069 {
_main:
; .FSTART _main
; 0000 006A PORTD=0x03;     //init buttons
	LDI  R30,LOW(3)
	OUT  0xB,R30
; 0000 006B TCCR0B=0x01;    //init timer
	LDI  R30,LOW(1)
	OUT  0x25,R30
; 0000 006C mode=0;
	LDI  R30,LOW(0)
	STS  _mode,R30
; 0000 006D ConfiguraMax();
	RCALL _ConfiguraMax
; 0000 006E clear();
	RCALL _clear
; 0000 006F while (1)
_0x18:
; 0000 0070     {
; 0000 0071     // Please write your application code here
; 0000 0072         if(!PIND.0){ // 1 Dice
	SBIC 0x9,0
	RJMP _0x1B
; 0000 0073             clear();
	RCALL _clear
; 0000 0074             if(mode==0){
	LDS  R30,_mode
	CPI  R30,0
	BRNE _0x1C
; 0000 0075                 srand(TCNT0);
	CALL SUBOPT_0x13
; 0000 0076                 n1 = rand()%6+1;
; 0000 0077                 Dice1(n1);
	LDS  R26,_n1
	RCALL _Dice1
; 0000 0078             }else if(mode==1){
	RJMP _0x1D
_0x1C:
	LDS  R26,_mode
	CPI  R26,LOW(0x1)
	BRNE _0x1E
; 0000 0079                 srand(TCNT0);
	CALL SUBOPT_0x13
; 0000 007A                 n1 = rand()%6+1;
; 0000 007B                 srand(TCNT0);
	CALL SUBOPT_0x14
; 0000 007C                 n2 = rand()%6+1;
; 0000 007D                 Dice2(n1, n2);
	LDS  R30,_n1
	ST   -Y,R30
	LDS  R26,_n2
	RCALL _Dice2
; 0000 007E             }else if(mode==2){
	RJMP _0x1F
_0x1E:
	LDS  R26,_mode
	CPI  R26,LOW(0x2)
	BRNE _0x20
; 0000 007F                 n1 = rand()%6+1;
	CALL SUBOPT_0x15
	STS  _n1,R30
; 0000 0080                 srand(TCNT0);
	CALL SUBOPT_0x14
; 0000 0081                 n2 = rand()%6+1;
; 0000 0082                 srand(TCNT0);
	CALL SUBOPT_0x16
; 0000 0083                 n3 = rand()%6+1;
	STS  _n3,R30
; 0000 0084                 Dice3(n1, n2, n3);
	CALL SUBOPT_0x17
	LDS  R26,_n3
	RCALL _Dice3
; 0000 0085             }else if(mode==3){
	RJMP _0x21
_0x20:
	LDS  R26,_mode
	CPI  R26,LOW(0x3)
	BRNE _0x22
; 0000 0086                 srand(TCNT0);
	CALL SUBOPT_0x13
; 0000 0087                 n1 = rand()%6+1;
; 0000 0088                 srand(TCNT0);
	CALL SUBOPT_0x14
; 0000 0089                 n2 = rand()%6+1;
; 0000 008A                 srand(TCNT0);
	CALL SUBOPT_0x16
; 0000 008B                 n3 = rand()%6+1;
	STS  _n3,R30
; 0000 008C                 srand(TCNT0);
	CALL SUBOPT_0x16
; 0000 008D                 n4 = rand()%6+1;
	STS  _n4,R30
; 0000 008E                 Dice4(n1, n2, n3, n4);
	CALL SUBOPT_0x17
	LDS  R30,_n3
	ST   -Y,R30
	LDS  R26,_n4
	RCALL _Dice4
; 0000 008F             }
; 0000 0090             delay_ms(100);
_0x22:
_0x21:
_0x1F:
_0x1D:
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0000 0091         }if(!PIND.1){
_0x1B:
	SBIC 0x9,1
	RJMP _0x23
; 0000 0092             mode++;
	LDS  R30,_mode
	SUBI R30,-LOW(1)
	STS  _mode,R30
; 0000 0093             if(mode>3)
	LDS  R26,_mode
	CPI  R26,LOW(0x4)
	BRLO _0x24
; 0000 0094                 mode=0;
	LDI  R30,LOW(0)
	STS  _mode,R30
; 0000 0095             delay_ms(100);
_0x24:
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0000 0096         }
; 0000 0097 
; 0000 0098     }
_0x23:
	RJMP _0x18
; 0000 0099 }
_0x25:
	RJMP _0x25
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
	CALL SUBOPT_0x18
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
	CALL SUBOPT_0x18
	movw r30,r22
	andi r31,0x7F
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG
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
;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:32 WORDS
SUBOPT_0x0:
	LD   R30,Y
	LDI  R31,0
	SBIW R30,1
	CALL __LSLW3
	SUBI R30,LOW(-_Dice*2)
	SBCI R31,HIGH(-_Dice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x100)
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2:
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x200)
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x300)
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x4:
	MOVW R26,R30
	CALL _MandaMax7219
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	ADIW R30,2
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x600)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	ADIW R30,1
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x700)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x7:
	LD   R30,Y
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x8:
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
SUBOPT_0x9:
	ADIW R30,2
	LPM  R26,Z
	LDI  R27,0
	LDI  R30,LOW(5)
	CALL __LSLW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xA:
	MOVW R26,R30
	CALL _MandaMax7219
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB:
	ADIW R30,1
	LPM  R26,Z
	LDI  R27,0
	LDI  R30,LOW(5)
	CALL __LSLW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xC:
	LPM  R26,Z
	LDI  R27,0
	LDI  R30,LOW(5)
	CALL __LSLW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xD:
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	OR   R30,R22
	OR   R31,R23
	MOVW R26,R30
	CALL _MandaMax7219
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xF:
	OR   R30,R22
	OR   R31,R23
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x10:
	LDD  R30,Y+2
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	SUBI R30,LOW(-_SmallDice*2)
	SBCI R31,HIGH(-_SmallDice*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	OR   R30,R22
	OR   R31,R23
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x12:
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x13:
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
SUBOPT_0x14:
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
SUBOPT_0x15:
	CALL _rand
	MOVW R26,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MODW21
	SUBI R30,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x16:
	IN   R30,0x26
	LDI  R31,0
	MOVW R26,R30
	CALL _srand
	RJMP SUBOPT_0x15

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	LDS  R30,_n1
	ST   -Y,R30
	LDS  R30,_n2
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x18:
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
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

;END OF CODE MARKER
__END_OF_CODE:
