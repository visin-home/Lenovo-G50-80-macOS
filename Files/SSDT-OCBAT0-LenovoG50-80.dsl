/*
Method:
_SB.PCI0.LPCB.EC0.BAT0._BIF
_SB.PCI0.LPCB.EC0.BAT0._BST
_SB.PCI0.LPCB.EC0.VPC0.MHPF
_SB.PCI0.LPCB.EC0.VPC0.MHIF
_SB.PCI0.LPCB.EC0.VPC0.GBID
_SB.PCI0.LPCB.EC0.VPC0.SMTF

Comment      change _BIF to XBIF
Find         5F424946 00
Replace      58424946 00

Comment      change _BST to XBST
Find         5F425354 08
Replace      58425354 08

Comment      change MHPF to XHPF
Find         4D485046 01
Replace      58485046 01

Comment      change MHIF to XHIF
Find         4D484946 01
Replace      58484946 01

Comment      change GBID to XBID
Find         47424944 08
Replace      58424944 08

Comment      change SMTF to XMTF
Find         534D5446 01
Replace      584D5446 01

*/

DefinitionBlock ("", "SSDT", 2, "ACDT", "BATT", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC0, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0.VPC0, DeviceObj)
    External (ECON, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.B1ST, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.SMPR, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.SMST, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.SMAD, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.SMCM, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BCNT, FieldUnitObj)
    External (P80H, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.FUSL, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.FUSH, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.B1CT, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.PBIF, PkgObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.PBST, PkgObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.OBST, IntObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.OBAC, IntObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.OBPR, IntObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.OBRC, IntObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.OBPV, IntObj)
    External (_SB_.PCI0.LPCB.EC0.VPC0.VBFC, IntObj)
    External (_SB_.PCI0.LPCB.EC0.VPC0.VBRC, IntObj)
    External (_SB_.PCI0.LPCB.EC0.VPC0.VBPV, IntObj)
    External (_SB_.PCI0.LPCB.EC0.VPC0.VBAC, IntObj)
    External (_SB_.PCI0.LPCB.EC0.VPC0.VBCT, IntObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.XBIF, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.BAT0.XBST, MethodObj)
    External (_SB.PCI0.LPCB.EC0.VPC0.XHPF, MethodObj)
    External (_SB.PCI0.LPCB.EC0.VPC0.XHIF, MethodObj)
    External (_SB.PCI0.LPCB.EC0.VPC0.XBID, MethodObj)
    External (_SB.PCI0.LPCB.EC0.VPC0.XMTF, MethodObj)

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }
    
    Method (RE1B, 1, NotSerialized)
    {
        OperationRegion (ERM2, EmbeddedControl, Arg0, One)
        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            BYTE,   8
        }

        Return (BYTE) /* \RE1B.BYTE */
    }

    Method (RECB, 2, Serialized)
    {
        Arg1 = ((Arg1 + 0x07) >> 0x03)
        Name (TEMP, Buffer (Arg1){})
        Arg1 += Arg0
        Local0 = Zero
        While ((Arg0 < Arg1))
        {
            TEMP [Local0] = RE1B (Arg0)
            Arg0++
            Local0++
        }

        Return (TEMP) /* \RECB.TEMP */
    }

    Method (WE1B, 2, NotSerialized)
    {
        OperationRegion (ERM2, EmbeddedControl, Arg0, One)
        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            BYTE,   8
        }

        BYTE = Arg1
    }

    Method (WECB, 3, Serialized)
    {
        Arg1 = ((Arg1 + 0x07) >> 0x03)
        Name (TEMP, Buffer (Arg1){})
        TEMP = Arg2
        Arg1 += Arg0
        Local0 = Zero
        While ((Arg0 < Arg1))
        {
            WE1B (Arg0, DerefOf (TEMP [Local0]))
            Arg0++
            Local0++
        }
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {        
        OperationRegion (XRAM, EmbeddedControl, Zero, 0xFF)
        Field (XRAM, ByteAcc, Lock, Preserve)
        {
            //Offset (0x14), 
            //FWBT,   64,     
            //Offset (0x64), 
            //SMDA,   256, 
            Offset (0xC2), 
            BRC0,   8,
            BRC1,   8,
            //B1RC,   16,     //0xC4
            Offset (0xC6),
            BFV0,   8,
            BFV1,   8,
            BDV0,   8,
            BDV1,   8,
            BDC0,   8,
            BDC1,   8,
            BFC0,   8,
            BFC1,   8,
            //B1FV,   16,     //0xC8
            //B1DV,   16,     //0xCA
            //B1DC,   16,     //0xCC
            //B1FC,   16,     //0xCE
            Offset (0xD2),
            BAC0,   8,
            BAC1,   8,
            //B1AC,   16,     //0xD4
        }
    }
        
    Scope (_SB.PCI0.LPCB.EC0.BAT0)
    {
        Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
        {
            If (_OSI ("Darwin"))
            {
                If ((ECON == One))
                {
                    Local0 = B1B2 (BDC0, BDC1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BDC0, BDC1) */
                    Local0 *= 0x0A
                    PBIF [One] = Local0
                    Local0 = B1B2 (BFC0, BFC1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BFC0, BFC1) */
                    Local0 *= 0x0A
                    PBIF [0x02] = Local0
                    PBIF [0x04] = B1B2 (BDV0, BDV1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BDV0, BDV1) */
                    PBIF [0x09] = ""
                    PBIF [0x0B] = ""
                }

                Return (PBIF) /* \_SB_.PCI0.LPCB.EC0_.BAT0.PBIF */
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.BAT0.XBIF())
            }
        }
        
        Method (_BST, 0, Serialized)  // _BST: Battery Status
        {
            If (_OSI ("Darwin"))
            {
                If ((ECON == One))
                {
                    Sleep (0x10)
                    Local0 = B1ST /* \_SB_.PCI0.LPCB.EC0_.B1ST */
                    Local1 = DerefOf (PBST [Zero])
                    Switch ((Local0 & 0x07))
                    {
                        Case (Zero)
                        {
                            OBST = (Local1 & 0xF8)
                        }
                        Case (One)
                        {
                            OBST = (One | (Local1 & 0xF8))
                        }
                        Case (0x02)
                        {
                            OBST = (0x02 | (Local1 & 0xF8))
                        }
                        Case (0x04)
                        {
                            OBST = (0x04 | (Local1 & 0xF8))
                        }

                    }

                    Sleep (0x10)
                    OBAC = B1B2 (BAC0, BAC1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BAC0, BAC1) */
                    If ((OBST & One))
                    {
                        If ((OBAC != Zero))
                        {
                            OBAC = (~OBAC & 0x7FFF)
                        }
                    }

                    OBPR = OBAC /* \_SB_.PCI0.LPCB.EC0_.BAT0.OBAC */
                    Sleep (0x10)
                    OBRC = B1B2 (BRC0, BRC1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BRC0, BRC1) */
                    Sleep (0x10)
                    OBPV = B1B2 (BFV0, BFV1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BFV0, BFV1) */
                    OBRC *= 0x0A
                    OBPR = ((OBAC * OBPV) / 0x03E8)
                    PBST [Zero] = OBST /* \_SB_.PCI0.LPCB.EC0_.BAT0.OBST */
                    PBST [One] = OBPR /* \_SB_.PCI0.LPCB.EC0_.BAT0.OBPR */
                    PBST [0x02] = OBRC /* \_SB_.PCI0.LPCB.EC0_.BAT0.OBRC */
                    PBST [0x03] = OBPV /* \_SB_.PCI0.LPCB.EC0_.BAT0.OBPV */
                }

                Return (PBST) /* \_SB_.PCI0.LPCB.EC0_.BAT0.PBST */
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.BAT0.XBST())
            }
        }
    }
    
    Scope (_SB.PCI0.LPCB.EC0.VPC0)
    {
        Method (MHPF, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Name (BFWB, Buffer (0x25){})
                CreateByteField (BFWB, Zero, FB0)
                CreateByteField (BFWB, One, FB1)
                CreateByteField (BFWB, 0x02, FB2)
                CreateByteField (BFWB, 0x03, FB3)
                CreateField (BFWB, 0x20, 0x0100, FB4)
                CreateByteField (BFWB, 0x24, FB5)
                If ((SizeOf (Arg0) <= 0x25))
                {
                    If ((SMPR != Zero))
                    {
                        FB1 = SMST /* \_SB_.PCI0.LPCB.EC0_.SMST */
                    }
                    Else
                    {
                        BFWB = Arg0
                        SMAD = FB2 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.FB2_ */
                        SMCM = FB3 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.FB3_ */
                        BCNT = FB5 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.FB5_ */
                        Local0 = FB0 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.FB0_ */
                        If (((Local0 & One) == Zero))
                        {
                            WECB (0x64, 0x0100, FB4) /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.WECB (0x64, 0x0100, FB4) */
                        }

                        SMST = Zero
                        SMPR = FB0 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.FB0_ */
                        Local1 = 0x03E8
                        While (Local1)
                        {
                            Sleep (One)
                            Local1--
                            If (((SMST && 0x80) || (SMPR == Zero)))
                            {
                                Break
                            }
                        }

                        Local0 = FB0 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.FB0_ */
                        If (((Local0 & One) != Zero))
                        {
                            FB4 = RECB (0x64, 0x0100) /* \_SB_.PCI0.LPCB.EC0_.RECB (0x64, 0x0100) */
                        }

                        FB1 = SMST /* \_SB_.PCI0.LPCB.EC0_.SMST */
                        If (((Local1 == Zero) || !(SMST && 0x80)))
                        {
                            SMPR = Zero
                            FB1 = 0x92
                        }
                    }

                    Return (BFWB) /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHPF.BFWB */
                }
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.VPC0.XHPF(Arg0))
            }
        }

        Method (MHIF, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                P80H = 0x50
                If ((Arg0 == Zero))
                {
                    Name (RETB, Buffer (0x0A){})
                    Name (BUF1, Buffer (0x08){})
                    BUF1 = RECB (0x14, 0x40) /* \_SB_.PCI0.LPCB.EC0_.RECB (0x14, 0x40) */
                    CreateByteField (BUF1, Zero, FW0)
                    CreateByteField (BUF1, One, FW1)
                    CreateByteField (BUF1, 0x02, FW2)
                    CreateByteField (BUF1, 0x03, FW3)
                    CreateByteField (BUF1, 0x04, FW4)
                    CreateByteField (BUF1, 0x05, FW5)
                    CreateByteField (BUF1, 0x06, FW6)
                    CreateByteField (BUF1, 0x07, FW7)
                    RETB [Zero] = FUSL /* \_SB_.PCI0.LPCB.EC0_.FUSL */
                    RETB [One] = FUSH /* \_SB_.PCI0.LPCB.EC0_.FUSH */
                    RETB [0x02] = FW0 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW0_ */
                    RETB [0x03] = FW1 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW1_ */
                    RETB [0x04] = FW2 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW2_ */
                    RETB [0x05] = FW3 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW3_ */
                    RETB [0x06] = FW4 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW4_ */
                    RETB [0x07] = FW5 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW5_ */
                    RETB [0x08] = FW6 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW6_ */
                    RETB [0x09] = FW7 /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.FW7_ */
                    Return (RETB) /* \_SB_.PCI0.LPCB.EC0_.VPC0.MHIF.RETB */
                }
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.VPC0.XHIF(Arg0))
            }
        }
        
        Method (GBID, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Name (GBUF, Package (0x04)
                {
                    Buffer (0x02)
                    {
                        0x00, 0x00                                       // ..
                    }, 

                    Buffer (0x02)
                    {
                        0x00, 0x00                                       // ..
                    }, 
    
                    Buffer (0x08)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                    }, 

                    Buffer (0x08)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                    }
                })
                DerefOf (GBUF [Zero]) [Zero] = B1CT /* \_SB_.PCI0.LPCB.EC0_.B1CT */
                DerefOf (GBUF [One]) [Zero] = Zero
                Name (BUF1, Buffer (0x08){})
                BUF1 = RECB (0x14, 0x40) /* \_SB_.PCI0.LPCB.EC0_.RECB (0x14, 0x40) */
                CreateByteField (BUF1, Zero, FW0)
                CreateByteField (BUF1, One, FW1)
                CreateByteField (BUF1, 0x02, FW2)
                CreateByteField (BUF1, 0x03, FW3)
                CreateByteField (BUF1, 0x04, FW4)
                CreateByteField (BUF1, 0x05, FW5)
                CreateByteField (BUF1, 0x06, FW6)
                CreateByteField (BUF1, 0x07, FW7)
                DerefOf (GBUF [0x02]) [Zero] = FW0 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW0_ */
                DerefOf (GBUF [0x02]) [One] = FW1 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW1_ */
                DerefOf (GBUF [0x02]) [0x02] = FW2 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW2_ */
                DerefOf (GBUF [0x02]) [0x03] = FW3 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW3_ */
                DerefOf (GBUF [0x02]) [0x04] = FW4 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW4_ */
                DerefOf (GBUF [0x02]) [0x05] = FW5 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW5_ */
                DerefOf (GBUF [0x02]) [0x06] = FW6 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW6_ */
                DerefOf (GBUF [0x02]) [0x07] = FW7 /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.FW7_ */
                DerefOf (GBUF [0x03]) [Zero] = Zero
                Return (GBUF) /* \_SB_.PCI0.LPCB.EC0_.VPC0.GBID.GBUF */
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.VPC0.XBID())
            }
        }
        
        Method (SMTF, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If ((Arg0 == Zero))
                {
                    If ((B1B2 (BFV0, BFV1) == Zero))
                    {
                        Return (Zero)
                    }
    
                    If ((B1B2 (BAC0, BAC1) == Zero))
                    {
                        Return (Zero)
                    }

                    Local0 = B1B2 (BFC0, BFC1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BFC0, BFC1) */
                    Local0 *= 0x0A
                    VBFC = Local0
                    Local1 = B1B2 (BRC0, BRC1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BRC0, BRC1) */
                    Local1 *= 0x0A
                    VBRC = Local1
                    If ((VBFC > VBRC))
                    {
                        VBPV = B1B2 (BFV0, BFV1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BFV0, BFV1) */
                        VBAC = B1B2 (BAC0, BAC1) /* \_SB_.PCI0.LPCB.EC0_.B1B2 (BAC0, BAC1) */
                        Local0 -= Local1
                        Local1 = (VBAC * VBPV)
                        Local3 = (Local0 * 0x03E8)
                        Local3 = (Local3 * 0x3C)
                        VBCT = (Local3 / Local1)
                        Return (VBCT) /* \_SB_.PCI0.LPCB.EC0_.VPC0.VBCT */
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                If ((Arg0 == One))
                {
                    Return (Zero)
                }

                Return (Zero)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.VPC0.XMTF(Arg0))
            }
        }
    }
}

