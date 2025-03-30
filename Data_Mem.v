module Data_Mem(A, WD, clk, rst, WE, RD);
 
  input [31:0] A,WD,WE;
  input clk, rst;

  output [31:0] RD;
  
  reg [31:0] Data_MEM [1023:0];

  // read
  assign RD = (WE==1'b0) ? Data_MEM[A] : 32'h00000000;
 
  // write
  always @(posedge clk)
  begin

    if(WE)
    begin
        Data_MEM[A] <= WD;
    end



  end

  initial begin

    Data_MEM[28] = 32'h00000020;

  end


endmodule