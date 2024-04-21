[slides im getting the understanding for this from](https://www.slideshare.net/n380/elementary-processor-tutorial)



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