module Data_Memory(
  input [3:0] address,
  input [3:0] writeData,
  input MemRead,
  input MemWrite,
  output reg [3:0] readData);

  reg [3:0] Data[15:0];

  initial begin
    Data[0] = 4'b0000;
    Data[1] = 4'b0001;
    Data[2] = 4'b0010;
    Data[3] = 4'b0000;
    Data[4] = 4'b0000;
  end

  always @(address, writeData, MemRead, MemWrite) begin
    if (MemWrite == 1)
        Data[address] = writeData;
    if (MemRead == 1)
        readData = Data[address];
  end
endmodule