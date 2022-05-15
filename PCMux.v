module PCMux(
  input [3:0] nextPC,
  input [3:0] branchPC,
  input Jump,
  output reg [3:0] nextnextPC);

  always @(nextPC, branchPC, Jump, nextnextPC) begin
    if (Jump == 0)
      nextnextPC = nextPC;
    else
      nextnextPC = branchPC;
  end
endmodule