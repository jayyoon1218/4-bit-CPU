module Registers(
  input [1:0] numRx,
  input [1:0] numRy,
  input [1:0] numRz,
  input [3:0] Rz,
  input RegWrite,
  output reg [3:0] Rx,
  output reg [3:0] Ry);

  reg [3:0] Data[3:0];

  always @(numRx, numRy, numRz, Rz, RegWrite) begin

    Rx = Data[numRx];
    Ry = Data[numRy];

    if (RegWrite == 1) begin
      Data[numRz] = Rz;
    end
  end
endmodule