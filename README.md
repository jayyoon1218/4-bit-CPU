# ECE 251 Computer Architecture Final Project 
## By Jeongwoo Yoon & Jinwook Lee

Our final project is a 4-bit CPU simulated using Verilog. It takes 16-bit instructions and performs calculations on 4-bit data. To do this, it executes R-type, I-type and J-type instructions that we determined to be essential; these operations are outlined in our Instruction Set Architecture. The instructions are brought from the instruction memory, and the corresponding data are loaded into the CPU’s registers. Then, the output of the CPU is stored back in the data memory.

## Instruction Set Architecture
The 16-bit instructions are written using 4-bit Opcodes, 2-bit Rx, Ry and Rz register numbers, and 4-bit immediate (or address) values. The rest of the instruction fields are left as ‘Don’t care’ fields. The instructions are formatted so that all instruction types have the 4-bit Opcodes at the most significant 4 bits. Meanwhile, the register numbers Rx, Ry, and Rz (the ‘address’ of each register, which stores a 4-bit data) are all placed at the least significant 6 bits. The meaning of these Rx, Ry, and Rz values depend on the instruction type, and are outlined in the ISA below. Lastly, immediate or address values (constants) are written in the middle bits of the instructions.
![alt text](https://github.com/jayyoon1218/4-bit-CPU/blob/d9bb15bd704f7525baf03f909cccb646c930adf5/Images/ISA.png)

## Instruction Memory and Program Counter
We decided to separate the instruction memory and data memory into separate modules to simplify the process of sending our instructions into the control unit. The instruction memory stores our assembled instructions. Because each instruction is 16-bits, each block in the memory is 16-bits wide. Meanwhile, the program counter is a 4-bit value that increments by 1 to go to the next instruction; therefore, there are a maximum of 16 blocks available in this memory. The instruction memory is 256 bits in total. Within the instruction memory module, each block is referred to as data[block number] - where the block number acts as the address of the instruction.
Without branching instructions, the PC increments by 1. When  an unconditional or conditional branch instruction is executed, the immediate value in the B or BZ instruction is added directly into the current PC value, and the subsequent instruction comes next in line. (For clarification in the code of the PCMux module: the input of the PCMux is either nextPC or the branchPC, and the output of the PCMux becomes the nextnextPC.)

## Registers
As mentioned above, the 2-bit Rx, Ry and Rz values in the instruction point to the register number in the register module. Therefore, there are a total of 4 registers to load operands and write the ALU output into.

## Data Memory
The data memory stores the initial and output data values of the program being executed. Because we are designing a 4-bit CPU, each block in this memory is 4-bits wide and the address of the data blocks are 4-bits wide as well. Therefore, there can be a maximum of 16 blocks available in this memory. The data memory is 64 bits in total. Within the instruction memory module, each block is similarly referred to as data[block number], where the block number is a 4-bit address of the data.

## Controller
The function of the controller is to switch specific mux switches depending on the instruction type. We kept the following control bits for the functions listed below. (Note the absence of ALUOP.) We wrote our control code into the CPU module itself, instead of creating a separate control module to reduce input and output clutter. Within the CPU module, the control bits were determined on the Opcode on a case-by-case basis. This process eliminated the need of a main decoder. Furthermore, the 4-bit Opcode from the instruction was also used to directly dictate the operation to be performed in the ALU; therefore, the ALUController value took on the Opcode value and we did not need a separate ALU decoder as well.
![alt text](https://github.com/jayyoon1218/4-bit-CPU/blob/d9bb15bd704f7525baf03f909cccb646c930adf5/Images/ControlBits.png)

## Datapath
The datapath of our CPU is a modified variation of the implementation in Chapter 4 of Computer Organization and Design, ARM edition. Refer to the block diagram for the R, I and J-type instructions.
#### R-type Instruction Datapath
![alt text](https://github.com/jayyoon1218/4-bit-CPU/blob/d9bb15bd704f7525baf03f909cccb646c930adf5/Images/R%20Block%20Diagram.png)
#### I-type Instruction (ADDI) Datapath
![alt text](https://github.com/jayyoon1218/4-bit-CPU/blob/d9bb15bd704f7525baf03f909cccb646c930adf5/Images/ADDI%20Block%20Diagram.png)
#### R-type Instruction (BZ) Datapath
![alt text](https://github.com/jayyoon1218/4-bit-CPU/blob/d9bb15bd704f7525baf03f909cccb646c930adf5/Images/BZ%20Block%20Diagram.png)
