
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
_0x26:
	.DB  0x5
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
	.DB  0x25,0x69,0x0,0x5B,0x25,0x30,0x32,0x69
	.DB  0x2F,0x25,0x30,0x32,0x69,0x2F,0x25,0x30
	.DB  0x32,0x69,0x20,0x25,0x30,0x32,0x69,0x3A
	.DB  0x25,0x30,0x32,0x69,0x3A,0x25,0x30,0x32
	.DB  0x69,0x5D,0x20,0x4E,0x65,0x77,0x5F,0x6D
	.DB  0x73,0x67,0x5F,0x72,0x63,0x76,0x64,0x0
	.DB  0x3A,0x20,0x56,0x6F,0x6C,0x74,0x61,0x67
	.DB  0x65,0x20,0x69,0x73,0x20,0x5B,0x56,0x31
	.DB  0x3A,0x25,0x30,0x31,0x69,0x2E,0x25,0x30
	.DB  0x32,0x69,0x2C,0x20,0x56,0x32,0x3A,0x25
	.DB  0x30,0x31,0x69,0x2E,0x25,0x30,0x32,0x69
	.DB  0x5D,0x0
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
	.DW  0x0D
	.DW  _fileName
	.DW  _0x25*2

	.DW  0x01
	.DW  _STM
	.DW  _0x26*2

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
	.ORG 0

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
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	CALL __INITLOCB
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
	CALL _delay_ms
	LDI  R16,LOW(0)
_0x5:
	CPI  R16,12
	BRSH _0x6
	CALL SUBOPT_0x0
	MOV  R30,R16
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CALL SUBOPT_0x1
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
	ST   -Y,R26
;	dato -> Y+0
	LD   R30,Y
	ANDI R30,LOW(0x8)
	BREQ _0x7
	SBI __lcd_port,__lcd_D7
	RJMP _0x8
_0x7:
	CBI __lcd_port,__lcd_D7
_0x8:
	LD   R30,Y
	ANDI R30,LOW(0x4)
	BREQ _0x9
	SBI __lcd_port,__lcd_D6
	RJMP _0xA
_0x9:
	CBI __lcd_port,__lcd_D6
_0xA:
	LD   R30,Y
	ANDI R30,LOW(0x2)
	BREQ _0xB
	SBI __lcd_port,__lcd_D5
	RJMP _0xC
_0xB:
	CBI __lcd_port,__lcd_D5
_0xC:
	LD   R30,Y
	ANDI R30,LOW(0x1)
	BREQ _0xD
	SBI __lcd_port,__lcd_D4
	RJMP _0xE
_0xD:
	CBI __lcd_port,__lcd_D4
_0xE:
	ADIW R28,1
	RET
; .FEND
_WriteComandLCD:
; .FSTART _WriteComandLCD
	ST   -Y,R26
	ST   -Y,R16
;	Comando -> Y+1
;	tempComando -> R16
	CBI __lcd_port,__lcd_RS
	CALL SUBOPT_0x0
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	RCALL _PulseEn
	LDD  R16,Y+0
	JMP  _0x20E001E
; .FEND
_CharLCD:
; .FSTART _CharLCD
	ST   -Y,R26
	ST   -Y,R16
;	dato -> Y+1
;	tempdato -> R16
	SBI __lcd_port,__lcd_RS
	CALL SUBOPT_0x0
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	RCALL _PulseEn
	LDD  R16,Y+0
	JMP  _0x20E001E
; .FEND
_StringLCD:
; .FSTART _StringLCD
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R16
;	i -> R16
	LDI  R16,LOW(0)
_0x10:
	MOV  R30,R16
	SUBI R16,-1
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R26,Z
	RCALL _CharLCD
	MOV  R30,R16
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	CPI  R30,0
	BRNE _0x10
	LDD  R16,Y+0
	JMP  _0x20E001C
; .FEND
;	tiempo -> Y+1
;	i -> R16
_StringLCDVar:
; .FSTART _StringLCDVar
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R16
;	Mensaje -> Y+1
;	i -> R16
	LDI  R16,LOW(0)
_0x16:
	MOV  R30,R16
	SUBI R16,-1
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RCALL _CharLCD
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CLR  R30
	ADD  R26,R16
	ADC  R27,R30
	LD   R30,X
	CPI  R30,0
	BRNE _0x16
	LDD  R16,Y+0
	JMP  _0x20E001C
; .FEND
_MoveCursor:
; .FSTART _MoveCursor
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LD   R30,Y
	LDI  R31,0
	SBIW R30,0
	BRNE _0x1B
	LDD  R26,Y+1
	SUBI R26,-LOW(128)
	RJMP _0x43
_0x1B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1C
	LDD  R26,Y+1
	SUBI R26,-LOW(192)
	RJMP _0x43
_0x1C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x1D
	LDD  R26,Y+1
	SUBI R26,-LOW(148)
	RJMP _0x43
_0x1D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1A
	LDD  R26,Y+1
	SUBI R26,-LOW(212)
_0x43:
	RCALL _WriteComandLCD
_0x1A:
	JMP  _0x20E001E
; .FEND
;	NoCaracter -> Y+3
;	datos -> Y+1
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
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0000 002C {
_read_adc:
; .FSTART _read_adc
; 0000 002D ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,LOW(0xC0)
	STS  124,R30
; 0000 002E // Delay needed for the stabilization of the ADC input voltage
; 0000 002F delay_us(10);
	__DELAY_USB 7
; 0000 0030 // Start the AD conversion
; 0000 0031 ADCSRA|=(1<<ADSC);
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0032 // Wait for the AD conversion to complete
; 0000 0033 while ((ADCSRA & (1<<ADIF))==0);
_0x22:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x22
; 0000 0034 ADCSRA|=(1<<ADIF);
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
; 0000 0035 return ADCW;
	LDS  R30,120
	LDS  R31,120+1
	JMP  _0x20E0019
; 0000 0036 }
; .FEND
;
;float v1, v2;
;int v1I, v1D, v2I, v2D;
;
;void updateADC(){
; 0000 003B void updateADC(){
_updateADC:
; .FSTART _updateADC
; 0000 003C 
; 0000 003D     v1 = (read_adc(6)*5.0)/1024.0;
	LDI  R26,LOW(6)
	CALL SUBOPT_0x4
	STS  _v1,R30
	STS  _v1+1,R31
	STS  _v1+2,R22
	STS  _v1+3,R23
; 0000 003E     v2 = (read_adc(7)*5.0)/1024.0;
	LDI  R26,LOW(7)
	CALL SUBOPT_0x4
	STS  _v2,R30
	STS  _v2+1,R31
	STS  _v2+2,R22
	STS  _v2+3,R23
; 0000 003F     v1I = (int)v1;
	LDS  R30,_v1
	LDS  R31,_v1+1
	LDS  R22,_v1+2
	LDS  R23,_v1+3
	CALL __CFD1
	STS  _v1I,R30
	STS  _v1I+1,R31
; 0000 0040     v1D = (int)((v1 - (float)v1I)*100.0);
	CALL SUBOPT_0x5
	CALL __CWD1
	CALL __CDF1
	LDS  R26,_v1
	LDS  R27,_v1+1
	LDS  R24,_v1+2
	LDS  R25,_v1+3
	CALL SUBOPT_0x6
	STS  _v1D,R30
	STS  _v1D+1,R31
; 0000 0041     v2I = (int)v2;
	LDS  R30,_v2
	LDS  R31,_v2+1
	LDS  R22,_v2+2
	LDS  R23,_v2+3
	CALL __CFD1
	STS  _v2I,R30
	STS  _v2I+1,R31
; 0000 0042     v2D = (int)((v2 - (float)v2I)*100.0);
	CALL SUBOPT_0x7
	CALL __CWD1
	CALL __CDF1
	LDS  R26,_v2
	LDS  R27,_v2+1
	LDS  R24,_v2+2
	LDS  R25,_v2+3
	CALL SUBOPT_0x6
	STS  _v2D,R30
	STS  _v2D+1,R31
; 0000 0043 }
	RET
; .FEND
;
;// SD
;char fileName[]  = "0:muestra.txt";

	.DSEG
;char date[32];
;char text[32];
;unsigned char STM=5, GS=0;
;
;    unsigned int br, br1;
;    char buffer[100];
;
;    /* FAT function result */
;    FRESULT res;
;
;    /* will hold the information for logical drive 0: */
;    FATFS drive;
;    FIL archivo; // file objects
;
;interrupt [TIM1_COMPA] void timer1_compa_isr(void)
; 0000 0056 {

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
; 0000 0057 disk_timerproc();
	CALL _disk_timerproc
; 0000 0058 /* MMC/SD/SD HC card access low level timing function */
; 0000 0059 }
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
;void sd(char NombreArchivo[], char *TextoEscritura[],unsigned char order){
; 0000 005C void sd(char NombreArchivo[], char *TextoEscritura[],unsigned char order){
_sd:
; .FSTART _sd
; 0000 005D 
; 0000 005E 
; 0000 005F     /* mount logical drive 0: */
; 0000 0060     if ((res=f_mount(0,&drive))==FR_OK){
	ST   -Y,R26
;	NombreArchivo -> Y+3
;	TextoEscritura -> Y+1
;	order -> Y+0
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(_drive)
	LDI  R27,HIGH(_drive)
	CALL _f_mount
	STS  _res,R30
	CPI  R30,0
	BRNE _0x27
; 0000 0061 
; 0000 0062         /*Lectura de Archivo*/
; 0000 0063         res = f_open(&archivo, NombreArchivo, FA_OPEN_ALWAYS | FA_WRITE | FA_READ);
	CALL SUBOPT_0x8
	CALL SUBOPT_0x9
	LDI  R26,LOW(19)
	CALL _f_open
	STS  _res,R30
; 0000 0064         if (res==FR_OK){
	CPI  R30,0
	BRNE _0x28
; 0000 0065 
; 0000 0066             if (order == 0){
	LD   R30,Y
	CPI  R30,0
	BRNE _0x29
; 0000 0067                 f_lseek(&archivo,archivo.fsize);
	CALL SUBOPT_0x8
	CALL SUBOPT_0xA
; 0000 0068                 f_write(&archivo,&TextoEscritura,32,&br1);   // Write of TextoEscritura
	CALL SUBOPT_0xB
	RJMP _0x44
; 0000 0069             }
; 0000 006A             else {
_0x29:
; 0000 006B                 f_lseek(&archivo,archivo.fsize);
	CALL SUBOPT_0x8
	CALL SUBOPT_0xA
; 0000 006C                 f_write(&archivo,&TextoEscritura,32,&br1);   // Write of TextoEscritura
	CALL SUBOPT_0xB
	CALL _f_write
; 0000 006D                 buffer[0] = 0x0D;                //Carriage return
	LDI  R30,LOW(13)
	STS  _buffer,R30
; 0000 006E                 buffer[1] = 0x0A;                //Line Feed
	LDI  R30,LOW(10)
	__PUTB1MN _buffer,1
; 0000 006F                 f_write(&archivo,buffer,2,&br);
	CALL SUBOPT_0x8
	LDI  R30,LOW(_buffer)
	LDI  R31,HIGH(_buffer)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_br)
	LDI  R27,HIGH(_br)
_0x44:
	CALL _f_write
; 0000 0070             }
; 0000 0071 
; 0000 0072             /*Escribiendo el Texto*/
; 0000 0073             f_close(&archivo);
	LDI  R26,LOW(_archivo)
	LDI  R27,HIGH(_archivo)
	CALL _f_close
; 0000 0074         }
; 0000 0075         else{
	RJMP _0x2B
_0x28:
; 0000 0076             StringLCD("Archivo NO Encontrado");
	__POINTW2FN _0x0,0
	RCALL _StringLCD
; 0000 0077         }
_0x2B:
; 0000 0078     }
; 0000 0079     else{
	RJMP _0x2C
_0x27:
; 0000 007A          StringLCD("Drive NO Detectado");
	__POINTW2FN _0x0,22
	RCALL _StringLCD
; 0000 007B     }
_0x2C:
; 0000 007C     f_mount(0, 0); //Cerrar drive de SD
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _f_mount
; 0000 007D }
	ADIW R28,5
	RET
; .FEND
;
;// Clock
;unsigned char H=0,M=0,S=0, D=0,Mes=0,A=0; // Variables for clock
;
;unsigned char time[16];
;
;void updateClock(){
; 0000 0084 void updateClock(){
_updateClock:
; .FSTART _updateClock
; 0000 0085     rtc_get_time(&H, &M, &S);
	LDI  R30,LOW(_H)
	LDI  R31,HIGH(_H)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_M)
	LDI  R31,HIGH(_M)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_S)
	LDI  R27,HIGH(_S)
	CALL _rtc_get_time
; 0000 0086     rtc_get_date(&D, &Mes, &A);
	LDI  R30,LOW(_D)
	LDI  R31,HIGH(_D)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_Mes)
	LDI  R31,HIGH(_Mes)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_A)
	LDI  R27,HIGH(_A)
	CALL _rtc_get_date
; 0000 0087 }
	RET
; .FEND
;
;// LCD
;void printTime(){
; 0000 008A void printTime(){
_printTime:
; .FSTART _printTime
; 0000 008B     sprintf(time, "%02i:%02i:%02i V1: %i.%i", H, M, S, v1I,v1D);
	LDI  R30,LOW(_time)
	LDI  R31,HIGH(_time)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,41
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	CALL SUBOPT_0xE
; 0000 008C     MoveCursor(0,0);
	LDI  R26,LOW(0)
	CALL SUBOPT_0xF
; 0000 008D     StringLCDVar(time);
; 0000 008E     sprintf(time, "%02i:%02i:%02i V2: %i.%i", D, Mes, A, v2I,v2D);
	LDI  R30,LOW(_time)
	LDI  R31,HIGH(_time)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,66
	CALL SUBOPT_0x10
	CALL SUBOPT_0x11
	CALL SUBOPT_0xE
; 0000 008F     MoveCursor(0,1);
	LDI  R26,LOW(1)
	CALL SUBOPT_0xF
; 0000 0090     StringLCDVar(time);
; 0000 0091 }
	RET
; .FEND
;
;
;void main(void)
; 0000 0095 {
_main:
; .FSTART _main
; 0000 0096 
; 0000 0097 // ADC initialization
; 0000 0098 // ADC Clock frequency: 1000.000 kHz
; 0000 0099 // ADC Voltage Reference: Int., cap. on AREF
; 0000 009A // ADC High Speed Mode: On
; 0000 009B // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
; 0000 009C // ADC4: On, ADC5: On, ADC6: Off, ADC7: Off
; 0000 009D DIDR0=(1<<ADC7D) | (1<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
	LDI  R30,LOW(192)
	STS  126,R30
; 0000 009E ADMUX=ADC_VREF_TYPE;
	STS  124,R30
; 0000 009F ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(129)
	STS  122,R30
; 0000 00A0 ADCSRB=(1<<ADHSM);
	LDI  R30,LOW(128)
	STS  123,R30
; 0000 00A1 
; 0000 00A2 // LCD
; 0000 00A3 SetupLCD();
	CALL _SetupLCD
; 0000 00A4 
; 0000 00A5 // DS1302
; 0000 00A6 rtc_init(0,0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _rtc_init
; 0000 00A7 
; 0000 00A8 // SD
; 0000 00A9 // Código para hacer una interrupción periódica cada 10ms
; 0000 00AA // Timer/Counter 1 initialization
; 0000 00AB // Clock source: System Clock
; 0000 00AC // Clock value: 1000.000 kHz
; 0000 00AD // Mode: CTC top=OCR1A
; 0000 00AE // Compare A Match Interrupt: On
; 0000 00AF TCCR1B=0x09;
	LDI  R30,LOW(9)
	STS  129,R30
; 0000 00B0 OCR1AH=19999/256;
	LDI  R30,LOW(78)
	STS  137,R30
; 0000 00B1 OCR1AL=19999%256;   //20000cuentas a 0.5us por cuenta=10mseg
	LDI  R30,LOW(31)
	STS  136,R30
; 0000 00B2 TIMSK1=0x02;
	LDI  R30,LOW(2)
	STS  111,R30
; 0000 00B3 SetupLCD();
	CALL _SetupLCD
; 0000 00B4 #asm("sei")
	sei
; 0000 00B5 /* Inicia el puerto SPI para la SD */
; 0000 00B6 disk_initialize(0);
	LDI  R26,LOW(0)
	CALL _disk_initialize
; 0000 00B7 delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 00B8 
; 0000 00B9 // First actions
; 0000 00BA PORTC = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x8,R30
; 0000 00BB 
; 0000 00BC GS = S + STM;
	CALL SUBOPT_0x12
; 0000 00BD 
; 0000 00BE if(GS>59){
	BRLO _0x2D
; 0000 00BF     GS = GS-59;
	CALL SUBOPT_0x13
; 0000 00C0 }
; 0000 00C1 
; 0000 00C2 while (1)
_0x2D:
_0x2E:
; 0000 00C3     {
; 0000 00C4     // Please write your application code here
; 0000 00C5         // Verify the correct range on clock time
; 0000 00C6 
; 0000 00C7         // ADC
; 0000 00C8         updateADC();
	RCALL _updateADC
; 0000 00C9 
; 0000 00CA         // Clock
; 0000 00CB         updateClock();
	RCALL _updateClock
; 0000 00CC         printTime();
	RCALL _printTime
; 0000 00CD 
; 0000 00CE         // If alarm is on, switch will turn alarm off without
; 0000 00CF         //  changing the default variable
; 0000 00D0         if(!PINC.0){
	SBIC 0x6,0
	RJMP _0x31
; 0000 00D1             H++;
	LDS  R30,_H
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x14
; 0000 00D2             rtc_set_time(H, M, S);
; 0000 00D3         }
; 0000 00D4         if(!PINC.1){
_0x31:
	SBIC 0x6,1
	RJMP _0x32
; 0000 00D5             M++;
	LDS  R30,_M
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x15
; 0000 00D6             rtc_set_time(H, M, S);
; 0000 00D7         }
; 0000 00D8         if(!PINC.2){
_0x32:
	SBIC 0x6,2
	RJMP _0x33
; 0000 00D9             S=0;
	CALL SUBOPT_0x16
; 0000 00DA             rtc_set_time(H, M, S);
; 0000 00DB         }
; 0000 00DC         if(!PINC.3){
_0x33:
	SBIC 0x6,3
	RJMP _0x34
; 0000 00DD             D++;
	LDS  R30,_D
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x17
; 0000 00DE             rtc_set_date(D, Mes, A);
; 0000 00DF         }
; 0000 00E0         if(!PINC.3){
_0x34:
	SBIC 0x6,3
	RJMP _0x35
; 0000 00E1             Mes++;
	LDS  R30,_Mes
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x18
; 0000 00E2             rtc_set_date(D, Mes, A);
; 0000 00E3         }
; 0000 00E4         if(!PINC.4){
_0x35:
	SBIC 0x6,4
	RJMP _0x36
; 0000 00E5             A++;
	LDS  R30,_A
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x19
; 0000 00E6             rtc_set_date(D, Mes, A);
; 0000 00E7         }
; 0000 00E8         if(!PINC.5){
_0x36:
	SBIC 0x6,5
	RJMP _0x37
; 0000 00E9             STM = STM + 5;
	LDS  R30,_STM
	SUBI R30,-LOW(5)
	STS  _STM,R30
; 0000 00EA             if(STM>60){
	LDS  R26,_STM
	CPI  R26,LOW(0x3D)
	BRLO _0x38
; 0000 00EB                 STM = 5;
	LDI  R30,LOW(5)
	STS  _STM,R30
; 0000 00EC             }
; 0000 00ED             GS = S+STM;
_0x38:
	CALL SUBOPT_0x12
; 0000 00EE             if(GS>59){
	BRLO _0x39
; 0000 00EF                 GS = GS-59;
	CALL SUBOPT_0x13
; 0000 00F0             }
; 0000 00F1         }
_0x39:
; 0000 00F2         if(S>59){
_0x37:
	LDS  R26,_S
	CPI  R26,LOW(0x3C)
	BRLO _0x3A
; 0000 00F3             S=0;
	CALL SUBOPT_0x16
; 0000 00F4             rtc_set_time(H, M, S);
; 0000 00F5         }
; 0000 00F6         if(M>59){
_0x3A:
	LDS  R26,_M
	CPI  R26,LOW(0x3C)
	BRLO _0x3B
; 0000 00F7             M=0;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x15
; 0000 00F8             rtc_set_time(H, M, S);
; 0000 00F9         }
; 0000 00FA         if(H>23){
_0x3B:
	LDS  R26,_H
	CPI  R26,LOW(0x18)
	BRLO _0x3C
; 0000 00FB             H=0;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x14
; 0000 00FC             rtc_set_time(H, M, S);
; 0000 00FD         }
; 0000 00FE         if(D>31){
_0x3C:
	LDS  R26,_D
	CPI  R26,LOW(0x20)
	BRLO _0x3D
; 0000 00FF             D=0;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x17
; 0000 0100             rtc_set_date(D, Mes, A);
; 0000 0101         }
; 0000 0102         if(Mes>12){
_0x3D:
	LDS  R26,_Mes
	CPI  R26,LOW(0xD)
	BRLO _0x3E
; 0000 0103             Mes=0;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x18
; 0000 0104             rtc_set_date(D, Mes, A);
; 0000 0105         }
; 0000 0106         if(A>25){
_0x3E:
	LDS  R26,_A
	CPI  R26,LOW(0x1A)
	BRLO _0x3F
; 0000 0107             A=00;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x19
; 0000 0108             rtc_set_date(D, Mes, A);
; 0000 0109         }
; 0000 010A         if(S == GS){
_0x3F:
	LDS  R30,_GS
	LDS  R26,_S
	CP   R30,R26
	BRNE _0x40
; 0000 010B         //SD here
; 0000 010C             sprintf(date, "[%02i/%02i/%02i %02i:%02i:%02i] New_msg_rcvd", D, Mes, A, H, M, S);
	LDI  R30,LOW(_date)
	LDI  R31,HIGH(_date)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,91
	CALL SUBOPT_0x10
	CALL SUBOPT_0xC
	LDI  R24,24
	CALL _sprintf
	ADIW R28,28
; 0000 010D             sprintf(text, ": Voltage is [V1:%01i.%02i, V2:%01i.%02i]", v1I, v1D, v2I, v2D);
	LDI  R30,LOW(_text)
	LDI  R31,HIGH(_text)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,136
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xD
	CALL SUBOPT_0x11
	LDI  R24,16
	CALL _sprintf
	ADIW R28,20
; 0000 010E             sd(fileName, &date, 0);
	LDI  R30,LOW(_fileName)
	LDI  R31,HIGH(_fileName)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_date)
	LDI  R31,HIGH(_date)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _sd
; 0000 010F             sd(fileName, &text, 1);
	LDI  R30,LOW(_fileName)
	LDI  R31,HIGH(_fileName)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_text)
	LDI  R31,HIGH(_text)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _sd
; 0000 0110             GS = S + STM;
	CALL SUBOPT_0x12
; 0000 0111             if(GS>59){
	BRLO _0x41
; 0000 0112                 GS = GS-59;
	CALL SUBOPT_0x13
; 0000 0113             }
; 0000 0114         }
_0x41:
; 0000 0115     }
_0x40:
	RJMP _0x2E
; 0000 0116 }
_0x42:
	RJMP _0x42
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
	ST   -Y,R26
    sbi  __ds1302_port-1,__ds1302_sclk
    sbi  __ds1302_port-1,__ds1302_io
    sbi  __ds1302_port-1,__ds1302_rst
    sbi  __ds1302_port,__ds1302_rst
	__DELAY_USB 3
	LD   R26,Y
	RCALL _ds1302_write1_G100
	JMP  _0x20E0019
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
_ds1302_read:
; .FSTART _ds1302_read
	ST   -Y,R26
	LD   R30,Y
	ORI  R30,1
	MOV  R26,R30
	CALL _ds1302_write0_G100
    cbi  __ds1302_port,__ds1302_io
    cbi  __ds1302_port-1,__ds1302_io
    ldi  r26,8
ds1302_read0:
    clc
	sbic __ds1302_port-2,__ds1302_io
    sec
    ror  r30
    sbi  __ds1302_port,__ds1302_sclk
	__DELAY_USB 1
	cbi  __ds1302_port,__ds1302_sclk
	__DELAY_USB 1
    dec  r26
    brne ds1302_read0
	CALL _ds1302_rst0_G100
	RJMP _0x20E0019
; .FEND
_ds1302_write:
; .FSTART _ds1302_write
	ST   -Y,R26
	LDD  R30,Y+1
	ANDI R30,0xFE
	MOV  R26,R30
	CALL _ds1302_write0_G100
	LD   R26,Y
	CALL _ds1302_write1_G100
	CALL _ds1302_rst0_G100
_0x20E001E:
	ADIW R28,2
	RET
; .FEND
_rtc_init:
; .FSTART _rtc_init
	ST   -Y,R26
	LD   R30,Y
	ANDI R30,LOW(0x3)
	ST   Y,R30
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x2000003
	LD   R30,Y
	ORI  R30,LOW(0xA0)
	ST   Y,R30
_0x2000003:
	LDD  R26,Y+1
	CPI  R26,LOW(0x1)
	BRNE _0x2000004
	LD   R30,Y
	ORI  R30,4
	RJMP _0x2000008
_0x2000004:
	LDD  R26,Y+1
	CPI  R26,LOW(0x2)
	BRNE _0x2000006
	LD   R30,Y
	ORI  R30,8
	RJMP _0x2000008
_0x2000006:
	LDI  R30,LOW(0)
_0x2000008:
	ST   Y,R30
	CALL SUBOPT_0x1A
	LDI  R30,LOW(144)
	ST   -Y,R30
	LDD  R26,Y+1
	RJMP _0x20E001B
; .FEND
_rtc_get_time:
; .FSTART _rtc_get_time
	ST   -Y,R27
	ST   -Y,R26
	LDI  R26,LOW(133)
	CALL SUBOPT_0x1B
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	LDI  R26,LOW(131)
	CALL SUBOPT_0x1B
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R26,LOW(129)
	RJMP _0x20E001D
; .FEND
_rtc_set_time:
; .FSTART _rtc_set_time
	ST   -Y,R26
	CALL SUBOPT_0x1A
	LDI  R30,LOW(132)
	CALL SUBOPT_0x1C
	LDI  R30,LOW(130)
	CALL SUBOPT_0x1D
	LDI  R30,LOW(128)
	RJMP _0x20E001A
; .FEND
_rtc_get_date:
; .FSTART _rtc_get_date
	ST   -Y,R27
	ST   -Y,R26
	LDI  R26,LOW(135)
	CALL SUBOPT_0x1B
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	LDI  R26,LOW(137)
	CALL SUBOPT_0x1B
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R26,LOW(141)
_0x20E001D:
	RCALL _ds1302_read
	MOV  R26,R30
	CALL _bcd2bin
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	ADIW R28,6
	RET
; .FEND
_rtc_set_date:
; .FSTART _rtc_set_date
	ST   -Y,R26
	CALL SUBOPT_0x1A
	LDI  R30,LOW(134)
	CALL SUBOPT_0x1C
	LDI  R30,LOW(136)
	CALL SUBOPT_0x1D
	LDI  R30,LOW(140)
_0x20E001A:
	ST   -Y,R30
	LDD  R26,Y+1
	CALL _bin2bcd
	MOV  R26,R30
_0x20E001B:
	RCALL _ds1302_write
	LDI  R30,LOW(142)
	ST   -Y,R30
	LDI  R26,LOW(128)
	RCALL _ds1302_write
_0x20E001C:
	ADIW R28,3
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
_crc7_G101:
; .FSTART _crc7_G101
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R19,LOW(0)
	LDD  R17,Y+4
_0x2020005:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LD   R18,X+
	STD  Y+5,R26
	STD  Y+5+1,R27
	LDI  R16,LOW(8)
_0x2020008:
	LSL  R19
	MOV  R30,R19
	EOR  R30,R18
	ANDI R30,LOW(0x80)
	BREQ _0x202000A
	LDI  R30,LOW(9)
	EOR  R19,R30
_0x202000A:
	LSL  R18
	SUBI R16,LOW(1)
	BRNE _0x2020008
	SUBI R17,LOW(1)
	BRNE _0x2020005
	MOV  R30,R19
	LSL  R30
	ORI  R30,1
	CALL __LOADLOCR4
	RJMP _0x20E0015
; .FEND
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
	RJMP _0x20E0016
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
_rx_datablock_G101:
; .FSTART _rx_datablock_G101
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR3
	LDI  R30,LOW(20)
	STS  _timer1_G101,R30
_0x202001A:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x202001C:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202001C
	IN   R16,46
	CPI  R16,255
	BRNE _0x202001F
	LDS  R30,_timer1_G101
	CPI  R30,0
	BRNE _0x2020020
_0x202001F:
	RJMP _0x202001B
_0x2020020:
	RJMP _0x202001A
_0x202001B:
	CPI  R16,254
	BREQ _0x2020021
	LDI  R30,LOW(0)
	CALL __LOADLOCR3
	RJMP _0x20E0015
_0x2020021:
	__GETWRS 17,18,5
_0x2020023:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020025:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020025
	PUSH R18
	PUSH R17
	__ADDWRN 17,18,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020028:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020028
	PUSH R18
	PUSH R17
	__ADDWRN 17,18,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x202002B:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202002B
	PUSH R18
	PUSH R17
	__ADDWRN 17,18,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x202002E:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202002E
	PUSH R18
	PUSH R17
	__ADDWRN 17,18,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	SBIW R30,4
	STD  Y+3,R30
	STD  Y+3+1,R31
	BRNE _0x2020023
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020031:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020031
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020034:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020034
	LDI  R30,LOW(1)
	CALL __LOADLOCR3
	RJMP _0x20E0015
; .FEND
_tx_datablock_G101:
; .FSTART _tx_datablock_G101
	ST   -Y,R26
	CALL __SAVELOCR4
	RCALL _wait_ready_G101
	CPI  R30,LOW(0xFF)
	BREQ _0x2020037
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20E0015
_0x2020037:
	LDD  R30,Y+4
	OUT  0x2E,R30
_0x2020038:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020038
	LDD  R26,Y+4
	CPI  R26,LOW(0xFD)
	BREQ _0x202003B
	LDI  R17,LOW(0)
	__GETWRS 18,19,5
_0x202003D:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	OUT  0x2E,R30
_0x202003F:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202003F
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	OUT  0x2E,R30
_0x2020042:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020042
	SUBI R17,LOW(1)
	BRNE _0x202003D
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020045:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020045
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020048:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020048
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x202004B:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202004B
	IN   R16,46
	MOV  R30,R16
	ANDI R30,LOW(0x1F)
	CPI  R30,LOW(0x5)
	BREQ _0x202004E
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20E0015
_0x202004E:
_0x202003B:
	LDI  R30,LOW(1)
	CALL __LOADLOCR4
	RJMP _0x20E0015
; .FEND
_send_cmd_G101:
; .FSTART _send_cmd_G101
	CALL __PUTPARD2
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	ANDI R30,LOW(0x80)
	BREQ _0x202004F
	LDD  R30,Y+6
	ANDI R30,0x7F
	STD  Y+6,R30
	LDI  R30,LOW(119)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	MOV  R17,R30
	CPI  R17,2
	BRLO _0x2020050
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0015
_0x2020050:
_0x202004F:
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
	BREQ _0x2020051
	RCALL _deselect_card_G101
	CBI  0x5,0
	RCALL _wait_ready_G101
	CPI  R30,LOW(0xFF)
	BREQ _0x2020052
	LDI  R30,LOW(255)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0015
_0x2020052:
_0x2020051:
	LDD  R30,Y+6
	OUT  0x2E,R30
_0x2020053:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020053
	LDD  R30,Y+5
	OUT  0x2E,R30
_0x2020056:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020056
	LDD  R30,Y+4
	OUT  0x2E,R30
_0x2020059:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020059
	LDD  R30,Y+3
	OUT  0x2E,R30
_0x202005C:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202005C
	LDD  R30,Y+2
	OUT  0x2E,R30
_0x202005F:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x202005F
	LDI  R16,LOW(1)
	LDD  R26,Y+6
	CPI  R26,LOW(0x40)
	BRNE _0x2020062
	LDI  R16,LOW(149)
	RJMP _0x2020063
_0x2020062:
	LDD  R26,Y+6
	CPI  R26,LOW(0x48)
	BRNE _0x2020064
	LDI  R16,LOW(135)
_0x2020064:
_0x2020063:
	OUT  0x2E,R16
_0x2020065:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020065
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
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
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0015
; .FEND
_rx_spi4_G101:
; .FSTART _rx_spi4_G101
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R16
	LDI  R16,4
_0x2020075:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2020077:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2020077
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,1
	STD  Y+1,R26
	STD  Y+1+1,R27
	SBIW R26,1
	IN   R30,0x2E
	ST   X,R30
	SUBI R16,LOW(1)
	BRNE _0x2020075
	RJMP _0x20E0014
; .FEND
_disk_initialize:
; .FSTART _disk_initialize
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR3
	LDD  R30,Y+7
	CPI  R30,0
	BREQ _0x202007A
	LDI  R30,LOW(1)
	CALL __LOADLOCR3
	RJMP _0x20E0018
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
	LDS  R30,_status_G101
	CALL __LOADLOCR3
	RJMP _0x20E0018
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
	ADIW R26,3
	RCALL _rx_spi4_G101
	LDD  R26,Y+5
	CPI  R26,LOW(0x1)
	BRNE _0x202008D
	LDD  R26,Y+6
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
	ADIW R26,3
	RCALL _rx_spi4_G101
	LDD  R30,Y+3
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
	LDS  R30,_status_G101
	CALL __LOADLOCR3
	RJMP _0x20E0018
; .FEND
_disk_status:
; .FSTART _disk_status
	ST   -Y,R26
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20200A7
	LDI  R30,LOW(1)
	RJMP _0x20E0019
_0x20200A7:
	LDS  R30,_status_G101
_0x20E0019:
	ADIW R28,1
	RET
; .FEND
_disk_read:
; .FSTART _disk_read
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20200A9
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20200A8
_0x20200A9:
	LDI  R30,LOW(4)
	RJMP _0x20E0018
_0x20200A8:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x1)
	BREQ _0x20200AB
	LDI  R30,LOW(3)
	RJMP _0x20E0018
_0x20200AB:
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x8)
	BRNE _0x20200AC
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20200AC:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20200AD
	LDI  R30,LOW(81)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200AE
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200AF
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20200AF:
_0x20200AE:
	RJMP _0x20200B0
_0x20200AD:
	LDI  R30,LOW(82)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200B1
_0x20200B3:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200B4
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20200B3
_0x20200B4:
	LDI  R30,LOW(76)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
_0x20200B1:
_0x20200B0:
	RCALL _deselect_card_G101
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20200B6
	LDI  R30,LOW(1)
	RJMP _0x20200B7
_0x20200B6:
	LDI  R30,LOW(0)
_0x20200B7:
	RJMP _0x20E0018
; .FEND
_disk_write:
; .FSTART _disk_write
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20200BA
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20200B9
_0x20200BA:
	LDI  R30,LOW(4)
	RJMP _0x20E0018
_0x20200B9:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x1)
	BREQ _0x20200BC
	LDI  R30,LOW(3)
	RJMP _0x20E0018
_0x20200BC:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x4)
	BREQ _0x20200BD
	LDI  R30,LOW(2)
	RJMP _0x20E0018
_0x20200BD:
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x8)
	BRNE _0x20200BE
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20200BE:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20200BF
	LDI  R30,LOW(88)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200C0
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(254)
	RCALL _tx_datablock_G101
	CPI  R30,0
	BREQ _0x20200C1
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20200C1:
_0x20200C0:
	RJMP _0x20200C2
_0x20200BF:
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x6)
	BREQ _0x20200C3
	LDI  R30,LOW(215)
	ST   -Y,R30
	LDD  R26,Y+1
	CLR  R27
	CLR  R24
	CLR  R25
	RCALL _send_cmd_G101
_0x20200C3:
	LDI  R30,LOW(89)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200C4
_0x20200C6:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(252)
	RCALL _tx_datablock_G101
	CPI  R30,0
	BREQ _0x20200C7
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20200C6
_0x20200C7:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(253)
	RCALL _tx_datablock_G101
	CPI  R30,0
	BRNE _0x20200C9
	LDI  R30,LOW(1)
	ST   Y,R30
_0x20200C9:
_0x20200C4:
_0x20200C2:
	RCALL _deselect_card_G101
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20200CA
	LDI  R30,LOW(1)
	RJMP _0x20200CB
_0x20200CA:
	LDI  R30,LOW(0)
_0x20200CB:
_0x20E0018:
	ADIW R28,8
	RET
; .FEND
_disk_ioctl:
; .FSTART _disk_ioctl
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,16
	CALL __SAVELOCR4
	LDD  R30,Y+23
	CPI  R30,0
	BREQ _0x20200CD
	LDI  R30,LOW(4)
	RJMP _0x20E0017
_0x20200CD:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x1)
	BREQ _0x20200CE
	LDI  R30,LOW(3)
	RJMP _0x20E0017
_0x20200CE:
	LDI  R16,LOW(1)
	LDD  R30,Y+22
	CPI  R30,0
	BRNE _0x20200D2
	CBI  0x5,0
	RCALL _wait_ready_G101
	CPI  R30,LOW(0xFF)
	BRNE _0x20200D3
	LDI  R16,LOW(0)
_0x20200D3:
	RJMP _0x20200D1
_0x20200D2:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x20200D4
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200D6
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BRNE _0x20200D7
_0x20200D6:
	RJMP _0x20200D5
_0x20200D7:
	LDD  R30,Y+4
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	CPI  R30,LOW(0x1)
	BRNE _0x20200D8
	LDI  R30,0
	LDD  R31,Y+12
	LDD  R26,Y+13
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	__PUTW1R 17,18
	__GETW2R 17,18
	CLR  R24
	CLR  R25
	LDI  R30,LOW(10)
	RJMP _0x2020109
_0x20200D8:
	LDD  R30,Y+9
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LDD  R30,Y+14
	ANDI R30,LOW(0x80)
	ROL  R30
	LDI  R30,0
	ROL  R30
	ADD  R26,R30
	LDD  R30,Y+13
	ANDI R30,LOW(0x3)
	LSL  R30
	ADD  R30,R26
	SUBI R30,-LOW(2)
	MOV  R19,R30
	LDD  R30,Y+12
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	MOV  R26,R30
	LDD  R30,Y+11
	LDI  R31,0
	CALL __LSLW2
	LDI  R27,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+10
	ANDI R30,LOW(0x3)
	LDI  R31,0
	CALL __LSLW2
	MOV  R31,R30
	LDI  R30,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	__PUTW1R 17,18
	__GETW2R 17,18
	CLR  R24
	CLR  R25
	MOV  R30,R19
	SUBI R30,LOW(9)
_0x2020109:
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R16,LOW(0)
_0x20200D5:
	RJMP _0x20200D1
_0x20200D4:
	CPI  R30,LOW(0x2)
	BRNE _0x20200DA
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	ST   X+,R30
	ST   X,R31
	LDI  R16,LOW(0)
	RJMP _0x20200D1
_0x20200DA:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x20200DB
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x4)
	BREQ _0x20200DC
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200DD
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x20200DE:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x20200DE
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200E1
	LDI  R19,LOW(48)
_0x20200E3:
	CPI  R19,0
	BREQ _0x20200E4
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x20200E5:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x20200E5
	SUBI R19,1
	RJMP _0x20200E3
_0x20200E4:
	LDD  R30,Y+14
	SWAP R30
	ANDI R30,0xF
	__GETD2N 0x10
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R16,LOW(0)
_0x20200E1:
_0x20200DD:
	RJMP _0x20200E8
_0x20200DC:
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BREQ PC+2
	RJMP _0x20200E9
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20200EA
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x2)
	BREQ _0x20200EB
	LDD  R30,Y+14
	ANDI R30,LOW(0x3F)
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __LSLD1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+15
	ANDI R30,LOW(0x80)
	CLR  R31
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(7)
	CALL __LSRD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	__ADDD1N 1
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+17
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	SUBI R30,LOW(1)
	CALL __LSLD12
	RJMP _0x202010A
_0x20200EB:
	LDD  R30,Y+14
	ANDI R30,LOW(0x7C)
	LSR  R30
	LSR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	__ADDD1N 1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+15
	ANDI R30,LOW(0x3)
	CLR  R31
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(3)
	CALL __LSLD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+15
	ANDI R30,LOW(0xE0)
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __ADDD12
	__ADDD1N 1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __MULD12U
_0x202010A:
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R16,LOW(0)
_0x20200EA:
_0x20200E9:
_0x20200E8:
	RJMP _0x20200D1
_0x20200DB:
	CPI  R30,LOW(0xA)
	BRNE _0x20200ED
	LDS  R30,_card_type_G101
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ST   X,R30
	LDI  R16,LOW(0)
	RJMP _0x20200D1
_0x20200ED:
	CPI  R30,LOW(0xB)
	BRNE _0x20200EE
	LDI  R19,LOW(73)
	RJMP _0x20200EF
_0x20200EE:
	CPI  R30,LOW(0xC)
	BRNE _0x20200F1
	LDI  R19,LOW(74)
_0x20200EF:
	ST   -Y,R19
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200F2
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200F3
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(15)
	RCALL _crc7_G101
	MOV  R26,R30
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	LDD  R30,Z+15
	CP   R30,R26
	BRNE _0x20200F4
	LDI  R16,LOW(0)
_0x20200F4:
_0x20200F3:
_0x20200F2:
	RJMP _0x20200D1
_0x20200F1:
	CPI  R30,LOW(0xD)
	BRNE _0x20200F5
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200F6
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	RCALL _rx_spi4_G101
	LDI  R16,LOW(0)
_0x20200F6:
	RJMP _0x20200D1
_0x20200F5:
	CPI  R30,LOW(0xE)
	BRNE _0x20200FD
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200F8
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x20200F9:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x20200F9
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(64)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200FC
	LDI  R16,LOW(0)
_0x20200FC:
_0x20200F8:
	RJMP _0x20200D1
_0x20200FD:
	LDI  R16,LOW(4)
_0x20200D1:
	RCALL _deselect_card_G101
	MOV  R30,R16
_0x20E0017:
	CALL __LOADLOCR4
	ADIW R28,24
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
_0x20E0016:
	LD   R16,Y+
	RET
; .FEND

	.CSEG
_get_fattime:
; .FSTART _get_fattime
	SBIW R28,7
	LDS  R26,_prtc_get_time
	LDS  R27,_prtc_get_time+1
	SBIW R26,0
	BREQ _0x2040004
	LDS  R26,_prtc_get_date
	LDS  R27,_prtc_get_date+1
	SBIW R26,0
	BRNE _0x2040003
_0x2040004:
	__GETD1N 0x3A210000
	RJMP _0x20E0015
_0x2040003:
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,7
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	__CALL1MN _prtc_get_time,0
	MOVW R30,R28
	ADIW R30,3
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,4
	__CALL1MN _prtc_get_date,0
	LD   R30,Y
	LDD  R31,Y+1
	SUBI R30,LOW(1980)
	SBCI R31,HIGH(1980)
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(25)
	CALL __LSLD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+2
	CALL SUBOPT_0x1E
	LDI  R30,LOW(21)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+3
	LDI  R31,0
	CALL __CWD1
	CALL __LSLD16
	CALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+6
	CALL SUBOPT_0x1E
	LDI  R30,LOW(11)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+5
	CALL SUBOPT_0x1E
	LDI  R30,LOW(5)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+4
	LDI  R31,0
	ASR  R31
	ROR  R30
	CALL __CWD1
	CALL __ORD12
_0x20E0015:
	ADIW R28,7
	RET
; .FEND
_chk_chrf_G102:
; .FSTART _chk_chrf_G102
	ST   -Y,R26
	ST   -Y,R16
_0x2040006:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LPM  R30,Z
	MOV  R16,R30
	CPI  R30,0
	BREQ _0x2040009
	LDD  R30,Y+1
	CP   R30,R16
	BRNE _0x204000A
_0x2040009:
	RJMP _0x2040008
_0x204000A:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
	RJMP _0x2040006
_0x2040008:
	MOV  R30,R16
	LDI  R31,0
	LDD  R16,Y+0
	ADIW R28,4
	RET
; .FEND
_move_window_G102:
; .FSTART _move_window_G102
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R16
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,46
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x20
	CALL SUBOPT_0x21
	CALL __CPD12
	BRNE PC+2
	RJMP _0x204000B
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x204000C
	CALL SUBOPT_0x22
	CPI  R30,0
	BREQ _0x204000D
	LDI  R30,LOW(1)
	RJMP _0x20E0012
_0x204000D:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x23
	MOVW R0,R26
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	MOVW R26,R0
	CALL __ADDD12
	CALL SUBOPT_0x21
	CALL __CPD21
	BRSH _0x204000E
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R16,Z+3
_0x2040010:
	CPI  R16,2
	BRLO _0x2040011
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	CALL SUBOPT_0x21
	CALL __ADDD12
	__PUTD1S 1
	CALL SUBOPT_0x22
	SUBI R16,1
	RJMP _0x2040010
_0x2040011:
_0x204000E:
_0x204000C:
	CALL SUBOPT_0x20
	CALL __CPD10
	BREQ _0x2040012
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,50
	CALL SUBOPT_0x24
	BREQ _0x2040013
	LDI  R30,LOW(1)
	RJMP _0x20E0012
_0x2040013:
	CALL SUBOPT_0x20
	__PUTD1SNS 9,46
_0x2040012:
_0x204000B:
	LDI  R30,LOW(0)
	RJMP _0x20E0012
; .FEND
_sync_G102:
; .FSTART _sync_G102
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R16
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x25
	MOV  R16,R30
	CPI  R16,0
	BREQ PC+2
	RJMP _0x2040014
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R26,X
	CPI  R26,LOW(0x3)
	BRNE _0x2040016
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LDD  R30,Z+5
	CPI  R30,0
	BRNE _0x2040017
_0x2040016:
	RJMP _0x2040015
_0x2040017:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL SUBOPT_0x26
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x27
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	SUBI R30,LOW(-510)
	SBCI R31,HIGH(-510)
	LDI  R26,LOW(43605)
	LDI  R27,HIGH(43605)
	STD  Z+0,R26
	STD  Z+1,R27
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	__GETD2N 0x41615252
	CALL SUBOPT_0x28
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	__GETD2N 0x61417272
	CALL SUBOPT_0x28
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,14
	CALL SUBOPT_0x29
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,10
	CALL SUBOPT_0x29
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x2A
	RCALL _disk_write
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040015:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RCALL _disk_ioctl
	CPI  R30,0
	BREQ _0x2040018
	LDI  R16,LOW(1)
_0x2040018:
_0x2040014:
	MOV  R30,R16
_0x20E0014:
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
_get_fat:
; .FSTART _get_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR4
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x2C
	BRLO _0x204001A
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x2B
	CALL __CPD21
	BRLO _0x2040019
_0x204001A:
	CALL SUBOPT_0x2D
	RJMP _0x20E0013
_0x2040019:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,34
	CALL SUBOPT_0x2E
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x204001F
	__GETWRS 18,19,8
	MOVW R30,R18
	LSR  R31
	ROR  R30
	__ADDWRR 18,19,30,31
	CALL SUBOPT_0x2F
	BREQ _0x2040020
	RJMP _0x204001E
_0x2040020:
	CALL SUBOPT_0x30
	LD   R16,X
	CLR  R17
	__ADDWRN 18,19,1
	CALL SUBOPT_0x2F
	BRNE _0x204001E
	CALL SUBOPT_0x30
	LD   R30,X
	MOV  R31,R30
	LDI  R30,0
	__ORWRR 16,17,30,31
	LDD  R30,Y+8
	ANDI R30,LOW(0x1)
	BREQ _0x2040022
	MOVW R30,R16
	CALL __LSRW4
	RJMP _0x204027A
_0x2040022:
	MOVW R30,R16
	ANDI R31,HIGH(0xFFF)
_0x204027A:
	CLR  R22
	CLR  R23
	RJMP _0x20E0013
_0x204001F:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2040025
	CALL SUBOPT_0x31
	CALL SUBOPT_0x32
	CALL SUBOPT_0x33
	BRNE _0x204001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0x34
	CALL SUBOPT_0x35
	RJMP _0x20E0013
_0x2040025:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x204001E
	CALL SUBOPT_0x31
	CALL SUBOPT_0x36
	CALL SUBOPT_0x33
	BRNE _0x204001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0x34
	CALL __GETD1P
	__ANDD1N 0xFFFFFFF
	RJMP _0x20E0013
_0x204001E:
	CALL SUBOPT_0x37
_0x20E0013:
	CALL __LOADLOCR4
	ADIW R28,14
	RET
; .FEND
_put_fat:
; .FSTART _put_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR5
	CALL SUBOPT_0x38
	CALL SUBOPT_0x2C
	BRLO _0x204002A
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	ADIW R26,30
	CALL SUBOPT_0x39
	BRLO _0x2040029
_0x204002A:
	LDI  R20,LOW(2)
	RJMP _0x204002C
_0x2040029:
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	ADIW R26,34
	CALL __GETD1P
	CALL SUBOPT_0x3A
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x2040030
	__GETWRS 16,17,13
	MOVW R30,R16
	LSR  R31
	ROR  R30
	__ADDWRR 16,17,30,31
	CALL SUBOPT_0x3B
	BREQ _0x2040031
	RJMP _0x204002F
_0x2040031:
	CALL SUBOPT_0x3C
	BREQ _0x2040032
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LDD  R30,Y+9
	LDI  R31,0
	CALL __LSLW4
	OR   R30,R26
	RJMP _0x2040033
_0x2040032:
	LDD  R30,Y+9
_0x2040033:
	MOVW R26,R18
	ST   X,R30
	__ADDWRN 16,17,1
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	CALL SUBOPT_0x3B
	BREQ _0x2040035
	RJMP _0x204002F
_0x2040035:
	CALL SUBOPT_0x3C
	BREQ _0x2040036
	CALL SUBOPT_0x3D
	LDI  R30,LOW(4)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	RJMP _0x2040037
_0x2040036:
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF0)
	MOV  R1,R30
	CALL SUBOPT_0x3D
	LDI  R30,LOW(8)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	ANDI R30,LOW(0xF)
	OR   R30,R1
_0x2040037:
	MOVW R26,R18
	ST   X,R30
	RJMP _0x204002F
_0x2040030:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2040039
	CALL SUBOPT_0x3E
	CALL SUBOPT_0x32
	CALL SUBOPT_0x3F
	BRNE _0x204002F
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0x40
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	STD  Z+0,R26
	STD  Z+1,R27
	RJMP _0x204002F
_0x2040039:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x204003D
	CALL SUBOPT_0x3E
	CALL SUBOPT_0x36
	CALL SUBOPT_0x3F
	BRNE _0x204002F
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0x40
	CALL SUBOPT_0x3D
	CALL __PUTDZ20
	RJMP _0x204002F
_0x204003D:
	LDI  R20,LOW(2)
_0x204002F:
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
_0x204002C:
	MOV  R30,R20
	CALL __LOADLOCR5
	ADIW R28,19
	RET
; .FEND
_remove_chain_G102:
; .FSTART _remove_chain_G102
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R16
	CALL SUBOPT_0x41
	CALL SUBOPT_0x2C
	BRLO _0x204003F
	CALL SUBOPT_0x42
	BRLO _0x204003E
_0x204003F:
	LDI  R16,LOW(2)
	RJMP _0x2040041
_0x204003E:
	LDI  R16,LOW(0)
_0x2040042:
	CALL SUBOPT_0x42
	BRLO PC+2
	RJMP _0x2040044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 7
	RCALL _get_fat
	__PUTD1S 1
	CALL SUBOPT_0x43
	CALL __CPD10
	BREQ _0x2040044
	CALL SUBOPT_0x21
	CALL SUBOPT_0x44
	BRNE _0x2040046
	LDI  R16,LOW(2)
	RJMP _0x2040044
_0x2040046:
	CALL SUBOPT_0x21
	CALL SUBOPT_0x45
	BRNE _0x2040047
	LDI  R16,LOW(1)
	RJMP _0x2040044
_0x2040047:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x46
	CALL __PUTPARD1
	CALL SUBOPT_0x47
	RCALL _put_fat
	MOV  R16,R30
	CPI  R16,0
	BRNE _0x2040044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x48
	BREQ _0x2040049
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CALL SUBOPT_0x49
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,5
	LDI  R30,LOW(1)
	ST   X,R30
_0x2040049:
	CALL SUBOPT_0x43
	CALL SUBOPT_0x3A
	RJMP _0x2040042
_0x2040044:
_0x2040041:
	MOV  R30,R16
_0x20E0012:
	LDD  R16,Y+0
	ADIW R28,11
	RET
; .FEND
_create_chain_G102:
; .FSTART _create_chain_G102
	CALL __PUTPARD2
	SBIW R28,16
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x4B
	CALL __CPD10
	BRNE _0x204004A
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,10
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x4C
	CALL __CPD02
	BREQ _0x204004C
	CALL SUBOPT_0x4D
	CALL SUBOPT_0x4C
	CALL __CPD21
	BRLO _0x204004B
_0x204004C:
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x4E
_0x204004B:
	RJMP _0x204004E
_0x204004A:
	CALL SUBOPT_0x4F
	__GETD2S 18
	CALL SUBOPT_0x50
	CALL SUBOPT_0x51
	CALL SUBOPT_0x2C
	BRSH _0x204004F
	CALL SUBOPT_0x2D
	RJMP _0x20E0011
_0x204004F:
	CALL SUBOPT_0x4D
	CALL SUBOPT_0x51
	CALL __CPD21
	BRSH _0x2040050
	CALL SUBOPT_0x52
	RJMP _0x20E0011
_0x2040050:
	CALL SUBOPT_0x4B
	CALL SUBOPT_0x4E
_0x204004E:
	CALL SUBOPT_0x53
	CALL SUBOPT_0x54
_0x2040052:
	CALL SUBOPT_0x55
	__SUBD1N -1
	CALL SUBOPT_0x54
	CALL SUBOPT_0x4D
	CALL SUBOPT_0x2B
	CALL __CPD21
	BRLO _0x2040054
	__GETD1N 0x2
	CALL SUBOPT_0x54
	CALL SUBOPT_0x56
	BRSH _0x2040055
	CALL SUBOPT_0x57
	RJMP _0x20E0011
_0x2040055:
_0x2040054:
	CALL SUBOPT_0x4F
	__GETD2S 10
	CALL SUBOPT_0x50
	CALL SUBOPT_0x52
	CALL __CPD10
	BREQ _0x2040053
	CALL SUBOPT_0x51
	CALL SUBOPT_0x45
	BREQ _0x2040058
	CALL SUBOPT_0x51
	CALL SUBOPT_0x44
	BRNE _0x2040057
_0x2040058:
	CALL SUBOPT_0x52
	RJMP _0x20E0011
_0x2040057:
	CALL SUBOPT_0x56
	BRNE _0x204005A
	CALL SUBOPT_0x57
	RJMP _0x20E0011
_0x204005A:
	RJMP _0x2040052
_0x2040053:
	CALL SUBOPT_0x4F
	CALL SUBOPT_0x58
	__GETD2N 0xFFFFFFF
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x204005B
	CALL SUBOPT_0x37
	RJMP _0x20E0011
_0x204005B:
	CALL SUBOPT_0x4B
	CALL __CPD10
	BREQ _0x204005C
	CALL SUBOPT_0x4F
	__GETD1S 18
	CALL __PUTPARD1
	__GETD2S 14
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x204005D
	CALL SUBOPT_0x37
	RJMP _0x20E0011
_0x204005D:
_0x204005C:
	CALL SUBOPT_0x55
	__PUTD1SNS 20,10
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	CALL SUBOPT_0x48
	BREQ _0x204005E
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,14
	CALL __GETD1P_INC
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	CALL __PUTDP1_DEC
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,5
	LDI  R30,LOW(1)
	ST   X,R30
_0x204005E:
	CALL SUBOPT_0x55
_0x20E0011:
	ADIW R28,22
	RET
; .FEND
_clust2sect:
; .FSTART _clust2sect
	CALL __PUTPARD2
	CALL SUBOPT_0x4D
	__SUBD1N 2
	CALL SUBOPT_0x4A
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	__GETD2Z 30
	__GETD1N 0x2
	CALL SUBOPT_0x59
	CALL __GETD2S0
	CALL __CPD21
	BRLO _0x204005F
	CALL SUBOPT_0x57
	RJMP _0x20E000C
_0x204005F:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R30,Z+2
	LDI  R31,0
	CALL __GETD2S0
	CALL __CWD1
	CALL __MULD12U
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,42
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	RJMP _0x20E000C
; .FEND
_dir_seek_G102:
; .FSTART _dir_seek_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x5A
	ADIW R26,6
	CALL SUBOPT_0x5B
	CALL SUBOPT_0x5C
	CALL SUBOPT_0x44
	BREQ _0x2040061
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x5E
	BRLO _0x2040060
_0x2040061:
	LDI  R30,LOW(2)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0010
_0x2040060:
	CALL SUBOPT_0x5F
	BRNE _0x2040064
	CALL SUBOPT_0x5D
	LD   R26,Z
	CPI  R26,LOW(0x3)
	BREQ _0x2040065
_0x2040064:
	RJMP _0x2040063
_0x2040065:
	CALL SUBOPT_0x5D
	ADIW R30,38
	MOVW R26,R30
	CALL SUBOPT_0x5B
_0x2040063:
	CALL SUBOPT_0x5F
	BRNE _0x2040066
	CALL SUBOPT_0x60
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2040067
	LDI  R30,LOW(2)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0010
_0x2040067:
	CALL SUBOPT_0x5D
	ADIW R30,38
	MOVW R26,R30
	CALL __GETD1P
	RJMP _0x204027B
_0x2040066:
	CALL SUBOPT_0x5D
	LDD  R30,Z+2
	LDI  R26,LOW(16)
	MUL  R30,R26
	MOVW R16,R0
_0x2040069:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R16
	CPC  R27,R17
	BRLO _0x204006B
	CALL SUBOPT_0x5D
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x4C
	RCALL _get_fat
	__PUTD1S 2
	CALL SUBOPT_0x5C
	CALL SUBOPT_0x45
	BRNE _0x204006C
	LDI  R30,LOW(1)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0010
_0x204006C:
	CALL SUBOPT_0x5C
	CALL SUBOPT_0x2C
	BRLO _0x204006E
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x5E
	BRLO _0x204006D
_0x204006E:
	LDI  R30,LOW(2)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0010
_0x204006D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUB  R30,R16
	SBC  R31,R17
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2040069
_0x204006B:
	CALL SUBOPT_0x60
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x4C
	RCALL _clust2sect
_0x204027B:
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __LSRW4
	CALL SUBOPT_0x61
	CALL SUBOPT_0x62
	CALL SUBOPT_0x5D
	ADIW R30,50
	MOVW R26,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x63
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0010
; .FEND
_dir_next_G102:
; .FSTART _dir_next_G102
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR3
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,4
	CALL __GETW1P
	ADIW R30,1
	MOVW R16,R30
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2040071
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,14
	CALL SUBOPT_0x64
	BRNE _0x2040070
_0x2040071:
	LDI  R30,LOW(4)
	RJMP _0x20E000F
_0x2040070:
	MOVW R30,R16
	ANDI R30,LOW(0xF)
	BREQ PC+2
	RJMP _0x2040073
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CALL SUBOPT_0x49
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,10
	CALL SUBOPT_0x64
	BRNE _0x2040074
	CALL SUBOPT_0x5D
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	CP   R16,R30
	CPC  R17,R31
	BRLO _0x2040075
	LDI  R30,LOW(4)
	RJMP _0x20E000F
_0x2040075:
	RJMP _0x2040076
_0x2040074:
	MOVW R30,R16
	CALL __LSRW4
	MOVW R0,R30
	CALL SUBOPT_0x5D
	LDD  R30,Z+2
	LDI  R31,0
	SBIW R30,1
	AND  R30,R0
	AND  R31,R1
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2040077
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x65
	RCALL _get_fat
	CALL SUBOPT_0x66
	CALL SUBOPT_0x67
	CALL SUBOPT_0x2C
	BRSH _0x2040078
	LDI  R30,LOW(2)
	RJMP _0x20E000F
_0x2040078:
	CALL SUBOPT_0x67
	CALL SUBOPT_0x45
	BRNE _0x2040079
	LDI  R30,LOW(1)
	RJMP _0x20E000F
_0x2040079:
	CALL SUBOPT_0x5D
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x67
	CALL __CPD21
	BRSH PC+2
	RJMP _0x204007A
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x204007B
	LDI  R30,LOW(4)
	RJMP _0x20E000F
_0x204007B:
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x65
	RCALL _create_chain_G102
	CALL SUBOPT_0x68
	CALL __CPD10
	BRNE _0x204007C
	LDI  R30,LOW(7)
	RJMP _0x20E000F
_0x204007C:
	CALL SUBOPT_0x67
	CALL SUBOPT_0x44
	BRNE _0x204007D
	LDI  R30,LOW(2)
	RJMP _0x20E000F
_0x204007D:
	CALL SUBOPT_0x67
	CALL SUBOPT_0x45
	BRNE _0x204007E
	LDI  R30,LOW(1)
	RJMP _0x20E000F
_0x204007E:
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x25
	CPI  R30,0
	BREQ _0x204007F
	LDI  R30,LOW(1)
	RJMP _0x20E000F
_0x204007F:
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x27
	CALL SUBOPT_0x5D
	MOVW R26,R30
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R30,R26
	CALL SUBOPT_0x69
	POP  R26
	POP  R27
	CALL __PUTDP1
	LDI  R18,LOW(0)
_0x2040081:
	CALL SUBOPT_0x5D
	LDD  R30,Z+2
	CP   R18,R30
	BRSH _0x2040082
	CALL SUBOPT_0x5D
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x25
	CPI  R30,0
	BREQ _0x2040083
	LDI  R30,LOW(1)
	RJMP _0x20E000F
_0x2040083:
	CALL SUBOPT_0x5D
	ADIW R30,46
	MOVW R26,R30
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
	SUBI R18,-1
	RJMP _0x2040081
_0x2040082:
	CALL SUBOPT_0x5D
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __GETD1P
	MOVW R26,R30
	MOVW R24,R22
	MOV  R30,R18
	LDI  R31,0
	CALL __CWD1
	CALL SUBOPT_0x59
	POP  R26
	POP  R27
	CALL __PUTDP1
_0x204007A:
	__GETD1S 3
	__PUTD1SNS 8,10
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x69
	CALL SUBOPT_0x62
_0x2040077:
_0x2040076:
_0x2040073:
	MOVW R30,R16
	CALL SUBOPT_0x5A
	CALL __GETW1P
	ADIW R30,50
	MOVW R26,R30
	MOVW R30,R16
	CALL SUBOPT_0x63
_0x20E000F:
	CALL __LOADLOCR3
_0x20E0010:
	ADIW R28,10
	RET
; .FEND
_dir_find_G102:
; .FSTART _dir_find_G102
	CALL SUBOPT_0x6A
	BREQ _0x2040084
	MOV  R30,R16
	CALL __LOADLOCR4
	RJMP _0x20E000C
_0x2040084:
_0x2040086:
	CALL SUBOPT_0x6B
	BRNE _0x2040087
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	MOVW R26,R18
	LD   R17,X
	CPI  R17,0
	BRNE _0x2040089
	LDI  R16,LOW(4)
	RJMP _0x2040087
_0x2040089:
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x8)
	BRNE _0x204008B
	CALL SUBOPT_0x6C
	CALL _memcmp
	CPI  R30,0
	BREQ _0x204008C
_0x204008B:
	RJMP _0x204008A
_0x204008C:
	RJMP _0x2040087
_0x204008A:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _dir_next_G102
	MOV  R16,R30
	CPI  R16,0
	BREQ _0x2040086
_0x2040087:
	MOV  R30,R16
	CALL __LOADLOCR4
	RJMP _0x20E000C
; .FEND
_dir_register_G102:
; .FSTART _dir_register_G102
	CALL SUBOPT_0x6A
	BRNE _0x2040099
_0x204009B:
	CALL SUBOPT_0x6B
	BRNE _0x204009C
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Z+18
	LDD  R27,Z+19
	LD   R17,X
	CPI  R17,229
	BREQ _0x204009F
	CPI  R17,0
	BRNE _0x204009E
_0x204009F:
	RJMP _0x204009C
_0x204009E:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _dir_next_G102
	MOV  R16,R30
	CPI  R16,0
	BREQ _0x204009B
_0x204009C:
_0x2040099:
	CPI  R16,0
	BRNE _0x20400A1
	CALL SUBOPT_0x6B
	BRNE _0x20400A2
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	ST   -Y,R19
	ST   -Y,R18
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(32)
	LDI  R27,0
	CALL _memset
	CALL SUBOPT_0x6C
	CALL _memcpy
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,20
	CALL __GETW1P
	LDD  R30,Z+11
	ANDI R30,LOW(0x18)
	__PUTB1RNS 18,12
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
_0x20400A2:
_0x20400A1:
	MOV  R30,R16
	CALL __LOADLOCR4
	RJMP _0x20E000C
; .FEND
_create_name_G102:
; .FSTART _create_name_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,5
	CALL __SAVELOCR6
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	ADIW R26,20
	LD   R19,X+
	LD   R20,X
	ST   -Y,R20
	ST   -Y,R19
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R26,LOW(11)
	LDI  R27,0
	CALL _memset
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOV  R16,R30
	MOV  R21,R30
	LDI  R30,LOW(8)
	STD  Y+10,R30
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x6E
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x2E)
	BRNE _0x20400A5
_0x20400A7:
	CALL SUBOPT_0x6F
	CPI  R17,46
	BRNE _0x20400AA
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,3
	BRLT _0x20400A9
_0x20400AA:
	RJMP _0x20400A8
_0x20400A9:
	CALL SUBOPT_0x70
	RJMP _0x20400A7
_0x20400A8:
	CPI  R17,47
	BREQ _0x20400AD
	CPI  R17,92
	BREQ _0x20400AD
	CPI  R17,33
	BRSH _0x20400AE
_0x20400AD:
	RJMP _0x20400AC
_0x20400AE:
	LDI  R30,LOW(6)
	RJMP _0x20E000D
_0x20400AC:
	CALL SUBOPT_0x6E
	CALL SUBOPT_0x71
	BRSH _0x20400AF
	LDI  R30,LOW(36)
	RJMP _0x20400B0
_0x20400AF:
	LDI  R30,LOW(32)
_0x20400B0:
	__PUTB1RONS 19,20,11
	RJMP _0x20E000E
_0x20400A5:
_0x20400B3:
	CALL SUBOPT_0x6F
	CPI  R17,33
	BRLO _0x20400B6
	CPI  R17,47
	BREQ _0x20400B6
	CPI  R17,92
	BRNE _0x20400B5
_0x20400B6:
	RJMP _0x20400B4
_0x20400B5:
	CPI  R17,46
	BREQ _0x20400B9
	LDD  R30,Y+10
	CP   R21,R30
	BRLO _0x20400B8
_0x20400B9:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20400BC
	CPI  R17,46
	BREQ _0x20400BB
_0x20400BC:
	LDI  R30,LOW(6)
	RJMP _0x20E000D
_0x20400BB:
	LDI  R21,LOW(8)
	LDI  R30,LOW(11)
	STD  Y+10,R30
	LSL  R16
	LSL  R16
	RJMP _0x20400B2
_0x20400B8:
	CPI  R17,128
	BRLO _0x20400BE
	ORI  R16,LOW(3)
	LDI  R30,LOW(6)
	RJMP _0x20E000D
_0x20400BE:
	LDI  R30,LOW(_k1*2)
	LDI  R31,HIGH(_k1*2)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R17
	RCALL _chk_chrf_G102
	SBIW R30,0
	BREQ _0x20400C4
	LDI  R30,LOW(6)
	RJMP _0x20E000D
_0x20400C4:
	CPI  R17,65
	BRLO _0x20400C6
	CPI  R17,91
	BRLO _0x20400C7
_0x20400C6:
	RJMP _0x20400C5
_0x20400C7:
	ORI  R16,LOW(2)
	RJMP _0x20400C8
_0x20400C5:
	CPI  R17,97
	BRLO _0x20400CA
	CPI  R17,123
	BRLO _0x20400CB
_0x20400CA:
	RJMP _0x20400C9
_0x20400CB:
	ORI  R16,LOW(1)
	SUBI R17,LOW(32)
_0x20400C9:
_0x20400C8:
	CALL SUBOPT_0x70
_0x20400B2:
	RJMP _0x20400B3
_0x20400B4:
	CALL SUBOPT_0x6E
	CALL SUBOPT_0x71
	BRSH _0x20400CC
	LDI  R30,LOW(4)
	RJMP _0x20400CD
_0x20400CC:
	LDI  R30,LOW(0)
_0x20400CD:
	MOV  R17,R30
	CPI  R21,0
	BRNE _0x20400CF
	LDI  R30,LOW(6)
	RJMP _0x20E000D
_0x20400CF:
	__GETW2R 19,20
	LD   R26,X
	CPI  R26,LOW(0xE5)
	BRNE _0x20400D0
	__GETW2R 19,20
	LDI  R30,LOW(5)
	ST   X,R30
_0x20400D0:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20400D1
	LSL  R16
	LSL  R16
_0x20400D1:
	MOV  R30,R16
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x1)
	BRNE _0x20400D2
	ORI  R17,LOW(16)
_0x20400D2:
	MOV  R30,R16
	ANDI R30,LOW(0xC)
	CPI  R30,LOW(0x4)
	BRNE _0x20400D3
	ORI  R17,LOW(8)
_0x20400D3:
	__GETW1R 19,20
	__PUTBZR 17,11
_0x20E000E:
	LDI  R30,LOW(0)
_0x20E000D:
	CALL __LOADLOCR6
	ADIW R28,15
	RET
; .FEND
_follow_path_G102:
; .FSTART _follow_path_G102
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
_0x20400E9:
	LDI  R30,LOW(1)
	CPI  R30,0
	BREQ _0x20400EC
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x20)
	BREQ _0x20400ED
_0x20400EC:
	RJMP _0x20400EB
_0x20400ED:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	RJMP _0x20400E9
_0x20400EB:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x2F)
	BREQ _0x20400EF
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x5C)
	BRNE _0x20400EE
_0x20400EF:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,6
	CALL SUBOPT_0x72
	RJMP _0x20400F1
_0x20400EE:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL __GETW1P
	ADIW R30,22
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x73
_0x20400F1:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CLR  R27
	SBIW R26,32
	BRSH _0x20400F2
	CALL SUBOPT_0x74
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _dir_seek_G102
	MOV  R16,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	CALL SUBOPT_0x75
	RJMP _0x20400F3
_0x20400F2:
_0x20400F5:
	CALL SUBOPT_0x74
	MOVW R26,R28
	ADIW R26,6
	RCALL _create_name_G102
	MOV  R16,R30
	CPI  R16,0
	BRNE _0x20400F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL _dir_find_G102
	MOV  R16,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,20
	CALL __GETW1P
	LDD  R30,Z+11
	ANDI R30,LOW(0x4)
	MOV  R19,R30
	CPI  R16,0
	BREQ _0x20400F8
	CPI  R16,4
	BRNE _0x20400FA
	CPI  R19,0
	BREQ _0x20400FB
_0x20400FA:
	RJMP _0x20400F9
_0x20400FB:
	LDI  R16,LOW(5)
_0x20400F9:
	RJMP _0x20400F6
_0x20400F8:
	CPI  R19,0
	BRNE _0x20400F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	LD   R17,X+
	LD   R18,X
	__GETW1R 17,18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BRNE _0x20400FD
	LDI  R16,LOW(5)
	RJMP _0x20400F6
_0x20400FD:
	CALL SUBOPT_0x76
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x77
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x78
	CALL SUBOPT_0x73
	RJMP _0x20400F5
_0x20400F6:
_0x20400F3:
	MOV  R30,R16
	CALL __LOADLOCR4
	ADIW R28,8
	RET
; .FEND
_check_fs_G102:
; .FSTART _check_fs_G102
	CALL __PUTPARD2
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 3
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	BREQ _0x20400FE
	LDI  R30,LOW(3)
	RJMP _0x20E000C
_0x20400FE:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x79
	BREQ _0x20400FF
	LDI  R30,LOW(2)
	RJMP _0x20E000C
_0x20400FF:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SUBI R26,LOW(-104)
	SBCI R27,HIGH(-104)
	CALL SUBOPT_0x7A
	BRNE _0x2040100
	LDI  R30,LOW(0)
	RJMP _0x20E000C
_0x2040100:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,50
	SUBI R30,LOW(-82)
	SBCI R31,HIGH(-82)
	MOVW R26,R30
	CALL SUBOPT_0x7A
	BRNE _0x2040101
	LDI  R30,LOW(0)
	RJMP _0x20E000C
_0x2040101:
	LDI  R30,LOW(1)
_0x20E000C:
	ADIW R28,6
	RET
; .FEND
_chk_mounted:
; .FSTART _chk_mounted
	ST   -Y,R26
	SBIW R28,20
	CALL __SAVELOCR5
	LDD  R26,Y+28
	LDD  R27,Y+28+1
	CALL __GETW1P
	STD  Y+7,R30
	STD  Y+7+1,R31
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LD   R30,X
	SUBI R30,LOW(48)
	MOV  R19,R30
	CPI  R19,10
	BRSH _0x2040103
	ADIW R26,1
	LD   R26,X
	CPI  R26,LOW(0x3A)
	BREQ _0x2040104
_0x2040103:
	RJMP _0x2040102
_0x2040104:
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,2
	STD  Y+7,R30
	STD  Y+7+1,R31
	LDD  R26,Y+28
	LDD  R27,Y+28+1
	ST   X+,R30
	ST   X,R31
	RJMP _0x2040105
_0x2040102:
	LDS  R19,_Drive_G102
_0x2040105:
	CPI  R19,1
	BRLO _0x2040106
	LDI  R30,LOW(11)
	RJMP _0x20E000A
_0x2040106:
	MOV  R30,R19
	CALL SUBOPT_0x7B
	CALL __GETW1P
	STD  Y+5,R30
	STD  Y+5+1,R31
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ST   X+,R30
	ST   X,R31
	SBIW R30,0
	BRNE _0x2040107
	LDI  R30,LOW(12)
	RJMP _0x20E000A
_0x2040107:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2040108
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LDD  R26,Z+1
	CALL _disk_status
	MOV  R20,R30
	SBRC R20,0
	RJMP _0x2040109
	LDD  R30,Y+25
	CPI  R30,0
	BREQ _0x204010B
	SBRC R20,2
	RJMP _0x204010C
_0x204010B:
	RJMP _0x204010A
_0x204010C:
	LDI  R30,LOW(10)
	RJMP _0x20E000A
_0x204010A:
	RJMP _0x20E000B
_0x2040109:
_0x2040108:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOV  R30,R19
	__PUTB1SNS 5,1
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LDD  R26,Z+1
	CALL _disk_initialize
	MOV  R20,R30
	SBRS R20,0
	RJMP _0x204010D
	LDI  R30,LOW(3)
	RJMP _0x20E000A
_0x204010D:
	LDD  R30,Y+25
	CPI  R30,0
	BREQ _0x204010F
	SBRC R20,2
	RJMP _0x2040110
_0x204010F:
	RJMP _0x204010E
_0x2040110:
	LDI  R30,LOW(10)
	RJMP _0x20E000A
_0x204010E:
	CALL SUBOPT_0x9
	CALL SUBOPT_0x57
	__PUTD1S 23
	MOVW R26,R30
	MOVW R24,R22
	RCALL _check_fs_G102
	MOV  R16,R30
	CPI  R16,1
	BRNE _0x2040111
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,50
	SUBI R30,LOW(-446)
	SBCI R31,HIGH(-446)
	__PUTW1R 17,18
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x2040112
	__GETW2R 17,18
	ADIW R26,8
	CALL __GETD1P
	__PUTD1S 21
	CALL SUBOPT_0x9
	__GETD2S 23
	RCALL _check_fs_G102
	MOV  R16,R30
_0x2040112:
_0x2040111:
	CPI  R16,3
	BRNE _0x2040113
	LDI  R30,LOW(1)
	RJMP _0x20E000A
_0x2040113:
	CPI  R16,0
	BRNE _0x2040115
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADIW R26,61
	CALL __GETW1P
	CPI  R30,LOW(0x200)
	LDI  R26,HIGH(0x200)
	CPC  R31,R26
	BREQ _0x2040114
_0x2040115:
	LDI  R30,LOW(13)
	RJMP _0x20E000A
_0x2040114:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-72)
	SBCI R27,HIGH(-72)
	CALL SUBOPT_0x35
	CALL SUBOPT_0x7C
	CALL SUBOPT_0x7D
	CALL __CPD10
	BRNE _0x2040117
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-86)
	SBCI R27,HIGH(-86)
	CALL __GETD1P
	CALL SUBOPT_0x7C
_0x2040117:
	CALL SUBOPT_0x7D
	__PUTD1SNS 5,26
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-66)
	SBCI R31,HIGH(-66)
	LD   R30,Z
	__PUTB1SNS 5,3
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LDD  R30,Z+3
	LDI  R31,0
	CALL SUBOPT_0x7E
	CALL __CWD1
	CALL __MULD12U
	CALL SUBOPT_0x7C
	CALL SUBOPT_0x7F
	CALL SUBOPT_0x80
	__PUTD1SNS 5,34
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LDD  R30,Z+63
	__PUTB1SNS 5,2
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-67)
	SBCI R27,HIGH(-67)
	CALL __GETW1P
	__PUTW1SNS 5,8
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-69)
	SBCI R27,HIGH(-69)
	CALL SUBOPT_0x35
	CALL SUBOPT_0x81
	CALL SUBOPT_0x82
	BRNE _0x2040118
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-82)
	SBCI R27,HIGH(-82)
	CALL SUBOPT_0x83
_0x2040118:
	CALL SUBOPT_0x7F
	CALL SUBOPT_0x38
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x59
	CALL SUBOPT_0x7E
	CALL __SUBD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x84
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CLR  R22
	CLR  R23
	CALL __SUBD21
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LDD  R30,Z+2
	LDI  R31,0
	CALL __CWD1
	CALL __DIVD21U
	__ADDD1N 2
	__PUTD1S 9
	__PUTD1SNS 5,30
	LDI  R16,LOW(1)
	CALL SUBOPT_0x3D
	__CPD2N 0xFF7
	BRLO _0x2040119
	LDI  R16,LOW(2)
_0x2040119:
	CALL SUBOPT_0x3D
	__CPD2N 0xFFF7
	BRLO _0x204011A
	LDI  R16,LOW(3)
_0x204011A:
	CPI  R16,3
	BRNE _0x204011B
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-94)
	SBCI R27,HIGH(-94)
	CALL __GETD1P
	RJMP _0x204027C
_0x204011B:
	CALL SUBOPT_0x85
_0x204027C:
	__PUTD1SNS 5,38
	CALL SUBOPT_0x85
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x84
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x61
	__PUTD1SNS 5,42
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADIW R26,14
	CALL SUBOPT_0x37
	CALL __PUTDP1
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	CPI  R16,3
	BREQ PC+2
	RJMP _0x204011D
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADIW R26,5
	ST   X,R30
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-98)
	SBCI R27,HIGH(-98)
	CALL __GETW1P
	CALL SUBOPT_0x80
	__PUTD1SNS 5,18
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	CALL SUBOPT_0x2A
	CALL _disk_read
	CPI  R30,0
	BRNE _0x204011F
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	CALL SUBOPT_0x79
	BRNE _0x204011F
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADIW R26,50
	CALL __GETD1P
	__CPD1N 0x41615252
	BRNE _0x204011F
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,50
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	MOVW R26,R30
	CALL __GETD1P
	__CPD1N 0x61417272
	BREQ _0x2040120
_0x204011F:
	RJMP _0x204011E
_0x2040120:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 5,10
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,50
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 5,14
_0x204011E:
_0x204011D:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ST   X,R16
	CALL SUBOPT_0x26
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADIW R26,22
	CALL SUBOPT_0x72
	LDI  R26,LOW(_Fsid_G102)
	LDI  R27,HIGH(_Fsid_G102)
	CALL SUBOPT_0x86
	__PUTW1SNS 5,6
_0x20E000B:
	LDI  R30,LOW(0)
_0x20E000A:
	CALL __LOADLOCR5
	ADIW R28,30
	RET
; .FEND
_validate_G102:
; .FSTART _validate_G102
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2040122
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2040122
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+6
	LDD  R27,Z+7
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x2040121
_0x2040122:
	LDI  R30,LOW(9)
	RJMP _0x20E0009
_0x2040121:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+1
	CALL _disk_status
	ANDI R30,LOW(0x1)
	BREQ _0x2040124
	LDI  R30,LOW(3)
	RJMP _0x20E0009
_0x2040124:
	LDI  R30,LOW(0)
_0x20E0009:
	ADIW R28,4
	RET
; .FEND
_f_mount:
; .FSTART _f_mount
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	CPI  R26,LOW(0x1)
	BRLO _0x2040125
	LDI  R30,LOW(11)
	RJMP _0x20E0008
_0x2040125:
	LDD  R30,Y+4
	CALL SUBOPT_0x7B
	LD   R16,X+
	LD   R17,X
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2040126
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040126:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2040127
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040127:
	LDD  R30,Y+4
	LDI  R26,LOW(_FatFs_G102)
	LDI  R27,HIGH(_FatFs_G102)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	STD  Z+0,R26
	STD  Z+1,R27
	LDI  R30,LOW(0)
_0x20E0008:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
_f_open:
; .FSTART _f_open
	ST   -Y,R26
	SBIW R28,34
	CALL __SAVELOCR3
	LDD  R26,Y+40
	LDD  R27,Y+40+1
	CALL SUBOPT_0x75
	LDD  R30,Y+37
	ANDI R30,LOW(0x1F)
	STD  Y+37,R30
	MOVW R30,R28
	ADIW R30,38
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,17
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+41
	ANDI R30,LOW(0x1E)
	MOV  R26,R30
	RCALL _chk_mounted
	MOV  R16,R30
	CPI  R16,0
	BREQ _0x2040128
	RJMP _0x20E0007
_0x2040128:
	MOVW R30,R28
	ADIW R30,3
	STD  Y+35,R30
	STD  Y+35+1,R31
	MOVW R30,R28
	ADIW R30,15
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+40
	LDD  R27,Y+40+1
	RCALL _follow_path_G102
	MOV  R16,R30
	LDD  R30,Y+37
	ANDI R30,LOW(0x1C)
	BRNE PC+2
	RJMP _0x2040129
	SBIW R28,8
	CPI  R16,0
	BREQ _0x204012A
	CPI  R16,4
	BRNE _0x204012B
	MOVW R26,R28
	ADIW R26,23
	RCALL _dir_register_G102
	MOV  R16,R30
_0x204012B:
	CPI  R16,0
	BREQ _0x204012C
	MOV  R30,R16
	ADIW R28,8
	RJMP _0x20E0007
_0x204012C:
	LDD  R30,Y+45
	ORI  R30,8
	STD  Y+45,R30
	__GETWRS 17,18,41
	RJMP _0x204012D
_0x204012A:
	LDD  R30,Y+45
	ANDI R30,LOW(0x4)
	BREQ _0x204012E
	LDI  R30,LOW(8)
	ADIW R28,8
	RJMP _0x20E0007
_0x204012E:
	__GETWRS 17,18,41
	MOV  R0,R17
	OR   R0,R18
	BREQ _0x2040130
	__GETW1R 17,18
	LDD  R30,Z+11
	ANDI R30,LOW(0x11)
	BREQ _0x204012F
_0x2040130:
	LDI  R30,LOW(7)
	ADIW R28,8
	RJMP _0x20E0007
_0x204012F:
	LDD  R30,Y+45
	ANDI R30,LOW(0x8)
	BRNE PC+2
	RJMP _0x2040132
	CALL SUBOPT_0x76
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x77
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x78
	CALL SUBOPT_0x4A
	__GETW1R 17,18
	ADIW R30,20
	CALL SUBOPT_0x87
	ADIW R30,26
	CALL SUBOPT_0x87
	ADIW R30,28
	CALL SUBOPT_0x47
	CALL __PUTDZ20
	LDD  R26,Y+23
	LDD  R27,Y+23+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R26,Y+23
	LDD  R27,Y+23+1
	ADIW R26,46
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x4D
	CALL __CPD10
	BREQ _0x2040133
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x5C
	RCALL _remove_chain_G102
	MOV  R16,R30
	CPI  R16,0
	BREQ _0x2040134
	ADIW R28,8
	RJMP _0x20E0007
_0x2040134:
	CALL SUBOPT_0x4D
	CALL SUBOPT_0x88
	__PUTD1SNS 23,10
_0x2040133:
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 6
	CALL _move_window_G102
	MOV  R16,R30
	CPI  R16,0
	BREQ _0x2040135
	ADIW R28,8
	RJMP _0x20E0007
_0x2040135:
_0x2040132:
_0x204012D:
	LDD  R30,Y+45
	ANDI R30,LOW(0x8)
	BREQ _0x2040136
	__GETW1R 17,18
	ADIW R30,11
	LDI  R26,LOW(0)
	STD  Z+0,R26
	CALL _get_fattime
	CALL SUBOPT_0x4E
	CALL SUBOPT_0x53
	__PUTD1RONS 17,18,14
	LDD  R26,Y+23
	LDD  R27,Y+23+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R30,Y+45
	ORI  R30,0x20
	STD  Y+45,R30
_0x2040136:
	ADIW R28,8
	RJMP _0x2040137
_0x2040129:
	CPI  R16,0
	BREQ _0x2040138
	MOV  R30,R16
	RJMP _0x20E0007
_0x2040138:
	__GETWRS 17,18,33
	MOV  R0,R17
	OR   R0,R18
	BREQ _0x204013A
	__GETW1R 17,18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BREQ _0x2040139
_0x204013A:
	LDI  R30,LOW(4)
	RJMP _0x20E0007
_0x2040139:
	LDD  R30,Y+37
	ANDI R30,LOW(0x2)
	BREQ _0x204013D
	__GETW1R 17,18
	LDD  R30,Z+11
	ANDI R30,LOW(0x1)
	BRNE _0x204013E
_0x204013D:
	RJMP _0x204013C
_0x204013E:
	LDI  R30,LOW(7)
	RJMP _0x20E0007
_0x204013C:
_0x2040137:
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	ADIW R26,46
	CALL __GETD1P
	__PUTD1SNS 40,26
	LDD  R30,Y+33
	LDD  R31,Y+33+1
	__PUTW1SNS 40,30
	LDD  R30,Y+37
	__PUTB1SNS 40,4
	CALL SUBOPT_0x76
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x77
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x78
	__PUTD1SNS 40,14
	__GETW2R 17,18
	ADIW R26,28
	CALL __GETD1P
	__PUTD1SNS 40,10
	LDD  R26,Y+40
	LDD  R27,Y+40+1
	ADIW R26,6
	CALL SUBOPT_0x72
	LDD  R26,Y+40
	LDD  R27,Y+40+1
	ADIW R26,5
	LDI  R30,LOW(255)
	ST   X,R30
	LDD  R26,Y+40
	LDD  R27,Y+40+1
	ADIW R26,22
	CALL SUBOPT_0x72
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	LDD  R26,Y+40
	LDD  R27,Y+40+1
	ST   X+,R30
	ST   X,R31
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	ADIW R26,6
	CALL __GETW1P
	__PUTW1SNS 40,2
	LDI  R30,LOW(0)
_0x20E0007:
	CALL __LOADLOCR3
	ADIW R28,42
	RET
; .FEND
_f_write:
; .FSTART _f_write
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	CALL __SAVELOCR5
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	STD  Y+5,R30
	STD  Y+5+1,R31
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	CALL SUBOPT_0x75
	CALL SUBOPT_0x89
	CALL SUBOPT_0x8A
	CALL SUBOPT_0x8B
	BREQ _0x2040159
	MOV  R30,R16
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x2040159:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x204015A
	LDI  R30,LOW(2)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x204015A:
	CALL SUBOPT_0x8C
	BRNE _0x204015B
	LDI  R30,LOW(7)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x204015B:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	__GETD2Z 10
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	CALL SUBOPT_0x61
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x8D
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x204015C
	LDI  R30,LOW(0)
	STD  Y+17,R30
	STD  Y+17+1,R30
_0x204015C:
_0x204015E:
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	SBIW R30,0
	BRNE PC+2
	RJMP _0x204015F
	CALL SUBOPT_0x8E
	MOVW R30,R26
	MOVW R22,R24
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2040160
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R0,Z+5
	CALL SUBOPT_0x89
	LDD  R30,Z+2
	CP   R0,R30
	BRSH PC+2
	RJMP _0x2040161
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL SUBOPT_0x64
	BRNE _0x2040162
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,14
	CALL __GETD1P
	CALL SUBOPT_0x8F
	CALL SUBOPT_0x90
	BRNE _0x2040163
	CALL SUBOPT_0x89
	CALL SUBOPT_0x91
	CALL SUBOPT_0x8F
	CALL SUBOPT_0x92
_0x2040163:
	RJMP _0x2040164
_0x2040162:
	CALL SUBOPT_0x89
	CALL SUBOPT_0x8A
	__GETD2Z 18
	CALL _create_chain_G102
	CALL SUBOPT_0x8F
_0x2040164:
	CALL SUBOPT_0x90
	BRNE _0x2040165
	RJMP _0x204015F
_0x2040165:
	__GETD2S 11
	CALL SUBOPT_0x44
	BRNE _0x2040166
	CALL SUBOPT_0x93
	LDI  R30,LOW(2)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x2040166:
	__GETD2S 11
	CALL SUBOPT_0x45
	BRNE _0x2040167
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x2040167:
	__GETD1S 11
	CALL SUBOPT_0x94
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040161:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2040168
	CALL SUBOPT_0x89
	CALL SUBOPT_0x95
	CALL SUBOPT_0x96
	BREQ _0x2040169
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x2040169:
	CALL SUBOPT_0x97
_0x2040168:
	CALL SUBOPT_0x89
	CALL SUBOPT_0x8A
	__GETD2Z 18
	RCALL _clust2sect
	__PUTD1S 7
	CALL SUBOPT_0x46
	CALL __CPD10
	BRNE _0x204016A
	CALL SUBOPT_0x93
	LDI  R30,LOW(2)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x204016A:
	CALL SUBOPT_0x98
	__GETD2S 7
	CALL __CWD1
	CALL __ADDD12
	__PUTD1S 7
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	__PUTW1R 19,20
	MOV  R0,R19
	OR   R0,R20
	BRNE PC+2
	RJMP _0x204016B
	CALL SUBOPT_0x98
	ADD  R30,R19
	ADC  R31,R20
	MOVW R0,R30
	CALL SUBOPT_0x89
	LDD  R30,Z+2
	MOVW R26,R0
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x204016C
	CALL SUBOPT_0x89
	LDD  R30,Z+2
	LDI  R31,0
	MOVW R26,R30
	CALL SUBOPT_0x98
	SUB  R26,R30
	SBC  R27,R31
	__PUTW2R 19,20
_0x204016C:
	CALL SUBOPT_0x89
	LDD  R30,Z+1
	ST   -Y,R30
	CALL SUBOPT_0x74
	CALL SUBOPT_0x58
	MOV  R26,R19
	CALL _disk_write
	CPI  R30,0
	BREQ _0x204016D
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x204016D:
	CALL SUBOPT_0x99
	CALL __SUBD21
	__GETW1R 19,20
	CLR  R22
	CLR  R23
	CALL __CPD21
	BRSH _0x204016E
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	ADIW R30,32
	CALL SUBOPT_0x8A
	__GETD2Z 22
	CALL SUBOPT_0x9A
	CALL __SUBD21
	__GETD1N 0x200
	CALL __MULD12U
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CLR  R24
	CLR  R25
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	CALL _memcpy
	CALL SUBOPT_0x97
_0x204016E:
	CALL SUBOPT_0x9B
	ADD  R30,R19
	ST   X,R30
	__GETW1R 19,20
	LSL  R30
	ROL  R31
	MOV  R31,R30
	LDI  R30,0
	__PUTW1R 17,18
	RJMP _0x204015D
_0x204016B:
	CALL SUBOPT_0x99
	CALL __CPD12
	BREQ _0x204016F
	CALL SUBOPT_0x8E
	MOVW R0,R26
	CALL SUBOPT_0x8D
	MOVW R26,R0
	CALL __CPD21
	BRSH _0x2040171
	CALL SUBOPT_0x89
	CALL SUBOPT_0x95
	CALL SUBOPT_0x58
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	BRNE _0x2040172
_0x2040171:
	RJMP _0x2040170
_0x2040172:
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	CALL __LOADLOCR5
	RJMP _0x20E0005
_0x2040170:
_0x204016F:
	CALL SUBOPT_0x46
	CALL SUBOPT_0x9C
	CALL SUBOPT_0x9B
	SUBI R30,-LOW(1)
	ST   X,R30
_0x2040160:
	CALL SUBOPT_0x9D
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	SUB  R26,R30
	SBC  R27,R31
	__PUTW2R 17,18
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	CP   R30,R17
	CPC  R31,R18
	BRSH _0x2040173
	__GETWRS 17,18,17
_0x2040173:
	CALL SUBOPT_0x9D
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,32
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ST   -Y,R31
	ST   -Y,R30
	__GETW2R 17,18
	CALL _memcpy
	CALL SUBOPT_0x9E
	ORI  R30,0x40
	ST   X,R30
_0x204015D:
	__GETW1R 17,18
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+5,R30
	STD  Y+5+1,R31
	CALL SUBOPT_0x9F
	MOVW R26,R30
	MOVW R24,R22
	__GETW1R 17,18
	CALL SUBOPT_0x61
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	LD   R30,X+
	LD   R31,X+
	ADD  R30,R17
	ADC  R31,R18
	ST   -X,R31
	ST   -X,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	SUB  R30,R17
	SBC  R31,R18
	STD  Y+17,R30
	STD  Y+17+1,R31
	RJMP _0x204015E
_0x204015F:
	CALL SUBOPT_0x8E
	MOVW R0,R26
	CALL SUBOPT_0x8D
	MOVW R26,R0
	CALL __CPD12
	BRSH _0x2040174
	CALL SUBOPT_0xA0
	CALL SUBOPT_0xA1
_0x2040174:
	CALL SUBOPT_0x9E
	ORI  R30,0x20
	ST   X,R30
	LDI  R30,LOW(0)
	CALL __LOADLOCR5
	RJMP _0x20E0005
; .FEND
_f_sync:
; .FSTART _f_sync
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR3
	CALL SUBOPT_0xA2
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x8B
	BREQ PC+2
	RJMP _0x2040175
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x20)
	BRNE PC+2
	RJMP _0x2040176
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2040177
	CALL SUBOPT_0xA2
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	__GETD2Z 22
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	CALL _disk_write
	CPI  R30,0
	BREQ _0x2040178
	LDI  R30,LOW(1)
	RJMP _0x20E0006
_0x2040178:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xBF
	ST   X,R30
_0x2040177:
	CALL SUBOPT_0xA2
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	__GETD2Z 26
	CALL _move_window_G102
	MOV  R16,R30
	CPI  R16,0
	BREQ PC+2
	RJMP _0x2040179
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	ADIW R26,30
	LD   R17,X+
	LD   R18,X
	__GETW2R 17,18
	ADIW R26,11
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	ADIW R26,10
	CALL __GETD1P
	__PUTD1RONS 17,18,28
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	ADIW R26,14
	CALL __GETW1P
	__PUTW1RONS 17,18,26
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	__GETD2Z 14
	MOVW R30,R26
	MOVW R22,R24
	CALL __LSRD16
	__PUTW1RONS 17,18,20
	CALL _get_fattime
	CALL SUBOPT_0x68
	__PUTD1RONS 17,18,22
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xDF
	ST   X,R30
	CALL SUBOPT_0xA2
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0xA2
	MOVW R26,R30
	CALL _sync_G102
	MOV  R16,R30
_0x2040179:
_0x2040176:
_0x2040175:
	MOV  R30,R16
_0x20E0006:
	CALL __LOADLOCR3
	ADIW R28,9
	RET
; .FEND
_f_close:
; .FSTART _f_close
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R16
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _f_sync
	MOV  R16,R30
	CPI  R16,0
	BRNE _0x204017A
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL SUBOPT_0x75
_0x204017A:
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
_f_lseek:
; .FSTART _f_lseek
	CALL __PUTPARD2
	SBIW R28,16
	ST   -Y,R16
	CALL SUBOPT_0x89
	CALL SUBOPT_0x8A
	CALL SUBOPT_0x8B
	BREQ _0x2040183
	RJMP _0x20E0004
_0x2040183:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x2040184
	LDI  R30,LOW(2)
	RJMP _0x20E0003
_0x2040184:
	CALL SUBOPT_0x8D
	CALL SUBOPT_0x7E
	CALL __CPD12
	BRSH _0x2040186
	CALL SUBOPT_0x8C
	BREQ _0x2040187
_0x2040186:
	RJMP _0x2040185
_0x2040187:
	CALL SUBOPT_0x8D
	CALL SUBOPT_0x7C
_0x2040185:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x57
	CALL SUBOPT_0x3A
	CALL SUBOPT_0xA3
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,5
	LDI  R30,LOW(255)
	ST   X,R30
	CALL SUBOPT_0x7E
	CALL __CPD02
	BRLO PC+2
	RJMP _0x2040188
	CALL SUBOPT_0x89
	LDD  R30,Z+2
	LDI  R31,0
	CALL __CWD1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 9
	CALL SUBOPT_0x21
	CALL __CPD02
	BRSH _0x204018A
	CALL SUBOPT_0x7D
	CALL SUBOPT_0xA4
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x43
	CALL SUBOPT_0xA4
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x204018B
_0x204018A:
	RJMP _0x2040189
_0x204018B:
	CALL SUBOPT_0x43
	CALL SUBOPT_0x88
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x9A
	CALL SUBOPT_0x88
	CALL __COMD1
	CALL __ANDD12
	CALL SUBOPT_0xA3
	CALL SUBOPT_0xA0
	CALL SUBOPT_0x7E
	CALL __SUBD21
	__PUTD2S 17
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,18
	CALL SUBOPT_0x83
	RJMP _0x204018C
_0x2040189:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,14
	CALL SUBOPT_0x83
	CALL SUBOPT_0x82
	BRNE _0x204018D
	CALL SUBOPT_0x89
	CALL SUBOPT_0x91
	CALL SUBOPT_0x81
	CALL SUBOPT_0x38
	CALL SUBOPT_0x44
	BRNE _0x204018E
	CALL SUBOPT_0x93
	LDI  R30,LOW(2)
	RJMP _0x20E0003
_0x204018E:
	CALL SUBOPT_0x38
	CALL SUBOPT_0x45
	BRNE _0x204018F
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	RJMP _0x20E0003
_0x204018F:
	CALL SUBOPT_0xA5
	CALL SUBOPT_0x92
_0x204018D:
	CALL SUBOPT_0xA5
	CALL SUBOPT_0x94
_0x204018C:
	CALL SUBOPT_0x82
	BRNE PC+2
	RJMP _0x2040190
_0x2040191:
	CALL SUBOPT_0x9A
	CALL SUBOPT_0x7E
	CALL __CPD12
	BRLO PC+2
	RJMP _0x2040193
	CALL SUBOPT_0x8C
	BREQ _0x2040194
	CALL SUBOPT_0x89
	CALL SUBOPT_0xA6
	CALL _create_chain_G102
	CALL SUBOPT_0x81
	CALL SUBOPT_0x82
	BRNE _0x2040195
	CALL SUBOPT_0x9A
	CALL SUBOPT_0x7C
	RJMP _0x2040193
_0x2040195:
	RJMP _0x2040196
_0x2040194:
	CALL SUBOPT_0x89
	CALL SUBOPT_0xA6
	CALL _get_fat
	CALL SUBOPT_0x81
_0x2040196:
	CALL SUBOPT_0x38
	CALL SUBOPT_0x45
	BRNE _0x2040197
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	RJMP _0x20E0003
_0x2040197:
	CALL SUBOPT_0x38
	CALL SUBOPT_0x2C
	BRLO _0x2040199
	CALL SUBOPT_0x89
	ADIW R30,30
	MOVW R26,R30
	CALL SUBOPT_0x39
	BRLO _0x2040198
_0x2040199:
	CALL SUBOPT_0x93
	LDI  R30,LOW(2)
	RJMP _0x20E0003
_0x2040198:
	CALL SUBOPT_0xA5
	CALL SUBOPT_0x94
	CALL SUBOPT_0x9F
	CALL SUBOPT_0x3D
	CALL __ADDD12
	MOVW R26,R0
	CALL __PUTDP1
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x7D
	CALL __SUBD12
	CALL SUBOPT_0x7C
	RJMP _0x2040191
_0x2040193:
	CALL SUBOPT_0x9F
	CALL SUBOPT_0x7E
	CALL __ADDD12
	MOVW R26,R0
	CALL __PUTDP1
	CALL SUBOPT_0x7E
	__GETD1N 0x200
	CALL __DIVD21U
	__PUTB1SNS 21,5
	CALL SUBOPT_0x7D
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ _0x204019B
	CALL SUBOPT_0x89
	CALL SUBOPT_0xA6
	CALL _clust2sect
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x20
	CALL __CPD10
	BRNE _0x204019C
	CALL SUBOPT_0x93
	LDI  R30,LOW(2)
	RJMP _0x20E0003
_0x204019C:
	CALL SUBOPT_0x98
	CALL SUBOPT_0x41
	CALL __CWD1
	CALL __ADDD12
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x9B
	SUBI R30,-LOW(1)
	ST   X,R30
_0x204019B:
_0x2040190:
_0x2040188:
	CALL SUBOPT_0x8E
	MOVW R30,R26
	MOVW R22,R24
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ _0x204019E
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,22
	CALL __GETD1P
	CALL SUBOPT_0x41
	CALL __CPD12
	BRNE _0x204019F
_0x204019E:
	RJMP _0x204019D
_0x204019F:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x20401A0
	CALL SUBOPT_0x89
	CALL SUBOPT_0x95
	CALL SUBOPT_0x96
	BREQ _0x20401A1
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	RJMP _0x20E0003
_0x20401A1:
	CALL SUBOPT_0x97
_0x20401A0:
	CALL SUBOPT_0x89
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0x24
	BREQ _0x20401A2
	CALL SUBOPT_0x93
	LDI  R30,LOW(1)
	RJMP _0x20E0003
_0x20401A2:
	CALL SUBOPT_0x20
	CALL SUBOPT_0x9C
_0x204019D:
	CALL SUBOPT_0x8E
	MOVW R0,R26
	CALL SUBOPT_0x8D
	MOVW R26,R0
	CALL __CPD12
	BRSH _0x20401A3
	CALL SUBOPT_0xA0
	CALL SUBOPT_0xA1
	CALL SUBOPT_0x9E
	ORI  R30,0x20
	ST   X,R30
_0x20401A3:
_0x20E0004:
	MOV  R30,R16
_0x20E0003:
	LDD  R16,Y+0
_0x20E0005:
	ADIW R28,23
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
_put_buff_G103:
; .FSTART _put_buff_G103
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x206002D
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x206002F
	__CPWRN 16,17,2
	BRLO _0x2060030
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x206002F:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL SUBOPT_0x86
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2060030:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2060031
	CALL SUBOPT_0x86
_0x2060031:
	RJMP _0x2060032
_0x206002D:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2060032:
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20E0001
; .FEND
__print_G103:
; .FSTART __print_G103
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL SUBOPT_0x75
_0x2060037:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2060039
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x206003D
	CPI  R19,37
	BRNE _0x206003E
	LDI  R16,LOW(1)
	RJMP _0x206003F
_0x206003E:
	CALL SUBOPT_0xA7
_0x206003F:
	RJMP _0x206003C
_0x206003D:
	CPI  R30,LOW(0x1)
	BRNE _0x2060040
	CPI  R19,37
	BRNE _0x2060041
	CALL SUBOPT_0xA7
	RJMP _0x20600F5
_0x2060041:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x2060042
	LDI  R17,LOW(1)
	RJMP _0x206003C
_0x2060042:
	CPI  R19,43
	BRNE _0x2060043
	LDI  R21,LOW(43)
	RJMP _0x206003C
_0x2060043:
	CPI  R19,32
	BRNE _0x2060044
	LDI  R21,LOW(32)
	RJMP _0x206003C
_0x2060044:
	RJMP _0x2060045
_0x2060040:
	CPI  R30,LOW(0x2)
	BRNE _0x2060046
_0x2060045:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x2060047
	ORI  R17,LOW(128)
	RJMP _0x206003C
_0x2060047:
	RJMP _0x2060048
_0x2060046:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x206003C
_0x2060048:
	CPI  R19,48
	BRLO _0x206004B
	CPI  R19,58
	BRLO _0x206004C
_0x206004B:
	RJMP _0x206004A
_0x206004C:
	LDI  R26,LOW(10)
	MUL  R20,R26
	MOV  R20,R0
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x206003C
_0x206004A:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x2060050
	CALL SUBOPT_0xA8
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0xA9
	RJMP _0x2060051
_0x2060050:
	CPI  R30,LOW(0x73)
	BRNE _0x2060053
	CALL SUBOPT_0xA8
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL SUBOPT_0x6D
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL _strlen
	MOV  R16,R30
	RJMP _0x2060054
_0x2060053:
	CPI  R30,LOW(0x70)
	BRNE _0x2060056
	CALL SUBOPT_0xA8
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL SUBOPT_0x6D
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL _strlenf
	MOV  R16,R30
	ORI  R17,LOW(8)
_0x2060054:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0x2060057
_0x2060056:
	CPI  R30,LOW(0x64)
	BREQ _0x206005A
	CPI  R30,LOW(0x69)
	BRNE _0x206005B
_0x206005A:
	ORI  R17,LOW(4)
	RJMP _0x206005C
_0x206005B:
	CPI  R30,LOW(0x75)
	BRNE _0x206005D
_0x206005C:
	LDI  R30,LOW(_tbl10_G103*2)
	LDI  R31,HIGH(_tbl10_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0x206005E
_0x206005D:
	CPI  R30,LOW(0x58)
	BRNE _0x2060060
	ORI  R17,LOW(8)
	RJMP _0x2060061
_0x2060060:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2060092
_0x2060061:
	LDI  R30,LOW(_tbl16_G103*2)
	LDI  R31,HIGH(_tbl16_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0x206005E:
	SBRS R17,2
	RJMP _0x2060063
	CALL SUBOPT_0xA8
	CALL SUBOPT_0xAA
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2060064
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0x2060064:
	CPI  R21,0
	BREQ _0x2060065
	SUBI R16,-LOW(1)
	RJMP _0x2060066
_0x2060065:
	ANDI R17,LOW(251)
_0x2060066:
	RJMP _0x2060067
_0x2060063:
	CALL SUBOPT_0xA8
	CALL SUBOPT_0xAA
_0x2060067:
_0x2060057:
	SBRC R17,0
	RJMP _0x2060068
_0x2060069:
	CP   R16,R20
	BRSH _0x206006B
	SBRS R17,7
	RJMP _0x206006C
	SBRS R17,2
	RJMP _0x206006D
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0x206006E
_0x206006D:
	LDI  R19,LOW(48)
_0x206006E:
	RJMP _0x206006F
_0x206006C:
	LDI  R19,LOW(32)
_0x206006F:
	CALL SUBOPT_0xA7
	SUBI R20,LOW(1)
	RJMP _0x2060069
_0x206006B:
_0x2060068:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0x2060070
_0x2060071:
	CPI  R18,0
	BREQ _0x2060073
	SBRS R17,3
	RJMP _0x2060074
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R19,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2060075
_0x2060074:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R19,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2060075:
	CALL SUBOPT_0xA7
	CPI  R20,0
	BREQ _0x2060076
	SUBI R20,LOW(1)
_0x2060076:
	SUBI R18,LOW(1)
	RJMP _0x2060071
_0x2060073:
	RJMP _0x2060077
_0x2060070:
_0x2060079:
	LDI  R19,LOW(48)
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
_0x206007B:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x206007D
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x206007B
_0x206007D:
	CPI  R19,58
	BRLO _0x206007E
	SBRS R17,3
	RJMP _0x206007F
	SUBI R19,-LOW(7)
	RJMP _0x2060080
_0x206007F:
	SUBI R19,-LOW(39)
_0x2060080:
_0x206007E:
	SBRC R17,4
	RJMP _0x2060082
	CPI  R19,49
	BRSH _0x2060084
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2060083
_0x2060084:
	RJMP _0x20600F6
_0x2060083:
	CP   R20,R18
	BRLO _0x2060088
	SBRS R17,0
	RJMP _0x2060089
_0x2060088:
	RJMP _0x2060087
_0x2060089:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0x206008A
	LDI  R19,LOW(48)
_0x20600F6:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0x206008B
	ANDI R17,LOW(251)
	ST   -Y,R21
	CALL SUBOPT_0xA9
	CPI  R20,0
	BREQ _0x206008C
	SUBI R20,LOW(1)
_0x206008C:
_0x206008B:
_0x206008A:
_0x2060082:
	CALL SUBOPT_0xA7
	CPI  R20,0
	BREQ _0x206008D
	SUBI R20,LOW(1)
_0x206008D:
_0x2060087:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x206007A
	RJMP _0x2060079
_0x206007A:
_0x2060077:
	SBRS R17,0
	RJMP _0x206008E
_0x206008F:
	CPI  R20,0
	BREQ _0x2060091
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0xA9
	RJMP _0x206008F
_0x2060091:
_0x206008E:
_0x2060092:
_0x2060051:
_0x20600F5:
	LDI  R16,LOW(0)
_0x206003C:
	RJMP _0x2060037
_0x2060039:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	SBIW R30,0
	BRNE _0x2060093
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20E0002
_0x2060093:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL SUBOPT_0x6D
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G103)
	LDI  R31,HIGH(_put_buff_G103)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G103
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20E0002:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG
_bcd2bin:
; .FSTART _bcd2bin
	ST   -Y,R26
    ld   r30,y
    swap r30
    andi r30,0xf
    mov  r26,r30
    lsl  r26
    lsl  r26
    add  r30,r26
    lsl  r30
    ld   r26,y+
    andi r26,0xf
    add  r30,r26
    ret
; .FEND
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
_memcmp:
; .FSTART _memcmp
	ST   -Y,R27
	ST   -Y,R26
    clr  r22
    clr  r23
    ld   r24,y+
    ld   r25,y+
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
memcmp0:
    adiw r24,0
    breq memcmp1
    sbiw r24,1
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    breq memcmp0
memcmp1:
    sub  r22,r23
    brcc memcmp2
    ldi  r30,-1
    ret
memcmp2:
    ldi  r30,0
    breq memcmp3
    inc  r30
memcmp3:
    ret
; .FEND
_memcpy:
; .FSTART _memcpy
	ST   -Y,R27
	ST   -Y,R26
    ldd  r25,y+1
    ld   r24,y
    adiw r24,0
    breq memcpy1
    ldd  r27,y+5
    ldd  r26,y+4
    ldd  r31,y+3
    ldd  r30,y+2
memcpy0:
    ld   r22,z+
    st   x+,r22
    sbiw r24,1
    brne memcpy0
memcpy1:
    ldd  r31,y+5
    ldd  r30,y+4
	ADIW R28,6
	RET
; .FEND
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
_0x20E0001:
	ADIW R28,5
	RET
; .FEND
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
_fileName:
	.BYTE 0xE
_date:
	.BYTE 0x20
_text:
	.BYTE 0x20
_STM:
	.BYTE 0x1
_GS:
	.BYTE 0x1
_br:
	.BYTE 0x2
_br1:
	.BYTE 0x2
_buffer:
	.BYTE 0x64
_res:
	.BYTE 0x1
_drive:
	.BYTE 0x232
_archivo:
	.BYTE 0x220
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
;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(2)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	CALL _SendDataBitsLCD
	JMP  _PulseEn

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	LDD  R30,Y+1
	ANDI R30,LOW(0xF0)
	MOV  R16,R30
	SWAP R16
	ANDI R16,0xF
	MOV  R26,R16
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LDD  R30,Y+1
	ANDI R30,LOW(0xF)
	MOV  R16,R30
	MOV  R26,R16
	CALL _SendDataBitsLCD
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x4:
	CALL _read_adc
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2N 0x40A00000
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x44800000
	CALL __DIVF21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	LDS  R30,_v1I
	LDS  R31,_v1I+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x6:
	CALL __SWAPD12
	CALL __SUBF12
	__GETD2N 0x42C80000
	CALL __MULF12
	CALL __CFD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	LDS  R30,_v2I
	LDS  R31,_v2I+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(_archivo)
	LDI  R31,HIGH(_archivo)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xA:
	__GETD2MN _archivo,10
	CALL _f_lseek
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xB:
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_br1)
	LDI  R27,HIGH(_br1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0xC:
	LDS  R30,_H
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,_M
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,_S
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xD:
	RCALL SUBOPT_0x5
	CALL __CWD1
	CALL __PUTPARD1
	LDS  R30,_v1D
	LDS  R31,_v1D+1
	CALL __CWD1
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LDI  R24,20
	CALL _sprintf
	ADIW R28,24
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	CALL _MoveCursor
	LDI  R26,LOW(_time)
	LDI  R27,HIGH(_time)
	JMP  _StringLCDVar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x10:
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_D
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,_Mes
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,_A
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	RCALL SUBOPT_0x7
	CALL __CWD1
	CALL __PUTPARD1
	LDS  R30,_v2D
	LDS  R31,_v2D+1
	CALL __CWD1
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x12:
	LDS  R30,_STM
	LDS  R26,_S
	ADD  R30,R26
	STS  _GS,R30
	LDS  R26,_GS
	CPI  R26,LOW(0x3C)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	LDS  R30,_GS
	SUBI R30,LOW(59)
	STS  _GS,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x14:
	STS  _H,R30
	ST   -Y,R30
	LDS  R30,_M
	ST   -Y,R30
	LDS  R26,_S
	JMP  _rtc_set_time

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x15:
	STS  _M,R30
	LDS  R30,_H
	ST   -Y,R30
	LDS  R30,_M
	ST   -Y,R30
	LDS  R26,_S
	JMP  _rtc_set_time

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x16:
	LDI  R30,LOW(0)
	STS  _S,R30
	LDS  R30,_H
	ST   -Y,R30
	LDS  R30,_M
	ST   -Y,R30
	LDS  R26,_S
	JMP  _rtc_set_time

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x17:
	STS  _D,R30
	ST   -Y,R30
	LDS  R30,_Mes
	ST   -Y,R30
	LDS  R26,_A
	JMP  _rtc_set_date

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x18:
	STS  _Mes,R30
	LDS  R30,_D
	ST   -Y,R30
	LDS  R30,_Mes
	ST   -Y,R30
	LDS  R26,_A
	JMP  _rtc_set_date

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x19:
	STS  _A,R30
	LDS  R30,_D
	ST   -Y,R30
	LDS  R30,_Mes
	ST   -Y,R30
	LDS  R26,_A
	JMP  _rtc_set_date

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1A:
	LDI  R30,LOW(142)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _ds1302_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1B:
	CALL _ds1302_read
	MOV  R26,R30
	JMP  _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1C:
	ST   -Y,R30
	LDD  R26,Y+3
	CALL _bin2bcd
	MOV  R26,R30
	JMP  _ds1302_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1D:
	ST   -Y,R30
	LDD  R26,Y+2
	CALL _bin2bcd
	MOV  R26,R30
	JMP  _ds1302_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	LDI  R31,0
	CALL __CWD1
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	CALL __GETD1P
	__PUTD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x20:
	__GETD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x21:
	__GETD2S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x22:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 4
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	JMP  _disk_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	__GETD2Z 34
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x24:
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 8
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x25:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2N 0x0
	JMP  _move_window_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x26:
	ADIW R26,46
	__GETD1N 0x0
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x27:
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	JMP  _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x28:
	CALL __PUTDZ20
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x29:
	CALL __GETD1P
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2A:
	__GETD2Z 18
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2B:
	__GETD2S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x2C:
	__CPD2N 0x2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	__GETD1N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2E:
	CALL __GETD1P
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x2F:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	__GETD2S 6
	CLR  R22
	CLR  R23
	CALL __ADDD21
	CALL _move_window_G102
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x30:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	MOVW R30,R18
	ANDI R31,HIGH(0x1FF)
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x31:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x32:
	__GETD1N 0x100
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x33:
	__GETD2S 6
	CALL __ADDD21
	CALL _move_window_G102
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x34:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x35:
	CALL __GETW1P
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x36:
	__GETD1N 0x80
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x37:
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x38:
	__GETD2S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	CALL __GETD1P
	RCALL SUBOPT_0x38
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3A:
	__PUTD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x3B:
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R16
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	__GETD2S 7
	CLR  R22
	CLR  R23
	CALL __ADDD21
	CALL _move_window_G102
	MOV  R20,R30
	CPI  R20,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3C:
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	ADIW R26,50
	MOVW R30,R16
	ANDI R31,HIGH(0x1FF)
	ADD  R30,R26
	ADC  R31,R27
	MOVW R18,R30
	LDD  R30,Y+13
	ANDI R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3D:
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3E:
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 15
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3F:
	__GETD2S 7
	CALL __ADDD21
	CALL _move_window_G102
	MOV  R20,R30
	CPI  R20,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x40:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+17
	LDD  R27,Y+17+1
	ADIW R26,50
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x41:
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x42:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,30
	CALL __GETD1P
	RCALL SUBOPT_0x41
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x43:
	__GETD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x44:
	__CPD2N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x45:
	__CPD2N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x46:
	__GETD1S 7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x47:
	__GETD2N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x48:
	__GETD2Z 14
	RJMP SUBOPT_0x45

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x49:
	ADIW R26,14
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4A:
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4B:
	__GETD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4C:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4D:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4E:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4F:
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x50:
	CALL _get_fat
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x51:
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x52:
	__GETD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x53:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x54:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x55:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x56:
	RCALL SUBOPT_0x53
	RCALL SUBOPT_0x2B
	CALL __CPD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x57:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x58:
	__GETD1S 10
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x59:
	CALL __SWAPD12
	CALL __SUBD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5A:
	__PUTW1SNS 8,4
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5B:
	CALL __GETD1P
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5C:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES, CODE SIZE REDUCTION:43 WORDS
SUBOPT_0x5D:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5E:
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	RCALL SUBOPT_0x5C
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5F:
	__GETD1S 2
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x60:
	__GETD1S 2
	__PUTD1SNS 8,10
	RJMP SUBOPT_0x5D

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x61:
	CLR  R22
	CLR  R23
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x62:
	__PUTD1SNS 8,14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x63:
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	LSL  R30
	CALL __LSLW4
	ADD  R30,R26
	ADC  R31,R27
	__PUTW1SNS 8,18
	LDI  R30,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x64:
	CALL __GETD1P
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x65:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	__GETD2Z 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x66:
	__PUTD1S 3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x67:
	__GETD2S 3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x68:
	RCALL SUBOPT_0x66
	__GETD1S 3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x69:
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x41
	JMP  _clust2sect

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6A:
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _dir_seek_G102
	MOV  R16,R30
	CPI  R16,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x6B:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__GETD2Z 14
	CALL _move_window_G102
	MOV  R16,R30
	CPI  R16,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6C:
	ST   -Y,R19
	ST   -Y,R18
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+20
	LDD  R27,Z+21
	ST   -Y,R27
	ST   -Y,R26
	LDI  R26,LOW(11)
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6D:
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6E:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x6F:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	SBIW R30,1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R17,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x70:
	MOV  R30,R21
	SUBI R21,-1
	LDI  R31,0
	ADD  R30,R19
	ADC  R31,R20
	ST   Z,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x71:
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	ST   X+,R30
	ST   X,R31
	CPI  R17,33
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x72:
	RCALL SUBOPT_0x57
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x73:
	__PUTD1SNS 6,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x74:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x75:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x76:
	__GETW2R 17,18
	ADIW R26,20
	RJMP SUBOPT_0x35

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x77:
	__GETW2R 17,18
	ADIW R26,26
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x78:
	CLR  R22
	CLR  R23
	CALL __ORD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x79:
	ADIW R30,50
	SUBI R30,LOW(-510)
	SBCI R31,HIGH(-510)
	MOVW R26,R30
	CALL __GETW1P
	CPI  R30,LOW(0xAA55)
	LDI  R26,HIGH(0xAA55)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x7A:
	CALL __GETD1P
	__ANDD1N 0xFFFFFF
	__CPD1N 0x544146
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7B:
	LDI  R26,LOW(_FatFs_G102)
	LDI  R27,HIGH(_FatFs_G102)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x7C:
	__PUTD1S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x7D:
	__GETD1S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x7E:
	__GETD2S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7F:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SUBI R26,LOW(-64)
	SBCI R27,HIGH(-64)
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x80:
	__GETD2S 21
	RJMP SUBOPT_0x61

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x81:
	__PUTD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x82:
	__GETD1S 13
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x83:
	CALL __GETD1P
	RJMP SUBOPT_0x81

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x84:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LDD  R26,Z+8
	LDD  R27,Z+9
	MOVW R30,R26
	CALL __LSRW4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x85:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	RCALL SUBOPT_0x23
	RCALL SUBOPT_0x7D
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x86:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x87:
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	STD  Z+0,R26
	STD  Z+1,R27
	__GETW1R 17,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x88:
	__SUBD1N 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x89:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x8A:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x8B:
	LDD  R26,Z+2
	LDD  R27,Z+3
	CALL _validate_G102
	MOV  R16,R30
	CPI  R16,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8C:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x8D:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,10
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x8E:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	__GETD2Z 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8F:
	__PUTD1S 11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x90:
	__GETD1S 11
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x91:
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x47
	JMP  _create_chain_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x92:
	__PUTD1SNS 21,14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x93:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x94:
	__PUTD1SNS 21,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x95:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x96:
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	__GETD2Z 22
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	CALL _disk_write
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x97:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xBF
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x98:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R30,Z+5
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x99:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	__GETD2Z 22
	RJMP SUBOPT_0x46

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x9A:
	__GETD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9B:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,5
	LD   R30,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9C:
	__PUTD1SNS 21,22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9D:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL __GETW1P
	ANDI R31,HIGH(0x1FF)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9E:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x9F:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	ADIW R30,6
	MOVW R0,R30
	MOVW R26,R30
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA0:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA1:
	__PUTD1SNS 21,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA2:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA3:
	__PUTD1SNS 21,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA4:
	RCALL SUBOPT_0x88
	MOVW R26,R30
	MOVW R24,R22
	RCALL SUBOPT_0x9A
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA5:
	__GETD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA6:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 15
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xA7:
	ST   -Y,R19
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xA8:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA9:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xAA:
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

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__ADDD21:
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__SUBD21:
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	RET

__ANDD12:
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	RET

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
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

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__LSRW4:
	LSR  R31
	ROR  R30
__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__LSLD1:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	RET

__LSRD16:
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	RET

__LSLD16:
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__COMD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
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

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
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

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__GETD1P_INC:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__PUTDP1_DEC:
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTDZ20:
	ST   Z,R26
	STD  Z+1,R27
	STD  Z+2,R24
	STD  Z+3,R25
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
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

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
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

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
