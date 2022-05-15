module RegisterMux(
  input [1:0] input1,
  input [1:0] input2,
  input Reg2Loc,
  output reg [1:0] out);

  always @(input1, input2, Reg2Loc) begin

    if (Reg2Loc == 0)
      out = input1;
    else
      out = input2;
  end
endmodule