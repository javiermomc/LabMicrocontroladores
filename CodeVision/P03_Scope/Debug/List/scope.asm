
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : AT90USB1286
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Medium
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

	#define _MODEL_MEDIUM_

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

	.MACRO __GETBRPF
	OUT  RAMPZ,R22
	ELPM R@0,Z
	.ENDM

	.MACRO __GETBRPF_INC
	OUT  RAMPZ,R22
	ELPM R@0,Z+
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
	.DEF _cursor=R4
	.DEF _freq=R5
	.DEF _freq_msb=R6
	.DEF _br=R7
	.DEF _br_msb=R8
	.DEF _j=R3
	.DEF _i=R9
	.DEF _i_msb=R10

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

_Letra0:
	.DB  0xC7,0xBB,0xBB,0xBB,0xBB,0xBB,0xBB,0xBB
	.DB  0xC7
_Letra1:
	.DB  0xEF,0x8F,0xEF,0xEF,0xEF,0xEF,0xEF,0xEF
	.DB  0x83
_LetraH:
	.DB  0x88,0xDD,0xDD,0xDD,0xC1,0xDD,0xDD,0xDD
	.DB  0x88
_LetraZ:
	.DB  0xFF,0xFF,0xFF,0x81,0xBB,0xF7,0xEF,0xDD
	.DB  0x81
_k1:
	.DB  0x20,0x22,0x2A,0x2B,0x2C,0x5B,0x3D,0x5D
	.DB  0x7C,0x7F,0x0
_vst_G101:
	.DB  0x0,0x4,0x0,0x2,0x0,0x1,0x80,0x0
	.DB  0x40,0x0,0x20,0x0,0x10,0x0,0x8,0x0
	.DB  0x4,0x0,0x2,0x0,0x0,0x0
_cst_G101:
	.DB  0x0,0x80,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x4,0x0,0x2
_tbl10_G102:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G102:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x3:
	.DB  0x3,0x3,0x3,0x2,0x2,0xC,0x0,0x8
	.DB  0x0,0x1,0x0,0x6
_0x2D:
	.DB  0x30,0x3A,0x49,0x4D,0x30,0x30,0x30,0x2E
	.DB  0x42,0x4D,0x50
_0x0:
	.DB  0x44,0x72,0x69,0x76,0x65,0x20,0x6E,0x6F
	.DB  0x20,0x64,0x65,0x74,0x65,0x63,0x74,0x61
	.DB  0x64,0x6F,0x0,0x44,0x72,0x69,0x76,0x65
	.DB  0x20,0x63,0x65,0x72,0x72,0x61,0x64,0x6F
	.DB  0x0,0x2E,0x2E,0x2E,0x0,0x57,0x65,0x6C
	.DB  0x63,0x6F,0x6D,0x65,0x0,0x53,0x74,0x61
	.DB  0x72,0x74,0x69,0x6E,0x67,0x20,0x20,0x20
	.DB  0x20,0x20,0x0,0x30,0x3A,0x42,0x41,0x53
	.DB  0x45,0x2E,0x42,0x4D,0x50,0x0,0x4C,0x69
	.DB  0x73,0x74,0x6F,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x0,0x46,0x69,0x6C,0x65,0x20,0x65
	.DB  0x72,0x72,0x6F,0x72,0x0,0x62,0x61,0x73
	.DB  0x65,0x2E,0x62,0x6D,0x70,0x20,0x65,0x72
	.DB  0x72,0x6F,0x72,0x0
_0x2000003:
	.DB  0x1
_0x20000FE:
	.DB  0x4
_0x2020000:
	.DB  0xEB,0xFE,0x90,0x4D,0x53,0x44,0x4F,0x53
	.DB  0x35,0x2E,0x30,0x0,0x4E,0x4F,0x20,0x4E
	.DB  0x41,0x4D,0x45,0x20,0x20,0x20,0x20,0x46
	.DB  0x41,0x54,0x33,0x32,0x20,0x20,0x20,0x0
	.DB  0x4E,0x4F,0x20,0x4E,0x41,0x4D,0x45,0x20
	.DB  0x20,0x20,0x20,0x46,0x41,0x54,0x20,0x20
	.DB  0x20,0x20,0x20,0x0

__GLOBAL_INI_TBL:
	.DW  0x0B
	.DW  _fileName
	.DD  _0x2D*2

	.DW  0x0B
	.DW  _0x36
	.DD  _0x0*2+59

	.DW  0x01
	.DW  _status_G100
	.DD  _0x2000003*2

	.DW  0x01
	.DW  _flags_S100000C000
	.DD  _0x20000FE*2

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
	LDI  R29,BYTE3(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	OUT  RAMPZ,R29
	ELPM R24,Z+
	ELPM R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	ELPM R26,Z+
	ELPM R27,Z+
	ELPM R0,Z+
	ELPM R1,Z+
	ELPM R28,Z+
	ELPM R29,Z+
	MOVW R22,R30
	IN   R29,RAMPZ
	MOVW R30,R0
	OUT  RAMPZ,R28
__GLOBAL_INI_LOOP:
	ELPM R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

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
; * scope.c
; *
; * Created: 08/03/2020 06:58:19 p. m.
; * Author: Chucho L�pez Ortega
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
	LDI  R22,BYTE3(_0x3*2)
	CALL __INITLOCB
	ST   -Y,R17
;	TableSetup -> Y+1
;	i -> R17
; 0000 0014     SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_EN
    SBI __lcd_port-1,__lcd_RS
    SBI __lcd_port-1,__lcd_D4
    SBI __lcd_port-1,__lcd_D5
    SBI __lcd_port-1,__lcd_D6
    SBI __lcd_port-1,__lcd_D7
	LDI  R26,LOW(50)
	LDI  R27,0
	CALL _delay_ms
	LDI  R17,LOW(0)
_0x5:
	CPI  R17,12
	BRSH _0x6
	CALL SUBOPT_0x0
	MOV  R30,R17
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CALL SUBOPT_0x1
	SUBI R17,-1
	RJMP _0x5
_0x6:
	LDI  R30,LOW(12)
	MOV  R4,R30
	MOV  R26,R4
	RCALL _WriteComandLCD
	LDD  R17,Y+0
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
	JMP  _0x20A0017
; .FEND
_WriteComandLCD:
; .FSTART _WriteComandLCD
	ST   -Y,R26
	ST   -Y,R17
;	Comando -> Y+1
;	tempComando -> R17
	CBI __lcd_port,__lcd_RS
	CALL SUBOPT_0x0
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	RCALL _PulseEn
	LDD  R17,Y+0
	RJMP _0x20A001A
; .FEND
_CharLCD:
; .FSTART _CharLCD
	ST   -Y,R26
	ST   -Y,R17
;	dato -> Y+1
;	tempdato -> R17
	SBI __lcd_port,__lcd_RS
	CALL SUBOPT_0x0
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	RCALL _PulseEn
	LDD  R17,Y+0
	RJMP _0x20A001A
; .FEND
_StringLCD:
; .FSTART _StringLCD
	CALL __PUTPARD2
	ST   -Y,R17
;	i -> R17
	LDI  R17,LOW(0)
_0x10:
	MOV  R30,R17
	SUBI R17,-1
	CALL SUBOPT_0x4
	__GETBRPF 26
	RCALL _CharLCD
	MOV  R30,R17
	CALL SUBOPT_0x4
	__GETBRPF 30
	CPI  R30,0
	BRNE _0x10
	LDD  R17,Y+0
	ADIW R28,5
	RET
; .FEND
;	tiempo -> Y+1
;	i -> R17
;	Mensaje -> Y+1
;	i -> R17
_EraseLCD:
; .FSTART _EraseLCD
	LDI  R26,LOW(1)
	RCALL _WriteComandLCD
	RET
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
	RJMP _0x48
_0x1B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1C
	LDD  R26,Y+1
	SUBI R26,-LOW(192)
	RJMP _0x48
_0x1C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x1D
	LDD  R26,Y+1
	SUBI R26,-LOW(148)
	RJMP _0x48
_0x1D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1A
	LDD  R26,Y+1
	SUBI R26,-LOW(212)
_0x48:
	RCALL _WriteComandLCD
_0x1A:
_0x20A001A:
	ADIW R28,2
	RET
; .FEND
;	NoCaracter -> Y+3
;	datos -> Y+1
;	i -> R17
;#include <delay.h>
;#include <stdio.h>
;#include <ff.h>
;
;// Voltage Reference: Int., cap. on AREF
;#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))
;
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0000 001F {
_read_adc:
; .FSTART _read_adc
; 0000 0020 ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,LOW(0xC0)
	STS  124,R30
; 0000 0021 // Delay needed for the stabilization of the ADC input voltage
; 0000 0022 // Start the AD conversion
; 0000 0023 ADCSRA|=(1<<ADSC);
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0024 // Wait for the AD conversion to complete
; 0000 0025 while ((ADCSRA & (1<<ADIF))==0);
_0x22:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x22
; 0000 0026 ADCSRA|=(1<<ADIF);
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
; 0000 0027 return ADCW;
	LDS  R30,120
	LDS  R31,120+1
	JMP  _0x20A0017
; 0000 0028 }
; .FEND
;
;int buffer[128];
;
;int frequency(){
; 0000 002C int frequency(){
_frequency:
; .FSTART _frequency
; 0000 002D     char i=0, max, iMax, freq;
; 0000 002E     max = buffer[0];
	CALL __SAVELOCR4
;	i -> R17
;	max -> R16
;	iMax -> R19
;	freq -> R18
	LDI  R17,0
	LDS  R16,_buffer
; 0000 002F     iMax = i;
	MOV  R19,R17
; 0000 0030     for ( i=1;i<128;i++){
	LDI  R17,LOW(1)
_0x26:
	CPI  R17,128
	BRSH _0x27
; 0000 0031         if(max == buffer[i]){
	CALL SUBOPT_0x5
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x28
; 0000 0032             freq = 1/(((float)(i - iMax))*0.000039);
	MOV  R26,R17
	CLR  R27
	MOV  R30,R19
	LDI  R31,0
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	CALL __CWD1
	CALL __CDF1
	__GETD2N 0x382393EE
	CALL __MULF12
	__GETD2N 0x3F800000
	CALL __DIVF21
	CALL __CFD1U
	MOV  R18,R30
; 0000 0033             iMax = i;
	MOV  R19,R17
; 0000 0034         }
; 0000 0035         if(max<buffer[i]){
_0x28:
	CALL SUBOPT_0x5
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x29
; 0000 0036             max = buffer[i];
	MOV  R30,R17
	CALL SUBOPT_0x6
	LD   R16,X
; 0000 0037             iMax = i;
	MOV  R19,R17
; 0000 0038         }
; 0000 0039     }
_0x29:
	SUBI R17,-1
	RJMP _0x26
_0x27:
; 0000 003A     return (int)freq;
	MOV  R30,R18
	LDI  R31,0
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; 0000 003B }
; .FEND
;
;// Fills the array to sample the scope shot
;void scope(){
; 0000 003E void scope(){
_scope:
; .FSTART _scope
; 0000 003F     int i;
; 0000 0040     for (i=0;i<128;i++){
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16,R17
	__GETWRN 16,17,0
_0x2B:
	__CPWRN 16,17,128
	BRGE _0x2C
; 0000 0041         buffer[i] = read_adc(7);
	MOVW R30,R16
	LDI  R26,LOW(_buffer)
	LDI  R27,HIGH(_buffer)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R26,LOW(7)
	RCALL _read_adc
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
; 0000 0042         delay_us(21);
	__DELAY_USB 112
; 0000 0043         #asm("NOP");
	NOP
; 0000 0044         #asm("NOP");
	NOP
; 0000 0045         #asm("NOP");
	NOP
; 0000 0046         #asm("NOP");
	NOP
; 0000 0047         #asm("NOP");
	NOP
; 0000 0048         #asm("NOP");
	NOP
; 0000 0049         #asm("NOP");
	NOP
; 0000 004A         #asm("NOP");
	NOP
; 0000 004B         #asm("NOP");
	NOP
; 0000 004C         #asm("NOP");
	NOP
; 0000 004D         #asm("NOP");
	NOP
; 0000 004E         #asm("NOP");
	NOP
; 0000 004F     }
	__ADDWRN 16,17,1
	RJMP _0x2B
_0x2C:
; 0000 0050 }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;int freq;
;
;
;// SD
;char fileName[]  = "0:IM000.BMP";

	.DSEG
;unsigned int br;
;/* will hold the information for logical drive 0: */
;FATFS drive;
;FIL archivo; // file objects
;
;interrupt [TIM1_COMPA] void timer1_compa_isr(void)
; 0000 005D {

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
	IN   R30,RAMPZ
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 005E disk_timerproc();
	CALL _disk_timerproc
; 0000 005F /* MMC/SD/SD HC card access low level timing function */
; 0000 0060 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	OUT  RAMPZ,R30
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
;flash unsigned char Letra0[9] ={0xC7,0xBB,0xBB,0xBB,0xBB,0xBB,0xBB,0xBB,0xC7};
;flash unsigned char Letra1[9] ={0xEF,0x8F,0xEF,0xEF,0xEF,0xEF,0xEF,0xEF,0x83};
;flash unsigned char Letra2[9] ={0xC7,0xBB,0xFB,0xFB,0xF7,0xEF,0xDF,0xBF,0x83};
;flash unsigned char Letra3[9] ={0xC7,0xBB,0xFB,0xFB,0xE7,0xFB,0xFB,0xBB,0xC7};
;flash unsigned char Letra4[9] ={0xF7,0xE7,0xE7,0xD7,0xD7,0xB7,0x83,0xF7,0xE3};
;flash unsigned char Letra5[9] ={0x83,0xBF,0xBF,0xBF,0x87,0xFB,0xFB,0xBB,0xC7};
;flash unsigned char Letra6[9] ={0xE7,0xDF,0xBF,0xBF,0x87,0xBB,0xBB,0xBB,0xC7};
;flash unsigned char Letra7[9] ={0x83,0xBB,0xFB,0xF7,0xF7,0xEF,0xEF,0xDF,0xDF};
;flash unsigned char Letra8[9] ={0xC7,0xBB,0xBB,0xBB,0xC7,0xBB,0xBB,0xBB,0xC7};
;flash unsigned char Letra9[9] ={0xC7,0xBB,0xBB,0xBB,0xC3,0xFB,0xFB,0xF7,0xCF};
;flash unsigned char LetraH[9] ={0x88,0xDD,0xDD,0xDD,0xC1,0xDD,0xDD,0xDD,0x88};
;flash unsigned char LetraZ[9] ={0xFF,0xFF,0xFF,0x81,0xBB,0xF7,0xEF,0xDD,0x81};
;
;void sd_openDrive(){
; 0000 006F void sd_openDrive(){
_sd_openDrive:
; .FSTART _sd_openDrive
; 0000 0070     if (f_mount(0,&drive)!=FR_OK){
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(_drive)
	LDI  R27,HIGH(_drive)
	CALL _f_mount
	CPI  R30,0
	BREQ _0x2E
; 0000 0071         EraseLCD();
	CALL SUBOPT_0x7
; 0000 0072         MoveCursor(0,0);
; 0000 0073         StringLCD("Drive no detectado");
	__POINTD2FN _0x0,0
	RCALL _StringLCD
; 0000 0074     }
; 0000 0075 }
_0x2E:
	RET
; .FEND
;void sd_closeDrive(){
; 0000 0076 void sd_closeDrive(){
_sd_closeDrive:
; .FSTART _sd_closeDrive
; 0000 0077     f_mount(0, 0); //Cerrar drive de SD
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _f_mount
; 0000 0078     EraseLCD();
	CALL SUBOPT_0x7
; 0000 0079     MoveCursor(0,0);
; 0000 007A     StringLCD("Drive cerrado");
	__POINTD2FN _0x0,19
	CALL SUBOPT_0x8
; 0000 007B     delay_ms(1000);
; 0000 007C }
	RET
; .FEND
;
;char j;
;int i;
;char encabezado[62];
;
;
;char output[64];
;
;void main(void) {
; 0000 0085 void main(void) {
_main:
; .FSTART _main
; 0000 0086     SetupLCD();
	CALL _SetupLCD
; 0000 0087     // ADC initialization
; 0000 0088     // ADC Clock frequency: 1000.000 kHz
; 0000 0089     // ADC Voltage Reference: Int., cap. on AREF
; 0000 008A     // ADC High Speed Mode: On
; 0000 008B     // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
; 0000 008C     // ADC4: On, ADC5: On, ADC6: On, ADC7: Off
; 0000 008D     CLKPR = 0x80;
	CALL SUBOPT_0x9
; 0000 008E     CLKPR = 0;
; 0000 008F     DIDR0=(1<<ADC7D) | (0<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
	LDI  R30,LOW(128)
	STS  126,R30
; 0000 0090     ADMUX=ADC_VREF_TYPE;
	LDI  R30,LOW(192)
	STS  124,R30
; 0000 0091     ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	LDI  R30,LOW(132)
	STS  122,R30
; 0000 0092     ADCSRB=(1<<ADHSM);
	LDI  R30,LOW(128)
	STS  123,R30
; 0000 0093 
; 0000 0094     // Trigger for scope shot
; 0000 0095     PORTD.7 = 1;
	SBI  0xB,7
; 0000 0096 
; 0000 0097     // SD
; 0000 0098     CLKPR=0x80;
	CALL SUBOPT_0x9
; 0000 0099     CLKPR=0;        //16 MHz
; 0000 009A 
; 0000 009B     // C�digo para hacer una interrupci�n peri�dica cada 10ms
; 0000 009C 
; 0000 009D     TCCR1B=0x0A;             //  CK/8
	LDI  R30,LOW(10)
	STS  129,R30
; 0000 009E     OCR1AH=19999/256;
	LDI  R30,LOW(78)
	STS  137,R30
; 0000 009F     OCR1AL=19999%256;
	LDI  R30,LOW(31)
	STS  136,R30
; 0000 00A0     TIMSK1=0x02;
	LDI  R30,LOW(2)
	STS  111,R30
; 0000 00A1     StringLCD("...");
	__POINTD2FN _0x0,33
	RCALL _StringLCD
; 0000 00A2     #asm("sei")
	sei
; 0000 00A3     disk_initialize(0);
	LDI  R26,LOW(0)
	RCALL _disk_initialize
; 0000 00A4     delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 00A5 
; 0000 00A6     while (1) {
_0x31:
; 0000 00A7     // Please write your application code here
; 0000 00A8     MoveCursor(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _MoveCursor
; 0000 00A9     StringLCD("Welcome");
	__POINTD2FN _0x0,37
	RCALL _StringLCD
; 0000 00AA         if (PIND.7 == 0){
	SBIC 0x9,7
	RJMP _0x34
; 0000 00AB             EraseLCD();
	RCALL _EraseLCD
; 0000 00AC             StringLCD("Starting     ");
	__POINTD2FN _0x0,45
	RCALL _StringLCD
; 0000 00AD             scope();
	RCALL _scope
; 0000 00AE             freq = frequency();
	RCALL _frequency
	__PUTW1R 5,6
; 0000 00AF             sd_openDrive();
	RCALL _sd_openDrive
; 0000 00B0             if(f_open(&archivo,"0:BASE.BMP", FA_OPEN_EXISTING | FA_READ)==FR_OK){
	CALL SUBOPT_0xA
	__POINTW1MN _0x36,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _f_open
	CPI  R30,0
	BREQ PC+2
	RJMP _0x35
; 0000 00B1                 f_read(&archivo, encabezado, 64, &br);
	CALL SUBOPT_0xA
	LDI  R30,LOW(_encabezado)
	LDI  R31,HIGH(_encabezado)
	CALL SUBOPT_0xB
	CALL _f_read
; 0000 00B2                 f_close(&archivo);
	LDI  R26,LOW(_archivo)
	LDI  R27,HIGH(_archivo)
	CALL _f_close
; 0000 00B3                 if (f_open(&archivo,fileName, FA_CREATE_ALWAYS | FA_WRITE)==FR_OK){
	CALL SUBOPT_0xA
	LDI  R30,LOW(_fileName)
	LDI  R31,HIGH(_fileName)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(10)
	CALL _f_open
	CPI  R30,0
	BREQ PC+2
	RJMP _0x37
; 0000 00B4                     f_write(&archivo,encabezado,sizeof(encabezado),&br);     //Escribir encabezado
	CALL SUBOPT_0xA
	LDI  R30,LOW(_encabezado)
	LDI  R31,HIGH(_encabezado)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(62)
	LDI  R31,HIGH(62)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	CALL _f_write
; 0000 00B5                     for (i=0;i<256;i++){
	CLR  R9
	CLR  R10
_0x39:
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CP   R9,R30
	CPC  R10,R31
	BRLT PC+2
	RJMP _0x3A
; 0000 00B6                         for(j=0; j<64; j++){
	CLR  R3
_0x3C:
	LDI  R30,LOW(64)
	CP   R3,R30
	BRSH _0x3D
; 0000 00B7                             output[j] = 0xFF;
	MOV  R30,R3
	LDI  R31,0
	SUBI R30,LOW(-_output)
	SBCI R31,HIGH(-_output)
	LDI  R26,LOW(255)
	STD  Z+0,R26
; 0000 00B8                         }
	INC  R3
	RJMP _0x3C
_0x3D:
; 0000 00B9                         for(j=0; j<128; j++){
	CLR  R3
_0x3F:
	LDI  R30,LOW(128)
	CP   R3,R30
	BRLO PC+2
	RJMP _0x40
; 0000 00BA                             if(buffer[j]*256/1024==i){
	MOV  R30,R3
	CALL SUBOPT_0x6
	CALL __GETW1P
	MOV  R31,R30
	LDI  R30,0
	MOVW R26,R30
	LDI  R30,LOW(1024)
	LDI  R31,HIGH(1024)
	CALL __DIVW21
	CP   R9,R30
	CPC  R10,R31
	BRNE _0x41
; 0000 00BB                                 if((j+1)%2==1){
	MOV  R30,R3
	LDI  R31,0
	ADIW R30,1
	MOVW R26,R30
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __MODW21
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x42
; 0000 00BC                                     output[j/2] = output[j/2] & 0x0F;
	CALL SUBOPT_0xC
	ANDI R30,LOW(0xF)
	RJMP _0x49
; 0000 00BD                                 }else{
_0x42:
; 0000 00BE                                     output[j/2] = output[j/2] & 0xF0;
	CALL SUBOPT_0xC
	ANDI R30,LOW(0xF0)
_0x49:
	MOVW R26,R22
	ST   X,R30
; 0000 00BF                                 }
; 0000 00C0                             }
; 0000 00C1                             if ((i>=10)&(i<=18)){
_0x41:
	__GETW2R 9,10
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __GEW12
	MOV  R0,R30
	LDI  R30,LOW(18)
	LDI  R31,HIGH(18)
	CALL __LEW12
	AND  R30,R0
	BREQ _0x44
; 0000 00C2                              output[1]=Letra0[18-i];
	CALL SUBOPT_0xD
	SUBI R30,LOW(-_Letra0*2)
	SBCI R31,HIGH(-_Letra0*2)
	SBCI R22,BYTE3(-_Letra0*2)
	__GETBRPF 0
	__PUTBR0MN _output,1
; 0000 00C3                              output[2]=Letra1[18-i];
	CALL SUBOPT_0xD
	SUBI R30,LOW(-_Letra1*2)
	SBCI R31,HIGH(-_Letra1*2)
	SBCI R22,BYTE3(-_Letra1*2)
	__GETBRPF 0
	__PUTBR0MN _output,2
; 0000 00C4                              output[3]=LetraH[18-i];
	CALL SUBOPT_0xD
	SUBI R30,LOW(-_LetraH*2)
	SBCI R31,HIGH(-_LetraH*2)
	SBCI R22,BYTE3(-_LetraH*2)
	__GETBRPF 0
	__PUTBR0MN _output,3
; 0000 00C5                              output[4]=LetraZ[18-i];
	CALL SUBOPT_0xD
	SUBI R30,LOW(-_LetraZ*2)
	SBCI R31,HIGH(-_LetraZ*2)
	SBCI R22,BYTE3(-_LetraZ*2)
	__GETBRPF 0
	__PUTBR0MN _output,4
; 0000 00C6                             }
; 0000 00C7                         }
_0x44:
	INC  R3
	RJMP _0x3F
_0x40:
; 0000 00C8                         f_write(&archivo,output,sizeof(output),&br);
	CALL SUBOPT_0xA
	LDI  R30,LOW(_output)
	LDI  R31,HIGH(_output)
	CALL SUBOPT_0xB
	CALL _f_write
; 0000 00C9                     }
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 9,10,30,31
	RJMP _0x39
_0x3A:
; 0000 00CA                     EraseLCD();
	RCALL _EraseLCD
; 0000 00CB                     StringLCD("Listo      ");
	__POINTD2FN _0x0,70
	RCALL _StringLCD
; 0000 00CC                     f_close(&archivo);
	LDI  R26,LOW(_archivo)
	LDI  R27,HIGH(_archivo)
	CALL _f_close
; 0000 00CD                     delay_ms(1000);
	RJMP _0x4A
; 0000 00CE                 }else{
_0x37:
; 0000 00CF                     EraseLCD();
	CALL SUBOPT_0x7
; 0000 00D0                     MoveCursor(0,0);
; 0000 00D1                     StringLCD("File error");
	__POINTD2FN _0x0,82
	RCALL _StringLCD
; 0000 00D2                     delay_ms(1000);
_0x4A:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 00D3                 }
; 0000 00D4             }else{
	RJMP _0x46
_0x35:
; 0000 00D5                EraseLCD();
	CALL SUBOPT_0x7
; 0000 00D6                MoveCursor(0,0);
; 0000 00D7                StringLCD("base.bmp error");
	__POINTD2FN _0x0,93
	CALL SUBOPT_0x8
; 0000 00D8                delay_ms(1000);
; 0000 00D9             }
_0x46:
; 0000 00DA             sd_closeDrive();
	RCALL _sd_closeDrive
; 0000 00DB             EraseLCD();
	RCALL _EraseLCD
; 0000 00DC         }
; 0000 00DD     }
_0x34:
	RJMP _0x31
; 0000 00DE }
_0x47:
	RJMP _0x47
; .FEND

	.DSEG
_0x36:
	.BYTE 0xB
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
_crc7_G100:
; .FSTART _crc7_G100
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R18,LOW(0)
	LDD  R16,Y+4
_0x2000005:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LD   R19,X+
	STD  Y+5,R26
	STD  Y+5+1,R27
	LDI  R17,LOW(8)
_0x2000008:
	LSL  R18
	MOV  R30,R18
	EOR  R30,R19
	ANDI R30,LOW(0x80)
	BREQ _0x200000A
	LDI  R30,LOW(9)
	EOR  R18,R30
_0x200000A:
	LSL  R19
	SUBI R17,LOW(1)
	BRNE _0x2000008
	SUBI R16,LOW(1)
	BRNE _0x2000005
	MOV  R30,R18
	LSL  R30
	ORI  R30,1
	CALL __LOADLOCR4
	RJMP _0x20A0013
; .FEND
_wait_ready_G100:
; .FSTART _wait_ready_G100
	ST   -Y,R17
	LDI  R30,LOW(50)
	STS  _timer2_G100,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x200000B:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200000B
_0x200000F:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000011:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000011
	IN   R17,46
	CPI  R17,255
	BREQ _0x2000014
	LDS  R30,_timer2_G100
	CPI  R30,0
	BRNE _0x2000015
_0x2000014:
	RJMP _0x2000010
_0x2000015:
	RJMP _0x200000F
_0x2000010:
	MOV  R30,R17
	RJMP _0x20A0014
; .FEND
_deselect_card_G100:
; .FSTART _deselect_card_G100
	SBI  0x5,0
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000016:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000016
	RET
; .FEND
_rx_datablock_G100:
; .FSTART _rx_datablock_G100
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R30,LOW(20)
	STS  _timer1_G100,R30
_0x200001A:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x200001C:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200001C
	IN   R17,46
	CPI  R17,255
	BRNE _0x200001F
	LDS  R30,_timer1_G100
	CPI  R30,0
	BRNE _0x2000020
_0x200001F:
	RJMP _0x200001B
_0x2000020:
	RJMP _0x200001A
_0x200001B:
	CPI  R17,254
	BREQ _0x2000021
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20A0016
_0x2000021:
	__GETWRS 18,19,6
_0x2000023:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000025:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000025
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000028:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000028
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x200002B:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200002B
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x200002E:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200002E
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0x2E
	POP  R26
	POP  R27
	ST   X,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,4
	STD  Y+4,R30
	STD  Y+4+1,R31
	BRNE _0x2000023
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000031:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000031
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000034:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000034
	LDI  R30,LOW(1)
	CALL __LOADLOCR4
	RJMP _0x20A0016
; .FEND
_tx_datablock_G100:
; .FSTART _tx_datablock_G100
	ST   -Y,R26
	CALL __SAVELOCR4
	RCALL _wait_ready_G100
	CPI  R30,LOW(0xFF)
	BREQ _0x2000037
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20A0013
_0x2000037:
	LDD  R30,Y+4
	OUT  0x2E,R30
_0x2000038:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000038
	LDD  R26,Y+4
	CPI  R26,LOW(0xFD)
	BREQ _0x200003B
	LDI  R16,LOW(0)
	__GETWRS 18,19,5
_0x200003D:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	OUT  0x2E,R30
_0x200003F:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200003F
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	OUT  0x2E,R30
_0x2000042:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000042
	SUBI R16,LOW(1)
	BRNE _0x200003D
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000045:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000045
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000048:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000048
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x200004B:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200004B
	IN   R17,46
	MOV  R30,R17
	ANDI R30,LOW(0x1F)
	CPI  R30,LOW(0x5)
	BREQ _0x200004E
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20A0013
_0x200004E:
_0x200003B:
	LDI  R30,LOW(1)
	CALL __LOADLOCR4
	RJMP _0x20A0013
; .FEND
_send_cmd_G100:
; .FSTART _send_cmd_G100
	CALL __PUTPARD2
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	ANDI R30,LOW(0x80)
	BREQ _0x200004F
	LDD  R30,Y+6
	ANDI R30,0x7F
	STD  Y+6,R30
	LDI  R30,LOW(119)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	MOV  R16,R30
	CPI  R16,2
	BRLO _0x2000050
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20A0013
_0x2000050:
_0x200004F:
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
	BREQ _0x2000051
	RCALL _deselect_card_G100
	CBI  0x5,0
	RCALL _wait_ready_G100
	CPI  R30,LOW(0xFF)
	BREQ _0x2000052
	LDI  R30,LOW(255)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20A0013
_0x2000052:
_0x2000051:
	LDD  R30,Y+6
	OUT  0x2E,R30
_0x2000053:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000053
	LDD  R30,Y+5
	OUT  0x2E,R30
_0x2000056:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000056
	LDD  R30,Y+4
	OUT  0x2E,R30
_0x2000059:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000059
	LDD  R30,Y+3
	OUT  0x2E,R30
_0x200005C:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200005C
	LDD  R30,Y+2
	OUT  0x2E,R30
_0x200005F:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200005F
	LDI  R17,LOW(1)
	LDD  R26,Y+6
	CPI  R26,LOW(0x40)
	BRNE _0x2000062
	LDI  R17,LOW(149)
	RJMP _0x2000063
_0x2000062:
	LDD  R26,Y+6
	CPI  R26,LOW(0x48)
	BRNE _0x2000064
	LDI  R17,LOW(135)
_0x2000064:
_0x2000063:
	OUT  0x2E,R17
_0x2000065:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000065
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
	BRNE _0x2000068
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000069:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000069
_0x2000068:
	LDI  R17,LOW(255)
_0x200006D:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x200006F:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x200006F
	IN   R16,46
	SBRS R16,7
	RJMP _0x2000072
	SUBI R17,LOW(1)
	BRNE _0x2000073
_0x2000072:
	RJMP _0x200006E
_0x2000073:
	RJMP _0x200006D
_0x200006E:
	MOV  R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20A0013
; .FEND
_rx_spi4_G100:
; .FSTART _rx_spi4_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDI  R17,4
_0x2000075:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000077:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000077
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,1
	STD  Y+1,R26
	STD  Y+1+1,R27
	SBIW R26,1
	IN   R30,0x2E
	ST   X,R30
	SUBI R17,LOW(1)
	BRNE _0x2000075
	RJMP _0x20A0011
; .FEND
_disk_initialize:
; .FSTART _disk_initialize
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x200007A
	LDI  R30,LOW(1)
	RJMP _0x20A0019
_0x200007A:
	CBI  0x4,4
	CBI  0x4,5
	LDI  R30,LOW(10)
	STS  _timer1_G100,R30
_0x200007B:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BRNE _0x200007B
	LDS  R30,_status_G100
	ANDI R30,LOW(0x2)
	BREQ _0x200007E
	RJMP _0x20A0018
_0x200007E:
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
	LDI  R30,LOW(83)
	OUT  0x2C,R30
	LDI  R30,LOW(0)
	OUT  0x2D,R30
	LDI  R19,LOW(255)
_0x2000080:
	LDI  R17,LOW(10)
_0x2000083:
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x2000085:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x2000085
	SUBI R17,LOW(1)
	BRNE _0x2000083
	LDI  R30,LOW(64)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	MOV  R16,R30
	SUBI R19,LOW(1)
	CPI  R16,1
	BREQ _0x2000088
	CPI  R19,0
	BRNE _0x2000089
_0x2000088:
	RJMP _0x2000081
_0x2000089:
	RJMP _0x2000080
_0x2000081:
	LDI  R19,LOW(0)
	CPI  R16,1
	BREQ PC+2
	RJMP _0x200008A
	LDI  R30,LOW(100)
	STS  _timer1_G100,R30
	LDI  R30,LOW(72)
	ST   -Y,R30
	__GETD2N 0x1AA
	RCALL _send_cmd_G100
	CPI  R30,LOW(0x1)
	BRNE _0x200008B
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G100
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x200008D
	LDD  R26,Y+7
	CPI  R26,LOW(0xAA)
	BREQ _0x200008E
_0x200008D:
	RJMP _0x200008C
_0x200008E:
_0x200008F:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x2000092
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x40000000
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x2000093
_0x2000092:
	RJMP _0x2000091
_0x2000093:
	RJMP _0x200008F
_0x2000091:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x2000095
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BREQ _0x2000096
_0x2000095:
	RJMP _0x2000094
_0x2000096:
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G100
	LDD  R30,Y+4
	ANDI R30,LOW(0x40)
	BREQ _0x2000097
	LDI  R30,LOW(12)
	RJMP _0x2000098
_0x2000097:
	LDI  R30,LOW(4)
_0x2000098:
	MOV  R19,R30
_0x2000094:
_0x200008C:
	RJMP _0x200009A
_0x200008B:
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,LOW(0x2)
	BRSH _0x200009B
	LDI  R19,LOW(2)
	LDI  R16,LOW(233)
	RJMP _0x200009C
_0x200009B:
	LDI  R19,LOW(1)
	LDI  R16,LOW(65)
_0x200009C:
_0x200009D:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x20000A0
	ST   -Y,R16
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000A1
_0x20000A0:
	RJMP _0x200009F
_0x20000A1:
	RJMP _0x200009D
_0x200009F:
	LDS  R30,_timer1_G100
	CPI  R30,0
	BREQ _0x20000A3
	LDI  R30,LOW(80)
	ST   -Y,R30
	__GETD2N 0x200
	RCALL _send_cmd_G100
	CPI  R30,0
	BREQ _0x20000A2
_0x20000A3:
	LDI  R19,LOW(0)
_0x20000A2:
_0x200009A:
_0x200008A:
	STS  _card_type_G100,R19
	RCALL _deselect_card_G100
	CPI  R19,0
	BREQ _0x20000A5
	LDS  R30,_status_G100
	ANDI R30,0xFE
	STS  _status_G100,R30
	LDI  R30,LOW(80)
	OUT  0x2C,R30
	LDI  R30,LOW(1)
	OUT  0x2D,R30
	RJMP _0x20000A6
_0x20000A5:
	CBI  0x5,0
	RCALL _wait_ready_G100
	RCALL _deselect_card_G100
	LDI  R30,LOW(0)
	OUT  0x2C,R30
	IN   R30,0x4
	ANDI R30,LOW(0xF0)
	OUT  0x4,R30
	IN   R30,0x5
	ANDI R30,LOW(0xF0)
	OUT  0x5,R30
	CBI  0x4,0
	LDS  R30,_status_G100
	ORI  R30,1
	STS  _status_G100,R30
_0x20000A6:
_0x20A0018:
	LDS  R30,_status_G100
_0x20A0019:
	CALL __LOADLOCR4
	ADIW R28,9
	RET
; .FEND
_disk_status:
; .FSTART _disk_status
	ST   -Y,R26
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20000A7
	LDI  R30,LOW(1)
	RJMP _0x20A0017
_0x20000A7:
	LDS  R30,_status_G100
_0x20A0017:
	ADIW R28,1
	RET
; .FEND
_disk_read:
; .FSTART _disk_read
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20000A9
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20000A8
_0x20000A9:
	LDI  R30,LOW(4)
	RJMP _0x20A0016
_0x20000A8:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x1)
	BREQ _0x20000AB
	LDI  R30,LOW(3)
	RJMP _0x20A0016
_0x20000AB:
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x8)
	BRNE _0x20000AC
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20000AC:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20000AD
	LDI  R30,LOW(81)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000AE
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000AF
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20000AF:
_0x20000AE:
	RJMP _0x20000B0
_0x20000AD:
	LDI  R30,LOW(82)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000B1
_0x20000B3:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000B4
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20000B3
_0x20000B4:
	LDI  R30,LOW(76)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
_0x20000B1:
_0x20000B0:
	RCALL _deselect_card_G100
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20000B6
	LDI  R30,LOW(1)
	RJMP _0x20000B7
_0x20000B6:
	LDI  R30,LOW(0)
_0x20000B7:
	RJMP _0x20A0016
; .FEND
_disk_write:
; .FSTART _disk_write
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20000BA
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20000B9
_0x20000BA:
	LDI  R30,LOW(4)
	RJMP _0x20A0016
_0x20000B9:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x1)
	BREQ _0x20000BC
	LDI  R30,LOW(3)
	RJMP _0x20A0016
_0x20000BC:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x4)
	BREQ _0x20000BD
	LDI  R30,LOW(2)
	RJMP _0x20A0016
_0x20000BD:
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x8)
	BRNE _0x20000BE
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20000BE:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20000BF
	LDI  R30,LOW(88)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000C0
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(254)
	RCALL _tx_datablock_G100
	CPI  R30,0
	BREQ _0x20000C1
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20000C1:
_0x20000C0:
	RJMP _0x20000C2
_0x20000BF:
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x6)
	BREQ _0x20000C3
	LDI  R30,LOW(215)
	ST   -Y,R30
	LDD  R26,Y+1
	CLR  R27
	CLR  R24
	CLR  R25
	RCALL _send_cmd_G100
_0x20000C3:
	LDI  R30,LOW(89)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000C4
_0x20000C6:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(252)
	RCALL _tx_datablock_G100
	CPI  R30,0
	BREQ _0x20000C7
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20000C6
_0x20000C7:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(253)
	RCALL _tx_datablock_G100
	CPI  R30,0
	BRNE _0x20000C9
	LDI  R30,LOW(1)
	ST   Y,R30
_0x20000C9:
_0x20000C4:
_0x20000C2:
	RCALL _deselect_card_G100
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20000CA
	LDI  R30,LOW(1)
	RJMP _0x20000CB
_0x20000CA:
	LDI  R30,LOW(0)
_0x20000CB:
_0x20A0016:
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
	BREQ _0x20000CD
	LDI  R30,LOW(4)
	RJMP _0x20A0015
_0x20000CD:
	LDS  R30,_status_G100
	ANDI R30,LOW(0x1)
	BREQ _0x20000CE
	LDI  R30,LOW(3)
	RJMP _0x20A0015
_0x20000CE:
	LDI  R17,LOW(1)
	LDD  R30,Y+22
	CPI  R30,0
	BRNE _0x20000D2
	CBI  0x5,0
	RCALL _wait_ready_G100
	CPI  R30,LOW(0xFF)
	BRNE _0x20000D3
	LDI  R17,LOW(0)
_0x20000D3:
	RJMP _0x20000D1
_0x20000D2:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x20000D4
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000D6
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BRNE _0x20000D7
_0x20000D6:
	RJMP _0x20000D5
_0x20000D7:
	LDD  R30,Y+4
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	CPI  R30,LOW(0x1)
	BRNE _0x20000D8
	LDI  R30,0
	LDD  R31,Y+12
	LDD  R26,Y+13
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	MOVW R18,R30
	MOVW R26,R18
	CLR  R24
	CLR  R25
	LDI  R30,LOW(10)
	RJMP _0x2000109
_0x20000D8:
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
	MOV  R16,R30
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
	MOVW R18,R30
	MOVW R26,R18
	CLR  R24
	CLR  R25
	MOV  R30,R16
	SUBI R30,LOW(9)
_0x2000109:
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20000D5:
	RJMP _0x20000D1
_0x20000D4:
	CPI  R30,LOW(0x2)
	BRNE _0x20000DA
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	ST   X+,R30
	ST   X,R31
	LDI  R17,LOW(0)
	RJMP _0x20000D1
_0x20000DA:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x20000DB
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x4)
	BREQ _0x20000DC
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000DD
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x20000DE:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x20000DE
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000E1
	LDI  R16,LOW(48)
_0x20000E3:
	CPI  R16,0
	BREQ _0x20000E4
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x20000E5:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x20000E5
	SUBI R16,1
	RJMP _0x20000E3
_0x20000E4:
	LDD  R30,Y+14
	SWAP R30
	ANDI R30,0xF
	__GETD2N 0x10
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20000E1:
_0x20000DD:
	RJMP _0x20000E8
_0x20000DC:
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BREQ PC+2
	RJMP _0x20000E9
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20000EA
	LDS  R30,_card_type_G100
	ANDI R30,LOW(0x2)
	BREQ _0x20000EB
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
	RJMP _0x200010A
_0x20000EB:
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
_0x200010A:
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20000EA:
_0x20000E9:
_0x20000E8:
	RJMP _0x20000D1
_0x20000DB:
	CPI  R30,LOW(0xA)
	BRNE _0x20000ED
	LDS  R30,_card_type_G100
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ST   X,R30
	LDI  R17,LOW(0)
	RJMP _0x20000D1
_0x20000ED:
	CPI  R30,LOW(0xB)
	BRNE _0x20000EE
	LDI  R16,LOW(73)
	RJMP _0x20000EF
_0x20000EE:
	CPI  R30,LOW(0xC)
	BRNE _0x20000F1
	LDI  R16,LOW(74)
_0x20000EF:
	ST   -Y,R16
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000F2
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000F3
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(15)
	RCALL _crc7_G100
	MOV  R26,R30
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	LDD  R30,Z+15
	CP   R30,R26
	BRNE _0x20000F4
	LDI  R17,LOW(0)
_0x20000F4:
_0x20000F3:
_0x20000F2:
	RJMP _0x20000D1
_0x20000F1:
	CPI  R30,LOW(0xD)
	BRNE _0x20000F5
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000F6
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	RCALL _rx_spi4_G100
	LDI  R17,LOW(0)
_0x20000F6:
	RJMP _0x20000D1
_0x20000F5:
	CPI  R30,LOW(0xE)
	BRNE _0x20000FD
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G100
	CPI  R30,0
	BRNE _0x20000F8
	LDI  R30,LOW(255)
	OUT  0x2E,R30
_0x20000F9:
	IN   R30,0x2D
	SBRS R30,7
	RJMP _0x20000F9
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(64)
	LDI  R27,0
	RCALL _rx_datablock_G100
	CPI  R30,0
	BREQ _0x20000FC
	LDI  R17,LOW(0)
_0x20000FC:
_0x20000F8:
	RJMP _0x20000D1
_0x20000FD:
	LDI  R17,LOW(4)
_0x20000D1:
	RCALL _deselect_card_G100
	MOV  R30,R17
_0x20A0015:
	CALL __LOADLOCR4
	ADIW R28,24
	RET
; .FEND
_disk_timerproc:
; .FSTART _disk_timerproc

	.DSEG

	.CSEG
	ST   -Y,R17
	LDS  R17,_timer1_G100
	CPI  R17,0
	BREQ _0x20000FF
	SUBI R17,LOW(1)
	STS  _timer1_G100,R17
_0x20000FF:
	LDS  R17,_timer2_G100
	CPI  R17,0
	BREQ _0x2000100
	SUBI R17,LOW(1)
	STS  _timer2_G100,R17
_0x2000100:
	LDS  R17,_flags_S100000C000
	LDI  R30,LOW(0)
	STS  _flags_S100000C000,R30
	SBIC 0x3,4
	RJMP _0x2000101
	LDI  R30,LOW(1)
	STS  _flags_S100000C000,R30
_0x2000101:
	SBIS 0x3,5
	RJMP _0x2000102
	LDS  R30,_flags_S100000C000
	ORI  R30,2
	STS  _flags_S100000C000,R30
_0x2000102:
	LDS  R30,_flags_S100000C000
	CP   R30,R17
	BRNE _0x2000103
	LDS  R17,_status_G100
	ANDI R30,LOW(0x1)
	BREQ _0x2000104
	ANDI R17,LOW(253)
	RJMP _0x2000105
_0x2000104:
	ORI  R17,LOW(3)
_0x2000105:
	LDS  R30,_flags_S100000C000
	ANDI R30,LOW(0x2)
	BREQ _0x2000106
	ORI  R17,LOW(4)
	RJMP _0x2000107
_0x2000106:
	ANDI R17,LOW(251)
_0x2000107:
	STS  _status_G100,R17
_0x2000103:
_0x20A0014:
	LD   R17,Y+
	RET
; .FEND

	.CSEG
_get_fattime:
; .FSTART _get_fattime
	SBIW R28,7
	LDS  R26,_prtc_get_time
	LDS  R27,_prtc_get_time+1
	SBIW R26,0
	BREQ _0x2020004
	LDS  R26,_prtc_get_date
	LDS  R27,_prtc_get_date+1
	SBIW R26,0
	BRNE _0x2020003
_0x2020004:
	__GETD1N 0x3A210000
	RJMP _0x20A0013
_0x2020003:
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
	CALL SUBOPT_0xE
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
	CALL SUBOPT_0xE
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
	CALL SUBOPT_0xE
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
_0x20A0013:
	ADIW R28,7
	RET
; .FEND
_chk_chrf_G101:
; .FSTART _chk_chrf_G101
	ST   -Y,R26
	ST   -Y,R17
_0x2020006:
	CALL SUBOPT_0xF
	__GETBRPF 30
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2020009
	LDD  R30,Y+1
	CP   R30,R17
	BRNE _0x202000A
_0x2020009:
	RJMP _0x2020008
_0x202000A:
	MOVW R26,R28
	ADIW R26,2
	CALL __GETD1P_INC
	__ADDD1N 1
	CALL __PUTDP1_DEC
	__SUBD1N 1
	RJMP _0x2020006
_0x2020008:
	MOV  R30,R17
	LDI  R31,0
	LDD  R17,Y+0
	ADIW R28,6
	RET
; .FEND
_move_window_G101:
; .FSTART _move_window_G101
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,46
	CALL __GETD1P
	CALL SUBOPT_0x10
	CALL SUBOPT_0x11
	CALL SUBOPT_0x12
	CALL __CPD12
	BRNE PC+2
	RJMP _0x202000B
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x202000C
	CALL SUBOPT_0x13
	CPI  R30,0
	BRNE _0x20A0012
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x14
	MOVW R0,R26
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	MOVW R26,R0
	CALL __ADDD12
	CALL SUBOPT_0x12
	CALL __CPD21
	BRSH _0x202000E
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R17,Z+3
_0x2020010:
	CPI  R17,2
	BRLO _0x2020011
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	CALL SUBOPT_0x12
	CALL __ADDD12
	CALL SUBOPT_0x10
	CALL SUBOPT_0x13
	SUBI R17,1
	RJMP _0x2020010
_0x2020011:
_0x202000E:
_0x202000C:
	CALL SUBOPT_0x11
	CALL __CPD10
	BREQ _0x2020012
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x15
	CALL SUBOPT_0x16
	BREQ _0x2020013
_0x20A0012:
	LDI  R30,LOW(1)
	LDD  R17,Y+0
	ADIW R28,11
	RET
_0x2020013:
	CALL SUBOPT_0x11
	__PUTD1SNS 9,46
_0x2020012:
_0x202000B:
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x20A000D
; .FEND
_sync_G101:
; .FSTART _sync_G101
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x17
	MOV  R17,R30
	CPI  R17,0
	BREQ PC+2
	RJMP _0x2020014
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R26,X
	CPI  R26,LOW(0x3)
	BRNE _0x2020016
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LDD  R30,Z+5
	CPI  R30,0
	BRNE _0x2020017
_0x2020016:
	RJMP _0x2020015
_0x2020017:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL SUBOPT_0x18
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x19
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
	CALL SUBOPT_0x1A
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	__GETD2N 0x61417272
	CALL SUBOPT_0x1A
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,14
	CALL SUBOPT_0x1B
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,10
	CALL SUBOPT_0x1B
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x1C
	RCALL _disk_write
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020015:
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
	BREQ _0x2020018
	LDI  R17,LOW(1)
_0x2020018:
_0x2020014:
	MOV  R30,R17
_0x20A0011:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_get_fat:
; .FSTART _get_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR4
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x1E
	BRLO _0x202001A
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x1D
	CALL __CPD21
	BRLO _0x2020019
_0x202001A:
	CALL SUBOPT_0x1F
	RJMP _0x20A0010
_0x2020019:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,34
	CALL SUBOPT_0x20
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x202001F
	__GETWRS 18,19,8
	MOVW R30,R18
	LSR  R31
	ROR  R30
	__ADDWRR 18,19,30,31
	CALL SUBOPT_0x21
	BREQ _0x2020020
	RJMP _0x202001E
_0x2020020:
	CALL SUBOPT_0x22
	LD   R16,X
	CLR  R17
	__ADDWRN 18,19,1
	CALL SUBOPT_0x21
	BRNE _0x202001E
	CALL SUBOPT_0x22
	LD   R30,X
	MOV  R31,R30
	LDI  R30,0
	__ORWRR 16,17,30,31
	LDD  R30,Y+8
	ANDI R30,LOW(0x1)
	BREQ _0x2020022
	MOVW R30,R16
	CALL __LSRW4
	RJMP _0x202027A
_0x2020022:
	MOVW R30,R16
	ANDI R31,HIGH(0xFFF)
_0x202027A:
	CLR  R22
	CLR  R23
	RJMP _0x20A0010
_0x202001F:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2020025
	CALL SUBOPT_0x23
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	BRNE _0x202001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0x26
	CALL SUBOPT_0x27
	RJMP _0x20A0010
_0x2020025:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x202001E
	CALL SUBOPT_0x23
	CALL SUBOPT_0x28
	CALL SUBOPT_0x25
	BRNE _0x202001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0x26
	CALL __GETD1P
	__ANDD1N 0xFFFFFFF
	RJMP _0x20A0010
_0x202001E:
	CALL SUBOPT_0x29
_0x20A0010:
	CALL __LOADLOCR4
	ADIW R28,14
	RET
; .FEND
_put_fat:
; .FSTART _put_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR6
	CALL SUBOPT_0x2A
	CALL SUBOPT_0x1E
	BRLO _0x202002A
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x2A
	CALL __CPD21
	BRLO _0x2020029
_0x202002A:
	LDI  R21,LOW(2)
	RJMP _0x202002C
_0x2020029:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,34
	CALL __GETD1P
	__PUTD1S 6
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x2020030
	__GETWRS 16,17,14
	MOVW R30,R16
	LSR  R31
	ROR  R30
	__ADDWRR 16,17,30,31
	CALL SUBOPT_0x2B
	BREQ _0x2020031
	RJMP _0x202002F
_0x2020031:
	CALL SUBOPT_0x2C
	BREQ _0x2020032
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LDD  R30,Y+10
	LDI  R31,0
	CALL __LSLW4
	OR   R30,R26
	RJMP _0x2020033
_0x2020032:
	LDD  R30,Y+10
_0x2020033:
	MOVW R26,R18
	ST   X,R30
	__ADDWRN 16,17,1
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	CALL SUBOPT_0x2B
	BREQ _0x2020035
	RJMP _0x202002F
_0x2020035:
	CALL SUBOPT_0x2C
	BREQ _0x2020036
	CALL SUBOPT_0x2D
	LDI  R30,LOW(4)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	RJMP _0x2020037
_0x2020036:
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF0)
	MOV  R1,R30
	CALL SUBOPT_0x2D
	LDI  R30,LOW(8)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	ANDI R30,LOW(0xF)
	OR   R30,R1
_0x2020037:
	MOVW R26,R18
	ST   X,R30
	RJMP _0x202002F
_0x2020030:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2020039
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x24
	CALL SUBOPT_0x2F
	BRNE _0x202002F
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0x30
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	STD  Z+0,R26
	STD  Z+1,R27
	RJMP _0x202002F
_0x2020039:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x202003D
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x28
	CALL SUBOPT_0x2F
	BRNE _0x202002F
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0x30
	CALL SUBOPT_0x2D
	CALL __PUTDZ20
	RJMP _0x202002F
_0x202003D:
	LDI  R21,LOW(2)
_0x202002F:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
_0x202002C:
	MOV  R30,R21
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_remove_chain_G101:
; .FSTART _remove_chain_G101
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	CALL SUBOPT_0x31
	CALL SUBOPT_0x1E
	BRLO _0x202003F
	CALL SUBOPT_0x32
	BRLO _0x202003E
_0x202003F:
	LDI  R17,LOW(2)
	RJMP _0x2020041
_0x202003E:
	LDI  R17,LOW(0)
_0x2020042:
	CALL SUBOPT_0x32
	BRLO PC+2
	RJMP _0x2020044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 7
	RCALL _get_fat
	CALL SUBOPT_0x10
	__GETD1S 1
	CALL __CPD10
	BREQ _0x2020044
	CALL SUBOPT_0x12
	CALL SUBOPT_0x33
	BRNE _0x2020046
	LDI  R17,LOW(2)
	RJMP _0x2020044
_0x2020046:
	CALL SUBOPT_0x12
	CALL SUBOPT_0x34
	BRNE _0x2020047
	LDI  R17,LOW(1)
	RJMP _0x2020044
_0x2020047:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 7
	CALL __PUTPARD1
	CALL SUBOPT_0x35
	RCALL _put_fat
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x2020044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x36
	BREQ _0x2020049
	CALL SUBOPT_0x37
	ADIW R26,5
	LDI  R30,LOW(1)
	ST   X,R30
_0x2020049:
	__GETD1S 1
	__PUTD1S 5
	RJMP _0x2020042
_0x2020044:
_0x2020041:
	MOV  R30,R17
	LDD  R17,Y+0
	RJMP _0x20A000D
; .FEND
_create_chain_G101:
; .FSTART _create_chain_G101
	CALL __PUTPARD2
	SBIW R28,16
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x38
	CALL SUBOPT_0x39
	CALL __CPD10
	BRNE _0x202004A
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,10
	CALL SUBOPT_0x20
	CALL SUBOPT_0x3A
	CALL __CPD02
	BREQ _0x202004C
	CALL SUBOPT_0x3B
	CALL SUBOPT_0x3A
	CALL __CPD21
	BRLO _0x202004B
_0x202004C:
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x3C
_0x202004B:
	RJMP _0x202004E
_0x202004A:
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x3E
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x40
	CALL SUBOPT_0x1E
	BRSH _0x202004F
	CALL SUBOPT_0x1F
	RJMP _0x20A000F
_0x202004F:
	CALL SUBOPT_0x3B
	CALL SUBOPT_0x40
	CALL __CPD21
	BRSH _0x2020050
	CALL SUBOPT_0x41
	RJMP _0x20A000F
_0x2020050:
	CALL SUBOPT_0x39
	CALL SUBOPT_0x3C
_0x202004E:
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
_0x2020052:
	CALL SUBOPT_0x15
	__SUBD1N -1
	CALL SUBOPT_0x43
	CALL SUBOPT_0x3B
	CALL SUBOPT_0x1D
	CALL __CPD21
	BRLO _0x2020054
	__GETD1N 0x2
	CALL SUBOPT_0x43
	CALL SUBOPT_0x44
	BRSH _0x2020055
	CALL SUBOPT_0x45
	RJMP _0x20A000F
_0x2020055:
_0x2020054:
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x46
	BREQ _0x2020053
	CALL SUBOPT_0x40
	CALL SUBOPT_0x34
	BREQ _0x2020058
	CALL SUBOPT_0x40
	CALL SUBOPT_0x33
	BRNE _0x2020057
_0x2020058:
	CALL SUBOPT_0x41
	RJMP _0x20A000F
_0x2020057:
	CALL SUBOPT_0x44
	BRNE _0x202005A
	CALL SUBOPT_0x45
	RJMP _0x20A000F
_0x202005A:
	RJMP _0x2020052
_0x2020053:
	CALL SUBOPT_0x3D
	__GETD1S 10
	CALL __PUTPARD1
	__GETD2N 0xFFFFFFF
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x202005B
	CALL SUBOPT_0x29
	RJMP _0x20A000F
_0x202005B:
	CALL SUBOPT_0x39
	CALL __CPD10
	BREQ _0x202005C
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x47
	CALL __PUTPARD1
	CALL SUBOPT_0x2A
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x202005D
	CALL SUBOPT_0x29
	RJMP _0x20A000F
_0x202005D:
_0x202005C:
	CALL SUBOPT_0x15
	__PUTD1SNS 20,10
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	CALL SUBOPT_0x36
	BREQ _0x202005E
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
_0x202005E:
	CALL SUBOPT_0x15
_0x20A000F:
	ADIW R28,22
	RET
; .FEND
_clust2sect:
; .FSTART _clust2sect
	CALL __PUTPARD2
	CALL SUBOPT_0x3B
	__SUBD1N 2
	CALL SUBOPT_0x38
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	__GETD2Z 30
	__GETD1N 0x2
	CALL SUBOPT_0x48
	CALL __GETD2S0
	CALL __CPD21
	BRLO _0x202005F
	CALL SUBOPT_0x45
	RJMP _0x20A0009
_0x202005F:
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
	RJMP _0x20A0009
; .FEND
_dir_seek_G101:
; .FSTART _dir_seek_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__PUTW1SNS 8,4
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,6
	CALL SUBOPT_0x49
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x33
	BREQ _0x2020061
	CALL SUBOPT_0x4B
	CALL SUBOPT_0x4C
	BRLO _0x2020060
_0x2020061:
	LDI  R30,LOW(2)
	RJMP _0x20A000E
_0x2020060:
	CALL SUBOPT_0xF
	CALL __CPD10
	BRNE _0x2020064
	CALL SUBOPT_0x4B
	LD   R26,Z
	CPI  R26,LOW(0x3)
	BREQ _0x2020065
_0x2020064:
	RJMP _0x2020063
_0x2020065:
	CALL SUBOPT_0x4B
	ADIW R30,38
	MOVW R26,R30
	CALL SUBOPT_0x49
_0x2020063:
	CALL SUBOPT_0xF
	CALL __CPD10
	BRNE _0x2020066
	CALL SUBOPT_0x4D
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2020067
	LDI  R30,LOW(2)
	RJMP _0x20A000E
_0x2020067:
	CALL SUBOPT_0x4B
	ADIW R30,38
	MOVW R26,R30
	CALL __GETD1P
	RJMP _0x202027B
_0x2020066:
	CALL SUBOPT_0x4B
	LDD  R30,Z+2
	LDI  R26,LOW(16)
	MUL  R30,R26
	MOVW R16,R0
_0x2020069:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R16
	CPC  R27,R17
	BRLO _0x202006B
	CALL SUBOPT_0x4B
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x3A
	RCALL _get_fat
	__PUTD1S 2
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x34
	BRNE _0x202006C
	LDI  R30,LOW(1)
	RJMP _0x20A000E
_0x202006C:
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x1E
	BRLO _0x202006E
	CALL SUBOPT_0x4B
	CALL SUBOPT_0x4C
	BRLO _0x202006D
_0x202006E:
	LDI  R30,LOW(2)
	RJMP _0x20A000E
_0x202006D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUB  R30,R16
	SBC  R31,R17
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2020069
_0x202006B:
	CALL SUBOPT_0x4D
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x3A
	RCALL _clust2sect
_0x202027B:
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __LSRW4
	CALL SUBOPT_0x4E
	__PUTD1SNS 8,14
	CALL SUBOPT_0x4B
	ADIW R30,50
	MOVW R26,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x4F
	__PUTW1SNS 8,18
	LDI  R30,LOW(0)
_0x20A000E:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
_dir_next_G101:
; .FSTART _dir_next_G101
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,4
	CALL __GETW1P
	ADIW R30,1
	MOVW R16,R30
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2020071
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,14
	CALL SUBOPT_0x50
	BRNE _0x2020070
_0x2020071:
	LDI  R30,LOW(4)
	RJMP _0x20A000C
_0x2020070:
	MOVW R30,R16
	ANDI R30,LOW(0xF)
	BREQ PC+2
	RJMP _0x2020073
	CALL SUBOPT_0x37
	ADIW R26,10
	CALL SUBOPT_0x50
	BRNE _0x2020074
	CALL SUBOPT_0x51
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	CP   R16,R30
	CPC  R17,R31
	BRLO _0x2020075
	LDI  R30,LOW(4)
	RJMP _0x20A000C
_0x2020075:
	RJMP _0x2020076
_0x2020074:
	MOVW R30,R16
	CALL __LSRW4
	MOVW R0,R30
	CALL SUBOPT_0x51
	LDD  R30,Z+2
	LDI  R31,0
	SBIW R30,1
	AND  R30,R0
	AND  R31,R1
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2020077
	CALL SUBOPT_0x51
	CALL SUBOPT_0x52
	RCALL _get_fat
	CALL SUBOPT_0x3C
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x1E
	BRSH _0x2020078
	LDI  R30,LOW(2)
	RJMP _0x20A000C
_0x2020078:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x34
	BRNE _0x2020079
	LDI  R30,LOW(1)
	RJMP _0x20A000C
_0x2020079:
	CALL SUBOPT_0x51
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x3A
	CALL __CPD21
	BRSH PC+2
	RJMP _0x202007A
	LDD  R30,Y+8
	CPI  R30,0
	BRNE _0x202007B
	LDI  R30,LOW(4)
	RJMP _0x20A000C
_0x202007B:
	CALL SUBOPT_0x51
	CALL SUBOPT_0x52
	RCALL _create_chain_G101
	CALL SUBOPT_0x53
	CALL __CPD10
	BRNE _0x202007C
	LDI  R30,LOW(7)
	RJMP _0x20A000C
_0x202007C:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x33
	BRNE _0x202007D
	LDI  R30,LOW(2)
	RJMP _0x20A000C
_0x202007D:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x34
	BRNE _0x202007E
	LDI  R30,LOW(1)
	RJMP _0x20A000C
_0x202007E:
	CALL SUBOPT_0x51
	CALL SUBOPT_0x17
	CPI  R30,0
	BREQ _0x202007F
	LDI  R30,LOW(1)
	RJMP _0x20A000C
_0x202007F:
	CALL SUBOPT_0x51
	CALL SUBOPT_0x19
	CALL SUBOPT_0x51
	MOVW R26,R30
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R30,R26
	CALL SUBOPT_0x54
	POP  R26
	POP  R27
	CALL __PUTDP1
	LDI  R19,LOW(0)
_0x2020081:
	CALL SUBOPT_0x51
	LDD  R30,Z+2
	CP   R19,R30
	BRSH _0x2020082
	CALL SUBOPT_0x51
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0x51
	CALL SUBOPT_0x17
	CPI  R30,0
	BREQ _0x2020083
	LDI  R30,LOW(1)
	RJMP _0x20A000C
_0x2020083:
	CALL SUBOPT_0x51
	ADIW R30,46
	MOVW R26,R30
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
	SUBI R19,-1
	RJMP _0x2020081
_0x2020082:
	CALL SUBOPT_0x51
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __GETD1P
	MOVW R26,R30
	MOVW R24,R22
	MOV  R30,R19
	LDI  R31,0
	CALL __CWD1
	CALL SUBOPT_0x48
	POP  R26
	POP  R27
	CALL __PUTDP1
_0x202007A:
	CALL SUBOPT_0x42
	__PUTD1SNS 9,10
	CALL SUBOPT_0x51
	CALL SUBOPT_0x54
	__PUTD1SNS 9,14
_0x2020077:
_0x2020076:
_0x2020073:
	MOVW R30,R16
	__PUTW1SNS 9,4
	CALL SUBOPT_0x51
	ADIW R30,50
	MOVW R26,R30
	MOVW R30,R16
	CALL SUBOPT_0x4F
	__PUTW1SNS 9,18
	LDI  R30,LOW(0)
_0x20A000C:
	CALL __LOADLOCR4
_0x20A000D:
	ADIW R28,11
	RET
; .FEND
_dir_find_G101:
; .FSTART _dir_find_G101
	CALL SUBOPT_0x55
	BREQ _0x2020084
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x20A0009
_0x2020084:
_0x2020086:
	CALL SUBOPT_0x56
	BRNE _0x2020087
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	MOVW R26,R18
	LD   R16,X
	CPI  R16,0
	BRNE _0x2020089
	LDI  R17,LOW(4)
	RJMP _0x2020087
_0x2020089:
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x8)
	BRNE _0x202008B
	CALL SUBOPT_0x57
	CALL _memcmp
	CPI  R30,0
	BREQ _0x202008C
_0x202008B:
	RJMP _0x202008A
_0x202008C:
	RJMP _0x2020087
_0x202008A:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _dir_next_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020086
_0x2020087:
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x20A0009
; .FEND
_dir_register_G101:
; .FSTART _dir_register_G101
	CALL SUBOPT_0x55
	BRNE _0x2020099
_0x202009B:
	CALL SUBOPT_0x56
	BRNE _0x202009C
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Z+18
	LDD  R27,Z+19
	LD   R16,X
	CPI  R16,229
	BREQ _0x202009F
	CPI  R16,0
	BRNE _0x202009E
_0x202009F:
	RJMP _0x202009C
_0x202009E:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _dir_next_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x202009B
_0x202009C:
_0x2020099:
	CPI  R17,0
	BRNE _0x20200A1
	CALL SUBOPT_0x56
	BRNE _0x20200A2
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
	CALL SUBOPT_0x57
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
_0x20200A2:
_0x20200A1:
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x20A0009
; .FEND
_create_name_G101:
; .FSTART _create_name_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,5
	CALL __SAVELOCR6
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	ADIW R26,20
	LD   R20,X+
	LD   R21,X
	ST   -Y,R21
	ST   -Y,R20
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R26,LOW(11)
	LDI  R27,0
	CALL _memset
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOV  R17,R30
	MOV  R18,R30
	LDI  R30,LOW(8)
	STD  Y+10,R30
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	CALL SUBOPT_0x58
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x2E)
	BRNE _0x20200A5
_0x20200A7:
	CALL SUBOPT_0x59
	CPI  R16,46
	BRNE _0x20200AA
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,3
	BRLT _0x20200A9
_0x20200AA:
	RJMP _0x20200A8
_0x20200A9:
	CALL SUBOPT_0x5A
	RJMP _0x20200A7
_0x20200A8:
	CPI  R16,47
	BREQ _0x20200AD
	CPI  R16,92
	BREQ _0x20200AD
	CPI  R16,33
	BRSH _0x20200AE
_0x20200AD:
	RJMP _0x20200AC
_0x20200AE:
	LDI  R30,LOW(6)
	RJMP _0x20A000A
_0x20200AC:
	CALL SUBOPT_0x58
	CALL SUBOPT_0x5B
	BRSH _0x20200AF
	LDI  R30,LOW(36)
	RJMP _0x20200B0
_0x20200AF:
	LDI  R30,LOW(32)
_0x20200B0:
	__PUTB1RNS 20,11
	RJMP _0x20A000B
_0x20200A5:
_0x20200B3:
	CALL SUBOPT_0x59
	CPI  R16,33
	BRLO _0x20200B6
	CPI  R16,47
	BREQ _0x20200B6
	CPI  R16,92
	BRNE _0x20200B5
_0x20200B6:
	RJMP _0x20200B4
_0x20200B5:
	CPI  R16,46
	BREQ _0x20200B9
	LDD  R30,Y+10
	CP   R18,R30
	BRLO _0x20200B8
_0x20200B9:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20200BC
	CPI  R16,46
	BREQ _0x20200BB
_0x20200BC:
	LDI  R30,LOW(6)
	RJMP _0x20A000A
_0x20200BB:
	LDI  R18,LOW(8)
	LDI  R30,LOW(11)
	STD  Y+10,R30
	LSL  R17
	LSL  R17
	RJMP _0x20200B2
_0x20200B8:
	CPI  R16,128
	BRLO _0x20200BE
	ORI  R17,LOW(3)
	LDI  R30,LOW(6)
	RJMP _0x20A000A
_0x20200BE:
	__POINTD1FN _k1,0
	CALL __PUTPARD1
	MOV  R26,R16
	RCALL _chk_chrf_G101
	SBIW R30,0
	BREQ _0x20200C4
	LDI  R30,LOW(6)
	RJMP _0x20A000A
_0x20200C4:
	CPI  R16,65
	BRLO _0x20200C6
	CPI  R16,91
	BRLO _0x20200C7
_0x20200C6:
	RJMP _0x20200C5
_0x20200C7:
	ORI  R17,LOW(2)
	RJMP _0x20200C8
_0x20200C5:
	CPI  R16,97
	BRLO _0x20200CA
	CPI  R16,123
	BRLO _0x20200CB
_0x20200CA:
	RJMP _0x20200C9
_0x20200CB:
	ORI  R17,LOW(1)
	SUBI R16,LOW(32)
_0x20200C9:
_0x20200C8:
	CALL SUBOPT_0x5A
_0x20200B2:
	RJMP _0x20200B3
_0x20200B4:
	CALL SUBOPT_0x58
	CALL SUBOPT_0x5B
	BRSH _0x20200CC
	LDI  R30,LOW(4)
	RJMP _0x20200CD
_0x20200CC:
	LDI  R30,LOW(0)
_0x20200CD:
	MOV  R16,R30
	CPI  R18,0
	BRNE _0x20200CF
	LDI  R30,LOW(6)
	RJMP _0x20A000A
_0x20200CF:
	MOVW R26,R20
	LD   R26,X
	CPI  R26,LOW(0xE5)
	BRNE _0x20200D0
	MOVW R26,R20
	LDI  R30,LOW(5)
	ST   X,R30
_0x20200D0:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20200D1
	LSL  R17
	LSL  R17
_0x20200D1:
	MOV  R30,R17
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x1)
	BRNE _0x20200D2
	ORI  R16,LOW(16)
_0x20200D2:
	MOV  R30,R17
	ANDI R30,LOW(0xC)
	CPI  R30,LOW(0x4)
	BRNE _0x20200D3
	ORI  R16,LOW(8)
_0x20200D3:
	MOVW R30,R20
	__PUTBZR 16,11
_0x20A000B:
	LDI  R30,LOW(0)
_0x20A000A:
	CALL __LOADLOCR6
	ADIW R28,15
	RET
; .FEND
_follow_path_G101:
; .FSTART _follow_path_G101
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
_0x20200E9:
	LDI  R30,LOW(1)
	CPI  R30,0
	BREQ _0x20200EC
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x20)
	BREQ _0x20200ED
_0x20200EC:
	RJMP _0x20200EB
_0x20200ED:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	RJMP _0x20200E9
_0x20200EB:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x2F)
	BREQ _0x20200EF
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x5C)
	BRNE _0x20200EE
_0x20200EF:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,6
	CALL SUBOPT_0x5C
	RJMP _0x20200F1
_0x20200EE:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL __GETW1P
	ADIW R30,22
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x5D
_0x20200F1:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CLR  R27
	SBIW R26,32
	BRSH _0x20200F2
	CALL SUBOPT_0x5E
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _dir_seek_G101
	MOV  R17,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	CALL SUBOPT_0x5F
	RJMP _0x20200F3
_0x20200F2:
_0x20200F5:
	CALL SUBOPT_0x5E
	MOVW R26,R28
	ADIW R26,6
	RCALL _create_name_G101
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x20200F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL _dir_find_G101
	MOV  R17,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,20
	CALL __GETW1P
	LDD  R30,Z+11
	ANDI R30,LOW(0x4)
	MOV  R16,R30
	CPI  R17,0
	BREQ _0x20200F8
	CPI  R17,4
	BRNE _0x20200FA
	CPI  R16,0
	BREQ _0x20200FB
_0x20200FA:
	RJMP _0x20200F9
_0x20200FB:
	LDI  R17,LOW(5)
_0x20200F9:
	RJMP _0x20200F6
_0x20200F8:
	CPI  R16,0
	BRNE _0x20200F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BRNE _0x20200FD
	LDI  R17,LOW(5)
	RJMP _0x20200F6
_0x20200FD:
	CALL SUBOPT_0x60
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x61
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x62
	CALL SUBOPT_0x5D
	RJMP _0x20200F5
_0x20200F6:
_0x20200F3:
	MOV  R30,R17
	CALL __LOADLOCR4
	ADIW R28,8
	RET
; .FEND
_check_fs_G101:
; .FSTART _check_fs_G101
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
	CALL SUBOPT_0x16
	BREQ _0x20200FE
	LDI  R30,LOW(3)
	RJMP _0x20A0009
_0x20200FE:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x63
	BREQ _0x20200FF
	LDI  R30,LOW(2)
	RJMP _0x20A0009
_0x20200FF:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SUBI R26,LOW(-104)
	SBCI R27,HIGH(-104)
	CALL SUBOPT_0x64
	BRNE _0x2020100
	LDI  R30,LOW(0)
	RJMP _0x20A0009
_0x2020100:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,50
	SUBI R30,LOW(-82)
	SBCI R31,HIGH(-82)
	MOVW R26,R30
	CALL SUBOPT_0x64
	BRNE _0x2020101
	LDI  R30,LOW(0)
	RJMP _0x20A0009
_0x2020101:
	LDI  R30,LOW(1)
_0x20A0009:
	ADIW R28,6
	RET
; .FEND
_chk_mounted:
; .FSTART _chk_mounted
	ST   -Y,R26
	SBIW R28,20
	CALL __SAVELOCR6
	LDD  R26,Y+29
	LDD  R27,Y+29+1
	CALL __GETW1P
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LD   R30,X
	SUBI R30,LOW(48)
	MOV  R16,R30
	CPI  R16,10
	BRSH _0x2020103
	ADIW R26,1
	LD   R26,X
	CPI  R26,LOW(0x3A)
	BREQ _0x2020104
_0x2020103:
	RJMP _0x2020102
_0x2020104:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,2
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+29
	LDD  R27,Y+29+1
	ST   X+,R30
	ST   X,R31
	RJMP _0x2020105
_0x2020102:
	LDS  R16,_Drive_G101
_0x2020105:
	CPI  R16,1
	BRLO _0x2020106
	LDI  R30,LOW(11)
	RJMP _0x20A0007
_0x2020106:
	MOV  R30,R16
	CALL SUBOPT_0x65
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+27
	LDD  R27,Y+27+1
	ST   X+,R30
	ST   X,R31
	SBIW R30,0
	BRNE _0x2020107
	LDI  R30,LOW(12)
	RJMP _0x20A0007
_0x2020107:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2020108
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	CALL _disk_status
	MOV  R21,R30
	SBRC R21,0
	RJMP _0x2020109
	LDD  R30,Y+26
	CPI  R30,0
	BREQ _0x202010B
	SBRC R21,2
	RJMP _0x202010C
_0x202010B:
	RJMP _0x202010A
_0x202010C:
	LDI  R30,LOW(10)
	RJMP _0x20A0007
_0x202010A:
	RJMP _0x20A0008
_0x2020109:
_0x2020108:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOV  R30,R16
	__PUTB1SNS 6,1
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	CALL _disk_initialize
	MOV  R21,R30
	SBRS R21,0
	RJMP _0x202010D
	LDI  R30,LOW(3)
	RJMP _0x20A0007
_0x202010D:
	LDD  R30,Y+26
	CPI  R30,0
	BREQ _0x202010F
	SBRC R21,2
	RJMP _0x2020110
_0x202010F:
	RJMP _0x202010E
_0x2020110:
	LDI  R30,LOW(10)
	RJMP _0x20A0007
_0x202010E:
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x45
	__PUTD1S 24
	MOVW R26,R30
	MOVW R24,R22
	RCALL _check_fs_G101
	MOV  R17,R30
	CPI  R17,1
	BRNE _0x2020111
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-446)
	SBCI R31,HIGH(-446)
	MOVW R18,R30
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x2020112
	MOVW R26,R18
	ADIW R26,8
	CALL __GETD1P
	__PUTD1S 22
	CALL SUBOPT_0x5E
	__GETD2S 24
	RCALL _check_fs_G101
	MOV  R17,R30
_0x2020112:
_0x2020111:
	CPI  R17,3
	BRNE _0x2020113
	LDI  R30,LOW(1)
	RJMP _0x20A0007
_0x2020113:
	CPI  R17,0
	BRNE _0x2020115
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,61
	CALL __GETW1P
	CPI  R30,LOW(0x200)
	LDI  R26,HIGH(0x200)
	CPC  R31,R26
	BREQ _0x2020114
_0x2020115:
	LDI  R30,LOW(13)
	RJMP _0x20A0007
_0x2020114:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-72)
	SBCI R27,HIGH(-72)
	CALL SUBOPT_0x27
	CALL SUBOPT_0x66
	CALL SUBOPT_0x47
	CALL __CPD10
	BRNE _0x2020117
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-86)
	SBCI R27,HIGH(-86)
	CALL __GETD1P
	CALL SUBOPT_0x66
_0x2020117:
	CALL SUBOPT_0x47
	__PUTD1SNS 6,26
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-66)
	SBCI R31,HIGH(-66)
	LD   R30,Z
	__PUTB1SNS 6,3
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+3
	LDI  R31,0
	CALL SUBOPT_0x3E
	CALL __CWD1
	CALL __MULD12U
	CALL SUBOPT_0x66
	CALL SUBOPT_0x67
	CALL SUBOPT_0x68
	__PUTD1SNS 6,34
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+63
	__PUTB1SNS 6,2
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-67)
	SBCI R27,HIGH(-67)
	CALL __GETW1P
	__PUTW1SNS 6,8
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-69)
	SBCI R27,HIGH(-69)
	CALL SUBOPT_0x27
	__PUTD1S 14
	CALL __CPD10
	BRNE _0x2020118
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-82)
	SBCI R27,HIGH(-82)
	CALL __GETD1P
	__PUTD1S 14
_0x2020118:
	CALL SUBOPT_0x67
	CALL SUBOPT_0x2A
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x48
	CALL SUBOPT_0x3E
	CALL __SUBD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x69
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CLR  R22
	CLR  R23
	CALL __SUBD21
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+2
	LDI  R31,0
	CALL __CWD1
	CALL __DIVD21U
	__ADDD1N 2
	__PUTD1S 10
	__PUTD1SNS 6,30
	LDI  R17,LOW(1)
	CALL SUBOPT_0x2D
	__CPD2N 0xFF7
	BRLO _0x2020119
	LDI  R17,LOW(2)
_0x2020119:
	CALL SUBOPT_0x2D
	__CPD2N 0xFFF7
	BRLO _0x202011A
	LDI  R17,LOW(3)
_0x202011A:
	CPI  R17,3
	BRNE _0x202011B
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-94)
	SBCI R27,HIGH(-94)
	CALL __GETD1P
	RJMP _0x202027C
_0x202011B:
	CALL SUBOPT_0x6A
_0x202027C:
	__PUTD1SNS 6,38
	CALL SUBOPT_0x6A
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x69
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x4E
	__PUTD1SNS 6,42
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,14
	CALL SUBOPT_0x29
	CALL __PUTDP1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	CPI  R17,3
	BREQ PC+2
	RJMP _0x202011D
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,5
	ST   X,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-98)
	SBCI R27,HIGH(-98)
	CALL __GETW1P
	CALL SUBOPT_0x68
	__PUTD1SNS 6,18
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x1C
	CALL _disk_read
	CPI  R30,0
	BRNE _0x202011F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x63
	BRNE _0x202011F
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,50
	CALL __GETD1P
	__CPD1N 0x41615252
	BRNE _0x202011F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	MOVW R26,R30
	CALL __GETD1P
	__CPD1N 0x61417272
	BREQ _0x2020120
_0x202011F:
	RJMP _0x202011E
_0x2020120:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 6,10
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 6,14
_0x202011E:
_0x202011D:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ST   X,R17
	CALL SUBOPT_0x18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,22
	CALL SUBOPT_0x5C
	LDI  R26,LOW(_Fsid_G101)
	LDI  R27,HIGH(_Fsid_G101)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	__PUTW1SNS 6,6
_0x20A0008:
	LDI  R30,LOW(0)
_0x20A0007:
	CALL __LOADLOCR6
	ADIW R28,31
	RET
; .FEND
_validate_G101:
; .FSTART _validate_G101
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2020122
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2020122
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+6
	LDD  R27,Z+7
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x2020121
_0x2020122:
	LDI  R30,LOW(9)
	RJMP _0x20A0006
_0x2020121:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+1
	CALL _disk_status
	ANDI R30,LOW(0x1)
	BREQ _0x2020124
	LDI  R30,LOW(3)
	RJMP _0x20A0006
_0x2020124:
	LDI  R30,LOW(0)
_0x20A0006:
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
	BRLO _0x2020125
	LDI  R30,LOW(11)
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
_0x2020125:
	LDD  R30,Y+4
	CALL SUBOPT_0x65
	LD   R16,X+
	LD   R17,X
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2020126
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020126:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2020127
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020127:
	LDD  R30,Y+4
	LDI  R26,LOW(_FatFs_G101)
	LDI  R27,HIGH(_FatFs_G101)
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
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0001
; .FEND
_f_open:
; .FSTART _f_open
	ST   -Y,R26
	SBIW R28,34
	CALL __SAVELOCR4
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	CALL SUBOPT_0x5F
	LDD  R30,Y+38
	ANDI R30,LOW(0x1F)
	STD  Y+38,R30
	MOVW R30,R28
	ADIW R30,39
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,18
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+42
	ANDI R30,LOW(0x1E)
	MOV  R26,R30
	RCALL _chk_mounted
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020128
	RJMP _0x20A0005
_0x2020128:
	MOVW R30,R28
	ADIW R30,4
	STD  Y+36,R30
	STD  Y+36+1,R31
	MOVW R30,R28
	ADIW R30,16
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	RCALL _follow_path_G101
	MOV  R17,R30
	LDD  R30,Y+38
	ANDI R30,LOW(0x1C)
	BRNE PC+2
	RJMP _0x2020129
	SBIW R28,8
	CPI  R17,0
	BREQ _0x202012A
	CPI  R17,4
	BRNE _0x202012B
	MOVW R26,R28
	ADIW R26,24
	RCALL _dir_register_G101
	MOV  R17,R30
_0x202012B:
	CPI  R17,0
	BREQ _0x202012C
	MOV  R30,R17
	ADIW R28,8
	RJMP _0x20A0005
_0x202012C:
	LDD  R30,Y+46
	ORI  R30,8
	STD  Y+46,R30
	__GETWRS 18,19,42
	RJMP _0x202012D
_0x202012A:
	LDD  R30,Y+46
	ANDI R30,LOW(0x4)
	BREQ _0x202012E
	LDI  R30,LOW(8)
	ADIW R28,8
	RJMP _0x20A0005
_0x202012E:
	__GETWRS 18,19,42
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x2020130
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x11)
	BREQ _0x202012F
_0x2020130:
	LDI  R30,LOW(7)
	ADIW R28,8
	RJMP _0x20A0005
_0x202012F:
	LDD  R30,Y+46
	ANDI R30,LOW(0x8)
	BRNE PC+2
	RJMP _0x2020132
	CALL SUBOPT_0x60
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x61
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x62
	CALL SUBOPT_0x38
	MOVW R30,R18
	ADIW R30,20
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	STD  Z+0,R26
	STD  Z+1,R27
	MOVW R30,R18
	ADIW R30,26
	STD  Z+0,R26
	STD  Z+1,R27
	MOVW R30,R18
	ADIW R30,28
	CALL SUBOPT_0x35
	CALL __PUTDZ20
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,46
	CALL SUBOPT_0x20
	CALL SUBOPT_0x3B
	CALL __CPD10
	BREQ _0x2020133
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x4A
	RCALL _remove_chain_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020134
	ADIW R28,8
	RJMP _0x20A0005
_0x2020134:
	CALL SUBOPT_0x3B
	__SUBD1N 1
	__PUTD1SNS 24,10
_0x2020133:
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 6
	CALL _move_window_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2020135
	ADIW R28,8
	RJMP _0x20A0005
_0x2020135:
_0x2020132:
_0x202012D:
	LDD  R30,Y+46
	ANDI R30,LOW(0x8)
	BREQ _0x2020136
	MOVW R30,R18
	ADIW R30,11
	LDI  R26,LOW(0)
	STD  Z+0,R26
	CALL _get_fattime
	CALL SUBOPT_0x53
	__PUTD1RNS 18,14
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R30,Y+46
	ORI  R30,0x20
	STD  Y+46,R30
_0x2020136:
	ADIW R28,8
	RJMP _0x2020137
_0x2020129:
	CPI  R17,0
	BREQ _0x2020138
	MOV  R30,R17
	RJMP _0x20A0005
_0x2020138:
	__GETWRS 18,19,34
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x202013A
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BREQ _0x2020139
_0x202013A:
	LDI  R30,LOW(4)
	RJMP _0x20A0005
_0x2020139:
	LDD  R30,Y+38
	ANDI R30,LOW(0x2)
	BREQ _0x202013D
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x1)
	BRNE _0x202013E
_0x202013D:
	RJMP _0x202013C
_0x202013E:
	LDI  R30,LOW(7)
	RJMP _0x20A0005
_0x202013C:
_0x2020137:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,46
	CALL __GETD1P
	__PUTD1SNS 41,26
	LDD  R30,Y+34
	LDD  R31,Y+34+1
	__PUTW1SNS 41,30
	LDD  R30,Y+38
	__PUTB1SNS 41,4
	CALL SUBOPT_0x60
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x61
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x62
	__PUTD1SNS 41,14
	MOVW R26,R18
	ADIW R26,28
	CALL __GETD1P
	__PUTD1SNS 41,10
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,6
	CALL SUBOPT_0x5C
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,5
	LDI  R30,LOW(255)
	ST   X,R30
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,22
	CALL SUBOPT_0x5C
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ST   X+,R30
	ST   X,R31
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,6
	CALL __GETW1P
	__PUTW1SNS 41,2
	LDI  R30,LOW(0)
_0x20A0005:
	CALL __LOADLOCR4
	ADIW R28,43
	RET
; .FEND
_f_read:
; .FSTART _f_read
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,14
	CALL __SAVELOCR6
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6D
	BREQ _0x202013F
	MOV  R30,R17
	RJMP _0x20A0004
_0x202013F:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x2020140
	LDI  R30,LOW(2)
	RJMP _0x20A0004
_0x2020140:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x1)
	BRNE _0x2020141
	LDI  R30,LOW(7)
	RJMP _0x20A0004
_0x2020141:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	__GETD2Z 10
	PUSH R25
	PUSH R24
	PUSH R27
	PUSH R26
	CALL SUBOPT_0x6E
	POP  R30
	POP  R31
	POP  R22
	POP  R23
	CALL __SUBD12
	CALL SUBOPT_0x43
	CALL SUBOPT_0x15
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CLR  R24
	CLR  R25
	CALL __CPD12
	BRSH _0x2020142
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	STD  Y+22,R30
	STD  Y+22+1,R31
_0x2020142:
_0x2020144:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	SBIW R30,0
	BRNE PC+2
	RJMP _0x2020145
	CALL SUBOPT_0x6E
	MOVW R30,R26
	MOVW R22,R24
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2020146
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R0,Z+5
	CALL SUBOPT_0x6B
	LDD  R30,Z+2
	CP   R0,R30
	BRLO _0x2020147
	CALL SUBOPT_0x6E
	CALL __CPD02
	BRNE _0x2020148
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ADIW R26,14
	CALL __GETD1P
	RJMP _0x2020149
_0x2020148:
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6F
	CALL _get_fat
_0x2020149:
	__PUTD1S 16
	__GETD2S 16
	CALL SUBOPT_0x1E
	BRSH _0x202014B
	CALL SUBOPT_0x70
	LDI  R30,LOW(2)
	RJMP _0x20A0004
_0x202014B:
	__GETD2S 16
	CALL SUBOPT_0x34
	BRNE _0x202014C
	CALL SUBOPT_0x70
	LDI  R30,LOW(1)
	RJMP _0x20A0004
_0x202014C:
	CALL SUBOPT_0x39
	__PUTD1SNS 26,18
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020147:
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6F
	RCALL _clust2sect
	CALL SUBOPT_0x71
	CALL SUBOPT_0x46
	BRNE _0x202014D
	CALL SUBOPT_0x70
	LDI  R30,LOW(2)
	RJMP _0x20A0004
_0x202014D:
	CALL SUBOPT_0x72
	CALL SUBOPT_0x40
	CALL __CWD1
	CALL __ADDD12
	CALL SUBOPT_0x71
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x73
	BRNE PC+2
	RJMP _0x202014E
	CALL SUBOPT_0x72
	ADD  R30,R20
	ADC  R31,R21
	MOVW R0,R30
	CALL SUBOPT_0x6B
	LDD  R30,Z+2
	MOVW R26,R0
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x202014F
	CALL SUBOPT_0x6B
	LDD  R30,Z+2
	LDI  R31,0
	MOVW R26,R30
	CALL SUBOPT_0x72
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
_0x202014F:
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x74
	__GETD1S 15
	CALL __PUTPARD1
	MOV  R26,R20
	CALL _disk_read
	CPI  R30,0
	BREQ _0x2020150
	CALL SUBOPT_0x70
	LDI  R30,LOW(1)
	RJMP _0x20A0004
_0x2020150:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2020152
	CALL SUBOPT_0x75
	CALL SUBOPT_0x76
	BRLO _0x2020153
_0x2020152:
	RJMP _0x2020151
_0x2020153:
	CALL SUBOPT_0x75
	CALL SUBOPT_0x77
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CLR  R24
	CLR  R25
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x6C
	ADIW R30,32
	CALL SUBOPT_0x78
_0x2020151:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL SUBOPT_0x79
	RJMP _0x2020143
_0x202014E:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2020154
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x7A
	LDD  R30,Y+29
	LDD  R31,Y+29+1
	CALL SUBOPT_0x7B
	BREQ _0x2020155
	CALL SUBOPT_0x70
	LDI  R30,LOW(1)
	RJMP _0x20A0004
_0x2020155:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL SUBOPT_0x7C
_0x2020154:
	CALL SUBOPT_0x75
	CALL __CPD12
	BREQ _0x2020156
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x7A
	__GETD1S 15
	CALL SUBOPT_0x16
	BREQ _0x2020157
	CALL SUBOPT_0x70
	LDI  R30,LOW(1)
	RJMP _0x20A0004
_0x2020157:
_0x2020156:
	CALL SUBOPT_0x41
	__PUTD1SNS 26,22
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ADIW R26,5
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
_0x2020146:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL SUBOPT_0x7D
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	SUB  R26,R30
	SBC  R27,R31
	MOVW R18,R26
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	CP   R30,R18
	CPC  R31,R19
	BRSH _0x2020158
	__GETWRS 18,19,22
_0x2020158:
	CALL SUBOPT_0x5E
	LDD  R26,Y+28
	LDD  R27,Y+28+1
	CALL SUBOPT_0x7D
	LDD  R26,Y+28
	LDD  R27,Y+28+1
	ADIW R26,32
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	CALL _memcpy
_0x2020143:
	CALL SUBOPT_0x7E
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	CALL SUBOPT_0x7F
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL SUBOPT_0x80
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	SUB  R30,R18
	SBC  R31,R19
	STD  Y+22,R30
	STD  Y+22+1,R31
	RJMP _0x2020144
_0x2020145:
	LDI  R30,LOW(0)
_0x20A0004:
	CALL __LOADLOCR6
	ADIW R28,28
	RET
; .FEND
_f_write:
; .FSTART _f_write
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	CALL __SAVELOCR6
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x81
	CALL SUBOPT_0x82
	CALL SUBOPT_0x6D
	BREQ _0x2020159
	MOV  R30,R17
	RJMP _0x20A0003
_0x2020159:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x202015A
	LDI  R30,LOW(2)
	RJMP _0x20A0003
_0x202015A:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	BRNE _0x202015B
	LDI  R30,LOW(7)
	RJMP _0x20A0003
_0x202015B:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 10
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	CALL SUBOPT_0x4E
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x83
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x202015C
	LDI  R30,LOW(0)
	STD  Y+18,R30
	STD  Y+18+1,R30
_0x202015C:
_0x202015E:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	SBIW R30,0
	BRNE PC+2
	RJMP _0x202015F
	CALL SUBOPT_0x84
	MOVW R30,R26
	MOVW R22,R24
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2020160
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R0,Z+5
	CALL SUBOPT_0x81
	LDD  R30,Z+2
	CP   R0,R30
	BRSH PC+2
	RJMP _0x2020161
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,6
	CALL SUBOPT_0x50
	BRNE _0x2020162
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,14
	CALL __GETD1P
	CALL SUBOPT_0x71
	CALL SUBOPT_0x46
	BRNE _0x2020163
	CALL SUBOPT_0x81
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x35
	CALL _create_chain_G101
	CALL SUBOPT_0x71
	__PUTD1SNS 22,14
_0x2020163:
	RJMP _0x2020164
_0x2020162:
	CALL SUBOPT_0x81
	CALL SUBOPT_0x82
	CALL SUBOPT_0x6F
	CALL _create_chain_G101
	CALL SUBOPT_0x71
_0x2020164:
	CALL SUBOPT_0x46
	BRNE _0x2020165
	RJMP _0x202015F
_0x2020165:
	CALL SUBOPT_0x40
	CALL SUBOPT_0x33
	BRNE _0x2020166
	CALL SUBOPT_0x85
	LDI  R30,LOW(2)
	RJMP _0x20A0003
_0x2020166:
	CALL SUBOPT_0x40
	CALL SUBOPT_0x34
	BRNE _0x2020167
	CALL SUBOPT_0x85
	LDI  R30,LOW(1)
	RJMP _0x20A0003
_0x2020167:
	CALL SUBOPT_0x41
	__PUTD1SNS 22,18
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2020161:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2020168
	CALL SUBOPT_0x81
	CALL SUBOPT_0x86
	LDD  R30,Y+25
	LDD  R31,Y+25+1
	CALL SUBOPT_0x7B
	BREQ _0x2020169
	CALL SUBOPT_0x85
	LDI  R30,LOW(1)
	RJMP _0x20A0003
_0x2020169:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x7C
_0x2020168:
	CALL SUBOPT_0x81
	CALL SUBOPT_0x82
	CALL SUBOPT_0x6F
	CALL _clust2sect
	CALL SUBOPT_0x43
	CALL SUBOPT_0x15
	CALL __CPD10
	BRNE _0x202016A
	CALL SUBOPT_0x85
	LDI  R30,LOW(2)
	RJMP _0x20A0003
_0x202016A:
	CALL SUBOPT_0x87
	CALL SUBOPT_0x1D
	CALL __CWD1
	CALL __ADDD12
	CALL SUBOPT_0x43
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	CALL SUBOPT_0x73
	BRNE PC+2
	RJMP _0x202016B
	CALL SUBOPT_0x87
	ADD  R30,R20
	ADC  R31,R21
	MOVW R0,R30
	CALL SUBOPT_0x81
	LDD  R30,Z+2
	MOVW R26,R0
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x202016C
	CALL SUBOPT_0x81
	LDD  R30,Z+2
	LDI  R31,0
	MOVW R26,R30
	CALL SUBOPT_0x87
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
_0x202016C:
	CALL SUBOPT_0x81
	CALL SUBOPT_0x74
	__GETD1S 11
	CALL __PUTPARD1
	MOV  R26,R20
	CALL _disk_write
	CPI  R30,0
	BREQ _0x202016D
	CALL SUBOPT_0x85
	LDI  R30,LOW(1)
	RJMP _0x20A0003
_0x202016D:
	CALL SUBOPT_0x88
	CALL SUBOPT_0x76
	BRSH _0x202016E
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0x82
	__GETD2Z 22
	__GETD1S 10
	CALL SUBOPT_0x77
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CLR  R24
	CLR  R25
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x78
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x7C
_0x202016E:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x79
	RJMP _0x202015D
_0x202016B:
	CALL SUBOPT_0x88
	CALL __CPD12
	BREQ _0x202016F
	CALL SUBOPT_0x84
	MOVW R0,R26
	CALL SUBOPT_0x83
	MOVW R26,R0
	CALL __CPD21
	BRSH _0x2020171
	CALL SUBOPT_0x81
	CALL SUBOPT_0x86
	__GETD1S 11
	CALL SUBOPT_0x16
	BRNE _0x2020172
_0x2020171:
	RJMP _0x2020170
_0x2020172:
	CALL SUBOPT_0x85
	LDI  R30,LOW(1)
	RJMP _0x20A0003
_0x2020170:
_0x202016F:
	CALL SUBOPT_0x15
	__PUTD1SNS 22,22
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,5
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
_0x2020160:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x7D
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	SUB  R26,R30
	SBC  R27,R31
	MOVW R18,R26
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	CP   R30,R18
	CPC  R31,R19
	BRSH _0x2020173
	__GETWRS 18,19,18
_0x2020173:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x7D
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,32
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	CALL _memcpy
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x40
	ST   X,R30
_0x202015D:
	CALL SUBOPT_0x7E
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	CALL SUBOPT_0x7F
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	CALL SUBOPT_0x80
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	SUB  R30,R18
	SBC  R31,R19
	STD  Y+18,R30
	STD  Y+18+1,R31
	RJMP _0x202015E
_0x202015F:
	CALL SUBOPT_0x84
	MOVW R0,R26
	CALL SUBOPT_0x83
	MOVW R26,R0
	CALL __CPD12
	BRSH _0x2020174
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,6
	CALL __GETD1P
	__PUTD1SNS 22,10
_0x2020174:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
	LDI  R30,LOW(0)
_0x20A0003:
	CALL __LOADLOCR6
	ADIW R28,24
	RET
; .FEND
_f_sync:
; .FSTART _f_sync
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	CALL SUBOPT_0x4B
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL SUBOPT_0x6D
	BREQ PC+2
	RJMP _0x2020175
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x20)
	BRNE PC+2
	RJMP _0x2020176
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2020177
	CALL SUBOPT_0x4B
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CALL SUBOPT_0x7B
	BREQ _0x2020178
	LDI  R30,LOW(1)
	RJMP _0x20A0002
_0x2020178:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CALL SUBOPT_0x7C
_0x2020177:
	CALL SUBOPT_0x4B
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	__GETD2Z 26
	CALL _move_window_G101
	MOV  R17,R30
	CPI  R17,0
	BREQ PC+2
	RJMP _0x2020179
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,30
	LD   R18,X+
	LD   R19,X
	MOVW R26,R18
	ADIW R26,11
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,10
	CALL __GETD1P
	__PUTD1RNS 18,28
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,14
	CALL __GETW1P
	__PUTW1RNS 18,26
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	__GETD2Z 14
	MOVW R30,R26
	MOVW R22,R24
	CALL __LSRD16
	__PUTW1RNS 18,20
	CALL _get_fattime
	CALL SUBOPT_0x53
	__PUTD1RNS 18,22
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xDF
	ST   X,R30
	CALL SUBOPT_0x4B
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0x4B
	MOVW R26,R30
	CALL _sync_G101
	MOV  R17,R30
_0x2020179:
_0x2020176:
_0x2020175:
	MOV  R30,R17
_0x20A0002:
	CALL __LOADLOCR4
	ADIW R28,10
	RET
; .FEND
_f_close:
; .FSTART _f_close
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _f_sync
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x202017A
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL SUBOPT_0x5F
_0x202017A:
	MOV  R30,R17
	LDD  R17,Y+0
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

	.CSEG

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
_0x20A0001:
	ADIW R28,5
	RET
; .FEND

	.CSEG

	.DSEG
_prtc_get_time:
	.BYTE 0x2
_prtc_get_date:
	.BYTE 0x2
_buffer:
	.BYTE 0x100
_fileName:
	.BYTE 0xC
_drive:
	.BYTE 0x232
_archivo:
	.BYTE 0x220
_encabezado:
	.BYTE 0x3E
_output:
	.BYTE 0x40
_status_G100:
	.BYTE 0x1
_timer1_G100:
	.BYTE 0x1
_timer2_G100:
	.BYTE 0x1
_card_type_G100:
	.BYTE 0x1
_flags_S100000C000:
	.BYTE 0x1
_FatFs_G101:
	.BYTE 0x2
_Fsid_G101:
	.BYTE 0x2
_Drive_G101:
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
	MOV  R17,R30
	SWAP R17
	ANDI R17,0xF
	MOV  R26,R17
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LDD  R30,Y+1
	ANDI R30,LOW(0xF)
	MOV  R17,R30
	MOV  R26,R17
	CALL _SendDataBitsLCD
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	__GETD2S 1
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5:
	MOV  R30,R17
	LDI  R26,LOW(_buffer)
	LDI  R27,HIGH(_buffer)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	MOV  R26,R16
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	LDI  R26,LOW(_buffer)
	LDI  R27,HIGH(_buffer)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x7:
	CALL _EraseLCD
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _MoveCursor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	CALL _StringLCD
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(128)
	STS  97,R30
	LDI  R30,LOW(0)
	STS  97,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(_archivo)
	LDI  R31,HIGH(_archivo)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC:
	MOV  R26,R3
	LDI  R27,0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	SUBI R30,LOW(-_output)
	SBCI R31,HIGH(-_output)
	MOVW R22,R30
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(18)
	LDI  R31,HIGH(18)
	SUB  R30,R9
	SBC  R31,R10
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDI  R31,0
	CALL __CWD1
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xF:
	__GETD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	__PUTD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	__GETD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x12:
	__GETD2S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x13:
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
SUBOPT_0x14:
	__GETD2Z 34
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x15:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x16:
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x17:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2N 0x0
	JMP  _move_window_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x18:
	ADIW R26,46
	__GETD1N 0x0
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x19:
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	JMP  _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1A:
	CALL __PUTDZ20
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1B:
	CALL __GETD1P
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1C:
	__GETD2Z 18
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x1D:
	__GETD2S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x1E:
	__CPD2N 0x2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	__GETD1N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x20:
	CALL __GETD1P
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x21:
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
	CALL _move_window_G101
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x22:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	MOVW R30,R18
	ANDI R31,HIGH(0x1FF)
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x23:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x24:
	__GETD1N 0x100
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x25:
	__GETD2S 6
	CALL __ADDD21
	CALL _move_window_G101
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x26:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x27:
	CALL __GETW1P
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	__GETD1N 0x80
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x29:
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2A:
	__GETD2S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x2B:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R16
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	RCALL SUBOPT_0x1D
	CLR  R22
	CLR  R23
	CALL __ADDD21
	CALL _move_window_G101
	MOV  R21,R30
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2C:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,50
	MOVW R30,R16
	ANDI R31,HIGH(0x1FF)
	ADD  R30,R26
	ADC  R31,R27
	MOVW R18,R30
	LDD  R30,Y+14
	ANDI R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2D:
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2E:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2F:
	RCALL SUBOPT_0x1D
	CALL __ADDD21
	CALL _move_window_G101
	MOV  R21,R30
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x30:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,50
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x31:
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x32:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,30
	CALL __GETD1P
	RCALL SUBOPT_0x31
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x33:
	__CPD2N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x34:
	__CPD2N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x35:
	__GETD2N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x36:
	__GETD2Z 14
	RJMP SUBOPT_0x34

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x37:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,14
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x38:
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x39:
	__GETD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x3A:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3B:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3C:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3D:
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3E:
	__GETD2S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3F:
	CALL _get_fat
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x40:
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x41:
	__GETD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x42:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x43:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x44:
	RCALL SUBOPT_0x42
	RCALL SUBOPT_0x1D
	CALL __CPD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x45:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x46:
	RCALL SUBOPT_0x41
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x47:
	__GETD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x48:
	CALL __SWAPD12
	CALL __SUBD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x49:
	CALL __GETD1P
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4A:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x4B:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4C:
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	RCALL SUBOPT_0x4A
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4D:
	RCALL SUBOPT_0xF
	__PUTD1SNS 8,10
	RJMP SUBOPT_0x4B

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4E:
	CLR  R22
	CLR  R23
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4F:
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	LSL  R30
	CALL __LSLW4
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x50:
	CALL __GETD1P
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x51:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x52:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	__GETD2Z 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x53:
	RCALL SUBOPT_0x3C
	RJMP SUBOPT_0x42

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x54:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 6
	JMP  _clust2sect

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x55:
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _dir_seek_G101
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x56:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__GETD2Z 14
	CALL _move_window_G101
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x57:
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x58:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x59:
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
	LD   R16,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5A:
	MOV  R30,R18
	SUBI R18,-1
	LDI  R31,0
	ADD  R30,R20
	ADC  R31,R21
	ST   Z,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5B:
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	ST   X+,R30
	ST   X,R31
	CPI  R16,33
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5C:
	RCALL SUBOPT_0x45
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5D:
	__PUTD1SNS 6,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5E:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5F:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x60:
	MOVW R26,R18
	ADIW R26,20
	RJMP SUBOPT_0x27

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x61:
	MOVW R26,R18
	ADIW R26,26
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x62:
	CLR  R22
	CLR  R23
	CALL __ORD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x63:
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
SUBOPT_0x64:
	CALL __GETD1P
	__ANDD1N 0xFFFFFF
	__CPD1N 0x544146
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x65:
	LDI  R26,LOW(_FatFs_G101)
	LDI  R27,HIGH(_FatFs_G101)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x66:
	__PUTD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x67:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-64)
	SBCI R27,HIGH(-64)
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x68:
	__GETD2S 22
	RJMP SUBOPT_0x4E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x69:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+8
	LDD  R27,Z+9
	MOVW R30,R26
	CALL __LSRW4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6A:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x47
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6B:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6C:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+28
	LDD  R31,Y+28+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6D:
	LDD  R26,Z+2
	LDD  R27,Z+3
	CALL _validate_G101
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6E:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	__GETD2Z 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6F:
	__GETD2Z 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x70:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x71:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x72:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R30,Z+5
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x73:
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	MOVW R20,R30
	MOV  R0,R20
	OR   R0,R21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x74:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x75:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	__GETD2Z 22
	RJMP SUBOPT_0x41

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x76:
	CALL __SUBD21
	MOVW R30,R20
	CLR  R22
	CLR  R23
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x77:
	CALL __SUBD21
	__GETD1N 0x200
	CALL __MULD12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x78:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	JMP  _memcpy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x79:
	ADIW R26,5
	LD   R30,X
	ADD  R30,R20
	ST   X,R30
	MOVW R30,R20
	LSL  R30
	ROL  R31
	MOV  R31,R30
	LDI  R30,0
	MOVW R18,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7A:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+27
	LDD  R31,Y+27+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x7B:
	__GETD2Z 22
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	CALL _disk_write
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7C:
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xBF
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7D:
	ADIW R26,6
	CALL __GETW1P
	ANDI R31,HIGH(0x1FF)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7E:
	MOVW R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7F:
	ADIW R30,6
	MOVW R0,R30
	MOVW R26,R30
	CALL __GETD1P
	MOVW R26,R30
	MOVW R24,R22
	MOVW R30,R18
	RJMP SUBOPT_0x4E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x80:
	LD   R30,X+
	LD   R31,X+
	ADD  R30,R18
	ADC  R31,R19
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x81:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x82:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x83:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,10
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x84:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x85:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x86:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x87:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R30,Z+5
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x88:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 22
	RJMP SUBOPT_0x15


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
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

__LEW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BRGE __LEW12T
	CLR  R30
__LEW12T:
	RET

__GEW12:
	CP   R26,R30
	CPC  R27,R31
	LDI  R30,1
	BRGE __GEW12T
	CLR  R30
__GEW12T:
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

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
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
	OUT  RAMPZ,R22
__INITLOC0:
	ELPM R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
