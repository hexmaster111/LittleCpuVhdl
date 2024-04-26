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
    [*] --> fjdksl
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
        [*] --> a 
    }

    state XOR {
        [*] --> m
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
    [*] --> fjdkslfds
}

```