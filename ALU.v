module ALU(
  input [3:0] A,
  input [3:0] B,
  input [3:0] aluOpcode,
  output reg [3:0] aluResult,
  output reg Zero);

  always @(A or B or aluOpcode) begin
    case (aluOpcode)
      4'b0000 : aluResult = A & B;
      4'b0001 : aluResult = A | B;
      4'b0010 : aluResult = A + B;
      4'b0011 : aluResult = A * B;
      4'b0100 : aluResult = A / B;
      4'b0101 : aluResult = A - B;
      4'b0110 : aluResult = ~(A | B);
    endcase

    if (aluResult == 0)
      Zero = 1'b1;
    else
      Zero = 1'b0;
  end
endmodule
