module Instruction_Memory(
  input [3:0] PC,
  output reg [15:0] Instruction);

  reg [15:0] Data[15:0];

  always @(PC) begin
    Instruction[15:0] = Data[PC];
  end
endmodule