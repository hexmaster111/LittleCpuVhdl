## WIP little cpu based off of [slides im getting the understanding for this from](https://www.slideshare.net/n380/elementary-processor-tutorial)

## [Good stuff ive been reading too](https://inst.eecs.berkeley.edu/~cs150/sp12/resources/FSM.pdf)




- 16 bit instructions
- instructions have opcode in top 8 and address in the bottem 8

| INST | VAL | DESC                          |
| ---- | --- | ----------------------------- |
| ADD  | h1  | `ACC <- ACC + MEM[ADDR]`      |
| XOR  | h2  | `ACC <- ACC XOR MEM[ADDR]`    |
| STO  | h3  | `MEM[ADDR] <- ACC`            |
| LOD  | h4  | `ACC <- MEM[ADDR]`            |
| JMP  | h5  | `PC <- ADDR`                  |
| JMZ  | h6  | `IF ACC == 0 THEN PC <- ADDR` |


``` mermaid
stateDiagram-v2

[*] --> FETCH
FETCH --> EXE
EXE --> INC
INC --> FETCH

state FETCH {
    F0 : MX_PC_IRD to IRD 
    F1 : LD MAR
    F2 : LD MDR
    F3 : LD IR
    
    [*] --> F0
    F1 --> F2
    F3 --> [*]
}

state EXE {
    [*] --> ADD
    [*] --> XOR
    [*] --> STO
    [*] --> LOD
    [*] --> JMP
    [*] --> JMZ

    ADD --> [*]
    XOR --> [*]
    STO --> [*]
    LOD --> [*]
    JMP --> [*]
    JMZ --> [*]

    state ADD {
        A0 : MX_PC_IDR to IDR
        A1 : LD MAR
        A2 : LD MDR && ALU ADD
        A3 : MX_IRD_ALUR to ALUR
        A4 : LD ACCM
        [*] --> A0
        A0 --> A1
        A1 --> A2
        A2 --> A3
        A3 --> A4
        A4 --> [*]
    }

    state XOR {
        X0 : MX_PC_IDR to IDR
        X1 : LD MAR
        X2 : LD MDR && ALU XOR
        X3 : MX_IRD_ALUR to ALUR
        X4 : LD ACCM
        [*] --> X0
        X0 --> X1
        X1 --> X2
        X2 --> X3
        X3 --> X4
        X4 --> [*]
    }

    state STO {
        [*] --> e
    }

    state LOD {
        [*] --> s
    }

    state JMP {
        [*] --> af
    }

    state JMZ {
        [*] --> x
    }
}

state INC {
    I0 : MX_IR_P1 to P1 
    I1 : PC_LD
    [*] --> I0
    I0 --> I1
    I1 --> [*]
}

```