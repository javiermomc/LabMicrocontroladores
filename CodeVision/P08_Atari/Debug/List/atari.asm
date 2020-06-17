
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
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
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

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

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _processing_value=R4
	.DEF _processing_confirm=R3
	.DEF _potenciometro_posicion=R6
	.DEF _potenciometro_velocidad=R5
	.DEF _i_animation=R8
	.DEF _j_animation=R7
	.DEF _i_game=R10
	.DEF _j_game=R9
	.DEF _level=R11
	.DEF _level_msb=R12
	.DEF _score=R14
	.DEF _life=R13

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

_Animacion:
	.DB  0x18,0x18,0x0,0x2,0x2,0x0,0x18,0x18
	.DB  0x8,0x10,0x8,0x2,0x2,0x8,0x10,0x8
	.DB  0x18,0x18,0x0,0x2,0x2,0x0,0x18,0x18
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
	.DB  0x0,0x7C,0x82,0x92,0x92,0x5C,0x0,0x0
	.DB  0x0,0x4,0x2A,0x2A,0x2A,0x1E,0x0,0x0
	.DB  0x0,0x3E,0x20,0x18,0x20,0x1E,0x0,0x0
	.DB  0x0,0x1C,0x2A,0x2A,0x2A,0x18,0x0,0x0
	.DB  0x0,0x7C,0x82,0x82,0x82,0x7C,0x0,0x0
	.DB  0x0,0x38,0x4,0x2,0x4,0x38,0x0,0x0
	.DB  0x0,0x1C,0x2A,0x2A,0x2A,0x18,0x0,0x0
	.DB  0x0,0x3E,0x10,0x20,0x20,0x10,0x0,0x0
	.DB  0x0,0x0,0x0,0xF2,0x0,0x0,0x0,0x0
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
_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0

_0x0:
	.DB  0x31,0x2C,0x25,0x64,0xA,0xD,0x0,0x32
	.DB  0x2C,0x25,0x64,0xA,0xD,0x0,0x33,0x2C
	.DB  0x25,0x64,0xA,0xD,0x0,0x34,0x2C,0x30
	.DB  0xA,0xD,0x0
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x03
	.DW  __REG_VARS*2

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
; * atari.c
; *
; * Created: 26-May-20 5:13:31 PM
; * Author: javie
; */
;
;#define DIN PORTC.0
;#define LOAD PORTC.1
;#define CLK PORTC.2
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
;#include <stdio.h>
;#include <delay.h>
;#include "processing.c"
;// Processing
;
;// Variables
;char processing_value;    //variable que almacena los characteres mandados de procesing
;char processing_confirm=0; //variable global para el funcionamiento del boton start
;
;//	Functions
;
;void start(){
; 0000 0010 void start(){

	.CSEG
;  if (processing_confirm==0){
;    do{
;    processing_value=getchar();
;    }while(processing_value!='H');
;  processing_confirm=1;
;  }
;}
;
;//valor entre 0 y 3, corresponden a cada sonido
;void mandar_sonido(int sonido){
_mandar_sonido:
; .FSTART _mandar_sonido
;    printf("1,%d\n\r",sonido);
	ST   -Y,R27
	ST   -Y,R26
;	sonido -> Y+0
	__POINTW1FN _0x0,0
	CALL SUBOPT_0x0
;}
	RJMP _0x20A0003
; .FEND
;
;//valor numerico puntuacion
;void mandar_puntuacion(int score){
_mandar_puntuacion:
; .FSTART _mandar_puntuacion
;    printf("2,%d\n\r",score);
	ST   -Y,R27
	ST   -Y,R26
;	score -> Y+0
	__POINTW1FN _0x0,7
	CALL SUBOPT_0x0
;}
	RJMP _0x20A0003
; .FEND
;
;//valor entre 0 y 5
;void mandar_pelotas(int life){
_mandar_pelotas:
; .FSTART _mandar_pelotas
;    printf("3,%d\n\r",life);
	ST   -Y,R27
	ST   -Y,R26
;	life -> Y+0
	__POINTW1FN _0x0,14
	CALL SUBOPT_0x0
;}
	RJMP _0x20A0003
; .FEND
;
;//finalizar partida
;void mandar_fin(){
_mandar_fin:
; .FSTART _mandar_fin
;    printf("4,0\n\r");
	__POINTW1FN _0x0,21
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;    processing_confirm=0;
	CLR  R3
;}
	RET
; .FEND
;#include "matrix.c"
;
;unsigned char columnas[8];
;unsigned char filas[8];
;unsigned short estado[8];
;unsigned char potenciometro_posicion;
;unsigned char potenciometro_velocidad;
;
;//ADC
;// Voltage Reference: Int., cap. on AREF
;#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (1<<ADLAR))
;
;// Read the 8 most significant bits
;// of the AD conversion result
;unsigned char read_adc(unsigned char adc_input)
; 0000 0011 {
_read_adc:
; .FSTART _read_adc
;ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,LOW(0xE0)
	STS  124,R30
;// Delay needed for the stabilization of the ADC input voltage
;delay_us(10);
	__DELAY_USB 7
;// Start the AD conversion
;ADCSRA|=(1<<ADSC);
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
;// Wait for the AD conversion to complete
;while ((ADCSRA & (1<<ADIF))==0);
_0x7:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x7
;ADCSRA|=(1<<ADIF);
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
;return ADCH;
	LDS  R30,121
	JMP  _0x20A0002
;}
; .FEND
;
;void IniciaColumnas()
;{
_IniciaColumnas:
; .FSTART _IniciaColumnas
;    unsigned char i;
;    for (i=0;i<8;i++)
	ST   -Y,R17
;	i -> R17
	LDI  R17,LOW(0)
_0xB:
	CPI  R17,8
	BRSH _0xC
;        columnas[i]=8-i;
	MOV  R26,R17
	LDI  R27,0
	SUBI R26,LOW(-_columnas)
	SBCI R27,HIGH(-_columnas)
	LDI  R30,LOW(8)
	SUB  R30,R17
	ST   X,R30
	SUBI R17,-1
	RJMP _0xB
_0xC:
	RJMP _0x20A0004
; .FEND
;
;void IniciaFilas()
;{
_IniciaFilas:
; .FSTART _IniciaFilas
;    unsigned char i,j=1;
;    for (i=0;i<8;i++)
	ST   -Y,R17
	ST   -Y,R16
;	i -> R17
;	j -> R16
	LDI  R16,1
	LDI  R17,LOW(0)
_0xE:
	CPI  R17,8
	BRSH _0xF
;    {
;        filas[7-i]=j;
	MOV  R30,R17
	LDI  R31,0
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	CALL SUBOPT_0x1
	SUBI R30,LOW(-_filas)
	SBCI R31,HIGH(-_filas)
	ST   Z,R16
;        j = j*2;
	LSL  R16
;    }
	SUBI R17,-1
	RJMP _0xE
_0xF:
;}
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;void IniciaEstado()
;{
_IniciaEstado:
; .FSTART _IniciaEstado
;    unsigned char i;
;    for (i=0;i<8;i++)
	ST   -Y,R17
;	i -> R17
	LDI  R17,LOW(0)
_0x11:
	CPI  R17,8
	BRSH _0x12
;        estado[i]=columnas[i]<<8 | 0x00;
	MOV  R30,R17
	CALL SUBOPT_0x2
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R17
	CALL SUBOPT_0x3
	ST   X+,R30
	ST   X,R31
	SUBI R17,-1
	RJMP _0x11
_0x12:
	RJMP _0x20A0004
; .FEND
;
;void MandaMax7219 (unsigned int dato)
;{
_MandaMax7219:
; .FSTART _MandaMax7219
;    unsigned char i;        //Contador para 16b
;    CLK=0;                  //Valores de inicializacion
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
;	dato -> Y+1
;	i -> R17
	CBI  0x8,2
;    LOAD=0;                 //Valores de inicializacion
	CBI  0x8,1
;    for (i=0;i<16;i++)
	LDI  R17,LOW(0)
_0x18:
	CPI  R17,16
	BRSH _0x19
;    {
;        if ((dato&0x8000)==0)
	LDD  R30,Y+2
	ANDI R30,LOW(0x80)
	BRNE _0x1A
;            DIN=0;
	CBI  0x8,0
;        else
	RJMP _0x1D
_0x1A:
;            DIN=1;
	SBI  0x8,0
;        CLK=1;
_0x1D:
	SBI  0x8,2
;        CLK=0;
	CBI  0x8,2
;        dato=dato<<1;         //El siguiente bit pasa a ser el mas significativo
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LSL  R30
	ROL  R31
	STD  Y+1,R30
	STD  Y+1+1,R31
;    }
	SUBI R17,-1
	RJMP _0x18
_0x19:
;    LOAD=1;
	SBI  0x8,1
;    LOAD=0;
	CBI  0x8,1
;}
	LDD  R17,Y+0
	JMP  _0x20A0001
; .FEND
;
;void ConfiguraMax(void)
;{
_ConfiguraMax:
; .FSTART _ConfiguraMax
;    DDRC=0x07;              //Salidas en PC0,PC1,PC2
	LDI  R30,LOW(7)
	OUT  0x7,R30
;    MandaMax7219(0x0900);    //Mando a 0x09 un 0x00 (Decode Mode)
	LDI  R26,LOW(2304)
	LDI  R27,HIGH(2304)
	RCALL _MandaMax7219
;    MandaMax7219(0x0A08);    //Mando a 0x0A un 0x08 (Decode Mode)
	LDI  R26,LOW(2568)
	LDI  R27,HIGH(2568)
	RCALL _MandaMax7219
;    MandaMax7219(0x0B07);    //Mando a 0x0B un 0x07 (Decode Mode)
	LDI  R26,LOW(2823)
	LDI  R27,HIGH(2823)
	RCALL _MandaMax7219
;    MandaMax7219(0x0C01);    //Mando a 0x01 un 0x01 (Decode Mode)
	LDI  R26,LOW(3073)
	LDI  R27,HIGH(3073)
	RCALL _MandaMax7219
;    MandaMax7219(0x0F00);    //Mando a 0x0F un 0x00 (Decode Mode)
	LDI  R26,LOW(3840)
	LDI  R27,HIGH(3840)
	RCALL _MandaMax7219
;}
	RET
; .FEND
;
;
;void prender_led(unsigned char x,unsigned char y)
;{
_prender_led:
; .FSTART _prender_led
;    //Actualización del estado de la matriz
;    estado[x]= columnas[x]<<8 | (estado[x] | filas[y]);
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDD  R30,Y+1
	CALL SUBOPT_0x2
	CALL SUBOPT_0x4
	MOVW R0,R30
	LDD  R30,Y+1
	CALL SUBOPT_0x2
	CALL SUBOPT_0x5
	CALL SUBOPT_0x6
	OR   R30,R0
	OR   R31,R1
	MOVW R26,R22
	ST   X+,R30
	ST   X,R31
;    //Encendido de LED
;    MandaMax7219(estado[x]);
	LDD  R30,Y+1
	CALL SUBOPT_0x2
	CALL SUBOPT_0x5
	RCALL _MandaMax7219
;}
	RJMP _0x20A0003
; .FEND
;
;void apagar_led(unsigned char x,unsigned char y)
;{
_apagar_led:
; .FSTART _apagar_led
;    //Actualización del estado de la matriz
;    if ((estado[x] & (columnas[x]<<8 | filas[y])) != (columnas[x]<<8 | 0x00))
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDD  R30,Y+1
	CALL SUBOPT_0x2
	ADD  R26,R30
	ADC  R27,R31
	LD   R0,X+
	LD   R1,X
	LDD  R30,Y+1
	CALL SUBOPT_0x3
	MOVW R26,R30
	CALL SUBOPT_0x6
	AND  R30,R0
	AND  R31,R1
	MOVW R26,R30
	LDD  R30,Y+1
	CALL SUBOPT_0x3
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x28
;        estado[x]= columnas[x]<<8 | (estado[x] ^ filas[y]);
	LDD  R30,Y+1
	CALL SUBOPT_0x2
	CALL SUBOPT_0x4
	MOVW R0,R30
	LDD  R30,Y+1
	CALL SUBOPT_0x2
	CALL SUBOPT_0x5
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-_filas)
	SBCI R31,HIGH(-_filas)
	LD   R30,Z
	LDI  R31,0
	EOR  R30,R26
	EOR  R31,R27
	OR   R30,R0
	OR   R31,R1
	MOVW R26,R22
	ST   X+,R30
	ST   X,R31
;
;    //Apagado de LED
;    MandaMax7219(estado[x]);
_0x28:
	LDD  R30,Y+1
	CALL SUBOPT_0x2
	CALL SUBOPT_0x5
	RCALL _MandaMax7219
;}
	RJMP _0x20A0003
; .FEND
;
;void updateADC()
;{
_updateADC:
; .FSTART _updateADC
;    potenciometro_posicion = read_adc(7);
	LDI  R26,LOW(7)
	RCALL _read_adc
	MOV  R6,R30
;	potenciometro_velocidad = read_adc(6);
	LDI  R26,LOW(6)
	RCALL _read_adc
	MOV  R5,R30
;}
	RET
; .FEND
;#include "animacion.h"
_startAnimation:
; .FSTART _startAnimation
	CLR  R7
_0x2A:
	LDI  R30,LOW(10)
	CP   R7,R30
	BRSH _0x2B
	LDI  R30,LOW(1)
	MOV  R8,R30
_0x2D:
	LDI  R30,LOW(9)
	CP   R8,R30
	BRSH _0x2E
	CALL SUBOPT_0x7
	CALL SUBOPT_0x8
	INC  R8
	RJMP _0x2D
_0x2E:
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
	INC  R7
	RJMP _0x2A
_0x2B:
	RET
; .FEND
_endAnimation:
; .FSTART _endAnimation
	LDI  R30,LOW(10)
	MOV  R7,R30
_0x30:
	LDI  R30,LOW(24)
	CP   R7,R30
	BRSH _0x31
	LDI  R30,LOW(1)
	MOV  R8,R30
_0x33:
	LDI  R30,LOW(9)
	CP   R8,R30
	BRSH _0x34
	CALL SUBOPT_0x7
	CALL SUBOPT_0x8
	INC  R8
	RJMP _0x33
_0x34:
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
	INC  R7
	RJMP _0x30
_0x31:
	RET
; .FEND
;#include "game.c"
;
;signed char i_game, j_game;
;unsigned int level;
;signed char score, life, start_game;
;signed char next_x, next_y, is_collision_bar, is_collision_wall;
;
;signed char left_wall, right_wall, bottom_wall;
;void init_wall(signed char left, signed char right, signed char bottom){
; 0000 0013 void init_wall(signed char left, signed char right, signed char bottom){
_init_wall:
; .FSTART _init_wall
;    left_wall = left;
	ST   -Y,R26
;	left -> Y+2
;	right -> Y+1
;	bottom -> Y+0
	LDD  R30,Y+2
	STS  _left_wall,R30
;    right_wall = right;
	LDD  R30,Y+1
	STS  _right_wall,R30
;    bottom_wall = bottom;
	LD   R30,Y
	STS  _bottom_wall,R30
;}
	JMP  _0x20A0001
; .FEND
;
;signed char collision_wall(signed char x, signed char y){
_collision_wall:
; .FSTART _collision_wall
;    if(x<=left_wall){
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDS  R30,_left_wall
	LDD  R26,Y+1
	CP   R30,R26
	BRLT _0x35
;        mandar_sonido(1);
	CALL SUBOPT_0x9
;        return 1;
	LDI  R30,LOW(1)
	RJMP _0x20A0003
;    }
;    if(x>=right_wall){
_0x35:
	LDS  R30,_right_wall
	LDD  R26,Y+1
	CP   R26,R30
	BRLT _0x36
;        mandar_sonido(1);
	CALL SUBOPT_0x9
;        return 2;
	LDI  R30,LOW(2)
	RJMP _0x20A0003
;    }
;    if(y<=-1){
_0x36:
	LD   R26,Y
	LDI  R30,LOW(255)
	CP   R30,R26
	BRLT _0x37
;        mandar_sonido(1);
	CALL SUBOPT_0x9
;        return 3;
	LDI  R30,LOW(3)
	RJMP _0x20A0003
;    }
;    if(y>=bottom_wall){
_0x37:
	LDS  R30,_bottom_wall
	LD   R26,Y
	CP   R26,R30
	BRLT _0x38
;        return 4;
	LDI  R30,LOW(4)
	RJMP _0x20A0003
;    }
;    return 0;
_0x38:
	LDI  R30,LOW(0)
	RJMP _0x20A0003
;}
; .FEND
;
;signed char matrix_game[8][8];
;
;void init_matrix(){
_init_matrix:
; .FSTART _init_matrix
;    char value = 30;
;    is_collision_wall=0;
	ST   -Y,R17
;	value -> R17
	LDI  R17,30
	LDI  R30,LOW(0)
	STS  _is_collision_wall,R30
;    for(i_game=0; i_game<3; i_game++){
	CLR  R10
_0x3A:
	LDI  R30,LOW(3)
	CP   R10,R30
	BRGE _0x3B
;        for(j_game=0; j_game<8; j_game++){
	CLR  R9
_0x3D:
	LDI  R30,LOW(8)
	CP   R9,R30
	BRGE _0x3E
;            matrix_game[j_game][i_game] = value;
	CALL SUBOPT_0xA
	MOV  R30,R10
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R17
;            prender_led(j_game, i_game);
	ST   -Y,R9
	MOV  R26,R10
	RCALL _prender_led
;        }
	INC  R9
	RJMP _0x3D
_0x3E:
;        value -= 10;
	SUBI R17,LOW(10)
;    }
	INC  R10
	RJMP _0x3A
_0x3B:
;}
_0x20A0004:
	LD   R17,Y+
	RET
; .FEND
;
;signed char value_empty;
;signed char empty_matrix(){
_empty_matrix:
; .FSTART _empty_matrix
;    value_empty = 0;
	LDI  R30,LOW(0)
	STS  _value_empty,R30
;    for(i_game=0; i_game<3; i_game++){
	CLR  R10
_0x40:
	LDI  R30,LOW(3)
	CP   R10,R30
	BRGE _0x41
;        for(j_game=0; j_game<8; j_game++){
	CLR  R9
_0x43:
	LDI  R30,LOW(8)
	CP   R9,R30
	BRGE _0x44
;            if(matrix_game[j_game][i_game]>0)
	CALL SUBOPT_0xA
	CLR  R30
	ADD  R26,R10
	ADC  R27,R30
	LD   R26,X
	CPI  R26,LOW(0x1)
	BRLT _0x45
;              value_empty += 1;
	LDS  R30,_value_empty
	SUBI R30,-LOW(1)
	STS  _value_empty,R30
;        }
_0x45:
	INC  R9
	RJMP _0x43
_0x44:
;    }
	INC  R10
	RJMP _0x40
_0x41:
;    return value_empty;
	LDS  R30,_value_empty
	RET
;}
; .FEND
;
;signed char collision_matrix(signed char x, signed char y){
_collision_matrix:
; .FSTART _collision_matrix
;    if(x<0 || y<0 || x>7 || y>7)
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDD  R26,Y+1
	CPI  R26,0
	BRLT _0x47
	LD   R26,Y
	CPI  R26,0
	BRLT _0x47
	LDD  R26,Y+1
	CPI  R26,LOW(0x8)
	BRGE _0x47
	LD   R26,Y
	CPI  R26,LOW(0x8)
	BRLT _0x46
_0x47:
;        return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0003
;    if(matrix_game[x][y]!=0){
_0x46:
	CALL SUBOPT_0xB
	CPI  R30,0
	BREQ _0x49
;        mandar_sonido(2);
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _mandar_sonido
;        return matrix_game[x][y];
	CALL SUBOPT_0xB
	RJMP _0x20A0003
;    }
;    return 0;
_0x49:
	LDI  R30,LOW(0)
	RJMP _0x20A0003
;}
; .FEND
;
;signed char bar_position_x, bar_position_y, bar_size;
;
;void init_bar(signed char x, signed char y, signed char size){
_init_bar:
; .FSTART _init_bar
;    is_collision_bar=0;
	ST   -Y,R26
;	x -> Y+2
;	y -> Y+1
;	size -> Y+0
	LDI  R30,LOW(0)
	STS  _is_collision_bar,R30
;    bar_size = size;
	LD   R30,Y
	STS  _bar_size,R30
;    bar_position_x = x;
	LDD  R30,Y+2
	STS  _bar_position_x,R30
;    bar_position_y = y;
	LDD  R30,Y+1
	STS  _bar_position_y,R30
;    for(i_game=x; i_game<(size+x); i_game++){
	LDD  R10,Y+2
_0x4B:
	LD   R26,Y
	LDI  R27,0
	SBRC R26,7
	SER  R27
	LDD  R30,Y+2
	CALL SUBOPT_0xC
	BRGE _0x4C
;        prender_led(i_game, y);
	ST   -Y,R10
	LDD  R26,Y+2
	RCALL _prender_led
;    }
	INC  R10
	RJMP _0x4B
_0x4C:
;}
	JMP  _0x20A0001
; .FEND
;
;signed char collision_bar(signed char x, signed char y){
_collision_bar:
; .FSTART _collision_bar
;    if(x>=bar_position_x && x<=bar_position_x+bar_size-1 && y == bar_position_y){
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDS  R30,_bar_position_x
	LDD  R26,Y+1
	CP   R26,R30
	BRLT _0x4E
	CALL SUBOPT_0xD
	LDI  R31,0
	SBRC R30,7
	SER  R31
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL SUBOPT_0x1
	LDD  R26,Y+1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x4E
	LDS  R30,_bar_position_y
	LD   R26,Y
	CP   R30,R26
	BREQ _0x4F
_0x4E:
	RJMP _0x4D
_0x4F:
;        mandar_sonido(0);
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _mandar_sonido
;        return x-bar_position_x+1;
	LDS  R26,_bar_position_x
	LDD  R30,Y+1
	SUB  R30,R26
	SUBI R30,-LOW(1)
	RJMP _0x20A0003
;    }
;    return 0;
_0x4D:
	LDI  R30,LOW(0)
	RJMP _0x20A0003
;}
; .FEND
;
;void move_bar(signed char x, signed char y){
_move_bar:
; .FSTART _move_bar
;    bar_position_x = x;
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDD  R30,Y+1
	STS  _bar_position_x,R30
;    bar_position_y = y;
	LD   R30,Y
	STS  _bar_position_y,R30
;
;    for(i_game=0; i_game<8; i_game++){
	CLR  R10
_0x51:
	LDI  R30,LOW(8)
	CP   R10,R30
	BRGE _0x52
;        if(i_game>=bar_position_x&&i_game<bar_position_x+bar_size)
	LDS  R30,_bar_position_x
	CP   R10,R30
	BRLT _0x54
	CALL SUBOPT_0xD
	CALL SUBOPT_0xC
	BRLT _0x55
_0x54:
	RJMP _0x53
_0x55:
;            prender_led(i_game, y);
	ST   -Y,R10
	LDD  R26,Y+1
	RCALL _prender_led
;        else
	RJMP _0x56
_0x53:
;            apagar_led(i_game, y);
	ST   -Y,R10
	LDD  R26,Y+1
	RCALL _apagar_led
;    }
_0x56:
	INC  R10
	RJMP _0x51
_0x52:
;}
	RJMP _0x20A0003
; .FEND
;
;signed char ball_position_x, ball_position_y, ball_velocity_x, ball_velocity_y, init_velocity_x, init_velocity_y;
;
;void init_ball(signed char x, signed char y, signed char velocity_x, signed char velocity_y){
_init_ball:
; .FSTART _init_ball
;    ball_position_x = x;
	ST   -Y,R26
;	x -> Y+3
;	y -> Y+2
;	velocity_x -> Y+1
;	velocity_y -> Y+0
	LDD  R30,Y+3
	STS  _ball_position_x,R30
;    ball_position_y = y;
	LDD  R30,Y+2
	STS  _ball_position_y,R30
;    ball_velocity_x = velocity_x;
	CALL SUBOPT_0xE
;    ball_velocity_y = velocity_y;
;    init_velocity_x = velocity_x;
	LDD  R30,Y+1
	STS  _init_velocity_x,R30
;    init_velocity_y = velocity_y;
	LD   R30,Y
	STS  _init_velocity_y,R30
;
;    prender_led(x, y);
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R26,Y+3
	RCALL _prender_led
;}
	ADIW R28,4
	RET
; .FEND
;
;void setVelocity_ball(signed char velocity_x, signed char velocity_y){
_setVelocity_ball:
; .FSTART _setVelocity_ball
;    ball_velocity_x = velocity_x;
	ST   -Y,R26
;	velocity_x -> Y+1
;	velocity_y -> Y+0
	CALL SUBOPT_0xE
;    ball_velocity_y = velocity_y;
;}
	RJMP _0x20A0003
; .FEND
;
;void move_ball(signed char x, signed char y){
_move_ball:
; .FSTART _move_ball
;    apagar_led(ball_position_x, ball_position_y);
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDS  R30,_ball_position_x
	ST   -Y,R30
	LDS  R26,_ball_position_y
	RCALL _apagar_led
;    ball_position_x = x;
	LDD  R30,Y+1
	STS  _ball_position_x,R30
;    ball_position_y = y;
	LD   R30,Y
	STS  _ball_position_y,R30
;    prender_led(x, y);
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R26,Y+1
	RCALL _prender_led
;}
	RJMP _0x20A0003
; .FEND
;
;void setup_game(){
_setup_game:
; .FSTART _setup_game
;    init_wall(-1, 8, 8);
	LDI  R30,LOW(255)
	ST   -Y,R30
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R26,LOW(8)
	RCALL _init_wall
;    init_matrix();
	RCALL _init_matrix
;    init_bar(3,7,3);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(3)
	RCALL _init_bar
;    init_ball(4,6,1,-1);
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(255)
	RCALL _init_ball
;    life = 5;
	LDI  R30,LOW(5)
	MOV  R13,R30
;    mandar_pelotas(life);
	CALL SUBOPT_0xF
;    level = 0;
	CLR  R11
	CLR  R12
;}
	RET
; .FEND
;
;void play_game(){
_play_game:
; .FSTART _play_game
;
;    if(start_game==0){
	LDS  R30,_start_game
	CPI  R30,0
	BRNE _0x57
;        start_game=1;
	LDI  R30,LOW(1)
	STS  _start_game,R30
;        startAnimation();
	RCALL _startAnimation
;        setup_game();
	RCALL _setup_game
;    }
;
;    move_bar(potenciometro_posicion*1.4/51, bar_position_y);
_0x57:
	MOV  R30,R6
	LDI  R31,0
	CALL __CWD1
	CALL __CDF1
	__GETD2N 0x3FB33333
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x424C0000
	CALL __DIVF21
	CALL __CFD1
	ST   -Y,R30
	LDS  R26,_bar_position_y
	RCALL _move_bar
;    next_x = ball_position_x+ball_velocity_x;
	CALL SUBOPT_0x10
;    next_y = ball_position_y+ball_velocity_y;
;    is_collision_bar = 1;
	LDI  R30,LOW(1)
	STS  _is_collision_bar,R30
;    is_collision_wall = 1;
	STS  _is_collision_wall,R30
;    while(is_collision_bar != 0 || is_collision_wall != 0){
_0x58:
	LDS  R26,_is_collision_bar
	CPI  R26,LOW(0x0)
	BRNE _0x5B
	LDS  R26,_is_collision_wall
	CPI  R26,LOW(0x0)
	BRNE _0x5B
	RJMP _0x5A
_0x5B:
;        next_x = ball_position_x+ball_velocity_x;
	CALL SUBOPT_0x10
;        next_y = ball_position_y+ball_velocity_y;
;        is_collision_bar = collision_bar(ball_position_x, next_y);
	CALL SUBOPT_0x11
	CALL SUBOPT_0x12
;        switch(is_collision_bar){
;            case 0:
	BREQ _0x5F
;                break;
;            case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ _0x85
;                setVelocity_ball(ball_velocity_x, -ball_velocity_y);
;                break;
;            case 2:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x62
;                srand(TCNT0);
	CALL SUBOPT_0x13
;                setVelocity_ball(init_velocity_x*rand()%2-1, -ball_velocity_y);
	PUSH R31
	PUSH R30
	CALL _rand
	POP  R26
	POP  R27
	CALL SUBOPT_0x14
	RJMP _0x86
;                break;
;            case 3:
_0x62:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x5F
;                setVelocity_ball(ball_velocity_x, -ball_velocity_y);
_0x85:
	LDS  R30,_ball_velocity_x
_0x86:
	ST   -Y,R30
	CALL SUBOPT_0x15
;                break;
;        }
_0x5F:
;        next_x = ball_position_x+ball_velocity_x;
	CALL SUBOPT_0x10
;        next_y = ball_position_y+ball_velocity_y;
;        is_collision_bar = collision_bar(next_x, next_y);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x12
;        switch(is_collision_bar){
;            case 0:
	BREQ _0x66
;                break;
;            case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ _0x87
;                setVelocity_ball(-ball_velocity_x, -ball_velocity_y);
;                break;
;            case 2:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x69
;                srand(TCNT0);
	CALL SUBOPT_0x13
;                setVelocity_ball(init_velocity_x*rand()%2-1, -ball_velocity_y);
	PUSH R31
	PUSH R30
	CALL _rand
	POP  R26
	POP  R27
	CALL SUBOPT_0x14
	RJMP _0x88
;                break;
;            case 3:
_0x69:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x66
;                setVelocity_ball(-ball_velocity_x, -ball_velocity_y);
_0x87:
	LDS  R30,_ball_velocity_x
	NEG  R30
_0x88:
	ST   -Y,R30
	CALL SUBOPT_0x15
;                break;
;        }
_0x66:
;        next_x = ball_position_x+ball_velocity_x;
	CALL SUBOPT_0x10
;        next_y = ball_position_y+ball_velocity_y;
;        is_collision_wall = collision_wall(next_x, next_y);
	CALL SUBOPT_0x16
	RCALL _collision_wall
	STS  _is_collision_wall,R30
;        switch(is_collision_wall){
	LDI  R31,0
	SBRC R30,7
	SER  R31
;            case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x6E
;                setVelocity_ball(-ball_velocity_x, ball_velocity_y);
	CALL SUBOPT_0x17
;                break;
	RJMP _0x6D
;            case 2:
_0x6E:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x6F
;                setVelocity_ball(-ball_velocity_x, ball_velocity_y);
	CALL SUBOPT_0x17
;                break;
	RJMP _0x6D
;            case 3:
_0x6F:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x70
;                setVelocity_ball(ball_velocity_x, -ball_velocity_y);
	LDS  R30,_ball_velocity_x
	ST   -Y,R30
	CALL SUBOPT_0x15
;                break;
	RJMP _0x6D
;            case 4:
_0x70:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x6D
;                life -= 1;
	DEC  R13
;                if(life>0){
	LDI  R30,LOW(0)
	CP   R30,R13
	BRGE _0x72
;                    move_ball(5, 4);
	CALL SUBOPT_0x18
;                    ball_velocity_y = -ball_velocity_y;
;                    ball_velocity_y = init_velocity_y;
;                    ball_velocity_x = init_velocity_x;
;                    mandar_pelotas(life);
	CALL SUBOPT_0xF
;                }else{
	RJMP _0x73
_0x72:
;                    mandar_sonido(3);
	LDI  R26,LOW(3)
	LDI  R27,0
	RCALL _mandar_sonido
;                    mandar_fin();
	RCALL _mandar_fin
;                    is_collision_bar=0;
	LDI  R30,LOW(0)
	STS  _is_collision_bar,R30
;                    is_collision_wall=0;
	STS  _is_collision_wall,R30
;					endAnimation();
	RCALL _endAnimation
;					start_game=0;
	LDI  R30,LOW(0)
	STS  _start_game,R30
;                }
_0x73:
;                break;
;        }
_0x6D:
;        score = collision_matrix(next_x, ball_position_y);
	LDS  R30,_next_x
	ST   -Y,R30
	LDS  R26,_ball_position_y
	CALL SUBOPT_0x19
;        if(score != 0){
	BREQ _0x74
;            setVelocity_ball(-ball_velocity_x, ball_velocity_y);
	CALL SUBOPT_0x17
;            matrix_game[next_x][ball_position_y] = 0;
	CALL SUBOPT_0x1A
	MOVW R26,R30
	LDS  R30,_ball_position_y
	CALL SUBOPT_0x1B
;            apagar_led(next_x, ball_position_y);
	LDS  R30,_next_x
	ST   -Y,R30
	LDS  R26,_ball_position_y
	CALL SUBOPT_0x1C
;            mandar_puntuacion(score);
;        }
;        next_x = ball_position_x+ball_velocity_x;
_0x74:
	CALL SUBOPT_0x10
;        next_y = ball_position_y+ball_velocity_y;
;        score = collision_matrix(ball_position_x, next_y);
	CALL SUBOPT_0x11
	CALL SUBOPT_0x19
;        if(score != 0){
	BREQ _0x75
;            setVelocity_ball(ball_velocity_x, -ball_velocity_y);
	LDS  R30,_ball_velocity_x
	ST   -Y,R30
	CALL SUBOPT_0x15
;            matrix_game[ball_position_x][next_y] = 0;
	LDS  R30,_ball_position_x
	LDI  R31,0
	CALL __LSLW3
	SUBI R30,LOW(-_matrix_game)
	SBCI R31,HIGH(-_matrix_game)
	MOVW R26,R30
	LDS  R30,_next_y
	CALL SUBOPT_0x1B
;            apagar_led(ball_position_x, next_y);
	CALL SUBOPT_0x11
	CALL SUBOPT_0x1C
;            mandar_puntuacion(score);
;        }
;
;        if(score == 0){
_0x75:
	TST  R14
	BRNE _0x76
;            score = collision_matrix(next_x, next_y);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x19
;            if(score!=0){
	BREQ _0x77
;                setVelocity_ball(-ball_velocity_x, -ball_velocity_y);
	LDS  R30,_ball_velocity_x
	NEG  R30
	ST   -Y,R30
	CALL SUBOPT_0x15
;                matrix_game[next_x][next_y] = 0;
	CALL SUBOPT_0x1A
	MOVW R26,R30
	LDS  R30,_next_y
	CALL SUBOPT_0x1B
;                apagar_led(next_x, next_y);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x1C
;                mandar_puntuacion(score);
;                score = 0;
	CLR  R14
;            }
;        }
_0x77:
;        next_x = ball_position_x+ball_velocity_x;
_0x76:
	CALL SUBOPT_0x10
;        next_y = ball_position_y+ball_velocity_y;
;        if(start_game==0){
	LDS  R30,_start_game
	CPI  R30,0
	BRNE _0x78
;            is_collision_bar = 0;
	LDI  R30,LOW(0)
	STS  _is_collision_bar,R30
;            is_collision_wall = 0;
	RJMP _0x89
;        }else{
_0x78:
;            is_collision_bar = collision_bar(next_x, next_y);
	CALL SUBOPT_0x16
	RCALL _collision_bar
	STS  _is_collision_bar,R30
;            is_collision_wall = collision_wall(next_x, next_y);
	CALL SUBOPT_0x16
	RCALL _collision_wall
_0x89:
	STS  _is_collision_wall,R30
;        }
;    }
	RJMP _0x58
_0x5A:
;    if(ball_velocity_x>1)
	LDS  R26,_ball_velocity_x
	CPI  R26,LOW(0x2)
	BRLT _0x7A
;      ball_velocity_x = 1;
	LDI  R30,LOW(1)
	STS  _ball_velocity_x,R30
;    if(ball_velocity_x<-1)
_0x7A:
	LDS  R26,_ball_velocity_x
	CPI  R26,LOW(0xFF)
	BRGE _0x7B
;      ball_velocity_x = -1;
	LDI  R30,LOW(255)
	STS  _ball_velocity_x,R30
;    if(ball_velocity_y>1)
_0x7B:
	LDS  R26,_ball_velocity_y
	CPI  R26,LOW(0x2)
	BRLT _0x7C
;      ball_velocity_y = 1;
	LDI  R30,LOW(1)
	STS  _ball_velocity_y,R30
;    if(ball_velocity_y<-1)
_0x7C:
	LDS  R26,_ball_velocity_y
	CPI  R26,LOW(0xFF)
	BRGE _0x7D
;      ball_velocity_y = -1;
	LDI  R30,LOW(255)
	STS  _ball_velocity_y,R30
;    if(start_game!=0)
_0x7D:
	LDS  R30,_start_game
	CPI  R30,0
	BREQ _0x7E
;        move_ball(ball_position_x+ball_velocity_x, ball_position_y+ball_velocity_y);
	LDS  R30,_ball_velocity_x
	LDS  R26,_ball_position_x
	ADD  R30,R26
	ST   -Y,R30
	LDS  R30,_ball_velocity_y
	LDS  R26,_ball_position_y
	ADD  R26,R30
	RCALL _move_ball
;    if(empty_matrix()==0){
_0x7E:
	RCALL _empty_matrix
	CPI  R30,0
	BRNE _0x7F
;      move_ball(5, 4);
	CALL SUBOPT_0x18
;      ball_velocity_y = -ball_velocity_y;
;      ball_velocity_y = init_velocity_y;
;      ball_velocity_x = init_velocity_x;
;      init_matrix();
	RCALL _init_matrix
;      level += 200;
	__GETW1R 11,12
	SUBI R30,LOW(-200)
	SBCI R31,HIGH(-200)
	__PUTW1R 11,12
;    }
;    if((unsigned int)(((unsigned int)potenciometro_velocidad)*4-level)>0)
_0x7F:
	CALL SUBOPT_0x1D
	CALL __CPW01
	BRSH _0x80
;        delay_ms((unsigned int)(((unsigned int)potenciometro_velocidad)*4-level));
	CALL SUBOPT_0x1D
	MOVW R26,R30
	CALL _delay_ms
;}
_0x80:
	RET
; .FEND
;
;
;
;void main(void)
; 0000 0018 {
_main:
; .FSTART _main
; 0000 0019 
; 0000 001A // USART1 initialization
; 0000 001B // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 001C // USART1 Receiver: On
; 0000 001D // USART1 Transmitter: On
; 0000 001E // USART1 Mode: Asynchronous
; 0000 001F // USART1 Baud Rate: 9600
; 0000 0020 UCSR1A=(0<<RXC1) | (0<<TXC1) | (0<<UDRE1) | (0<<FE1) | (0<<DOR1) | (0<<UPE1) | (0<<U2X1) | (0<<MPCM1);
	LDI  R30,LOW(0)
	STS  200,R30
; 0000 0021 UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (1<<RXEN1) | (1<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	LDI  R30,LOW(24)
	STS  201,R30
; 0000 0022 UCSR1C=(0<<UMSEL11) | (0<<UMSEL10) | (0<<UPM11) | (0<<UPM10) | (0<<USBS1) | (1<<UCSZ11) | (1<<UCSZ10) | (0<<UCPOL1);
	LDI  R30,LOW(6)
	STS  202,R30
; 0000 0023 UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  205,R30
; 0000 0024 UBRR1L=0x0C;
	LDI  R30,LOW(12)
	STS  204,R30
; 0000 0025 
; 0000 0026 // ADC initialization
; 0000 0027 // ADC Clock frequency: 125.000 kHz
; 0000 0028 // ADC Voltage Reference: Int., cap. on AREF
; 0000 0029 // ADC High Speed Mode: Off
; 0000 002A // Only the 8 most significant bits of
; 0000 002B // the AD conversion result are used
; 0000 002C // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
; 0000 002D // ADC4: On, ADC5: On, ADC6: Off, ADC7: Off
; 0000 002E DIDR0=(1<<ADC7D) | (1<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
	LDI  R30,LOW(192)
	STS  126,R30
; 0000 002F ADMUX=ADC_VREF_TYPE;
	LDI  R30,LOW(224)
	STS  124,R30
; 0000 0030 ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	LDI  R30,LOW(132)
	STS  122,R30
; 0000 0031 ADCSRB=(1<<ADHSM);
	LDI  R30,LOW(128)
	STS  123,R30
; 0000 0032 
; 0000 0033 
; 0000 0034 PORTD=0x07;     //seteo de botones
	LDI  R30,LOW(7)
	OUT  0xB,R30
; 0000 0035 
; 0000 0036 
; 0000 0037 ConfiguraMax();
	RCALL _ConfiguraMax
; 0000 0038 IniciaColumnas();
	RCALL _IniciaColumnas
; 0000 0039 IniciaFilas();
	RCALL _IniciaFilas
; 0000 003A IniciaEstado();
	RCALL _IniciaEstado
; 0000 003B 
; 0000 003C prender_led(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _prender_led
; 0000 003D prender_led(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _prender_led
; 0000 003E 
; 0000 003F prender_led(1,0);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _prender_led
; 0000 0040 prender_led(1,1);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _prender_led
; 0000 0041 
; 0000 0042 delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 0043 
; 0000 0044 apagar_led(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _apagar_led
; 0000 0045 apagar_led(1,1);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _apagar_led
; 0000 0046 
; 0000 0047 
; 0000 0048 while (1)
_0x81:
; 0000 0049     {
; 0000 004A         //start();
; 0000 004B         updateADC();
	RCALL _updateADC
; 0000 004C         play_game();
	RCALL _play_game
; 0000 004D 
; 0000 004E     }
	RJMP _0x81
; 0000 004F }
_0x84:
	RJMP _0x84
; .FEND
;
;//Dejar start en comentarios para ejecutar el juego sin necesidad de conectar el micro a processing

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
	CALL SUBOPT_0x1E
_0x20A0003:
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
	CALL SUBOPT_0x1E
	movw r30,r22
	andi r31,0x7F
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

	.CSEG
_putchar:
; .FSTART _putchar
	ST   -Y,R26
_0x2020006:
	LDS  R30,200
	ANDI R30,LOW(0x20)
	BREQ _0x2020006
	LD   R30,Y
	STS  206,R30
_0x20A0002:
	ADIW R28,1
	RET
; .FEND
_put_usart_G101:
; .FSTART _put_usart_G101
	ST   -Y,R27
	ST   -Y,R26
	LDD  R26,Y+2
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x20A0001:
	ADIW R28,3
	RET
; .FEND
__print_G101:
; .FSTART __print_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x202001C:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x202001E
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x2020022
	CPI  R18,37
	BRNE _0x2020023
	LDI  R17,LOW(1)
	RJMP _0x2020024
_0x2020023:
	CALL SUBOPT_0x1F
_0x2020024:
	RJMP _0x2020021
_0x2020022:
	CPI  R30,LOW(0x1)
	BRNE _0x2020025
	CPI  R18,37
	BRNE _0x2020026
	CALL SUBOPT_0x1F
	RJMP _0x20200D2
_0x2020026:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020027
	LDI  R16,LOW(1)
	RJMP _0x2020021
_0x2020027:
	CPI  R18,43
	BRNE _0x2020028
	LDI  R20,LOW(43)
	RJMP _0x2020021
_0x2020028:
	CPI  R18,32
	BRNE _0x2020029
	LDI  R20,LOW(32)
	RJMP _0x2020021
_0x2020029:
	RJMP _0x202002A
_0x2020025:
	CPI  R30,LOW(0x2)
	BRNE _0x202002B
_0x202002A:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x202002C
	ORI  R16,LOW(128)
	RJMP _0x2020021
_0x202002C:
	RJMP _0x202002D
_0x202002B:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x2020021
_0x202002D:
	CPI  R18,48
	BRLO _0x2020030
	CPI  R18,58
	BRLO _0x2020031
_0x2020030:
	RJMP _0x202002F
_0x2020031:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x2020021
_0x202002F:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2020035
	CALL SUBOPT_0x20
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x21
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x73)
	BRNE _0x2020038
	CALL SUBOPT_0x20
	CALL SUBOPT_0x22
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2020039
_0x2020038:
	CPI  R30,LOW(0x70)
	BRNE _0x202003B
	CALL SUBOPT_0x20
	CALL SUBOPT_0x22
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020039:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x202003C
_0x202003B:
	CPI  R30,LOW(0x64)
	BREQ _0x202003F
	CPI  R30,LOW(0x69)
	BRNE _0x2020040
_0x202003F:
	ORI  R16,LOW(4)
	RJMP _0x2020041
_0x2020040:
	CPI  R30,LOW(0x75)
	BRNE _0x2020042
_0x2020041:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x2020043
_0x2020042:
	CPI  R30,LOW(0x58)
	BRNE _0x2020045
	ORI  R16,LOW(8)
	RJMP _0x2020046
_0x2020045:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2020077
_0x2020046:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x2020043:
	SBRS R16,2
	RJMP _0x2020048
	CALL SUBOPT_0x20
	CALL SUBOPT_0x23
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020049
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020049:
	CPI  R20,0
	BREQ _0x202004A
	SUBI R17,-LOW(1)
	RJMP _0x202004B
_0x202004A:
	ANDI R16,LOW(251)
_0x202004B:
	RJMP _0x202004C
_0x2020048:
	CALL SUBOPT_0x20
	CALL SUBOPT_0x23
_0x202004C:
_0x202003C:
	SBRC R16,0
	RJMP _0x202004D
_0x202004E:
	CP   R17,R21
	BRSH _0x2020050
	SBRS R16,7
	RJMP _0x2020051
	SBRS R16,2
	RJMP _0x2020052
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x2020053
_0x2020052:
	LDI  R18,LOW(48)
_0x2020053:
	RJMP _0x2020054
_0x2020051:
	LDI  R18,LOW(32)
_0x2020054:
	CALL SUBOPT_0x1F
	SUBI R21,LOW(1)
	RJMP _0x202004E
_0x2020050:
_0x202004D:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x2020055
_0x2020056:
	CPI  R19,0
	BREQ _0x2020058
	SBRS R16,3
	RJMP _0x2020059
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x202005A
_0x2020059:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x202005A:
	CALL SUBOPT_0x1F
	CPI  R21,0
	BREQ _0x202005B
	SUBI R21,LOW(1)
_0x202005B:
	SUBI R19,LOW(1)
	RJMP _0x2020056
_0x2020058:
	RJMP _0x202005C
_0x2020055:
_0x202005E:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x2020060:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2020062
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2020060
_0x2020062:
	CPI  R18,58
	BRLO _0x2020063
	SBRS R16,3
	RJMP _0x2020064
	SUBI R18,-LOW(7)
	RJMP _0x2020065
_0x2020064:
	SUBI R18,-LOW(39)
_0x2020065:
_0x2020063:
	SBRC R16,4
	RJMP _0x2020067
	CPI  R18,49
	BRSH _0x2020069
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020068
_0x2020069:
	RJMP _0x20200D3
_0x2020068:
	CP   R21,R19
	BRLO _0x202006D
	SBRS R16,0
	RJMP _0x202006E
_0x202006D:
	RJMP _0x202006C
_0x202006E:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x202006F
	LDI  R18,LOW(48)
_0x20200D3:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2020070
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x21
	CPI  R21,0
	BREQ _0x2020071
	SUBI R21,LOW(1)
_0x2020071:
_0x2020070:
_0x202006F:
_0x2020067:
	CALL SUBOPT_0x1F
	CPI  R21,0
	BREQ _0x2020072
	SUBI R21,LOW(1)
_0x2020072:
_0x202006C:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x202005F
	RJMP _0x202005E
_0x202005F:
_0x202005C:
	SBRS R16,0
	RJMP _0x2020073
_0x2020074:
	CPI  R21,0
	BREQ _0x2020076
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x21
	RJMP _0x2020074
_0x2020076:
_0x2020073:
_0x2020077:
_0x2020036:
_0x20200D2:
	LDI  R17,LOW(0)
_0x2020021:
	RJMP _0x202001C
_0x202001E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_printf:
; .FSTART _printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_usart_G101)
	LDI  R31,HIGH(_put_usart_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G101
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.DSEG
_columnas:
	.BYTE 0x8
_filas:
	.BYTE 0x8
_estado:
	.BYTE 0x10
_start_game:
	.BYTE 0x1
_next_x:
	.BYTE 0x1
_next_y:
	.BYTE 0x1
_is_collision_bar:
	.BYTE 0x1
_is_collision_wall:
	.BYTE 0x1
_left_wall:
	.BYTE 0x1
_right_wall:
	.BYTE 0x1
_bottom_wall:
	.BYTE 0x1
_matrix_game:
	.BYTE 0x40
_value_empty:
	.BYTE 0x1
_bar_position_x:
	.BYTE 0x1
_bar_position_y:
	.BYTE 0x1
_bar_size:
	.BYTE 0x1
_ball_position_x:
	.BYTE 0x1
_ball_position_y:
	.BYTE 0x1
_ball_velocity_x:
	.BYTE 0x1
_ball_velocity_y:
	.BYTE 0x1
_init_velocity_x:
	.BYTE 0x1
_init_velocity_y:
	.BYTE 0x1
__seed_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(_estado)
	LDI  R27,HIGH(_estado)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3:
	LDI  R31,0
	SUBI R30,LOW(-_columnas)
	SBCI R31,HIGH(-_columnas)
	LD   R31,Z
	LDI  R30,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	LDD  R30,Y+1
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5:
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-_filas)
	SBCI R31,HIGH(-_filas)
	LD   R30,Z
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x7:
	MOV  R31,R8
	LDI  R30,LOW(0)
	MOVW R24,R30
	MOV  R30,R7
	LDI  R31,0
	CALL __LSLW3
	SUBI R30,LOW(-_Animacion*2)
	SBCI R31,HIGH(-_Animacion*2)
	MOVW R22,R30
	MOV  R30,R8
	LDI  R31,0
	LDI  R26,LOW(8)
	LDI  R27,HIGH(8)
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	ADD  R30,R22
	ADC  R31,R23
	LPM  R30,Z
	LDI  R31,0
	OR   R30,R24
	OR   R31,R25
	MOVW R26,R30
	JMP  _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(1)
	LDI  R27,0
	JMP  _mandar_sonido

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA:
	MOV  R30,R9
	LDI  R31,0
	CALL __LSLW3
	SUBI R30,LOW(-_matrix_game)
	SBCI R31,HIGH(-_matrix_game)
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xB:
	LDD  R30,Y+1
	LDI  R31,0
	CALL __LSLW3
	SUBI R30,LOW(-_matrix_game)
	SBCI R31,HIGH(-_matrix_game)
	MOVW R26,R30
	LD   R30,Y
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xC:
	LDI  R31,0
	SBRC R30,7
	SER  R31
	ADD  R30,R26
	ADC  R31,R27
	MOV  R26,R10
	LDI  R27,0
	SBRC R26,7
	SER  R27
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xD:
	LDS  R26,_bar_position_x
	LDI  R27,0
	SBRC R26,7
	SER  R27
	LDS  R30,_bar_size
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LDD  R30,Y+1
	STS  _ball_velocity_x,R30
	LD   R30,Y
	STS  _ball_velocity_y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	MOV  R26,R13
	LDI  R27,0
	SBRC R26,7
	SER  R27
	JMP  _mandar_pelotas

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x10:
	LDS  R30,_ball_velocity_x
	LDS  R26,_ball_position_x
	ADD  R30,R26
	STS  _next_x,R30
	LDS  R30,_ball_velocity_y
	LDS  R26,_ball_position_y
	ADD  R30,R26
	STS  _next_y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	LDS  R30,_ball_position_x
	ST   -Y,R30
	LDS  R26,_next_y
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x12:
	CALL _collision_bar
	STS  _is_collision_bar,R30
	LDI  R31,0
	SBRC R30,7
	SER  R31
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x13:
	IN   R30,0x26
	LDI  R31,0
	MOVW R26,R30
	CALL _srand
	LDS  R30,_init_velocity_x
	LDI  R31,0
	SBRC R30,7
	SER  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x14:
	CALL __MULW12
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __MANDW12
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x15:
	LDS  R30,_ball_velocity_y
	NEG  R30
	MOV  R26,R30
	JMP  _setVelocity_ball

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x16:
	LDS  R30,_next_x
	ST   -Y,R30
	LDS  R26,_next_y
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x17:
	LDS  R30,_ball_velocity_x
	NEG  R30
	ST   -Y,R30
	LDS  R26,_ball_velocity_y
	JMP  _setVelocity_ball

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x18:
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R26,LOW(4)
	CALL _move_ball
	LDS  R30,_ball_velocity_y
	NEG  R30
	STS  _ball_velocity_y,R30
	LDS  R30,_init_velocity_y
	STS  _ball_velocity_y,R30
	LDS  R30,_init_velocity_x
	STS  _ball_velocity_x,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	CALL _collision_matrix
	MOV  R14,R30
	TST  R14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1A:
	LDS  R30,_next_x
	LDI  R31,0
	CALL __LSLW3
	SUBI R30,LOW(-_matrix_game)
	SBCI R31,HIGH(-_matrix_game)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1C:
	CALL _apagar_led
	MOV  R26,R14
	LDI  R27,0
	SBRC R26,7
	SER  R27
	JMP  _mandar_puntuacion

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	MOV  R26,R5
	LDI  R30,LOW(4)
	MUL  R30,R26
	MOVW R30,R0
	SUB  R30,R11
	SBC  R31,R12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	STS  __seed_G100,R30
	STS  __seed_G100+1,R31
	STS  __seed_G100+2,R22
	STS  __seed_G100+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1F:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x20:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x21:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x22:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x23:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x1F4
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

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

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

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__MANDW12:
	CLT
	SBRS R31,7
	RJMP __MANDW121
	RCALL __ANEGW1
	SET
__MANDW121:
	AND  R30,R26
	AND  R31,R27
	BRTC __MANDW122
	RCALL __ANEGW1
__MANDW122:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPW01:
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
