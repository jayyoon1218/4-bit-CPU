module DataMemMux(
  input [3:0] readData,
  input [3:0] aluResult,
  input MemtoReg,
  output reg [3:0] out);

  always @(readData, aluResult, MemtoReg, out) begin
    if (MemtoReg == 0)
      out = aluResult;
    else
      out = readData;
  end
endmodule