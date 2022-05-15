`include "ALU.v"
`include "ALUMux.v"
`include "DataMemMux.v"
`include "PCMux.v"
`include "RegisterMux.v"

module CPU(
  input clock,
  input [15:0] Instruction,
  input [3:0] Rx,
  input [3:0] Ry,
  input [3:0] readData,
  output reg Reg2Loc,
  output reg RegWrite,
  output reg MemRead,
  output reg MemWrite,
  output reg Branch,
  output reg [1:0] numRx,
  output [1:0] numRy,
  output reg [1:0] numRz,
  output [3:0] aluResult,
  output [3:0] Rz,
  output reg [3:0] PC);

  reg [1:0] tempRx;
  reg [1:0] tempRy;
  reg [3:0] Opcode;

  reg MemtoReg;
  reg ALUSrc;
  reg Uncondbranch;

  wire tempZero;
  reg [3:0] aluOpcode;
  wire [3:0] tempALUInput2;
  wire [3:0] tempImmediate;

  wire [3:0] nextnextPC;
  reg Jump;
  wire [3:0] nextPC;
  wire nextPCZero;
  wire [3:0] branchPC;
  wire branchPCZero;
  reg tempBranch;

  PCMux mux1(nextPC, branchPC, Jump, nextnextPC); 

  RegisterMux mux2(tempRx, tempRy, Reg2Loc, numRy);

  ALUMux mux3(Ry, tempImmediate, ALUSrc, tempALUInput2);

  DataMemMux mux4(readData, aluResult, MemtoReg, Rz);

  ALU alu(Rx, Ry, aluOpcode, aluResult, tempZero);

  ALU adderNextPC(PC, 4'b0001, 4'b0010, nextPC, nextPCZero);

  ALU adderShiftPC(PC, tempImmediate, 4'b0010, branchPC, branchPCZero); 
  initial begin
    PC = 0;
    Reg2Loc = 1'bz;
    MemtoReg = 1'bz;
    RegWrite = 1'bz;
    MemRead = 1'bz;
    MemWrite = 1'bz;
    ALUSrc = 1'bz;
    Branch = 1'b0;
    Uncondbranch = 1'b0;
    tempBranch = tempZero & Branch;
    Jump = Uncondbranch | tempBranch;
  end

  always @(posedge clock or Instruction) begin

    if (Jump == 1'b1)
      PC <= #1 nextnextPC;

    Opcode = Instruction[15:12];
    tempRx = Instruction[1:0];
    tempRy = Instruction[5:4];
    numRx = Instruction[3:2];
    numRz = Instruction[5:4];

    //J-type
    if (Opcode == 4'b1010) begin // Opcode for B
      Reg2Loc = 1'b0;
      MemtoReg = 1'b0;
      RegWrite = 1'b0;
      MemRead = 1'b0;
      MemWrite = 1'b0;
      ALUSrc = 1'b0;
      Branch = 1'b0;
      Uncondbranch = 1'b1;
      end 
    else if (Opcode == 4'b1011) begin // Opcode for BZ
      Reg2Loc = 1'b1;
      MemtoReg = 1'b0;
      RegWrite = 1'b0;
      MemRead = 1'b0;
      MemWrite = 1'b0;
      ALUSrc = 1'b0;
      Branch = 1'b1;
      Uncondbranch = 1'b0;
      end

    //I-type
    else if (Opcode == 4'b0111) begin // Opcode for ADDI
      aluOpcode = 4'b0010;
      Reg2Loc = 1'bx;
      MemtoReg = 1'b0;
      RegWrite = 1'b1;
      MemRead = 1'b0;
      MemWrite = 1'b0;
      ALUSrc = 1'b1;
      Branch = 1'b0;
      Uncondbranch = 1'b0;
      end
    else if (Opcode == 4'b1000) begin // Opcode for STUR
      aluOpcode <= 4'b0010;
      Reg2Loc = 1'b1;
      MemtoReg = 1'bx;
      RegWrite = 1'b0;
      MemRead = 1'b0;
      MemWrite = 1'b1;
      ALUSrc = 1'b1;
      Branch = 1'b0;
      Uncondbranch = 1'b0;
      end
    else if (Opcode == 4'b1000) begin // Opcode for LDUR
      aluOpcode <= 4'b0010;
      Reg2Loc = 1'bx;
      MemtoReg = 1'b1;
      RegWrite = 1'b1;
      MemRead = 1'b1;
      MemWrite = 1'b0;
      ALUSrc = 1'b1;
      Branch = 1'b1;
      Uncondbranch = 1'b0;
      end

    //R-type
    else begin
      aluOpcode <= Opcode;
      Branch = 1'b0;
      Uncondbranch = 1'b0;
      Reg2Loc = 1'b0;
      MemtoReg = 1'b0;
      RegWrite = 1'b1;
      MemRead = 1'b0;
      MemWrite = 1'b0;
      ALUSrc = 1'b0;
      end

    tempBranch = tempZero & Branch;
    Jump = Uncondbranch | tempBranch;

    if (Jump == 1'b0)
    	PC <= #1 nextnextPC;
  end
endmodule