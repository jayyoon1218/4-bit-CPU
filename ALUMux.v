module ALUMux(
  input [3:0] input1,
  input [3:0] input2,
  input ALUSrc,
  output reg [3:0] out);

  always @(input1, input2, ALUSrc, out) begin

    if (ALUSrc == 0) begin
      out = input1;
    end

    else begin
      out = input2;
    end
  end
endmodule