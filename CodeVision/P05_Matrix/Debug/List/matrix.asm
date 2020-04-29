
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
;Data Stack size        : 1024 byte(s)
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
	.EQU __DSTACK_SIZE=0x0400
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

_0x2F:
	.DB  0x46,0x75,0x6E,0x63,0x69,0x6F,0x6E,0x61
	.DB  0x6E,0x64,0x6F,0x0
_0x34:
	.DB  0x43,0x4F,0x56,0x49,0x44,0x2D,0x31,0x39
	.DB  0x3F,0x20,0x4E,0x6F,0x20,0x70,0x72,0x6F
	.DB  0x62,0x6C,0x65,0x6D,0x21,0x0
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
	.ORG 0x500

	.CSEG
;/*
; * Matriz_LEDS.c
; *
; * Created: 21/04/2020 05:36:03 p. m.
; * Author: Chucho López Ortega
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
;#include <delay.h>
;#include "Letras.h"
;#include "Animacion.h"
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
	RJMP _0x2000001
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
	RJMP _0x2000003
; 0000 002C }
; .FEND
;
;void MandaLetra(char letra)
; 0000 002F {
_MandaLetra:
; .FSTART _MandaLetra
; 0000 0030     letra=letra-32;          //offset de la tabla (espacio es el primer caracter)
	ST   -Y,R26
;	letra -> Y+0
	LD   R30,Y
	SUBI R30,LOW(32)
	ST   Y,R30
; 0000 0031     MandaMax7219(0x0100);    //elimino las columnas que no ocupo
	RCALL SUBOPT_0x0
; 0000 0032     MandaMax7219(0x0200);    //elimino las columnas que no ocupo
; 0000 0033     MandaMax7219(0x0800);    //elimino las columnas que no ocupo
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
	RCALL SUBOPT_0x1
; 0000 0034 
; 0000 0035     //    Unimos la columna y el valor de cada renglon
; 0000 0036     MandaMax7219(0x0300|Letras[letra][4]);
	ADIW R30,4
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x300)
	MOVW R26,R30
	RCALL SUBOPT_0x1
; 0000 0037     MandaMax7219(0x0400|Letras[letra][3]);
	ADIW R30,3
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x400)
	MOVW R26,R30
	RCALL SUBOPT_0x1
; 0000 0038     MandaMax7219(0x0500|Letras[letra][2]);
	ADIW R30,2
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x500)
	MOVW R26,R30
	RCALL SUBOPT_0x1
; 0000 0039     MandaMax7219(0x0600|Letras[letra][1]);
	ADIW R30,1
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x600)
	MOVW R26,R30
	RCALL SUBOPT_0x1
; 0000 003A     MandaMax7219(0x0700|Letras[letra][0]);
	LPM  R30,Z
	LDI  R31,0
	ORI  R31,HIGH(0x700)
	RJMP _0x2000002
; 0000 003B }
; .FEND
;
;void clear(){
; 0000 003D void clear(){
_clear:
; .FSTART _clear
; 0000 003E     MandaMax7219(0x0100);
	RCALL SUBOPT_0x0
; 0000 003F     MandaMax7219(0x0200);
; 0000 0040     MandaMax7219(0x0300);
	LDI  R26,LOW(768)
	LDI  R27,HIGH(768)
	RCALL _MandaMax7219
; 0000 0041     MandaMax7219(0x0400);
	LDI  R26,LOW(1024)
	LDI  R27,HIGH(1024)
	RCALL _MandaMax7219
; 0000 0042     MandaMax7219(0x0500);
	LDI  R26,LOW(1280)
	LDI  R27,HIGH(1280)
	RCALL _MandaMax7219
; 0000 0043     MandaMax7219(0x0600);
	LDI  R26,LOW(1536)
	LDI  R27,HIGH(1536)
	RCALL _MandaMax7219
; 0000 0044     MandaMax7219(0x0700);
	LDI  R26,LOW(1792)
	LDI  R27,HIGH(1792)
	RCALL _MandaMax7219
; 0000 0045     MandaMax7219(0x0800);
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
_0x2000003:
	RCALL _MandaMax7219
; 0000 0046 }
	RET
; .FEND
;
;void DespliegaMensaje(char *str, int time, char size){
; 0000 0048 void DespliegaMensaje(char *str, int time, char size){
_DespliegaMensaje:
; .FSTART _DespliegaMensaje
; 0000 0049     char i=0;
; 0000 004A     for(i=0; i<size-1; i++){
	ST   -Y,R26
	ST   -Y,R16
;	*str -> Y+4
;	time -> Y+2
;	size -> Y+1
;	i -> R16
	LDI  R16,0
	LDI  R16,LOW(0)
_0x19:
	LDD  R30,Y+1
	LDI  R31,0
	SBIW R30,1
	RCALL SUBOPT_0x2
	BRGE _0x1A
; 0000 004B         MandaLetra(str[i]);
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CLR  R30
	ADD  R26,R16
	ADC  R27,R30
	LD   R26,X
	RCALL _MandaLetra
; 0000 004C         delay_ms(time);
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL _delay_ms
; 0000 004D     }
	SUBI R16,-1
	RJMP _0x19
_0x1A:
; 0000 004E }
	LDD  R16,Y+0
	ADIW R28,6
	RET
; .FEND
;
;int l1, l2, l3, l4, l5, l6, l7, l8, lsize;
;void DespliegaMensajeCorrimiento(char *Mensaje, int tiempo, char size){
; 0000 0051 void DespliegaMensajeCorrimiento(char *Mensaje, int tiempo, char size){
_DespliegaMensajeCorrimiento:
; .FSTART _DespliegaMensajeCorrimiento
; 0000 0052     char i=0, j=0;
; 0000 0053     clear();
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	*Mensaje -> Y+5
;	tiempo -> Y+3
;	size -> Y+2
;	i -> R16
;	j -> R17
	LDI  R16,0
	LDI  R17,0
	RCALL _clear
; 0000 0054     lsize = (size-1)*5;
	LDD  R30,Y+2
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12
	STS  _lsize,R30
	STS  _lsize+1,R31
; 0000 0055     for(i=0; i<lsize+8; i++){
	LDI  R16,LOW(0)
_0x1C:
	LDS  R30,_lsize
	LDS  R31,_lsize+1
	ADIW R30,8
	RCALL SUBOPT_0x2
	BRLT PC+2
	RJMP _0x1D
; 0000 0056         l8 = l7;    // Recorre las letras de la posicion anterior a la nueva
	LDS  R30,_l7
	LDS  R31,_l7+1
	STS  _l8,R30
	STS  _l8+1,R31
; 0000 0057         l7 = l6;
	LDS  R30,_l6
	LDS  R31,_l6+1
	STS  _l7,R30
	STS  _l7+1,R31
; 0000 0058         l6 = l5;
	LDS  R30,_l5
	LDS  R31,_l5+1
	STS  _l6,R30
	STS  _l6+1,R31
; 0000 0059         l5 = l4;
	LDS  R30,_l4
	LDS  R31,_l4+1
	STS  _l5,R30
	STS  _l5+1,R31
; 0000 005A         l4 = l3;
	LDS  R30,_l3
	LDS  R31,_l3+1
	STS  _l4,R30
	STS  _l4+1,R31
; 0000 005B         l3 = l2;
	LDS  R30,_l2
	LDS  R31,_l2+1
	STS  _l3,R30
	STS  _l3+1,R31
; 0000 005C         l2 = l1;
	LDS  R30,_l1
	LDS  R31,_l1+1
	STS  _l2,R30
	STS  _l2+1,R31
; 0000 005D         if(i<lsize) // Agrega las lineas al principio
	LDS  R30,_lsize
	LDS  R31,_lsize+1
	RCALL SUBOPT_0x2
	BRGE _0x1E
; 0000 005E             l1 = Letras[Mensaje[j]-32][i%5];
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CLR  R30
	ADD  R26,R17
	ADC  R27,R30
	LD   R30,X
	LDI  R31,0
	SBIW R30,32
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	SUBI R30,LOW(-_Letras*2)
	SBCI R31,HIGH(-_Letras*2)
	MOVW R22,R30
	RCALL SUBOPT_0x3
	ADD  R30,R22
	ADC  R31,R23
	LPM  R30,Z
	LDI  R31,0
	STS  _l1,R30
	STS  _l1+1,R31
; 0000 005F         else
	RJMP _0x1F
_0x1E:
; 0000 0060             l1 = 0;
	LDI  R30,LOW(0)
	STS  _l1,R30
	STS  _l1+1,R30
; 0000 0061         if(i%5==4) // Cambia de letra cuando esta acabe
_0x1F:
	RCALL SUBOPT_0x3
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x20
; 0000 0062             j++;
	SUBI R17,-1
; 0000 0063         MandaMax7219(0x0100|l1); // Envia la informacion al Max7219
_0x20:
	LDS  R30,_l1
	LDS  R31,_l1+1
	ORI  R31,HIGH(0x100)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0064         MandaMax7219(0x0200|l2);
	LDS  R30,_l2
	LDS  R31,_l2+1
	ORI  R31,HIGH(0x200)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0065         MandaMax7219(0x0300|l3);
	LDS  R30,_l3
	LDS  R31,_l3+1
	ORI  R31,HIGH(0x300)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0066         MandaMax7219(0x0400|l4);
	LDS  R30,_l4
	LDS  R31,_l4+1
	ORI  R31,HIGH(0x400)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0067         MandaMax7219(0x0500|l5);
	LDS  R30,_l5
	LDS  R31,_l5+1
	ORI  R31,HIGH(0x500)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0068         MandaMax7219(0x0600|l6);
	LDS  R30,_l6
	LDS  R31,_l6+1
	ORI  R31,HIGH(0x600)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0069         MandaMax7219(0x0700|l7);
	LDS  R30,_l7
	LDS  R31,_l7+1
	ORI  R31,HIGH(0x700)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 006A         MandaMax7219(0x0800|l8);
	LDS  R30,_l8
	LDS  R31,_l8+1
	ORI  R31,HIGH(0x800)
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 006B         delay_ms(tiempo);
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	CALL _delay_ms
; 0000 006C     }
	SUBI R16,-1
	RJMP _0x1C
_0x1D:
; 0000 006D 
; 0000 006E }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,7
	RET
; .FEND
;
;void ConfiguraIntensidad(unsigned char c)
; 0000 0071 {
_ConfiguraIntensidad:
; .FSTART _ConfiguraIntensidad
; 0000 0072     MandaMax7219(0x0A00|c);
	ST   -Y,R26
;	c -> Y+0
	LD   R30,Y
	LDI  R31,0
	ORI  R31,HIGH(0xA00)
_0x2000002:
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0073 }
	ADIW R28,1
	RET
; .FEND
;
;void MandaAnimacion(void)
; 0000 0076 {
_MandaAnimacion:
; .FSTART _MandaAnimacion
; 0000 0077     unsigned char i,j,k=0;
; 0000 0078     ConfiguraIntensidad(1);
	CALL __SAVELOCR3
;	i -> R16
;	j -> R17
;	k -> R18
	LDI  R18,0
	LDI  R26,LOW(1)
	RCALL _ConfiguraIntensidad
; 0000 0079     for (j=0;j<38;j++)
	LDI  R17,LOW(0)
_0x22:
	CPI  R17,38
	BRSH _0x23
; 0000 007A     {
; 0000 007B         if (j<8)
	CPI  R17,8
	BRSH _0x24
; 0000 007C         {
; 0000 007D             ConfiguraIntensidad(k);
	MOV  R26,R18
	RCALL _ConfiguraIntensidad
; 0000 007E             k++;
	SUBI R18,-1
; 0000 007F         }
; 0000 0080         if (j>30 && j<38)
_0x24:
	CPI  R17,31
	BRLO _0x26
	CPI  R17,38
	BRLO _0x27
_0x26:
	RJMP _0x25
_0x27:
; 0000 0081         {
; 0000 0082             ConfiguraIntensidad(k);
	MOV  R26,R18
	RCALL _ConfiguraIntensidad
; 0000 0083             k--;
	SUBI R18,1
; 0000 0084         }
; 0000 0085         for (i=1;i<9;i++)
_0x25:
	LDI  R16,LOW(1)
_0x29:
	CPI  R16,9
	BRSH _0x2A
; 0000 0086         {
; 0000 0087             MandaMax7219((i<<8)|Animacion[j][8-i]);
	MOV  R31,R16
	LDI  R30,LOW(0)
	MOVW R24,R30
	MOV  R30,R17
	LDI  R31,0
	CALL __LSLW3
	SUBI R30,LOW(-_Animacion*2)
	SBCI R31,HIGH(-_Animacion*2)
	MOVW R22,R30
	MOV  R30,R16
	LDI  R31,0
	LDI  R26,LOW(8)
	LDI  R27,HIGH(8)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	ADD  R30,R22
	ADC  R31,R23
	LPM  R30,Z
	LDI  R31,0
	OR   R30,R24
	OR   R31,R25
	MOVW R26,R30
	RCALL _MandaMax7219
; 0000 0088         }
	SUBI R16,-1
	RJMP _0x29
_0x2A:
; 0000 0089         delay_ms(400);
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
; 0000 008A     }
	SUBI R17,-1
	RJMP _0x22
_0x23:
; 0000 008B }
	CALL __LOADLOCR3
_0x2000001:
	ADIW R28,3
	RET
; .FEND
;
;void main(void)
; 0000 008E {
_main:
; .FSTART _main
; 0000 008F 
; 0000 0090 PORTD=0x07;     //seteo de botones
	LDI  R30,LOW(7)
	OUT  0xB,R30
; 0000 0091 ConfiguraMax();
	RCALL _ConfiguraMax
; 0000 0092 while (1)
_0x2B:
; 0000 0093     {
; 0000 0094     // Please write your application code here
; 0000 0095         if(!PIND.0){ // Aparicion de letras
	SBIC 0x9,0
	RJMP _0x2E
; 0000 0096             char str[] = "Funcionando";
; 0000 0097             DespliegaMensaje(str, 1000, sizeof(str));
	SBIW R28,12
	LDI  R24,12
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x2F*2)
	LDI  R31,HIGH(_0x2F*2)
	CALL __INITLOCB
;	str -> Y+0
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(12)
	RCALL _DespliegaMensaje
; 0000 0098         }else if (PIND.1==0)
	ADIW R28,12
	RJMP _0x30
_0x2E:
	SBIC 0x9,1
	RJMP _0x31
; 0000 0099             MandaAnimacion();
	RCALL _MandaAnimacion
; 0000 009A         else if (PIND.2==0)     {
	RJMP _0x32
_0x31:
	SBIC 0x9,2
	RJMP _0x33
; 0000 009B             char str[] = "COVID-19? No problem!";
; 0000 009C             DespliegaMensajeCorrimiento(str, 200, sizeof(str));
	SBIW R28,22
	LDI  R24,22
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x34*2)
	LDI  R31,HIGH(_0x34*2)
	CALL __INITLOCB
;	str -> Y+0
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(22)
	RCALL _DespliegaMensajeCorrimiento
; 0000 009D         }else // Caso de no apretar nungun boton
	ADIW R28,22
	RJMP _0x35
_0x33:
; 0000 009E             clear();
	RCALL _clear
; 0000 009F     }
_0x35:
_0x32:
_0x30:
	RJMP _0x2B
; 0000 00A0 }
_0x36:
	RJMP _0x36
; .FEND

	.DSEG
_l1:
	.BYTE 0x2
_l2:
	.BYTE 0x2
_l3:
	.BYTE 0x2
_l4:
	.BYTE 0x2
_l5:
	.BYTE 0x2
_l6:
	.BYTE 0x2
_l7:
	.BYTE 0x2
_l8:
	.BYTE 0x2
_lsize:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(256)
	LDI  R27,HIGH(256)
	RCALL _MandaMax7219
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RJMP _MandaMax7219

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x1:
	RCALL _MandaMax7219
	LD   R30,Y
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,LOW(-_Letras*2)
	SBCI R31,HIGH(-_Letras*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	MOV  R26,R16
	LDI  R27,0
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	MOV  R26,R16
	CLR  R27
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __MODW21
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

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
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

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

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
